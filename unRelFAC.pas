unit unRelFAC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, ComObj, StdCtrls, DB, Grids, ExtCtrls,
  ZAbstractRODataset, ZDataset, ADODB;//, ADODB;

type
  TfrmRelFAC = class(TForm)
    sbExcel: TSpeedButton;
    SBtnGer: TSpeedButton;
    cbDT_Devolucao: TDateTimePicker;
    StrGridDados: TStringGrid;
    BtnImp: TBitBtn;
    pMSG: TPanel;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    qryTotaisFAC: TZReadOnlyQuery;
    qryFamilaFAC: TZReadOnlyQuery;
    ADOQuery1: TZReadOnlyQuery;
    qryResumo: TZReadOnlyQuery;
    qryDevolFAC: TZReadOnlyQuery;
    qryFamilia: TZReadOnlyQuery;
    qryDatas: TZReadOnlyQuery;
    qryTotais: TZReadOnlyQuery;
    qryTotaisFACfamilia: TStringField;
    qryTotaisFACqtd: TLargeintField;
    qryTotaisFACds_motivo: TStringField;
    qryFamilaFACfamilia: TStringField;
    ADOQuery1qtde: TFloatField;
    ADOQuery1motivo: TStringField;
    ADOQuery1dt_devolucao: TDateField;
    ADOQuery1familia: TStringField;
    qryResumoqtde: TFloatField;
    qryResumomotivo: TStringField;
    qryResumodt_devolucao: TDateField;
    qryDevolFACqtde: TFloatField;
    qryDevolFACmotivo: TStringField;
    qryDevolFACdt_devolucao: TDateField;
    qryDevolFACfamilia: TStringField;
    qryFamiliafamilia: TStringField;
    qryTotaisqtde: TFloatField;
    qryTotaismotivo: TStringField;
    qryTotaisdt_devolucao: TDateField;
    qryDatasdt_devolucao: TStringField;
    procedure FormShow(Sender: TObject);
    procedure SBtnGerClick(Sender: TObject);
    procedure BtnImpClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbExcelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarArquivo: boolean;
  end;

var
  frmRelFAC: TfrmRelFAC;

implementation

{$R *.dfm}
uses cddm,unexcel;//VisualizadorTexto,

procedure TfrmRelFAC.SBtnGerClick(Sender: TObject);
begin
  DM.qArqFac.Close;
//  DM.qArqFac.Parameters.ParamByName('dt_devolucao').Value := trunc(cbDT_DEVOLUCAO.Date);
  DM.qArqFac.ParamByName('dt_devolucao').AsDate := trunc(cbDT_DEVOLUCAO.Date);
  DM.qArqFac.Open;

  if NOT(DM.qArqFac.IsEmpty) then
  begin
    GerarArquivo;
    pmsg.Caption := 'Relatório Gerado';
    pmsg.Refresh;

  end;

end;

function TfrmRelFAC.GerarArquivo: boolean;
var
  F: TextFile;
  s, sDir, sDev: string;
  ListaSLP: TStringList;
  SalvaSLP, sCartao: string;
  iAux: integer;
  ListaArq: TStringList;
begin
  Result := True;
  ListaArq := TStringList.Create;
  ListaSLP := TStringList.Create;
  sDir     :=  'F:\ibisis\RELATORIOS\';

  try
    if not DirectoryExists(sDir) then
    begin
      CreateDirectory(PAnsiChar(sDir), nil);
    end;

