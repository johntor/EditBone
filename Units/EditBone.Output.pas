unit EditBone.Output;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ComCtrls,
  VirtualTrees, BCComponent.SkinManager,
  BCControl.PageControl, BCCommon.Images, sPageControl;

type
  TOpenAllEvent = procedure(var FileNames: TStrings);

  TEBOutput = class(TObject)
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
    procedure VirtualDrawTreeInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure TabsheetDblClick(Sender: TObject);
  private
    FCancelSearch: Boolean;
    FProcessingTabSheet: Boolean;
    FProcessingPage: TsTabSheet;
    FTabsheetDblClick: TNotifyEvent;
    FOpenAll: TOpenAllEvent;
    FRootNode: PVirtualNode;
    FPageControl: TBCPageControl;
    FTabSheetFindInFiles: TTabSheet;
    FSkinManager: TBCSkinManager;
    function GetOutputTreeView(TabSheet: TTabSheet): TVirtualDrawTree;
    function TabFound(const TabCaption: string): Boolean;
    function CheckCancel(ATabIndex: Integer = -1): Boolean;
  public
    constructor Create(AOwner: TBCPageControl);
    function CloseTabSheet(AFreePage: Boolean = True; ATabIndex: Integer = -1): Boolean;
    function SelectedLine(var Filename: string; var Ln: LongWord; var Ch: LongWord): Boolean;
    function AddTreeView(const TabCaption: string): TVirtualDrawTree;
    procedure AddTreeViewLine(OutputTreeView: TVirtualDrawTree; const Filename: WideString; Ln, Ch: LongInt;
      const Text: WideString; const SearchString: WideString = '');
    procedure ReadOutputFile;
    procedure SetOptions;
    procedure WriteOutputFile;
    procedure CloseAllOtherTabSheets;
    procedure CloseAllTabSheets;
    procedure CopyToClipboard(OnlySelected: Boolean = False);
    procedure SetProcessingTabSheet(Value: Boolean);
    procedure OpenFiles(OnlySelected: Boolean = False);
    procedure SetCheckedState(Value: TCheckState);
    property OnTabsheetDblClick: TNotifyEvent read FTabsheetDblClick write FTabsheetDblClick;
    property OnOpenAll: TOpenAllEvent read FOpenAll write FOpenAll;
    property ProcessingTabSheet: Boolean read FProcessingTabSheet write SetProcessingTabSheet;
    property CancelSearch: Boolean read FCancelSearch write FCancelSearch;
    property SkinManager: TBCSkinManager read FSkinManager write FSkinManager;
    property PageControl: TBCPageControl read FPageControl;
  end;

implementation

uses
  EditBone.Types, BCCommon.Options.Container, System.UITypes, Vcl.Clipbrd, BCCommon.Messages,
  BCCommon.Language.Strings, BCCommon.FileUtils, BCCommon.Consts, BCCommon.StringUtils, System.Types,
  BCControl.Panel;

constructor TEBOutput.Create(AOwner: TBCPageControl);
begin
  inherited Create;
  FPageControl := AOwner;
  FTabSheetFindInFiles := AOwner.Pages[0];
end;

procedure TEBOutput.TabsheetDblClick(Sender: TObject);
begin
  if Assigned(FTabsheetDblClick) then
    FTabsheetDblClick(Sender);
end;

procedure TEBOutput.OpenFiles(OnlySelected: Boolean);
var
  FileNames: TStrings;

  procedure GetFileNames;
  var
    OutputTreeView: TVirtualDrawTree;
    Node: PVirtualNode;
    Data: POutputRec;
  begin
    OutputTreeView := GetOutputTreeView(PageControl.ActivePage);
    Node := OutputTreeView.GetFirst;
    while Assigned(Node) do
    begin
      if not OnlySelected or OnlySelected and (OutputTreeView.CheckState[Node] = csCheckedNormal) then
      begin
        Data := OutputTreeView.GetNodeData(Node);
        FileNames.Add(Data.FileName);
      end;
      Node := Node.NextSibling;
    end;
  end;

begin
  if Assigned(FOpenAll) then
  begin
    FileNames := TStringList.Create;
    try
      GetFileNames;
      FOpenAll(FileNames);
    finally
      FileNames.Free;
    end;
  end;
