unit CDDM;

interface
{$WARN UNIT_PLATFORM OFF}
uses
  SysUtils, Classes, DB, ZAbstractRODataset, ZDataset, ZConnection, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  ZAbstractDataset, ExtCtrls, ZAbstractConnection, Forms, IniFiles, DateUtils,
  ZAbstractTable, FileCtrl, Dialogs;

  type
  TDM = class(TDataModule)
    dtsMotivo: TDataSource;
    CtrlDvlDBConn: TZConnection;
    qMotivo: TZReadOnlyQuery;
    qFac: TZReadOnlyQuery;
    qCodFac: TZReadOnlyQuery;
    qBuscaFAC: TZReadOnlyQuery;
    qData: TZReadOnlyQuery;
    qArqFac: TZReadOnlyQuery;
    qAR: TZReadOnlyQuery;
    qCodAR: TZReadOnlyQuery;
    qEmail: TZReadOnlyQuery;
    qBuscaAR: TZReadOnlyQuery;
    qArqAR: TZReadOnlyQuery;
    qParam: TZReadOnlyQuery;
    qAusente: TZReadOnlyQuery;
    qMotivoid: TIntegerField;
    qMotivocd_motivo: TStringField;
    qMotivods_motivo: TStringField;
    qCodFaccodigo: TIntegerField;
    qCodARcodigo: TIntegerField;
    qEmailid: TIntegerField;
    qEmailpara: TStringField;
    qEmailcc: TStringField;
    qParamid: TIntegerField;
    qParamausente: TStringField;
    qParamcd_motivo: TStringField;
    qAusenteqtde: TLargeintField;
    DtSAux: TDataSource;
    SqlAux: TZQuery;
    ZQAux: TZQuery;
    DtSZqAux: TDataSource;
    qBuscaARid: TIntegerField;
    qBuscaARcod_ar: TStringField;
    qBuscaARcd_motivo: TStringField;
    qBuscaARdata: TDateField;
    qBuscaARdt_devolucao: TDateField;
    qBuscaARhr_devolucao: TTimeField;
    qBuscaARdt_cadastro: TDateField;
    qBuscaARhr_cadastro: TTimeField;
    qBuscaARcodbin: TStringField;
    qBuscaARds_motivo: TStringField;
    qArqARid: TIntegerField;
    qArqARcod_ar: TStringField;
    qArqARcd_motivo: TStringField;
    qArqARdata: TDateField;
    qArqARdt_devolucao: TDateField;
    qArqARhr_devolucao: TTimeField;
    qArqARdt_cadastro: TDateField;
    qArqARhr_cadastro: TTimeField;
    qArqARcodbin: TStringField;
    qFacid: TIntegerField;
    qFacnro_cartao: TStringField;
    qFaccd_motivo: TStringField;
    qFacdata: TDateField;
    qFacdt_devolucao: TDateField;
    qFachr_devolucao: TTimeField;
    qFacdt_cadastro: TDateField;
    qFachr_cadastro: TTimeField;
    qFaccodbin: TStringField;
    qBuscaFACid: TIntegerField;
    qBuscaFACnro_cartao: TStringField;
    qBuscaFACcd_motivo: TStringField;
    qBuscaFACdata: TDateField;
    qBuscaFACdt_devolucao: TDateField;
    qBuscaFAChr_devolucao: TTimeField;
    qBuscaFACdt_cadastro: TDateField;
    qBuscaFAChr_cadastro: TTimeField;
    qBuscaFACcodbin: TStringField;
    qBuscaFACds_motivo: TStringField;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    Timer: TTimer;
    qDatadata: TDateField;
    qARid: TIntegerField;
    qARcod_ar: TStringField;
    qARcd_motivo: TStringField;
    qARdata: TDateField;
    qARdt_devolucao: TDateField;
    qARhr_devolucao: TTimeField;
    qARdt_cadastro: TDateField;
    qARhr_cadastro: TTimeField;
    qARcodbin: TStringField;
    qArqFacid: TIntegerField;
    qArqFacnro_cartao: TStringField;
    qArqFaccd_motivo: TStringField;
    qArqFacdata: TDateField;
    qArqFacdt_devolucao: TDateField;
    qArqFachr_devolucao: TTimeField;
    qArqFacdt_cadastro: TDateField;
    qArqFachr_cadastro: TTimeField;
    qArqFaccodbin: TStringField;
    ZQUsuario: TZQuery;
    DtUsuario: TDataSource;
    ZQUsuariocodusu: TIntegerField;
    ZQUsuariocoduni: TIntegerField;
    ZQUsuarionomusu: TStringField;
    ZQUsuariologusu: TStringField;
    ZQUsuariosnhusu: TStringField;
    ZQUsuarioflgusu: TBooleanField;
    ZQUsuarionivusu: TIntegerField;
    ZQUsuariodatusu: TDateField;
    ZQUsuariohrausu: TTimeField;
    ZqAusFac: TZQuery;
    ZqAusFacqtde: TLargeintField;
    ZQAusFat: TZQuery;
    ZQAusFatqtde: TLargeintField;
    dsMotivos: TDataSource;
    dsProdutos: TDataSource;
    dsOrg: TDataSource;
    dsControle: TDataSource;
    qraRelatorioTOT: TZReadOnlyQuery;
    qraRelatorioQtde: TZReadOnlyQuery;
    qraRetorno: TZReadOnlyQuery;
    qraControle: TZQuery;
    qAux: TZTable;
    qraMotivo: TZReadOnlyQuery;
    qraProduto: TZReadOnlyQuery;
    qraOrg: TZQuery;
    ZQuery1: TZQuery;
    qraRelMensal: TZQuery;
    qraRelMensalds_motivo: TStringField;
    qraRelMensalcd_produto: TStringField;
    qraRelMensalds_produto: TStringField;
    qraRelMensaltotal: TLargeintField;
    DtSRelMensal: TDataSource;
    qMotivodescricao: TStringField;
    qraMotivoID: TIntegerField;
    qraMotivoCd_Motivo: TStringField;
    qraMotivoDs_motivo: TStringField;
    qraProdutoIdProd: TIntegerField;
    qraProdutoCdProduto: TStringField;
    qraProdutoDs_Produto: TStringField;
    qraProdutoCodbin: TStringField;
    qraProdutoPrivBand: TStringField;
    qraMotivoDescricao: TStringField;
    qraProdutodescricao: TStringField;
    procedure TimerTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure envarq;
    private
    { Private declarations }
  public
    { Public declarations }
    currdir, relatdir, retdir, msg : string;
    Texto : TIdMessage;
    Html : TIdMessage;
    Anexo : TIdCreateAttachmentEvent;
    dtatu : TDateTime;
    usuaces :  Int64;
    operador: String;
    iniFile : TIniFile;
    iniFileName : String;
    max_login_erros: Integer;
    siglas_validas: TStringList;
  end;

