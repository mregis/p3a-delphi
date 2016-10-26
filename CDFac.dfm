object frmCartao: TfrmCartao
  Left = 233
  Top = 190
  BorderStyle = bsDialog
  Caption = 'Controle de Devolu'#231#227'o - Cart'#227'o - FAC'
  ClientHeight = 543
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 4
    Top = 55
    Width = 83
    Height = 16
    Caption = 'Data Inicial:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 4
    Top = 87
    Width = 51
    Height = 16
    Caption = 'Motivo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblQtde: TLabel
    Left = 4
    Top = 167
    Width = 215
    Height = 16
    Caption = 'Quantidade de Cart'#245'es lidos: 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 206
    Top = 55
    Width = 76
    Height = 16
    Caption = 'Data Final:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pMsg: TPanel
    Left = 0
    Top = 0
    Width = 690
    Height = 41
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object gbxCartao: TGroupBox
    Left = 400
    Top = 48
    Width = 273
    Height = 489
    Caption = 'Cart'#227'o'
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 54
      Width = 54
      Height = 13
      Caption = 'C'#243'digo BIN'
    end
    object edtCartao: TEdit
      Left = 8
      Top = 28
      Width = 257
      Height = 21
      CharCase = ecUpperCase
      PasswordChar = '*'
      TabOrder = 0
      OnEnter = edtCartaoEnter
      OnKeyPress = edtCartaoKeyPress
    end
    object mmCartoes: TMemo
      Left = 7
      Top = 104
      Width = 257
      Height = 175
      TabStop = False
      TabOrder = 2
      OnChange = mmCartoesChange
      OnEnter = mmCartoesEnter
    end
    object mmCodBin: TMemo
      Left = 7
      Top = 290
      Width = 256
      Height = 175
      TabOrder = 3
    end
    object edtBIN: TEdit
      Left = 9
      Top = 75
      Width = 257
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = edtBINChange
    end
  end
  object cbDT_DEVOLUCAO: TDateTimePicker
    Left = 89
    Top = 47
    Width = 98
    Height = 24
    Date = 36800.765975347210000000
    Time = 36800.765975347210000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnEnter = cbDT_DEVOLUCAOEnter
  end
  object lcCD_MOTIVO: TDBLookupComboBox
    Left = 4
    Top = 107
    Width = 381
    Height = 24
    Hint = 'Selecione o motivo da devolu'#231#227'o'
    DropDownRows = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    KeyField = 'CD_MOTIVO'
    ListField = 'DS_MOTIVO'
    ListSource = DM.dtsMotivo
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = lcCD_MOTIVOClick
    OnExit = lcCD_MOTIVOExit
  end
  object gbxProcessamento: TGroupBox
    Left = 8
    Top = 195
    Width = 377
    Height = 201
    Caption = 'Atualiza'#231#227'o - Arquivo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object btnSalvar: TBitBtn
      Left = 16
      Top = 64
      Width = 169
      Height = 73
      Caption = '&Salvar Dados'
      Enabled = False
      TabOrder = 0
      OnClick = btnSalvarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        98403F953A3A8B3435957D7DB0B8B7BDBCBBC0BCBBBBB8B7B6BBBAA487878028
        29812C2C903737FF00FFFF00FFAA5D56C14B4BC54D4DA64041836666AC8A89D9
        C2C0FEF7F2FFFCF8EEF3F0C59F9F7E1918811D1DB141419C3E3FFF00FFA95D56
        BC4A4AC04C4CA54242876062862B2BA45B5AE0D5D3FCFAF7FEFFFCCEA7A67E1A
        1A811E1EAF40409A3E3FFF00FFA95D56BC4A4AC04B4CA54242926A6981232383
        2020BFAAA9EEEBE9FFFFFFD9B2B07E1919801E1EAF40409A3E3FFF00FFA95D56
        BC4A4AC04B4BA441419E7675882F2F7B1D1D908282C9D0CCF8FFFEDEBAB87A18
        187E1C1CAD3F3F9A3E3FFF00FFA95D56BC4A4AC14B4BA94141B27776B17E7D9F
        6C6C957475A78B8AD8BBB8D193938C23238E2727B24242993D3EFF00FFA95D56
        BD4A4BBC4949BC4949BC4849BD4C4CBF4C4CBD4949B84141BA4343BB4646BD4A
        4ABF4B4BC14D4D973C3DFF00FFAA5E57A439379E413DB66C6AC58E8BC99695C9
        9593C99695C98F8EC99291C99593CA9997C68484BF4B4B973B3CFF00FFAA5D56
        9D3533DCBFBCF8F4F4F6F0EFF7F2F0F7F2F0F7F2F0F7F3F2F7F2F0F7F2F0FAFA
        F8D4ACABB44142983C3DFF00FFAA5D569F3735E5CBCAFBFAF8F4EBEAF4EDEBF4
        EDEBF4EDEBF4EDEBF4EDEBF3EDEBFAF7F6D4AAA9B24141983C3DFF00FFAA5D56
        9F3735E5CBC7EBEAEACCC9C7CFCBCBCFCBCBCFCBCBCFCBCBCFCBCBCCC9C9E6E6
        E5D7ABAAB14141983C3DFF00FFAA5D569F3735E5CBC9EFEDEDD4CFCED5D0D0D5
        D0D0D5D0D0D5D0D0D5D0D0D3CFCEE9E9E9D7ABAAB24141983C3DFF00FFAA5D56
        9F3735E3CBC9F2F0EFDCD5D4DDD8D7DDD8D7DDD8D7DDD8D7DDD8D7DCD5D5EEED
        EBD5ABA9B24141983C3DFF00FFAA5D569F3735E5CBCAEDEBEACEC9C9CFCCCBCF
        CCCBCFCCCBCFCCCBCFCCCBCCC9C9E7E6E5D8ACABB24141983C3DFF00FFAA5D55
        9F3735E2CAC7FEFAFAF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEFCF8
        F7D4AAA9B24141983C3DFF00FFFF00FF923633BAA3A1C6C9C7C4C0C0C4C0C0C4
        C0C0C4C0C0C4C0C0C4C0C0C4C0C0C6C7C7BC99988C3435FF00FF}
    end
    object btnArquivo: TBitBtn
      Left = 200
      Top = 64
      Width = 161
      Height = 73
      Caption = '&Gerar Arquivo'
      TabOrder = 1
      OnClick = btnArquivoClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object btnFechar: TBitBtn
      Left = 144
      Top = 152
      Width = 89
      Height = 33
      Caption = '&Fechar'
      TabOrder = 2
      OnClick = btnFecharClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
  end
  object Panel1: TPanel
    Left = 9
    Top = 488
    Width = 376
    Height = 41
    BevelOuter = bvLowered
    TabOrder = 5
  end
  object Edarq: TEdit
    Left = 9
    Top = 456
    Width = 376
    Height = 21
    TabOrder = 6
  end
  object DTPFinal: TDateTimePicker
    Left = 284
    Top = 47
    Width = 98
    Height = 21
    Date = 40042.608140439810000000
    Time = 40042.608140439810000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object Timer1: TTimer
    Interval = 400
    OnTimer = Timer1Timer
    Left = 352
    Top = 72
  end
  object qryFamilia: TZReadOnlyQuery
    SQL.Strings = (
      'SELECT CODBIN FROM IBI_CADASTRO_FAMILIA '
      'WHERE '
      'CODBIN = :COD_BIN'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'COD_BIN'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      'SELECT CODBIN FROM IBI_CADASTRO_FAMILIA '
      'WHERE '
      'CODBIN = :COD_BIN')
    Left = 168
    Top = 75
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COD_BIN'
        ParamType = ptUnknown
      end>
  end
  object FacRelQtde: TZReadOnlyQuery
    Params = <>
    Left = 205
    Top = 76
  end
  object FacRelTot: TZReadOnlyQuery
    Params = <>
    Left = 240
    Top = 76
  end
end
