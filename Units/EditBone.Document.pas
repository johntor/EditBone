unit EditBone.Document;

interface

uses
  Winapi.Windows, Winapi.CommDlg, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, EditBone.Consts,
  BCEditor.Editor, Vcl.ComCtrls, Vcl.ImgList, Vcl.Menus, BCControls.PageControl, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ActnList, System.Actions, BCControls.ProgressBar, BCControls.ImageList, Vcl.ActnMan, acAlphaImageList,
  sPageControl, BCEditor.Types, EditBone.Types, BCControls.StatusBar, BCEditor.MacroRecorder, BCEditor.Print,
  Vcl.PlatformDefaultStyleActnCtrls, BCEditor.Editor.Bookmarks, sFrameAdapter, BCCommon.Frames.Base, Vcl.Dialogs, sDialogs,
  System.ImageList, Vcl.ExtCtrls, BCEditor.Print.Types, EditBone.XMLTree, BCControls.Splitter, BCControls.ComboBox,
  System.Generics.Collections;

type
  TEBSetBookmarks = procedure of object;
  TEBSetTitleBarMenus = procedure of object;
  TEBCreateFileReopenList = procedure of object;
  TEBGetActionList = function: TObjectList<TAction> of object;

  TEBDocument = class(TObject)
    procedure EditorOnChange(Sender: TObject);
    procedure EditorReplaceText(Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer;
      DeleteLine: Boolean; var Action: TBCEditorReplaceAction);
    procedure EditorCaretChanged(Sender: TObject; X, Y: Integer);
    procedure EditorAfterBookmarkPlaced(Sender: TObject);
    procedure EditorAfterClearBookmark(Sender: TObject);
    procedure TabSheetNewClickBtn(Sender: TObject);
  private
    FCaretInfo: string;
    FCompareImageIndex, FNewImageIndex: Integer;
    FCreateFileReopenList: TEBCreateFileReopenList;
    FGetActionList: TEBGetActionList;
    FNumberOfNewDocument: Integer;
    FImages: TImageList;
    FPageControl: TBCPageControl;
    FProcessing: Boolean;
    FProgressBar: TBCProgressBar;
    FModifiedDocuments: Boolean;
    FOpenDialog: TOpenDialog;
    FSaveDialog: TSaveDialog;
    FStatusBar: TBCStatusBar;
    FPopupMenuEditor: TPopupMenu;
    FPopupMenuXMLTree: TPopupMenu;
    FSetBookmarks: TEBSetBookmarks;
    FSetTitleBarMenus: TEBSetTitleBarMenus;
    FTabSheetNew: TsTabSheet;
    function CreateNewTabSheet(FileName: string = ''; ShowMinimap: Boolean = False; AHighlighter: string = '';
      AColor: string = ''): TBCEditor;
    function FindOpenFile(FileName: string): TBCEditor;
    function GetActiveDocumentFound: Boolean;
    function GetActiveDocumentModified: Boolean;
    function GetActiveDocumentName: string;
    function GetActivePageCaption: string;
    function GetActiveTabSheetCaption: string;
    function GetCanRedo: Boolean;
    function GetCanUndo: Boolean;
    //function GetCompareFrame(TabSheet: TTabSheet): TCompareFrame;
    //function GetDocTabSheetFrame(TabSheet: TTabSheet): TDocTabSheetFrame;
    function GetModifiedDocuments(CheckActive: Boolean = True): Boolean;
    function GetOpenTabSheetCount: Integer;
    function GetSelectionFound: Boolean;
    function GetSelectionModeChecked: Boolean;
    function GetSplitChecked: Boolean;
    function GetMinimapChecked: Boolean;
    function GetEditor(const ATabSheet: TTabSheet; const ATag: Integer = EDITBONE_EDITOR_TAG): TBCEditor;
    function GetXMLTree(const ATabSheet: TTabSheet): TEBXMLTree;
    function GetComboBoxSearchText(const ATabSheet: TTabSheet): TBCComboBox;
    function GetXMLTreeVisible: Boolean;
    function GetVerticalSplitter(const ATabSheet: TTabSheet): TBCSplitter;
    function Save(TabSheet: TTabSheet; ShowDialog: Boolean = False): string; overload;
    procedure AddToReopenFiles(FileName: string);
    procedure CheckModifiedDocuments;
    procedure SelectHighlighter(FileName: string);
    procedure SetActivePageCaptionModified(AModified: Boolean);
    procedure SetEditorBookmarks(Editor: TBCEditor; Bookmarks: TStrings);
    procedure SetSkinColors(Editor: TBCEditor);
  public
    constructor Create;
    destructor Destroy; override;
    function Close(AFreePage: Boolean = True; ATabIndex: Integer = -1): Integer;
    function GetActiveSplitEditor: TBCEditor;
    function GetActiveEditor: TBCEditor;
    function GetMacroRecordPauseImageIndex: Integer;
    function GetModifiedInfo: string;
    function GetActiveBookmarkList: TBCEditorBookmarkList;
    //function IsCompareFilesActivePage: Boolean;
    procedure InsertTag;
    procedure InitializeEditorPrint(EditorPrint: TBCEditorPrint);
    function IsMacroStopped: Boolean;
    function IsRecordingMacro: Boolean;
    function IsSQLDocument: Boolean;
    function IsXMLDocument: Boolean;
    function Options(AActionList: TActionList): Boolean;
    function ReadIniOpenFiles: Boolean;
    function SaveAs: string;
    function ToggleLineNumbers: Boolean;
    function ToggleSpecialChars: Boolean;
    function ToggleWordWrap: Boolean;
    function ToggleXMLTree: Boolean;
    procedure CheckFileDateTimes;
    procedure ClearBookmarks;
    procedure CloseAll;
    procedure CloseAllOtherPages;
    //procedure CompareFiles(FileName: string = ''; AFileDragDrop: Boolean = False);
    procedure Copy;
    procedure Cut;
    procedure DecreaseIndent;
    procedure DeleteEndOfLine;
    procedure DeleteLine;
    procedure DeleteWhiteSpace;
    procedure DeleteWord;
    procedure FileProperties;
    procedure FindNext;
    procedure FindPrevious;
    procedure FormatXML;
    procedure FormatSQL;
    procedure GotoBookmarks(ItemIndex: Integer);
    procedure GotoLine;
    procedure IncreaseIndent;
    procedure InsertLine;
    procedure InsertDateAndTime;
    procedure LoadMacro;
    procedure New;
    procedure NextPage;
    procedure Open(FileName: string = ''; Bookmarks: TStrings = nil; Ln: Integer = 0; Ch: Integer = 0;
      StartUp: Boolean = False; ShowMinimap: Boolean = False; AHighlighter: string = ''; AColor: string = '');
    procedure Paste;
    procedure PlaybackMacro;
    procedure PreviousPage;
    procedure Print;
    procedure PrintPreview;
    procedure RecordMacro;
    procedure Redo;
    procedure Refresh(Page: Integer);
    procedure Replace;
    procedure Save; overload;
    procedure SaveAll;
    procedure SaveMacro;
    procedure Search;
    procedure SelectAll;
    procedure SelectForCompare;
    procedure SetActiveEncoding(Value: Integer);
    procedure SetHighlighter(AHighlighterName: string);
    procedure SetHighlighterColor(AColorName: string);
    procedure SetOptions;
    procedure ShowInfo;
    procedure Sort(ASortOrder: TBCEditorSortOrder = soToggle);
    procedure StopMacro;
    procedure ToggleBookmark(AItemIndex: Integer);
    procedure ToggleCase(ACase: TBCEditorCase = cNone);
    procedure ToggleMiniMap;
    procedure ToggleSelectionMode;
    procedure ToggleSplit;
    procedure Undo;
    procedure UpdateHighlighterColors;
    procedure UpdateLanguage(SelectedLanguage: string);
    procedure WriteIniFile;
    property ActiveDocumentFound: Boolean read GetActiveDocumentFound;
    property ActiveDocumentModified: Boolean read GetActiveDocumentModified;
    property ActiveDocumentName: string read GetActiveDocumentName;
    property ActiveTabSheetCaption: string read GetActiveTabSheetCaption;
    property CanRedo: Boolean read GetCanRedo;
    property CanUndo: Boolean read GetCanUndo;
    property CaretInfo: string read FCaretInfo;
    property CreateFileReopenList: TEBCreateFileReopenList read FCreateFileReopenList write FCreateFileReopenList;
    property GetActionList: TEBGetActionList read FGetActionList write FGetActionList;
    property MinimapChecked: Boolean read GetMinimapChecked;
    property ModifiedDocuments: Boolean read FModifiedDocuments write FModifiedDocuments;
    property OpenDialog: TOpenDialog read FOpenDialog write FOpenDialog;
    property OpenTabSheetCount: Integer read GetOpenTabSheetCount;
    property PageControl: TBCPageControl read FPageControl write FPageControl;
    property PopupMenuEditor: TPopupMenu read FPopupMenuEditor write FPopupMenuEditor;
    property PopupMenuXMLTree: TPopupMenu read FPopupMenuXMLTree write FPopupMenuXMLTree;
    property Processing: Boolean read FProcessing;
    property ProgressBar: TBCProgressBar read FProgressBar write FProgressBar;
    property SaveDialog: TSaveDialog read FSaveDialog write FSaveDialog;
    property SelectionFound: Boolean read GetSelectionFound;
    property SelectionModeChecked: Boolean read GetSelectionModeChecked;
    property SetBookmarks: TEBSetBookmarks read FSetBookmarks write FSetBookmarks;
    property SetTitleBarMenus: TEBSetTitleBarMenus read FSetTitleBarMenus write FSetTitleBarMenus;
    property SplitChecked: Boolean read GetSplitChecked;
    property StatusBar: TBCStatusBar write FStatusBar;
    property XMLTreeVisible: Boolean read GetXMLTreeVisible;
  end;

implementation

