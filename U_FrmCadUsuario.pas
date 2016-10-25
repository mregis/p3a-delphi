unit U_FrmCadUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids;

type
  TFrmCadUsuario = class(TForm)
    Label1: TLabel;
    EdNome: TEdit;
    EdLogin: TEdit;
    EdSenha: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Btninclui: TBitBtn;
    BtnAltera: TBitBtn;
    BtnDesativa: TBitBtn;
    DBGridUsuario: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure BtnDesativaClick(Sender: TObject);
    procedure DBGridUsuarioKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridUsuarioDblClick(Sender: TObject);
    procedure BtnAlteraClick(Sender: TObject);
    procedure EdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure BtnincluiClick(Sender: TObject);
    procedure EdSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure selusuario;
    procedure atudados;
    procedure altdados(tipo: Integer);

  private
  codusu  : Int64;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmCadUsuario: TFrmCadUsuario;

implementation

uses CDDM;

{$R *.dfm}

procedure TFrmCadUsuario.atudados;
begin
with DM	do
begin
  codusu        :=  ZQUsuariocodusu.AsInteger;
  EdNome.Clear;
  EdLogin.Clear;
  EdSenha.Clear;
  EdNome.Text   :=  ZQUsuarionomusu.Text;
  EdLogin.Text  :=  ZQUsuariologusu.Text;
end;
end;
procedure TFrmCadUsuario.altdados(tipo: Integer) ;
begin
  with DM do
  begin

    SqlAux.Close;
    sqlaux.SQL.Clear;
    SqlAux.SQL.Add('update ibi_cadusuario set ');
    case tipo of
      0:
        begin
          if  (EdNome.Text<> '' )   and   (EdLogin.Text <> '')  and
              (EdSenha.Text <> '')  and   (codusu > 0 )         then
          begin
            SqlAux.SQL.Add('nomusu = :nome,logusu = :login,snhusu = md5('+chr(39)+Trim(EdSenha.Text)+chr(39)+') where (codusu = '+IntToStr(codusu)+')');
            SqlAux.Params[0].AsString   :=  trim(EdNome.Text);
            SqlAux.Params[1].AsString   :=  Trim(EdLogin.Text);
//            SqlAux.Params[2].AsString   :=  chr(39)+'md5('+chr(39)+Trim(EdSenha.Text)+chr(39)+')';
          end
          else
          begin
            Application.MessageBox('Favor Digitar Nome, login ou senha','IBISIS',IDOK);
            EdNome.SetFocus;
            exit;
          end;
        end;
      1:  SqlAux.SQL.Add('flgusu  = false where (codusu = '+IntToStr(codusu)+')');
    end;
    try
      SqlAux.ExecSQL;
      ZQUsuario.Refresh;
      BtnAltera.Enabled   :=  true;
      BtnDesativa.Enabled :=  True;
      selusuario;
    except on e: exception do
      begin
        Application.MessageBox(PChar(e.Message),'IBISIS',IDOK);
        EdSenha.SetFocus;
        BtnAltera.Enabled   :=  false;
        BtnDesativa.Enabled :=  false;
      end;
    end;
  end;
end;
procedure TFrmCadUsuario.BtnAlteraClick(Sender: TObject);
begin
  altdados(0);
end;

procedure TFrmCadUsuario.BtnDesativaClick(Sender: TObject);
begin
  altdados(1)	
end;

procedure TFrmCadUsuario.BtnincluiClick(Sender: TObject);
begin
    if  (EdNome.Text<> '' )   and   (EdLogin.Text <> '')  and
        (EdSenha.Text <> '')  then
    begin
      with DM do
      begin
        SqlAux.Close;
        SqlAux.SQL.Clear;
        SqlAux.SQL.Add('insert into ibi_cadusuario (nomusu,logusu,snhusu) values (:nom,:logusu,md5('+chr(39)+trim(EdSenha.Text)+chr(39)+'))' );
        SqlAux.Params[0].AsString :=  trim(EdNome.Text);
        SqlAux.Params[1].AsString :=  Trim(EdLogin.Text);
        //InputBox('','',SqlAux.SQL.Text);
        try
          SqlAux.ExecSQL;
          ZQUsuario.Refresh;
          selusuario;
        except on e: exception do
          begin
            Application.MessageBox(PChar(e.Message),'IBISIS',IDOK);
            EdSenha.SetFocus;
            Btninclui.Enabled :=  false;
          end;
        end;
      end;
    end;
end;
procedure TFrmCadUsuario.DBGridUsuarioDblClick(Sender: TObject);
begin
    atudados;

end;

procedure TFrmCadUsuario.DBGridUsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    atudados;

end;

procedure TFrmCadUsuario.DBGridUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
    atudados;

end;

procedure TFrmCadUsuario.DBGridUsuarioKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    atudados;

end;

procedure TFrmCadUsuario.selusuario;
begin
  with DM do
  begin
    ZQUsuario.Close;
    ZQUsuario.SQL.Clear;
    ZQUsuario.SQL.Add('select * from ibi_cadusuario where (nomusu Ilike :nome) ');//and (flgusu=True)');
    ZQUsuario.Params[0].AsString :=  trim(EdNome.Text)+'%';
    ZQUsuario.Open;
    case ZQUsuario.RecordCount of
      0:  Btninclui.Enabled :=  true;
      else
        begin
          BtnAltera.Enabled   :=  true;
          BtnDesativa.Enabled :=  True;
          DBGridUsuario.Refresh;
        end;
    end;
  end;
end;
procedure TFrmCadUsuario.EdNomeKeyPress(Sender: TObject; var Key: Char);
begin
 selusuario;
end;

procedure TFrmCadUsuario.EdSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
      Btninclui.SetFocus
  else
    Btninclui.Enabled :=  False;

end;

procedure TFrmCadUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
    SelectNext(ActiveOleControl,true,true);
end;

procedure TFrmCadUsuario.FormShow(Sender: TObject);
begin
  with DM do
    begin
      ZQUsuario.Close;
      ZQUsuario.SQL.Clear;
      ZQUsuario.SQL.Add('select * from ibi_cadusuario where (flgusu=True)');
      ZQUsuario.Open;
      DBGridUsuario.Refresh;
    end;

end;

end.
