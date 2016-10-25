unit unRelAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, ComObj, StdCtrls, ComCtrls, ExtCtrls, DB, //ADODB,
  ZAbstractRODataset, ZDataset, ZAbstractDataset, ZAbstractTable;

type
  TfrmRelAr = class(TForm)
    pMSG: TPanel;
    Label1: TLabel;
    cbDT_Devolucao: TDateTimePicker;
    BtnImprime: TBitBtn;
    sbRel: TSpeedButton;
    SBtRel: TSpeedButton;
    BtnSair: TBitBtn;
    StringGrid1: TStringGrid;
    qryTotaisCorrier: TZReadOnlyQuery;
    qryFamilaCOR: TZReadOnlyQuery;
    qryTotaisRemessa: TZReadOnlyQuery;
    qryFamilaRE: TZReadOnlyQuery;
    qryResumoREM: TZReadOnlyQuery;
    qryDatasREM: TZReadOnlyQuery;
    qryTotaisREM: TZReadOnlyQuery;
    qryDevolARRem: TZReadOnlyQuery;
    qryResumoCour: TZReadOnlyQuery;
    qryTotaisCour: TZReadOnlyQuery;
    qryDevolARCou: TZReadOnlyQuery;
    qryTotais: TZReadOnlyQuery;
    qryDevolAR: TZReadOnlyQuery;
    qryResumo: TZReadOnlyQuery;
    qryFamilia: TZReadOnlyQuery;
    qryDatas: TZReadOnlyQuery;
    qryDatasCour: TZReadOnlyQuery;
    qryTotaisCorrierfamilia: TStringField;
    qryTotaisCorrierqtd: TLargeintField;
    qryTotaisCorrierds_motivo: TStringField;
    qryTotaisRemessafamilia: TStringField;
    qryTotaisRemessaqtd: TLargeintField;
    qryTotaisRemessads_motivo: TStringField;
    qryFamilaCORfamilia: TStringField;
    qryFamilaREfamilia: TStringField;
    qryResumoREMqtde: TFloatField;
    qryResumoREMmotivo: TStringField;
    qryResumoREMcod_mot: TStringField;
    qryResumoREMdt_devolucao: TDateField;
    qryTotaisCourqtde: TFloatField;
    qryTotaisCourmotivo: TStringField;
    qryTotaisCourdt_devolucao: TDateField;
    qryDevolARCouqtde: TFloatField;
    qryDevolARCoumotivo: TStringField;
    qryDevolARCoudt_devolucao: TDateField;
    qryDevolARCoufamilia: TStringField;
    qryTotaisREMqtde: TFloatField;
    qryTotaisREMmotivo: TStringField;
    qryTotaisREMdt_devolucao: TDateField;
    qryTotaisqtde: TFloatField;
    qryTotaismotivo: TStringField;
    qryTotaisdt_devolucao: TDateField;
    qryDevolARRemqtde: TFloatField;
    qryDevolARRemmotivo: TStringField;
    qryDevolARRemdt_devolucao: TDateField;
    qryDevolARRemfamilia: TStringField;
    qryResumoCourqtde: TFloatField;
    qryResumoCourmotivo: TStringField;
    qryResumoCourdt_devolucao: TDateField;
    qryResumoqtde: TFloatField;
    qryResumomotivo: TStringField;
    qryResumodt_devolucao: TDateField;
    qryDevolAR2: TZTable;
    qryDevolARqtde: TFloatField;
    qryDevolARmotivo: TStringField;
    qryDevolARdt_devolucao: TDateField;
    qryDevolARfamilia: TStringField;
    qryDatasCourdt_devolucao: TStringField;
    qryDatasdt_devolucao: TStringField;
    qryFamiliafamilia: TStringField;
    qryDatasREMdt_devolucao: TStringField;
    procedure BtnSairClick(Sender: TObject);
    procedure BtnImprimeClick(Sender: TObject);
    procedure SBtRelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbRelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarArquivo: boolean;
  end;

var
  frmRelAr: TfrmRelAr;

implementation

{$R *.dfm}
uses CDDM,unexcel ;

procedure TfrmRelAr.BtnSairClick(Sender: TObject);
begin
//  Application.Terminate;
  close;
end;

procedure TfrmRelAr.BtnImprimeClick(Sender: TObject);
var
  col, ilinha: Integer;
