unit U_FrmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, IdCoder, IdCoderMIME, ComCtrls,
  ZAbstractConnection, ZConnection, FileCtrl;

type
  TFrmConfig = class(TForm)
    BitBtnFechar: TBitBtn;
    BitBtnSalvar: TBitBtn;
    PageControlConfigs: TPageControl;
    TabSheetBD: TTabSheet;
    GroupBox1: TGroupBox;
    LabelDBHost: TLabel;
    LabelDBName: TLabel;
    LabelPort: TLabel;
    LabelDBUsername: TLabel;
    LabelDBPassword: TLabel;
    EditDBHost: TEdit;
    EditDBName: TEdit;
    EditDBPort: TEdit;
    EditDBUsername: TEdit;
    EditDBPassword: TEdit;
    TabSheetDirs: TTabSheet;
    GroupBox2: TGroupBox;
    LabelDirDest: TLabel;
    EditDirRelat: TEdit;
    TabSheetGeral: TTabSheet;
    LabelMaxLoginErros: TLabel;
    EditMaxLoginErros: TEdit;
    Conn4Test: TZConnection;
    EditDirRetorno: TEdit;
    LabelArqRetorno: TLabel;
    LabelWorkDir: TLabel;
    EditWorkDir: TEdit;
    BitBtnTesteConexao: TBitBtn;
    BitBtnGetWorkDir: TBitBtn;
    BitBtnGetRelatDir: TBitBtn;
    BitBtnGetRetDir: TBitBtn;
    SaveDialogConfig: TSaveDialog;
    procedure BitBtnGetRetDirClick(Sender: TObject);
    procedure BitBtnGetRelatDirClick(Sender: TObject);
    procedure BitBtnGetWorkDirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnTesteConexaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnSalvarClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
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

procedure TFrmConfig.BitBtnGetRelatDirClick(Sender: TObject);
var chosenDirectory : string;
begin
  chosenDirectory := EditDirRelat.Text;
  if (SelectDirectory(chosenDirectory, [sdAllowCreate, sdPerformCreate, sdPrompt], 0)) then
    EditDirRelat.Text := '.\' + ExtractRelativePath(GetCurrentDir, chosenDirectory);
end;

procedure TFrmConfig.BitBtnGetRetDirClick(Sender: TObject);
var chosenDirectory : string;
begin
  chosenDirectory := EditDirRetorno.Text;
  if (SelectDirectory(chosenDirectory, [sdAllowCreate, sdPerformCreate, sdPrompt], 0)) then
    EditDirRetorno.Text := '.\' + ExtractRelativePath(GetCurrentDir, chosenDirectory);

end;

procedure TFrmConfig.BitBtnGetWorkDirClick(Sender: TObject);
var chosenDirectory : string;
begin
  chosenDirectory := EditWorkDir.Text;
  if (SelectDirectory(chosenDirectory, [sdAllowCreate, sdPerformCreate, sdPrompt], 0)) then
    EditWorkDir.Text := '.\' + ExtractRelativePath(GetCurrentDir, chosenDirectory);
end;