end;

function TEBOutput.TabFound(const TabCaption: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  { check if there already is a tab with same name }
  for i := 0 to PageControl.PageCount - 1 do
    if Trim(PageControl.Pages[i].Caption) = TabCaption then
    begin
      PageControl.ActivePageIndex := i;
      Result := True;
      Break;
    end;
end;

function TEBOutput.AddTreeView(const TabCaption: string): TVirtualDrawTree;
var
  LTabSheet: TsTabSheet;
  LVirtualDrawTree: TVirtualDrawTree;
  LPanel: TBCPanel;
begin
  { check if there already is a tab with same name }
  if TabFound(StringReplace(TabCaption, '&', '&&', [rfReplaceAll])) then
  begin
    Result := GetOutputTreeView(PageControl.ActivePage);
    if Assigned(Result) then
    begin
      Result.Clear;
      Result.Tag := 0;
    end;
    Exit;
  end;

  LTabSheet := TsTabSheet.Create(PageControl);
  LTabSheet.PageControl := PageControl;

  if Assigned(FTabSheetFindInFiles) then
    FTabSheetFindInFiles.PageIndex := FPageControl.PageCount - 1;

  LTabSheet.TabVisible := False;
  LTabSheet.ImageIndex := IMAGE_INDEX_FIND_IN_FILES;
  LTabSheet.Caption := StringReplace(TabCaption, '&', '&&', [rfReplaceAll]);
  PageControl.ActivePage := LTabSheet;

  { Panel needed because Virtual tree's AlignWithMargins does not work. Remove when fixed. }
  LPanel := TBCPanel.Create(LTabSheet);
  with LPanel do
  begin
    Parent := LTabSheet;
    Align := alClient;
    AlignWithMargins := True;
    Margins.Left := 2;
    Margins.Top := 2;
    if FSkinManager.Active then
      Margins.Right := 2
    else
      Margins.Right := 4;
    Margins.Bottom := 2;
  end;
  LVirtualDrawTree := TVirtualDrawTree.Create(LPanel);
  with LVirtualDrawTree do
  begin
    Parent := LPanel;
    Align := alClient;
    TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoChangeScale];
    TreeOptions.MiscOptions := [toCheckSupport, toFullRepaintOnResize, toToggleOnDblClick, toWheelPanning];
    TreeOptions.PaintOptions := [toHideFocusRect, toShowButtons, toShowRoot, toThemeAware, toGhostedIfUnfocused];
    TreeOptions.SelectionOptions := [toFullRowSelect, toMiddleClickSelect];
    OnDrawNode := VirtualDrawTreeDrawNode;
    OnFreeNode := VirtualDrawTreeFreeNode;
    OnGetNodeWidth := VirtualDrawTreeGetNodeWidth;
    OnInitNode := VirtualDrawTreeInitNode;
    OnDblClick := TabsheetDblClick;
    NodeDataSize := SizeOf(TOutputRec);
  end;
  Result := LVirtualDrawTree;
  LTabSheet.TabVisible := True;
end;

procedure TEBOutput.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree;
  const PaintInfo: TVTPaintInfo);
