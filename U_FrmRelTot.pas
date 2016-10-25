unit U_FrmRelTot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,Types, ExtCtrls, ZAbstractRODataset, ZDataset, StdCtrls, Buttons,
  ComCtrls,Mask, OleServer,OleCtrls,
  ComObj, ActiveX, OleDB,OfficeXP,ExcelXP,Math,SysConst,ShlObj,OleConst, FileCtrl,
  DBCtrls, ZAbstractDataset;

type
  TFrmRelTot = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DTPinicial: TDateTimePicker;
    DTPFinal: TDateTimePicker;
    btnProc: TBitBtn;
    Btnsair: TBitBtn;
    qryRelTot: TZReadOnlyQuery;
    EdArq: TEdit;
    ZQRel: TZQuery;
    CboBox: TComboBox;
    qryRelTotMotivo: TStringField;
    qryRelTotQtde: TStringField;
    qryRelTotProduto: TMemoField;
    procedure btnProcClick(Sender: TObject);
    procedure BtnsairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure relana;
    procedure relsin;

  private
    { Private declarations }
      linha,coluna : integer;
      arquivo,cab :string;
      excel: variant;
      valor : string;

  public
    { Public declarations }
  end;

var
  FrmRelTot: TFrmRelTot;

implementation

uses U_Func, CDDM;

{$R *.dfm}
procedure TFrmRelTot.relana;
var   XL : TDataSetToExcel;
begin
  qryRelTot.Params[0].AsDate  :=  DTPinicial.Date;
  qryRelTot.Params[1].AsDate  :=  DTPFinal.Date;
  qryRelTot.Open;
  cab := '';
  case qryRelTot.RecordCount of
    0:  Application.MessageBox(PChaR('Registro Encontrado: '+IntToStr(qryRelTot.RecordCount)),'IBISIS',IDOK);
    else
      begin
      EdArq.Text  :=  DM.unidade+'ibisis\RELATORIOS\analitico';
      if (Not(DirectoryExists(EdArq.Text)))  then
        MkDir(EdArq.Text);
      EdArq.Text :=  EdArq.Text+'\Total'+FormatDateTime('mmyyyy',TRUNC(DTPFinal.Date))+'.xls';;
      XL := TDataSetToExcel.Create(qryRelTot,EdArq.Text,cab);
      XL.WriteFile;
      XL.Free;
      qryRelTot.Close;
      end;
  end;

end;
procedure TFrmRelTot.relsin;
var   XL : TDataSetToExcel;
begin
  with DM do
  begin
    ZQRel.Close;
    ZQRel.SQL.Clear;

    case CboBox.ItemIndex of
      0:
        begin
          valor :='  (select dt_devolucao as "Data" ,''AR'' as "Produto",count(cod_ar) as "Qtde" from ibi_controle_devolucoes_ar ';
          valor :=  valor +'where (dt_devolucao between :par1 and :par2) ';
          valor :=  valor +'group by dt_devolucao) ';
          valor :=  valor +'union ';
          valor :=  valor +'(select dt_devolucao as "Data",''FAC'' as "Produto",count(nro_cartao) as "Qtde" from ibi_controle_devolucoes_fac ';
          valor :=  valor +'where (dt_devolucao between :par1 and :par2) ';
          valor :=  valor +'group by dt_devolucao) ';
          valor :=  valor +'union ';
          valor :=  valor +'(select dt_devolucao as "Data",''FAT'' as "Produto",count(nro_conta) as "Qtde" from cea_controle_devolucoes ';
          valor :=  valor +'where (dt_devolucao between :par1 and :par2) ';
          valor :=  valor +'group by dt_devolucao) ';
          valor :=  valor +'order by 2,1';
          ZQRel.SQL.Add(valor);
          ZQRel.Params[0].AsDate  :=  trunc(DTPinicial.Date);
          ZQRel.Params[1].AsDate  :=  trunc(DTPFinal.Date);
        end;
      1:
        begin
            valor :='  (select to_char(dt_devolucao,''mm/yyyy'') as "Data" ,''AR'' as "Produto",count(cod_ar) as "Qtde" from ibi_controle_devolucoes_ar ';
            valor :=  valor +'where (to_char(dt_devolucao,''yyyymm'') = :par1) ';
            valor :=  valor +'group by "Data") ';
            valor :=  valor +'union ';
            valor :=  valor +'(select to_char(dt_devolucao,''mm/yyyy'') as "Data",''FAC'' as "Produto",count(nro_cartao) as "Qtde" from ibi_controle_devolucoes_fac ';
            valor :=  valor +'where (to_char(dt_devolucao,''yyyymm'') = :par1) ';
            valor :=  valor +'group by "Data") ';
            valor :=  valor +'union ';
            valor :=  valor +'(select to_char(dt_devolucao,''mm/yyyy'') as "Data",''FAT'' as "Produto",count(nro_conta) as "Qtde" from cea_controle_devolucoes ';
            valor :=  valor +'where (to_char(dt_devolucao,''yyyymm'') = :par1) ';
            valor :=  valor +'group by "Data") ';
            valor :=  valor +'order by 2,1';
          ZQRel.SQL.Add(valor);
          ZQRel.Params[0].AsString  :=  FormatDateTime('yyyymm',trunc(DTPinicial.Date));
