unit unFamila;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, ComCtrls, Mask, DBCtrls,//ADODB, 
  Buttons, ToolWin, ExtCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractTable;

type
  TcadFamilia = class(TForm)
    DataSource1: TDataSource;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    DBORG: TDBEdit;
    DBLOGO: TDBEdit;
    DBDESC: TDBEdit;
    DBCODBIN: TDBEdit;
    DBFAM: TDBEdit;
    DBPRIV: TDBEdit;
    CoolBar1: TCoolBar;
    sbPrimeiro: TSpeedButton;
    sbAnterior: TSpeedButton;
    sbProximo: TSpeedButton;
    sbUltimo: TSpeedButton;
    sbAdd: TSpeedButton;
    sbRemove: TSpeedButton;
    sbEditar: TSpeedButton;
    sbAplicar: TSpeedButton;
    sbCancelar: TSpeedButton;
    sbRefresh: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    qryFamilia: TZTable;
//    ZQuery1: TZQuery;
//    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure Button1Click(Sender: TObject);
    procedure sbPrimeiroClick(Sender: TObject);
    procedure sbAnteriorClick(Sender: TObject);
    procedure sbProximoClick(Sender: TObject);
    procedure sbUltimoClick(Sender: TObject);
    procedure sbAddClick(Sender: TObject);
    procedure sbRemoveClick(Sender: TObject);
    procedure sbEditarClick(Sender: TObject);
    procedure sbAplicarClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure sbRefreshClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadFamilia: TcadFamilia;

implementation

{$R *.dfm}

uses cddm;

procedure TcadFamilia.Button1Click(Sender: TObject);
begin
  close;

end;

procedure TcadFamilia.sbPrimeiroClick(Sender: TObject);
begin
  qryFamilia.First;
end;

procedure TcadFamilia.sbAnteriorClick(Sender: TObject);
begin
  qryFamilia.Prior;
end;

procedure TcadFamilia.sbProximoClick(Sender: TObject);
begin
  qryFamilia.Next;
end;

procedure TcadFamilia.sbUltimoClick(Sender: TObject);
begin
  qryFamilia.Last;
end;

procedure TcadFamilia.sbAddClick(Sender: TObject);
begin
  qryFamilia.Append;
  sbAplicar.Enabled := true;
end;

procedure TcadFamilia.sbRemoveClick(Sender: TObject);
begin
  qryFamilia.Delete;
end;

procedure TcadFamilia.sbEditarClick(Sender: TObject);
begin
  qryFamilia.Edit;
end;

procedure TcadFamilia.sbAplicarClick(Sender: TObject);
begin

  if (DBORG.Text = '') or
    (DBLOGO.Text = '') or
    (DBDESC.Text = '') or
    (DBCODBIN.Text = '') or
    (DBFAM.Text = '') then
  begin
    ShowMessage('Sem Dados para inserir registros');
    sbAplicar.Enabled := false;
  end
  else
  begin
    qryFamilia.Post;
    sbAplicar.Enabled := false;

  end;
end;

procedure TcadFamilia.sbCancelarClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente cancelar as alterações?', 'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = id_yes then
    qryFamilia.CancelUpdates;

end;

procedure TcadFamilia.sbRefreshClick(Sender: TObject);
begin
  qryFamilia.Refresh;

end;

procedure TcadFamilia.PageControl1Change(Sender: TObject);
begin
  sbAplicar.Enabled := False;
end;

end.

