unit RelMotivos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables, ADODB,
  ZAbstractRODataset, ZDataset;

type
  TqrForm_RelMotivos = class(TQuickRep)
    QRBand1: TQRBand;
    Detail: TQRBand;
    QRBand3: TQRBand;
    QRLabel2: TQRLabel;
    QRExpr10: TQRExpr;
    QRLabel66: TQRLabel;
    QRExpr11: TQRExpr;
    QRLabel12: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel152: TQRLabel;
    qlPeriodo: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel139: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    qraMotivosTot1: TADOQuery;
    qraMotivosTot: TZReadOnlyQuery;
  private

  public

  end;

var
  qrForm_RelMotivos: TqrForm_RelMotivos;

implementation
uses Devolucoes;

{$R *.DFM}

end.
