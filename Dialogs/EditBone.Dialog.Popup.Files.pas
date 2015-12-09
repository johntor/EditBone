unit EditBone.Dialog.Popup.Files;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls, BCControls.ButtonedEdit, sSkinProvider,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList;

type
  TSelectFileEvent = procedure(var APageIndex: Integer) of object;

  TPopupFilesDialog = class(TForm)
    VirtualDrawTreeSearch: TVirtualDrawTree;
    SkinProvider: TsSkinProvider;
    ButtonedEdit: TBCButtonedEdit;
    ActionList: TActionList;
    ActionClear: TAction;
    ActionSearch: TAction;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionSearchExecute(Sender: TObject);
    procedure VirtualDrawTreeSearchCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: Integer);
    procedure VirtualDrawTreeSearchDblClick(Sender: TObject);
    procedure VirtualDrawTreeSearchDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeSearchFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeSearchGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VirtualDrawTreeSearchGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSelectFile: TSelectFileEvent;
    procedure SetVisibleRows;
    procedure WMActivate(var AMessage: TWMActivate); message WM_ACTIVATE;
  public
    procedure Execute(AFiles: TStrings; ASelectedFile: string);
    property OnSelectFile: TSelectFileEvent read FSelectFile write FSelectFile;
  end;

implementation

{$R *.dfm}

uses
  System.Types, BCControls.Utils, sGraphUtils, sVclUtils, sDefaults, System.Math;

type
  PSearchRec = ^TSearchRec;
  TSearchRec = packed record
    FileName: string;
    FilePath: string;
    ImageIndex: Integer;
    PageIndex: Integer;
  end;

procedure TPopupFilesDialog.FormCreate(Sender: TObject);
var
  SysImageList: THandle;
begin
  VirtualDrawTreeSearch.NodeDataSize := SizeOf(TSearchRec);
  VirtualDrawTreeSearch.Images := TImageList.Create(Self);
  SysImageList := GetSysImageList;
  if SysImageList <> 0 then
  begin
    VirtualDrawTreeSearch.Images.Handle := SysImageList;
    VirtualDrawTreeSearch.Images.BkColor := clNone;
    VirtualDrawTreeSearch.Images.ShareImages := True;
  end;
end;

procedure TPopupFilesDialog.Execute(AFiles: TStrings; ASelectedFile: string);
var
  i: Integer;
  Node: PVirtualNode;
  NodeData: PSearchRec;
  LFileName, LSelectedFile: string;
  LWidth, LMaxWidth: Integer;
begin
  LMaxWidth := 0;
  LSelectedFile := Copy(ASelectedFile, 2, Length(ASelectedFile) - 2); { Remove [] }
  for i := 0 to AFiles.Count - 1 do
  begin
    Node := VirtualDrawTreeSearch.AddChild(nil);
    NodeData := VirtualDrawTreeSearch.GetNodeData(Node);
    LFileName := AFiles[i];

    LWidth := VirtualDrawTreeSearch.Canvas.TextWidth(LFileName);
    if LWidth > LMaxWidth then
      LMaxWidth := LWidth;

    NodeData.FileName := ExtractFileName(LFileName);
    NodeData.FilePath := ExtractFilePath(LFileName);
    NodeData.ImageIndex := GetIconIndex(LFileName);
    if NodeData.ImageIndex = -1 then
      NodeData.ImageIndex := 0;
    NodeData.PageIndex := Integer(AFiles.Objects[i]);
    VirtualDrawTreeSearch.Selected[Node] := LSelectedFile = LFileName;
  end;
  {$WARNINGS ON}
  VirtualDrawTreeSearch.Sort(nil, 0, sdAscending, False);
  VirtualDrawTreeSearch.Invalidate;
  Width := LMaxWidth + 80;
  Height := Min(Integer(VirtualDrawTreeSearch.DefaultNodeHeight) * AFiles.Count + ButtonedEdit.Height + 13, TForm(Self.PopupParent).Height);

  Visible := True;
end;

procedure TPopupFilesDialog.FormDestroy(Sender: TObject);
begin
  VirtualDrawTreeSearch.Images.Free;
