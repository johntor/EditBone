unit EditBone.Document;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, EditBone.Consts, BCEditor.Editor,
  Vcl.ComCtrls, Vcl.ImgList, Vcl.Menus, BCControl.PageControl, Vcl.Buttons, Vcl.ActnList,
  BCControl.ProgressBar, BCControl.Panel, sLabel, sPageControl, BCEditor.Types, BCControl.StatusBar,
  BCEditor.MacroRecorder, BCEditor.Print, BCEditor.Editor.Bookmarks, Vcl.Dialogs, BCCommon.Frame.Compare,
  BCEditor.Print.Types, EditBone.XMLTree, BCControl.Splitter, BCControl.ComboBox, System.Generics.Collections,
  BCComponent.SkinManager, BCControl.Labels;

type
  TEBSetBookmarks = procedure of object;
  TEBSetTitleBarMenuCaptions = procedure of object;
  TEBCreateFileReopenList = procedure of object;
  TEBGetActionList = function: TObjectList<TAction> of object;

  TEBDocument = class(TObject)
    procedure ComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint);
    procedure ComboBoxSearchTextChange(Sender: TObject);
    procedure ComboBoxSearchTextKeyPress(Sender: TObject; var Key: Char);
    procedure DropFiles(Sender: TObject; Pos: TPoint; AFiles: TStrings);
    procedure EditorAfterBookmarkPlaced(Sender: TObject);
    procedure EditorAfterClearBookmark(Sender: TObject);
    procedure EditorCaretChanged(Sender: TObject; X, Y: Integer);
    procedure EditorOnChange(Sender: TObject);
    procedure EditorReplaceText(Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; DeleteLine: Boolean; var Action: TBCEditorReplaceAction);
    procedure XMLTreeClick(Sender: TObject);
  private
    FActionSearchClose: TAction;
    FActionSearchFindNext: TAction;
    FActionSearchFindPrevious: TAction;
    FActionSearchOptions: TAction;
    FActionSearchTextItems: TAction;
    FCaretInfo: string;
    FCompareImageIndex, FNewImageIndex: Integer;
    FCreateFileReopenList: TEBCreateFileReopenList;
    FGetActionList: TEBGetActionList;
    FImages: TImageList;
    FModifiedDocuments: Boolean;
    FNumberOfNewDocument: Integer;
    FOpenDialog: TOpenDialog;
    FPageControl: TBCPageControl;
    FPopupMenuEditor: TPopupMenu;
    FPopupMenuXMLTree: TPopupMenu;
    FProcessing: Boolean;
    FProgressBar: TBCProgressBar;
    FSaveDialog: TSaveDialog;
    FSetBookmarks: TEBSetBookmarks;
    FSetTitleBarMenuCaptions: TEBSetTitleBarMenuCaptions;
    FSkinManager: TBCSkinManager;
    FStatusBar: TBCStatusBar;
    FTabSheetNew: TTabSheet;
    function CreateNewTabSheet(const AFileName: string = ''; AShowMinimap: Boolean = False;
      const AHighlighter: string = ''; const AColor: string = ''; ASetActivePage: Boolean = True): TBCEditor;
    function FindOpenFile(const FileName: string): TBCEditor;
    function GetActiveDocumentModified: Boolean;
    function GetActiveDocumentName: string;
    function GetActiveFileName: string;
    function GetActiveLabelSearchResultCount: TsLabel;
    function GetActivePageCaption: string;
    function GetActiveSearchPanel: TBCPanel;
    function GetActiveTabSheetCaption: string;
    function GetCanRedo: Boolean;
    function GetCanUndo: Boolean;
    function GetComboBoxSearchText(const ATabSheet: TTabSheet): TBCComboBox;
    function GetCompareFrame(TabSheet: TTabSheet): TCompareFrame;
    function GetModifiedDocuments(CheckActive: Boolean = True): Boolean;
    function GetSearchPanel(const ATabSheet: TTabSheet): TBCPanel;
    function GetSplitter(const ATabSheet: TTabSheet; const ATag: Integer): TBCSplitter;
    function GetXMLTree(const ATabSheet: TTabSheet): TEBXMLTree;
    function GetXMLTreeVisible: Boolean;
    function Save(TabSheet: TTabSheet; ShowDialog: Boolean = False): string; overload;
    function SetDocumentSpecificSearchText(AEditor: TBCEditor): Boolean;
    procedure AddToReopenFiles(const FileName: string);
    procedure CheckModifiedDocuments;
    procedure CreateImageList;
    procedure CreateSearchPanel(ATabSheet: TsTabSheet);
    procedure SelectHighlighter(AEditor: TBCEditor; const FileName: string);
    procedure SetActiveEditorFocus;
    procedure SetActivePageCaptionModified(AModified: Boolean);
    procedure SetEditorBookmarks(Editor: TBCEditor; Bookmarks: TStrings);
    procedure SetSearchMatchesFound;
    procedure SetSkinColors(Editor: TBCEditor);
  public
    constructor Create(AOwner: TBCPageControl);
    destructor Destroy; override;
    function Close(AFreePage: Boolean = True; ATabIndex: Integer = -1): Integer;
    function GetActiveBookmarkList: TBCEditorBookmarkList;
    function GetActiveComboBoxSearchText: TBCComboBox;
    function GetActiveEditor: TBCEditor;
    function GetActiveSplitEditor: TBCEditor;
    function GetEditor(const ATabSheet: TTabSheet; const ATag: Integer = EDITBONE_DOCUMENT_EDITOR_TAG): TBCEditor;
    function GetMacroRecordPauseImageIndex: Integer;
    function GetModifiedInfo(AEditor: TBCEditor): string;
    function Options(AActionList: TActionList): Boolean;
    function ReadIniOpenFiles: Boolean;
    function SaveAs: string;
    function SearchPanelVisible: Boolean;
    function ToggleLineNumbers: Boolean;
    function ToggleSearch(AShowPanel: Boolean = False): Boolean;
    function ToggleSpecialChars: Boolean;
    function ToggleWordWrap: Boolean;
    function ToggleXMLTree: Boolean;
    procedure CheckFileDateTimes;
    procedure ClearBookmarks;
    procedure CloseAll;
    procedure CloseAllOtherPages;
    procedure CollapseAll;
    procedure CompareFiles(AFileName: string = ''; AFileDragDrop: Boolean = False);
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
    procedure FormatJSON(AIndentSize: Integer);
    procedure FormatSQL;
    procedure FormatXML;
    procedure GotoBookmarks(ItemIndex: Integer);
    procedure GotoLine;
    procedure IncreaseIndent;
    procedure InitializeEditorPrint(EditorPrint: TBCEditorPrint);
    procedure InsertDateAndTime;
    procedure InsertLine;
    procedure InsertTag;
    procedure LoadMacro;
    procedure New;
    procedure NextPage;
    procedure Open(const FileName: string = ''; Bookmarks: TStrings = nil; ALine: Integer = 0; AChar: Integer = 0;
      StartUp: Boolean = False; ShowMinimap: Boolean = False; const AHighlighter: string = ''; const AColor: string = '';
      ASetActivePage: Boolean = True); overload;
    procedure Open(const Filename: string; ALine: Integer; AChar: Integer); overload;
    procedure Open(const Filename: string; ASetActivePage: Boolean); overload;
    procedure Paste;
    procedure PlaybackMacro;
    procedure PreviousPage;
    procedure PrintPreview;
    procedure RecordMacro;
    procedure Redo;
    procedure Refresh(Page: Integer);
    procedure RefreshXMLTree;
    procedure Replace;
    procedure Save; overload;
    procedure SaveAll;
    procedure SaveMacro;
    procedure SearchClose;
    procedure SearchOptions;
    procedure SelectAll;
    procedure SelectForCompare;
    procedure SetHighlighter(AEditor: TBCEditor; const AHighlighterName: string);
    procedure SetHighlighterColor(AEditor: TBCEditor; const AColorName: string);
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
    procedure WriteIniFile;
    property ActionSearchClose: TAction read FActionSearchClose write FActionSearchClose;
    property ActionSearchFindNext: TAction read FActionSearchFindNext write FActionSearchFindNext;
    property ActionSearchFindPrevious: TAction read FActionSearchFindPrevious write FActionSearchFindPrevious;
    property ActionSearchOptions: TAction read FActionSearchOptions write FActionSearchOptions;
    property ActionSearchTextItems: TAction read FActionSearchTextItems write FActionSearchTextItems;
    property ActiveDocumentModified: Boolean read GetActiveDocumentModified;
    property ActiveDocumentName: string read GetActiveDocumentName;
    property ActiveFileName: string read GetActiveFileName;
    property ActiveTabSheetCaption: string read GetActiveTabSheetCaption;
    property CanRedo: Boolean read GetCanRedo;
    property CanUndo: Boolean read GetCanUndo;
    property CaretInfo: string read FCaretInfo;
    property CreateFileReopenList: TEBCreateFileReopenList read FCreateFileReopenList write FCreateFileReopenList;
    property GetActionList: TEBGetActionList read FGetActionList write FGetActionList;
    property ModifiedDocuments: Boolean read FModifiedDocuments write FModifiedDocuments;
    property OpenDialog: TOpenDialog read FOpenDialog write FOpenDialog;
    property PageControl: TBCPageControl read FPageControl;
    property PopupMenuEditor: TPopupMenu read FPopupMenuEditor write FPopupMenuEditor;
    property PopupMenuXMLTree: TPopupMenu read FPopupMenuXMLTree write FPopupMenuXMLTree;
    property Processing: Boolean read FProcessing;
    property ProgressBar: TBCProgressBar read FProgressBar write FProgressBar;
    property SaveDialog: TSaveDialog read FSaveDialog write FSaveDialog;
    property SetBookmarks: TEBSetBookmarks read FSetBookmarks write FSetBookmarks;
    property SetTitleBarMenuCaptions: TEBSetTitleBarMenuCaptions read FSetTitleBarMenuCaptions write FSetTitleBarMenuCaptions;
    property SkinManager: TBCSkinManager read FSkinManager write FSkinManager;
    property StatusBar: TBCStatusBar write FStatusBar;
    property XMLTreeVisible: Boolean read GetXMLTreeVisible;
  end;

