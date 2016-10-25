unit RelMensal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables, ADODB,
  ZAbstractRODataset, ZDataset;

type
  TqrForm_RelMensal = class(TQuickRep)
    QRGroup1: TQRGroup;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    PageHeaderBand1: TQRBand;
    QRExpr10: TQRExpr;
    QRLabel66: TQRLabel;
    QRLabel38: TQRLabel;
    QRExpr11: TQRExpr;
    QRLabel152: TQRLabel;
    qlPeriodo: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel139: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel6: TQRLabel;
    qrbGp: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel7: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel1: TQRLabel;
    qraRelMensal1: TADOQuery;
    qraRelMensal: TZReadOnlyQuery;
  private

  public

  end;

var
  qrForm_RelMensal: TqrForm_RelMensal;

implementation

uses Devolucoes;

{$R *.DFM}

end.
