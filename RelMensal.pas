unit RelMensal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, ZAbstractRODataset, ZDataset, ZAbstractDataset;

type
  TqrForm_RelMensal = class(TForm)
    RLRelMensal: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLPeriodo: TRLLabel;
    RLLabel6: TRLLabel;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLLabel7: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel8: TRLLabel;
    RLDBText2: TRLDBText;
    RLLabel9: TRLLabel;
    RLDraw3: TRLDraw;
    RLBand3: TRLBand;
    RLDBText3: TRLDBText;
    RLDraw4: TRLDraw;
    RLBand4: TRLBand;
    RLLabel10: TRLLabel;
    RLDBText4: TRLDBText;
    RLDTotGrupo: TRLDBResult;
    RLBand5: TRLBand;
    RLLabel11: TRLLabel;
    RLDTotGer: TRLDBResult;
    DtSRelMensal: TDataSource;
    qraRelMensal: TZQuery;
    qraRelMensalds_motivo: TStringField;
    qraRelMensalcd_produto: TStringField;
    qraRelMensalds_produto: TStringField;
    qraRelMensaltotal: TLargeintField;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  qrForm_RelMensal: TqrForm_RelMensal;

implementation

uses CDDM, Devolucoes;

{$R *.dfm}

procedure TqrForm_RelMensal.RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLLabel2.Caption  :=  RLLabel2.Caption+ FormatDateTime('dd/mm/yyyy',Date);
  RLPeriodo.Caption :=  'Perído: '+FormatDateTime('dd/mm/yyyy',DevolucoesFrm.cbDT_INICIAL.Date)+' à '+FormatDateTime('dd/mm/yyyy',DevolucoesFrm.cbDT_FINAL.Date);
end;

end.
