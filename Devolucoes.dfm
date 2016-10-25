object DevolucoesFrm: TDevolucoesFrm
  Left = 149
  Top = 173
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Banco IBI (C&A) - Devolu'#231#227'o Correspond'#234'ncia'
  ClientHeight = 482
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 408
    Top = 73
    Width = 233
    Height = 361
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel1: TBevel
    Left = 4
    Top = 73
    Width = 397
    Height = 169
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 484
    Top = 81
    Width = 72
    Height = 20
    Caption = 'C'#211'DIGO'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 12
    Top = 87
    Width = 117
    Height = 16
    Caption = 'Data Devolu'#231#227'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDS_MOTIVO: TLabel
    Left = 12
    Top = 149
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
    Top = 215
    Width = 381
    Height = 23
    AutoSize = False
    Caption = 'PRODUTO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel3: TBevel
    Left = 4
    Top = 257
    Width = 397
    Height = 177
    Shape = bsFrame
    Style = bsRaised
  end
  object Label3: TLabel
    Left = 70
    Top = 288
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
    Top = 288
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
  object Label5: TLabel
    Left = 79
    Top = 263
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
  object Label6: TLabel
    Left = 0
    Top = 0
    Width = 656
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
  object Label7: TLabel
    Left = 451
    Top = 139
    Width = 143
    Height = 20
    Caption = 'C'#211'DIGOS LIDOS'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object edCIF: TEdit
    Left = 416
    Top = 105
    Width = 217
    Height = 28
    Hint = 'Entre com o n'#250'mero do CIF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnKeyPress = edCIFKeyPress
  end
  object BtnCloseConsistencia: TBitBtn
    Left = 542
    Top = 449
    Width = 100
    Height = 30
    Hint = 'Fechar Janela'
    Cancel = True
    Caption = '&Fechar'
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
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
  object ListBoxCIF: TListBox
    Left = 416
    Top = 163
    Width = 217
    Height = 225
    Hint = 'N'#250'mero do CIF j'#225' gravados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 20
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 2
  end
  object BtnLimpaReprocesso: TBitBtn
    Left = 480
    Top = 396
    Width = 100
    Height = 30
    Hint = 'LImpa Box de CIF j'#225' cadastrados'
    Cancel = True
    Caption = '&Limpa'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnLimpaReprocessoClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033337733333333333333333F333333333333
      0000333911733333973333333377F333333F3333000033391117333911733333
      37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
      911117111117333337F3337F733337F3000033333911111111733333337F3337
      3333F7330000333333911111173333333337F333333F73330000333333311111
      7333333333337F3333373333000033333339111173333333333337F333733333
      00003333339111117333333333333733337F3333000033333911171117333333
      33337333337F333300003333911173911173333333373337F337F33300003333
      9117333911173333337F33737F337F33000033333913333391113333337FF733
      37F337F300003333333333333919333333377333337FFF730000333333333333
      3333333333333333333777330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object lcCD_MOTIVO: TDBLookupComboBox
    Left = 12
    Top = 115
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
  object BtnRelatorio1: TBitBtn
    Left = 63
    Top = 336
    Width = 120
    Height = 28
    Hint = 'Relat'#243'rio Arquivo 1 - Forne'#231'a a data de devolu'#231#227'o'
    Caption = '&Retorno'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BtnRelatorio1Click
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
  object lcCD_PRODUTO: TDBLookupComboBox
    Left = 12
    Top = 183
    Width = 381
    Height = 24
    Hint = 'Selecione o C'#243'digo do Produto'
    DropDownRows = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    KeyField = 'CD_PRODUTO'
    ListField = 'CD_PRODUTO;DS_PRODUTO'
    ListSource = dsProdutos
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = lcCD_PRODUTOClick
    OnKeyDown = lcCD_PRODUTOKeyDown
    OnKeyPress = lcCD_PRODUTOKeyPress
    OnKeyUp = lcCD_PRODUTOKeyUp
  end
  object cbDT_INICIAL: TDateTimePicker
    Left = 63
    Top = 307
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
    TabOrder = 7
  end
  object cbDT_FINAL: TDateTimePicker
    Left = 223
    Top = 307
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
    TabOrder = 8
  end
  object cbDT_DEVOLUCAO: TDateTimePicker
    Left = 152
    Top = 82
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
    TabOrder = 9
    OnEnter = cbDT_DEVOLUCAOEnter
  end
  object btRelMensal: TBitBtn
    Left = 223
    Top = 336
    Width = 120
    Height = 28
    Caption = 'Relat'#243'rio &Mensal'
    TabOrder = 10
    OnClick = btRelMensalClick
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
  object pmsg: TPanel
    Left = 8
    Top = 399
    Width = 385
    Height = 25
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
  object btnProduto: TBitBtn
    Left = 5
    Top = 449
    Width = 121
    Height = 30
    Caption = '&Cadastrar Produto'
    TabOrder = 12
    OnClick = btnProdutoClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
      000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
      99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
      0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
      FFFF3FFFFF7F337F333300000307B70FFFFF77777F73FF733F330EEE033000FF
      0FFF7F337FF777337FF30EEE00033FF000FF7F33777F333777FF0EEE0E033300
      000F7FFF7F7FFF77777F00000E00000000007777737773777777330EEE0E0330
      00FF337FFF7F7F3777F33300000E033000FF337777737F3777F333330EEE0330
      00FF33337FFF7FF77733333300000000033F3333777777777333}
    NumGlyphs = 2
  end
  object btnOrg: TBitBtn
    Left = 133
    Top = 449
    Width = 114
    Height = 30
    Caption = '&Cadastrar Org'
    TabOrder = 13
    OnClick = btnOrgClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
      000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
      99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
      0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
      FFFF3FFFFF7F337F333300000307B70FFFFF77777F73FF733F330EEE033000FF
      0FFF7F337FF777337FF30EEE00033FF000FF7F33777F333777FF0EEE0E033300
      000F7FFF7F7FFF77777F00000E00000000007777737773777777330EEE0E0330
      00FF337FFF7F7F3777F33300000E033000FF337777737F3777F333330EEE0330
      00FF33337FFF7FF77733333300000000033F3333777777777333}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 254
    Top = 449
    Width = 146
    Height = 30
    Caption = '&Cadastrar Org Descri'#231#227'o'
    TabOrder = 14
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
      000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
      99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
      0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
      FFFF3FFFFF7F337F333300000307B70FFFFF77777F73FF733F330EEE033000FF
      0FFF7F337FF777337FF30EEE00033FF000FF7F33777F333777FF0EEE0E033300
      000F7FFF7F7FFF77777F00000E00000000007777737773777777330EEE0E0330
      00FF337FFF7F7F3777F33300000E033000FF337777737F3777F333330EEE0330
      00FF33337FFF7FF77733333300000000033F3333777777777333}
    NumGlyphs = 2
  end
  object BitBtn1: TBitBtn
    Left = 410
    Top = 448
    Width = 97
    Height = 30
    Hint = 'Relat'#243'rio Arquivo 1 - Forne'#231'a a data de devolu'#231#227'o'
    Caption = '&Diferen'#231'a'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnClick = BitBtn1Click
    NumGlyphs = 2
  end
  object Edarq: TEdit
    Left = 69
    Top = 370
    Width = 274
    Height = 21
    Enabled = False
    TabOrder = 16
  end
  object dsMotivos: TDataSource
    DataSet = qraMotivo
    Left = 71
    Top = 40
  end
  object dsControle: TDataSource
    Left = 167
    Top = 41
  end
  object dsProdutos: TDataSource
    DataSet = qraProduto
    Left = 103
    Top = 40
  end
  object dsOrg: TDataSource
    DataSet = qraOrg
    Left = 135
    Top = 40
  end
  object ADOConnection2: TZConnection
    Protocol = 'postgresql-7.4'
    HostName = '192.168.100.20'
    Port = 5432
    Database = 'dbdevibi'
    User = 'valdires'
    Password = 'valdir!50#'
    ReadOnly = True
    Connected = True
    Left = 24
    Top = 40
  end
  object qraRelatorioTOT: TZReadOnlyQuery
    Connection = ADOConnection2
    SQL.Strings = (
      'SELECT count(*) AS TOTAL FROM CEA_CONTROLE_DEVOLUCOES'
      'WHERE'
      'DT_DEVOLUCAO BETWEEN '#39'2004-08-03 00:00'#39' AND '#39'2004-08-04 00:00'#39
      '')
    Params = <>
    Properties.Strings = (
      'SELECT count(*) AS TOTAL FROM CEA_CONTROLE_DEVOLUCOES'
      'WHERE'
      'DT_DEVOLUCAO BETWEEN '#39'2004-08-03 00:00'#39' AND '#39'2004-08-04 00:00'#39)
    Left = 200
    Top = 40
  end
  object qraRelatorioQtde: TZReadOnlyQuery
    Connection = ADOConnection2
    SQL.Strings = (
      'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE '
      'FROM CEA_CONTROLE_DEVOLUCOES CD, CEA_MOTIVOS_DEVOLUCOES MD'
      'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO'
      'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO'
      'ORDER BY CD.CD_MOTIVO'
      '')
    Params = <>
    Properties.Strings = (
      'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE '
      'FROM CEA_CONTROLE_DEVOLUCOES CD, CEA_MOTIVOS_DEVOLUCOES MD'
      'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO'
      'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO'
      'ORDER BY CD.CD_MOTIVO')
    Left = 232
    Top = 40
  end
  object qraRetorno: TZReadOnlyQuery
    Connection = ADOConnection2
    Params = <>
    Left = 272
    Top = 40
  end
  object qraMotivo: TZReadOnlyQuery
    Connection = ADOConnection2
    SQL.Strings = (
      'SELECT * FROM cea_motivos_devolucoes'
      '')
    Params = <>
    Left = 376
    Top = 40
  end
  object qraProduto: TZReadOnlyQuery
    Connection = ADOConnection2
    SQL.Strings = (
      'SELECT * FROM CEA_PRODUTOS'
      '')
    Params = <>
    Properties.Strings = (
      'SELECT * FROM CEA_MOTIVOS_DEVOLUCOES')
    Left = 408
    Top = 40
  end
  object qAux: TZTable
    Connection = ADOConnection2
    ReadOnly = True
    Left = 336
    Top = 40
  end
  object qraOrg: TZQuery
    Connection = ADOConnection2
    SQL.Strings = (
      'select * from cea_org'
      '')
    Params = <>
    Properties.Strings = (
      'select * from cea_org')
    Left = 440
    Top = 40
  end
  object qraControle: TZQuery
    Connection = ADOConnection2
    SQL.Strings = (
      'SELECT * FROM CEA_CONTROLE_DEVOLUCOES'
      'WHERE NR_CONTA = :NR_CONTA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'NR_CONTA'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      'SELECT * FROM CEA_CONTROLE_DEVOLUCOES'
      'WHERE NR_CONTA = :NR_CONTA')
    Left = 304
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NR_CONTA'
        ParamType = ptUnknown
      end>
  end
  object SqlAux: TZQuery
    Connection = ADOConnection2
    Params = <>
    Left = 480
    Top = 40
  end
  object DtSAux: TDataSource
    Left = 513
    Top = 41
  end
end