procedure TFrmConfig.BitBtnSalvarClick(Sender: TObject);
var i, intTemp : Integer;
begin
  // Necessário validar campos
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TEdit) and ((Components[i] as TEdit).Text = '') then
      Begin
        Application.MessageBox(PChar('O campo "' + (Components[i] as TEdit).Hint +
          '"' + #13#10 + 'não pode ficar em branco.'),
          'Controle de Devolução', MB_OK + MB_ICONERROR);
        (Components[i] as TEdit).SetFocus;
        exit;
      end;

  // Todos os campos preenchidos
  DM.IniFile := TIniFile.Create(DM.iniFileName);
  Try
    Try
      // Nome do Servidor onde se encontra a Base de Dados Postgres
      DM.IniFile.WriteString('BD', 'Host', EditDBHost.Text);;
      // Nome da base de Dados que a aplicação utilizará
      DM.IniFile.WriteString('BD', 'Banco', EditDBName.Text);
      // Porta de conexão ao banco de Dados
      if ( tryStrToInt(EditDBPort.Text, intTemp) AND (intTemp > 1) AND (intTemp < 65536)) then
        DM.IniFile.WriteInteger('BD', 'Porta', intTemp)
      else
        begin
          EditDBPort.SetFocus;
          raise Exception.Create('Valor para o campo Porta inválido!');
        end;

      // Nome de usuario para conexão ao BD
      DM.IniFile.WriteString('BD', 'Usuario', EditDBUsername.Text);
      // Senha de acesso ao Bando de Dados
      DM.IniFile.WriteString('BD', 'Senha', encryptstr(EditDBPassword.Text, 9, 6, 9));

      // Diretório padrão da aplicação (Raiz)
      if (DirectoryExists(EditWorkDir.Text) OR ForceDirectories(EditWorkDir.Text)) then
        DM.IniFile.WriteString('Diretorios', 'Raiz', EditWorkDir.Text)
      else
        begin
          EditWorkDir.SetFocus;
          raise Exception.Create('Não foi possível utilizar o caminho informado para ' +
              'o diretório padrão!');
        end;

      // Diretório onde serão armazenados os arquivos de Relatórios
      if (DirectoryExists(EditDirRelat.Text) OR ForceDirectories(EditDirRelat.Text)) then
        DM.IniFile.WriteString('Diretorios', 'Relatorios', EditDirRelat.Text)
      else
        begin
          EditDirRetorno.SetFocus;
          raise Exception.Create('Não foi possível utilizar o caminho informado para ' +
              'o diretório de relatórios!');
        end;

      // Diretório onde serão armazenados os arquivos de Relatórios
      if (DirectoryExists(EditDirRetorno.Text) OR ForceDirectories(EditDirRetorno.Text)) then
        DM.IniFile.WriteString('Diretorios', 'Relatorios', EditDirRetorno.Text)
      else
        begin
          EditDirRetorno.SetFocus;
          raise Exception.Create('Não foi possível utilizar o caminho informado para ' +
              'o diretório de arquivos retorno!');
        end;

      // Diretório onde serão armazenados os arquivos de Retorno
      DM.IniFile.WriteString('Diretorios', 'Retorno', EditDirRetorno.Text);

      // Maximo de tentativas de logins antes da aplicação encerrar
      if ( tryStrToInt(EditMaxLoginErros.Text, intTemp) AND (intTemp > 0)) then
        DM.IniFile.WriteInteger('Geral', 'MaxLoginErros', intTemp);
    except on E: Exception do
      Application.MessageBox(PChar(E.Message), 'Controle de Devolução', MB_OK + MB_ICONERROR);
    end;
  finally
    DM.IniFile.Free;
  end;

end;

{
  Método que testa conexão com o Banco de Dados informados no
  formulário de configuração.
  Um objeto de conexão de teste é utilizado para validar os dados
  e posteriormente uma tentativa de listar as tabelas é feito para
  garantir que o usuário informado tem permissão de usá-las
}
procedure TFrmConfig.BitBtnTesteConexaoClick(Sender: TObject);
var portTemp : Integer;
  tbls : TStringList;
begin
  Try
    // Nome do Servidor onde se encontra a Base de Dados Postgres
    Conn4Test.HostName := EditDBHost.Text;
    // Nome da base de Dados que a aplicação utilizará
    Conn4Test.Database := EditDBName.Text;
    // Porta de conexão ao banco de Dados
    if (not (TryStrToInt(EditDBPort.Text, portTemp) and
        (portTemp > 0)  AND (portTemp < 65536) )) then
      begin
        Application.MessageBox(PCHAR('Valor para porta inválido!'), 'ERRO', MB_OK + MB_ICONERROR);
        exit;
      end;
    Conn4Test.Port := portTemp;
    // Nome de usuario para conexão ao BD
    Conn4Test.User := EditDBUsername.Text;
    // Senha de acesso ao Bando de Dados
    Conn4Test.Password := EditDBPassword.Text;
    try
      Conn4Test.Connect;
      tbls := TStringList.Create;
      Conn4Test.GetTableNames('%', tbls);
      if (tbls.Count > 0) then
        Application.MessageBox(PCHAR('Teste bem sucedido'),
            'SUCCESSO', MB_OK + MB_ICONINFORMATION)
      else
        Application.MessageBox(PCHAR('Informacões de conexão parecem válidas ' +
            'porém não foi possível recuperar lista de tabelas.' + #13#10 +
            '"' + EditDBUsername.Text + '" possui as permissões necessárias?'),
          'ERRO', MB_OK + MB_ICONERROR);
    finally
      Conn4Test.Disconnect;
    end;
  except on E: Exception do
    Application.MessageBox(PCHAR('Erro ao testar conexao! Detalhes: ' + E.Message),
      'ERRO', MB_OK + MB_ICONERROR);
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

procedure TFrmConfig.FormCreate(Sender: TObject);
var strTemp : String;
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
    strTemp := encryptstr('dbdevpass', 9, 6, 9);
    EditDBPassword.Text := decryptstr( DM.IniFile.ReadString('BD', 'Senha', strTemp), 9, 6, 9);

    // Diretório padrão da aplicação
    EditWorkDir.Text := DM.IniFile.ReadString('Diretorios', 'Raiz', GetCurrentDir);
    // Diretório de destino dos arquivos de relatórios gerados
    EditDirRelat.Text := DM.IniFile.ReadString('Diretorios', 'Relatorios', '.\RELATORIOS');
    // Diretório de destino dos arquivos de retorno gerados
    EditDirRetorno.Text := DM.IniFile.ReadString('Diretorios', 'Retorno', '.\RETORNO');

    // Quantidade Máxima de tentativa de logins incorretos
    EditMaxLoginErros.Text := IntToStr(DM.IniFile.ReadInteger('Geral', 'MaxLoginErros', 5));
  finally
    DM.IniFile.Free;
  end;
end;

end.
