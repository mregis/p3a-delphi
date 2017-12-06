object fGeraArqDev: TfGeraArqDev
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gerar Arquivo de Devolu'#231#227'o'
  ClientHeight = 135
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
    Left = 3
    Top = 0
    Width = 363
    Height = 115
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
      OnClick = lbldataClick
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
      OnClick = lbldataClick
    end
    object cbgrupo: TComboBox
      Left = 8
      Top = 33
      Width = 347
      Height = 22
      Style = csOwnerDrawFixed
      ItemHeight = 16
      TabOrder = 0
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
      TabOrder = 1
    end
    object btnGerar: TBitBtn
      Left = 214
      Top = 79
      Width = 141
      Height = 24
      Caption = 'Gerar Arquivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnGerarClick
    end
    object cbdtfim: TDateTimePicker
      Left = 111
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
      TabOrder = 2
    end
    object panelBarra: TPanel
      Left = 4
      Top = 10
      Width = 356
      Height = 101
      TabOrder = 4
      Visible = False
      object lblPlanilha: TLabel
        Left = 3
        Top = 15
        Width = 345
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
        Top = 48
        Width = 335
        Height = 31
        Step = 1
        TabOrder = 0
      end
    end
  end
  object Status: TStatusBar
    Left = 0
    Top = 116
    Width = 370
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object TB_AUX: TZQuery
    Connection = DM.CtrlDvlDBConn
    Params = <>
    Left = 32
    Top = 16
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.TMP'
    FileName = 'arquivos_ibis'
    Title = 'Salvar arquivos'
    Left = 88
    Top = 16
  end
end
