unit Cadastro_Produtos;

interface

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, StdCtrls, Forms,
  Dialogs, DBCtrls, DB, DBGrids, DBTables, Grids, ExtCtrls, //ADODB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractTable;

type
  TProdutosFrm = class(TForm)
    qrProdutos: TZTable;
    DtSProd: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1:  TDBGrid;
    DBNavigator:  TDBNavigator;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ProdutosFrm: TProdutosFrm;

implementation

uses Devolucoes, CDDM;

{$R *.DFM}

procedure TProdutosFrm.FormCreate(Sender: TObject);
begin
//  qrProdutos.Close;
 // qrProdutos.Open;
end;

end.