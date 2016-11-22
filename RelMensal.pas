unit RelMensal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, ZAbstractRODataset, ZDataset, ZAbstractDataset,
  ComCtrls, ExtCtrls;

type
  TqrForm_RelMensal = class(TForm)
    RLRelMensal: TRLReport;
    RLBandCabecalho: TRLBand;
    RLLabelTitulo: TRLLabel;
    RLLabelData: TRLLabel;
    RLLabelPagina: TRLLabel;
    RLSystemInfoNumPag: TRLSystemInfo;
    RLPeriodo: TRLLabel;
    RLLabelSubTitulo: TRLLabel;
    RLLabelDataRelatorio: TRLLabel;
    RLGroupProdutos: TRLGroup;
    RLDetailGridResumoLeituras: TRLDetailGrid;
    RLDTotalProduto: TRLDBResult;
    RLDBTextMotivo: TRLDBText;
    RLBandTotalProduto: TRLBand;
    RLLabelTotalGeral: TRLLabel;
    RLDBResultTotalProduto: TRLDBResult;
    RLBandColumHeader: TRLBand;
    RLLabelMotivos: TRLLabel;
    RLLabelQtde: TRLLabel;
    RLBandHeaderProduto: TRLBand;
    RLLabelProduto: TRLLabel;
    RLDBTextCodProduto: TRLDBText;
    RLDBTextDescricaoProduto: TRLDBText;
    RLBand1: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel1: TRLLabel;
    procedure FormCreate(Sender: TObject);
    procedure RLBandCabecalhoBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    dt_inicial, dt_final : TDate;
  end;

var
  qrForm_RelMensal: TqrForm_RelMensal;

implementation

uses CDDM;

{$R *.dfm}

procedure TqrForm_RelMensal.FormCreate(Sender: TObject);
begin
  dt_inicial := Date;
  dt_final := Date;
end;

procedure TqrForm_RelMensal.RLBandCabecalhoBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLLabelDataRelatorio.Caption  :=  FormatDateTime('dd/mm/yyyy', Date);
  RLPeriodo.Caption :=  'Perído: ' + FormatDateTime('dd/mm/yyyy', dt_inicial) +
    ' à ' + FormatDateTime('dd/mm/yyyy', dt_final);
end;

end.
