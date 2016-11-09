unit EditBone.FindInFiles;

interface

uses
  System.Classes, System.Types, BCEditor.Editor;

type
  TOnCancelSearch = function: Boolean of object;
  TOnAddTreeViewLine = procedure(ASender: TObject; const AFilename: string; const ALine, ACharacter: LongInt; const AText: string;
    const ASearchString: string; const ALength: Integer) of object;

  TFindInFilesThread = class(TThread)
  private
    FCount: Integer;
    FEditor: TBCEditor;
    FOnCancelSearch: TOnCancelSearch;
    FOnProgressBarStep: TNotifyEvent;
    FOnAddTreeViewLine: TOnAddTreeViewLine;
    FFileExtensions: string;
    FFileTypeText: string;
    FFindWhatText: string;
    FFolderText: string;
    FLookInSubfolders: Boolean;
    procedure FindInFiles(const AFolderText: string);
  public
    constructor Create(const AFindWhatText, AFileTypeText, AFolderText: string;
      ASearchCaseSensitive, ARegularExpressions, AWildcard, AWholeWordsOnly, ALookInSubfolders: Boolean;
      const AFileExtensions: string); overload;
    procedure Execute; override;
    property Count: Integer read FCount;
    property FindWhatText: string read FFindWhatText;
    property OnCancelSearch: TOnCancelSearch read FOnCancelSearch write FOnCancelSearch;
    property OnProgressBarStep: TNotifyEvent read FOnProgressBarStep write FOnProgressBarStep;
    property OnAddTreeViewLine: TOnAddTreeViewLine read FOnAddTreeViewLine write FOnAddTreeViewLine;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, BCControl.Utils, BCCommon.Language.Strings, Vcl.Forms, BCEditor.Types,
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
  ASearchCaseSensitive, ARegularExpressions, AWildcard, AWholeWordsOnly, ALookInSubfolders: Boolean;
  const AFileExtensions: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;

  FFileExtensions := AFileExtensions;
  FFileTypeText := AFileTypeText;
  FFolderText := AFolderText;
  FFindWhatText := AFindWhatText;
  FLookInSubfolders := ALookInSubfolders;
  FCount := 0;

  FEditor := TBCEditor.Create(nil);
  FEditor.Search.Enabled := True;

  FEditor.Search.SetOption(soCaseSensitive, ASearchCaseSensitive);
  FEditor.Search.SetOption(soWholeWordsOnly, AWholeWordsOnly);
  if ARegularExpressions then
    FEditor.Search.Engine := seRegularExpression
  else
  if AWildcard then
    FEditor.Search.Engine := seWildcard
  else
    FEditor.Search.Engine := seNormal;

  FEditor.Search.SearchText := AFindWhatText;
end;

procedure TFindInFilesThread.FindInFiles(const AFolderText: string);
var
  LIndex: Integer;
  LFileName: string;
  LPSearchItem: PBCEditorSearchItem;
begin
  try
    for LFileName in BCCommon.FileUtils.GetFiles(AFolderText, FFileTypeText, FLookInSubfolders) do
    begin
      Application.ProcessMessages;

      if Assigned(FOnCancelSearch) and FOnCancelSearch then
      begin
        Terminate;
        Exit;
      end;

      if Assigned(FOnProgressBarStep) then
        FOnProgressBarStep(Self);

      try
        FEditor.LoadFromFile(LFileName);
        Inc(FCount, FEditor.Search.Lines.Count);
        for LIndex := 0 to FEditor.Search.Lines.Count - 1 do
        begin
          LPSearchItem := PBCEditorSearchItem(FEditor.Search.Lines.Items[LIndex]);

          if Assigned(FOnAddTreeViewLine) then
            FOnAddTreeViewLine(Self, LFileName, LPSearchItem^.TextPosition.Line, LPSearchItem^.TextPosition.Char,
              FEditor.Lines[LPSearchItem^.TextPosition.Line], FEditor.Search.SearchText, LPSearchItem^.Length);
        end;
      except
        if Assigned(FOnAddTreeViewLine) then
          FOnAddTreeViewLine(Self, '', -1, 0, Format(LanguageDataModule.GetWarningMessage('FileAccessError'),
            [LFileName]), '', 0);
      end;
    end;
  finally
    FEditor.Free;
  end;
end;

end.
