object DuplicateCheckerOptionsDialog: TDuplicateCheckerOptionsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Duplicate Checker'
  ClientHeight = 287
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonPanel: TPanel
    Left = 0
    Top = 255
    Width = 456
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object OKButton: TButton
      Left = 290
      Top = 0
      Width = 75
      Height = 24
      Action = OKAction
      Align = alRight
      Default = True
      TabOrder = 0
    end
    object CancelButton: TButton
      Left = 373
      Top = 0
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object ButtonDividerPanel: TPanel
      Left = 365
      Top = 0
      Width = 8
      Height = 24
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object ContentPanel: TPanel
    Left = 0
    Top = 0
    Width = 456
    Height = 255
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Content1Panel: TPanel
      Left = 0
      Top = 0
      Width = 456
      Height = 77
      Align = alTop
      BevelOuter = bvNone
      Padding.Left = 6
      Padding.Right = 6
      Padding.Bottom = 3
      TabOrder = 0
      object InputGroupBox: TGroupBox
        Left = 6
        Top = 0
        Width = 444
        Height = 74
        Align = alClient
        Caption = ' Input '
        TabOrder = 0
        object InputLeftPanel: TPanel
          Left = 2
          Top = 15
          Width = 82
          Height = 57
          Align = alLeft
          BevelOuter = bvNone
          Padding.Left = 10
          Padding.Top = 3
          Padding.Right = 10
          TabOrder = 0
          object FolderPanel: TPanel
            Left = 10
            Top = 3
            Width = 62
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            Padding.Top = 2
            TabOrder = 0
            object FolderLabel: TLabel
              Left = 0
              Top = 2
              Width = 30
              Height = 22
              Align = alLeft
              Caption = 'Folder'
              ExplicitHeight = 13
            end
          end
          object FileTypePanel: TPanel
            Left = 10
            Top = 27
            Width = 62
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alTop
            AutoSize = True
            BevelOuter = bvNone
            Padding.Top = 2
            TabOrder = 1
            object FileTypeLabel: TLabel
              Left = 0
              Top = 2
              Width = 41
              Height = 23
              Align = alLeft
              Caption = 'File type'
              ExplicitHeight = 13
            end
          end
        end
        object InputRightPanel: TPanel
          Left = 84
          Top = 15
          Width = 358
          Height = 57
          Align = alClient
          BevelOuter = bvNone
          Padding.Top = 3
          Padding.Right = 8
          Padding.Bottom = 9
          TabOrder = 1
          object FilderEditPanel: TPanel
            Left = 0
            Top = 3
            Width = 350
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            Padding.Bottom = 3
            TabOrder = 0
            object FolderEdit: TBCEdit
              Left = 0
              Top = 0
              Width = 325
              Height = 21
              Hint = 'Folder'
              Align = alClient
              TabOrder = 0
              Text = ''
              OnlyNumbers = False
              NumbersWithDots = False
              NumbersWithSpots = False
              EditColor = clInfoBk
              ErrorColor = 14803198
              NumbersAllowNegative = False
            end
            object FolderBitBtn: TBitBtn
              Left = 329
              Top = 0
              Width = 21
              Height = 21
              Action = FolderButtonClickAction
              Align = alRight
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274ACFF00
                FFFF00FFFF00FFFF00FFFF00FF0274AC138AC456B6E14BBFF74ABFF74ABFF74A
                BFF74ABFF64ABFF74ABFF62398CC0C81BAFF00FFFF00FFFF00FFFF00FF0274AC
                33AAE02392C454C7F854C7F753C7F854C7F754C7F854C7F854C7F8279DCEBAEB
                EF0274ACFF00FFFF00FFFF00FF0274AC57CAF80274AC5ED1FA5ED1FA5ED1FA5E
                D1FA5ED1FA5FD1FA5ED1F82CA1CEBAEBEF0274ACFF00FFFF00FFFF00FF0274AC
                68DAFB2BA4D196EBFB74E5FB74E5FB74E5FC74E5FC74E5FB74E5FC33A9CFBAEB
                EFBAEBEF0274ACFF00FFFF00FF0274AC70E3FB5CD1EFFEFFFFB8F4FCBAF4FCBA
                F4FCBAF4FEB8F4FEBAF4FC83C9DEE3FEFEC5EFF60274ACFF00FFFF00FF0274AC
                7AEBFE7AEBFC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
                AC0274AC0274ACFF00FFFF00FF0274AC83F2FE82F3FE83F2FC83F3FE82F3FE83
                F2FE82F3FC83F2FE82F3FE036FA7FF00FFFF00FFFF00FFFF00FFFF00FF0274AC
                FEFEFE89FAFF89FAFE8AF8FE8AFAFE89F8FE8AFAFE8AFAFF89FAFF036FA7FF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FF0274ACFEFEFE8FFEFF8FFEFF0274AC02
                74AC0274AC0274AC0274ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF0274AC0274AC0274ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 1
            end
            object FolderEditDividerPanel: TPanel
              Left = 325
              Top = 0
              Width = 4
              Height = 21
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 2
            end
          end
          object FileTypeComboPanel: TPanel
            Left = 0
            Top = 27
            Width = 350
            Height = 24
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object FileTypeComboBox: TBCComboBox
              Left = 0
              Top = 0
              Width = 350
              Height = 21
              Align = alTop
              DropDownCount = 20
              TabOrder = 0
              Text = '*.*'
              EditColor = clInfoBk
              DeniedKeyStrokes = False
              ReadOnly = False
              DropDownFixedWidth = 0
            end
          end
        end
      end
    end
    object Content3Panel: TPanel
      Left = 0
      Top = 147
      Width = 456
      Height = 100
      Align = alTop
      BevelOuter = bvNone
      Padding.Left = 6
      Padding.Right = 6
      Padding.Bottom = 3
      TabOrder = 2
      object OptionsGroupBox: TGroupBox
        Left = 6
        Top = 0
        Width = 444
        Height = 97
        Align = alClient
        Caption = ' Options '
        TabOrder = 0
        object OptionsPanel: TPanel
          Left = 2
          Top = 15
          Width = 440
          Height = 50
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object OptionsLeftPanel: TPanel
            Left = 0
            Top = 0
            Width = 82
            Height = 50
            Align = alLeft
            BevelOuter = bvNone
            Padding.Left = 10
            Padding.Right = 10
            TabOrder = 0
            object MinBlockSizeLabel: TLabel
              Left = 10
              Top = 7
              Width = 65
              Height = 13
              Caption = 'Min Block Size'
            end
            object MinCharsLabel: TLabel
              Left = 10
              Top = 30
              Width = 47
              Height = 13
              Caption = 'Min Chars'
            end
          end
          object OptionsRightPanel: TPanel
            Left = 82
            Top = 0
            Width = 358
            Height = 50
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object MinBlockSizeSpinEdit: TJvSpinEdit
              Left = 6
              Top = 4
              Width = 59
              Height = 21
              Decimal = 0
              MaxValue = 255.000000000000000000
              Value = 4.000000000000000000
              TabOrder = 0
            end
            object MinCharsSpinEdit: TJvSpinEdit
              Left = 6
              Top = 27
              Width = 60
              Height = 21
              Decimal = 0
              MaxValue = 255.000000000000000000
              Value = 3.000000000000000000
              TabOrder = 1
            end
          end
        end
        object RemoveCommentsCheckBox: TCheckBox
          Left = 12
          Top = 69
          Width = 346
          Height = 17
          Caption = ' Remove Comments'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
    end
    object Content2Panel: TPanel
      Left = 0
      Top = 77
      Width = 456
      Height = 70
      Align = alTop
      BevelOuter = bvNone
      Padding.Left = 6
      Padding.Right = 6
      Padding.Bottom = 3
      TabOrder = 1
      object OutputGroupBox: TGroupBox
        Left = 6
        Top = 0
        Width = 444
        Height = 67
        Align = alClient
        Caption = ' Output '
        TabOrder = 0
        object OutputLeftPanel: TPanel
          Left = 2
          Top = 15
          Width = 82
          Height = 50
          Align = alLeft
          BevelOuter = bvNone
          Padding.Left = 10
          Padding.Right = 10
          TabOrder = 0
          object FileLabel: TLabel
            Left = 10
            Top = 6
            Width = 16
            Height = 13
            Caption = 'File'
          end
        end
        object OutputRightPanel: TPanel
          Left = 84
          Top = 15
          Width = 358
          Height = 50
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object LaunchAfterCreationCheckBox: TCheckBox
            Left = 0
            Top = 27
            Width = 141
            Height = 17
            Caption = ' Launch After Creation'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object FileEditPanel: TPanel
            Left = 0
            Top = 0
            Width = 358
            Height = 21
            Align = alTop
            BevelOuter = bvNone
            Padding.Right = 8
            TabOrder = 0
            object FileEdit: TBCEdit
              Left = 0
              Top = 0
              Width = 325
              Height = 21
              Hint = 'Folder'
              Align = alClient
              TabOrder = 0
              Text = ''
              OnlyNumbers = False
              NumbersWithDots = False
              NumbersWithSpots = False
              EditColor = clInfoBk
              ErrorColor = 14803198
              NumbersAllowNegative = False
            end
            object FileBitBtn: TBitBtn
              Left = 329
              Top = 0
              Width = 21
              Height = 21
              Action = FileButtonClickAction
              Align = alRight
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274ACFF00
                FFFF00FFFF00FFFF00FFFF00FF0274AC138AC456B6E14BBFF74ABFF74ABFF74A
                BFF74ABFF64ABFF74ABFF62398CC0C81BAFF00FFFF00FFFF00FFFF00FF0274AC
                33AAE02392C454C7F854C7F753C7F854C7F754C7F854C7F854C7F8279DCEBAEB
                EF0274ACFF00FFFF00FFFF00FF0274AC57CAF80274AC5ED1FA5ED1FA5ED1FA5E
                D1FA5ED1FA5FD1FA5ED1F82CA1CEBAEBEF0274ACFF00FFFF00FFFF00FF0274AC
                68DAFB2BA4D196EBFB74E5FB74E5FB74E5FC74E5FC74E5FB74E5FC33A9CFBAEB
                EFBAEBEF0274ACFF00FFFF00FF0274AC70E3FB5CD1EFFEFFFFB8F4FCBAF4FCBA
                F4FCBAF4FEB8F4FEBAF4FC83C9DEE3FEFEC5EFF60274ACFF00FFFF00FF0274AC
                7AEBFE7AEBFC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
                AC0274AC0274ACFF00FFFF00FF0274AC83F2FE82F3FE83F2FC83F3FE82F3FE83
                F2FE82F3FC83F2FE82F3FE036FA7FF00FFFF00FFFF00FFFF00FFFF00FF0274AC
                FEFEFE89FAFF89FAFE8AF8FE8AFAFE89F8FE8AFAFE8AFAFF89FAFF036FA7FF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FF0274ACFEFEFE8FFEFF8FFEFF0274AC02
                74AC0274AC0274AC0274ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF0274AC0274AC0274ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 1
            end
            object FileEditDividerPanel: TPanel
              Left = 325
              Top = 0
              Width = 4
              Height = 21
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 2
            end
          end
        end
      end
    end
  end
  object ActionList: TActionList
    Left = 266
    Top = 138
    object OKAction: TAction
      Caption = '&OK'
      OnExecute = OKActionExecute
    end
    object ExcludeOtherBranchesAction: TAction
      Caption = 'ExcludeOtherBranchesAction'
    end
    object RootDirectoryClickAction: TAction
      Caption = 'RootDirectoryClickAction'
    end
    object FolderButtonClickAction: TAction
      OnExecute = FolderButtonClickActionExecute
    end
    object FileButtonClickAction: TAction
      OnExecute = FileButtonClickActionExecute
    end
  end
end