uses
  Vcl.Forms, BCCommon.Forms.Print.Preview, BCCommon.Options.Container, BCCommon.Dialogs.ConfirmReplace, BCControls.Panel,
  Vcl.ActnMenus, System.Types, System.WideStrings, System.Math, BigIni, Vcl.GraphUtil, BCCommon.Language.Strings,
  BCCommon.Dialogs.InputQuery, BCCommon.Language.Utils, BCCommon.Dialogs.Replace, BCCommon.FileUtils, BCCommon.Messages,
  BCCommon.StringUtils, Winapi.CommCtrl, EditBone.Forms.Options, BCCommon.Images,
  BCCommon.SQL.Formatter, BCEditor.Editor.KeyCommands, EditBone.Images,
  BCControls.Utils, BCEditor.Editor.Utils, BCCommon.Consts, BCEditor.Encoding, Vcl.Clipbrd, BCEditor.Highlighter.Colors;

{ TEBDocument }

constructor TEBDocument.Create;
begin
  inherited;
  FNumberOfNewDocument := 0;
  FProcessing := False;
  FModifiedDocuments := False;

  SetOptions;

  FTabSheetNew := TsTabSheet.Create(PageControl);
  FTabSheetNew.PageControl := PageControl;
  FTabSheetNew.Caption := '    ';
  FTabSheetNew.TabType := ttButton;
  FTabSheetNew.TabSkin := 'CHECKBOX';
  FTabSheetNew.OnClickBtn := TabSheetNewClickBtn
end;

destructor TEBDocument.Destroy;
begin
  if Assigned(FImages) then
    FImages.Free;

  FTabSheetNew.Free;

  inherited Destroy;
end;

procedure TEBDocument.TabSheetNewClickBtn(Sender: TObject);
begin
  inherited;
  New;
end;

function TEBDocument.ToggleXMLTree: Boolean;
var
  i: Integer;
  LEditor: TBCEditor;
  LXMLTree: TEBXMLTree;
  LVerticalSplitter: TBCSplitter;
begin
  Result := False;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    LEditor := GetEditor(PageControl.Pages[i]);
    if Assigned(LEditor) then
      if Pos('XML', LEditor.Highlighter.FileName) <> 0 then
      begin
        LXMLTree := GetXMLTree(PageControl.Pages[i]);
        if not Assigned(LXMLTree) then
        begin
          LXMLTree := TEBXMLTree.Create(PageControl.Pages[i]);
          LXMLTree.ProgressBar := FProgressBar;
          LXMLTree.Editor := LEditor;
          LXMLTree.Images := DataModuleImages.ImageListXMLTree;
          LXMLTree.PopupMenu := FPopupMenuXMLTree;
          LXMLTree.Parent := PageControl.Pages[i];
          LXMLTree.LoadFromXML(LEditor.Text);
        end
        else
        begin
          LXMLTree.Free;
          LXMLTree := nil;
        end;
        LVerticalSplitter := GetVerticalSplitter(PageControl.Pages[i]);
        if Assigned(LVerticalSplitter) then
          LVerticalSplitter.Visible := not LVerticalSplitter.Visible;
        Result := Assigned(LXMLTree);
      end;
  end;
end;

function TEBDocument.GetXMLTreeVisible: Boolean;
var
  LXMLTree: TEBXMLTree;
begin
  Result := False;
  LXMLTree := GetXMLTree(PageControl.ActivePage);
  if Assigned(LXMLTree) then
    Result := LXMLTree.Visible;
end;

procedure TEBDocument.EditorAfterBookmarkPlaced(Sender: TObject);
begin
  if Assigned(FSetBookmarks) then
    FSetBookmarks;
end;

procedure TEBDocument.EditorAfterClearBookmark(Sender: TObject);
begin
  if Assigned(FSetBookmarks) then
    FSetBookmarks;
end;

function TEBDocument.CreateNewTabSheet(FileName: string = ''; ShowMinimap: Boolean = False;
  AHighlighter: string = ''; AColor: string = ''): TBCEditor;
var
  LTabSheet: TsTabSheet;
  LEditor: TBCEditor;
begin
  FProcessing := True;

  { create a TabSheet }
  LTabSheet := TsTabSheet.Create(PageControl);
  LTabSheet.PageControl := PageControl;

  FTabSheetNew.PageIndex := PageControl.PageCount - 1;

  if FileName <> '' then
    LTabSheet.ImageIndex := GetIconIndex(FileName)
  else
    LTabSheet.ImageIndex := FNewImageIndex;

  PageControl.ActivePage := LTabSheet;

  { set the Caption property }
  if FileName = '' then
    PageControl.ActivePageCaption := LanguageDataModule.GetConstant('Document') + IntToStr(FNumberOfNewDocument)
  else
    PageControl.ActivePageCaption := ExtractFileName(FileName);

  LEditor := TBCEditor.Create(LTabSheet);
  with LEditor do
  begin
    Visible := False;
    Parent := LTabSheet;
    DocumentName := FileName;
    SearchString := '';
    FileDateTime := GetFileDateTime(FileName);
    OnChange := EditorOnChange;
    OnCaretChanged := EditorCaretChanged;
    OnReplaceText := EditorReplaceText;
    OnAfterBookmarkPlaced := EditorAfterBookmarkPlaced;
    OnAfterClearBookmark := EditorAfterClearBookmark;
    PopupMenu := FPopupMenuEditor;
    Minimap.Visible := ShowMinimap;
    Tag := EDITBONE_EDITOR_TAG;
  end;
  { VirtualDrawTree }
  //DocTabSheetFrame.ImageListXMLTree := Self.ImageListXMLTree;
  //DocTabSheetFrame.PopupMenuXMLTree := Self.PopupMenuXMLTree;

  OptionsContainer.AssignTo(LEditor);

  if FileName <> '' then
  begin
    if AHighlighter <> '' then
      SetHighlighter(AHighlighter)
    else
      SelectHighlighter(FileName);
    if AColor <> '' then
      SetHighlighterColor(AColor)
    else
      SetHighlighterColor(OptionsContainer.DefaultColor);
    LEditor.LoadFromFile(FileName);
  end
  else
  begin
    SetActiveEncoding(OptionsContainer.DefaultEncoding);
    SetHighlighter(OptionsContainer.DefaultHighlighter);
    SetHighlighterColor(OptionsContainer.DefaultColor);
  end;

  if Assigned(FSetTitleBarMenus) then
    FSetTitleBarMenus;

  { XML Tree }
  {XMLTreeVisible := OptionsContainer.ShowXMLTree and IsXMLDocument;
  if XMLTreeVisible then
    LoadFromXML(Editor.Text);}

  { reduce flickering by setting width and height to zero }
  LEditor.Width := 0;
  LEditor.Height := 0;
  LEditor.Visible := True;

  if LEditor.CanFocus then
    LEditor.SetFocus;

  Result := LEditor;
  FProcessing := False;
end;
 (*
procedure TEBDocument.CompareFiles(FileName: string; AFileDragDrop: Boolean);
var
  i: Integer;
  TabSheet: TsTabSheet;
  //Frame: TCompareFrame;
  TempList: TStringList;
  Editor: TBCEditor;
begin
  { create list of open documents }
  TempList := TStringList.Create;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    Editor := GetEditor(PageControl.Pages[i]);
    if Assigned(Editor) then
      TempList.Add(Editor.DocumentName);
  end;
  if FileName <> '' then
  begin
    { find compare tab }
    for i := 0 to PageControl.PageCount - 2 do
      if PageControl.Pages[i].ImageIndex = FCompareImageIndex then
      begin
        Frame := GetCompareFrame(PageControl.Pages[i]);
        { if there already are two files to compare then continue }
        if Frame.ComparedFilesSet then
          Continue
        else
        begin
          { else set file and exit }
          PageControl.ActivePageIndex := i;
          Frame.SetCompareFile(FileName, AFileDragDrop);
          Exit;
        end;
      end;
  end;
  { create a TabSheet }
  TabSheet := TsTabSheet.Create(PageControl);
  TabSheet.PageControl := PageControl;
  TabSheet.ImageIndex := FCompareImageIndex;
  TabSheet.Caption := LanguageDataModule.GetConstant('CompareFiles');

  PageControl.ActivePage := TabSheet;
  { create a compare frame }
  Frame := TCompareFrame.Create(TabSheet);
  with Frame do
  begin
    Parent := TabSheet;
    Align := alClient;
    OpenDocumentsList := TempList;
    SetCompareFile(FileName);
    SpecialChars := OptionsContainer.EnableSpecialChars;
    LineNumbers := OptionsContainer.EnableLineNumbers;
    UpdateLanguage(GetSelectedLanguage);
  end;
end;     *)

procedure TEBDocument.SelectForCompare;
{var
  Editor: TBCEditor;   }
begin
  {Editor := GetActiveEditor;
  if Assigned(Editor) then
    CompareFiles(Editor.DocumentName);  }
end;

function TEBDocument.FindOpenFile(FileName: string): TBCEditor;
var
  i: Integer;
  Editor: TBCEditor;
begin
  Result := nil;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    Editor := GetEditor(PageControl.Pages[i]);
    if Assigned(Editor) then
      if CompareText(UpperCase(Editor.DocumentName), UpperCase(FileName)) = 0 then
      begin
        PageControl.ActivePage := PageControl.Pages[i] as TsTabSheet;
        Result := Editor;
        Break;
      end;
  end;
end;

procedure TEBDocument.New;
begin
  Inc(FNumberOfNewDocument);
  CreateNewTabSheet;
end;


procedure TEBDocument.SetEditorBookmarks(Editor: TBCEditor; Bookmarks: TStrings);
var
  i: Integer;
  Temp: string;
  LBookmarkIndex, Ln, Ch: Integer;
begin
  if Assigned(Bookmarks) then
  begin
    for i := 0 to Bookmarks.Count - 1 do
    begin
      Temp := Bookmarks.Strings[i];
      if Pos(Editor.DocumentName, Temp) <> 0 then
      begin
        Temp := System.Copy(Temp, Pos('=', Temp) + 1, Length(Temp));
        LBookmarkIndex := StrToInt(System.Copy(Temp, 1, Pos(';', Temp) - 1));
        Temp := System.Copy(Temp, Pos(';', Temp) + 1, Length(Temp));
        Ln := StrToInt(System.Copy(Temp, 1, Pos(';', Temp) - 1));
        Temp := System.Copy(Temp, Pos(';', Temp) + 1, Length(Temp));
        Ch := StrToInt(Temp);

        Editor.SetBookMark(LBookmarkIndex, Ch, Ln);
      end;
    end;
  end;
