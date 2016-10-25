unit Cadastro_Org_Descricao;

interface

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, StdCtrls, Forms,
  Dialogs, DBCtrls, DB, DBGrids, DBTables, Grids, ExtCtrls, //ADODB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractTable;

type
  TOrgDescricaoFrm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1:  TDBGrid;
    DBNavigator:  TDBNavigator;
    qrDesOrg: TZTable;
    DtSDesOrg: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  OrgDescricaoFrm: TOrgDescricaoFrm;

implementation

uses Devolucoes;

{$R *.DFM}

procedure TOrgDescricaoFrm.FormCreate(Sender: TObject);
begin
  qrDesOrg.Close;
  qrDesOrg.Open;
end;

end.