var
  Data: POutputRec;
  S, Temp: string;
  R: TRect;
  Format: Cardinal;
  LColor: TColor;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    if Assigned(FSkinManager) then
      LColor := FSkinManager.GetActiveEditFontColor
    else
      LColor := clWindowText;

    if vsSelected in PaintInfo.Node.States then
    begin
      if Assigned(FSkinManager) then
      begin
        Canvas.Brush.Color := FSkinManager.GetHighLightColor;
        LColor := FSkinManager.GetHighLightFontColor
      end
      else
      begin
        Canvas.Brush.Color := clHighlight;
        LColor := clHighlightText;
      end;
    end;
    Canvas.Font.Color := LColor;

    if Data.Level = 0 then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold]
    else
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);
    if Data.Level = 2 then
      R.Left := 4;

    if (Data.Level = 0) or (Data.Level = 2) then
      S := Data.Filename
    else
      S := String(Data.Text);

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;
      if (Data.Level = 0) or (Data.Level = 2) or (Data.SearchString = '') then
      begin
        if Data.Level = 0 then
          S := System.SysUtils.Format('%s [%d]', [S, Node.ChildCount]);
        if Data.Level = 1 then
          S := System.SysUtils.Format('%s (%d, %d): ', [ExtractFilename(String(Data.Filename)), Data.Ln + OptionsContainer.LeftMarginLineNumbersStartFrom, Data.Ch]) + S;
        DrawText(Canvas.Handle, S, Length(S), R, Format)
      end
      else
      begin
        S := String(Data.Text);
        S := System.Copy(S, 0, Data.TextCh - 1);

        S := System.SysUtils.Format('%s (%d, %d): ', [ExtractFilename(String(Data.Filename)), Data.Ln + OptionsContainer.LeftMarginLineNumbersStartFrom, Data.Ch]) + S;

        DrawText(Canvas.Handle, S, Length(S), R, Format);
        S := StringReplace(S, Chr(9), '', [rfReplaceAll]); { replace tabs }
        R.Left := R.Left + Canvas.TextWidth(S);
        Canvas.Font.Color := clRed;
        S := Copy(String(Data.Text), Data.TextCh, Length(Data.SearchString));
        Temp := StringReplace(S, '&', '&&', [rfReplaceAll]);
        Canvas.Font.Style := Canvas.Font.Style + [fsBold];
        DrawText(Canvas.Handle, Temp, Length(Temp), R, Format);
        Canvas.Font.Color := LColor;
        R.Left := R.Left + Canvas.TextWidth(S);
        Canvas.Font.Style := Canvas.Font.Style - [fsBold];
        S := System.Copy(Data.Text, Integer(Data.TextCh) + Integer(System.Length(Data.SearchString)), Length(Data.Text));
        DrawText(Canvas.Handle, S, Length(S), R, Format);
      end;
    end;
  end;
end;

procedure TEBOutput.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree;
  HintCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  Data: POutputRec;
  AMargin, BoldWidth: Integer;
  S: string;
begin
  with Sender as TVirtualDrawTree do
  begin
    AMargin := TextMargin;
    Data := Sender.GetNodeData(Node);
    if Assigned(Data) then
    case Data.Level of
      0: begin
           Canvas.Font.Style := Canvas.Font.Style + [fsBold];
           NodeWidth := Canvas.TextWidth(Trim(Format('%s [%d]', [String(Data.FileName), Node.ChildCount]))) + 2 * AMargin;
         end;
      1: begin
           S := System.SysUtils.Format('%s (%d, %d): ', [ExtractFilename(String(Data.Filename)), Data.Ln, Data.Ch]);
           Canvas.Font.Style := Canvas.Font.Style + [fsBold];
           BoldWidth := Canvas.TextWidth(String(Data.SearchString));
           Canvas.Font.Style := Canvas.Font.Style - [fsBold];
           BoldWidth := BoldWidth - Canvas.TextWidth(string(Data.SearchString));
           NodeWidth := Canvas.TextWidth(Trim(S + String(Data.Text))) + 2 * AMargin + BoldWidth;
         end;
    end;
  end;
end;

procedure TEBOutput.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: POutputRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TEBOutput.AddTreeViewLine(OutputTreeView: TVirtualDrawTree; const Filename: WideString; Ln, Ch: LongInt;
  const Text: WideString; const SearchString: WideString);
var
  Node, LastNode: PVirtualNode;
  NodeData: POutputRec;
  s: WideString;
