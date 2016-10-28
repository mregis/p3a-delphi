unit Cadastro_Org_Bin;

interface

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, StdCtrls, Forms,
  Dialogs, DBCtrls, DB, DBGrids, DBTables, Grids, ExtCtrls, //ADODB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractTable, ADODB;

type
  TOrgBinFrm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    qrBin: TZTable;
    DtSBin: TDataSource;
    DBGrid1:  TDBGrid;
    DBNavigator:  TDBNavigator;

    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  OrgBinFrm: TOrgBinFrm;

implementation
uses Devolucoes, CDDM;

{$R *.DFM}

procedure TOrgBinFrm.FormCreate(Sender: TObject);
begin
  //qrBin.Close;
  //qrBin.Open;
end;

end.