begin
  ilinha := 1;

  qryDevolAR.Close;
  qryDevolAR.Params.ParamByName('DT_DEVOL').AsDate   := cbDT_DEVOLUCAO.Date; //trunc(cbDT_DEVOLUCAO.Date);
//  qryDevolAR.ParamByName('DT_DEVOL').Value := trunc(cbDT_DEVOLUCAO.Date);
  qryDevolAR.Open;
  qryDevolAR.First;
  StringGrid1.ColWidths[0] := 100;
  StringGrid1.ColWidths[1] := 200;
  StringGrid1.ColWidths[2] := 100;
  StringGrid1.ColWidths[3] := 140;

  if qryDevolAR.RecordCount > 0 then
  begin

    StringGrid1.RowCount := qryDevolAR.RecordCount + 1;
    StringGrid1.Cells[0, 0] := 'QTD';
    StringGrid1.Cells[1, 0] := 'MOTIVO';
    StringGrid1.Cells[2, 0] := 'DT_DEVOLUCAO';
    StringGrid1.Cells[3, 0] := 'FAMILIA';
    while not qryDevolAR.Eof do
    begin
      StringGrid1.Cells[0, ilinha] := qryDevolARQTDE.AsString;
      StringGrid1.Cells[1, ilinha] := qryDevolARMOTIVO.AsString;
      StringGrid1.Cells[2, ilinha] := qryDevolARDT_DEVOLUCAO.AsString;
      StringGrid1.Cells[3, ilinha] := qryDevolARFAMILIA.AsString;
      inc(ilinha);
      qryDevolAR.Next;
    end;
    pMSG.Caption := 'Pesquisa Concluída';
    pMSG.Refresh;
    SBtRel.Enabled := True;
  end
  else
  begin
    //SpeedButton1.Enabled := False;
    pMSG.Caption := 'Não há dados para a data selecionada';
    pMSG.Refresh;
    StringGrid1.Cells[0, 0] := '';
    StringGrid1.Cells[1, 0] := '';
    StringGrid1.Cells[2, 0] := '';
    StringGrid1.Cells[3, 0] := '';
    for col := 0 to StringGrid1.rowCount - 1 do
    begin
      StringGrid1.Cells[col, 1] := '';
      StringGrid1.Cells[col, 2] := '';
      StringGrid1.Cells[col, 3] := '';
      StringGrid1.Cells[col, 4] := '';
    end;
    StringGrid1.RowCount := 1;
  end;
end;

procedure TfrmRelAr.SBtRelClick(Sender: TObject);
begin
  DM.qArqAR.Close;
//  DM.qArqAR.ParamByName('dt_devolucao').AsDate  := cbDT_DEVOLUCAO.Date ;//trunc(cbDT_DEVOLUCAO.Date);
  DM.qArqAR.Params[0].AsDate  := trunc(cbDT_DEVOLUCAO.Date);
  DM.qArqAR.Params[1].AsDate  := trunc(cbDT_DEVOLUCAO.Date);
//  inputbox('','',DM.qArqAR.SQL.Text);
  DM.qArqAR.Open;

  if not DM.qArqAR.IsEmpty then
  begin
    GerarArquivo;
    pmsg.Caption := 'Relatório Gerado';
    pmsg.Refresh;

  end;

end;

function TfrmRelAr.GerarArquivo: boolean;
var
  F, A: TextFile;
  s, sAusente, sDir: string;
  bAusente: Boolean;
  ListaSLP: TStringList;
  sCartao: string;
  iAux: integer;