begin
  if not FProcessingTabSheet then
    Exit;
  if FCancelSearch then
    Exit;
  if not Assigned(OutputTreeView) then
    Exit;
  OutputTreeView.BeginUpdate;
  LastNode := OutputTreeView.GetLast;
  if Assigned(LastNode) then
  begin
    NodeData := OutputTreeView.GetNodeData(LastNode);
    if (NodeData.Filename <> FileName) or (NodeData.Ln = -1) then
      LastNode := nil;
  end;
  if not Assigned(LastNode) then
  begin
    FRootNode := OutputTreeView.AddChild(nil);
    NodeData := OutputTreeView.GetNodeData(FRootNode);
    NodeData.Level := 0;
    if Ln = -1 then
    begin
      NodeData.Level := 2;
      NodeData.Filename := Text;
    end
    else
      NodeData.Filename := Filename;
  end;
  if Ln <> -1  then
  begin
    Node := OutputTreeView.AddChild(FRootNode);
    NodeData := OutputTreeView.GetNodeData(Node);
    NodeData.Level := 1;
    NodeData.Ln := Ln;
    NodeData.Ch := Ch;
    NodeData.SearchString := SearchString;
    NodeData.Filename := Filename;

    s := Text;

    if NodeData.SearchString <> '' then
    begin
      if Ch > 255 then
      begin
        NodeData.TextCh := 11;
        s := System.Copy(s, Ch - 10, System.Length(s));
      end
      else
        NodeData.TextCh := Ch;
      if System.Length(s) > 255 then
        s := Format('%s...', [System.Copy(s, 0, 251)]);
    end;

    if toAutoExpand in OutputTreeView.TreeOptions.AutoOptions then
      if not OutputTreeView.Expanded[FRootNode] then
        OutputTreeView.FullExpand(FRootNode);

    NodeData.Text := s;
    OutputTreeView.Tag := OutputTreeView.Tag + 1;
  end;
  OutputTreeView.EndUpdate;
  { fix for scrollbar resize bug }
  SetWindowPos(OutputTreeView.Handle, 0, 0, 0, OutputTreeView.Width, OutputTreeView.Height, SWP_DRAWFRAME);
  Application.ProcessMessages;
end;

function TEBOutput.SelectedLine(var Filename: string; var Ln: LongWord; var Ch: LongWord): Boolean;
var
  Node: PVirtualNode;
  NodeData: POutputRec;
  OutputTreeView: TVirtualDrawTree;
begin
  Result := False;
  OutputTreeView := GetOutputTreeView(PageControl.ActivePage);
  if not Assigned(OutputTreeView) then
    Exit;

  Node := OutputTreeView.GetFirstSelected;
  NodeData := OutputTreeView.GetNodeData(Node);

  Result := Assigned(NodeData) and (NodeData.Text <> '');
  if Result then
  begin
    Filename := String(NodeData.Filename);
    Ln := NodeData.Ln;
    Ch := NodeData.Ch;
  end;
end;

procedure TEBOutput.CopyToClipboard(OnlySelected: Boolean);
var
  OutputTreeView: TVirtualDrawTree;
  Node, ChildNode: PVirtualNode;
  Data, ChildData: POutputRec;
  StringList: TStrings;
begin
  OutputTreeView := GetOutputTreeView(PageControl.ActivePage);
  if Assigned(OutputTreeView) then
  begin
    StringList := TStringList.Create;
    try
      Node := OutputTreeView.GetFirst;
      while Assigned(Node) do
      begin
        if not OnlySelected or OnlySelected and (OutputTreeView.CheckState[Node] = csCheckedNormal) then
        begin
          Data := OutputTreeView.GetNodeData(Node);
          StringList.Add(Data.FileName);
          ChildNode := Node.FirstChild;
          while Assigned(ChildNode) do
          begin
            ChildData := OutputTreeView.GetNodeData(ChildNode);
            StringList.Add(System.SysUtils.Format('  %s (%d, %d): %s', [ExtractFilename(String(ChildData.Filename)),
              ChildData.Ln, ChildData.Ch, ChildData.Text]));
            ChildNode := ChildNode.NextSibling;
          end;
        end;
        Node := Node.NextSibling;
      end;
    finally
      Clipboard.AsText := StringList.Text;
      StringList.Free;
    end;
  end;
end;

function TEBOutput.CheckCancel(ATabIndex: Integer = -1): Boolean;
var
  LTabSheet: TTabSheet;
begin
  Result := False;
  Application.ProcessMessages;
  if ATabIndex <> -1 then
    LTabSheet := PageControl.Pages[ATabIndex]
  else
    LTabSheet := PageControl.ActivePage;
  if FProcessingTabSheet then
    if FProcessingPage = LTabSheet then
    begin
      if AskYesOrNo(LanguageDataModule.GetYesOrNoMessage('CancelSearch')) then
        FCancelSearch := True
      else
        Result := True;
    end;
end;

function TEBOutput.CloseTabSheet(AFreePage: Boolean = True; ATabIndex: Integer = -1): Boolean;
var
  LActivePageIndex: Integer;
