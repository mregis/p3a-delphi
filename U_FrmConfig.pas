unit U_FrmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, IdCoder, IdCoderMIME;

type
  TFrmConfig = class(TForm)
    BitBtnFechar: TBitBtn;
    BitBtnSalvar: TBitBtn;
    GroupBox1: TGroupBox;
    LabelDBHost: TLabel;
    EditDBHost: TEdit;
    LabelDBName: TLabel;
    EditDBName: TEdit;
    Label1: TLabel;
    EditDBPort: TEdit;
    LabelDBUsername: TLabel;
    EditDBUsername: TEdit;
    EditDBPassword: TEdit;
    LabelDBPassword: TLabel;
    GroupBox2: TGroupBox;
    LabelDirDest: TLabel;
    EditDirDest: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnSalvarClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfig: TFrmConfig;

implementation
uses U_Func, IdBaseComponent, CDDM;
{$R *.dfm}

procedure TFrmConfig.BitBtnSalvarClick(Sender: TObject);
var i : Integer;
begin
  // Necessário validar campos
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TEdit) and ((Components[i] as TEdit).Text = '') then
      Begin
        Application.MessageBox(PChar('O campo "' + (Components[i] as TEdit).Hint +
          '"' + #13#10 + 'não pode ficar em branco.'),
          'ADS', MB_OK + MB_ICONERROR);
        (Components[i] as TEdit).SetFocus;
        exit;
      end;

  // Todos os campos preenchidos
  DM.IniFile := TIniFile.Create(DM.iniFileName);
  Try
      // Nome do Servidor onde se encontra a Base de Dados Postgres
    DM.IniFile.WriteString('BD', 'Host', EditDBHost.Text);;
    // Nome da base de Dados que a aplicação utilizará
    DM.IniFile.WriteString('BD', 'Banco', EditDBName.Text);
    // Porta de conexão ao banco de Dados
    DM.IniFile.WriteInteger('BD', 'Porta', StrToInt(EditDBPort.Text));
    // Nome de usuario para conexão ao BD
    DM.IniFile.WriteString('BD', 'Usuario', EditDBUsername.Text);
    // Senha de acesso ao Bando de Dados
    DM.IniFile.WriteString('BD', 'Senha', encryptstr(EditDBPassword.Text, 9, 6, 9));
    // Diretório de destino dos arquivos gerados
    DM.IniFile.WriteString('Arquivos', 'Local', EditDirDest.Text);
  finally
    DM.IniFile.Free;
  end;

end;

procedure TFrmConfig.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  FrmConfig := Nil;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
var passTemp : String;
begin
  DM.IniFile := TIniFile.Create(Dm.iniFileName);
  try
    // Nome do Servidor onde se encontra a Base de Dados Postgres
    EditDBHost.Text := DM.IniFile.ReadString('BD', 'Host', 'localhost');;
    // Nome da base de Dados que a aplicação utilizará
    EditDBName.Text := DM.IniFile.ReadString('BD', 'Banco', 'dbdevibi');
    // Porta de conexão ao banco de Dados
    EditDBPort.Text := IntToStr(DM.IniFile.ReadInteger('BD', 'Porta', 5432));
    // Nome de usuario para conexão ao BD
    EditDBUsername.Text := DM.IniFile.ReadString('BD', 'Usuario', 'dbdevuser');
    // Senha de acesso ao Bando de Dados
    passTemp := encryptstr('dbdevpass', 9, 6, 9);
    EditDBPassword.Text := decryptstr( DM.IniFile.ReadString('BD', 'Senha', passTemp), 9, 6, 9);
    // Diretório de destino dos arquivos gerados
    EditDirDest.Text := DM.IniFile.ReadString('Arquivos', 'Local', GetCurrentDir);
  finally
    DM.IniFile.Free;
  end;

end;

end.
