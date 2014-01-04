inherited OptionsToolBarFrame: TOptionsToolBarFrame
  Width = 451
  Height = 310
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 310
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 305
    object ListView: TListView
      AlignWithMargins = True
      Left = 4
      Top = 0
      Width = 447
      Height = 282
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Columns = <>
      HotTrack = True
      RowSelect = True
      SmallImages = ImagesDataModule.ImageList
      TabOrder = 0
      ViewStyle = vsSmallIcon
      ExplicitHeight = 264
    end
    object ButtonPanel: TPanel
      Left = 0
      Top = 282
      Width = 451
      Height = 28
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object DividerBevel: TBevel
        AlignWithMargins = True
        Left = 55
        Top = 5
        Width = 4
        Height = 18
        Margins.Left = 6
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alLeft
        Shape = bsLeftLine
        ExplicitLeft = 58
        ExplicitTop = 2
        ExplicitHeight = 26
      end
      object ColumnsToolBar: TBCToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 46
        Height = 22
        Margins.Right = 0
        Align = alLeft
        Caption = 'SourceToolBar'
        Images = ImageList
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 4
        object MoveUpToolButton: TToolButton
          Left = 0
          Top = 0
          Action = MoveUpAction
        end
        object MoveDownToolButton: TToolButton
          Left = 23
          Top = 0
          Action = MoveDownAction
        end
      end
      object BCToolBar1: TBCToolBar
        AlignWithMargins = True
        Left = 65
        Top = 3
        Width = 69
        Height = 22
        Margins.Right = 0
        Align = alLeft
        AutoSize = True
        Caption = 'SourceToolBar'
        Images = ImageList
        TabOrder = 1
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = AddItemAction
        end
        object ToolButton2: TToolButton
          Left = 23
          Top = 0
          Action = DeleteItemAction
        end
        object ToolButton3: TToolButton
          Left = 46
          Top = 0
          Action = AddDividerAction
        end
      end
    end
  end
  object ImageList: TBCImageList
    Left = 168
    Top = 166
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007070700000000000707070000000
      0000707070000000000070707000000000007070700000000000707070000000
      0000707070000000000070707000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000707070000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007070700000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000070707000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000707070000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007070700000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000070707000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000707070000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000070707000AB7D4D00AB7D4D00AB7D
      4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D
      4D00AB7D4D00AB7D4D0070707000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AB7D4D0070707000AB7D4D007070
      7000AB7D4D0070707000AB7D4D0070707000AB7D4D0070707000AB7D4D007070
      7000AB7D4D0070707000AB7D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000070707000AB7D4D00AB7D4D00AB7D
      4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D4D00AB7D
      4D00AB7D4D00AB7D4D0070707000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000707070000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007070700000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000070707000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B6F73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000676E760000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000676E7600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B6F73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6F7300000000006B6F73000000
      00006B6F7300000000006B6F7300000000006B6F7300000000006B6F73000000
      00006B6F7300000000006B6F7300000000000000000000000000000000000000
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
      0000000000003FA074000089490000884700008949003FA07400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008247000089490000874700008747000087470000874700008949000082
      4700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000008E4E000088480000884800008E4E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008949000FE9AC0000E2A1000FE9AC0000894900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008949000EE9AC0000E2A10000E1A10000E1A10000E2A1000EE9AC000089
      4900000000000000000000000000000000000000000000000000000000000000
      000000000000008E4E0000C2810000E4A30000E4A30000C28100008E4E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000087470020E4AF0000D99B0020E4AF0000874700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000087460025E3B10000D79C0000D69B0000D69B0000D79C0025E3B1000087
      4600000000000000000000000000000000000000000000000000000000000000
      0000008E4E0000C07F0000DF9F0000DC9B0000DC9B0000DF9F0000C07F00008E
      4E00000000000000000000000000000000000000000000000000000000000000
      0000000000000087460031E2B50000D49A0031E2B50000874600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008746003DE3BA0000D19A0000D19A0000D19A0000D19A003DE3BA000087
      430000000000000000000000000000000000000000000000000000000000008E
      4E0000BE7F0000DC9F0000D99B0000D7990000D7990000D99B0000DC9F0000BE
      7F00008E4E000000000000000000000000000000000000000000000000000000
      0000000000000087440044E4BC0000D0980044E4BC0000874400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000087440054E4C30000CE990000CE9A0000CE9A0000CE990054E4C3000087
      4400000000000000000000000000000000000000000000000000008E4E0000BE
      800000DC9F0000D89B0000D6990000D6990000D6990000D6990000D89B0000DC
      9F0000BE8000008E4E0000000000000000003FA07300008A4800008947000089
      4700008846000083400058E3C30000CD980058E3C30000834000008846000089
      470000894700008A48003FA0730000000000000000002A50A400182DC300182D
      C300182DC300182DC300182DC300182DC300182DC300182DC300182DC300182D
      C300182DC300182DC3002A50A4000000000000000000008E4D00008C4A000089
      450000833E006FE5CC0000CA990000CA9A0000CA9A0000CA99006FE5CC000083
      3E0000894500008C4A00008E4D000000000000000000008E4E0000C2870000E1
      A70000DBA10000D79C0000D59A0000D59A0000D59A0000D59A0000D79C0000DB
      A10000E1A70000C28700008E4E00000000000089470069EBD20000D0A00000D0
      A10000D0A10000CE9E0000CB9A0000CA990000CB9A0000CE9E0000D0A10000D0
      A10000D0A00069EBD200008947000000000000000000182DC3007183FF007183
      FF007183FF007183FF007183FF007183FF007183FF007183FF007183FF007183
      FF007183FF007183FF00182DC3000000000000000000008C4B0000B7870089EF
      DE0000C99E0000C69A0000C69A0000C69B0000C69B0000C69A0000C69A0000C9
      9E0089EFDE0000B78700008C4B000000000000000000008E4E00008B4B000088
      4700008240003CE1B80000D0990000D09A0000D09A0000D099003CE1B8000082
      400000884700008B4B00008E4E00000000000088440075E8D30000C6990000C6
      990000C6990000C6990000C6990000C6990000C6990000C6990000C6990000C6
      990000C6990075E8D300008844000000000000000000182DC3007183FF007183
      FF007183FF007183FF007183FF007183FF007183FF007183FF007183FF007183
      FF007183FF007183FF00182DC3000000000000000000000000000089470000AF
      7F009CECDF0000C0980000C1990000C29B0000C29B0000C1990000C098009CEC
      DF0000AF7F000089470000000000000000000000000000000000000000000000
      0000008744005EE3C70000CA980000CA990000CA990000CA98005EE3C7000087
      440000000000000000000000000000000000008946008AEEDE008AEADA008BEA
      D9008BEAD9008BE8D70052D8BE0000C2960052D8BE008BE8D7008BEAD9008BEA
      D9008AEADA008AEEDE00008946000000000000000000182DC3007183FF007183
      FF007183FF007183FF007183FF007183FF007183FF007183FF007183FF007183
      FF007183FF007183FF00182DC300000000000000000000000000000000000087
      470000AB7D00A1EBE00000BC980000BC990000BC990000BC9800A1EBE00000AB
      7D00008846000000000000000000000000000000000000000000000000000000
      0000008743007EE7D50000C2980000C39A0000C39A0000C298007EE7D5000087
      4300000000000000000000000000000000004FB0830000894600008743000087
      43000086420000813A0097E9DC0000BE950097E9DC0000813A00008642000087
      430000874300008946001094570000000000000000002D54A800182DC300182D
      C300182DC300182DC300182DC300182DC300182DC300182DC300182DC300182D
      C300182DC300182DC3001C4C9C00000000000000000000000000000000000000
      00000087460000A97D00A1E9E10000B8990000B89900A1E9E10000A97D000088
      4600000000000000000000000000000000000000000000000000000000000000
      00000088430099EBE10000BB970000BC980000BC980000BB970099EBE1000088
      4300000000000000000000000000000000000000000000000000000000000000
      0000000000000086410099EADE0000BB950099EADE0000864100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000088460000A67E009FE8E4009FE8E40000A67E00008946000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008A460074E0D80073DCD20075DCD20075DCD20073DCD20074E0D800008A
      4600000000000000000000000000000000000000000000000000000000000000
      0000000000000087420098E9DE0000B7940098E9DE0000874200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000008A49000089450000894500008A4900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008E4E00008A460000894400008844000088440000894400008A4600008E
      4E00000000000000000000000000000000000000000000000000000000000000
      0000000000000088430097E7E00000B3950097E7E00000884300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008946009AE9E60096E6E1009AE9E60000894600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004FB0820000894600008843000089460010945600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000005555000000000000
      FEFF0000000000007FFD000000000000FEFF0000000000007FFD000000000000
      FEFF000000000000000100000000000000010000000000000001000000000000
      FEFF0000000000007FFD000000000000FEFF0000000000007FFD000000000000
      FEFF0000000000005555000000000000FFFFFFFFFFFFFFFFFFFFFFFFF83FFFFF
      F00FFC3FF83FFFFFF00FF81FF83FFFFFF00FF00FF83FFFFFF00FE007F83FFFFF
      F00FC0030001800180018001000180018001800100018001C003F00F00018001
      E007F00F00018001F00FF00FF83FFFFFF81FF00FF83FFFFFFC3FF00FF83FFFFF
      FFFFFFFFF83FFFFFFFFFFFFFF83FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 245
    Top = 173
    object MoveUpAction: TAction
      Hint = 'Move up'
      ImageIndex = 0
    end
    object MoveDownAction: TAction
      Hint = 'Move down'
      ImageIndex = 1
    end
    object AddItemAction: TAction
      Hint = 'Add item'
      ImageIndex = 2
    end
    object DeleteItemAction: TAction
      Hint = 'Delete item'
      ImageIndex = 3
    end
    object AddDividerAction: TAction
      Hint = 'Add divider'
      ImageIndex = 4
    end
  end
end
