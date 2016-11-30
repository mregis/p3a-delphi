unit U_frmAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmAcesso = class(TForm)
    Shape2: TShape;
    Label4: TLabel;
    Image1: TImage;
    Shape1: TShape;
    Label1: TLabel;
    Label5: TLabel;
    Image2: TImage;
    EdLogin: TEdit;
    Label6: TLabel;
    Image3: TImage;
    EdSenha: TEdit;
    BtnSair: TBitBtn;
    BtnAcesso: TBitBtn;
    Label2: TLabel;
    LblMsgs: TLabel;
    procedure EdSenhaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdLoginKeyPress(Sender: TObject; var Key: Char);
    procedure EdSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAcessoClick(Sender: TObject);
  private
    { Private declarations }
    conta :  Integer;
    acesso  : Boolean;
  public
    { Public declarations }
  end;

var
  FrmAcesso: TFrmAcesso;

implementation

uses CDDM, Main, U_Func;

{$R *.dfm}

procedure TFrmAcesso.BtnAcessoClick(Sender: TObject);
 var hash : string;
begin
  if conta < 3  then
    begin
      With DM do
        begin
          ZQUsuario.Close;
          ZQUsuario.SQL.Clear;
          ZQUsuario.SQL.Add('SELECT * FROM ibi_cadusuario ' + #13#10 +
              'WHERE logusu = :login AND snhusu = :senha AND flgusu = true');

          // Criptografando a senha antes de enviar para o banco
          // Evitando ir senha em Plain Text para os logs
          hash := md5(EdSenha.Text);

          ZQUsuario.ParamByName('login').AsString :=  trim(EdLogin.Text);
          ZQUsuario.ParamByName('senha').AsString :=  hash;
          ZQUsuario.Open;
          if ZQUsuario.RecordCount > 0 then
            begin
              DM.usuaces  :=  ZQUsuariocodusu.AsInteger;
              acesso  :=  true;
              application.CreateForm(TfrmMain, frmMain);
              frmMain.Show;
              FrmAcesso.Close;
            end
          else
            begin
              Inc(conta, 1);
              LblMsgs.Caption := 'Senha inválida!';
              LblMsgs.Visible := true;
              LblMsgs.Refresh;
              Sleep(conta * 800);
              LblMsgs.Visible := false;
              LblMsgs.Caption := '';
              EdSenha.Clear;
              EdSenha.SetFocus;
            end;
        end;
    end
      else
        Application.Terminate;
end;

procedure TFrmAcesso.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAcesso.EdLoginKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    EdSenha.SetFocus;
end;

procedure TFrmAcesso.EdSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    EdSenha.SetFocus;
end;

procedure TFrmAcesso.EdSenhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
      BtnAcesso.Click;
end;

procedure TFrmAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  FrmAcesso := nil;

  if acesso = false then
      Application.Terminate;

end;

procedure TFrmAcesso.FormCreate(Sender: TObject);
begin
  conta   :=  0;
  acesso  := false;
end;

end.