//    sDir:= sdir+'ADDRESS2ACC.CARTAO.IBI.FAC.PROTOCOLO_' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) +FormatDateTime('HHMMSS', cbDT_Devolucao.Time)+ '.TXT';
    sDir:= sdir;
    //+'CARTAO.IBI.FAC.PROTOCOLO_' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) +FormatDateTime('HHMMSS', cbDT_Devolucao.Time)+ '.TXT';
{    if not FileExists(sDir) then
    begin
      CreateFile(PAnsiChar(sDir),GENERIC_ALL,0,nil,CREATE_ALWAYS,0,0);
//      GENERIC_READ or GENERIC_WRITE or
    end;}

    ListaArq.Add('CARTAO.IBI.FAC.PROTOCOLO_');

    ListaSLP.Add(StringOfChar('-', 70));
    ListaSLP.Add('Devolução IBI - Cartões');
    ListaSLP.Add(StringOfChar('-', 70));
    ListaSLP.Add('Data da Devolução:' + FormatDateTime('DD/MM/YYYY', cbDT_DEVOLUCAO.Date));
    ListaSLP.Add('Total de Objetos : ' + FormatFloat('##,##0', DM.qArqFac.RecordCount));
    ListaSLP.Add(StringOfChar('-', 70));
    ListaSLP.Add('Cartões:');

    DM.qArqFac.First;
    sCartao := '';
    iAux := 0;
    while not DM.qArqFac.Eof do
    begin
      s := DM.qArqFacNRO_CARTAO.AsString + '005' + DM.qArqFacCD_MOTIVO.AsString + DM.qArqFacDATA.AsString;
      if iAux < 4 then
      begin
        if iAux = 0 then
        begin
          sCartao := copy(DM.qArqFacNRO_CARTAO.AsString, 1, 6) + '******' + copy(DM.qArqFacNRO_CARTAO.AsString, 13, 4);
          inc(iAux);
        end
        else
        begin
          if iAux <> 3 then
          begin
            sCartao := sCartao + '  ' + copy(DM.qArqFacNRO_CARTAO.AsString, 1, 6) + '******' + copy(DM.qArqFacNRO_CARTAO.AsString, 13, 4);
            inc(iAux);
          end
          else
          begin
            sCartao := sCartao + '  ' + copy(DM.qArqFacNRO_CARTAO.AsString, 1, 6) + '******' + copy(DM.qArqFacNRO_CARTAO.AsString, 13, 4);
            ListaSLP.Add(sCartao);
            iAux := 0;
            sCartao := '';
          end;
        end;
      end;
      DM.qArqFac.Next;
    end;
    ListaSLP.Add(sCartao);
    ListaSLP.Add(StringOfChar('-', 70));
    dm.qData.Open;
    ListaSLP.Add('©'+ FormatDateTime('DDMMYYYY', DM.qdatadata.AsDateTime));
    ListaSLP.Add(format('%-51.51s%',['ADDRESS SA']) + FormatDateTime('DD/MM/YYYY HH:MM:SS', cbDT_Devolucao.Time));
    ListaSLP.SaveToFile(sdir+'CARTAO.IBI.FAC.PROTOCOLO_' + FormatDateTime('DDMMYYYY', dm.SqlAux.Fields[0].AsDateTime) +FormatDateTime('HHMMSS', dm.SqlAux.Fields[1].AsDateTime)+ '.TMP');
    Application.ProcessMessages;
  finally
    ListaSLP.Free;
  end;
end;

procedure TfrmRelFAC.BtnImpClick(Sender: TObject);
var
  col, ilinha: Integer;
begin
  ilinha := 1;

  qryDevolFAC.Close;
//  qryDevolFAC.Parameters.ParamByName('DT_DEVOL').Value := trunc(cbDT_DEVOLUCAO.Date);
  qryDevolFAC.ParamByName('DT_DEVOL').AsDate := trunc(cbDT_DEVOLUCAO.Date);
  qryDevolFAC.Open;
  qryDevolFAC.First;

  if qryDevolFAC.RecordCount > 0 then
  begin
    StrGridDados.RowCount := qryDevolFAC.RecordCount + 1;
    StrGridDados.Cells[0, 0] := 'QTD';
    StrGridDados.Cells[1, 0] := 'MOTIVO';
    StrGridDados.Cells[2, 0] := 'DT_DEVOLUCAO';
    StrGridDados.Cells[3, 0] := 'FAMILIA';
    while not qryDevolFAC.Eof do
    begin
      StrGridDados.Cells[0, ilinha] := qryDevolFACQTDE.AsString;
      StrGridDados.Cells[1, ilinha] := qryDevolFACMOTIVO.AsString;
      StrGridDados.Cells[2, ilinha] := qryDevolFACDT_DEVOLUCAO.AsString;
      StrGridDados.Cells[3, ilinha] := qryDevolFACFAMILIA.AsString;
      inc(ilinha);
      qryDevolFAC.Next;
    end;
    pMSG.Caption := 'Pesquisa Concluída';
    pMSG.Refresh;
    SBtnGer.Enabled := True;
  end
  else
  begin
    sbExcel.Enabled := False;
    pMSG.Caption := 'Não há dados para a data selecionada';
    pMSG.Refresh;
    StrGridDados.Cells[0, 0] := '';
    StrGridDados.Cells[1, 0] := '';
    StrGridDados.Cells[2, 0] := '';
    StrGridDados.Cells[3, 0] := '';
    for col := 0 to StrGridDados.rowCount - 1 do
    begin
      StrGridDados.Cells[col, 1] := '';
      StrGridDados.Cells[col, 2] := '';
      StrGridDados.Cells[col, 3] := '';
      StrGridDados.Cells[col, 4] := '';
    end;
    StrGridDados.RowCount := 1;
  end;
end;

procedure TfrmRelFAC.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRelFAC.FormCreate(Sender: TObject);
begin
  cbDT_Devolucao.Date := Now;
end;

procedure TfrmRelFAC.FormShow(Sender: TObject);
begin
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date,localtime(0)');
  dm.SqlAux.Open;
  cbDT_Devolucao.Date :=  dm.SqlAux.Fields[0].AsDateTime;
end;

procedure TfrmRelFAC.sbExcelClick(Sender: TObject);
begin
  frmExcel := TfrmExcel.Create(Self);
  frmExcel.ShowModal;
  frmExcel.Free;

end;

end.

