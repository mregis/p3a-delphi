object Frmdevcrtsnh: TFrmdevcrtsnh
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'BANCO IBI CARTA SENHA'
  ClientHeight = 471
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 0
    Top = 0
    Width = 447
    Height = 32
    Align = alTop
    Alignment = taCenter
    Caption = 'Banco IBI'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 128
  end
  object Bevel1: TBevel
    Left = 4
    Top = 40
    Width = 397
    Height = 174
    Shape = bsFrame
    Style = bsRaised
  end
  object lblDS_MOTIVO: TLabel
    Left = 12
    Top = 47
    Width = 325
    Height = 20
    AutoSize = False
    Caption = 'MOTIVO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDS_PRODUTO: TLabel
    Left = 12
    Top = 105
    Width = 381
    Height = 22
    AutoSize = False
    Caption = 'PRODUTO'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel3: TBevel
    Left = 4
    Top = 222
    Width = 397
    Height = 202
    Shape = bsFrame
    Style = bsRaised
  end
  object Label5: TLabel
    Left = 70
    Top = 237
    Width = 249
    Height = 24
    Caption = 'ARQUIVOS DE RETORNO'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 70
    Top = 276
    Width = 79
    Height = 16
    Caption = 'Data Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 231
    Top = 276
    Width = 72
    Height = 16
    Caption = 'Data Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lcCD_MOTIVO: TDBLookupComboBox
    Left = 12
    Top = 75
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
    ListField = 'CD_MOTIVO;DS_MOTIVO'
    ListSource = dsMotivos
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = lcCD_MOTIVOClick
    OnKeyDown = lcCD_MOTIVOKeyDown
    OnKeyPress = lcCD_MOTIVOKeyPress
    OnKeyUp = lcCD_MOTIVOKeyUp
  end
  object lcCD_PRODUTO: TDBLookupComboBox
    Left = 12
    Top = 129
    Width = 381
    Height = 24
    Hint = 'Selecione o C'#243'digo do Produto'
    DropDownRows = 15
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    KeyField = 'CD_PRODUTO'
    ListField = 'CD_PRODUTO;DS_PRODUTO'
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object cbDT_INICIAL: TDateTimePicker
    Left = 63
    Top = 295
    Width = 120
    Height = 24
    Date = 36800.765975347210000000
    Time = 36800.765975347210000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object cbDT_FINAL: TDateTimePicker
    Left = 223
    Top = 295
    Width = 120
    Height = 24
    Date = 36800.765975347210000000
    Time = 36800.765975347210000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object BtnRelatorio1: TBitBtn
    Left = 63
    Top = 325
    Width = 120
    Height = 28
    Hint = 'Relat'#243'rio Arquivo 1 - Forne'#231'a a data de devolu'#231#227'o'
    Caption = '&Retorno'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333330000000
      00003333377777777777333330FFFFFFFFF03FF3F7FFFF33FFF7003000000FF0
      00F077F7777773F77737E00FBFBFB0FFFFF07773333FF7FF33F7E0FBFB00000F
      F0F077F333777773F737E0BFBFBFBFB0FFF077F3333FFFF733F7E0FBFB00000F
      F0F077F333777773F737E0BFBFBFBFB0FFF077F33FFFFFF733F7E0FB0000000F
      F0F077FF777777733737000FB0FFFFFFFFF07773F7F333333337333000FFFFFF
      FFF0333777F3FFF33FF7333330F000FF0000333337F777337777333330FFFFFF
      0FF0333337FFFFFF7F37333330CCCCCC0F033333377777777F73333330FFFFFF
      0033333337FFFFFF773333333000000003333333377777777333}
    NumGlyphs = 2
  end
  object btRelMensal: TBitBtn
    Left = 223
    Top = 325
    Width = 120
    Height = 28
    Caption = 'Relat'#243'rio &Mensal'
    TabOrder = 5
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000333FFF3777777777F3000330FFFFFFF033777FF7F3FF3FF7F07B7030F00F0
      0F0377777F7F7737737F0BBB030FFFFFFF0377777F7F3FFFF37F07B7030F0000
      FF037777737F7777337F3000330FFFFFFF033777337F3FF3FF7F3333330F00F0
      00033333337F7737777F3333330FFFF0FF033FFFFF7F3FF7F3730000030F08F0
      F03377777F7F7737F7330999030FFFF0033377777F7FFFF77333099903000000
      333377777F7777773333099903333333333377777F33FFFFFFF3000003300000
      00337777733777777733333333330CCC033333333333777773333333333330C0
      3333333333333777333333333333330333333333333333733333}
    NumGlyphs = 2
  end
  object Edarq: TEdit
    Left = 63
    Top = 363
    Width = 280
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object pmsg: TPanel
    Left = 12
    Top = 390
    Width = 381
    Height = 25
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object BtnCloseConsistencia: TBitBtn
    Left = 155
    Top = 430
    Width = 100
    Height = 30
    Hint = 'Fechar Janela'
    Cancel = True
    Caption = '&Fechar'
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = BtnCloseConsistenciaClick
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
  object Edcod: TEdit
    Left = 12
    Top = 159
    Width = 381
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 9
    OnKeyPress = EdcodKeyPress
  end
  object SqlAux: TZQuery
    Connection = dbdevibicon
    Params = <>
    Left = 344
    Top = 40
  end
  object DtSAux: TDataSource
    Left = 312
    Top = 40
  end
  object dbdevibicon: TZConnection
    Protocol = 'postgresql-7.4'
    HostName = '192.168.100.20'
    Port = 5432
    Database = 'dbdevibi'
    User = 'valdires'
    Password = 'valdir!50#'
    ReadOnly = True
    Connected = True
    Left = 216
    Top = 40
  end
  object dsMotivos: TDataSource
    DataSet = qraMotivo
    Left = 248
    Top = 40
  end
  object qraMotivo: TZReadOnlyQuery
    Connection = dbdevibicon
    SQL.Strings = (
      'SELECT * FROM cea_motivos_devolucoes'
      '')
    Params = <>
    Left = 280
    Top = 40
    object qraMotivoid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qraMotivocd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qraMotivods_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
  end
end