implementation

{$R EDITBONE.DOCUMENT.RES}

uses
  Vcl.Forms, BCCommon.Form.Print.Preview, BCCommon.Options.Container, BCCommon.Dialog.ConfirmReplace,
  System.Types, BigIni, BCCommon.Language.Strings, VirtualTrees,  BCCommon.Dialog.InputQuery, BCCommon.Dialog.Replace,
  BCCommon.FileUtils, BCCommon.Messages, BCCommon.Utils, BCCommon.StringUtils, Winapi.CommCtrl, EditBone.Form.Options,
  BCCommon.Images, System.IniFiles, BCCommon.SQL.Formatter, BCEditor.Editor.KeyCommands, EditBone.DataModule.Images,
  BCControl.SpeedButton, BCControl.Utils, BCEditor.Editor.Utils, BCCommon.Consts, BCEditor.Encoding, Vcl.Clipbrd,
  BCEditor.Highlighter.Colors, BCCommon.Dialog.Options.Search, Vcl.ValEdit, System.IOUtils, EditBone.Encoding;

{ TEBDocument }

constructor TEBDocument.Create(AOwner: TBCPageControl);
begin
  inherited Create;
  FPageControl := AOwner;

  FNumberOfNewDocument := 0;
  FProcessing := False;
  FModifiedDocuments := False;

  FTabSheetNew := AOwner.Pages[0];

  CreateImageList;
  SetOptions;
end;

destructor TEBDocument.Destroy;
begin
  if Assigned(FImages) then
    FImages.Free;

  inherited Destroy;
end;

procedure TEBDocument.RefreshXMLTree;
var
  LEditor: TBCEditor;
  LXMLTree: TEBXMLTree;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
  begin
    LXMLTree := GetXMLTree(PageControl.ActivePage);
    if Assigned(LXMLTree) then
      LXMLTree.LoadFromXML(LEditor.Text);
  end;
end;

procedure TEBDocument.XMLTreeClick(Sender: TObject);
var
  LEditor: TBCEditor;
  LXMLTree: TEBXMLTree;
  LData: PXMLTreeRec;
  LNode: PVirtualNode;
begin
  LEditor := GetActiveEditor;
  LXMLTree := GetXMLTree(PageControl.ActivePage);
  if Assigned(LEditor) and Assigned(LXMLTree) then
  begin
    LNode := LXMLTree.GetFirstSelected;
    if Assigned(LNode) then
    begin
      LData := LXMLTree.GetNodeData(LXMLTree.GetFirstSelected);
      LEditor.TextCaretPosition := GetTextPosition(LData.BlockBegin.Char, LData.BlockBegin.Line);
      LEditor.EnsureCursorPositionVisible(True);
      LEditor.SelectionBeginPosition := LData.BlockBegin;
      LEditor.SelectionEndPosition := LData.BlockEnd;
    end;
  end;
end;

function TEBDocument.ToggleXMLTree: Boolean;
var
  LEditor: TBCEditor;
  LXMLTree: TEBXMLTree;
  LVerticalSplitter: TBCSplitter;
begin
  Result := False;

  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    if Pos('XML', LEditor.Highlighter.FileName) <> 0 then
    begin
      LXMLTree := GetXMLTree(PageControl.ActivePage);
      if not Assigned(LXMLTree) then
      begin
        LXMLTree := TEBXMLTree.Create(PageControl.ActivePage);
        LXMLTree.Align := alLeft;
        LXMLTree.AlignWithMargins := True;
        LXMLTree.Margins.Left := 2;
        LXMLTree.Margins.Top := 2;
        LXMLTree.Margins.Right := 0;
        LXMLTree.Margins.Bottom := 2;
        LEditor.Margins.Left := 0;
        LXMLTree.ProgressBar := FProgressBar;
        LXMLTree.Editor := LEditor;
        LXMLTree.Images := EBDataModuleImages.ImageListXMLTree;
        LXMLTree.PopupMenu := FPopupMenuXMLTree;
        LXMLTree.Parent := PageControl.ActivePage;
        LXMLTree.LoadFromXML(LEditor.Text);
        LXMLTree.TreeOptions.SelectionOptions := [];
        LXMLTree.Tag := EDITBONE_DOCUMENT_XML_TREE_TAG;
        LXMLTree.TreeOptions.SelectionOptions := [toFullRowSelect];
        LXMLTree.TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale];
        LXMLTree.TreeOptions.MiscOptions := [toFullRepaintOnResize, toToggleOnDblClick, toWheelPanning];
        LXMLTree.TreeOptions.PaintOptions := [toHideFocusRect, toShowButtons, toShowDropmark, toShowRoot, toThemeAware];
        LXMLTree.OnClick := XMLTreeClick;
        { vertical splitter }
        LVerticalSplitter := TBCSplitter.Create(PageControl.ActivePage);
        LVerticalSplitter.Parent := PageControl.ActivePage;
        LVerticalSplitter.Align := alLeft;
        LVerticalSplitter.Tag := EDITBONE_DOCUMENT_VERTICAL_SPLITTER_TAG;
        LVerticalSplitter.Left := LXMLTree.Left + 1; { splitter always right }
      end
      else
      begin
        LEditor.Margins.Left := 2;
        LXMLTree.Free;
        LXMLTree := nil;
        { horizontal splitter }
        LVerticalSplitter := GetSplitter(PageControl.ActivePage, EDITBONE_DOCUMENT_VERTICAL_SPLITTER_TAG);
        LVerticalSplitter.Parent := nil;
        LVerticalSplitter.Free;
      end;
      Result := Assigned(LXMLTree);
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

procedure TEBDocument.CreateSearchPanel(ATabSheet: TsTabSheet);
var
  LPanelSearch: TBCPanel;
  LComboBoxSearchText: TBCComboBox;
  LItems: TStrings;
  LSplitter: TBCSplitter;
  LSpeedButton: TBCSpeedButton;
  LLabel: TsLabel;
  LBitmap: TBitmap;
