unit CDDM;

interface

uses
  SysUtils, Classes,DB, ZAbstractRODataset, ZDataset, ZConnection, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  ZAbstractDataset, ExtCtrls;
//  ZAbstractDataset,
  //IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdMessage;
// IdMessage, IdBaseComponent, IdComponent,
//  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,

type
  TDM = class(TDataModule)
    dtsMotivo: TDataSource;
    ADOConnection1: TZConnection;
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
    procedure TimerTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure envarq;
    private
    { Private declarations }
  public
    { Public declarations }
    unidade,currdir,msg:string;
    Texto: TIdMessage;
    Html: TIdMessage;
    Anexo: TIdCreateAttachmentEvent;
    dtatu:  TDateTime;
    hratu:  string;
    usuaces :  Int64;
  end;

var
  DM: TDM;

implementation

uses U_Func, U_FrmCadHost, Main;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  currdir :=  GetCurrentDir;
  ADOConnection1.Connected  := false;

  try
    unidade           := Trim(copy(procarqconf('Unidade'),9,50));
    ADOConnection1.Database  := decryptstr(Trim(copy(procarqconf('Nome do Banco'),15,50)),9,6,9);
    ADOConnection1.HostName  := decryptstr(trim(copy(procarqconf('Host'),7,150)),9,6,9);
    ADOConnection1.Port      := strtoint(decryptstr(Trim(copy(procarqconf('Porta'),7,50)),9,6,9));
    ADOConnection1.User      := decryptstr(Trim(copy(procarqconf('Usuario'),9,50)),9,6,9);
    ADOConnection1.Password  := decryptstr(Trim(copy(procarqconf('Senha'),7,50)),9,6,9);
    ADOConnection1.Connected  := true;

    except on e: exception do
      begin
{          //TFrmCadHost.Create(self);

          FrmCadHost.ShowModal;
          unidade           := Trim(copy(procarqconf('Unidade'),9,50));
          ADOConnection1.Database  := decryptstr(Trim(copy(procarqconf('Nome do Banco'),15,50)),9,6,9);
          ADOConnection1.HostName  := decryptstr(trim(copy(procarqconf('Host'),7,150)),9,6,9);
          ADOConnection1.Port      := strtoint(decryptstr(Trim(copy(procarqconf('Porta'),7,50)),9,6,9));
          ADOConnection1.User      := decryptstr(Trim(copy(procarqconf('Usuario'),9,50)),9,6,9);
          ADOConnection1.Password  := decryptstr(Trim(copy(procarqconf('Senha'),7,50)),9,6,9);}
      end;
    end;
    //try
    //a29x!@h29b}
        SqlAux.Close;
    SqlAux.SQL.Clear;
    SqlAux.SQL.Add('select current_date,localtime(0)');
    SqlAux.Open;
    dtatu :=  SqlAux.Fields[0].AsDateTime;
    hratu :=  SqlAux.Fields[1].AsString;

end;
procedure TDM.envarq;
begin
//  IdMessage.ContentType :=  'multpart/mixed';
  //Html  :=    IdMessage. ;//t TIdMessage.Create();
  msg :=  '<html><body>table><tr><td width="200"><span class="style1">'+format('%5.5s%',['Teste: Envio Arquivos IBI'])+'</span></td></tr></table></body></html>';
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
    SqlAux.Close;
    SqlAux.SQL.Clear;
    SqlAux.SQL.Add('select current_date,localtime(0)');
    SqlAux.Open;
    dtatu :=  SqlAux.Fields[0].AsDateTime;
    hratu :=  SqlAux.Fields[1].AsString;

end;

end.
