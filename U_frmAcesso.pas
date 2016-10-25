unit U_frmAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmAcesso = class(TForm)
    Label2: TLabel;
    EdLogin: TEdit;
    Label3: TLabel;
    EdSenha: TEdit;
    BtnAcesso: TBitBtn;
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

uses CDDM, Main;

{$R *.dfm}

procedure TFrmAcesso.BtnAcessoClick(Sender: TObject);
begin
  if conta < 3  then
  begin
    with DM do
    begin
      ZQUsuario.Close;
      ZQUsuario.SQL.Clear;
      ZQUsuario.SQL.Add('select * from ibi_cadusuario where (logusu = :login) and (snhusu = md5(:senha)) and (flgusu=True)');
      ZQUsuario.Params[0].AsString :=  trim(EdLogin.Text);
      ZQUsuario.Params[1].AsString :=  trim(EdSenha.Text);
      ZQUsuario.Open;
      case ZQUsuario.RecordCount of
        0:
        begin
        Inc(conta,1);//Application.Terminate;
        EdLogin.Clear;
        EdSenha.Clear;
        EdLogin.SetFocus;
        end
      else
        DM.usuaces  :=  ZQUsuariocodusu.AsInteger;
        acesso  :=  true;
        FrmAcesso.Close;
        //Application.Run;

      end;
    end;
  end
  else
    Application.Terminate;

end;

procedure TFrmAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if acesso = false then
  begin
    //FrmAcesso :=  nil;
    Application.Terminate;
    action  :=  cafree;
  end
  else
    FrmAcesso :=  nil;


end;

procedure TFrmAcesso.FormCreate(Sender: TObject);
begin
  conta   :=  0;
  acesso  := false;
end;

end.