begin
  LPanelSearch := TBCPanel.Create(ATabSheet);
  with LPanelSearch do
  begin
    Align := alBottom;
    AlignWithMargins := True;
    BevelOuter := bvNone;
    Caption := '';
    Margins.Left := 2;
    Margins.Top := 2;
    Margins.Right := 2;
    Margins.Bottom := 2;
    AutoSize := True;
    Height := 21;
    Visible := OptionsContainer.SearchVisible;
    Parent := ATabSheet;
    Tag := EDITBONE_DOCUMENT_SEARCH_PANEL_TAG;
  end;
  LComboBoxSearchText := TBCComboBox.Create(ATabSheet);
  with LComboBoxSearchText do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Width := 200;
    VerticalAlignment := taAlignTop;
    UseMouseWheel := False;
    Tag := EDITBONE_DOCUMENT_COMBOBOX_SEARCH_TEXT_TAG;
    OnChange := ComboBoxSearchTextChange;
    OnKeyPress := ComboBoxSearchTextKeyPress;
    OnKeyDown := ComboBoxKeyDown;
    OnMouseWheel := ComboBoxMouseWheel;
    LItems := TStringList.Create;
  end;
  with TIniFile.Create(GetIniFilename) do
  try
    ReadSectionValues('SearchItems', LItems);
    InsertItemsToComboBox(LItems, LComboBoxSearchText);
  finally
    LItems.Free;
    Free;
  end;
  LSplitter := TBCSplitter.Create(ATabSheet);
  with LSplitter do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Left := LComboBoxSearchText.Width + 1;
  end;
  LSpeedButton := TBCSpeedButton.Create(ATabSheet);
  with LSpeedButton do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Width := 21;
    ShowCaption := False;
    Left := LSplitter.Left + 1;
    SkinData.SkinSection := 'TOOLBUTTON';
    OnClick := ActionSearchTextItems.OnExecute;
    ImageIndex := ActionSearchTextItems.ImageIndex;
    Hint := ActionSearchTextItems.Hint;
    Images := ImagesDataModule.ImageListSmall;
  end;
  LSpeedButton := TBCSpeedButton.Create(ATabSheet);
  with LSpeedButton do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Width := 10;
    ButtonStyle := tbsDivider;
    Left := LSplitter.Left + LSplitter.Width + 22;
  end;
  LSpeedButton := TBCSpeedButton.Create(ATabSheet);
  with LSpeedButton do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Width := 21;
    ShowCaption := False;
    Left := LSplitter.Left + LSplitter.Width + 32;
    SkinData.SkinSection := 'TOOLBUTTON';
    OnClick := ActionSearchFindPrevious.OnExecute;
    ImageIndex := ActionSearchFindPrevious.ImageIndex;
    Hint := ActionSearchFindPrevious.Hint;
    Images := ImagesDataModule.ImageListSmall;
  end;
  LSpeedButton := TBCSpeedButton.Create(ATabSheet);
  with LSpeedButton do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Width := 21;
    ShowCaption := False;
    Left := LSplitter.Left + LSplitter.Width + 53;
    SkinData.SkinSection := 'TOOLBUTTON';
    OnClick := ActionSearchFindNext.OnExecute;
    ImageIndex := ActionSearchFindNext.ImageIndex;
    Hint := ActionSearchFindNext.Hint;
    Images := ImagesDataModule.ImageListSmall;
  end;
  LSpeedButton := TBCSpeedButton.Create(ATabSheet);
  with LSpeedButton do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Width := 10;
    ButtonStyle := tbsDivider;
    Left := LSplitter.Left + LSplitter.Width + 74;
  end;
  LSpeedButton := TBCSpeedButton.Create(ATabSheet);
  with LSpeedButton do
  begin
    Align := alLeft;
    Parent := LPanelSearch;
    Width := 21;
    ShowCaption := False;
    Left := LSplitter.Left + LSplitter.Width + 84;
    SkinData.SkinSection := 'TOOLBUTTON';
    OnClick := ActionSearchOptions.OnExecute;
    ImageIndex := ActionSearchOptions.ImageIndex;
    Hint := ActionSearchOptions.Hint;
    Images := ImagesDataModule.ImageListSmall;
  end;
  LLabel := TsLabel.Create(ATabSheet);
  with LLabel do
  begin
    Align := alRight;
    AlignWithMargins := True;
    Margins.Top := 1;
    Margins.Right := 6;
    Parent := LPanelSearch;
    AutoSize := True;
    Font.Size := 10;
    Tag := EDITBONE_DOCUMENT_LABEL_SEARCH_RESULT_COUNT_TAG;
    SkinManager := FSkinManager;
  end;
  LSpeedButton := TBCSpeedButton.Create(ATabSheet);
  with LSpeedButton do
  begin
    Parent := LPanelSearch;
    Align := alRight;
    Width := 20;
    Left := LLabel.Left + LLabel.Width + 1;
    ShowCaption := False;
    SkinData.SkinSection := 'TOOLBUTTON';
    OnClick := ActionSearchClose.OnExecute;
    Hint := ActionSearchClose.Hint;
    Images := ImagesDataModule.ImageListSmall;
    LBitmap := TBitmap.Create;
    LBitmap.Width := 32;
    LBitmap.Height := 16;
    LBitmap.LoadFromResourceName(hInstance, 'SEARCHGLYPH');
    Glyph := LBitmap;
    LBitmap.Free;
  end;
end;

function TEBDocument.CreateNewTabSheet(const AFileName: string = ''; AShowMinimap: Boolean = False;
  const AHighlighter: string = ''; const AColor: string = ''; ASetActivePage: Boolean = True): TBCEditor;
var
  LTabSheet: TsTabSheet;
  LEditor: TBCEditor;
begin
  FProcessing := True;

  { create new tab sheet }
  LTabSheet := TsTabSheet.Create(PageControl);
  LTabSheet.PageControl := PageControl;

  if AFileName <> '' then
    LTabSheet.ImageIndex := GetIconIndex(AFileName)
  else
    LTabSheet.ImageIndex := FNewImageIndex;
  LTabSheet.TabVisible := False;
  if ASetActivePage then
    PageControl.ActivePage := LTabSheet;
  { tab sheet new always last }
  FTabSheetNew.PageIndex := PageControl.PageCount - 1;

  { set the Caption property }
  if AFileName = '' then
    LTabSheet.Caption := LanguageDataModule.GetConstant('Document') + IntToStr(FNumberOfNewDocument)
  else
    LTabSheet.Caption := ExtractFileName(AFileName);

  { create editor }
  LEditor := TBCEditor.Create(LTabSheet);
  with LEditor do
  begin
    Align := alClient;
    AlignWithMargins := True;
    Margins.Left := 2;
    Margins.Top := 2;
    Margins.Right := 2;
    Margins.Bottom := 2;
    Visible := False;
    Parent := LTabSheet;
    DocumentName := AFileName;
    SearchString := '';
    FileDateTime := GetFileDateTime(AFileName);
    OnChange := EditorOnChange;
    OnCaretChanged := EditorCaretChanged;
    OnReplaceText := EditorReplaceText;
    OnAfterBookmarkPlaced := EditorAfterBookmarkPlaced;
    OnAfterClearBookmark := EditorAfterClearBookmark;
    OnDropFiles := DropFiles;
    PopupMenu := FPopupMenuEditor;
    Tag := EDITBONE_DOCUMENT_EDITOR_TAG;
    Search.Visible := OptionsContainer.SearchVisible;
  end;
  OptionsContainer.AssignTo(LEditor);
  LEditor.Minimap.Visible := LEditor.Minimap.Visible or AShowMinimap;

  CreateSearchPanel(LTabSheet);

  if AFileName <> '' then
  begin
    if AHighlighter <> '' then
      SetHighlighter(LEditor, AHighlighter)
    else
      SelectHighlighter(LEditor, AFileName);
    if AColor <> '' then
      SetHighlighterColor(LEditor, AColor)
    else
      SetHighlighterColor(LEditor, OptionsContainer.DefaultColor);
    LEditor.LoadFromFile(AFileName);
  end
  else
  begin
    SetEncoding(LEditor, OptionsContainer.DefaultEncoding);
    SetHighlighter(LEditor, OptionsContainer.DefaultHighlighter);
    SetHighlighterColor(LEditor, OptionsContainer.DefaultColor);
  end;

  if Assigned(FSetTitleBarMenuCaptions) then
    FSetTitleBarMenuCaptions;

  { reduce flickering by setting width and height to zero }
  LEditor.Width := 0;
  LEditor.Height := 0;
  LEditor.Visible := True;

  if LEditor.CanFocus then
    LEditor.SetFocus;

  Result := LEditor;
  LTabSheet.TabVisible := True;
  FProcessing := False;
end;

procedure TEBDocument.ComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LEditor: TBCEditor;
  LCommand: TBCEditorCommand;
begin
  if (Key = VK_END) or (Key = VK_HOME) or (Key = VK_UP) or (Key = VK_DOWN) then
  begin
    LEditor := GetActiveEditor;
    if Assigned(LEditor) then
    begin
      if LEditor.CanFocus then
        LEditor.SetFocus;
      case Key of
        VK_UP: LCommand := ecUp;
        VK_DOWN: LCommand := ecDown;
        VK_END: LCommand := ecLineEnd;
        VK_HOME: LCommand := ecLineStart;
      else
        LCommand := ecNone;
      end;
      LEditor.ExecuteCommand(LCommand, EDITBONE_NONE_CHAR, nil);
    end;
    Key := 0;
  end;
end;

procedure TEBDocument.ComboBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint);
begin
  SetActiveEditorFocus;
end;

procedure TEBDocument.SetActiveEditorFocus;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    if LEditor.CanFocus then
      LEditor.SetFocus;
end;

procedure TEBDocument.ComboBoxSearchTextKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  LComboBoxSearchText, LComboBoxSearchTextPage: TBCComboBox;
  LSearchPanel: TBCPanel;
  LItems: TStrings;
