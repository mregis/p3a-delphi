object fGeraExcelDev: TfGeraExcelDev
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Planilhas de Devolu'#231#245'es'
  ClientHeight = 202
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object group: TGroupBox
    Left = 0
    Top = 0
    Width = 417
    Height = 183
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 3
    ExplicitTop = -3
    ExplicitWidth = 480
    ExplicitHeight = 262
    object lbldata: TLabel
      Left = 8
      Top = 123
      Width = 127
      Height = 16
      Caption = 'Informar o Per'#237'odo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 68
      Width = 38
      Height = 16
      Caption = 'Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblProduto: TLabel
      Left = 8
      Top = 14
      Width = 44
      Height = 14
      Caption = 'Servi'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbgrupo: TComboBox
      Left = 8
      Top = 87
      Width = 370
      Height = 28
      Style = csOwnerDrawFixed
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemHeight = 22
      ParentFont = False
      TabOrder = 4
      OnClick = cbgrupoClick
      OnKeyUp = cbgrupoKeyUp
    end
    object btnGerar: TBitBtn
      Left = 259
      Top = 141
      Width = 149
      Height = 28
      Caption = 'Gerar Planilha'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnGerarClick
      Glyph.Data = {
        B6080000424DB608000000000000360400002800000030000000180000000100
        08000000000080040000120B0000120B00000001000014000000FF55FF00FF00
        FF00AA00FF00AAAAAA00FF55AA00AA55AA005555AA00FF00AA00AA00AA00AA55
        55005555550000555500AA0055005500550055AA000000AA0000AA5500005555
        0000005500000000000000000000000000000000000000000000000000000000
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
        0000000000000000000000000000000000000000000000000000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010A0D0A0D0A0A0D0A0D0A0D0A0D0A01
        0101010101010101010A0A0A0A0A0A0A0A0A0A0A0A0A0A010101010101010101
        0D0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A08010101010101010A0A0A0A0A0A0A0A
        0A0A0A0A0A0A0A0A03010101010101070A08010101010101010101010101080A
        0A010101010101010A03010101010101010101010101010A0A01010508050806
        1105050805080508050701010101010D0A010103030303030A03030303030303
        030101010101010A0A0101110F11110E1211110F1111110F110A01010101010A
        0D01010A0A0A0A0A0A0A0A0A0A0A0A0A0A0A01010101010A0A01010E0A010101
        0101010101010101090A01010101010D0A01010A0A0101010101010101010101
        0A0301010101010A0A0101110A01010801010101010800010A0A010101010105
        0A01010A030101010101010101010101030A0101010101030A0101110A010811
        0E0701080E110101090A01010101010D0A01010A0301010A0A0101010A0A0101
        030A01010101010A0A01010E0D010105120A070F110801010A1101010101010A
        0D01010A030101030A0A010A0A010101030A01010101010A0A0101110A010101
        090E121105010101090A01010101010D0A01010A0A010101030A0A0A03010101
        0A0301010101010A0A0101110A010101010A0E0A010101010A0A010101010105
        0A01010A03010101010A0A0A01010101030A0101010101030A01010E0A010101
        0412110E080101010A0A01010101010D0A01010A03010101010A0A0A01010101
        030A01010101010A0A0101110A0101010F1109110E0101010A10010101010105
        1301010A030101010A0A030A0A010101030A010101010103130101110A01010A
        1109010A110A01010A0A01010101010D0A01010A0A0101030A0301030A030101
        0A0301010101010A0A01010E0A01010101010101010101010A0902090A0A0D0A
        0A01010A030101010101010101010101030A01030A0A0A0A0A0101110A010101
        01010101010101010A0A080A0B0A0A120501010A030101010101010101010101
        030A030A0A0A0A13030101110E11110F111111110E1111110E0A0A0D0A0A0A08
        0101010A0A0A0A0A0A0A0A0A0A0A0A0A0A030A0A0A0A0A030101010508050805
        110508050805080508050C0B0A0D0A0101010101010301030A03010303030303
        01010A0A0A0A0A0101010101010101080A0101010101010101010A0A0A0A0101
        01010101010101010A0101010101010101010A0A0A0A01010101010101010108
        0A0801010101010101010D0A0A01010101010101010101030A01010101010101
        01010A0A0A01010101010101010101010A0A0A0D0A0D0A0D0A0D0A0A01010101
        01010101010101010A0A0A0A0A0A0A0A0A0A0A0A010101010101010101010101
        080A0A0A0A0A0A0A0A0A0A08010101010101010101010101030A0A0A0A0A0A0A
        0A0A0A0301010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101}
      NumGlyphs = 2
    end
    object cbdtini: TDateTimePicker
      Left = 8
      Top = 142
      Width = 113
      Height = 27
      Date = 43077.611727731480000000
      Time = 43077.611727731480000000
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = cbdtiniChange
    end
    object cbdtfim: TDateTimePicker
      Left = 128
      Top = 142
      Width = 114
      Height = 27
      Date = 43077.611727731480000000
      Time = 43077.611727731480000000
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object lcCD_SERVICO: TDBLookupComboBox
      Left = 8
      Top = 31
      Width = 370
      Height = 27
      Hint = 'Selecione o Servi'#231'o'
      DropDownRows = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      KeyField = 'id'
      ListField = 'descricao'
      ListSource = DM.dsServicos
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = lcCD_SERVICOClick
      OnKeyUp = lcCD_SERVICOKeyUp
    end
    object panelBarra: TPanel
      Left = 35
      Top = 34
      Width = 357
      Height = 97
      BevelInner = bvRaised
      BevelKind = bkSoft
      TabOrder = 0
      Visible = False
      object lblPlanilha: TLabel
        Left = 0
        Top = 89
        Width = 355
        Height = 23
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object ProgressBar: TProgressBar
        Left = 8
        Top = 38
        Width = 342
        Height = 28
        Step = 1
        TabOrder = 0
      end
    end
  end
  object Status: TStatusBar
    Left = 0
    Top = 183
    Width = 417
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ExplicitTop = 111
    ExplicitWidth = 370
  end
  object TBLIMITE: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 163
    Top = 50
  end
  object TBDATAS: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 71
    Top = 50
  end
  object TBDEV: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 117
    Top = 4
  end
  object TBDEVFAC: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 301
    Top = 4
  end
  object TBDEVAR: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 163
    Top = 4
  end
  object TBFAMILIA: TZQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT FAMILIA'
      'FROM '
      '('
      'SELECT DISTINCT'
      '   CASE '
      '      WHEN (FAMILIA = '#39#39') THEN '#39'SEM FAMILIA'#39
      '   ELSE'
      '      FAMILIA'
      '   END AS FAMILIA,'
      '   '
      '   CASE '
      '      WHEN (FAMILIA = '#39'SEM FAMILIA'#39' OR FAMILIA = '#39#39') THEN 0'
      '   ELSE'
      '      1'
      '   END AS ORD'
      'FROM  IBI_CADASTRO_FAMILIA '
      'WHERE servico_id= :SERVICO'
      'ORDER BY 2, FAMILIA'
      ') FAMILIA'
      'ORDER BY'
      '   ORD')
    Params = <
      item
        DataType = ftInteger
        Name = 'SERVICO'
        ParamType = ptInput
        Value = 1
      end>
    Left = 71
    Top = 4
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SERVICO'
        ParamType = ptInput
        Value = 1
      end>
  end
  object TBMOTIVO: TZQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '   COALESCE(OM.POSICAO, 0) AS POSICAO, M.*'
      'FROM  IBI_MOTIVO_DEVOLUCOES M   '
      '   LEFT JOIN ORDEM_MOTIVOS OM ON OM.CD_MOTIVO = M.CD_MOTIVO'
      'WHERE M.servico_id = :SERVICO'
      'ORDER BY 1, M.DS_MOTIVO')
    Params = <
      item
        DataType = ftInteger
        Name = 'SERVICO'
        ParamType = ptInput
        Value = 1
      end>
    Left = 255
    Top = 4
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SERVICO'
        ParamType = ptInput
        Value = 1
      end>
  end
  object TBCONSOLIDA: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 209
    Top = 4
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'xls'
    FileName = 'arquivos_ibis.xls'
    Title = 'Salvar planilha...'
    Left = 209
    Top = 50
  end
  object TB_AUX: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 117
    Top = 50
  end
end