begin

  Result := True;
  ListaSLP := TStringList.Create;
  sDir := 'F:\ibisis' ;
  if (Not DirectoryExists(sDir))  then
    MkDir(sDir);
  sDir  :=  sDir  + '\RELATORIOS';
  if (Not DirectoryExists(sDir))  then
    MkDir(sDir);
  try
    DM.qParam.Close;
    DM.qParam.Open;

    bAusente := False;
    {if DM.qParamAUSENTE.AsString = 'S' then
    begin
      DM.qAusente.Close;
      DM.qAusente.ParamByName('data').Value       := FormatDateTime('YYYYMMDD', trunc(cbDT_DEVOLUCAO.Date));
      DM.qAusente.ParamByName('cd_motivo').Value  := DM.qParamCD_MOTIVO.AsString;
      DM.qAusente.Open;

      if not DM.qAusente.IsEmpty then
        bAusente := True;
    end;}

    ListaSLP.Add(StringOfChar('-', 108));
    ListaSLP.Add('                       Devolução IBI - ARs                      ');
    ListaSLP.Add(StringOfChar('-', 108));
    if bAusente then
    begin
      ListaSLP.Add('Arquivo Outros   : ' + 'ADDRESS2ACC.OUTR.IBI.AR.' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('hhmmss',Time)+'.TMP');
      ListaSLP.Add('Arquivo Ausente  : ' + 'ADDRESS2ACC.AUSR.IBI.AR.' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('hhmmss',Time)+'.TMP');
    end
    else
      ListaSLP.Add('Arquivo Outros   : ' + 'ADDRESS2ACC.OUTR.IBI.AR.' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('hhmmss',Time)+'.TMP');

    ListaSLP.Add('Data da Devolução: ' + FormatDateTime('DD/MM/YYYY', cbDT_DEVOLUCAO.Date));

    if bAusente then
    begin
      ListaSLP.Add('Total de Objetos Outros   : ' + FormatFloat('##,##0', DM.qArqAR.RecordCount - DM.qAusente.RecordCount));
      ListaSLP.Add('Total de Objetos Ausentes : ' + FormatFloat('##,##0', DM.qAusente.RecordCount));
    end
    else
    begin
      ListaSLP.Add('Total de Objetos Outros   : ' + FormatFloat('##,##0', DM.qArqAR.RecordCount));
      ListaSLP.Add('Total de Objetos Ausentes : ' + FormatFloat('##,##0', 0));
    end;

    ListaSLP.Add(StringOfChar('-', 108));
    ListaSLP.Add('Código AR:');
    DM.qArqAR.First;
    sAusente := '';
    sCartao := '';
    iAux := 0;
    while not DM.qArqAR.Eof do
    begin
      if not bAusente then
        s := DM.qArqARCOD_AR.AsString + DM.qArqARCD_MOTIVO.AsString + '005'
      else
      begin
        if DM.qArqARCD_MOTIVO.AsString = DM.qParamCD_MOTIVO.AsString then
        begin
          sAusente := DM.qArqARCOD_AR.AsString + DM.qArqARCD_MOTIVO.AsString + DM.qArqARDATA.AsString;
          s := '';
        end
        else
        begin
          s := DM.qArqARCOD_AR.AsString + DM.qArqARCD_MOTIVO.AsString + '005';
          sAusente := '';
        end;
      end;

      if iAux < 5 then
      begin
        if iAux = 0 then
        begin
          sCartao := DM.qArqARCOD_AR.AsString + ' ' + DM.qArqARCODBIN.AsString;
          inc(iAux);
        end
        else
        begin
          if iAux <> 4 then
          begin
            sCartao := sCartao + '  ' + DM.qArqARCOD_AR.AsString + ' ' + DM.qArqARCODBIN.AsString;
            inc(iAux);
          end
          else
          begin
            sCartao := sCartao + '  ' + DM.qArqARCOD_AR.AsString + ' ' + DM.qArqARCODBIN.AsString;
            ListaSLP.Add(sCartao);
            iAux := 0;
            sCartao := '';
          end;
        end;
      end;

      DM.qArqAR.Next;
    end;

    DM.qData.Close;
    DM.qData.Open;
    ListaSLP.Add(sCartao);
    ListaSLP.Add(StringOfChar('-', 108));
    ListaSLP.Add(format('%-10.10s%',['© ' + FormatDateTime('MMYYYY', DM.qdatadata.AsDateTime)])
    +   format('%-77.77s%',['ADDRESS SA'])+ FormatDateTime('DD/MM/YYYY',DM.qDatadata.AsDateTime)+ FormatDateTime(' - HH:MM:SS',dm.SqlAux.Fields[1].AsDateTime));
    ListaSLP.SaveToFile(sDir +'\'+ 'ADDRESS2ACC.IBI.AR'+FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS', dm.SqlAux.Fields[1].AsDateTime) + '.SLP');
    Application.ProcessMessages;
    pMsg.Caption := '';
  finally
    ListaSLP.Free;

  end;
end;

procedure TfrmRelAr.FormCreate(Sender: TObject);
begin
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date,localtime(0)');
  dm.SqlAux.Open;
  cbDT_Devolucao.Date :=  dm.SqlAux.Fields[0].AsDateTime; 
end;

procedure TfrmRelAr.sbRelClick(Sender: TObject);
begin
  frmExcel := TfrmExcel.Create(Self);
  frmExcel.ShowModal;
  frmExcel.Free;
end;


end.