//--          ZQRel.Params[1].AsDate  :=  trunc(DTPFinal.Date);
        end;
      2:
        begin
          valor :='  (select ''AR'' as "Produto",count(cod_ar) as "Qtde" from ibi_controle_devolucoes_ar ';
          valor :=  valor +'where (to_char(dt_devolucao,''yyyy'') = :par1) ';
          valor :=  valor +') ';
          valor :=  valor +'union ';
          valor :=  valor +'(select ''FAC'' as "Produto",count(nro_cartao) as "Qtde" from ibi_controle_devolucoes_fac ';
          valor :=  valor +'where (to_char(dt_devolucao,''yyyy'') = :par1) ';
          valor :=  valor +') ';
          valor :=  valor +'union ';
          valor :=  valor +'(select ''FAT'' as "Produto",count(nro_conta) as "Qtde" from cea_controle_devolucoes ';
          valor :=  valor +'where (to_char(dt_devolucao,''yyyy'') = :par1) ';
          valor :=  valor +') ';
          valor :=  valor +'order by 1';
          ZQRel.SQL.Add(valor);
          ZQRel.Params[0].AsString  :=  FormatDateTime('yyyy',trunc(DTPinicial.Date));
        end;
    end;
  ZQRel.Open;
  cab := '';
  case ZQRel.RecordCount of
    0:  Application.MessageBox(PChaR('Registro Encontrado: '+IntToStr(qryRelTot.RecordCount)),'IBISIS',IDOK);
    else
      begin
      EdArq.Text  :=  DM.unidade+'ibisis\RELATORIOS\sintetico';
      if (Not(DirectoryExists(EdArq.Text)))  then
        MkDir(EdArq.Text);
      EdArq.Text :=  EdArq.Text+'\Total'+FormatDateTime('mmyyyy',TRUNC(DTPFinal.Date))+'.xls';;
      XL := TDataSetToExcel.Create(ZQRel,EdArq.Text,cab);
      XL.WriteFile;
      XL.Free;
      end;
  end;

  end;
end;
procedure TFrmRelTot.btnProcClick(Sender: TObject);
begin
  case self.Tag of
    0 : relana;
  else relsin;
  end;
end;

procedure TFrmRelTot.BtnsairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmRelTot.FormShow(Sender: TObject);
begin
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date,localtime(0)');
  dm.SqlAux.Open;
  DTPinicial.Date :=  dm.SqlAux.Fields[0].AsDateTime;
  DTPFinal.Date   :=  dm.SqlAux.Fields[0].AsDateTime;

  case SELF.TAG of
    1: CboBox.Enabled :=  true;
  end;

end;

end.
