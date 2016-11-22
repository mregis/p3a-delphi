unit RelMotivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, ZAbstractRODataset, ZDataset;

type
  TqrForm_RelMotivos = class(TForm)
    RLRelMotivos: TRLReport;
    qraMotivosTot: TZReadOnlyQuery;
    DtsMotivosTot: TDataSource;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel4: TRLLabel;
    qlPeriodo: TRLLabel;
    RLDraw1: TRLDraw;
    RLLabel5: TRLLabel;
    RLDraw2: TRLDraw;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand3: TRLBand;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel8: TRLLabel;
    RLDraw3: TRLDraw;
    RLBand4: TRLBand;
    RLLabel9: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDraw4: TRLDraw;
    RLBand5: TRLBand;
    RLLabel10: TRLLabel;
    RLDBResult2: TRLDBResult;
    procedure RLRelMotivosBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dt_inicial, dt_final : TDateTime; 
  end;

var
  qrForm_RelMotivos: TqrForm_RelMotivos;

implementation

uses CDDM;

{$R *.dfm}

procedure TqrForm_RelMotivos.FormCreate(Sender: TObject);
begin
  dt_inicial := Date;
  dt_final := Date;
end;

procedure TqrForm_RelMotivos.FormShow(Sender: TObject);
begin
  qraMotivosTot.Close;
  qraMotivosTot.ParamByName('dti').AsDate := dt_inicial;
  qraMotivosTot.ParamByName('dtf').AsDate := dt_final;
  qraMotivosTot.Open;
end;

procedure TqrForm_RelMotivos.RLRelMotivosBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
    qlPeriodo.Caption := DateToStr(dt_inicial) + ' à ' + DateToStr(dt_final);
end;

end.