begin
  if (Key = EDITBONE_CARRIAGE_RETURN) or (Key = EDITBONE_LINEFEED) then
  begin
    SetActiveEditorFocus;
    LComboBoxSearchText := GetActiveComboBoxSearchText;
    if Assigned(LComboBoxSearchText) then
      if LComboBoxSearchText.Items.IndexOf(LComboBoxSearchText.Text) = -1 then
      begin
        LComboBoxSearchText.Items.Add(LComboBoxSearchText.Text);
        { Update other documents }
        for i := 0 to FPageControl.PageCount - 2 do
        if FPageControl.Pages[i] <> FPageControl.ActivePage then
        begin
          LComboBoxSearchTextPage := GetComboBoxSearchText(FPageControl.Pages[i]);
          if Assigned(LComboBoxSearchTextPage) then
            LComboBoxSearchTextPage.Items.Add(LComboBoxSearchText.Text);
        end;
        { Save to ini }
        LItems := TStringList.Create;
        try
          with TIniFile.Create(GetIniFilename) do
          try
            ReadSectionValues('SearchItems', LItems);
            WriteString('SearchItems', IntToStr(LItems.Count), LComboBoxSearchText.Text);
          finally
            Free;
          end;
        finally
          LItems.Free;
        end;
      end;
    Key := EDITBONE_NONE_CHAR;
  end;
  if Key = EDITBONE_ESCAPE then
  begin
    LSearchPanel := GetActiveSearchPanel;
    if Assigned(LSearchPanel) then
      LSearchPanel.Visible := False;
    SetActiveEditorFocus;
    Key := EDITBONE_NONE_CHAR;
  end;
end;

procedure TEBDocument.SearchOptions;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    TSearchOptionsDialog.ClassShowModal(LEditor);
end;

procedure TEBDocument.SetSearchMatchesFound;
var
  s: string;
  LEditor: TBCEditor;
  LLabelSearchResultCount: TsLabel;
begin
  s := '';
  LEditor := GetActiveEditor;
  if Assigned(LEditor) and (LEditor.SearchResultCount > 1) then
    s := LanguageDataModule.GetConstant('MatchFoundPluralExtension');
  if Assigned(LEditor) and (LEditor.SearchResultCount > 0) then
    s := Format(LanguageDataModule.GetConstant('MatchFound'), [LEditor.SearchResultCount, s]);

  LLabelSearchResultCount := GetActiveLabelSearchResultCount;
  if Assigned(LLabelSearchResultCount) then
  begin
    LLabelSearchResultCount.Caption := s;
    LLabelSearchResultCount.Left := 0;
  end;
end;

procedure TEBDocument.ComboBoxSearchTextChange(Sender: TObject);
var
  LEditor: TBCEditor;
  LComboBoxSearchText: TBCComboBox;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
  begin
    if soSearchOnTyping in LEditor.Search.Options then
    begin
      LComboBoxSearchText := GetActiveComboBoxSearchText;
      if Assigned(LComboBoxSearchText) then
        LEditor.Search.SearchText := LComboBoxSearchText.Text;
      SetSearchMatchesFound;
    end;
    OptionsContainer.DocumentSpecificSearchText := '';
    if not OptionsContainer.DocumentSpecificSearch then
      OptionsContainer.DocumentSpecificSearchText := LEditor.Search.SearchText
  end;
end;

procedure TEBDocument.CompareFiles(AFileName: string; AFileDragDrop: Boolean);
var
  i: Integer;
  TabSheet: TsTabSheet;
  Frame: TCompareFrame;
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
  if AFileName <> '' then
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
          Frame.SetCompareFile(AFileName, AFileDragDrop);
          Exit;
        end;
      end;
  end;
  { create a TabSheet }
  TabSheet := TsTabSheet.Create(PageControl);
  TabSheet.PageControl := PageControl;
  TabSheet.PageIndex := PageControl.PageCount - 2;
  TabSheet.ImageIndex := FCompareImageIndex;
  TabSheet.Caption := LanguageDataModule.GetConstant('CompareFiles');
  PageControl.ActivePage := TabSheet;
  { create a compare frame }
  Frame := TCompareFrame.Create(TabSheet);
  with Frame do
  begin
    Parent := TabSheet;
    Align := alClient;
    Tag := EDITBONE_DOCUMENT_COMPARE_TAG;
    OpenDocumentsList := TempList;
    SetCompareFile(AFileName);
    SpecialChars := OptionsContainer.EnableSpecialChars;
    LineNumbers := OptionsContainer.EnableLineNumbers;
    //UpdateLanguage(GetSelectedLanguage);
  end;
end;

procedure TEBDocument.SelectForCompare;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    CompareFiles(LEditor.DocumentName, False);
end;

function TEBDocument.FindOpenFile(const FileName: string): TBCEditor;
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
  LTextPosition: TBCEditorTextPosition;
begin
  if Assigned(Bookmarks) then
  begin
    for i := 0 to Bookmarks.Count - 1 do
    begin
      Temp := Bookmarks.Strings[i];
      if Pos(Editor.DocumentName, Temp) <> 0 then
      begin
        // TODO: use function
        Temp := System.Copy(Temp, Pos('=', Temp) + 1, Length(Temp));
        LBookmarkIndex := StrToInt(System.Copy(Temp, 1, Pos(';', Temp) - 1));
        Temp := System.Copy(Temp, Pos(';', Temp) + 1, Length(Temp));
        Ln := StrToInt(System.Copy(Temp, 1, Pos(';', Temp) - 1));
        Temp := System.Copy(Temp, Pos(';', Temp) + 1, Length(Temp));
        Ch := StrToInt(Temp);
        LTextPosition.Char := Ch;
        LTextPosition.Line := Ln;
        Editor.SetBookMark(LBookmarkIndex, LTextPosition);
      end;
    end;
  end;
end;

procedure TEBDocument.AddToReopenFiles(const FileName: string);
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

procedure TEBDocument.Open(const Filename: string; ASetActivePage: Boolean);
begin
  Open(Filename, nil, 0, 0, False, False, '', '', ASetActivePage);
end;

procedure TEBDocument.Open(const Filename: string; ALine: Integer; AChar: Integer);
begin
  Open(Filename, nil, ALine, AChar);
end;

procedure TEBDocument.Open(const FileName: string = ''; Bookmarks: TStrings = nil; ALine: Integer = 0; AChar: Integer = 0;
  StartUp: Boolean = False; ShowMinimap: Boolean = False; const AHighlighter: string = ''; const AColor: string = '';
  ASetActivePage: Boolean = True);
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
      if OpenDialog.Execute(Application.Handle) then
        for i := 0 to OpenDialog.Files.Count - 1 do
          Open(OpenDialog.Files[i])
    end
    else
    begin
      if FileExists(FileName) then
      begin
        Editor := FindOpenFile(FileName);
        if not Assigned(Editor) then
          Editor := CreateNewTabSheet(FileName, ShowMinimap, AHighlighter, AColor, ASetActivePage);
        SetEditorBookmarks(Editor, Bookmarks);

        Editor.GotoLineAndCenter(ALine);
        Editor.TextCaretPosition := GetTextPosition(AChar, ALine);
        if Editor.CanFocus then
          Editor.SetFocus;
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

  PageControl.TabClosed := True;
  if Assigned(Editor) and Editor.Modified then
  begin
    Result := SaveChanges;
    if Result = mrYes then
      Save;
  end;

  if Result <> mrCancel then
  begin
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
  if Assigned(FSetTitleBarMenuCaptions) then
    FSetTitleBarMenuCaptions;
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
      FProgressBar.Show(PageControl.PageCount - 2);
      Application.ProcessMessages;
      PageControl.Visible := False;
      for i := PageControl.PageCount - 2 downto 0 do
        if TsTabSheet(PageControl.Pages[i]).TabType = ttTab then
        begin
          ProgressBar.StepIt;
          PageControl.Pages[i].Free;
        end;
      PageControl.Visible := True;
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
    Screen.Cursor := crHourGlass;
    try
      FProgressBar.Show(PageControl.PageCount - 3);
      Application.ProcessMessages;
      PageControl.Visible := False;
      for i := PageControl.PageCount - 2 downto 1 do
      begin
        ProgressBar.StepIt;
        PageControl.Pages[i].Free;
      end;
      PageControl.Visible := True;
      FProgressBar.Hide;
    finally
      Screen.Cursor := crDefault;
    end;
    PageControl.ActivePageIndex := 0;
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
        AFileName := LEditor.FileName;

      FilePath := LEditor.FilePath;
      FilterIndex := OptionsContainer.GetFilterIndex(ExtractFileExt(AFileName));
      SaveDialog.InitialDir := FilePath;
      SaveDialog.Filter := OptionsContainer.Filters;
      SaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
      SaveDialog.FilterIndex := FilterIndex;
      SaveDialog.FileName := AFileName;
      if SaveDialog.Execute(Application.Handle) then
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
  LEditor: TBCEditor;
begin
  FProcessing := True;
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  try
    FProgressBar.Show(PageControl.PageCount - 2);
    for i := 0 to PageControl.PageCount - 2 do
    begin
      ProgressBar.StepIt;
      Application.ProcessMessages;
      LEditor := GetEditor(PageControl.Pages[i]);
      if Assigned(LEditor) and LEditor.Modified then
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
  Result := FormatFileName(PageControl.ActivePage.Caption);
