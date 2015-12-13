unit EditBone.Dialog.Popup.Highlighter.Color;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls, BCControls.ButtonedEdit, sSkinProvider,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList;

type
  TSelectEncodingEvent = procedure(AId: Integer) of object;

  TPopupHighlighterColorDialog = class(TForm)
    VirtualDrawTree: TVirtualDrawTree;
    SkinProvider: TsSkinProvider;
    procedure VirtualDrawTreeDblClick(Sender: TObject);
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSelectEncoding: TSelectEncodingEvent;
    procedure WMActivate(var AMessage: TWMActivate); message WM_ACTIVATE;
  public
    procedure Execute(ASelectedEncoding: string);
    property OnSelectEncoding: TSelectEncodingEvent read FSelectEncoding write FSelectEncoding;
  end;

implementation

{$R *.dfm}

uses
  System.Types, BCControls.Utils, sGraphUtils, sVclUtils, sDefaults, System.Math;

type
  PSearchRec = ^TSearchRec;
  TSearchRec = packed record
    Id: Integer;
    Name: string;
  end;

procedure TPopupHighlighterColorDialog.FormCreate(Sender: TObject);
begin
  VirtualDrawTree.NodeDataSize := SizeOf(TSearchRec);
end;

procedure TPopupHighlighterColorDialog.FormShow(Sender: TObject);
begin
   VirtualDrawTree.SetFocus;
end;

procedure TPopupHighlighterColorDialog.Execute(ASelectedEncoding: string);
var
  Node: PVirtualNode;
  NodeData: PSearchRec;
  LWidth, LMaxWidth: Integer;

  procedure AddEncoding(AId: Integer);
  var
    LName: string;
  begin
    //LName := ENCODING_CAPTIONS[AId];

    Node := VirtualDrawTree.AddChild(nil);
    NodeData := VirtualDrawTree.GetNodeData(Node);

    LWidth := VirtualDrawTree.Canvas.TextWidth(LName);
    if LWidth > LMaxWidth then
      LMaxWidth := LWidth;

    NodeData.Id := AId;
    NodeData.Name := LName;
    VirtualDrawTree.Selected[Node] := ASelectedEncoding = LName;
  end;

begin
  LMaxWidth := 0;

  VirtualDrawTree.Invalidate;

  Width := LMaxWidth + 80;
  Height := Min(Integer(VirtualDrawTree.DefaultNodeHeight) * 7 + VirtualDrawTree.Margins.Top +
    VirtualDrawTree.Margins.Bottom + BorderWidth * 2 + 2, TForm(Self.PopupParent).Height);

  Visible := True;
end;

procedure TPopupHighlighterColorDialog.VirtualDrawTreeDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PSearchRec;
begin
  Node := VirtualDrawTree.GetFirstSelected;
  Data := VirtualDrawTree.GetNodeData(Node);
  if Assigned(Data) then
    if Assigned(FSelectEncoding) then
      FSelectEncoding(Data.Id);
end;

procedure TPopupHighlighterColorDialog.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
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

    S := Data.Name;

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;

      DrawText(Canvas.Handle, S, Length(S), R, Format);
    end;
  end;
end;

procedure TPopupHighlighterColorDialog.WMActivate(var AMessage: TWMActivate);
begin
  if AMessage.Active <> WA_INACTIVE then
    SendMessage(Self.PopupParent.Handle, WM_NCACTIVATE, WPARAM(True), -1);

  inherited;

  if AMessage.Active = WA_INACTIVE then
    Release;
end;

procedure TPopupHighlighterColorDialog.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PSearchRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TPopupHighlighterColorDialog.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
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
      NodeWidth := Canvas.TextWidth(Data.Name) + 2 * AMargin;
  end;
end;

end.
