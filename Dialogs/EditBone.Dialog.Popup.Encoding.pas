unit EditBone.Dialog.Popup.Encoding;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls, BCControls.ButtonedEdit, sSkinProvider,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList;

type
  TSelectEncodingEvent = procedure(var AId: Integer) of object;

  TPopupEncodingDialog = class(TForm)
    VirtualDrawTreeSearch: TVirtualDrawTree;
    SkinProvider: TsSkinProvider;
    procedure VirtualDrawTreeSearchDblClick(Sender: TObject);
    procedure VirtualDrawTreeSearchDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeSearchFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeSearchGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure FormCreate(Sender: TObject);
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
  System.Types, BCControls.Utils, BCCommon.Consts, sGraphUtils, sVclUtils, sDefaults, System.Math;

type
  PSearchRec = ^TSearchRec;
  TSearchRec = packed record
    Id: Integer;
    Name: string;
  end;

procedure TPopupEncodingDialog.FormCreate(Sender: TObject);
begin
  VirtualDrawTreeSearch.NodeDataSize := SizeOf(TSearchRec);
end;

procedure TPopupEncodingDialog.Execute(ASelectedEncoding: string);
var
  Node: PVirtualNode;
  NodeData: PSearchRec;
  LWidth, LMaxWidth: Integer;

  procedure AddEncoding(AId: Integer; AName: string);
  begin
    Node := VirtualDrawTreeSearch.AddChild(nil);
    NodeData := VirtualDrawTreeSearch.GetNodeData(Node);

    LWidth := VirtualDrawTreeSearch.Canvas.TextWidth(AName);
    if LWidth > LMaxWidth then
      LMaxWidth := LWidth;

    NodeData.Id := AId;
    NodeData.Name := AName;
    VirtualDrawTreeSearch.Selected[Node] := ASelectedEncoding = AName;
  end;

begin
  LMaxWidth := 0;

  AddEncoding(ENCODING_ANSI, ENCODING_ANSI_CAPTION);
  AddEncoding(ENCODING_ASCII, ENCODING_ASCII_CAPTION);
  AddEncoding(ENCODING_BIG_ENDIAN_UNICODE, ENCODING_BIG_ENDIAN_UNICODE_CAPTION);
  AddEncoding(ENCODING_UNICODE, ENCODING_UNICODE_CAPTION);
  AddEncoding(ENCODING_UTF7, ENCODING_UTF7_CAPTION);
  AddEncoding(ENCODING_UTF8, ENCODING_UTF8_CAPTION);
  AddEncoding(ENCODING_UTF_WITHOUT_BOM, ENCODING_UTF_WITHOUT_BOM_CAPTION);

  VirtualDrawTreeSearch.Invalidate;
  Width := LMaxWidth + 80;
  Height := Min(Integer(VirtualDrawTreeSearch.DefaultNodeHeight) * 7 + 8, TForm(Self.PopupParent).Height);

  Visible := True;
end;

procedure TPopupEncodingDialog.VirtualDrawTreeSearchDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PSearchRec;
begin
  Node := VirtualDrawTreeSearch.GetFirstSelected;
  Data := VirtualDrawTreeSearch.GetNodeData(Node);
  if Assigned(Data) then
    if Assigned(FSelectEncoding) then
      FSelectEncoding(Data.Id);
end;

procedure TPopupEncodingDialog.VirtualDrawTreeSearchDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
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

procedure TPopupEncodingDialog.WMActivate(var AMessage: TWMActivate);
begin
  if AMessage.Active <> WA_INACTIVE then
    SendMessage(Self.PopupParent.Handle, WM_NCACTIVATE, WPARAM(True), -1);

  inherited;

  if AMessage.Active = WA_INACTIVE then
    Release;
end;

procedure TPopupEncodingDialog.VirtualDrawTreeSearchFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PSearchRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TPopupEncodingDialog.VirtualDrawTreeSearchGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
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