end;

procedure TEBDocument.AddToReopenFiles(FileName: string);
var
  i: Integer;
  Files: TStrings;
  IniFile: string;
begin
  IniFile := GetIniFilename;
  Files := TStringList.Create;
  try
    { Read section }
    with TBigIniFile.Create(IniFile) do
    try
      ReadSectionValues('FileReopenFiles', Files);
    finally
      Free;
    end;
    { Insert filename }
    for i := 0 to Files.Count - 1 do
      Files[i] := System.Copy(Files[i], Pos('=', Files[i]) + 1, Length(Files[i]));
    for i := Files.Count - 1 downto 0 do
      if Files[i] = FileName then
        Files.Delete(i);
    Files.Insert(0, FileName);
    while Files.Count > 10 do
      Files.Delete(Files.Count - 1);
    { write section }
    with TBigIniFile.Create(IniFile) do
    try
      EraseSection('FileReopenFiles');
      for i := 0 to Files.Count - 1 do
        WriteString('FileReopenFiles', IntToStr(i), Files.Strings[i]);
    finally
      Free;
    end;
    { if ini file is open in editor reload it because time has changed }
    for i := 0 to PageControl.PageCount - 2 do
      if PageControl.Pages[i].Caption = ExtractFileName(IniFile) then
        Refresh(i);
  finally
    Files.Free;
  end;
end;

procedure TEBDocument.Open(FileName: string = ''; Bookmarks: TStrings = nil; Ln: Integer = 0; Ch: Integer = 0;
  StartUp: Boolean = False; ShowMinimap: Boolean = False; AHighlighter: string = ''; AColor: string = '');
var
  i: Integer;
  Editor: TBCEditor;
begin
  FProcessing := True;
  try
    if FileName = '' then
    begin
      OpenDialog.Filter := OptionsContainer.Filters;
      OpenDialog.Title := LanguageDataModule.GetConstant('Open');
      if OpenDialog.Execute(PageControl.Handle) then
        for i := 0 to OpenDialog.Files.Count - 1 do
          Open(OpenDialog.Files[i])
    end
    else
    begin
      if FileExists(FileName) then
      begin
        Editor := FindOpenFile(FileName);
        if not Assigned(Editor) then
          Editor := CreateNewTabSheet(FileName, ShowMinimap, AHighlighter, AColor);
        SetEditorBookmarks(Editor, Bookmarks);

        Editor.GotoLineAndCenter(Ln);
        Editor.CaretPosition := GetTextPosition(Ch, Ln);
        if not StartUp then
        begin
          AddToReopenFiles(FileName);
          if Assigned(FCreateFileReopenList) then
            FCreateFileReopenList;
        end;
      end
      else if ExtractFileName(FileName) <> '' then
        ShowErrorMessage(Format(LanguageDataModule.GetErrorMessage('FileNotFound'), [FileName]))
    end;
  finally
    FProcessing := False;
  end;
end;

function TEBDocument.Close(AFreePage: Boolean = True; ATabIndex: Integer = -1): Integer;
var
  LActivePageIndex: Integer;
  Editor: TBCEditor;
begin
  Result := mrNone;

  if ATabIndex <> -1 then
    Editor := GetEditor(PageControl.Pages[ATabIndex])
  else
    Editor := GetActiveEditor;
  if Assigned(Editor) and Editor.Modified then
  begin
    Result := SaveChanges;
    if Result = mrYes then
      Save;
  end;

  if Result <> mrCancel then
  begin
    PageControl.TabClosed := True;
    if ATabIndex = -1 then
      LActivePageIndex := PageControl.ActivePageIndex
    else
      LActivePageIndex := ATabIndex;
    if AFreePage and (PageControl.PageCount > 0) then
    begin
      PageControl.Pages[LActivePageIndex].Free;
      if LActivePageIndex > 0 then
        PageControl.ActivePageIndex := LActivePageIndex - 1
      else if PageControl.PageCount > 0 then
        PageControl.ActivePageIndex := 0;
    end
    else
    begin
      TsTabSheet(PageControl.Pages[LActivePageIndex]).TabVisible := False;
      PageControl.Pages[LActivePageIndex].PageIndex := LActivePageIndex + 1;
    end;
    if PageControl.PageCount = 0 then
      FNumberOfNewDocument := 0;
  end;
  if Assigned(FSetTitleBarMenus) then
    FSetTitleBarMenus;
  CheckModifiedDocuments;
  PageControl.Repaint; { Icon paint bug fix }
end;

procedure TEBDocument.CloseAll;
var
  Rslt, i: Integer;
begin
  Application.ProcessMessages;
  FProcessing := True;
  Rslt := mrNone;

  if FModifiedDocuments then
  begin
    Rslt := SaveChanges;
    if Rslt = mrYes then
      SaveAll;
  end;
  if Rslt <> mrCancel then
  begin
    Screen.Cursor := crHourGlass;
    try
      FProgressBar.Count := PageControl.PageCount;
      FProgressBar.Show;
      for i := PageControl.PageCount - 2 downto 0 do
      begin
        if TsTabSheet(PageControl.Pages[i]).TabType = ttTab then
        begin
          ProgressBar.StepIt;
          Application.ProcessMessages;
          PageControl.Pages[i].Free;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
      FProgressBar.Hide;
    end;
    FNumberOfNewDocument := 0;
  end;
  Application.ProcessMessages;
  CheckModifiedDocuments;
  PageControl.Repaint; { Icon paint bug fix }
  FProcessing := False;
end;

procedure TEBDocument.CloseAllOtherPages;
var
  i: Integer;
  Rslt: Integer;
  ActiveEditor, Editor: TBCEditor;
begin
  Application.ProcessMessages;
  FProcessing := True;

  Rslt := mrNone;

  ActiveEditor := GetActiveEditor;

  if GetModifiedDocuments(False) then
  begin
    Rslt := SaveChanges(True);

    if Rslt = mrYes then
      for i := 0 to PageControl.PageCount - 2 do
      begin
        Editor := GetEditor(PageControl.Pages[i]);
        if Assigned(Editor) and Editor.Modified and (Editor <> ActiveEditor) then
          Save(PageControl.Pages[i]);
      end;
  end;

  if Rslt <> mrCancel then
  begin
    PageControl.ActivePage.PageIndex := 0; { move the page first }
    if Assigned(FTabSheetNew) then
      FTabSheetNew.PageIndex := 1;
    Screen.Cursor := crHourGlass;
    try
      FProgressBar.Count := PageControl.PageCount;
      FProgressBar.Show;
      for i := PageControl.PageCount - 1 downto 2 do
      begin
        ProgressBar.StepIt;
        Application.ProcessMessages;
        PageControl.Pages[i].Free;
      end;
      FProgressBar.Hide;
    finally
      Screen.Cursor := crDefault;
    end;
    Editor := GetActiveEditor;
    if Assigned(Editor) and (Editor.DocumentName = '') then
      FNumberOfNewDocument := 1
    else
      FNumberOfNewDocument := 0
  end;
  Application.ProcessMessages;
  CheckModifiedDocuments;
  PageControl.Repaint; { Icon paint bug fix }
  FProcessing := False;
end;

procedure TEBDocument.CheckModifiedDocuments;
begin
  FModifiedDocuments := GetModifiedDocuments;
end;

function TEBDocument.Save(TabSheet: TTabSheet; ShowDialog: Boolean): string;
var
  AFileName, FilePath: string;
  FilterIndex: Cardinal;
  LEditor: TBCEditor;
begin
  Result := '';
  LEditor := GetEditor(TabSheet);
  if Assigned(LEditor) then
  begin
    if (LEditor.DocumentName = '') or ShowDialog then
    begin
      if LEditor.DocumentName = '' then
      begin
        AFileName := Trim(TabSheet.Caption);
        AFileName := FormatFileName(AFileName);
      end
      else
        AFileName := ExtractFileName(LEditor.DocumentName);

      FilePath := ExtractFilePath(LEditor.DocumentName);
      FilterIndex := OptionsContainer.GetFilterIndex(ExtractFileExt(AFileName));
      SaveDialog.InitialDir := FilePath;
      SaveDialog.Filter := OptionsContainer.Filters;
      SaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
      SaveDialog.FilterIndex := FilterIndex;
      SaveDialog.FileName := AFileName;
      if SaveDialog.Execute(PageControl.Handle) then
      begin
        Result := SaveDialog.Files[0];
        if ExtractFileExt(Result) = '' then
          if (FilterIndex > 1) and (FilterIndex < OptionsContainer.FilterCount) then
            Result := Format('%s%s', [Result, OptionsContainer.GetFilterExt(FilterIndex)]);
        TabSheet.Caption := ExtractFileName(Result);
        LEditor.DocumentName := Result;
      end
      else
      begin
        if LEditor.CanFocus then
          LEditor.SetFocus;
        Exit;
      end;
    end;
    with LEditor do
    begin
      SaveToFile(DocumentName);
      if not OptionsContainer.UndoAfterSave then
        UndoList.Clear;
      FileDateTime := GetFileDateTime(DocumentName);
      Modified := False;
      TabSheet.ImageIndex := GetIconIndex(DocumentName);
      TabSheet.Caption := FormatFileName(TabSheet.Caption);
    end;
    CheckModifiedDocuments;
  end;
end;

procedure TEBDocument.Save;
begin
  if Assigned(PageControl.ActivePage) then
    Save(PageControl.ActivePage);
end;

function TEBDocument.SaveAs: string;
begin
  Result := '';
  if Assigned(PageControl.ActivePage) then
    Result := Save(PageControl.ActivePage, True);
end;

procedure TEBDocument.SaveAll;
var
  i: Integer;
  Editor: TBCEditor;
begin
  FProcessing := True;
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  try
    FProgressBar.Count := PageControl.PageCount;
    FProgressBar.Show;
    for i := 0 to PageControl.PageCount - 2 do
    begin
      ProgressBar.StepIt;
      Application.ProcessMessages;
      Editor := GetEditor(PageControl.Pages[i]);
      if Assigned(Editor) and Editor.Modified then
        Save(PageControl.Pages[i]);
    end;
    FProgressBar.Hide;
  finally
    Screen.Cursor := crDefault;
  end;
  FProcessing := False;
