object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 457
  Width = 699
  object dtsMotivo: TDataSource
    DataSet = qMotivo
    Left = 169
    Top = 118
  end
  object CtrlDvlDBConn: TZConnection
    ControlsCodePage = cGET_ACP
    UTF8StringsAsWideField = False
    AutoEncodeStrings = False
    DesignConnection = True
    HostName = 'localhost'
    Port = 5432
    Database = 'dbdevibi'
    User = 'valdires'
    Password = 'valdir!50#'
    Protocol = 'postgresql-9'
    Left = 32
    Top = 8
  end
  object qMotivo: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'SELECT id, cd_motivo, ds_motivo, '
      'CAST (cd_motivo || '#39' - '#39' || ds_motivo AS VARCHAR) AS descricao'
      'FROM ibi_motivo_devolucoes a'
      'ORDER BY cd_motivo')
    Params = <>
    Properties.Strings = (
      'select * from ibi_motivo_devolucoes'
      'order by cd_motivo')
    Left = 229
    Top = 118
    object qMotivoid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qMotivocd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qMotivods_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
    object qMotivodescricao: TStringField
      FieldName = 'descricao'
      Required = True
      Size = 45
    end
  end
  object qFac: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from ibi_controle_devolucoes_fac'
      'where id is null'
      '')
    Params = <>
    Properties.Strings = (
      'select * from ibi_controle_devolucoes_fac'
      'where id is null')
    Left = 97
    Top = 280
    object qFacid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qFacnro_cartao: TStringField
      FieldName = 'nro_cartao'
      Required = True
      Size = 16
    end
    object qFaccd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qFacdata: TDateField
      FieldName = 'data'
      Required = True
    end
    object qFacdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      Required = True
    end
    object qFachr_devolucao: TTimeField
      FieldName = 'hr_devolucao'
      Required = True
    end
    object qFacdt_cadastro: TDateField
      FieldName = 'dt_cadastro'
      Required = True
    end
    object qFachr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
      Required = True
    end
    object qFaccodbin: TStringField
      FieldName = 'codbin'
      Required = True
      Size = 6
    end
  end
  object qCodFac: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select max(id) +1 as codigo from ibi_controle_devolucoes_fac'
      '')
    Params = <>
    Properties.Strings = (
      
        'select isnull(max(id),0) +1 as codigo from ibi_controle_devoluco' +
        'es_fac')
    Left = 162
    Top = 280
    object qCodFaccodigo: TIntegerField
      FieldName = 'codigo'
      ReadOnly = True
    end
  end
  object qBuscaFAC: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      
        'select F.*, D.ds_motivo from ibi_controle_devolucoes_fac F, ibi_' +
        'motivo_devolucoes D'
      'where'
      '  F.cd_motivo = D.cd_motivo and'
      '  nro_cartao = :cartao and'
      '  data = :data'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'cartao'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      
        'select F.*, D.ds_motivo from ibi_controle_devolucoes_fac F, ibi_' +
        'motivo_devolucoes D'
      'where'
      '  F.cd_motivo = D.cd_motivo and'
      '  nro_cartao = :cartao and'
      '  data = :data')
    Left = 292
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cartao'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    object qBuscaFACid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qBuscaFACnro_cartao: TStringField
      FieldName = 'nro_cartao'
      Required = True
      Size = 16
    end
    object qBuscaFACcd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qBuscaFACdata: TDateField
      FieldName = 'data'
      Required = True
    end
    object qBuscaFACdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      Required = True
    end
    object qBuscaFAChr_devolucao: TTimeField
      FieldName = 'hr_devolucao'
      Required = True
    end
    object qBuscaFACdt_cadastro: TDateField
      FieldName = 'dt_cadastro'
      Required = True
    end
    object qBuscaFAChr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
      Required = True
    end
    object qBuscaFACcodbin: TStringField
      FieldName = 'codbin'
      Required = True
      Size = 6
    end
    object qBuscaFACds_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
  end
  object qData: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select current_date as data')
    Params = <>
    Properties.Strings = (
      'select current_date as data,localtime(0) as hratu')
    Left = 422
    Top = 280
    object qDatadata: TDateField
      FieldName = 'data'
      ReadOnly = True
    end
  end
  object qArqFac: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from ibi_controle_devolucoes_fac'
      'where dt_devolucao between :dt1 and :dt2'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'dt1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dt2'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      'select * from ibi_controle_devolucoes_fac'
      'where dt_devolucao = :dt_devolucao')
    Left = 244
    Top = 338
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dt1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dt2'
        ParamType = ptUnknown
      end>
    object qArqFacid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qArqFacnro_cartao: TStringField
      FieldName = 'nro_cartao'
      Required = True
      Size = 16
    end
    object qArqFaccd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qArqFacdata: TDateField
      FieldName = 'data'
      Required = True
    end
    object qArqFacdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      Required = True
    end
    object qArqFachr_devolucao: TTimeField
      FieldName = 'hr_devolucao'
      Required = True
    end
    object qArqFacdt_cadastro: TDateField
      FieldName = 'dt_cadastro'
      Required = True
    end
    object qArqFachr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
      Required = True
    end
    object qArqFaccodbin: TStringField
      FieldName = 'codbin'
      Required = True
      Size = 6
    end
  end
  object qAR: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from ibi_controle_devolucoes_AR'
      'where id is null'
      '')
    Params = <>
    Properties.Strings = (
      'select * from ibi_controle_devolucoes_AR'
      'where id is null')
    Left = 456
    Top = 338
    object qARid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qARcod_ar: TStringField
      FieldName = 'cod_ar'
      Required = True
      Size = 13
    end
    object qARcd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qARdata: TDateField
      FieldName = 'data'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qARdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qARhr_devolucao: TTimeField
      FieldName = 'hr_devolucao'
      Required = True
    end
    object qARdt_cadastro: TDateField
      FieldName = 'dt_cadastro'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qARhr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
      Required = True
    end
    object qARcodbin: TStringField
      FieldName = 'codbin'
      Required = True
      Size = 6
    end
  end
  object qCodAR: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select max(id) +1 as codigo from ibi_controle_devolucoes_AR'
      '')
    Params = <>
    Properties.Strings = (
      'select(max(id) +1 as codigo from ibi_controle_devolucoes_AR')
    Left = 227
    Top = 280
    object qCodARcodigo: TIntegerField
      FieldName = 'codigo'
      ReadOnly = True
    end
  end
  object qEmail: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from ibi_email'
      '')
    Params = <>
    Properties.Strings = (
      'select * from ibi_email')
    Left = 488
    Top = 280
    object qEmailid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qEmailpara: TStringField
      FieldName = 'para'
      Required = True
      Size = 400
    end
    object qEmailcc: TStringField
      FieldName = 'cc'
      Required = True
      Size = 400
    end
  end
  object qBuscaAR: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select A.*, D.ds_motivo, L.codigo'
      'FROM ibi_controle_devolucoes_AR A'
      
        '    INNER JOIN ibi_motivo_devolucoes D ON (  A.cd_motivo = D.cd_' +
        'motivo)'
      '    LEFT JOIN lote L ON (A.lote_id = L.id)'
      'WHERE  cod_ar = :cartao AND'
      '    data >= :data'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'cartao'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      
        'select A.*, D.ds_motivo from ibi_controle_devolucoes_AR A, ibi_m' +
        'otivo_devolucoes D'
      'where'
      '  A.cd_motivo = D.cd_motivo and'
      '  cod_ar = :cartao and'
      '  data = :data')
    Left = 32
    Top = 338
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cartao'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    object qBuscaARid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qBuscaARcod_ar: TStringField
      FieldName = 'cod_ar'
      Required = True
      Size = 13
    end
    object qBuscaARcd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qBuscaARdata: TDateField
      FieldName = 'data'
      Required = True
    end
    object qBuscaARdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      Required = True
    end
    object qBuscaARhr_devolucao: TTimeField
      FieldName = 'hr_devolucao'
      Required = True
    end
    object qBuscaARdt_cadastro: TDateField
      FieldName = 'dt_cadastro'
      Required = True
    end
    object qBuscaARhr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
      Required = True
    end
    object qBuscaARcodbin: TStringField
      FieldName = 'codbin'
      Required = True
      Size = 6
    end
    object qBuscaARds_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
  end
  object qArqAR: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from ibi_controle_devolucoes_ar'
      'where dt_devolucao between :dt_devolucao and :dt_devfim'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'dt_devolucao'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dt_devfim'
        ParamType = ptUnknown
      end>
    Left = 102
    Top = 338
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dt_devolucao'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dt_devfim'
        ParamType = ptUnknown
      end>
    object qArqARid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qArqARcod_ar: TStringField
      FieldName = 'cod_ar'
      Required = True
      Size = 13
    end
    object qArqARcd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qArqARdata: TDateField
      FieldName = 'data'
      Required = True
    end
    object qArqARdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      Required = True
    end
    object qArqARhr_devolucao: TTimeField
      FieldName = 'hr_devolucao'
      Required = True
    end
    object qArqARdt_cadastro: TDateField
      FieldName = 'dt_cadastro'
      Required = True
    end
    object qArqARhr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
      Required = True
    end
    object qArqARcodbin: TStringField
      FieldName = 'codbin'
      Required = True
      Size = 6
    end
  end
  object qParam: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from ibi_parametros'
      '')
    Params = <>
    Properties.Strings = (
      'select * from ibi_parametros')
    Left = 173
    Top = 338
    object qParamid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qParamausente: TStringField
      FieldName = 'ausente'
      Required = True
      Size = 1
    end
    object qParamcd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
  end
  object qAusente: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select count(*) as qtde from ibi_controle_devolucoes_ar '
      'where cd_motivo = :cd_motivo and data = :data'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'cd_motivo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      
        'select count(*) qtde from ibi_controle_devolucoes_ar where cd_mo' +
        'tivo = :cd_motivo and data = :data')
    Left = 357
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cd_motivo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    object qAusenteqtde: TLargeintField
      FieldName = 'qtde'
      ReadOnly = True
    end
  end
  object DtSAux: TDataSource
    Left = 313
    Top = 173
  end
  object SqlAux: TZQuery
    Connection = CtrlDvlDBConn
    Params = <>
    Left = 32
    Top = 227
  end
  object ZQAux: TZQuery
    Connection = CtrlDvlDBConn
    Params = <>
    Left = 229
    Top = 173
  end
  object DtSZqAux: TDataSource
    Left = 169
    Top = 173
  end
  object IdSMTP: TIdSMTP
    Host = 'mail.address.com.br'
    Password = 'env222'
    SASLMechanisms = <>
    Username = 'envio@address.com.br'
    Left = 32
    Top = 392
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 168
    Top = 392
  end
  object Timer: TTimer
    Interval = 120000000
    OnTimer = TimerTimer
    Left = 88
    Top = 392
  end
  object ZQUsuario: TZQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from ibi_cadusuario where (1=1)')
    Params = <>
    Left = 89
    Top = 62
    object ZQUsuariocodusu: TIntegerField
      FieldName = 'codusu'
      Required = True
    end
    object ZQUsuariocoduni: TIntegerField
      FieldName = 'coduni'
      Required = True
    end
    object ZQUsuarionomusu: TStringField
      FieldName = 'nomusu'
      Required = True
      Size = 50
    end
    object ZQUsuariologusu: TStringField
      FieldName = 'logusu'
      Required = True
    end
    object ZQUsuariosnhusu: TStringField
      FieldName = 'snhusu'
      Required = True
      Size = 64
    end
    object ZQUsuarioflgusu: TBooleanField
      FieldName = 'flgusu'
    end
    object ZQUsuarionivusu: TIntegerField
      FieldName = 'nivusu'
    end
    object ZQUsuariodatusu: TDateField
      FieldName = 'datusu'
      Required = True
    end
    object ZQUsuariohrausu: TTimeField
      FieldName = 'hrausu'
      Required = True
    end
  end
  object DtUsuario: TDataSource
    DataSet = ZQUsuario
    Left = 32
    Top = 62
  end
  object ZqAusFac: TZQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      
        'select count(nro_cartao) as qtde from ibi_controle_devolucoes_fa' +
        'c '
      'where cd_motivo = :cd_motivo and data = :data'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'cd_motivo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    Left = 163
    Top = 227
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cd_motivo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    object ZqAusFacqtde: TLargeintField
      FieldName = 'qtde'
      ReadOnly = True
    end
  end
  object ZQAusFat: TZQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select count(nro_conta) as qtde from cea_controle_devolucoes'
      'where cd_motivo = :cd_motivo and data = :data'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'cd_motivo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    Left = 229
    Top = 227
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cd_motivo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end>
    object ZQAusFatqtde: TLargeintField
      FieldName = 'qtde'
      ReadOnly = True
    end
  end
  object dsMotivos: TDataSource
    DataSet = qraMotivo
    Left = 169
    Top = 62
  end
  object dsProdutos: TDataSource
    DataSet = qraProduto
    Left = 313
    Top = 62
  end
  object dsOrg: TDataSource
    DataSet = qraOrg
    Left = 32
    Top = 118
  end
  object dsControle: TDataSource
    Left = 32
    Top = 173
  end
  object qraRelatorioTOT: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'SELECT COUNT(*) AS TOTAL '
      'FROM cea_controle_devolucoes '
      'WHERE dt_devolucao BETWEEN :dti AND :dtf'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'dti'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dtf'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      'SELECT count(*) AS TOTAL FROM CEA_CONTROLE_DEVOLUCOES'
      'WHERE'
      'DT_DEVOLUCAO BETWEEN '#39'2004-08-03 00:00'#39' AND '#39'2004-08-04 00:00'#39)
    Left = 32
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dti'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dtf'
        ParamType = ptUnknown
      end>
  end
  object qraRelatorioQtde: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
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
    Left = 314
    Top = 338
  end
  object qraRetorno: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    Params = <>
    Left = 385
    Top = 338
  end
  object qraControle: TZQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'SELECT * FROM cea_controle_devolucoes '
      'WHERE nro_conta = :nr_conta AND dt_cadastro = :dt_cadastro'
      '')
    Params = <
      item
        DataType = ftString
        Name = 'nr_conta'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftDateTime
        Name = 'dt_cadastro'
        ParamType = ptUnknown
        Value = 42653d
      end>
    Properties.Strings = (
      'SELECT * FROM CEA_CONTROLE_DEVOLUCOES'
      'WHERE NR_CONTA = :NR_CONTA')
    Left = 89
    Top = 173
    ParamData = <
      item
        DataType = ftString
        Name = 'nr_conta'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftDateTime
        Name = 'dt_cadastro'
        ParamType = ptUnknown
        Value = 42653d
      end>
  end
  object qAux: TZTable
    Connection = CtrlDvlDBConn
    ReadOnly = True
    Left = 383
    Top = 173
  end
  object qraMotivo: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'SELECT id, cd_motivo, ds_motivo, '
      'CAST(cd_motivo || '#39' - '#39' || ds_motivo AS VARCHAR) as descricao'
      'FROM cea_motivos_devolucoes')
    Params = <>
    Left = 229
    Top = 62
    object qraMotivoID: TIntegerField
      FieldName = 'ID'
    end
    object qraMotivoCd_Motivo: TStringField
      FieldName = 'cd_Motivo'
      Size = 2
    end
    object qraMotivoDs_motivo: TStringField
      FieldName = 'ds_motivo'
      Size = 40
    end
    object qraMotivoDescricao: TStringField
      DisplayLabel = 'Descricao'
      FieldName = 'descricao'
      Size = 45
    end
  end
  object qraProduto: TZReadOnlyQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'SELECT idprod, cd_produto, ds_produto, codbin, priv_band, '
      
        '    CAST(cd_produto || '#39' - '#39' || ds_produto AS VARCHAR) as descri' +
        'cao'
      'FROM cea_produtos')
    Params = <>
    Properties.Strings = (
      'SELECT * FROM CEA_MOTIVOS_DEVOLUCOES')
    Left = 383
    Top = 62
    object qraProdutoIdProd: TIntegerField
      FieldName = 'idprod'
    end
    object qraProdutoCdProduto: TStringField
      FieldName = 'cd_produto'
      Size = 3
    end
    object qraProdutoDs_Produto: TStringField
      FieldName = 'ds_produto'
      Size = 60
    end
    object qraProdutoCodbin: TStringField
      FieldName = 'codbin'
      Size = 6
    end
    object qraProdutoPrivBand: TStringField
      FieldName = 'priv_band'
      Size = 1
    end
    object qraProdutodescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
  end
  object qraOrg: TZQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select * from cea_org'
      '')
    Params = <>
    Properties.Strings = (
      'select * from cea_org')
    Left = 89
    Top = 118
  end
  object ZQuery1: TZQuery
    Connection = CtrlDvlDBConn
    Params = <>
    Left = 97
    Top = 227
  end
  object qraRelMensal: TZQuery
    Connection = CtrlDvlDBConn
    SQL.Strings = (
      'select '
      
        '  m.ds_motivo, D.CD_PRODUTO, P.DS_PRODUTO, count(D.CD_PRODUTO)  ' +
        'as Total'
      
        'from  cea_controle_devolucoes d, cea_org_descricao c, CEA_MOTIVO' +
        'S_DEVOLUCOES m, CEA_PRODUTOS P'
      'where (1=0)'
      'group by m.ds_motivo, D.CD_PRODUTO, P.DS_PRODUTO'
      'order by D.CD_PRODUTO, P.DS_PRODUTO, m.ds_motivo'
      ''
      '')
    Params = <>
    Left = 383
    Top = 118
    object qraRelMensalds_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
    object qraRelMensalcd_produto: TStringField
      FieldName = 'cd_produto'
      Required = True
      Size = 6
    end
    object qraRelMensalds_produto: TStringField
      FieldName = 'ds_produto'
      Required = True
      Size = 60
    end
    object qraRelMensaltotal: TLargeintField
      FieldName = 'total'
      ReadOnly = True
    end
  end
  object DtSRelMensal: TDataSource
    DataSet = qraRelMensal
    Left = 313
    Top = 118
  end
end
