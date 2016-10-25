unit U_FrmCadHost;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,  //QTypes,
  Mask, Grids,ComCtrls,StdCtrls, Buttons, Db;  


type
  TFrmCadHost = class(TForm)
    EdHost: TEdit;
    EdDb: TEdit;
    EdUsuario: TEdit;
    EdSenha: TEdit;
    BtSalva: TBitBtn;
    BtSair: TBitBtn;
    Label1: TLabel;
    Base: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdPorta: TEdit;
    procedure BtSalvaClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  arq : TextFile;
  lin,nom_arq : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadHost: TFrmCadHost;

implementation

uses U_Func, CDDM;

{$R *.xfm}

procedure TFrmCadHost.BtSalvaClick(Sender: TObject);
begin
  nom_arq :=  GetCurrentDir+'/spt.confa';
  AssignFile(arq,nom_arq);
  Rewrite(arq);
  lin:='#############################################################################';
  writeLn(arq,lin);
  lin:='#                       Configuracoes do Controle de Devolução              #';
  writeln(arq,lin);
  lin:='#                           Versao 1.0.1                                    #';
  writeln(arq,lin);
  lin:='#                  Desenvolvido por : Valdir dos Santos                     #';
  writeln(arq,lin);
  lin:='#                           Address Logística                               #';
  writeln(arq,lin);
  lin:='#############################################################################';
  writeln(arq,lin);
  lin:='';
  writeln(arq,lin);
  lin:='# Configuracao dos parametros de Conexão com o Banco de Dados #';
  writeln(arq,lin);
  lin:='';
  writeln(arq,lin);
  lin:='# Configurações de Rede #';
  writeln(arq,lin);
  lin:='# Para Windows #';
  writeln(arq,lin);
  lin:='Unidade: F:\';
  writeln(arq,lin);
  lin:='Nome do Banco: '+EncryptSTR(trim(EdDb.Text),9,6,9);
  writeln(arq,lin);
  lin:='Host: '+EncryptSTR(trim(EdHost.Text),9,6,9);
//  lin:='Host: '+trim(EdHost.Text);
  writeln(arq,lin);
//  lin:='Porta: '+EncryptSTR('5432',9,6,9);
  lin:='Porta: '+EncryptSTR(trim(EdPorta.Text),9,6,9);
  writeln(arq,lin);
  lin:='Usuario: '+EncryptSTR(trim(EdUsuario.Text),9,6,9);
  //lin:='Usuario: '+'postgres';
  writeln(arq,lin);
  lin:='Senha: '+EncryptSTR(trim(EdSenha.Text),9,6,9);
  writeln(arq,lin);
  lin:='# Configuracoes locais da Address #';
  writeln(arq,lin);
  lin:='Ender: Rua Mergenthaler, nº 1177';
  writeln(arq,lin);
  lin:='Cidade: São Paulo';
  writeln(arq,lin);
  lin:='UF: SP';
  writeln(arq,lin);
  lin:='#';
  writeln(arq,lin);
  closefile(arq);
end;


procedure TFrmCadHost.BtSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadHost.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action  :=  caFree;
end;

end.
