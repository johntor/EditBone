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
    function GetStringList(const AFilename: string): TStringList;
    procedure FindInFiles(const AFolderText: string);
  public
    constructor Create(const AFindWhatText, AFileTypeText, AFolderText: string;
      ASearchCaseSensitive, ALookInSubfolders: Boolean; const AFileExtensions: string); overload;
    procedure Execute; override;
    property Count: Integer read FCount;
    property FindWhatText: string read FFindWhatOriginalText;
    property OnCancelSearch: TOnCancelSearch read FOnCancelSearch write FOnCancelSearch;
    property OnProgressBarStep: TNotifyEvent read FOnProgressBarStep write FOnProgressBarStep;
    property OnAddTreeViewLine: TOnAddTreeViewLine read FOnAddTreeViewLine write FOnAddTreeViewLine;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, BCControl.Utils, BCCommon.Language.Strings, Vcl.Forms,
  BCEditor.Encoding, BCEditor.Editor.Utils, EditBone.Consts, BCCommon.FileUtils;

procedure TFindInFilesThread.Execute;
begin
  Synchronize(
    procedure
    begin
      FindInFiles(FFolderText)
    end);
end;

constructor TFindInFilesThread.Create(const AFindWhatText, AFileTypeText, AFolderText: string;
  ASearchCaseSensitive, ALookInSubfolders: Boolean; const AFileExtensions: string);
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

procedure TFindInFilesThread.FindInFiles(const AFolderText: string);
var
  LTextLine: string;
  FName: string;
  i: Integer;
  LStringList: TStringList;
  LTextPtr, LStartTextPtr, LFindWhatTextPtr, LBookmarkTextPtr: PChar;
begin
  for FName in BCCommon.FileUtils.GetFiles(AFolderText, FFileTypeText, FLookInSubfolders) do
  begin
    Application.ProcessMessages;

    if Assigned(FOnCancelSearch) and FOnCancelSearch then
    begin
      Terminate;
      Exit;
    end;

    if Assigned(FOnProgressBarStep) then
      FOnProgressBarStep(Self);

    LStringList := GetStringList(FName);
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
                if Assigned(FOnAddTreeViewLine) then
                  FOnAddTreeViewLine(Self, FName, i, LBookmarkTextPtr - LStartTextPtr + 1, LStringList.Strings[i],
                    FFindWhatOriginalText);
              end
              else
                LTextPtr := LBookmarkTextPtr; { not found, return pointer back }
            end;
            Inc(LTextPtr);
          end;
        end
      except
        if Assigned(FOnAddTreeViewLine) then
          FOnAddTreeViewLine(Self, '', -1, 0, Format(LanguageDataModule.GetWarningMessage('FileAccessError'),
            [FName]), '');
      end;
    finally
      LStringList.Free;
    end;
  end;
end;

type
  TStringsProxy = class(TStrings);

function TFindInFilesThread.GetStringList(const AFilename: string): TStringList;
var
  LFileStream: TFileStream;
  LBuffer: TBytes;
  LWithBom: Boolean;
  LEncoding: System.SysUtils.TEncoding;
  LSize: Integer;
  LStrBuffer: string;
begin
  Result := TStringList.Create;
  LFileStream := TFileStream.Create(AFilename, fmOpenRead or fmShareDenyNone);
  try
    { Read file into buffer }
    SetLength(LBuffer, LFileStream.Size);
    LFileStream.ReadBuffer(Pointer(LBuffer)^, Length(LBuffer));
  finally
    LFileStream.Free;
  end;
  { Identify encoding }
  if IsUTF8Buffer(LBuffer, LWithBOM) then
  begin
    if LWithBOM then
      LEncoding := TEncoding.UTF8
    else
      LEncoding := BCEditor.Encoding.TEncoding.UTF8WithoutBOM;
  end
  else
    LEncoding := nil;

	LSize := TEncoding.GetBufferEncoding(LBuffer, LEncoding);
	LStrBuffer := LEncoding.GetString(LBuffer, LSize, Length(LBuffer) - LSize);
	SetLength(LBuffer, 0);
	TStringsProxy(Result).SetTextStr(LStrBuffer);
end;

end.