begin
  Result := True;

  FPageControl.TabClosed := True;
  if CheckCancel(ATabIndex) then
    Exit(False);
  if FPageControl.PageCount > 0 then
  begin
    if ATabIndex = -1 then
      LActivePageIndex := FPageControl.ActivePageIndex
    else
      LActivePageIndex := ATabIndex;
    if AFreePage and (FPageControl.PageCount > 0) then
    begin
      FPageControl.Pages[LActivePageIndex].Free;
      if LActivePageIndex > 0 then
        FPageControl.ActivePageIndex := LActivePageIndex - 1
      else
      if FPageControl.PageCount > 0 then
        FPageControl.ActivePageIndex := 0;
    end
    else
    begin
      TsTabSheet(FPageControl.Pages[LActivePageIndex]).TabVisible := False;
      FPageControl.Pages[LActivePageIndex].PageIndex := LActivePageIndex + 1;
    end;
  end;
end;

procedure TEBOutput.CloseAllTabSheets;
var
  i, j: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    PageControl.Visible := False;
    j := PageControl.PageCount - 2;
    for i := j downto 0 do
    if TsTabSheet(PageControl.Pages[i]).TabType = ttTab then
      CloseTabSheet(True, i);
    PageControl.Visible := True;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TEBOutput.CloseAllOtherTabSheets;
var
  i, j: Integer;
  LTabSheet: TsTabSheet;
begin
  if CheckCancel then
    Exit;
  LTabSheet := PageControl.ActivePage;
  LTabSheet.PageIndex := 0; { move the page first }
  Screen.Cursor := crHourGlass;
  try
    PageControl.Visible := False;
    j := PageControl.PageCount - 2;
    for i := j downto 1 do
      PageControl.Pages[i].Free;
    PageControl.ActivePage := LTabSheet;
    PageControl.Visible := True;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TEBOutput.SetProcessingTabSheet(Value: Boolean);
begin
  FProcessingTabSheet := Value;
  FProcessingPage := PageControl.ActivePage;
  FCancelSearch := False;
end;

function TEBOutput.GetOutputTreeView(TabSheet: TTabSheet): TVirtualDrawTree;
var
  LPanel: TBCPanel;
begin
  Result := nil;
  if Assigned(TabSheet) then
    if Assigned(TabSheet.Controls[0]) then
      if TabSheet.Controls[0] is TBCPanel then
      begin
        LPanel := TBCPanel(TabSheet.Controls[0]);
        if Assigned(LPanel) then
          if Assigned(LPanel.Controls[0]) then
            if LPanel.Controls[0] is TVirtualDrawTree then
              Result := TVirtualDrawTree(LPanel.Controls[0]);
      end;
end;

procedure TEBOutput.SetOptions;
var
  i: Integer;
  VirtualDrawTree: TVirtualDrawTree;
  Node: PVirtualNode;
begin
  PageControl.MultiLine := OptionsContainer.OutputMultiLine;
  PageControl.ShowCloseBtns := OptionsContainer.OutputShowCloseButton;
  PageControl.RightClickSelect := OptionsContainer.OutputRightClickSelect;
  FTabSheetFindInFiles.TabVisible := OptionsContainer.OutputShowFindInFilesButton;

  if OptionsContainer.OutputShowImage then
    PageControl.Images := ImagesDataModule.ImageListSmall
  else
    PageControl.Images := nil;

  for i := 0 to PageControl.PageCount - 2 do
  begin
    VirtualDrawTree := GetOutputTreeView(PageControl.Pages[i]);
    VirtualDrawTree.Indent := OptionsContainer.OutputIndent;
    if OptionsContainer.OutputShowTreeLines then
      VirtualDrawTree.TreeOptions.PaintOptions := VirtualDrawTree.TreeOptions.PaintOptions + [toShowTreeLines]
    else
      VirtualDrawTree.TreeOptions.PaintOptions := VirtualDrawTree.TreeOptions.PaintOptions - [toShowTreeLines];

    { check box }
    Node := VirtualDrawTree.GetFirst;
    while Assigned(Node) do
    begin
      VirtualDrawTree.ReinitNode(Node, False);
      Node := VirtualDrawTree.GetNextSibling(Node);
    end;
  end;
end;

procedure TEBOutput.SetCheckedState(Value: TCheckState);
var
  OutputTreeView: TVirtualDrawTree;
  Node: PVirtualNode;
