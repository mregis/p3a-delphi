object frmExcel: TfrmExcel
  Left = 473
  Top = 202
  Caption = 'Gerar Excel - Controle de Devolucoes IBI'
  ClientHeight = 376
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 95
    Top = 30
    Width = 180
    Height = 13
    Caption = 'Seleciona a Data para Gera'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 72
    Top = 256
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object CheckListBox1: TCheckListBox
    Left = 72
    Top = 48
    Width = 233
    Height = 177
    ItemHeight = 13
    TabOrder = 0
  end
  object btnGerar: TButton
    Left = 76
    Top = 284
    Width = 97
    Height = 35
    Caption = 'Gerar'
    TabOrder = 1
    OnClick = btnGerarClick
  end
  object pMSG: TPanel
    Left = 0
    Top = 335
    Width = 410
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object btnSair: TButton
    Left = 204
    Top = 284
    Width = 97
    Height = 35
    Caption = 'Sair'
    TabOrder = 3
    OnClick = btnSairClick
  end
  object EdArq: TEdit
    Left = 72
    Top = 231
    Width = 233
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 4
  end
  object dsDatas: TDataSource
    DataSet = qryDatas
    Left = 176
    Top = 104
  end
  object qryDatasREM: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      
        'select distinct cast(dt_devolucao as VARCHAR(10)) as dt_devoluca' +
        'o'
      'from ibi_controle_devolucoes_AR'
      'where '
      #9'cod_ar  not like '#39'IB%'#39' and '
      #9'dt_devolucao between :DTINI and :DTFIM'
      'group by dt_devolucao'
      'order by dt_devolucao desc'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    Left = 320
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    object qryDatasREMdt_devolucao: TStringField
      FieldName = 'dt_devolucao'
      ReadOnly = True
      Size = 10
    end
  end
  object qryDatasCour: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      
        'select distinct cast(dt_devolucao as VARCHAR(10)) as dt_devoluca' +
        'o'
      'from ibi_controle_devolucoes_AR'
      'where '
      #9'dt_devolucao between :DTINI  and'
      ':DTFIM'
      ''
      'group by dt_devolucao'
      'order by dt_devolucao desc')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    Left = 320
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    object qryDatasCourdt_devolucao: TStringField
      FieldName = 'dt_devolucao'
      ReadOnly = True
      Size = 10
    end
  end
  object qryDatasFAC: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      
        'select distinct cast(dt_devolucao as VARCHAR(10)) as dt_devoluca' +
        'o'
      'from ibi_controle_devolucoes_FAC'
      'where '
      #9'dt_devolucao between :DTINI and :DTFIM '
      'group by dt_devolucao'
      'order by dt_devolucao desc')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    Left = 320
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    object qryDatasFACdt_devolucao: TStringField
      FieldName = 'dt_devolucao'
      ReadOnly = True
      Size = 10
    end
  end
  object qryDevolARRem: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM ('
      '  SELECT  '
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM '
      '    IBI_CONTROLE_DEVOLUCOES_AR F '
      '--    IBI_MOTIVO_DEVOLUCOES D,  '
      '--    IBI_CADASTRO_FAMILIA CF'
      'full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTIVO'
      '    --AND FM.CODBIN = F.CODBINIBI_MOTIVO_DEVOLUCOES D'
      '    full join IBI_CADASTRO_FAMILIA CF on CF.CODBIN = F.CODBIN'
      '  WHERE '
      '   F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY '
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN, '
      '    F.CD_MOTIVO,D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ') TMP'
      '  GROUP BY'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      ' ORDER BY DT_DEVOLUCAO,FAMILIA'
      ''
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Left = 360
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryDevolARRemqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryDevolARRemmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryDevolARRemdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
    object qryDevolARRemfamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
  end
  object qryDevolFAC: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM('
      '  SELECT  '
      '    COUNT(F.CODBIN) AS QTD_DEVOL, '
      '    D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'
      '    F.DT_DEVOLUCAO, '
      '    CF.FAMILIA'
      '  FROM '
      '    IBI_CONTROLE_DEVOLUCOES_FAC F'
      '--    IBI_MOTIVO_DEVOLUCOES D,  '
      ' --   IBI_CADASTRO_FAMILIA CF'
      
        '    full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTI' +
        'VO'
      '    --AND FM.CODBIN = F.CODBINIBI_MOTIVO_DEVOLUCOES D'
      '    full join IBI_CADASTRO_FAMILIA CF on CF.CODBIN = F.CODBIN'
      ''
      '  WHERE --0=1'
      '--    F.CD_MOTIVO = D.CD_MOTIVO  and'
      ' --   F.CODBIN = CF.CODBIN '
      '--AND '
      'F.DT_DEVOLUCAO between  :DTINI_FAC and :DTFIM_FAC'
      ''
      '  GROUP BY '
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN, '
      '    F.CD_MOTIVO,D.DS_MOTIVO,D.CD_MOTIVO, '
      '    CF.FAMILIA'
      ''
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'ORDER BY DT_DEVOLUCAO,FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DTINI_FAC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAC'
        ParamType = ptUnknown
      end>
    Left = 360
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DTINI_FAC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAC'
        ParamType = ptUnknown
      end>
    object qryDevolFACqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryDevolFACmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryDevolFACdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
    object qryDevolFACfamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
  end
  object qryDatas: TZQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'select '
      
        'distinct(to_char(dt_devolucao,'#39'mm'#39') || to_char(dt_devolucao,'#39'yyy' +
        'y'#39')),'
      'Cast(to_char(dt_devolucao,'#39'mm'#39') as char(2)) as mes,'
      'Cast(to_char(dt_devolucao,'#39'yyyy'#39') as char(4))  as ano'
      'from ibi_controle_devolucoes_ar'
      '--group by ano,mes'
      'order by ano,mes')
    Params = <>
    Left = 320
    Top = 152
    object qryDatasmes: TStringField
      FieldName = 'mes'
      ReadOnly = True
      Size = 2
    end
    object qryDatasano: TStringField
      FieldName = 'ano'
      ReadOnly = True
      Size = 4
    end
  end
  object qryConsolidado: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'SELECT TEMP.FAMILIA, TEMP.DS_MOTIVO, SUM(TEMP.QTD) AS QTD '
      'FROM ('
      'SELECT  '
      #9'FM.FAMILIA,'
      #9'COUNT(F.COD_AR) AS QTD,'
      #9'D.DS_MOTIVO,F.CODBIN'
      'FROM  '
      '    IBI_CONTROLE_DEVOLUCOES_AR F'
      '--    IBI_MOTIVO_DEVOLUCOES D,'
      '--    IBI_CADASTRO_FAMILIA FM'
      ''
      
        '    full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTI' +
        'VO'
      '    --AND FM.CODBIN = F.CODBINIBI_MOTIVO_DEVOLUCOES D'
      '    full join IBI_CADASTRO_FAMILIA FM on FM.CODBIN = F.CODBIN'
      'WHERE --0=1'
      #9'--D.CD_MOTIVO = F.CD_MOTIVO'
      #9'--AND FM.CODBIN = F.CODBIN'
      #9'--AND '
      '    (F.DT_DEVOLUCAO BETWEEN :DTINI_AR AND :DTFIM_AR)'
      'GROUP BY'
      #9'D.DS_MOTIVO,FM.FAMILIA  , F.CODBIN'
      'UNION ALL'
      ''
      'SELECT  '
      #9'FM.FAMILIA,'
      #9'COUNT(F.NRO_CONTA) AS QTD,'
      #9'D.DS_MOTIVO,F.CODBIN'
      'FROM  '
      '    CEA_CONTROLE_DEVOLUCOES F'
      '--    IBI_MOTIVO_DEVOLUCOES D,'
      '--    IBI_CADASTRO_FAMILIA FM'
      ''
      
        '    full join CEA_motivos_devolucoes D on D.CD_MOTIVO = F.CD_MOT' +
        'IVO'
      '    --AND FM.CODBIN = F.CODBINIBI_MOTIVO_DEVOLUCOES D'
      '    full join CEA_CADASTRO_FAMILIA FM on FM.CODBIN = F.CODBIN'
      'WHERE --0=1'
      #9'--D.CD_MOTIVO = F.CD_MOTIVO'
      #9'--AND FM.CODBIN = F.CODBIN'
      #9'--AND '
      '    (F.DT_DEVOLUCAO BETWEEN :DTINI_FAT AND :DTFIM_FAT)'
      'GROUP BY'
      #9'D.DS_MOTIVO,FM.FAMILIA  , F.CODBIN'
      'UNION ALL'
      'SELECT'
      #9'FM.FAMILIA,'
      #9'COUNT(F.NRO_CARTAO) AS QTD,'
      #9'D.DS_MOTIVO,F.CODBIN'
      'FROM'
      '    IBI_CONTROLE_DEVOLUCOES_FAC F'
      '--    IBI_MOTIVO_DEVOLUCOES D,'
      '--    IBI_CADASTRO_FAMILIA FM'
      
        '    full join IBI_MOTIVO_DEVOLUCOES D on D.CD_MOTIVO = F.CD_MOTI' +
        'VO'
      '    --AND FM.CODBIN = F.CODBINIBI_MOTIVO_DEVOLUCOES D'
      '    full join IBI_CADASTRO_FAMILIA FM on FM.CODBIN = F.CODBIN'
      ''
      'WHERE'
      #9'--D.CD_MOTIVO = F.CD_MOTIVO'
      #9'--AND FM.CODBIN = F.CODBIN'
      #9'--AND '
      '   ( F.DT_DEVOLUCAO BETWEEN :DTINI_FAC AND :DTFIM_FAC)'
      'GROUP BY'
      #9'D.DS_MOTIVO,FM.FAMILIA , F.CODBIN'
      ') TEMP'
      'GROUP BY TEMP.FAMILIA, TEMP.DS_MOTIVO'
      ''
      'ORDER BY TEMP.FAMILIA, TEMP.DS_MOTIVO'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DTINI_AR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_AR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTINI_FAT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTINI_FAC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAC'
        ParamType = ptUnknown
      end>
    Left = 360
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DTINI_AR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_AR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTINI_FAT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTINI_FAC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAC'
        ParamType = ptUnknown
      end>
    object qryConsolidadofamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
    object qryConsolidadods_motivo: TStringField
      FieldName = 'ds_motivo'
      ReadOnly = True
      Size = 40
    end
    object qryConsolidadoqtd: TFloatField
      FieldName = 'qtd'
      ReadOnly = True
    end
  end
  object qryFamilia: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'select distinct(familia) from ibi_cadastro_familia '
      'ORDER BY FAMILIA'
      '')
    Params = <>
    Properties.Strings = (
      'select distinct familia from ibi_cadastro_familia'
      'ORDER BY FAMILIA')
    Left = 320
    Top = 216
    object qryFamiliafamilia: TStringField
      FieldName = 'familia'
      Required = True
      Size = 60
    end
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = True
    Left = 304
    Top = 16
  end
  object qryDevolARCou: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM('
      '  SELECT  '
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM '
      '    IBI_CONTROLE_DEVOLUCOES_AR F'
      '--    IBI_MOTIVO_DEVOLUCOES D,  '
      ' --   IBI_CADASTRO_FAMILIA CF'
      
        '    full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTI' +
        'VO'
      '    --AND FM.CODBIN = F.CODBINIBI_MOTIVO_DEVOLUCOES D'
      '    full join IBI_CADASTRO_FAMILIA CF on CF.CODBIN = F.CODBIN'
      ''
      '  WHERE '
      '--    F.CD_MOTIVO = D.CD_MOTIVO  and'
      ' --   F.CODBIN = CF.CODBIN '
      '--AND '
      '--F.COD_AR LIKE '#39'IB%'#39
      '--AND '
      '  F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY '
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN, '
      '    F.CD_MOTIVO, D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ''
      ') TMP'
      '  GROUP BY'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      '  ORDER BY DT_DEVOLUCAO,FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Left = 360
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryDevolARCouqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryDevolARCoumotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryDevolARCoudt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
    object qryDevolARCoufamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
  end
  object qryDevolFat: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM('
      '  SELECT  '
      '    COUNT(C.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'C.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM '
      '    CEA_CONTROLE_DEVOLUCOES C'
      
        '    full join CEA_motivos_devolucoes D on D.CD_MOTIVO =  C.CD_MO' +
        'TIVO'
      '    full join CEA_CADASTRO_FAMILIA CF on CF.CODBIN = C.CODBIN'
      ''
      '  WHERE '
      '  C.DT_DEVOLUCAO between :DTINI_FAT AND  :DTFIM_FAT'
      '  GROUP BY '
      '    C.DT_DEVOLUCAO,'
      '    C.CODBIN, '
      '    C.CD_MOTIVO, D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ''
      ') TMP'
      '  GROUP BY'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      '  ORDER BY DT_DEVOLUCAO,FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DTINI_FAT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAT'
        ParamType = ptUnknown
      end>
    Left = 360
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DTINI_FAT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM_FAT'
        ParamType = ptUnknown
      end>
    object qryDevolFatqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryDevolFatmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryDevolFatdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
    object qryDevolFatfamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
  end
  object qryDatasFAT: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      
        'select distinct cast(dt_devolucao as VARCHAR(10)) as dt_devoluca' +
        'o'
      'from cea_controle_devolucoes'
      'where dt_devolucao between :DTINI  and :DTFIM'
      'group by dt_devolucao'
      'order by dt_devolucao desc'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    Left = 320
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DTINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DTFIM'
        ParamType = ptUnknown
      end>
    object qryDatasFATdt_devolucao: TStringField
      FieldName = 'dt_devolucao'
      ReadOnly = True
      Size = 10
    end
  end
end
