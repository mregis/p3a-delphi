object fGeraExcelDev: TfGeraExcelDev
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Planilhas de Devolu'#231#245'es'
  ClientHeight = 130
  ClientWidth = 370
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
    Left = 2
    Top = -3
    Width = 367
    Height = 112
    TabOrder = 0
    object lbldata: TLabel
      Left = 8
      Top = 60
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
      Top = 11
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
    object cbgrupo: TComboBox
      Left = 8
      Top = 33
      Width = 347
      Height = 22
      Style = csOwnerDrawFixed
      ItemHeight = 16
      TabOrder = 4
    end
    object btnGerar: TBitBtn
      Left = 208
      Top = 79
      Width = 149
      Height = 24
      Caption = 'Gerar Planilha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnGerarClick
    end
    object cbdtini: TDateTimePicker
      Left = 8
      Top = 79
      Width = 94
      Height = 22
      Date = 41240.611727731480000000
      Time = 41240.611727731480000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object cbdtfim: TDateTimePicker
      Left = 107
      Top = 79
      Width = 94
      Height = 22
      Date = 0.611727731477003500
      Time = 0.611727731477003500
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object panelBarra: TPanel
      Left = 5
      Top = 10
      Width = 357
      Height = 97
      TabOrder = 0
      Visible = False
      object lblPlanilha: TLabel
        Left = 1
        Top = 4
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
    Top = 111
    Width = 370
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object TBLIMITE: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 8
    Top = 46
  end
  object TBDATAS: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 64
    Top = 46
  end
  object TBDEV: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 216
    Top = 46
  end
  object TBDEVFAC: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 320
    Top = 46
  end
  object TBDEVAR: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 264
    Top = 46
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
      'FROM '
      '   IBI_CADASTRO_FAMILIA '
      'ORDER BY'
      '   2, FAMILIA'
      ') FAMILIA'
      'ORDER BY'
      '   ORD')
    Params = <>
    Left = 160
    Top = 46
  end
  object TBMOTIVO: TZQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '   COALESCE(OM.POSICAO, 0) AS POSICAO, M.*'
      'FROM'
      '   IBI_MOTIVO_DEVOLUCOES M'
      '   LEFT JOIN ORDEM_MOTIVOS OM ON OM.CD_MOTIVO = M.CD_MOTIVO'
      'ORDER BY'
      '   1, M.DS_MOTIVO')
    Params = <>
    Left = 112
    Top = 46
  end
  object TBCONSOLIDA: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 296
    Top = 14
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'xls'
    FileName = 'arquivos_ibis'
    Title = 'Salvar planilha...'
    Left = 240
    Top = 14
  end
  object TB_AUX: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 176
  end
end
