unit EditBone.FindInFiles;

interface

uses
  System.Classes, System.Types;

type
  TOnCancelSearch = function: Boolean of object;
  TOnAddTreeViewLine = procedure(Sender: TObject; Filename: WideString; Ln, Ch: LongInt; Text: WideString;
    SearchString: WideString) of object;

  TFindInFilesThread = class(TThread)
  private
    FCount: Integer;
    FOnCancelSearch: TOnCancelSearch;
    FOnProgressBarStep: TNotifyEvent;
    FOnAddTreeViewLine: TOnAddTreeViewLine;
    FFindWhatOriginalText, FFindWhatSearchText: string;
    FFileExtensions: string;
    FFileTypeText: string;
    FFolderText: string;
    FSearchCaseSensitive: Boolean;
    FLookInSubfolders: Boolean;
    function GetFiles(const Path, Masks: string): TStringDynArray;
    function GetStringList(AFilename: string): TStringList;
    procedure FindInFiles(AFolderText: String);
  public
    constructor Create(AFindWhatText, AFileTypeText, AFolderText: String;
      ASearchCaseSensitive, ALookInSubfolders: Boolean; AFileExtensions: string); overload;
    procedure Execute; override;
    property Count: Integer read FCount;
    property FindWhatText: string read FFindWhatOriginalText;
    property OnCancelSearch: TOnCancelSearch read FOnCancelSearch write FOnCancelSearch;
    property OnProgressBarStep: TNotifyEvent read FOnProgressBarStep write FOnProgressBarStep;
    property OnAddTreeViewLine: TOnAddTreeViewLine read FOnAddTreeViewLine write FOnAddTreeViewLine;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, BCControls.Utils, BCCommon.Language.Strings, Vcl.Forms, System.Masks,
  BCEditor.Encoding, BCEditor.Editor.Utils, EditBone.Consts, System.IOUtils, System.StrUtils;

procedure TFindInFilesThread.Execute;
begin
  Synchronize(
    procedure
    begin
      FindInFiles(FFolderText)
    end);
end;

constructor TFindInFilesThread.Create(AFindWhatText, AFileTypeText, AFolderText: String;
  ASearchCaseSensitive, ALookInSubfolders: Boolean; AFileExtensions: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FFindWhatOriginalText := AFindWhatText;
  if ASearchCaseSensitive then
    FFindWhatSearchText := AFindWhatText
  else
    FFindWhatSearchText := UpperCase(AFindWhatText);
  FFileExtensions := AFileExtensions;
  FFileTypeText := AFileTypeText;
  FFolderText := AFolderText;
  FSearchCaseSensitive := ASearchCaseSensitive;
  FLookInSubfolders := ALookInSubfolders;
  FCount := 0;
end;

function TFindInFilesThread.GetFiles(const Path, Masks: string): TStringDynArray;
var
  MaskArray: TStringDynArray;
  Predicate: TDirectory.TFilterPredicate;
  LSearchOption: TSearchOption;
begin
  if FLookInSubfolders then
    LSearchOption := System.IOUtils.TSearchOption.soAllDirectories
  else
    LSearchOption := System.IOUtils.TSearchOption.soTopDirectoryOnly;

  MaskArray := SplitString(Masks, ';');
  Predicate := function(const Path: string; const SearchRec: TSearchRec): Boolean
    var
      Mask: string;
    begin
      for Mask in MaskArray do
        if MatchesMask(SearchRec.Name, Mask) then
          Exit(True);
      Exit(False);
    end;
  Result := TDirectory.GetFiles(Path, LSearchOption, Predicate);
end;

{ Recursive method to find files. }
procedure TFindInFilesThread.FindInFiles(AFolderText: String);
var
  LTextLine: string;
  FName: string;
  i: Integer;
  LStringList: TStringList;
  LTextPtr, LStartTextPtr, LFindWhatTextPtr, LBookmarkTextPtr: PChar;
begin
  for FName in Self.GetFiles(AFolderText, FFileTypeText) do
    if (FFileTypeText = '*.*') and IsExtInFileType(ExtractFileExt(FName), FFileExtensions) or
      IsExtInFileType(ExtractFileExt(FName), FFileTypeText) then
    begin
      if Assigned(FOnProgressBarStep) then
        FOnProgressBarStep(Self);
{$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
      LStringList := GetStringList(FName);
{$WARNINGS ON}
      try
        try
          if Trim(LStringList.Text) <> '' then
            for i := 0 to LStringList.Count - 1 do
            begin
              LTextLine := LStringList.Strings[i];
              if not FSearchCaseSensitive then
                LTextLine := UpperCase(LTextLine);
              LStartTextPtr := PChar(LTextLine);
              LTextPtr := LStartTextPtr;
              while LTextPtr^ <> EDITBONE_NONE_CHAR do
              begin
                if LTextPtr^ = PChar(FFindWhatSearchText)^ then { if the first character is a match }
                begin
                  LFindWhatTextPtr := PChar(FFindWhatSearchText);
                  LBookmarkTextPtr := LTextPtr;
                  { check if the keyword found }
                  while (LTextPtr^ <> EDITBONE_NONE_CHAR) and (LFindWhatTextPtr^ <> EDITBONE_NONE_CHAR) and
                    (LTextPtr^ = LFindWhatTextPtr^) do
                  begin
                    Inc(LTextPtr);
                    Inc(LFindWhatTextPtr);
                  end;
                  if LFindWhatTextPtr^ = EDITBONE_NONE_CHAR then
                  begin
                    Inc(FCount);
                    if Assigned(FOnCancelSearch) and FOnCancelSearch then
                    begin
                      Terminate;
                      Exit;
                    end;
{$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
                    if Assigned(FOnAddTreeViewLine) then
                      FOnAddTreeViewLine(Self, FName, i, LBookmarkTextPtr - LStartTextPtr + 1, LStringList.Strings[i],
                        FFindWhatOriginalText);
{$WARNINGS ON}
                  end
                  else
                    LTextPtr := LBookmarkTextPtr; { not found, return pointer back }
                end;
                Inc(LTextPtr);
              end;
            end
        except
{$WARNINGS OFF}
          { IncludeTrailingBackslash is specific to a platform }
          if Assigned(FOnAddTreeViewLine) then
            FOnAddTreeViewLine(Self, '', -1, 0, Format(LanguageDataModule.GetWarningMessage('FileAccessError'),
              [FName]), '');
{$WARNINGS ON}
        end;
      finally
        LStringList.Free;
      end;
    end;
end;

function TFindInFilesThread.GetStringList(AFilename: string): TStringList;
var
  LFileStream: TFileStream;
  LBuffer: TBytes;
  WithBom: Boolean;
  LEncoding: System.SysUtils.TEncoding;
begin
  Result := TStringList.Create;
  LEncoding := nil;
  LFileStream := TFileStream.Create(AFilename, fmOpenRead);
  try
    // Identify encoding
    if IsUTF8(LFileStream, WithBom) then
    begin
      if WithBom then
        LEncoding := TEncoding.UTF8
      else
        LEncoding := BCEditor.Encoding.TEncoding.UTF8WithoutBOM;
    end
    else
    begin
      // Read file into buffer
      SetLength(LBuffer, LFileStream.Size);
      LFileStream.ReadBuffer(Pointer(LBuffer)^, Length(LBuffer));
      TEncoding.GetBufferEncoding(LBuffer, LEncoding);
    end;
  finally
    LFileStream.Free;
  end;
  Result.LoadFromFile(AFilename, LEncoding);
end;

end.
