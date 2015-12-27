unit EditBone.Frame.Options.Directory;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControl.Edit,
  BCCommon.Options.Container,  BCCommon.Frames.Options.Base,
  BCControl.Panel, acSlider, sLabel, sComboBox, BCControl.ComboBox, sEdit, Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TOptionsDirectoryFrame = class(TBCOptionsBaseFrame)
    StickyLabelShowArchiveFiles: TsStickyLabel;
    StickyLabelShowHiddenFiles: TsStickyLabel;
    StickyLabelShowOverlayIcons: TsStickyLabel;
    StickyLabelShowSystemFiles: TsStickyLabel;
    StickyLabelShowTreeLines: TsStickyLabel;
    SliderShowTreeLines: TsSlider;
    SliderShowHiddenFiles: TsSlider;
    SliderShowSystemFiles: TsSlider;
    SliderShowArchiveFiles: TsSlider;
    SliderShowOverlayIcons: TsSlider;
    EditIndent: TBCEdit;
    Panel: TBCPanel;
    SliderAutoHide: TsSlider;
    StickyLabelAutoHide: TsStickyLabel;
    ComboBoxAlign: TBCComboBox;
  protected
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsDirectoryFrame(AOwner: TComponent): TOptionsDirectoryFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Utils, BCCommon.Language.Strings;

var
  FOptionsDirectoryFrame: TOptionsDirectoryFrame;

function OptionsDirectoryFrame(AOwner: TComponent): TOptionsDirectoryFrame;
begin
  if not Assigned(FOptionsDirectoryFrame) then
    FOptionsDirectoryFrame := TOptionsDirectoryFrame.Create(AOwner);
  Result := FOptionsDirectoryFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsDirectoryFrame.Destroy;
begin
  inherited;
  FOptionsDirectoryFrame := nil;
end;

procedure TOptionsDirectoryFrame.Init;
begin
  with ComboBoxAlign.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Left'));
    Add(LanguageDatamodule.GetSQLFormatter('Right'));
  end;
end;

procedure TOptionsDirectoryFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderAutoHide.SliderOn := DirAutoHide;
    SliderShowTreeLines.SliderOn := DirShowTreeLines;
    EditIndent.Text := IntToStr(DirIndent);
    SliderShowHiddenFiles.SliderOn := DirShowHiddenFiles;
    SliderShowSystemFiles.SliderOn := DirShowSystemFiles;
    SliderShowArchiveFiles.SliderOn := DirShowArchiveFiles;
    SliderShowOverlayIcons.SliderOn := DirShowOverlayIcons;
    ComboBoxAlign.ItemIndex := DirAlign;
  end;
end;

procedure TOptionsDirectoryFrame.PutData;
begin
  with OptionsContainer do
  begin
    DirAutoHide := SliderAutoHide.SliderOn;
    DirShowTreeLines := SliderShowTreeLines.SliderOn;
    DirShowHiddenFiles := SliderShowHiddenFiles.SliderOn;
    DirShowSystemFiles := SliderShowSystemFiles.SliderOn;
    DirShowArchiveFiles := SliderShowArchiveFiles.SliderOn;
    DirIndent := StrToIntDef(EditIndent.Text, 20);
    DirShowOverlayIcons := SliderShowOverlayIcons.SliderOn;
    DirAlign := ComboBoxAlign.ItemIndex;
  end;
end;

end.