end;

procedure TEBDocument.Undo;

  procedure Undo(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
      begin
        AEditor.DoUndo;
        if AEditor.UndoList.ItemCount = 0 then
          PageControl.ActivePage.Caption := GetActivePageCaption;
      end;
  end;

begin
  Undo(GetActiveEditor);
  Undo(GetActiveSplitEditor);
  CheckModifiedDocuments;
end;

procedure TEBDocument.Redo;

  procedure Redo(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
        AEditor.DoRedo;
  end;

begin
  Redo(GetActiveEditor);
  Redo(GetActiveSplitEditor);
  CheckModifiedDocuments;
end;

procedure TEBDocument.Cut;

  procedure Cut(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
        AEditor.CutToClipboard;
  end;

begin
  Cut(GetActiveEditor);
  Cut(GetActiveSplitEditor);
end;

procedure TEBDocument.Copy;

  procedure Copy(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
        AEditor.CopyToClipboard;
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

        if not OptionsContainer.DocumentSpecificSearch then
          OptionsContainer.DocumentSpecificSearchText := Clipboard.AsText;

        LComboBoxSearchText := GetActiveComboBoxSearchText;
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

function TEBDocument.ToggleSearch(AShowPanel: Boolean = False): Boolean;
var
  LEditor: TBCEditor;
  LSearchPanel: TBCPanel;
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
      SetOption(ReadBool('Options', 'SearchShowSearchMatchNotFound', True), soShowSearchMatchNotFound);
      SetOption(ReadBool('Options', 'SearchShowSearchStringNotFound', False), soShowStringNotFound);
      SetOption(ReadBool('Options', 'SearchWholeWordsOnly', False), soWholeWordsOnly);
    finally
      Free;
    end;
  end;

begin
  Result := False;

  LSearchPanel := GetActiveSearchPanel;
  if Assigned(LSearchPanel) then
  begin
    if AShowPanel then
      LSearchPanel.Visible := True
    else
      LSearchPanel.Visible := not LSearchPanel.Visible;

    LEditor := GetActiveEditor;
    LEditor.Search.Visible := LSearchPanel.Visible;

    if LSearchPanel.Visible then
      ReadSearchOptions;

    Result := LSearchPanel.Visible;

    if Result then
    begin
      LComboBoxSearchText := GetActiveComboBoxSearchText;
      if Assigned(LComboBoxSearchText) then
        if LComboBoxSearchText.CanFocus then
          LComboBoxSearchText.SetFocus;
    end;
  end;
end;

function TEBDocument.SetDocumentSpecificSearchText(AEditor: TBCEditor): Boolean;
begin
  Result := False;
  if not OptionsContainer.DocumentSpecificSearch then
    if AEditor.Search.SearchText <> OptionsContainer.DocumentSpecificSearchText then
    begin
      AEditor.Search.SearchText := OptionsContainer.DocumentSpecificSearchText;
      Result := True;
    end;
end;

procedure TEBDocument.FindNext;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if not Assigned(LEditor) then
    Exit;
  if not SetDocumentSpecificSearchText(LEditor) then
    LEditor.FindNext;
end;

procedure TEBDocument.FindPrevious;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if not Assigned(LEditor) then
    Exit;
  if not SetDocumentSpecificSearchText(LEditor) then
    LEditor.FindPrevious;
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
      SearchFor := LEditor.SelectedText;
    LResult := ShowModal;

    if (LResult = mrOK) or (LResult = mrYes) then
    begin
      if ReplaceInWholeFile then
      begin
        GetOptions(LEditor);
        LEditor.CaretZero;
        Screen.Cursor := crHourGlass;
        try
          LEditor.ReplaceText(SearchFor, ReplaceWith);
          SetActivePageCaptionModified(LEditor.Modified);
        finally
          Screen.Cursor := crDefault;
        end;
      end
      else
      begin
        Screen.Cursor := crHourGlass;
        try
          FProgressBar.Show(PageControl.PageCount - 2);
          for i := 0 to PageControl.PageCount - 2 do
          begin
            ProgressBar.StepIt;
            Application.ProcessMessages;
            LEditor := GetEditor(PageControl.Pages[i]);
            if Assigned(LEditor) then
            begin
              GetOptions(LEditor);
              LEditor.CaretZero;
              LEditor.ReplaceText(SearchFor, ReplaceWith);
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
  CheckModifiedDocuments;
  FProcessing := False;
end;

procedure TEBDocument.ToggleBookmark(AItemIndex: Integer);
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.ToggleBookmark(AItemIndex);
end;

function TEBDocument.ToggleWordWrap: Boolean;
var
  i: Integer;
  LEditor: TBCEditor;
begin
  OptionsContainer.EnableWordWrap := not OptionsContainer.EnableWordWrap;
  Result := OptionsContainer.EnableWordWrap;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    LEditor := GetEditor(PageControl.Pages[i]);
    if Assigned(LEditor) then
      LEditor.WordWrap.Enabled := Result;
    LEditor := GetEditor(PageControl.Pages[i], EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG);
    if Assigned(LEditor) then
      LEditor.WordWrap.Enabled := Result;
  end;
end;

function TEBDocument.ToggleSpecialChars: Boolean;
var
  i: Integer;
  LEditor: TBCEditor;
begin
  OptionsContainer.EnableSpecialChars := not OptionsContainer.EnableSpecialChars;
  Result := OptionsContainer.EnableSpecialChars;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    LEditor := GetEditor(PageControl.Pages[i]);
    if Assigned(LEditor) then
    begin
      LEditor.SpecialChars.Visible := Result;
      LEditor.SpecialChars.EndOfLine.Visible := Result;
    end;
    LEditor := GetEditor(PageControl.Pages[i], EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG);
    if Assigned(LEditor) then
    begin
      LEditor.SpecialChars.Visible := Result;
      LEditor.SpecialChars.EndOfLine.Visible := Result;
    end;
    //if PageControl.Pages[i].Components[0] is TCompareFrame then
    //  Result := TCompareFrame(PageControl.Pages[i].Components[0]).ToggleSpecialChars
  end;
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
    ToggleSelectionMode(GetEditor(PageControl.Pages[i], EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG));
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
    Editor := GetEditor(PageControl.Pages[i], EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG);
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
  LFileNamesList, LBookmarksList: TStrings;
  LCaretXList, LCaretYList, LMinimapsList: TValueListEditor;
  LCaretX, LCaretY: Integer;
  LMinimap: Boolean;

  function GetIntegerListItem(AList: TValueListEditor; AIndex: Integer): Integer;
  begin
    if AIndex >= AList.Strings.Count then
      Result := 0
    else
      Result := StrToInt(AList.Values[IntToStr(AIndex)])
  end;

  function GetBooleanListItem(AList: TValueListEditor; AIndex: Integer): Boolean;
  begin
    if AIndex >= AList.Strings.Count then
      Result := False
    else
      Result := AList.Values[IntToStr(AIndex)] = 'True'
  end;

begin
  LFileNamesList := TStringList.Create;
  LBookmarksList := TStringList.Create;
  LCaretXList := TValueListEditor.Create(nil);
  LCaretYList := TValueListEditor.Create(nil);
  LMinimapsList := TValueListEditor.Create(nil);
  with TBigIniFile.Create(GetIniFilename) do
  try
    PageControl.Visible := False;
    { Open Files }
    ReadSectionValues('OpenFiles', LFileNamesList);
    ReadSectionValues('Bookmarks', LBookmarksList);
    ReadSectionValues('CaretX', LCaretXList.Strings);
    ReadSectionValues('CaretY', LCaretYList.Strings);
    ReadSectionValues('Minimaps', LMinimapsList.Strings);

    for i := 0 to LFileNamesList.Count - 1 do
    begin
      s := RemoveTokenFromStart('=', LFileNamesList.Strings[i]);
      LFileName := GetNextToken(';', s);
      if FileExists(LFileName) then
      begin
        s := RemoveTokenFromStart(';', s);
        LHighlighter := GetNextToken(';', s);
        s := RemoveTokenFromStart(';', s);
        LColor := GetNextToken(';', s);
        LCaretX := GetIntegerListItem(LCaretXList, i);
        LCaretY := GetIntegerListItem(LCaretYList, i);
        LMinimap := GetBooleanListItem(LMinimapsList, i);
        Open(LFileName, LBookmarksList, LCaretY, LCaretX, True, LMinimap, LHighlighter, LColor);
      end;
    end;

    i := ReadInteger('Options', 'ActivePageIndex', 0);
    if i < PageControl.PageCount then
    begin
      PageControl.ActivePageIndex := i;
      if Assigned(FSetTitleBarMenuCaptions) then
        FSetTitleBarMenuCaptions;
    end;

    Result := LFileNamesList.Count > 0;
  finally
    LFileNamesList.Free;
    LBookmarksList.Free;
    LCaretXList.Free;
    LCaretYList.Free;
    LMinimapsList.Free;
    Free;
    PageControl.Visible := True;
  end;
end;

procedure TEBDocument.WriteIniFile;
var
  i, j: Integer;
  LFileType: string;
  LEditor: TBCEditor;
  LTextCaretPosition: TBCEditorTextPosition;
  LLanguageItem: string;
begin
  with TBigIniFile.Create(GetIniFilename) do
  try
    EraseSection('OpenFiles');
    EraseSection('Bookmarks');
    EraseSection('Minimaps');
    EraseSection('CaretX');
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
          LTextCaretPosition := LEditor.TextCaretPosition;
          WriteInteger('CaretY', IntToStr(i), LTextCaretPosition.Line);
          WriteInteger('CaretX', IntToStr(i), LTextCaretPosition.Char);
        end;
      end;
    { Active document }
    WriteInteger('Options', 'ActivePageIndex', PageControl.ActivePageIndex);
    EraseSection('FileTypes');
    { FileTypes }
    for i := 0 to OptionsContainer.FileTypes.Count - 1 do
    begin
      LLanguageItem := LanguageDataModule.MultiStringHolderFileTypes.MultipleStrings.Items[i].Strings.Text;
      LFileType := Trim(System.Copy(LLanguageItem, 0, Pos('(', LLanguageItem) - 1));
      LFileType := Format('%s (%s)', [LFileType, StringBetween(OptionsContainer.FileTypes.Strings[i], '(', ')')]);
      WriteString('FileTypes', LanguageDataModule.MultiStringHolderFileTypes.MultipleStrings.Items[i].Name, LFileType);
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
      LEditor.CommandProcessor(ecImeStr, EDITBONE_NONE_CHAR, PWideChar(Format('<%s></%s>', [LTagName, LTagName])));
      LEditor.DisplayCaretX := LEditor.DisplayCaretX - Length(LTagName) - 3; { -3 from </> }
    end;
  end;
end;

procedure TEBDocument.InsertDateAndTime;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.CommandProcessor(ecImeStr, EDITBONE_NONE_CHAR, PWideChar(DateTimeToStr(Now)));
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

procedure TEBDocument.CreateImageList;
var
  LSysImageList: THandle;
  LIcon: TIcon;
begin
  if not Assigned(FImages) then
    FImages := TImageList.Create(nil);
  LSysImageList := GetSysImageList;
  if LSysImageList <> 0 then
  begin
    FImages.Handle := LSysImageList;
    FImages.BkColor := clNone;
    FImages.ShareImages := True;
  end;
  { compare and new image index }
  LIcon := TIcon.Create;
  try
    { Windows font size causing a problem: Icon size will be smaller than PageControl.Images size }
    case FImages.Height of
      16:
        begin
          { smaller }
          EBDataModuleImages.ImageListDocument16.GetIcon(0, LIcon);
          FCompareImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          EBDataModuleImages.ImageListDocument16.GetIcon(1, LIcon);
          FNewImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          if Assigned(FTabSheetNew) then
          begin
            EBDataModuleImages.ImageListDocument16.GetIcon(2, LIcon);
            FTabSheetNew.ImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          end;
        end;
      20:
        begin
          { medium }
          EBDataModuleImages.ImageListDocument20.GetIcon(0, LIcon);
          FCompareImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          EBDataModuleImages.ImageListDocument20.GetIcon(1, LIcon);
          FNewImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          if Assigned(FTabSheetNew) then
          begin
            EBDataModuleImages.ImageListDocument20.GetIcon(2, LIcon);
            FTabSheetNew.ImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          end;
        end;
      24:
        begin
          { larger }
          EBDataModuleImages.ImageListDocument24.GetIcon(0, LIcon);
          FCompareImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          EBDataModuleImages.ImageListDocument24.GetIcon(1, LIcon);
          FNewImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          if Assigned(FTabSheetNew) then
          begin
            EBDataModuleImages.ImageListDocument24.GetIcon(2, LIcon);
            FTabSheetNew.ImageIndex := ImageList_AddIcon(FImages.Handle, LIcon.Handle);
          end;
        end;
    end;
  finally
    LIcon.Free;
  end;
end;

procedure TEBDocument.SetOptions;
var
  i: Integer;
  LEditor: TBCEditor;
begin
  PageControl.MultiLine := OptionsContainer.DocMultiLine;
  PageControl.ShowCloseBtns := OptionsContainer.DocShowCloseButton;
  PageControl.RightClickSelect := OptionsContainer.DocRightClickSelect;
  if OptionsContainer.DocShowImage then
    PageControl.Images := FImages
  else
    PageControl.Images := nil;
  if Assigned(FTabSheetNew) then
    FTabSheetNew.TabVisible := OptionsContainer.DocShowNewDocumentButton;
  { assign to every Editor }
  for i := 0 to PageControl.PageCount - 2 do
  begin
    LEditor := GetEditor(PageControl.Pages[i]);
    if Assigned(LEditor) then
      OptionsContainer.AssignTo(LEditor);
    LEditor := GetEditor(PageControl.Pages[i], EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG);
    if Assigned(LEditor) then
      OptionsContainer.AssignTo(LEditor);
  end;
end;

function TEBDocument.GetCompareFrame(TabSheet: TTabSheet): TCompareFrame;
begin
  Result := nil;
  if Assigned(TabSheet) then
    if TabSheet.ComponentCount <> 0 then
      if TabSheet.Components[0] is TCompareFrame then
        Result := TCompareFrame(TabSheet.Components[0]);
end;

function TEBDocument.GetSplitter(const ATabSheet: TTabSheet; const ATag: Integer): TBCSplitter;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ATabSheet.ControlCount - 1 do
  if ATabSheet.Controls[i].Tag = ATag then
  begin
    Result := ATabSheet.Controls[i] as TBCSplitter;
    Break;
  end;
end;

function TEBDocument.GetComboBoxSearchText(const ATabSheet: TTabSheet): TBCComboBox;
var
  i: Integer;
  LSearchPanel: TBCPanel;
begin
  Result := nil;
  LSearchPanel := GetSearchPanel(ATabSheet);
  if Assigned(LSearchPanel) then
  for i := 0 to LSearchPanel.ControlCount - 1 do
  if LSearchPanel.Controls[i].Tag = EDITBONE_DOCUMENT_COMBOBOX_SEARCH_TEXT_TAG then
  begin
    Result := LSearchPanel.Controls[i] as TBCComboBox;
    Break;
  end;
end;

function TEBDocument.GetActiveLabelSearchResultCount: TsLabel;
var
  i: Integer;
  LSearchPanel: TBCPanel;
begin
  Result := nil;
  LSearchPanel := GetActiveSearchPanel;
  if Assigned(LSearchPanel) then
  for i := 0 to LSearchPanel.ControlCount - 1 do
  if LSearchPanel.Controls[i].Tag = EDITBONE_DOCUMENT_LABEL_SEARCH_RESULT_COUNT_TAG then
  begin
    Result := LSearchPanel.Controls[i] as TsLabel;
    Break;
  end;
end;

function TEBDocument.GetXMLTree(const ATabSheet: TTabSheet): TEBXMLTree;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ATabSheet.ControlCount - 1 do
  if ATabSheet.Controls[i].Tag = EDITBONE_DOCUMENT_XML_TREE_TAG then
  begin
    Result := ATabSheet.Controls[i] as TEBXMLTree;
    Break;
  end;
end;

function TEBDocument.GetSearchPanel(const ATabSheet: TTabSheet): TBCPanel;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ATabSheet.ControlCount - 1 do
  if ATabSheet.Controls[i].Tag = EDITBONE_DOCUMENT_SEARCH_PANEL_TAG then
  begin
    Result := ATabSheet.Controls[i] as TBCPanel;
    Result.Realign;
    Break;
  end;
end;

function TEBDocument.SearchPanelVisible: Boolean;
var
  LPanel: TBCPanel;
begin
  Result := False;
  LPanel := GetActiveSearchPanel;
  if Assigned(LPanel) then
    Result := LPanel.Visible;
end;

procedure TEBDocument.SearchClose;
var
  LPanel: TBCPanel;
  LEditor: TBCEditor;
begin
  LPanel := GetActiveSearchPanel;
  if Assigned(LPanel) then
    LPanel.Visible := False;
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.Search.Visible := False;
end;

function TEBDocument.GetActiveSearchPanel: TBCPanel;
begin
  if Assigned(PageControl.ActivePage) then
    Result := GetSearchPanel(PageControl.ActivePage)
  else
    Result := nil;
end;

function TEBDocument.GetActiveComboBoxSearchText: TBCComboBox;
begin
  if Assigned(PageControl.ActivePage) then
    Result := GetComboBoxSearchText(PageControl.ActivePage)
  else
    Result := nil;
end;

function TEBDocument.GetEditor(const ATabSheet: TTabSheet; const ATag: Integer = EDITBONE_DOCUMENT_EDITOR_TAG): TBCEditor;
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
  LEditor: TBCEditor;
  LEditorCommand: TBCEditorCommand;
begin
  LEditorCommand := ecNone;
  case ItemIndex of
    1:
      LEditorCommand := ecGotoBookmark1;
    2:
      LEditorCommand := ecGotoBookmark2;
    3:
      LEditorCommand := ecGotoBookmark3;
    4:
      LEditorCommand := ecGotoBookmark4;
    5:
      LEditorCommand := ecGotoBookmark5;
    6:
      LEditorCommand := ecGotoBookmark6;
    7:
      LEditorCommand := ecGotoBookmark7;
    8:
      LEditorCommand := ecGotoBookmark8;
    9:
      LEditorCommand := ecGotoBookmark9;
  end;
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.CommandProcessor(LEditorCommand, Char(ItemIndex), nil);
end;

procedure TEBDocument.GotoLine;
var
  LEditor: TBCEditor;
  LLine: Integer;
begin
  if TInputQueryDialog.ClassShowModal(Application.MainForm, LanguageDataModule.GetConstant('GoToLine'), LLine) = mrOK then
  begin
    LEditor := GetActiveEditor;
    if Assigned(LEditor) then
      LEditor.GotoLineAndCenter(LLine);
  end;
end;

function TEBDocument.GetActiveSplitEditor: TBCEditor;
begin
  if Assigned(PageControl.ActivePage) then
    Result := GetEditor(PageControl.ActivePage, EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG)
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
  PageControl.ActivePage.Caption := FormatFileName(PageControl.ActivePage.Caption, AModified);
end;

procedure TEBDocument.EditorOnChange(Sender: TObject);
var
  LEditor: TBCEditor;
begin
  inherited;
  LEditor := GetActiveEditor;
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
      Result := PageControl.ActivePage.Caption;
end;

function TEBDocument.GetActiveDocumentName: string;
var
  LEditor: TBCEditor;
begin
  Result := '';
  if Assigned(PageControl.ActivePage) then
  begin
    LEditor := GetActiveEditor;
    if Assigned(LEditor) then
      if LEditor.DocumentName <> '' then
        Result := FormatFileName(LEditor.DocumentName, LEditor.Modified);
  end;
end;

function TEBDocument.GetActiveFileName: string;
var
  LEditor: TBCEditor;
begin
  Result := '';
  if Assigned(PageControl.ActivePage) then
  begin
    LEditor := GetActiveEditor;
    if Assigned(LEditor) then
      Result := LEditor.FileName
  end;
end;

function TEBDocument.GetModifiedDocuments(CheckActive: Boolean): Boolean;
var
  i: Integer;
  LEditor: TBCEditor;
begin
  Result := True;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    if (TsTabSheet(PageControl.Pages[i]).TabType = ttTab) and TsTabSheet(PageControl.Pages[i]).TabVisible then
      if CheckActive or ((PageControl.ActivePageIndex <> i) and not CheckActive) then
      begin
        LEditor := GetEditor(PageControl.Pages[i]);
        if Assigned(LEditor) then
          if LEditor.Modified then
            Exit;
      end;
  end;
  Result := False;
end;

function TEBDocument.GetCanUndo: Boolean;
var
  LEditor: TBCEditor;
begin
  Result := False;
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    Result := LEditor.UndoList.ItemCount > 0;

  LEditor := GetActiveSplitEditor;
  if Assigned(LEditor) then
    Result := Result or (LEditor.UndoList.ItemCount > 0);
end;

function TEBDocument.GetCanRedo: Boolean;
var
  LEditor: TBCEditor;
begin
  Result := False;
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    Result := LEditor.RedoList.ItemCount > 0;

  LEditor := GetActiveSplitEditor;
  if Assigned(LEditor) then
    Result := Result or (LEditor.RedoList.ItemCount > 0);
end;

procedure TEBDocument.EditorReplaceText(Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer;
  DeleteLine: Boolean; var Action: TBCEditorReplaceAction);
var
  LConfirmText: string;
begin
  if ASearch = AReplace then
    Action := raSkip
  else
  begin
    if DeleteLine then
      LConfirmText := LanguageDataModule.GetYesOrNoMessage('DeleteLine')
    else
      LConfirmText := Format(LanguageDataModule.GetYesOrNoMessage('ReplaceOccurence'), [ASearch, AReplace]);

    case TConfirmReplaceDialog.ClassShowModal(Application.MainForm, LConfirmText) of
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
  if Assigned(FStatusBar) then
    FStatusBar.Repaint;
end;

function TEBDocument.GetModifiedInfo(AEditor: TBCEditor): string;
begin
  Result := '';
  if OptionsContainer.AutoSave then
    Result := LanguageDataModule.GetConstant('AutoSave')
  else
  if Assigned(AEditor) then
    if AEditor.Modified then
      Result := LanguageDataModule.GetConstant('Modified');
end;

function TEBDocument.GetActiveDocumentModified: Boolean;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  Result := Assigned(LEditor) and LEditor.Modified;
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
  LEditor: TBCEditor;
  LFileDateTime: TDateTime;
  LDialogResult: Integer;
begin
  LDialogResult := mrNo;
  if FProcessing then
    Exit;
  FProcessing := True;
  for i := 0 to PageControl.PageCount - 2 do
  begin
    LEditor := GetEditor(PageControl.Pages[i]);
    if Assigned(LEditor) then
      if LEditor.DocumentName <> '' then
      begin
        LFileDateTime := GetFileDateTime(LEditor.DocumentName);
        if (LFileDateTime <> 0) and (LFileDateTime <> LEditor.FileDateTime) then
        begin
          if FileExists(LEditor.DocumentName) then
          begin
            PageControl.TabClosed := True; { just to avoid begin drag }
            if not(LDialogResult in [mrYesToAll, mrNoToAll]) then
              LDialogResult := AskYesOrNoAll(Format(LanguageDataModule.GetYesOrNoMessage('DocumentTimeChanged'),
                [LEditor.DocumentName]));
            if LDialogResult in [mrYes, mrYesToAll] then
              Refresh(i);
          end
          else
          begin
            if OptionsContainer.AutoSave then
              Save
            else
            begin
              LEditor.Modified := True;
              PageControl.Pages[i].Caption := FormatFileName(PageControl.Pages[i].Caption, LEditor.Modified);
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
  LEditor: TBCEditor;
begin
  if (Page < 0) or (Page > PageControl.PageCount - 2) then
    Exit;
  LEditor := GetEditor(PageControl.Pages[Page]);
  if Assigned(LEditor) then
  begin
    LEditor.LoadFromFile(LEditor.DocumentName);
    LEditor.FileDateTime := GetFileDateTime(LEditor.DocumentName);
  end;
end;

procedure TEBDocument.DecreaseIndent;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.CommandProcessor(ecBlockUnindent, 'U', nil);
end;

procedure TEBDocument.IncreaseIndent;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.CommandProcessor(ecBlockIndent, 'I', nil);
end;

procedure TEBDocument.SelectAll;
var
  LComboBoxSearchText: TBCComboBox;

  procedure SelectAll(Editor: TBCEditor);
  begin
    if Assigned(Editor) then
      if Editor.Focused then
        Editor.SelectAll;
  end;

begin
  LComboBoxSearchText := GetActiveComboBoxSearchText;
  if Assigned(LComboBoxSearchText) and LComboBoxSearchText.Focused then
    LComboBoxSearchText.SelectAll
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
  begin
    LEditor.ClearBookmarks;
    LEditor.Invalidate;
  end;
  LEditor := GetActiveSplitEditor;
  if Assigned(LEditor) then
  begin
    LEditor.ClearBookmarks;
    LEditor.Invalidate;
  end;
end;

procedure TEBDocument.InsertLine;

  procedure InsertLine(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
        AEditor.CommandProcessor(ecInsertLine, 'N', nil);
  end;

begin
  InsertLine(GetActiveEditor);
  InsertLine(GetActiveSplitEditor);
end;

procedure TEBDocument.DeleteWord;

  procedure DeleteWord(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
        AEditor.CommandProcessor(ecDeleteWord, 'T', nil);
  end;

begin
  DeleteWord(GetActiveEditor);
  DeleteWord(GetActiveSplitEditor);
end;

procedure TEBDocument.DeleteLine;

  procedure DeleteLine(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
        AEditor.CommandProcessor(ecDeleteLine, 'Y', nil);
  end;

begin
  DeleteLine(GetActiveEditor);
  DeleteLine(GetActiveSplitEditor);
end;

procedure TEBDocument.DeleteEndOfLine;

  procedure DeleteEndOfLine(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      if AEditor.Focused then
        AEditor.CommandProcessor(ecDeleteEndOfLine, 'Y', nil);
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

procedure TEBDocument.SetHighlighter(AEditor: TBCEditor; const AHighlighterName: string);
begin
  if Assigned(AEditor) then
  with AEditor do
  begin
    Highlighter.LoadFromFile(Format('%s.json', [AHighlighterName]));
    CodeFolding.Visible := OptionsContainer.ShowCodeFolding and (Highlighter.CodeFoldingRangeCount > 0);

    ExtraTag := 0;
    if Pos('JSON', AHighlighterName) <> 0 then
      ExtraTag := EXTENSION_JSON
    else
    if Pos('XML', AHighlighterName) <> 0 then
      ExtraTag := EXTENSION_XML
    else
    if Pos('SQL', AHighlighterName) <> 0 then
      ExtraTag := EXTENSION_SQL;

    if CanFocus then
      Invalidate;
  end;
end;

procedure TEBDocument.UpdateHighlighterColors;
var
  i: Integer;
  LEditor: TBCEditor;
begin
  for i := 0 to PageControl.PageCount - 2 do
  begin
    LEditor := GetEditor(PageControl.Pages[i]);
    if Assigned(LEditor) then
    begin
      LEditor.Highlighter.Colors.LoadFromFile(LEditor.Highlighter.Colors.FileName);
      SetSkinColors(LEditor);
    end;
  end;
end;

procedure TEBDocument.SetSkinColors(Editor: TBCEditor);
var
  i: Integer;
  LColor: TColor;
begin
  LColor := SkinManager.GetActiveEditColor;
  if OptionsContainer.SkinActiveLineBackground then
    Editor.ActiveLine.Color := SkinManager.GetHighLightColor(False);
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
    Editor.Selection.Colors.Foreground := SkinManager.GetHighLightFontColor;
  if OptionsContainer.SkinSelectionBackground then
    Editor.Selection.Colors.Background := SkinManager.GetHighLightColor;
  for i := 0 to Editor.Highlighter.Colors.Styles.Count - 1 do
    if PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Name = 'Editor' then
    begin
      if OptionsContainer.SkinForeground then
        PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Foreground :=
          SkinManager.GetActiveEditFontColor;
      if OptionsContainer.SkinBackground then
        PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Background := LColor;
      Break;
    end;
  Editor.Highlighter.UpdateColors;
end;

procedure TEBDocument.SetHighlighterColor(AEditor: TBCEditor; const AColorName: string);
begin
  if Assigned(AEditor) then
  with AEditor do
  begin
    Highlighter.Colors.LoadFromFile(Format('%s.json', [AColorName]));
    SetSkinColors(AEditor);
    Invalidate;
  end;
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
      SaveDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('Macro'), '|', EDITBONE_NONE_CHAR, [rfReplaceAll]
        )) + EDITBONE_NONE_CHAR + EDITBONE_NONE_CHAR;
      SaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
      SaveDialog.FileName := '';
      SaveDialog.DefaultExt := 'mcr';
      if SaveDialog.Execute(Application.Handle) then
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
    OpenDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('Macro'), '|', EDITBONE_NONE_CHAR, [rfReplaceAll])) + EDITBONE_NONE_CHAR + EDITBONE_NONE_CHAR;
    OpenDialog.Title := LanguageDataModule.GetConstant('Open');
    OpenDialog.DefaultExt := 'mcr';
    if OpenDialog.Execute(Application.Handle) then
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

procedure TEBDocument.ToggleSplit;
var
  LEditor, LSplitEditor: TBCEditor;
  LSplitterHorizontal: TBCSplitter;
begin
  LEditor := GetActiveEditor;
  LSplitEditor := GetEditor(PageControl.ActivePage, EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG);
  if not Assigned(LSplitEditor) then
  begin
    LEditor.Margins.Bottom := 0;
    LSplitEditor := TBCEditor.Create(PageControl.ActivePage);
    LSplitEditor.Align := alBottom;
    LSplitEditor.AlignWithMargins := True;
    LSplitEditor.Margins.SetBounds(2, 0, 2, 2);
    LSplitEditor.Width := 0; { avoid flickering }
    LSplitEditor.Height := LEditor.Height div 2;
    LSplitEditor.Tag := EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG;
    LSplitEditor.Parent := PageControl.ActivePage;
    OptionsContainer.AssignTo(LSplitEditor);
    LSplitEditor.name := 'test';
    LSplitEditor.ChainEditor(LEditor);
    LSplitEditor.SetFocus;
    LSplitEditor.Minimap.Visible := LEditor.Minimap.Visible;
    LSplitEditor.CodeFolding.Visible := LEditor.CodeFolding.Visible;
    { horizontal splitter }
    LSplitterHorizontal := TBCSplitter.Create(PageControl.ActivePage);
    LSplitterHorizontal.Align := alBottom;
    LSplitterHorizontal.Parent := PageControl.ActivePage;
    LSplitterHorizontal.Tag := EDITBONE_DOCUMENT_HORIZONTAL_SPLITTER_TAG;
    LSplitterHorizontal.Top := LSplitEditor.Top - 1; { splitter always above }
  end
  else
  begin
    LEditor.Margins.Bottom := 2;
    LSplitEditor.RemoveChainedEditor;
    LSplitEditor.Visible := False;
    LSplitEditor.Parent := nil;
    LSplitEditor.Free;
    { horizontal splitter }
    LSplitterHorizontal := GetSplitter(PageControl.ActivePage, EDITBONE_DOCUMENT_HORIZONTAL_SPLITTER_TAG);
    LSplitterHorizontal.Parent := nil;
    LSplitterHorizontal.Free;
  end;
end;

procedure TEBDocument.ToggleMiniMap;

  procedure ToggleMinimap(AEditor: TBCEditor);
  begin
    if Assigned(AEditor) then
      AEditor.Minimap.Visible := not AEditor.Minimap.Visible;
  end;

begin
  ToggleMinimap(GetActiveEditor);
  ToggleMinimap(GetActiveSplitEditor);
end;

procedure TEBDocument.FormatXML;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
  begin
    LEditor.BeginUndoBlock;
    try
      LEditor.SelectAll;
      LEditor.SelectedText := BCCommon.StringUtils.FormatXML(LEditor.Text);
    finally
      LEditor.EndUndoBlock;
      LEditor.SetFocus;
    end;
  end;
end;

procedure TEBDocument.FormatSQL;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    if Trim(LEditor.Text) <> '' then
      LEditor.Text := BCCommon.SQL.Formatter.FormatSQL(LEditor.Text, TSQLDatabase(SQLFormatterOptionsContainer.SQLDatabase));
end;

procedure TEBDocument.FormatJSON(AIndentSize: Integer);
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    if Trim(LEditor.Text) <> '' then
    begin
      LEditor.Text := BCCommon.StringUtils.FormatJSON(LEditor.Text, AIndentSize);
      LEditor.CaretZero;
    end;
end;

procedure TEBDocument.SelectHighlighter(AEditor: TBCEditor; const FileName: string);
var
  Ext, ItemString, Token: string;
  i: Integer;
begin
  Ext := '*' + LowerCase(ExtractFileExt(FileName));

  for i := 0 to OptionsContainer.FileTypes.Count - 1 do
  begin
    ItemString := StringBetween(OptionsContainer.FileTypes.ValueFromIndex[i], '(', ')');
    while ItemString <> '' do
    begin
      Token := GetNextToken(';', ItemString);
      ItemString := RemoveTokenFromStart(';', ItemString);
      if Ext = Token then
      begin
        if Pos('SQL', OptionsContainer.FileTypes.Names[i]) <> 0 then
          SetHighlighter(AEditor, OptionsContainer.DefaultSQLHighlighter)
        else
          SetHighlighter(AEditor, OptionsContainer.FileTypes.Names[i]);
        Exit;
      end;
    end;
  end;
  SetHighlighter(AEditor, OptionsContainer.DefaultHighlighter);
end;

function TEBDocument.GetActiveBookmarkList: TBCEditorBookmarkList;
var
  LEditor: TBCEditor;
begin
  Result := nil;
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    Result := LEditor.Marks;
end;

procedure TEBDocument.CollapseAll;
var
  LEditor: TBCEditor;
begin
  LEditor := GetActiveEditor;
  if Assigned(LEditor) then
    LEditor.CodeFoldingCollapseAll;
end;

procedure TEBDocument.DropFiles(Sender: TObject; Pos: TPoint; AFiles: TStrings);
var
  i, j: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    j := AFiles.Count;
    ProgressBar.Show(j);
   { if IsCompareFilesActivePage then
    begin
      if j > 1 then
        for i := 0 to j - 1 do
        begin
          ProgressBar.StepIt;
          CompareFiles(Value.Strings[i]);
        end
      else
        CompareFiles(Value.Strings[0], True)
    end
    else }
    for i := 0 to j - 1 do
    begin
      ProgressBar.StepIt;
      Open(AFiles.Strings[i], i = 0);
    end;
  finally
    ProgressBar.Hide;
    Screen.Cursor := crDefault;
  end;
end;

end.