end;

function TEBDocument.GetActivePageCaption: string;
begin
  Result := FormatFileName(PageControl.ActivePageCaption);
end;

procedure TEBDocument.Undo;

  procedure Undo(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
      begin
        AEditor.DoUndo;
        if AEditor.UndoList.ItemCount = 0 then
          PageControl.ActivePageCaption := GetActivePageCaption;
      end;
  end;

begin
  Undo(GetActiveEditor);
  Undo(GetActiveSplitEditor);
  CheckModifiedDocuments;
end;

procedure TEBDocument.Redo;

  procedure Redo(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.DoRedo;
  end;

begin
  Redo(GetActiveEditor);
  Redo(GetActiveSplitEditor);
  CheckModifiedDocuments;
end;

procedure TEBDocument.Cut;

  procedure Cut(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.CutToClipboard;
  end;

begin
  Cut(GetActiveEditor);
  Cut(GetActiveSplitEditor);
end;

procedure TEBDocument.Copy;

  procedure Copy(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.CopyToClipboard;
  end;

begin
  Copy(GetActiveEditor);
  Copy(GetActiveSplitEditor);
end;

procedure TEBDocument.Paste;
var
  LEditor, LSplitEditor: TBCEditor;
  LComboBoxSearchText: TBCComboBox;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) and LEditor.Focused then
    LEditor.PasteFromClipboard
  else
  begin
    LSplitEditor := GetActiveSplitEditor;
    if Assigned(LSplitEditor) and LSplitEditor.Focused then
      LSplitEditor.PasteFromClipboard
    else
    begin
      if Assigned(LEditor) and LEditor.Search.Enabled then
      begin
        LEditor.Search.SearchText := Clipboard.AsText;
        if Assigned(LSplitEditor) and LSplitEditor.Search.Enabled then
          LSplitEditor.Search.SearchText := Clipboard.AsText;

        if OptionsContainer.DocumentSpecificSearch then
          OptionsContainer.DocumentSpecificSearchText := Clipboard.AsText;

        LComboBoxSearchText := GetComboBoxSearchText(PageControl.ActivePage);
        if Assigned(LComboBoxSearchText) then
          LComboBoxSearchText.Text := LEditor.Search.SearchText;
      end;
    end;
  end;
end;

procedure TEBDocument.InitializeEditorPrint(EditorPrint: TBCEditorPrint);
var
  LEditor: TBCEditor;
  LAlignment: TAlignment;

  procedure SetHeaderFooter(Option: Integer; Value: string);
  begin
    case Option of
      0, 1:
        with EditorPrint.Footer do
        begin
          case Option of
            0:
              LAlignment := taLeftJustify;
            1:
              LAlignment := taRightJustify;
          end;
          Add(Value, nil, LAlignment, 1);
        end;
      2, 3:
        with EditorPrint.Header do
        begin
          case Option of
            2:
              LAlignment := taLeftJustify;
            3:
              LAlignment := taRightJustify;
          end;
          Add(Value, nil, LAlignment, 1);
        end;
    end;
  end;

begin
  LEditor := GetActiveEditor;
  if not Assigned(LEditor) then
    Exit;

  EditorPrint.Editor := LEditor;
  EditorPrint.Title := LEditor.DocumentName;

  EditorPrint.Header.Clear;
  EditorPrint.Footer.Clear;

  SetHeaderFooter(0, Format(LanguageDataModule.GetConstant('PrintedBy'), [Application.Title]));
  SetHeaderFooter(1, LanguageDataModule.GetConstant('PreviewDocumentPage'));
  SetHeaderFooter(2, LEditor.DocumentName);
  SetHeaderFooter(3, '$DATE$ $TIME$');

  EditorPrint.Header.FrameTypes := [ftLine];
  EditorPrint.Footer.FrameTypes := [ftLine];
  EditorPrint.LineNumbersInMargin := True;
  EditorPrint.LineNumbers := True;
  EditorPrint.Wrap := False;
  EditorPrint.Colors := True;
end;

procedure TEBDocument.PrintPreview;
begin
  with PrintPreviewDialog do
  begin
    InitializeEditorPrint(PrintPreview.EditorPrint);
    ShowModal;
  end;
end;

procedure TEBDocument.Search;
var
  LOldCaretPosition: TBCEditorTextPosition;
  LOldSelectionBeginPosition, LOldSelectionEndPosition: TBCEditorTextPosition;
  LSelectedText: string;
  LSelectionAvailable: Boolean;
  LEditor: TBCEditor;
  LComboBoxSearchText: TBCComboBox;

  procedure ReadSearchOptions;

    procedure SetOption(Enabled: Boolean; Option: TBCEditorSearchOption);
    begin
      if Enabled then
        LEditor.Search.Options := LEditor.Search.Options + [Option]
      else
        LEditor.Search.Options := LEditor.Search.Options - [Option];
    end;

  begin
    with TBigIniFile.Create(GetIniFilename) do
    try
      SetOption(ReadBool('Options', 'SearchBeepIfSearchStringNotFound', True), soBeepIfStringNotFound);
      SetOption(ReadBool('Options', 'SearchCaseSensitive', False), soCaseSensitive);
      SetOption(ReadBool('Options', 'SearchEntireScope', False), soEntireScope);
      SetOption(ReadBool('Options', 'SearchHighlightResult', True), soHighlightResults);
      if ReadBool('Options', 'SearchRegularExpression', False) then
        LEditor.Search.Engine := seRegularExpression
      else
      if ReadBool('Options', 'SearchWildCard', False) then
        LEditor.Search.Engine := seWildCard
      else
        LEditor.Search.Engine := seNormal;
      SetOption(ReadBool('Options', 'SearchOnTyping', True), soSearchOnTyping);
      SetOption(ReadBool('Options', 'SearchSelectedOnly', False), soSelectedOnly);
      SetOption(ReadBool('Options', 'SearchShowSearchStringNotFound', False), soShowStringNotFound);
      SetOption(ReadBool('Options', 'SearchWholeWordsOnly', False), soWholeWordsOnly);
    finally
      Free;
    end;
  end;

begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
  begin
    LOldCaretPosition := LEditor.CaretPosition;
    LSelectionAvailable := LEditor.SelectionAvailable;
    if LSelectionAvailable then
    begin
      LOldSelectionBeginPosition := LEditor.SelectionBeginPosition;
      LOldSelectionEndPosition := LEditor.SelectionEndPosition;
    end;
    ReadSearchOptions;
    LEditor.Search.Enabled := True;
    LEditor.CaretPosition := LOldCaretPosition;
    if LSelectionAvailable then
    begin
      LEditor.SelectionBeginPosition := LOldSelectionBeginPosition;
      LEditor.SelectionEndPosition := LOldSelectionEndPosition;
    end;
    Application.ProcessMessages;

    LSelectedText := LEditor.SelectedText;
    LComboBoxSearchText := GetComboBoxSearchText(PageControl.ActivePage);
    if Assigned(LComboBoxSearchText) then
    begin
      if LSelectedText <> '' then
      begin
        LEditor.Search.SearchText := LSelectedText;
        LComboBoxSearchText.Text := LEditor.Search.SearchText;
        LComboBoxSearchText.OnChange(nil);
      end
      else
      if OptionsContainer.DocumentSpecificSearch then
      begin
        LEditor.Search.SearchText := OptionsContainer.DocumentSpecificSearchText;
        LComboBoxSearchText.Text := LEditor.Search.SearchText;
      end;
      if LComboBoxSearchText.CanFocus then
        LComboBoxSearchText.SetFocus;
    end;
  end;
end;

procedure TEBDocument.FindNext;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then
    Exit;
  Editor.FindNext;
end;

procedure TEBDocument.FindPrevious;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then
    Exit;
  Editor.FindPrevious;
end;

procedure TEBDocument.Replace;
var
  i: Integer;
  LEditor: TBCEditor;
  LResult: Integer;
begin
  FProcessing := True;

  with ReplaceDialog do
  begin
    LEditor := GetActiveEditor;
    if not Assigned(LEditor) then
      Exit;
    if LEditor.SelectionAvailable then
      ComboBoxSearchFor.Text := LEditor.SelectedText;
    LResult := ShowModal;
    if (LResult = mrOK) or (LResult = mrYes) then
    begin
      if ReplaceInWholeFile then
      begin
        GetOptions(LEditor);
        LEditor.CaretZero;
        LEditor.ReplaceText(ComboBoxSearchFor.Text, ComboBoxReplaceWith.Text);
      end
      else
      begin
        Screen.Cursor := crHourGlass;
        try
          FProgressBar.Count := PageControl.PageCount - 1;
          FProgressBar.Show;
          for i := 0 to PageControl.PageCount - 2 do
          begin
            ProgressBar.StepIt;
            Application.ProcessMessages;
            LEditor := GetEditor(PageControl.Pages[i]);
            if Assigned(LEditor) then
            begin
              GetOptions(LEditor);
              LEditor.CaretZero;
              LEditor.ReplaceText(ComboBoxSearchFor.Text, ComboBoxReplaceWith.Text);
              PageControl.Pages[i].Caption := FormatFileName(PageControl.Pages[i].Caption, LEditor.Modified);
            end;
          end;
        finally
          Screen.Cursor := crDefault;
          FProgressBar.Hide;
        end;
      end;
    end;
  end;
  FProcessing := False;
end;

procedure TEBDocument.ToggleBookmark(AItemIndex: Integer);
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.ToggleBookmark(AItemIndex);
end;

function TEBDocument.ToggleWordWrap: Boolean;
var
  i: Integer;
  Editor: TBCEditor;
begin
  OptionsContainer.EnableWordWrap := not OptionsContainer.EnableWordWrap;
  Result := OptionsContainer.EnableWordWrap;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    Editor := GetEditor(PageControl.Pages[i]);
    if Assigned(Editor) then
      Editor.WordWrap.Enabled := Result;
    Editor := GetEditor(PageControl.Pages[i], EDITBONE_SPLIT_EDITOR_TAG);
    if Assigned(Editor) then
      Editor.WordWrap.Enabled := Result;
  end;
end;

function TEBDocument.ToggleSpecialChars: Boolean;
var
  i: Integer;
  Editor: TBCEditor;
begin
  OptionsContainer.EnableSpecialChars := not OptionsContainer.EnableSpecialChars;
  Result := OptionsContainer.EnableSpecialChars;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    Editor := GetEditor(PageControl.Pages[i]);
    if Assigned(Editor) then
    begin
      Editor.SpecialChars.Visible := Result;
      Editor.SpecialChars.EndOfLine.Visible := Result;
    end;
    Editor := GetEditor(PageControl.Pages[i], EDITBONE_SPLIT_EDITOR_TAG);
    if Assigned(Editor) then
    begin
      Editor.SpecialChars.Visible := Result;
      Editor.SpecialChars.EndOfLine.Visible := Result;
    end;
    //if PageControl.Pages[i].Components[0] is TCompareFrame then
    //  Result := TCompareFrame(PageControl.Pages[i].Components[0]).ToggleSpecialChars
  end;
end;

function TEBDocument.GetSelectionModeChecked: Boolean;
var
  Editor: TBCEditor;
begin
  Result := False;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Result := Editor.Selection.Mode = smColumn;
end;

procedure TEBDocument.ToggleSelectionMode;
var
  i: Integer;

  procedure ToggleSelectionMode(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
    begin
      if OptionsContainer.EnableSelectionMode then
      begin
        Editor.Selection.Options := Editor.Selection.Options - [soALTSetsColumnMode];
        Editor.Selection.Mode := smColumn;
      end
      else
      begin
        Editor.Selection.Options := Editor.Selection.Options + [soALTSetsColumnMode];
        Editor.Selection.Mode := smNormal
      end;
    end;
  end;

begin
  OptionsContainer.EnableSelectionMode := not OptionsContainer.EnableSelectionMode;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    ToggleSelectionMode(GetEditor(PageControl.Pages[i]));
    ToggleSelectionMode(GetEditor(PageControl.Pages[i], EDITBONE_SPLIT_EDITOR_TAG));
  end;
end;

function TEBDocument.ToggleLineNumbers: Boolean;
var
  i: Integer;
  Editor: TBCEditor;
begin
  OptionsContainer.EnableLineNumbers := not OptionsContainer.EnableLineNumbers;
  Result := OptionsContainer.EnableLineNumbers;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    Editor := GetEditor(PageControl.Pages[i]);
    if Assigned(Editor) then
      Editor.LeftMargin.LineNumbers.Visible := Result;
    Editor := GetEditor(PageControl.Pages[i], EDITBONE_SPLIT_EDITOR_TAG);
    if Assigned(Editor) then
      Editor.LeftMargin.LineNumbers.Visible := Result;
    //if PageControl.Pages[i].Components[0] is TCompareFrame then
    //  Result := TCompareFrame(PageControl.Pages[i].Components[0]).ToggleLineNumbers
  end;
end;

function TEBDocument.ReadIniOpenFiles: Boolean;
var
  i: Integer;
  s, LFileName, LHighlighter, LColor: string;
  FileNames, Bookmarks: TStrings;
  // Editor: TBCEditor;
begin
  FileNames := TStringList.Create;
  Bookmarks := TStringList.Create;
  with TBigIniFile.Create(GetIniFilename) do
    try
      PageControl.Visible := False;
      { Open Files }
      ReadSectionValues('OpenFiles', FileNames);
      ReadSectionValues('Bookmarks', Bookmarks);
      for i := 0 to FileNames.Count - 1 do
      begin
        s := RemoveTokenFromStart('=', FileNames.Strings[i]);
        LFileName := GetNextToken(';', s);
        if FileExists(LFileName) then
        begin
          s := RemoveTokenFromStart(';', s);
          LHighlighter := GetNextToken(';', s);
          s := RemoveTokenFromStart(';', s);
          LColor := GetNextToken(';', s);
          Open(LFileName, Bookmarks, ReadInteger('CaretY', IntToStr(i), 0), ReadInteger('CaretX', IntToStr(i), 0), True,
            ReadBool('Minimaps', IntToStr(i), False), LHighlighter, LColor);
        end;
      end;

      i := ReadInteger('Options', 'ActivePageIndex', 0);
      if i < PageControl.PageCount then
      begin
        PageControl.ActivePageIndex := i;
        if Assigned(FSetTitleBarMenus) then
          FSetTitleBarMenus;
      end;

      Result := FileNames.Count > 0;
    finally
      FileNames.Free;
      Bookmarks.Free;
      // Minimaps.Free;
      Free;
      PageControl.Visible := True;
    end;
end;

procedure TEBDocument.WriteIniFile;
var
  i, j: Integer;
  FileType: string;
  LEditor: TBCEditor;
begin
  with TBigIniFile.Create(GetIniFilename) do
  try
    EraseSection('OpenFiles');
    EraseSection('Bookmarks');
    EraseSection('Minimaps');
    EraseSection('CaretY');
    { Open documents and bookmarks }
    if OptionsContainer.DocSaveTabs then
      for i := 0 to PageControl.PageCount - 2 do
      begin
        LEditor := GetEditor(PageControl.Pages[i]);
        if Assigned(LEditor) then
        begin
          if Trim(LEditor.DocumentName) <> '' then
            WriteString('OpenFiles', IntToStr(i), Format('%s;%s;%s;', [LEditor.DocumentName, LEditor.Highlighter.Name,
              LEditor.Highlighter.Colors.Name]));
          for j := 0 to LEditor.Marks.Count - 1 do
            WriteString('Bookmarks', Format('%s:%s', [LEditor.DocumentName, IntToStr(j)]),
              Format('%s;%s;%s', [IntToStr(LEditor.Marks.Items[j].Index), IntToStr(LEditor.Marks.Items[j].Line),
              IntToStr(LEditor.Marks.Items[j].Char)]));
          WriteBool('Minimaps', IntToStr(i), LEditor.Minimap.Visible);
          WriteInteger('CaretY', IntToStr(i), LEditor.CaretY);
          WriteInteger('CaretX', IntToStr(i), LEditor.CaretX);
        end;
      end;
    { Active document }
    WriteInteger('Options', 'ActivePageIndex', PageControl.ActivePageIndex);
    EraseSection('FileTypes');
    { FileTypes }
    for i := 0 to OptionsContainer.FileTypes.Count - 1 do
    begin
      FileType := Trim(System.Copy(LanguageDataModule.MultiStringHolderFileTypes.MultipleStrings.Items[i].Strings.Text,
        0, Pos('(', LanguageDataModule.MultiStringHolderFileTypes.MultipleStrings.Items[i].Strings.Text) - 1));
      WriteString('FileTypes', IntToStr(i),
        Format('%s (%s)', [FileType, StringBetween(OptionsContainer.FileTypes.Strings[i], '(', ')')]));
    end;
  finally
    Free;
  end;
end;

procedure TEBDocument.InsertTag;
var
  LEditor: TBCEditor;
  LTagName: string;
begin
  if TInputQueryDialog.ClassShowModal(Application.MainForm, LanguageDataModule.GetConstant('InsertTags'), LTagName) = mrOK then
  begin
    LEditor := GetActiveEditor;
    if Assigned(LEditor) then
    begin
      LEditor.CommandProcessor(ecImeStr, #0, PWideChar(Format('<%s></%s>', [LTagName, LTagName])));
      LEditor.CaretX := LEditor.CaretX - Length(LTagName) - 3; { -3 from </> }
    end;
  end;
end;

procedure TEBDocument.InsertDateAndTime;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.CommandProcessor(ecImeStr, #0, PWideChar(DateTimeToStr(Now)));
end;

function TEBDocument.Options(AActionList: TActionList): Boolean;
var
  ActionList: TObjectList<TAction>;
begin
  FProcessing := True;
  ActionList := GetActionList;
  try
    Result := OptionsForm.Execute(ActionList);
    if Result then
    begin
      SetOptions;
      UpdateHighlighterColors;
      WriteIniFile;
    end;
  finally
    if Assigned(ActionList) then
      ActionList.Free;
    FProcessing := False;
  end;
end;

procedure TEBDocument.SetOptions;
var
  i: Integer;
  LEditor: TBCEditor;
begin
  PageControl.DoubleBuffered := OptionsContainer.DocDoubleBuffered;
  PageControl.MultiLine := OptionsContainer.DocMultiLine;
  PageControl.ShowCloseBtns := OptionsContainer.DocShowCloseButton;
  PageControl.RightClickSelect := OptionsContainer.DocRightClickSelect;
  if Assigned(FTabSheetNew) then
    FTabSheetNew.TabVisible := OptionsContainer.DocShowNewDocumentButton;
  if OptionsContainer.DocShowImage then
    PageControl.Images := FImages
  else
    PageControl.Images := nil;
  { assign to every Editor }
  for i := 0 to PageControl.PageCount - 2 do
  begin
    LEditor := GetEditor(PageControl.Pages[i]);
    if Assigned(LEditor) then
      OptionsContainer.AssignTo(LEditor);
  end;
end;

{function TEBDocument.GetCompareFrame(TabSheet: TTabSheet): TCompareFrame;
begin
  Result := nil;
  if Assigned(TabSheet) then
    if TabSheet.ComponentCount <> 0 then
      if TabSheet.Components[0] is TCompareFrame then
        Result := TCompareFrame(TabSheet.Components[0]);
end; }

function TEBDocument.GetVerticalSplitter(const ATabSheet: TTabSheet): TBCSplitter;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ATabSheet.ControlCount - 1 do
  if ATabSheet.Controls[i].Tag = EDITBONE_VERTICAL_SPLITTER_TAG then
  begin
    Result := ATabSheet.Controls[i] as TBCSplitter;
    Break;
  end;
end;

function TEBDocument.GetComboBoxSearchText(const ATabSheet: TTabSheet): TBCComboBox;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ATabSheet.ControlCount - 1 do
  if ATabSheet.Controls[i].Tag = EDITBONE_COMBOBOX_TAG then
  begin
    Result := ATabSheet.Controls[i] as TBCComboBox;
    Break;
  end;
end;

function TEBDocument.GetXMLTree(const ATabSheet: TTabSheet): TEBXMLTree;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ATabSheet.ControlCount - 1 do
  if ATabSheet.Controls[i].Tag = EDITBONE_XML_TREE_TAG then
  begin
    Result := ATabSheet.Controls[i] as TEBXMLTree;
    Break;
  end;
end;

function TEBDocument.GetEditor(const ATabSheet: TTabSheet; const ATag: Integer = EDITBONE_EDITOR_TAG): TBCEditor;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ATabSheet.ControlCount - 1 do
  if ATabSheet.Controls[i].Tag = ATag then
  begin
    Result := ATabSheet.Controls[i] as TBCEditor;
    Break;
  end;
end;

procedure TEBDocument.GotoBookmarks(ItemIndex: Integer);
var
  Editor: TBCEditor;
  EditorCommand: TBCEditorCommand;
begin
  EditorCommand := ecNone;
  case ItemIndex of
    1:
      EditorCommand := ecGotoBookmark1;
    2:
      EditorCommand := ecGotoBookmark2;
    3:
      EditorCommand := ecGotoBookmark3;
    4:
      EditorCommand := ecGotoBookmark4;
    5:
      EditorCommand := ecGotoBookmark5;
    6:
      EditorCommand := ecGotoBookmark6;
    7:
      EditorCommand := ecGotoBookmark7;
    8:
      EditorCommand := ecGotoBookmark8;
    9:
      EditorCommand := ecGotoBookmark9;
  end;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.CommandProcessor(EditorCommand, Char(ItemIndex), nil);
end;

procedure TEBDocument.GotoLine;
var
  LEditor: TBCEditor;
  LRow: Integer;
begin
  if TInputQueryDialog.ClassShowModal(Application.MainForm, LanguageDataModule.GetConstant('GoToLine'), LRow) = mrOK then
  begin
    LEditor := GetActiveEditor;
    if Assigned(LEditor) then
      LEditor.GotoLineAndCenter(LRow);
  end;
end;

function TEBDocument.GetActiveSplitEditor: TBCEditor;
begin
  if Assigned(PageControl.ActivePage) then
    Result := GetEditor(PageControl.ActivePage, EDITBONE_SPLIT_EDITOR_TAG)
  else
    Result := nil;
end;

function TEBDocument.GetActiveEditor: TBCEditor;
begin
  if Assigned(PageControl.ActivePage) then
    Result := GetEditor(PageControl.ActivePage)
  else
    Result := nil;
end;

procedure TEBDocument.SetActivePageCaptionModified(AModified: Boolean);
begin
  PageControl.ActivePageCaption := FormatFileName(PageControl.ActivePageCaption, AModified);
end;

procedure TEBDocument.EditorOnChange(Sender: TObject);
var
  LEditor: TBCEditor;
begin
  inherited;
  LEditor := GetEditor(PageControl.ActivePage);
  if Assigned(LEditor) then
  begin
    if not FModifiedDocuments then
      FModifiedDocuments := LEditor.Modified;

    if OptionsContainer.AutoSave then
      Save
    else
    if not FProcessing then
      SetActivePageCaptionModified(LEditor.Modified);
  end;
end;

function TEBDocument.GetActiveTabSheetCaption: string;
begin
  Result := '';

  if Assigned(PageControl.ActivePage) then
    if PageControl.ActivePage.TabType = ttTab then
      Result := PageControl.ActivePageCaption;
end;

function TEBDocument.GetActiveDocumentFound: Boolean;
var
  Editor: TBCEditor;
begin
  Result := False;

  if Assigned(PageControl.ActivePage) then
  begin
    Editor := GetActiveEditor;
    if Assigned(Editor) then
      Result := True;
  end;
end;

function TEBDocument.GetActiveDocumentName: string;
var
  Editor: TBCEditor;
begin
  Result := '';
  if Assigned(PageControl.ActivePage) then
  begin
    Editor := GetActiveEditor;
    if Assigned(Editor) then
      if Editor.DocumentName <> '' then
        Result := FormatFileName(Editor.DocumentName, Editor.Modified);
  end;
end;

function TEBDocument.GetOpenTabSheetCount: Integer;
begin
  Result := PageControl.PageCount - 1;
end;

function TEBDocument.GetModifiedDocuments(CheckActive: Boolean): Boolean;
var
  i: Integer;
  Editor: TBCEditor;
begin
  Result := True;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    if (TsTabSheet(PageControl.Pages[i]).TabType = ttTab) and TsTabSheet(PageControl.Pages[i]).TabVisible then
      if CheckActive or ((PageControl.ActivePageIndex <> i) and not CheckActive) then
      begin
        Editor := GetEditor(PageControl.Pages[i]);
        if Assigned(Editor) then
          if Editor.Modified then
            Exit;
      end;
  end;
  Result := False;
end;

function TEBDocument.GetSelectionFound: Boolean;
var
  Editor: TBCEditor;
begin
  Result := False;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Result := Editor.SelectionAvailable;

  Editor := GetActiveSplitEditor;
  if Assigned(Editor) then
    Result := Result or Editor.SelectionAvailable;
end;

function TEBDocument.GetCanUndo: Boolean;
var
  Editor: TBCEditor;
begin
  Result := False;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Result := Editor.UndoList.ItemCount > 0;

  Editor := GetActiveSplitEditor;
  if Assigned(Editor) then
    Result := Result or (Editor.UndoList.ItemCount > 0);
end;

function TEBDocument.GetCanRedo: Boolean;
var
  Editor: TBCEditor;
begin
  Result := False;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Result := Editor.RedoList.ItemCount > 0;

  Editor := GetActiveSplitEditor;
  if Assigned(Editor) then
    Result := Result or (Editor.RedoList.ItemCount > 0);
end;

procedure TEBDocument.EditorReplaceText(Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer;
  DeleteLine: Boolean; var Action: TBCEditorReplaceAction);
var
  ConfirmText: string;
begin
  if ASearch = AReplace then
    Action := raSkip
  else
  begin
    if DeleteLine then
      ConfirmText := LanguageDataModule.GetYesOrNoMessage('DeleteLine')
    else
      ConfirmText := Format(LanguageDataModule.GetYesOrNoMessage('ReplaceOccurence'), [ASearch, AReplace]);

    case TConfirmReplaceDialog.ClassShowModal(Application.MainForm, ConfirmText) of
      mrYes:
        Action := raReplace;
      mrYesToAll:
        Action := raReplaceAll;
      mrNo:
        Action := raSkip;
    else
      Action := raCancel;
    end;
  end;
end;

procedure TEBDocument.EditorCaretChanged(Sender: TObject; X, Y: Integer);
begin
  inherited;
  FCaretInfo := Format('%d: %d', [Y, X]);
  FStatusBar.Repaint;
end;

function TEBDocument.GetModifiedInfo: string;
var
  Editor: TBCEditor;
begin
  Result := '';
  if OptionsContainer.AutoSave then
    Result := LanguageDataModule.GetConstant('AutoSave')
  else
  begin
    Editor := GetActiveEditor;
    if Assigned(Editor) and Editor.Modified then
      Result := LanguageDataModule.GetConstant('Modified');
  end;
end;

function TEBDocument.GetActiveDocumentModified: Boolean;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  Result := Assigned(Editor) and Editor.Modified;
end;

procedure TEBDocument.NextPage;
var
  i: Integer;
begin
  if Assigned(PageControl) then
  begin
    i := PageControl.ActivePageIndex + 1;
    if i >= PageControl.PageCount - 1 then
      i := 0;
    PageControl.ActivePage := PageControl.Pages[i] as TsTabSheet;
  end;
end;

procedure TEBDocument.PreviousPage;
var
  i: Integer;
begin
  if Assigned(PageControl) then
  begin
    i := PageControl.ActivePageIndex - 1;
    if i < 0 then
      i := PageControl.PageCount - 2;
    PageControl.ActivePage := PageControl.Pages[i] as TsTabSheet;;
  end;
end;

procedure TEBDocument.CheckFileDateTimes;
var
  i: Integer;
  Editor: TBCEditor;
  FileDateTime: TDateTime;
  DialogResult: Integer;
begin
  DialogResult := mrNo;
  if FProcessing then
    Exit;
  FProcessing := True;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    Editor := GetEditor(PageControl.Pages[i]);
    if Assigned(Editor) then
      if Editor.DocumentName <> '' then
      begin
        FileDateTime := GetFileDateTime(Editor.DocumentName);
        if (FileDateTime <> 0) and (FileDateTime <> Editor.FileDateTime) then
        begin
          if FileExists(Editor.DocumentName) then
          begin
            PageControl.TabClosed := True; { just to avoid begin drag }
            if not(DialogResult in [mrYesToAll, mrNoToAll]) then
              DialogResult := AskYesOrNoAll(Format(LanguageDataModule.GetYesOrNoMessage('DocumentTimeChanged'),
                [Editor.DocumentName]));
            if DialogResult in [mrYes, mrYesToAll] then
              Refresh(i);
          end
          else
          begin
            if OptionsContainer.AutoSave then
              Save
            else
            begin
              Editor.Modified := True;
              PageControl.Pages[i].Caption := FormatFileName(PageControl.Pages[i].Caption, Editor.Modified);
              PageControl.Invalidate;
            end;
          end;
        end;
      end;
  end;
  FProcessing := False;
end;

procedure TEBDocument.Refresh(Page: Integer);
var
  Editor: TBCEditor;
begin
  Editor := GetEditor(PageControl.Pages[Page]);
  if Assigned(Editor) then
  begin
    Editor.LoadFromFile(Editor.DocumentName);
    Editor.FileDateTime := GetFileDateTime(Editor.DocumentName);
  end;
end;

procedure TEBDocument.DecreaseIndent;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.CommandProcessor(ecBlockUnindent, 'U', nil);
end;

procedure TEBDocument.IncreaseIndent;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.CommandProcessor(ecBlockIndent, 'I', nil);
end;

procedure TEBDocument.SelectAll;
var
  DocTabSheetFrame: TDocTabSheetFrame;

  procedure SelectAll(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.SelectAll;
  end;

begin
  DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
  if Assigned(DocTabSheetFrame) and DocTabSheetFrame.IsSearchFocused then
    DocTabSheetFrame.SearchSelectAll
  else
  begin
    SelectAll(GetActiveEditor);
    SelectAll(GetActiveSplitEditor);
  end;
end;

procedure TEBDocument.ToggleCase(ACase: TBCEditorCase = cNone);
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.ToggleSelectedCase(ACase);
  LEditor := GetActiveSplitEditor;
  if Assigned(LEditor) then
    LEditor.ToggleSelectedCase(ACase);
end;

procedure TEBDocument.DeleteWhiteSpace;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.DeleteWhiteSpace;
  LEditor := GetActiveSplitEditor;
  if Assigned(LEditor) then
    LEditor.DeleteWhiteSpace;
end;

procedure TEBDocument.Sort(ASortOrder: TBCEditorSortOrder = soToggle);
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.Sort(ASortOrder);
  LEditor := GetActiveSplitEditor;
  if Assigned(LEditor) then
    LEditor.Sort(ASortOrder);
end;

procedure TEBDocument.ClearBookmarks;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.ClearBookmarks;
  LEditor := GetActiveSplitEditor;
  if Assigned(LEditor) then
    LEditor.ClearBookmarks;
end;

procedure TEBDocument.InsertLine;

  procedure InsertLine(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.CommandProcessor(ecInsertLine, 'N', nil);
  end;

begin
  InsertLine(GetActiveEditor);
  InsertLine(GetActiveSplitEditor);
end;

procedure TEBDocument.DeleteWord;

  procedure DeleteWord(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.CommandProcessor(ecDeleteWord, 'T', nil);
  end;

begin
  DeleteWord(GetActiveEditor);
  DeleteWord(GetActiveSplitEditor);
end;

procedure TEBDocument.DeleteLine;

  procedure DeleteLine(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.CommandProcessor(ecDeleteLine, 'Y', nil);
  end;

begin
  DeleteLine(GetActiveEditor);
  DeleteLine(GetActiveSplitEditor);
end;

procedure TEBDocument.DeleteEndOfLine;

  procedure DeleteEndOfLine(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.CommandProcessor(ecDeleteEndOfLine, 'Y', nil);
  end;

begin
  DeleteEndOfLine(GetActiveEditor);
  DeleteEndOfLine(GetActiveSplitEditor);
end;

procedure TEBDocument.ShowInfo;
var
  Editor: TBCEditor;

  function LengthWithoutWhiteSpaces(Str: string): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to Length(Str) do
      if Trim(Str[i]) <> '' then
        Inc(Result);
  end;

begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    ShowMessage(Format(LanguageDataModule.GetMessage('DocumentStatistics'), [Editor.Lines.Count, CHR_ENTER,
      WordCount(Editor.Text), CHR_ENTER, LengthWithoutWhiteSpaces(Editor.Text)]));
end;

function TEBDocument.GetMacroRecordPauseImageIndex: Integer;
var
  Editor: TBCEditor;
begin
  Result := IMAGE_INDEX_RECORD;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    if Assigned(Editor.MacroRecorder) then
      if Editor.MacroRecorder.State = msRecording then
        Result := IMAGE_INDEX_PAUSE
end;

function TEBDocument.IsRecordingMacro: Boolean;
var
  Editor: TBCEditor;
begin
  Result := False;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    if Assigned(Editor.MacroRecorder) then
      Result := Editor.MacroRecorder.State = msRecording
end;

procedure TEBDocument.SetHighlighter(AHighlighterName: string);
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    with Editor do
    begin
      Highlighter.LoadFromFile(Format('%s.json', [AHighlighterName]));
      CodeFolding.Visible := OptionsContainer.ShowCodeFolding and (Editor.Highlighter.CodeFoldingRegions.Count > 0);
      Invalidate;
    end;
end;

procedure TEBDocument.UpdateHighlighterColors;
var
  i: Integer;
  Editor: TBCEditor;
begin
  for i := 0 to PageControl.PageCount - 2 do
  begin
    Editor := GetEditor(PageControl.Pages[i]);
    if Assigned(Editor) then
    begin
      Editor.Highlighter.Colors.LoadFromFile(Editor.Highlighter.Colors.FileName);
      SetSkinColors(Editor);
    end;
  end;
  Invalidate;
end;

procedure TEBDocument.SetSkinColors(Editor: TBCEditor);
var
  i: Integer;
  LColor: TColor;
begin
  LColor := FrameAdapter.SkinData.SkinManager.GetActiveEditColor;
  if OptionsContainer.SkinActiveLineBackground then
    Editor.ActiveLine.Color := FrameAdapter.SkinData.SkinManager.GetHighLightColor(False);
  if OptionsContainer.SkinBackground then
    Editor.BackgroundColor := LColor;
  if OptionsContainer.SkinCodeFoldingBackground then
    Editor.CodeFolding.Colors.Background := LColor;
  if OptionsContainer.SkinCodeFoldingHintBackground then
    Editor.CodeFolding.Hint.Colors.Background := LColor;
  if OptionsContainer.SkinCompletionProposalBackground then
    Editor.CompletionProposal.Colors.Background := LColor;
  if OptionsContainer.SkinCompletionProposalSelectionBackground then
    Editor.CompletionProposal.Colors.SelectedBackground := LColor;
  if OptionsContainer.SkinLeftMarginBackground then
    Editor.LeftMargin.Colors.Background := LColor;
  if OptionsContainer.SkinBookmarkPanelBackground then
    Editor.LeftMargin.Colors.BookmarkPanelBackground := LColor;
  if OptionsContainer.SkinSelectionForeground then
    Editor.Selection.Colors.Foreground := FrameAdapter.SkinData.SkinManager.GetHighLightFontColor;
  if OptionsContainer.SkinSelectionBackground then
    Editor.Selection.Colors.Background := FrameAdapter.SkinData.SkinManager.GetHighLightColor;
  for i := 0 to Editor.Highlighter.Colors.Styles.Count - 1 do
    if PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Name = 'Editor' then
    begin
      if OptionsContainer.SkinForeground then
        PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Foreground :=
          FrameAdapter.SkinData.SkinManager.GetActiveEditFontColor;
      if OptionsContainer.SkinBackground then
        PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Background := LColor;
      Break;
    end;
  Editor.Highlighter.UpdateColors;
end;

procedure TEBDocument.SetHighlighterColor(AColorName: string);
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    with Editor do
    begin
      Highlighter.Colors.LoadFromFile(Format('%s.json', [AColorName]));
      SetSkinColors(Editor);
      Invalidate;
    end;
end;

function TEBDocument.IsMacroStopped: Boolean;
var
  Editor: TBCEditor;
begin
  Result := False;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    if Assigned(Editor.MacroRecorder) then
      Result := Editor.MacroRecorder.State = msStopped
end;

procedure TEBDocument.RecordMacro;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    if not Assigned(Editor.MacroRecorder) then
    begin
      Editor.MacroRecorder := TBCEditorMacroRecorder.Create(Editor);
      Editor.MacroRecorder.RecordMacro(Editor);
    end
    else if Editor.MacroRecorder.State = msStopped then
    begin
      if AskYesOrNo(LanguageDataModule.GetYesOrNoMessage('RecordMacro')) then
      begin
        Editor.MacroRecorder.Clear;
        Editor.MacroRecorder.RecordMacro(Editor);
      end;
    end
    else if Editor.MacroRecorder.State = msRecording then
      Editor.MacroRecorder.Pause
    else if Editor.MacroRecorder.State = msPaused then
      Editor.MacroRecorder.Resume
  end;
end;

procedure TEBDocument.StopMacro;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    if Assigned(Editor.MacroRecorder) then
      Editor.MacroRecorder.Stop;
  end;
end;

procedure TEBDocument.PlaybackMacro;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    if Assigned(Editor.MacroRecorder) then
      Editor.MacroRecorder.PlaybackMacro(Editor);
  end;
end;

procedure TEBDocument.SaveMacro;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    if Assigned(Editor.MacroRecorder) then
    begin
      SaveDialog.InitialDir := '';
      SaveDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('Macro'), '|', #0, [rfReplaceAll]
        )) + #0#0;
      SaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
      SaveDialog.FileName := '';
      SaveDialog.DefaultExt := 'mcr';
      if SaveDialog.Execute(Handle) then
        Editor.MacroRecorder.SaveToFile(SaveDialog.Files[0]);
    end;
end;

procedure TEBDocument.LoadMacro;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    OpenDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('Macro'), '|', #0, [rfReplaceAll])) + #0#0;
    OpenDialog.Title := LanguageDataModule.GetConstant('Open');
    OpenDialog.DefaultExt := 'mcr';
    if OpenDialog.Execute(Handle) then
    begin
      if not Assigned(Editor.MacroRecorder) then
        Editor.MacroRecorder := TBCEditorMacroRecorder.Create(Editor);
      Editor.MacroRecorder.LoadFromFile(OpenDialog.Files[0]);
    end;
  end;
end;

procedure TEBDocument.FileProperties;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    FilePropertiesDialog(Editor.DocumentName);
end;

procedure TEBDocument.SetActiveEncoding(Value: Integer);
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    with Editor do
    begin
      case Value of
        ENCODING_ANSI:
          Encoding := TEncoding.ANSI;
        ENCODING_ASCII:
          Encoding := TEncoding.ASCII;
        ENCODING_BIG_ENDIAN_UNICODE:
          Encoding := TEncoding.BigEndianUnicode;
        ENCODING_UNICODE:
          Encoding := TEncoding.Unicode;
        ENCODING_UTF7:
          Encoding := TEncoding.UTF7;
        ENCODING_UTF8:
          Encoding := TEncoding.UTF8;
        ENCODING_UTF_WITHOUT_BOM:
          Encoding := TEncoding.UTF8WithoutBOM;
      end;
    end;
end;

function TEBDocument.GetSplitChecked: Boolean;
var
  DocTabSheetFrame: TDocTabSheetFrame;
begin
  Result := False;
  DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
  if Assigned(DocTabSheetFrame) then
    Result := DocTabSheetFrame.SplitVisible;
end;

function TEBDocument.GetMinimapChecked: Boolean;
var
  DocTabSheetFrame: TDocTabSheetFrame;
begin
  Result := False;
  DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
  if Assigned(DocTabSheetFrame) then
    Result := DocTabSheetFrame.MinimapVisible;
end;

procedure TEBDocument.ToggleSplit;
var
  DocTabSheetFrame: TDocTabSheetFrame;
begin
  DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
  if Assigned(DocTabSheetFrame) then
  begin
    DocTabSheetFrame.SplitVisible := not DocTabSheetFrame.SplitVisible;
    Invalidate;
  end;
end;

procedure TEBDocument.ToggleMiniMap;
var
  DocTabSheetFrame: TDocTabSheetFrame;
begin
  DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
  if Assigned(DocTabSheetFrame) then
    DocTabSheetFrame.MinimapVisible := not DocTabSheetFrame.MinimapVisible;
end;

{function TEBDocument.IsCompareFilesActivePage: Boolean;
begin
  Result := Assigned(PageControl.ActivePage) and (PageControl.ActivePage.ImageIndex = FCompareImageIndex);
end; }

procedure TEBDocument.UpdateLanguage(SelectedLanguage: string);
var
  i: Integer;
  CompareFrame: TCompareFrame;
  DocTabSheetFrame: TDocTabSheetFrame;
begin
  BCCommon.Language.Utils.UpdateLanguage(TForm(Self), SelectedLanguage);

  { compare frames }
  for i := 0 to PageControl.PageCount - 2 do
  begin
    if PageControl.Pages[i].ImageIndex = FCompareImageIndex then
    begin
      CompareFrame := GetCompareFrame(PageControl.Pages[i]);
      if Assigned(CompareFrame) then
        CompareFrame.UpdateLanguage(SelectedLanguage);
    end
    else
    begin
      DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
      if Assigned(DocTabSheetFrame) then
        DocTabSheetFrame.UpdateLanguage(SelectedLanguage);
    end;
  end;
end;

procedure TEBDocument.FormatXML;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    Editor.BeginUndoBlock;
    try
      Editor.SelectAll;
      Editor.SelectedText := BCCommon.StringUtils.FormatXML(Editor.Text);
    finally
      Editor.EndUndoBlock;
      Editor.SetFocus;
    end;
  end;
end;

procedure TEBDocument.FormatSQL;
var
  Editor: TBCEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    if Trim(Editor.Text) <> '' then
      Editor.Text := BCCommon.SQL.Formatter.FormatSQL(Editor.Text,
        TSQLDatabase(SQLFormatterOptionsContainer.SQLDatabase));
end;

function TEBDocument.IsXMLDocument: Boolean;
var
  DocTabSheetFrame: TDocTabSheetFrame;
begin
  Result := False;
  DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
  if Assigned(DocTabSheetFrame) then
    Result := Assigned(DocTabSheetFrame.Editor.Highlighter) and
      (Pos('XML', DocTabSheetFrame.Editor.Highlighter.FileName) <> 0)
end;

function TEBDocument.IsSQLDocument: Boolean;
var
  DocTabSheetFrame: TDocTabSheetFrame;
begin
  Result := False;
  DocTabSheetFrame := GetDocTabSheetFrame(PageControl.ActivePage);
  if Assigned(DocTabSheetFrame) then
    Result := Assigned(DocTabSheetFrame.Editor.Highlighter) and
      (Pos('SQL', DocTabSheetFrame.Editor.Highlighter.FileName) <> 0)
end;

procedure TEBDocument.SelectHighlighter(FileName: string);
var
  Ext, ItemString, Token: string;
  i: Integer;
begin
  Ext := '*' + LowerCase(ExtractFileExt(FileName));

  for i := 0 to OptionsContainer.FileTypes.Count - 1 do
  begin
    ItemString := StringBetween(OptionsContainer.FileTypes.Values[OptionsContainer.FileTypes.Names[i]], '(', ')');
    while ItemString <> '' do
    begin
      Token := GetNextToken(';', ItemString);
      ItemString := RemoveTokenFromStart(';', ItemString);
      if Ext = Token then
      begin
        if Pos('SQL', OptionsContainer.FileTypes.Names[i]) <> 0 then
          SetHighlighter(OptionsContainer.DefaultSQLHighlighter)
        else
          SetHighlighter(OptionsContainer.FileTypes.Names[i]);
        Exit;
      end;
    end;
  end;
  SetHighlighter(OptionsContainer.DefaultHighlighter);
end;

function TEBDocument.GetActiveBookmarkList: TBCEditorBookmarkList;
var
  Editor: TBCEditor;
begin
  Result := nil;
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Result := Editor.Marks;
end;

(*
function TDocTabSheetFrame.GetSearchFrame: TBCSearchFrame;
begin
  if not Assigned(FSearchFrame) then
  begin
    FSearchFrame := TBCSearchFrame.Create(PanelSearchFrame);
    FSearchFrame.Align := alClient;
    FSearchFrame.AlignWithMargins := True;
    FSearchFrame.Margins.Left := 2;
    FSearchFrame.Margins.Top := 0;
    FSearchFrame.Margins.Right := 0;
    FSearchFrame.Margins.Bottom := 0;
    FSearchFrame.Parent := PanelSearchFrame;
    FSearchFrame.Editor := Editor;
    FSearchFrame.OnSearchText := DoOnSearchText;
    { IDE losing these }
    FSearchFrame.ActionList.Images := ImagesDataModule.ImageListSmall;
    FSearchFrame.SpeedButtonFindPrevious.Images := ImagesDataModule.ImageListSmall;
    FSearchFrame.SpeedButtonFindNext.Images := ImagesDataModule.ImageListSmall;
    FSearchFrame.SpeedButtonOptions.Images := ImagesDataModule.ImageListSmall;
  end;
  Result := FSearchFrame;
end;

procedure TDocTabSheetFrame.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  PanelSearchFrame.Visible := Editor.Search.Enabled;

  if not PanelSearchFrame.Visible and Assigned(FSearchFrame) then
  begin
    FSearchFrame.Free;
    FSearchFrame := nil;
  end;
end;

constructor TDocTabSheetFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FModified := False;
end;

procedure TDocTabSheetFrame.DoOnSearchText(Sender: TObject);
begin
  OptionsContainer.DocumentSpecificSearchText := '';
  if OptionsContainer.DocumentSpecificSearch then
    OptionsContainer.DocumentSpecificSearchText := Editor.Search.SearchText
end;

destructor TDocTabSheetFrame.Destroy;
begin
  if Assigned(FDocumentXMLTreeFrame) then
    FDocumentXMLTreeFrame.Free;
  inherited;
end;

procedure TDocTabSheetFrame.UpdateLanguage(SelectedLanguage: string);
begin
  BCCommon.Language.Utils.UpdateLanguage(TForm(Self), SelectedLanguage);
end;

function TDocTabSheetFrame.IsSearchFocused: Boolean;
begin
  Result := Assigned(FSearchFrame) and FSearchFrame.ComboBoxSearchText.Focused;
end;

procedure TDocTabSheetFrame.SearchSelectAll;
begin
  if Assigned(FSearchFrame) then
    FSearchFrame.ComboBoxSearchText.SelectAll;
end;

procedure TDocTabSheetFrame.EditorEnter(Sender: TObject);
begin
  if Assigned(FSearchFrame) then
    FSearchFrame.Editor := Editor;
end;

procedure TDocTabSheetFrame.EditorRightMarginMouseUp(Sender: TObject);
begin
  OptionsContainer.RightMarginPosition := Editor.RightMargin.Position;
  if Assigned(FEditorSplit) then
    FEditorSplit.RightMargin.Position := Editor.RightMargin.Position;
end;

procedure TDocTabSheetFrame.SplitEditorRightMarginMouseUp(Sender: TObject);
begin
  if Assigned(FEditorSplit) then
  begin
    OptionsContainer.RightMarginPosition := FEditorSplit.RightMargin.Position;
    Editor.RightMargin.Position := FEditorSplit.RightMargin.Position;
  end;
end;

procedure TDocTabSheetFrame.RefreshActionExecute(Sender: TObject);
begin
  LoadFromXML(Editor.Text);
end;

procedure TDocTabSheetFrame.LoadFromXML(XML: string);
begin
  if Assigned(FDocumentXMLTreeFrame) then
    FDocumentXMLTreeFrame.LoadFromXML(XML);
end;

function TDocTabSheetFrame.GetSplitVisible: Boolean;
begin
  Result := Assigned(FEditorSplit) and FEditorSplit.Visible;
end;

procedure TDocTabSheetFrame.SetSplitVisible(Value: Boolean);
begin
  if Value then
  begin
    FEditorSplit := TBCEditor.Create(PanelDocument);
    FEditorSplit.Visible := False;
    FEditorSplit.Align := alBottom;
    FEditorSplit.AlignWithMargins := True;
    FEditorSplit.Margins.Left := 1;
    FEditorSplit.Margins.Top := 0;
    FEditorSplit.Margins.Right := 2;
    FEditorSplit.Margins.Bottom := 0;
    FEditorSplit.Parent := PanelDocument;
    FEditorSplit.Width := 0; { avoid flickering }

    OptionsContainer.AssignTo(FEditorSplit);
    FEditorSplit.Highlighter.LoadFromFile(Editor.Highlighter.FileName);
    FEditorSplit.Highlighter.Colors.LoadFromFile(Editor.Highlighter.Colors.FileName);
    FEditorSplit.ChainEditor(Editor);
    FEditorSplit.InitCodeFolding;

    FEditorSplit.Visible := True;
    SplitterHorizontal.Visible := True;
    SplitterHorizontal.Top := FEditorSplit.Top - 1; { splitter always above }
  end
  else
  begin
    FEditorSplit.RemoveChainedEditor;
    FEditorSplit.Visible := False;
    SplitterHorizontal.Visible := False;
    FEditorSplit.Parent := nil;
    FEditorSplit.Free;
    FEditorSplit := nil;
  end;
end;

function TDocTabSheetFrame.GetEditorSplit: TBCEditor;
begin
  Result := nil;
  if Assigned(FEditorSplit) then
    Result := FEditorSplit
end;*)

end.