var
  DM: TDM;

implementation

uses U_Func, U_FrmCadHost, Main, U_FrmConfig;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  currdir :=  GetCurrentDir;
  iniFileName := ChangeFileExt(Application.ExeName, '.ini');
  // Fechar Conexoes eventualmente abertas ao iniciar a aplicação
  CtrlDvlDBConn.Connected := false;
  if not FileExists(iniFileName) then
    Begin
      // Criando o formulário de Configuração da aplicação
      Application.CreateForm(TFrmConfig, FrmConfig);
      FrmConfig.ShowModal;
    end;

  Try
    Try
      // Recuperando as configurações do aplicativo
      iniFile := TIniFile.Create(iniFileName);
      // Maximo de tentativas de logins antes da aplicação encerrar
      max_login_erros := iniFile.ReadInteger('Geral', 'MaxLoginErros', 5);
      siglas_validas := TStringList.Create;
      siglas_validas.CommaText := iniFile.ReadString('Geral', 'SiglasSedexValidas', 'DQ');

      // Nome do Servidor onde se encontra a Base de Dados Postgres
      CtrlDvlDBConn.HostName := iniFile.ReadString('BD', 'Host', 'localhost');;
      // Nome da base de Dados que a aplicação utilizará
      CtrlDvlDBConn.Database := iniFile.ReadString('BD', 'Banco', 'dbdevibi');
      // Porta de conexão ao banco de Dados
      CtrlDvlDBConn.Port := iniFile.ReadInteger('BD', 'Porta', 5432);
      // Nome de usuario para conexão ao BD
      CtrlDvlDBConn.User := iniFile.ReadString('BD', 'Usuario', 'dbdevuser');
      // Senha de acesso ao Bando de Dados
      CtrlDvlDBConn.Password := decryptstr( iniFile.ReadString('BD', 'Senha', encryptstr('dbdevpass', 9, 6, 9)), 9, 6, 9);

      // Diretório padrão da aplicação
      currdir := DM.IniFile.ReadString('Diretorios', 'Raiz', GetCurrentDir);
      // Verificando a existência do diretório
      if (DirectoryExists(currdir) = false) then
        currdir := StringReplace(GetCurrentDir, GetCurrentDir, '.\',[rfReplaceAll]);

      // Diretório de destino dos arquivos de relatórios gerados
      relatdir := DM.IniFile.ReadString('Diretorios', 'Relatorios', '.\RELATORIOS');
      if (DirectoryExists(relatdir) = false) then
        try
          CreateDir(relatdir);
        except on E:Exception do
          raise Exception.Create('Erro ao tentar definir diretório dos Relatórios');
        end;

      // Diretório de destino dos arquivos de retorno gerados
      retdir := DM.IniFile.ReadString('Diretorios', 'Retorno', '.\RETORNO');
      if (DirectoryExists(retdir) = false) then
        begin
          try
            CreateDir(retdir);
          except on E:Exception do
            raise Exception.Create('Erro ao tentar definir diretório dos Arquivos de Retorno');
          end;
        end;

      relatdir := IncludeTrailingBackslash(relatdir);
      retdir := IncludeTrailingBackslash(retdir);
      currdir := IncludeTrailingBackslash(currdir);
      
      // Evitando problemas de arquivo com opções removidas externamente
      IniFile.WriteString('BD', 'Host', CtrlDvlDBConn.HostName);
      IniFile.WriteString('BD', 'Banco', CtrlDvlDBConn.Database);
      IniFile.WriteInteger('BD', 'Porta', CtrlDvlDBConn.Port);
      IniFile.WriteString('BD', 'Usuario', CtrlDvlDBConn.User);
      IniFile.WriteString('BD', 'Senha', encryptstr(CtrlDvlDBConn.Password, 9, 6, 9));

      IniFile.WriteInteger('Geral', 'MaxLoginErros', max_login_erros);
      IniFile.WriteString('Geral', 'SiglasSedexValidas', siglas_validas.CommaText);


      // Diretório padrão da aplicação (Raiz)
      IniFile.WriteString('Diretorios', 'Raiz', currdir);
      // Diretório onde serão armazenados os arquivos de Relatórios
      IniFile.WriteString('Diretorios', 'Relatorios', relatdir);
      // Diretório onde serão armazenados os arquivos de Retorno
      IniFile.WriteString('Diretorios', 'Retorno', retdir);

      iniFile.UpdateFile;
    except
      raise Exception.Create('Erro ao ler informações do arquivo de configuração! Tente novamente.');
    end;
  finally
    iniFile.Free;
  end;

  try
    CtrlDvlDBConn.Connected := True;

    // Forçando o DateStyle a ser sempre o mesmo, independente do
    // que foi configurado no servidor, devido a Bug da Lib Zeos
    SqlAux.Close;
    SqlAux.SQL.Text := FORMAT('SET DATESTYLE TO %s', [QuotedStr('ISO, DMY')]);
    SqlAux.ExecSQL;

    // Pegando a data hora do servidor do Banco de Dados para evitar problemas
    // com hora incorreta do computador onde está sendo executado a aplicação
    SqlAux.Close;
    SqlAux.SQL.Text := 'SELECT CURRENT_TIMESTAMP as dthr';
    SqlAux.Open;
    dtatu := SqlAux.FieldByName('dthr').AsDateTime;

    // Forçando aos caracteres serem tratados como WIN1252 no lado do cliente
    SqlAux.SQL.Text := FORMAT('SET NAMES %s', [QuotedStr('WIN1252')]);
    SqlAux.ExecSQL;


  Except on e: exception do
    dtatu := Date;
  end;
end;

procedure TDM.envarq;
begin
//  IdMessage.ContentType :=  'multpart/mixed';
  //Html  :=    IdMessage. ;//t TIdMessage.Create();
  msg :=  '<html><body>table><tr><td width="200"><span class="style1">' +
    format('%5.5s%',['Teste: Envio Arquivos IBI']) +
    '</span></td></tr></table></body></html>';
  IdMessage.Body.Text :=  msg;
  //Html.Body.Text := msg;
//  Html.ContentType:=  'text/html';
  IdMessage.ContentType:=  'text/html';
  IdMessage.Recipients.Add.Address  :=  'valdir.santos@address.com.br';
  IdMessage.From.Address                := 'valdir.santos@address.com.br';
  IdMessage.CCList.EMailAddresses     :=  'tecnologia@address.com.br';
  IdSMTP.Connect;
  try
  IdSMTP.Send(IdMessage);
  //Memo1.Lines.Add(SqlAux.Fields[5].AsString);
  except on e: exception do
//  e.Message;
//    ApplicationHandleException('Erro ao Enviar o E-Mail ');//+IdMessage.Recipients.Add.Address+chr(10)+' - '+e.Message,'IBISIS',0);
  end;
  IdSMTP.Disconnect;

end;
procedure TDM.TimerTimer(Sender: TObject);
begin
  if (not SqlAux.Active) then
    begin
      SqlAux.Close;
      SqlAux.SQL.Clear;
      SqlAux.SQL.Add('SELECT CURRENT_TIMESTAMP');
      SqlAux.Open;
      dtatu :=  SqlAux.Fields[0].AsDateTime;
    end;
end;

end.