begin
  OutputTreeView := GetOutputTreeView(PageControl.ActivePage);
  Node := OutputTreeView.GetFirst;
  while Assigned(Node) do
  begin
    OutputTreeView.CheckState[Node] := Value;
    Node := Node.NextSibling;
  end;
end;

procedure TEBOutput.ReadOutputFile;
var
  Filename, S: string;
  OutputFile: TStreamReader;
  VirtualDrawTree: TVirtualDrawTree;
  AFilename, Text, SearchString: string;
  Ln, Ch: Cardinal;
begin
  FProcessingTabSheet := True;
  VirtualDrawTree := nil;
  Filename := GetOutFilename;
  if FileExists(Filename) then
  begin
    OutputFile := TStreamReader.Create(Filename, TEncoding.Unicode);
    try
      while not OutputFile.EndOfStream do
      begin
        S := OutputFile.ReadLine;
        if Pos('s:', S) = 1 then
          VirtualDrawTree := AddTreeView(Format(LanguageDataModule.GetConstant('SearchFor'), [Copy(S, 3, Length(S))]))
        else
        begin
          if Assigned(VirtualDrawTree) then
          begin
            AFilename := GetNextToken(OUTPUT_FILE_SEPARATOR, S);
            S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
            Ln := StrToInt(GetNextToken(OUTPUT_FILE_SEPARATOR, S));
            S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
            Ch := StrToInt(GetNextToken(OUTPUT_FILE_SEPARATOR, S));
            S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
            Text := GetNextToken(OUTPUT_FILE_SEPARATOR, S);
            S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
            SearchString := S;
            AddTreeViewLine(VirtualDrawTree, AFilename, Ln, Ch, Text, SearchString);
          end;
        end;
      end;
    finally
      OutputFile.Free;
    end;
  end;
  FProcessingTabSheet := False;
end;

procedure TEBOutput.WriteOutputFile;
var
  i: Integer;
  Filename: string;
  OutputFile: TStreamWriter;
  Node: PVirtualNode;
  NodeData: POutputRec;
  VirtualDrawTree: TVirtualDrawTree;
begin
  FProcessingTabSheet := True;
  Filename := GetOutFilename;
  if FileExists(Filename) then
    DeleteFile(Filename);
  if OptionsContainer.OutputSaveTabs then
    if PageControl.PageCount > 0 then
    begin
      OutputFile := TStreamWriter.Create(Filename, False, TEncoding.Unicode);
      try
        for i := 0 to PageControl.PageCount - 2 do
        begin
          VirtualDrawTree := GetOutputTreeView(PageControl.Pages[i]);
          if Assigned(VirtualDrawTree) then
          begin
            { tab sheet }
            Node := VirtualDrawTree.GetFirst;
            Node := VirtualDrawTree.GetFirstChild(Node);
            if Assigned(Node) then
            begin
              NodeData := VirtualDrawTree.GetNodeData(Node);
              OutputFile.Writeline(Format('s:%s', [NodeData.SearchString]));
            end;
            { data }
            while Assigned(Node) do
            begin
              NodeData := VirtualDrawTree.GetNodeData(Node);
              if NodeData.SearchString <> '' then
                OutputFile.WriteLine(Format('%s%s%d%s%d%s%s%s%s', [NodeData.Filename, OUTPUT_FILE_SEPARATOR, NodeData.Ln,
                  OUTPUT_FILE_SEPARATOR, NodeData.Ch, OUTPUT_FILE_SEPARATOR, NodeData.Text, OUTPUT_FILE_SEPARATOR, NodeData.SearchString]));
              Node := VirtualDrawTree.GetNext(Node);
            end;
          end;
        end;
      finally
        OutputFile.Free;
      end;
    end;
  FProcessingTabSheet := False;
end;

procedure TEBOutput.VirtualDrawTreeInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: POutputRec;
begin
  with Sender do
  if OptionsContainer.OutputShowCheckBox then
  begin
    if GetNodeLevel(Node) = 0 then
    begin
      Data := Sender.GetNodeData(Node);
      if Data.Level <> 2 then
      begin
        CheckType[Node] := ctCheckBox;
        CheckState[Node] := csCheckedNormal;
      end;
    end
  end
  else
    CheckType[Node] := ctNone;
end;

end.
