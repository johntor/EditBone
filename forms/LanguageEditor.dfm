object LanguageEditorForm: TLanguageEditorForm
  Left = 0
  Top = 0
  Caption = 'Language Editor - [%s]'
  ClientHeight = 474
  ClientWidth = 820
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 455
    Width = 820
    Height = 19
    Panels = <
      item
        Width = 86
      end
      item
        Width = 86
      end
      item
        Width = 86
      end>
  end
  object VirtualTreePanel: TPanel
    Left = 0
    Top = 27
    Width = 820
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 4
    Padding.Right = 4
    Padding.Bottom = 4
    TabOrder = 1
    object VirtualDrawTree: TVirtualDrawTree
      Left = 4
      Top = 0
      Width = 812
      Height = 424
      Align = alClient
      BorderWidth = 1
      Ctl3D = True
      DragOperations = []
      EditDelay = 0
      Header.AutoSizeIndex = 0
      Header.DefaultHeight = 20
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Height = 20
      Header.Images = ImageList
      Header.Options = [hoColumnResize, hoShowSortGlyphs, hoVisible]
      Images = ImageList
      ParentCtl3D = False
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand]
      TreeOptions.MiscOptions = [toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
      TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedSelection]
      TreeOptions.SelectionOptions = [toDisableDrawSelection, toExtendedFocus, toMiddleClickSelect, toRightClickSelect]
      WantTabs = True
      OnCompareNodes = VirtualDrawTreeCompareNodes
      OnCreateEditor = VirtualDrawTreeCreateEditor
      OnDrawNode = VirtualDrawTreeDrawNode
      OnEdited = VirtualDrawTreeEdited
      OnEditing = VirtualDrawTreeEditing
      OnFreeNode = VirtualDrawTreeFreeNode
      OnGetImageIndex = VirtualDrawTreeGetImageIndex
      OnGetNodeWidth = VirtualDrawTreeGetNodeWidth
      OnInitChildren = VirtualDrawTreeInitChildren
      OnInitNode = VirtualDrawTreeInitNode
      Columns = <
        item
          Position = 0
          Width = 220
          WideText = 'Object'
        end
        item
          Position = 1
          Width = 220
          WideText = 'Caption'
        end
        item
          Position = 2
          Width = 220
          WideText = 'Hint'
        end
        item
          Position = 3
          Width = 120
          WideText = 'Shortcut'
        end>
    end
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 0
    Width = 820
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 2
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 56
      Top = 4
      Width = 4
      Height = 19
      Margins.Left = 6
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      Shape = bsLeftLine
      ExplicitLeft = 84
      ExplicitTop = 5
    end
    object SaveToolBar: TBCToolBar
      Left = 2
      Top = 2
      Width = 48
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      ButtonWidth = 24
      Images = ImageList
      TabOrder = 0
      object ZoomToolButton: TToolButton
        Left = 0
        Top = 0
        Action = FileNewAction
      end
      object ToolButton2: TToolButton
        Left = 24
        Top = 0
        Action = FileOpenAction
      end
    end
    object PrintToolBar: TBCToolBar
      Left = 63
      Top = 2
      Width = 48
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      ButtonWidth = 24
      Caption = 'ZoomToolBar'
      Images = ImageList
      TabOrder = 1
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = FileSaveAction
      end
      object ToolButton3: TToolButton
        Left = 24
        Top = 0
        Action = FileSaveAsAction
      end
    end
  end
  object ImageList: TBCImageList
    Left = 84
    Top = 54
    Bitmap = {
      494C0101080058026C0510001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008D8D8D005151510051515100515151005151510051515100515151005151
      51005151510051515100515151008D8D8D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000919191004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A009191910000000000000000008D8D8D0051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      510051515100515151008D8D8D00000000000000000000000000000000000000
      000051515100A7F4F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4
      F600A7F4F600A7F4F600A7F4F600515151000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD00DFFBFD004D4D4D00000000000000000051515100A7F4F600A7F4F600A7F4
      F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4
      F600A7F4F600A7F4F60051515100000000008D8D8D0051515100515151005151
      5100515151005151510051515100515151005151510051515100515151008D8D
      8D00DFFBFD00DFFBFD00A7F4F600515151000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DFFBFD004D4D4D00000000000000000051515100FFFFFF00DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD00DFFBFD00A7F4F600515151000000000051515100A7F4F600A7F4F600A7F4
      F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4F600A7F4F6005151
      5100DFFBFD00DFFBFD00A7F4F600515151002020200040404000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      4000404040004040400040404000606060000000000066666600FFFFFF00FFFF
      FF00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00FFFF
      FF00DFFBFD004D4D4D00000000000000000051515100FFFFFF00DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD00DFFBFD00A7F4F600515151000000000051515100FFFFFF00DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00A7F4F6005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00AFAFAF00AFAFAF00AFAF
      AF00AFAFAF00AFAFAF00AFAFAF00AFAFAF00AFAFAF00AFAFAF00AFAFAF00AFAF
      AF00AFAFAF00AFAFAF0090909000404040000000000066666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DFFBFD004D4D4D00000000000000000051515100FFFFFF008D8D8D008D8D
      8D008D8D8D008D8D8D008D8D8D00DFFBFD00DFFBFD008D8D8D008D8D8D008D8D
      8D008D8D8D00A7F4F600515151000000000051515100FFFFFF00DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00A7F4F6005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00FFFF
      FF00DFFBFD004D4D4D00000000000000000051515100FFFFFF008D8D8D00FFFF
      FF00FFFFFF00FFFFFF008D8D8D00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD008D8D8D00A7F4F600515151000000000051515100FFFFFF00DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00A7F4F6005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DFFBFD004D4D4D00000000000000000051515100FFFFFF008D8D8D00FFFF
      FF00FFFFFF00FFFFFF008D8D8D00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD00DFFBFD00A7F4F600515151000000000051515100FFFFFF00DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00A7F4F6005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00FFFF
      FF00DFFBFD004D4D4D00000000000000000051515100FFFFFF008D8D8D00FFFF
      FF00FFFFFF00FFFFFF008D8D8D00DFFBFD00DFFBFD008D8D8D008D8D8D008D8D
      8D008D8D8D00A7F4F600515151000000000051515100FFFFFF00DFFBFD00DFFB
      FD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFBFD00A7F4F6005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DFFBFD004D4D4D00000000000000000051515100FFFFFF008D8D8D00FFFF
      FF00FFFFFF00FFFFFF008D8D8D00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD008D8D8D00A7F4F600515151000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D00DFFB
      FD00DFFBFD004D4D4D00000000000000000051515100FFFFFF008D8D8D00FFFF
      FF00FFFFFF00FFFFFF008D8D8D00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD00DFFBFD00A7F4F60051515100000000005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFFB
      FD00DFFBFD004D4D4D00000000000000000051515100FFFFFF008D8D8D008D8D
      8D008D8D8D008D8D8D008D8D8D00DFFBFD00DFFBFD00DFFBFD00DFFBFD00DFFB
      FD00DFFBFD00A7F4F600515151000000000051515100B0903D00B0903D00B090
      3D00B0903D00B0903D00B0903D0051515100C6C6C60051515100C6C6C6005151
      5100DFFBFD00DFFBFD00A7F4F600515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00B0903D00B0903D00B0903D00B0903D00FFFFFF00FFFFFF00666666006666
      6600666666004D4D4D00000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0051515100000000008D8D8D0051515100515151005151
      5100515151005151510051515100515151005151510051515100515151008D8D
      8D00FFFFFF00FFFFFF00FFFFFF00515151007F7F7F00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00AFAFAF00404040000000000066666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0066666600EAFF
      FF00EAFFFF004D4D4D0000000000000000005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100515151005151510051515100000000000000000000000000000000000000
      0000515151005151510051515100515151005151510051515100515151005151
      5100515151005151510051515100515151003F3F3F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F00404040000000000066666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0066666600EAFF
      FF006666660000000000000000000000000051515100B0903D00B0903D00B090
      3D00B0903D00B0903D00B0903D00B0903D00B0903D00B0903D0051515100C6C6
      C60051515100C6C6C60051515100000000000000000000000000000000000000
      000051515100B0903D00B0903D00B0903D00B0903D00B0903D00B0903D005151
      5100C6C6C60051515100C6C6C600515151003F0000007F0000007F0000007F00
      00007F0000007F0000007F0000007F0000007F0000007F0000007F0000007F00
      0000303030003030300030303000202020000000000099999900666666006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600000000000000000000000000000000008D8D8D0051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      510051515100515151008D8D8D00000000000000000000000000000000000000
      00008D8D8D005151510051515100515151005151510051515100515151005151
      51005151510051515100515151008D8D8D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C2A6A400C2A6
      A400C2A6A400C2A6A400C2A6A400C2A6A400C2A6A400C2A6A400C2A6A400C2A6
      A400C2A6A400C2A6A400000000000000000000000000078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0585900A5787800CBBE
      BC00F1EDEB00E5E6E500A3575600A53F3F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C2A6A400FEFC
      FB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFC
      FB00FEFCFB00C2A6A4000000000000000000078DBE0025A1D10072C7E70085D7
      FA0066CDF90065CDF90065CDF90065CDF90065CDF80065CDF90065CDF80066CE
      F90039ADD800078DBE00000000000000000000000000000000007F2B28007F2B
      2800A1828300A1828300A1828300A1828300A1828300A1828300A18283007A1C
      1C007F2B2800000000000000000000000000C4716D00CD646400A46868009D45
      4400E5D9D800FEFEFE00A9585700A53F3F00B55C5D0000000000000000000000
      0000000000000000000000000000000000000000000000000000C2A6A400FEFC
      FB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFCFB00FEFC
      FB00FEFCFB00C2A6A4000000000000000000078DBE004CBCE70039A8D100A0E2
      FB006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
      F9003EB1D90084D7EB00078DBE0000000000000000007F2B2800CA4D4D00B645
      4500DDD4D5007916170079161700DCE0E000D7DADE00CED5D700BDBABD007610
      0F009A2D2D007F2B28000000000000000000C4716D00CD646400B57A7A009F55
      5400B1A1A000F1EDEB0005720A0005720A00087F0F0005720A00000000000000
      0000000000000000000000000000000000000000000000000000C2A6A400FEFA
      F500FEFCFB00FEFAF500FEFAF500FEFCFB00FEFAF500FEFAF500FEFCFB00FEFA
      F500FEFAF500C2A6A4000000000000000000078DBE0072D6FA00078DBE00AEEA
      FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
      FA0044B5D900AEF1F900078DBE0000000000000000007F2B2800C24A4B00B144
      4400E2D9D9007916170079161700D9D8DA00D9DEE100D3D9DC00C1BDC1007611
      1100982D2D007F2B28000000000000000000C16F6B00C0585900C8717100CB80
      7F00C3727200CA787800C16F6B00CD64640005720A000C9918000A9114000572
      0A00000000000000000000000000000000000000000000000000C2A6A400FEFA
      F500FEFAF500FEFAF500FEFAF500FEFAF500FEFAF500FEFAF500FEFAF500FEFA
      F500FEFAF500C2A6A4000000000000000000078DBE0079DDFB001899C7009ADF
      F30092E7FB0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
      FC0048B9DA00B3F4F900078DBE0000000000000000007F2B2800C24A4A00B042
      4200E6DCDC007916170079161700D5D3D500D8DEE100D7DDE000C6C2C500700F
      0F00962C2C007F2B28000000000000000000B7645E00D09C9A00EEDCDC00EEDC
      DC00EEDCDC00EED8D700EFE3E100D28E8D00AD4C4D0005720A000FA31B000A91
      140005720A000000000000000000000000000000000000000000C2A6A400FEF7
      F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7
      F000FEF7F000C2A6A4000000000000000000078DBE0082E3FC0043B7DC0065C3
      E000ACF0FD008DEBFC008DEBFC008DEBFD008DEBFD008DEBFC008DEBFD000C85
      18004CBBDA00B6F7F9006DCAE000078DBE00000000007F2B2800C24A4A00B041
      4100EADEDE00E7DDDD00DDD4D500D7D3D500D5D7D900D7D8DA00CAC2C5007E17
      17009E3131007F2B28000000000000000000B7645E00E6CCCA00F3F8F700EAE9
      E900EAE9E900EAE9E900F2F6F500D28E8D00AD4C4D00B781830005720A0011A9
      200005720A00B7818300B7818300B78183000000000000000000C2A6A400FEF7
      F000FEF7F000FEF7F000FEF7F000FEF3E900FEF7F000FEF7F000FEF3E900FEF7
      F000FEF7F000C2A6A4000000000000000000078DBE008AEAFC0077DCF300229C
      C600FDFFFF00C8F7FE00C9F7FE00C9F7FE00C9F7FE00C8F7FE000C8518003CBC
      5D000C851800DEF9FB00D6F6F900078DBE00000000007F2B2800BF474800B845
      4500BA4C4C00BD575700BB575600B64E4E00B4494900BD525100BB4B4C00B542
      4200BF4A4A007F2B28000000000000000000B7645E00E5C6C500E5E6E500DBD7
      D700DDD9D900DDD9D900EAE9E900D28E8D00AD4C4D00FAE7C60005720A001FB6
      350005720A00F3D29800F9DB9B00B78183000000000000000000C2A6A400FEF3
      E900FEF3E900FEF3E900FEF3E900FEF3E900FEF3E900FEF3E900FEF3E900FEF3
      E900FEF3E900C2A6A4000000000000000000078DBE0093F0FE0093F0FD001697
      C500078DBE00078DBE00078DBE00078DBE00078DBE000C85180052D97F0062ED
      970041C465000C851800078DBE00078DBE00000000007F2B2800A33B3900B160
      5D00C6868400CB918F00CC919000CC908F00CB898800C9898800CB939100CC96
      9600BD4B4C007F2B28000000000000000000B7645E00E5C6C500EAE9E900E5E6
      E500E5E6E500E5E6E500EFE3E100D5918F0005720A0005720A0005720A0033C5
      520005720A0005720A0005720A00B78183000000000000000000C2A6A400FFF0
      E200FFF0E200FEF3E900FFEEDE00FEF3E900FFEEDE00FEF3E900FFEEDE00FEF3
      E900FFEEDE00C2A6A4000000000000000000078DBE009BF5FE009AF6FE009AF6
      FE009BF5FD009BF6FE009AF6FE009BF5FE000C85180046CE6C0059E4880058E1
      880061EB940040C165000C85180000000000000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B2800000000000000000000000000D2B6B500EAE9E900E5D9
      D800E5D9D800E5D9D800EAE9E900C285840005720A0034B3510053DB800046D1
      6C002BBB45001EA5300005720A00B78183000000000000000000C2A6A400FEF3
      E900FFEEDE00FFF0E200FEF3E900FFEEDE00FFF0E200DDCFC200DDCFC200DDCF
      C200DDCFC200C2A6A4000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
      FE00A0FBFE00A1FAFE00A1FBFE000C8518000C8518000C8518000C85180056E1
      840047CD6E000C8518000C8518000C851800000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      0000000000000000000000000000CAA39800FDF9F50005720A0048CB700060ED
      940030B34B0005720A00F6DBAC00B78183000000000000000000C2A6A400FFEE
      DE00FFEEDE00FFEEDE00FFEEDE00FFEEDE00FFEEDE00C3B4A800C3B4A800C3B4
      A800C3B4A800C2A6A400000000000000000000000000078DBE00FEFEFE00A5FE
      FF00A5FEFF00A5FEFF00078CB60043B7DC0043B7DC0043B7DC000C8518004EDD
      790036BA54000C8518000000000000000000000000007F2B2800BD4B4C00F7F7
      F700BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      0000000000000000000000000000D1A69300FEFEFE00FDF9F50005720A003CBB
      5D0005720A00F5DDC100FBE2BA00B78183000000000000000000C2A6A400FFEE
      DE00FFEAD700FFEEDE00FFEAD700FFEAD700FFEEDE00B0A29600B0A29600B0A2
      9600B0A29600C2A6A40000000000000000000000000000000000078DBE00078D
      BE00078DBE00078DBE00000000000000000000000000000000000C85180040D0
      65000C851800000000000000000000000000000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      0000000000000000000000000000E2B89800FEFEFE00FEFEFE00FDF9F5000572
      0A00F9EAD900FDEDD500F4E6C700B78183000000000000000000C2A6A400FFEA
      D700FFEAD700FFEAD700FFEAD700FFEAD700C9B9AC00FEFAF500FEF7F000E6DA
      D900C2A6A4000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C8518002AB743002DBA
      49000C851800000000000000000000000000000000007F2B2800BD4B4C00F7F7
      F700BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      0000000000000000000000000000E2B89800FEFEFE00FEFEFE00FEFEFE00FDF9
      F500FCF3E800B5837800B5837800B78183000000000000000000C2A6A400FFEA
      D700FFE6D000FFEAD700FFE6D000FFEAD700C5B5A900FEFAF500DDCFC200C2A6
      A400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C85180021B538000C85
      180000000000000000000000000000000000000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      0000000000000000000000000000EBC39F00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FAF7F400B5837800E8AA6100CD8C62000000000000000000C2A6A400FFE6
      D000FFE6D000FFE6D000FFE6D000FFE6D000C9B9AC00DDCFC200C2A6A4000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000C8518000C8518000C8518000C8518000000
      00000000000000000000000000000000000000000000000000007F2B2800F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F7007F2B28000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F0C8A100FAF7F400FAF7F400FAF7F400FDF9
      F500F6F0EF00B5837800D59E7D00000000000000000000000000C2A6A400C2A6
      A400C2A6A400C2A6A400C2A6A400C2A6A400C2A6A400C2A6A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000C8518000C8518000C8518000C85180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EBC39F00DDAE9400E0B39600DCA88700DCA8
      8700DCA88700B58378000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFF000FFFF80030001F000FFFF
      800300010000FFFF800300010000000080030001000000008003000100000000
      8003000100000000800300010000000080030001000000008003000100000000
      80030001000000008003000100000000800300010000000080030001F0000000
      80070001F0000000800F0001F000FFFFC0038003FFFF80FFC0030003C007007F
      C00300018003003FC00300018003000FC003000180030007C003000080030000
      C003000080030000C003000080030000C003000180038000C00300008003FE00
      C00380038003FE00C003C3C78003FE00C007FF878003FE00C00FFF8F8003FE00
      C01FFE1FC007FE01C03FF87FFFFFFE0300000000000000000000000000000000
      000000000000}
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 186
    Top = 72
    object FileNewAction: TAction
      Caption = 'NewAction'
      Hint = 'Create a new language file'
      ImageIndex = 0
      OnExecute = FileNewActionExecute
    end
    object FileOpenAction: TAction
      Caption = 'Open...'
      Hint = 'Open an existing language file'
      ImageIndex = 1
      OnExecute = FileOpenActionExecute
    end
    object FileSaveAction: TAction
      Caption = 'FileSaveAction'
      Hint = 'Save file'
      ImageIndex = 2
      OnExecute = FileSaveActionExecute
    end
    object FileSaveAsAction: TAction
      Caption = 'FileSaveAsAction'
      Hint = 'Save with a new name'
      ImageIndex = 3
      OnExecute = FileSaveAsActionExecute
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    OnMessage = ApplicationEventsMessage
    Left = 84
    Top = 128
  end
end