end;

procedure TPopupFilesDialog.FormShow(Sender: TObject);
begin
  ButtonedEdit.SetFocus;
end;

procedure TPopupFilesDialog.VirtualDrawTreeSearchCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PSearchRec;
begin
  if Result = 0 then
  begin
    Data1 := VirtualDrawTreeSearch.GetNodeData(Node1);
    Data2 := VirtualDrawTreeSearch.GetNodeData(Node2);

    Result := -1;

    if not Assigned(Data1) or not Assigned(Data2) then
      Exit;

    Result := AnsiCompareText(Data1.FileName, Data2.FileName);
  end;
end;

procedure TPopupFilesDialog.VirtualDrawTreeSearchDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PSearchRec;
begin
  Node := VirtualDrawTreeSearch.GetFirstSelected;
  Data := VirtualDrawTreeSearch.GetNodeData(Node);
  if Assigned(Data) then
    if Assigned(FSelectFile) then
      FSelectFile(Data.PageIndex);
end;

procedure TPopupFilesDialog.VirtualDrawTreeSearchDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  Data: PSearchRec;
  S: string;
  R: TRect;
  Format: Cardinal;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetActiveEditFontColor;

    if vsSelected in PaintInfo.Node.States then
    begin
      Canvas.Brush.Color := SkinProvider.SkinData.SkinManager.GetHighLightColor;
      Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetHighLightFontColor
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);

    S := Data.Filename;

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;

      DrawText(Canvas.Handle, S, Length(S), R, Format);
      if Data.FilePath <> '' then
      begin
        R.Left := R.Left + Canvas.TextWidth(S);
        S := System.SysUtils.Format(' (%s)', [Data.FilePath]);
        Canvas.Font.Color := MixColors(ColorToRGB(Font.Color), GetControlColor(Parent), DefDisabledBlend);
        DrawText(Canvas.Handle, S, Length(S), R, Format);
      end;
    end;
  end;
end;

procedure TPopupFilesDialog.WMActivate(var AMessage: TWMActivate);
begin
  if AMessage.Active <> WA_INACTIVE then
    SendMessage(Self.PopupParent.Handle, WM_NCACTIVATE, WPARAM(True), -1);

  inherited;

  if AMessage.Active = WA_INACTIVE then
    Release;
end;

procedure TPopupFilesDialog.ActionClearExecute(Sender: TObject);
begin
  ButtonedEdit.Text := '';
end;

procedure TPopupFilesDialog.ActionSearchExecute(Sender: TObject);
begin
  ButtonedEdit.RightButton.Visible := Trim(ButtonedEdit.Text) <> '';
  SetVisibleRows;
end;

procedure TPopupFilesDialog.SetVisibleRows;
var
  CurNode: PVirtualNode;
  Data: PSearchRec;
begin
  with VirtualDrawTreeSearch do
  begin
    CurNode := GetFirst;
    while Assigned(CurNode) do
    begin
      Data := GetNodeData(CurNode);
      IsVisible[CurNode] := (Pos(UpperCase(ButtonedEdit.Text), UpperCase(Data.FileName)) <> 0) or (ButtonedEdit.Text = '');
      CurNode := CurNode.NextSibling;
    end;
  end;
end;

procedure TPopupFilesDialog.VirtualDrawTreeSearchFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PSearchRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TPopupFilesDialog.VirtualDrawTreeSearchGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PSearchRec;
begin
  Data := VirtualDrawTreeSearch.GetNodeData(Node);
  if Assigned(Data) then
    ImageIndex := Data.ImageIndex;
end;

procedure TPopupFilesDialog.VirtualDrawTreeSearchGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  Data: PSearchRec;
  AMargin: Integer;
begin
  with Sender as TVirtualDrawTree do
  begin
    AMargin := TextMargin;
    Data := GetNodeData(Node);
    if Assigned(Data) then
      NodeWidth := Canvas.TextWidth(Format('%s (%s)', [Data.FileName, Data.FilePath])) + 2 * AMargin;
  end;
end;

end.
