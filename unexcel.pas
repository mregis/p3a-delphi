unit unExcel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj, CheckLst, DB,Excel2000,  DBCtrls, ZAbstractDataset,ShlObj,OleConst,SysConst,Math,
  Grids, ExcelXP, ExtCtrls, ComCtrls,  Buttons,  Types, OfficeXP,ActiveX,  OleServer, ZDataset, ZAbstractRODataset;
  //ADODB;

type
  TfrmExcel = class(TForm)
    dsDatas: TDataSource;
    CheckListBox1: TCheckListBox;
    btnGerar: TButton;
    Label1: TLabel;
    pMSG: TPanel;
    btnSair: TButton;
    qryDatasREM: TZReadOnlyQuery;
    qryDatasCour: TZReadOnlyQuery;
    qryDatasFAC: TZReadOnlyQuery;
    qryDevolARRem: TZReadOnlyQuery;
    qryDevolFAC: TZReadOnlyQuery;
    qryDatas: TZQuery;
    qryConsolidado: TZReadOnlyQuery;
    qryFamilia: TZReadOnlyQuery;
    qryDatasFACdt_devolucao: TStringField;
    qryDatasREMdt_devolucao: TStringField;
    ExcelApplication1: TExcelApplication;
    EdArq: TEdit;
    Label2: TLabel;
    qryDatasCourdt_devolucao: TStringField;
    qryDevolARCou: TZReadOnlyQuery;
    qryDevolARCouqtde: TFloatField;
    qryDevolARCoumotivo: TStringField;
    qryDevolARCoudt_devolucao: TDateField;
    qryDevolARCoufamilia: TStringField;
    qryDevolARRemqtde: TFloatField;
    qryDevolARRemmotivo: TStringField;
    qryDevolARRemdt_devolucao: TDateField;
    qryDevolARRemfamilia: TStringField;
    qryFamiliafamilia: TStringField;
    qryDevolFat: TZReadOnlyQuery;
    qryDevolFACqtde: TFloatField;
    qryDevolFACmotivo: TStringField;
    qryDevolFACdt_devolucao: TDateField;
    qryDevolFACfamilia: TStringField;
    qryDatasFAT: TZReadOnlyQuery;
    qryDatasmes: TStringField;
    qryDatasano: TStringField;
    qryDatasFATdt_devolucao: TStringField;
    qryDevolFatqtde: TFloatField;
    qryDevolFatmotivo: TStringField;
    qryDevolFatdt_devolucao: TDateField;
    qryDevolFatfamilia: TStringField;
    qryConsolidadofamilia: TStringField;
    qryConsolidadods_motivo: TStringField;
    qryConsolidadoqtd: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  Sheet, Excel: variant;
  public
    { Public declarations }
    function CalculaData(sData: string): string;
  end;

var
  frmExcel: TfrmExcel;

implementation

uses cddm;
{$R *.dfm}

procedure TfrmExcel.FormCreate(Sender: TObject);
begin
  Label2.Caption  :=  '';
  qryDatas.Close;
  qryDatas.Open;
  while not qryDatas.Eof do
  begin
    CheckListBox1.Items.Add(qryDatasmes.AsString+'/'+qryDatasano.AsString);
    //FormatDateTime('mm/yyyy',qryDatasdt_devolucao.AsDateTime));
    qryDatas.Next;
  end;
end;
procedure TfrmExcel.btnGerarClick(Sender: TObject);
var
  coluna,coluna_anterior,sum_outros,  sum_info,  sum_cep_zerado ,
  sum_cep_generico,  sum_mudou,  sum_end_insuf, sum_nao_existe,
  sum_desconhecido,  sum_recusado,  sum_nao_proc,  sum_ausente,
  sum_falecido,  sum_cep_errado : Integer;
  icount, linha, ZLINHA, i,j,k, iReg,
   col_atual2, col, col_atual,subtot,totger,totdia : integer;
  datas2, valor, datas, sData,fam_ant: string;
  datasql: TDateTime;
  sNomeArq, sDataINI, sDataFIM: string;
  SdataList: TStringList;
  ano, ano_ant, mes, mes_ant, dia: word;
begin
  sum_outros := 0;
  sum_info := 0;
  sum_cep_zerado := 0;
  sum_cep_generico := 0;
  sum_mudou := 0;
  sum_end_insuf := 0;
  sum_nao_existe := 0;
  sum_desconhecido := 0;
  sum_recusado := 0;
  sum_nao_proc := 0;
  sum_ausente := 0;
  sum_falecido := 0;
  sum_cep_errado := 0;
  col_atual := 3;
  linha   :=  2;
  ZLINHA  :=  2;
  totdia  :=0;
  pMSG.Caption := 'Aguarde ..... Gerando Planilhas ';
  pMSG.Refresh;

  SdataList := TStringList.Create;
  //qryFamilia.Open;
  for i := 0 to CheckListBox1.Items.Count - 1 do
  begin
    if CheckListBox1.Checked[i] then
      SdataList.Add(CheckListBox1.Items[i]);
  end;
  SdataList.Sort;

  j := SdataList.Count;
  for i := 0 to j - 1 do
  begin
    try
//      ExcelApplication1.Workbooks.Open(fileName,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,0);
      excel := CreateOleObject('Excel.Application');
      excel.Workbooks.add(1);
      excel.visible := false;
    except
      Application.MessageBox('Versão do Ms-Excel Incompatível', 'Erro', MB_OK + MB_ICONEXCLAMATION);
    end;

    try
      sum_outros        := 0;
      sum_info          := 0;
      sum_cep_zerado    := 0;
      sum_cep_generico  := 0;
      sum_mudou         := 0;
      sum_end_insuf     := 0;
      sum_nao_existe    := 0;
      sum_desconhecido  := 0;
      sum_recusado      := 0;
      sum_nao_proc      := 0;
      sum_ausente       := 0;
      sum_falecido      := 0;
      sum_cep_errado    := 0;
      col_atual         := 3;

      sNomeArq := SdataList[i];
      sDataFIM := CalculaData(sNomeArq);
      sDataINI := '01/' + sNomeArq;
     // ShowMessage(sDataFIM + '  ' + sDataINI);

      qryConsolidado.Close;
      qryConsolidado.SQL.Clear;
      qryConsolidado.SQL.Add('SELECT TEMP.FAMILIA, TEMP.DS_MOTIVO, SUM(TEMP.QTD) AS QTD ');
      qryConsolidado.SQL.Add('FROM (SELECT	FM.FAMILIA,	COUNT(F.COD_AR) AS QTD, ');
      qryConsolidado.SQL.Add('	D.DS_MOTIVO,F.CODBIN FROM    IBI_CONTROLE_DEVOLUCOES_AR F ');
      qryConsolidado.SQL.Add('    full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTIVO ');
      qryConsolidado.SQL.Add('    full join IBI_CADASTRO_FAMILIA FM on FM.CODBIN = F.CODBIN ');
      qryConsolidado.SQL.Add('WHERE (F.DT_DEVOLUCAO BETWEEN :DTINI_AR AND :DTFIM_AR) ');
      qryConsolidado.SQL.Add('GROUP BY	D.DS_MOTIVO,FM.FAMILIA  , F.CODBIN ');
      qryConsolidado.SQL.Add('UNION ALL ');
      qryConsolidado.SQL.Add('SELECT ');
      qryConsolidado.SQL.Add('	FM.FAMILIA, ');
      qryConsolidado.SQL.Add('	COUNT(F.NRO_CONTA) AS QTD, ');
      qryConsolidado.SQL.Add('	D.DS_MOTIVO,F.CODBIN ');
      qryConsolidado.SQL.Add('FROM ');
      qryConsolidado.SQL.Add('    CEA_CONTROLE_DEVOLUCOES F ');
      qryConsolidado.SQL.Add('    full join CEA_motivos_devolucoes D on D.CD_MOTIVO = F.CD_MOTIVO ');
      qryConsolidado.SQL.Add('    full join CEA_CADASTRO_FAMILIA FM on FM.CODBIN = F.CODBIN ');
      qryConsolidado.SQL.Add('WHERE ');
      qryConsolidado.SQL.Add('    (F.DT_DEVOLUCAO BETWEEN :DTINI_FAT AND :DTFIM_FAT) ');
      qryConsolidado.SQL.Add('GROUP BY ');
      qryConsolidado.SQL.Add('	D.DS_MOTIVO,FM.FAMILIA  , F.CODBIN ');
      qryConsolidado.SQL.Add('UNION ALL ');
      qryConsolidado.SQL.Add('SELECT	FM.FAMILIA,	COUNT(F.NRO_CARTAO) AS QTD,	D.DS_MOTIVO,F.CODBIN ');
      qryConsolidado.SQL.Add('FROM    IBI_CONTROLE_DEVOLUCOES_FAC F    ');
      qryConsolidado.SQL.Add('full join IBI_MOTIVO_DEVOLUCOES D on D.CD_MOTIVO = F.CD_MOTIVO ');
      qryConsolidado.SQL.Add('full join IBI_CADASTRO_FAMILIA FM on FM.CODBIN = F.CODBIN ');
      qryConsolidado.SQL.Add('WHERE   (to_char(F.DT_DEVOLUCAO,''yyyymm'') BETWEEN :DTINI_FAC AND :DTFIM_FAC) GROUP BY ');
      qryConsolidado.SQL.Add('	D.DS_MOTIVO,FM.FAMILIA , F.CODBIN             ');
      qryConsolidado.SQL.Add(') TEMP GROUP BY TEMP.FAMILIA, TEMP.DS_MOTIVO ');
      qryConsolidado.SQL.Add('ORDER BY TEMP.FAMILIA, TEMP.DS_MOTIVO');
      qryConsolidado.ParamByName('DTINI_AR').AsString :=  FormatDateTime('yyyy/mm/dd',StrToDate(sDataINI));
      qryConsolidado.ParamByName('DTFIM_AR').AsString :=  FormatDateTime('yyyy/mm/dd',StrToDate(sDataFIM));
      qryConsolidado.ParamByName('DTINI_FAC').AsString :=  FormatDateTime('yyyymm',StrToDate(sDataINI));
      qryConsolidado.ParamByName('DTFIM_FAC').AsString :=  FormatDateTime('yyyyMm',StrToDate(sDataFIM));
      qryConsolidado.ParamByName('DTINI_FAT').AsString :=  FormatDateTime('yyyy/mm/dd',StrToDate(sDataINI));
      qryConsolidado.ParamByName('DTFIM_FAT').AsString :=  FormatDateTime('yyyy/mm/dd',StrToDate(sDataFIM));
      qryConsolidado.Open;
      qryConsolidado.First;
      sNomeArq := StringReplace(sNomeArq, '/', '_', [rfReplaceAll]);
      excel.Workbooks[1].WorkSheets[1].Name := 'Resumo_consolidado';
      Sheet := Excel.Workbooks[1].WorkSheets['Resumo_consolidado'];
 //     excel.Workbooks[1].WorkSheets[1].Name := 'Resumo_consolidado_' + sNomeArq;
//      Sheet := Excel.Workbooks[1].WorkSheets['Resumo_consolidado_' + sNomeArq];
      excel.cells[1, 1] := 'FAMILIA';
      excel.cells[1, 2] := 'AUSENTE';
      excel.cells[1, 3] := 'CEP ERRADO';
      excel.cells[1, 4] := 'CEP GENERICO';
      excel.cells[1, 5] := 'CEP ZERADO';
      excel.cells[1, 6] := 'DESCONHECIDO';
      excel.cells[1, 7] := 'ENDERECO INSUFICIENTE';
      excel.cells[1, 8] := 'FALECIDO';
      excel.cells[1, 9] := 'INFO ESCRITA PELO PORTEIRO';
      excel.cells[1, 10] := 'MUDOU-SE';
      excel.cells[1, 11] := 'NÃO EXISTE O NÚMERO INDICADO';
      excel.cells[1, 12] := 'NÃO PROCURADO';
      excel.cells[1, 13] := 'OUTROS';
      excel.cells[1, 14] := 'RECUSADO';
      for coluna := 1 to 14 do
        sheet.cells[1, coluna].font.bold := true;

      excel.columns.autofit;
      if qryConsolidado.RecordCount>0 then
        Label2.Caption  :=  IntToStr(qryConsolidado.RecordCount);
      qryConsolidado.First;

//**********************************************************
      fam_ant  :=   qryConsolidadoFAMILIA.AsString;
      excel.cells[linha,1]  :=   qryConsolidadoFAMILIA.AsString;
      while not qryConsolidado.Eof do
        begin
          if fam_ant  =   qryConsolidadoFAMILIA.AsString then
            begin
              //excel.cells[linha,1]  :=   qryConsolidadoFAMILIA.AsString;
            if qryConsolidadoDS_MOTIVO.AsString = 'AUSENTE' then
            begin
              excel.cells[linha, 2] := qryConsolidadoQTD.AsString;
              sum_ausente := sum_ausente + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'CEP ERRADO' then
            begin
              excel.cells[linha, 3] := qryConsolidadoQTD.AsString;
              sum_cep_errado := sum_cep_errado + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'CEP GENÉRICO' then
            begin
              excel.cells[linha, 4] := qryConsolidadoQTD.AsString;
              sum_cep_generico := sum_cep_generico + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'CEP ZERADO' then
            begin
              excel.cells[linha, 5] := qryConsolidadoQTD.AsString;
              sum_cep_zerado := sum_cep_zerado + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'DESCONHECIDO' then
            begin
              excel.cells[linha, 6] := qryConsolidadoQTD.AsString;
              sum_desconhecido := sum_desconhecido + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'ENDERECO INSUFICIENTE' then
            begin
              excel.cells[linha, 7] := qryConsolidadoQTD.AsString;
              sum_end_insuf := sum_end_insuf + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'FALECIDO' then
            begin
              excel.cells[linha, 8] := qryConsolidadoQTD.AsString;
              sum_falecido := sum_falecido + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'INFO ESCRITA PELO PORTEIRO' then
            begin
              excel.cells[linha, 9] := qryConsolidadoQTD.AsString;
              sum_info := sum_info + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'MUDOU-SE' then
            begin
              excel.cells[linha, 10] := qryConsolidadoQTD.AsString;
              sum_mudou := sum_mudou + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'NÃO EXISTE O NÚMERO INDICADO' then
            begin
              excel.cells[linha, 11] := qryConsolidadoQTD.AsString;
              sum_nao_existe := sum_nao_existe + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'NÃO PROCURADO' then
            begin
              excel.cells[linha, 12] := qryConsolidadoQTD.AsString;
              sum_nao_proc := sum_nao_proc + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'OUTROS' then
            begin
              excel.cells[linha, 13] := qryConsolidadoQTD.AsString;
              sum_outros := sum_outros + qryConsolidadoQTD.AsInteger;
            end;

            if qryConsolidadoDS_MOTIVO.AsString = 'RECUSADO' then
            begin
              excel.cells[linha, 14] := qryConsolidadoQTD.AsString;
              sum_recusado := sum_recusado + qryConsolidadoQTD.AsInteger;
            end;
//              Inc(linha,1);
              qryConsolidado.Next;
            end
          else
            begin
//              Inc( ZLINHA,1);
              Inc(linha,1);
              fam_ant               :=  qryConsolidadofamilia.AsString;
              excel.cells[linha,1]  :=   qryConsolidadoFAMILIA.AsString;
              //qryConsolidado.Prior;
            end;
        end;
      if qryConsolidadoDS_MOTIVO.AsString = 'AUSENTE' then
      begin
        excel.cells[linha, 2] := qryConsolidadoQTD.AsString;
        sum_ausente := sum_ausente + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'CEP ERRADO' then
      begin
        excel.cells[linha, 3] := qryConsolidadoQTD.AsString;
        sum_cep_errado := sum_cep_errado + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'CEP GENÉRICO' then
      begin
        excel.cells[linha, 4] := qryConsolidadoQTD.AsString;
        sum_cep_generico := sum_cep_generico + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'CEP ZERADO' then
      begin
        excel.cells[linha, 5] := qryConsolidadoQTD.AsString;
        sum_cep_zerado := sum_cep_zerado + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'DESCONHECIDO' then
      begin
        excel.cells[linha, 6] := qryConsolidadoQTD.AsString;
        sum_desconhecido := sum_desconhecido + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'ENDERECO INSUFICIENTE' then
      begin
        excel.cells[linha, 7] := qryConsolidadoQTD.AsString;
        sum_end_insuf := sum_end_insuf + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'FALECIDO' then
      begin
        excel.cells[linha, 8] := qryConsolidadoQTD.AsString;
        sum_falecido := sum_falecido + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'INFO ESCRITA PELO PORTEIRO' then
      begin
        excel.cells[linha, 9] := qryConsolidadoQTD.AsString;
        sum_info := sum_info + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'MUDOU-SE' then
      begin
        excel.cells[linha, 10] := qryConsolidadoQTD.AsString;
        sum_mudou := sum_mudou + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'NÃO EXISTE O NÚMERO INDICADO' then
      begin
        excel.cells[linha, 11] := qryConsolidadoQTD.AsString;
        sum_nao_existe := sum_nao_existe + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'NÃO PROCURADO' then
      begin
        excel.cells[linha, 12] := qryConsolidadoQTD.AsString;
        sum_nao_proc := sum_nao_proc + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'OUTROS' then
      begin
        excel.cells[linha, 13] := qryConsolidadoQTD.AsString;
        sum_outros := sum_outros + qryConsolidadoQTD.AsInteger;
      end;

      if qryConsolidadoDS_MOTIVO.AsString = 'RECUSADO' then
      begin
        excel.cells[linha, 14] := qryConsolidadoQTD.AsString;
        sum_recusado := sum_recusado + qryConsolidadoQTD.AsInteger;
      end;
      Inc(linha,1);
      for k := 1 to 15 - 1 do
        begin
          sheet.cells[linha, k].font.bold := true;
          sheet.cells[linha, k].font.color := clblue;
        end;
      excel.cells[linha, 1] := 'Total';
      excel.cells[linha, 2] := sum_ausente;
      excel.cells[linha, 3] := sum_cep_errado;
      excel.cells[linha, 4] := sum_cep_generico;
      excel.cells[linha, 5] := sum_cep_zerado;
      excel.cells[linha, 6] := sum_desconhecido;
      excel.cells[linha, 7] := sum_end_insuf;
      excel.cells[linha, 8] := sum_falecido;
      excel.cells[linha, 9] := sum_info;
      excel.cells[linha, 10] := sum_mudou;
      excel.cells[linha, 11] := sum_nao_existe;
      excel.cells[linha, 12] := sum_nao_proc;
      excel.cells[linha, 13] := sum_outros;
      excel.cells[linha, 14] := sum_recusado;
      excel.cells[linha+1,1].font.color :=  clred;
      excel.cells[linha+1,1].font.bold  :=  True;
      excel.cells[linha+1,1]  :=  'Total Geral ==>';
      totger  :=  sum_ausente+sum_cep_errado+sum_cep_generico+sum_cep_zerado+sum_desconhecido+sum_end_insuf;
      totger  :=  totger+sum_falecido+sum_info+sum_mudou+sum_nao_existe+sum_nao_proc+sum_outros+sum_recusado;
      excel.cells[linha+1,2].font.color   := clred;
      excel.cells[linha+1,2].font.bold    :=  True;
      excel.cells[linha+1,2]  :=IntToStr(totger);
      qryConsolidado.Close;
      totger:=0;
      subtot:=0;
{courier}

      {qryDatasCour.Close;
//      qryDatasCour.ParamByName('DT_DEVOL').AsString := FormatDateTime('yyyy/mm/dd', StrToDate(sDataINI));
      qryDatasCour.ParamByName('DTINI').AsString := FormatDateTime('yyyy/mm/dd',StrToDate(sDataINI));
      qryDatasCour.ParamByName('DTFIM').AsString := FormatDateTime('yyyy/mm/dd',StrToDate(sDataFIM));

      qryDatasCour.Open;
      qryFamilia.Open;
      excel.Workbooks[1].Sheets.Add;
      excel.Workbooks[1].WorkSheets[1].Name := 'AR_COURRIER_' + sNomeArq;
      Sheet := Excel.Workbooks[1].WorkSheets['AR_COURRIER_' + sNomeArq];

      for linha := 0 to qryDatasCour.RecordCount - 1 do
      begin
        datas :=  copy(qryDatasCourdt_devolucao.AsString, 9, 2) + '/' + copy(qryDatasCourdt_devolucao.AsString, 6, 2) + '/' +copy(qryDatasCourdt_devolucao.AsString, 1, 4);
        datasql := StrToDateTime(datas);
        DecodeDate(datasql, ano, mes, dia);
        excel.columns.autofit;

        ano_ant := ano;
        mes_ant := mes;
        excel.cells[1, 1] := 'Data';
        excel.cells[2, 1] := 'Familia';
        sheet.cells[2, 1].font.bold := true;
        icount := 1;
        qryFamilia.First;
        datas2 := inttostr(dia) + '/' + inttostr(mes) + '/' + inttostr(ano);
        qryDevolARCou.Close;
        qryDevolARCou.SQL.Clear;
        datasql := trunc(strtodate(datas2));
        qryDevolARCou.SQL.Add('SELECT   SUM(QTD_DEVOL) AS QTDE, MOTIVO, DT_DEVOLUCAO, FAMILIA ');
        qryDevolARCou.SQL.Add('FROM( ');
        qryDevolARCou.SQL.Add('  SELECT  ');
        qryDevolARCou.SQL.Add('    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO, ');
        qryDevolARCou.SQL.Add('    D.CD_MOTIVO AS COD_MOT,	F.DT_DEVOLUCAO, CF.FAMILIA ');
        qryDevolARCou.SQL.Add('  FROM ');
        qryDevolARCou.SQL.Add('    IBI_CONTROLE_DEVOLUCOES_AR F ');
        qryDevolARCou.SQL.Add('    full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTIVO ');
        qryDevolARCou.SQL.Add('    full join IBI_CADASTRO_FAMILIA CF on CF.CODBIN = F.CODBIN ');
        qryDevolARCou.SQL.Add('  WHERE   (F.DT_DEVOLUCAO = '+ chr(39)+FormatDateTime('mm/dd/yyyy',datasql)+chr(39)+')'); //:DT_DEVOL
        qryDevolARCou.SQL.Add('  GROUP BY ');
        qryDevolARCou.SQL.Add('    F.DT_DEVOLUCAO, ');
        qryDevolARCou.SQL.Add('    F.CODBIN, ');
        qryDevolARCou.SQL.Add('    F.CD_MOTIVO, D.CD_MOTIVO,D.DS_MOTIVO, ');
        qryDevolARCou.SQL.Add('    CF.FAMILIA ');
        qryDevolARCou.SQL.Add(') TMP ');
        qryDevolARCou.SQL.Add('  GROUP BY ');
        qryDevolARCou.SQL.Add('  MOTIVO, ');
        qryDevolARCou.SQL.Add('  DT_DEVOLUCAO, ');
        qryDevolARCou.SQL.Add('  FAMILIA ');
        qryDevolARCou.SQL.Add('  ORDER BY DT_DEVOLUCAO,FAMILIA ');
//        qryDevolARCou.Params[0].AsDate := datasql;//trunc(strtodate(datas2));
//        InputBox('','',qryDevolARCou.SQL.Text);
        qryDevolARCou.Open;
        qryDevolARCou.First;

        for coluna := 1 to qryFamilia.RecordCount do
        begin
          valor := qryFamiliafamilia.AsString;

          if coluna = 1 then
          begin
            col := 3;
          end
          else
          begin
            col := coluna + 13 * icount;
            col := col - 10;
          end;

          excel.cells[col, 1] := valor;
          excel.cells[col, 2] := 'AUSENTE';
          sheet.cells[col, 2].font.color := clblue;
          excel.cells[col + 1, 2] := 'MUDOU-SE';
          excel.cells[col + 1, 2].font.color := clblue;
          excel.cells[col + 2, 2] := 'ENDERECO INSUFICIENTE';
          excel.cells[col + 2, 2].font.color := clblue;
          excel.cells[col + 3, 2] := 'NÃO EXISTE O NÚMERO INDICADO';
          excel.cells[col + 3, 2].font.color := clblue;
          excel.cells[col + 4, 2] := 'DESCONHECIDO';
          excel.cells[col + 4, 2].font.color := clblue;
          excel.cells[col + 5, 2] := 'RECUSADO';
          excel.cells[col + 5, 2].font.color := clblue;
          excel.cells[col + 6, 2] := 'NÃO PROCURADO';
          excel.cells[col + 6, 2].font.color := clblue;
          excel.cells[col + 7, 2] := 'FALECIDO';
          excel.cells[col + 7, 2].font.color := clblue;
          excel.cells[col + 8, 2] := 'INFO ESCRITA PELO PORTEIRO';
          excel.cells[col + 8, 2].font.color := clblue;
          excel.cells[col + 9, 2] := 'OUTROS';
          excel.cells[col + 9, 2].font.color := clblue;
          excel.cells[col + 10, 2] := 'CEP ZERADO';
          excel.cells[col + 10, 2].font.color := clblue;
          excel.cells[col + 11, 2] := 'CEP GENÉRICO';
          excel.cells[col + 11, 2].font.color := clblue;
          excel.cells[col + 12, 2] := 'CEP ERRADO';
          excel.cells[col + 12, 2].font.color := clblue;
          excel.cells[col + 13, 2] := 'Total';
          sheet.cells[col + 13, 2].font.color := clred;
          sheet.cells[col + 13, 2].font.bold := true;
          inc(icount);
          col_atual2 := col + 14;
          qryDevolARCou.Close;
          qryDevolARCou.Open;
          qryDevolARCou.First;

          while not qryDevolARCou.Eof do
          begin
            if valor = QryDevolARCouFAMILIA.AsString then
            begin

              if QryDevolARCouMOTIVO.AsString = 'AUSENTE' then
              begin
                excel.cells[col, col_atual] := qryDevolARCouQTDE.AsString;
                sheet.cells[col, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'MUDOU-SE' then
              begin
                excel.cells[col + 1, col_atual] := qryDevolARCouQTDE.AsString;
                sheet.cells[col + 1, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'ENDERECO INSUFICIENTE' then
              begin
                excel.cells[col + 2, col_atual] := qryDevolARCouQTDE.AsString;
                sheet.cells[col + 2, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'NÃO EXISTE O NÚMERO INDICADO' then
              begin
                excel.cells[col + 3, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 3, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'DESCONHECIDO' then
              begin
                excel.cells[col + 4, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 4, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'RECUSADO' then
              begin
                excel.cells[col + 5, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 5, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'NÃO PROCURADO' then
              begin
                excel.cells[col + 6, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 6, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'FALECIDO' then
              begin
                excel.cells[col + 7, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 7, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'INFO ESCRITA PELO PORTEIRO' then
              begin
                excel.cells[col + 8, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 8, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'OUTROS' then
              begin
                excel.cells[col + 9, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 9, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'CEP ZERADO' then
              begin
                excel.cells[col + 10, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 10, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'CEP GENERICO' then
              begin
                excel.cells[col + 11, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 11, col_atual].font.color := clgreen;
              end;

              if QryDevolARCouMOTIVO.AsString = 'CEP ERRADO' then
              begin
                excel.cells[col + 12, col_atual] := QryDevolARCouQTDE.AsString;
                sheet.cells[col + 12, col_atual].font.color := clgreen;
              end;
              subtot  :=  subtot+qryDevolARCouqtde.AsInteger;
            end;
            //totger  :=  totger+subtot;
            QryDevolARCou.Next;
          end;
          sheet.cells[col+13, col_atual].font.color := clred;
          sheet.cells[col+13, col_atual].Font.bold  :=  true;
          excel.cells[col+13, col_atual] := IntToStr(subtot);
          totdia  :=  totdia+subtot;
          subtot  :=  0;
          qryFamilia.Next;
        end;
//        subtot  :=  0;
        for coluna := 1 to qryDatasCour.FieldCount do
        begin
          coluna_anterior := coluna_anterior + 1;
          sheet.cells[col_atual2, 1].font.color         :=  clred;
          sheet.cells[col_atual2, 1].Font.bold          :=  True;
          sheet.cells[col_atual2, 1]                    :=  'Total do Dia ==>';
          sheet.cells[col_atual2, col_atual].font.color :=  clred;
          sheet.cells[col_atual2, col_atual].Font.bold  :=  True;
          excel.cells[col+14,col_atual]                 :=  IntToStr(totdia);
          totger  :=  totger+totdia;
          totdia  :=  0;
          valor := qryDatasCour.Fields[coluna - 1].AsString;
          excel.cells[coluna, coluna_anterior + 2] := valor;
//          totais := 0;
          col_atual := col_atual + 1;
        end;

        qryDatasCour.Next;
        excel.columns.AutoFit;
      end;
      excel.cells[col_atual2+1, 1]            := 'Total Geral ==>';
      sheet.cells[col_atual2+1, 1].font.color := clred;
      sheet.cells[col_atual2+1, 1].font.bold  :=  true;
      excel.cells[col_atual2+1, 2]            := IntToStr(totger);
      sheet.cells[col_atual2+1, 2].font.color := clred;
      sheet.cells[col_atual2+1, 2].font.bold  :=  true;
      totger  :=  0;
      subtot  :=  0;
      totdia  :=  0;}
{FATURA}
      coluna_anterior := 0;
      col_atual := 3;
      qryFamilia.close;

      qryDatasFAT.Close;
//      qryDatasFAT.ParamByName('DT_DEVOL').AsString := FormatDateTime('yyyy/mm/dd', StrToDate(sDataINI));
      qryDatasFAT.Params[0].AsString := FormatDateTime('yyyy/mm/dd',StrToDate(sDataINI));
      qryDatasFAT.Params[1].AsString := FormatDateTime('yyyy/mm/dd',StrToDate(sDataFIM));
//      InputBox('','',qryDevolFat.SQL.Text);
      qryDatasFAT.Open;
      qryFamilia.Open;
      excel.Workbooks[1].Sheets.Add;
      excel.Workbooks[1].WorkSheets[1].Name := 'FATURA';
      Sheet := Excel.Workbooks[1].WorkSheets['FATURA'];
//      excel.Workbooks[1].WorkSheets[1].Name := 'FATURA_' + sNomeArq;
//      Sheet := Excel.Workbooks[1].WorkSheets['FATURA_' + sNomeArq];

      for linha := 0 to qryDatasFAT.RecordCount - 1 do
      begin
//        datas := copy(qryDatasREMdt_devolucao.AsString,9,2)+'/'+copy(qryDatasREMdt_devolucao.AsString,6,2)+'/'+copy(qryDatasREMdt_devolucao.AsString,1,4);

        datas :=  copy(qryDatasFatdt_devolucao.AsString, 9, 2)
        + '/' + copy(qryDatasFatdt_devolucao.AsString, 6, 2)
         + '/'+copy(qryDatasFatdt_devolucao.AsString, 1, 4);
        datasql := StrToDateTime(datas);
        DecodeDate(datasql, ano, mes, dia);
        excel.columns.autofit;

        excel.cells[1, 1] := 'Data';
        sheet.cells[1, 1].font.bold := true;
        excel.cells[2, 1] := 'Familia';
        sheet.cells[2, 1].font.bold := true;
        excel.cells[2, 2] := 'Motivo';
        sheet.cells[2, 2].font.bold := true;
        icount := 1;
        qryFamilia.First;
        datas2 := inttostr(dia) + '/' + format('%2.2d',[mes]) + '/' + inttostr(ano);
        qryDevolFat.Close;
        qryDevolFat.SQL.Clear;
        qryDevolFat.SQL.Add('SELECT   SUM(QTD_DEVOL) AS QTDE, MOTIVO, DT_DEVOLUCAO, FAMILIA ');
        qryDevolFat.SQL.Add('FROM( ');
        qryDevolFat.SQL.Add('  SELECT  ');
        qryDevolFat.SQL.Add('    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO, ');
        qryDevolFat.SQL.Add('    D.CD_MOTIVO AS COD_MOT,	F.DT_DEVOLUCAO, CF.FAMILIA ');
        qryDevolFat.SQL.Add('  FROM ');
        qryDevolFat.SQL.Add('    CEA_CONTROLE_DEVOLUCOES F ');
        qryDevolFat.SQL.Add('    full join CEA_motivos_devolucoes D on D.CD_MOTIVO = F.CD_MOTIVO ');
        qryDevolFat.SQL.Add('    full join CEA_CADASTRO_FAMILIA CF on CF.CODBIN = F.CODBIN ');
//        qryDevolFat.SQL.Add('  WHERE   (F.DT_DEVOLUCAO = '+ chr(39)+FormatDateTime('mm/dd/yyyy',datasql)+chr(39)+')'); //:DT_DEVOL
        qryDevolFat.SQL.Add('  WHERE   (F.DT_DEVOLUCAO = :DT_DEVOL)');//''+ chr(39)+FormatDateTime('mm/dd/yyyy',datasql)+chr(39)+')'); //:DT_DEVOL
        qryDevolFat.SQL.Add('  GROUP BY ');
        qryDevolFat.SQL.Add('    F.DT_DEVOLUCAO, ');
        qryDevolFat.SQL.Add('    F.CODBIN, ');
        qryDevolFat.SQL.Add('    F.CD_MOTIVO, D.CD_MOTIVO,D.DS_MOTIVO, ');
        qryDevolFat.SQL.Add('    CF.FAMILIA ');
        qryDevolFat.SQL.Add(') TMP ');
        qryDevolFat.SQL.Add('  GROUP BY ');
        qryDevolFat.SQL.Add('  MOTIVO, ');
        qryDevolFat.SQL.Add('  DT_DEVOLUCAO, ');
        qryDevolFat.SQL.Add('  FAMILIA ');
        qryDevolFat.SQL.Add('  ORDER BY DT_DEVOLUCAO,FAMILIA ');
//        qryDevolFat.Params[0].AsDate := datasql;//trunc(strtodate(datas2));
//        InputBox('','',qryDevolFat.SQL.Text);
//        qryDevolFat.ParamByName('DT_DEVOL').AsString :=  '08/13/2012';//FormatDateTime('mm/dd/yyyy', StrToDate(datas));
        qryDevolFat.ParamByName('DT_DEVOL').AsString :=  FormatDateTime('mm/dd/yyyy', StrToDate(datas));
        qryDevolFat.Open;
        qryDevolFat.First;

        for coluna := 1 to qryFamilia.RecordCount do
        begin
          valor := qryFamiliafamilia.AsString;

          if coluna = 1 then
          begin
            col := 3;
          end
          else
          begin
            col := coluna + 13 * icount;
            col := col - 10;
          end;

          excel.cells[col, 1] := valor;
          excel.cells[col, 2] := 'AUSENTE';
          sheet.cells[col, 2].font.color := clblue;
          excel.cells[col + 1, 2] := 'MUDOU-SE';
          excel.cells[col + 1, 2].font.color := clblue;
          excel.cells[col + 2, 2] := 'ENDERECO INSUFICIENTE';
          excel.cells[col + 2, 2].font.color := clblue;
          excel.cells[col + 3, 2] := 'NÃO EXISTE O NÚMERO INDICADO';
          excel.cells[col + 3, 2].font.color := clblue;
          excel.cells[col + 4, 2] := 'DESCONHECIDO';
          excel.cells[col + 4, 2].font.color := clblue;
          excel.cells[col + 5, 2] := 'RECUSADO';
          excel.cells[col + 5, 2].font.color := clblue;
          excel.cells[col + 6, 2] := 'NÃO PROCURADO';
          excel.cells[col + 6, 2].font.color := clblue;
          excel.cells[col + 7, 2] := 'FALECIDO';
          excel.cells[col + 7, 2].font.color := clblue;
          excel.cells[col + 8, 2] := 'INFO ESCRITA PELO PORTEIRO';
          excel.cells[col + 8, 2].font.color := clblue;
          excel.cells[col + 9, 2] := 'OUTROS';
          excel.cells[col + 9, 2].font.color := clblue;
          excel.cells[col + 10, 2] := 'CEP ZERADO';
          excel.cells[col + 10, 2].font.color := clblue;
          excel.cells[col + 11, 2] := 'CEP GENÉRICO';
          excel.cells[col + 11, 2].font.color := clblue;
          excel.cells[col + 12, 2] := 'CEP ERRADO';
          excel.cells[col + 12, 2].font.color := clblue;
          excel.cells[col + 13, 2] := 'Total';
          sheet.cells[col + 13, 2].font.color := clred;
          sheet.cells[col + 13, 2].font.bold := true;
          inc(icount);
          col_atual2 := col + 14;
//          qryDevolFat.Close;
//          qryDevolFat.Open;
          qryDevolFat.First;

          while not qryDevolFat.Eof do
          begin
            if valor = qryDevolFatFAMILIA.AsString then
            begin
              if qryDevolFatMOTIVO.AsString = 'AUSENTE' then
              begin
                excel.cells[col, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'MUDOU-SE' then
              begin
                excel.cells[col + 1, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 1, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'ENDERECO INSUFICIENTE' then
              begin
                excel.cells[col + 2, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 2, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'NÃO EXISTE O NÚMERO INDICADO' then
              begin
                excel.cells[col + 3, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 3, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'DESCONHECIDO' then
              begin
                excel.cells[col + 4, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 4, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'RECUSADO' then
              begin
                excel.cells[col + 5, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 5, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'NÃO PROCURADO' then
              begin
                excel.cells[col + 6, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 6, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'FALECIDO' then
              begin
                excel.cells[col + 7, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 7, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'INFO ESCRITA PELO PORTEIRO' then
              begin
                excel.cells[col + 8, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 8, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'OUTROS' then
              begin
                excel.cells[col + 9, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 9, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'CEP ZERADO' then
              begin
                excel.cells[col + 10, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 10, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'CEP GENÉRICO' then
              begin
                excel.cells[col + 11, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 11, col_atual].font.color := clgreen;
              end;

              if qryDevolFatMOTIVO.AsString = 'CEP ERRADO' then
              begin
                excel.cells[col + 12, col_atual] := qryDevolFatQTDE.AsString;
                sheet.cells[col + 12, col_atual].font.color := clgreen;
              end;
              subtot  :=  subtot+qryDevolFatqtde.AsInteger;
            end;
            //totger  :=  totger+subtot;
            qryDevolFat.Next;
          end;
          sheet.cells[col+13, col_atual].font.color := clred;
          sheet.cells[col+13, col_atual].Font.bold  :=  true;
          excel.cells[col+13, col_atual] := IntToStr(subtot);
          totdia  :=  totdia+subtot;
          subtot  :=  0;
          qryFamilia.Next;
        end;
        subtot  :=  0;
        for coluna := 1 to qryDatasFAT.FieldCount do
        begin
          coluna_anterior := coluna_anterior + 1;
          sheet.cells[col_atual2, 1].font.color         :=  clred;
          sheet.cells[col_atual2, 1].Font.bold          :=  True;
          sheet.cells[col_atual2, 1]                    :=  'Total do Dia ==>';
          sheet.cells[col_atual2, col_atual].font.color :=  clred;
          sheet.cells[col_atual2, col_atual].Font.bold  :=  True;
          excel.cells[col+14,col_atual]                 :=  IntToStr(totdia);
          totger  :=  totger+totdia;
          totdia  :=  0;
          valor := qryDatasFAT.Fields[coluna - 1].AsString;
          excel.cells[coluna, coluna_anterior + 2] := valor;
//          totais := 0;
          col_atual := col_atual + 1;
        end;
        qryDatasFAT.Next;
        excel.columns.AutoFit;
      end;
      excel.cells[col_atual2+1, 1]            := 'Total Geral ==>';
      sheet.cells[col_atual2+1, 1].font.color := clred;
      sheet.cells[col_atual2+1, 1].font.bold  :=  true;
      excel.cells[col_atual2+1, 2]            := IntToStr(totger);
      sheet.cells[col_atual2+1, 2].font.color := clred;
      sheet.cells[col_atual2+1, 2].font.bold  :=  true;
      totger  :=  0;
      subtot  :=  0;
      totdia  :=  0;

{ RE-AR}
      coluna_anterior := 0;
      col_atual := 3;
      qryFamilia.close;

      qryDatasREM.Close;
      qryDatasREM.ParamByName('DTINI').AsString := FormatDateTime('yyyy/mm/dd',StrToDate(sDataINI));
      qryDatasREM.ParamByName('DTFIM').AsString := FormatDateTime('yyyy/mm/dd',StrToDate(sDataFIM));

      qryDatasREM.Open;
      qryFamilia.Open;
      excel.Workbooks[1].Sheets.Add;
      excel.Workbooks[1].WorkSheets[1].Name := 'AR_RE';
      Sheet := Excel.Workbooks[1].WorkSheets['AR_RE'];
//      excel.Workbooks[1].WorkSheets[1].Name := 'AR_RE_' + sNomeArq;
//      Sheet := Excel.Workbooks[1].WorkSheets['AR_RE_' + sNomeArq];

      for linha := 0 to qryDatasREM.RecordCount - 1 do
      begin
//        datas := FormatDateTime('dd/mm/yyyy',qryDatasREMdt_devolucao.AsDateTime);
        datas := copy(qryDatasREMdt_devolucao.AsString,9,2)+'/'+copy(qryDatasREMdt_devolucao.AsString,6,2)+'/'+copy(qryDatasREMdt_devolucao.AsString,1,4);
//        datasql := qryDatasREMdt_devolucao.AsDateTime;
        datasql := StrToDateTime(datas);
        DecodeDate(datasql, ano, mes, dia);
        excel.columns.autofit;
        excel.cells[1, 1] := 'Data';
        excel.cells[2, 1] := 'Familia';
        sheet.cells[2, 1].font.bold := true;
        excel.cells[2, 2] := 'Motivo';
        sheet.cells[2, 2].font.bold := true;
        icount := 1;
        qryFamilia.First;
        datas2 := inttostr(mes) + '/' +inttostr(dia) + '/' +  inttostr(ano);
        qryDevolARRem.Close;
        qryDevolARRem.SQL.Clear;
        qryDevolARRem.SQL.Add('SELECT  SUM(QTD_DEVOL) AS QTDE,  MOTIVO,  DT_DEVOLUCAO,  ');
        qryDevolARRem.SQL.Add('FAMILIA  FROM (  SELECT    COUNT(F.CODBIN) AS QTD_DEVOL, ');
        qryDevolARRem.SQL.Add('D.DS_MOTIVO AS MOTIVO,    D.CD_MOTIVO AS COD_MOT,F.DT_DEVOLUCAO, ');
        qryDevolARRem.SQL.Add('CF.FAMILIA  FROM    IBI_CONTROLE_DEVOLUCOES_AR F ');
        qryDevolARRem.SQL.Add('full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTIVO');
        qryDevolARRem.SQL.Add('full join IBI_CADASTRO_FAMILIA CF on CF.CODBIN = F.CODBIN');
        qryDevolARRem.SQL.Add('  WHERE   (F.DT_DEVOLUCAO = :DT_DEVOL)  GROUP BY    F.DT_DEVOLUCAO,');
        qryDevolARRem.SQL.Add('    F.CODBIN,    F.CD_MOTIVO,D.CD_MOTIVO,D.DS_MOTIVO,    CF.FAMILIA) TMP ');
        qryDevolARRem.SQL.Add('  GROUP BY  MOTIVO,  DT_DEVOLUCAO,  FAMILIA ORDER BY DT_DEVOLUCAO,FAMILIA');
        qryDevolARRem.ParamByName('DT_DEVOL').AsString := datas2;//trunc(strtodate(datas2));
//        qryDevolARRem.ParamByName('DT_DEVOL').AsString :=  FormatDateTime('mm/dd/yyyy', StrToDate(datas));

        qryDevolARRem.Open;
        qryDevolARRem.First;

        for coluna := 1 to qryFamilia.RecordCount do
        begin
          valor := qryFamiliafamilia.AsString;

          if coluna = 1 then
          begin
            col := 3;
          end
          else
          begin
            col := coluna + 13 * icount;
            col := col - 10;
          end;

          excel.cells[col, 1] := valor;
          excel.cells[col, 2] := 'AUSENTE';
          sheet.cells[col, 2].font.color := clblue;
          excel.cells[col + 1, 2] := 'MUDOU-SE';
          excel.cells[col + 1, 2].font.color := clblue;
          excel.cells[col + 2, 2] := 'ENDERECO INSUFICIENTE';
          excel.cells[col + 2, 2].font.color := clblue;
          excel.cells[col + 3, 2] := 'NÃO EXISTE O NÚMERO INDICADO';
          excel.cells[col + 3, 2].font.color := clblue;
          excel.cells[col + 4, 2] := 'DESCONHECIDO';
          excel.cells[col + 4, 2].font.color := clblue;
          excel.cells[col + 5, 2] := 'RECUSADO';
          excel.cells[col + 5, 2].font.color := clblue;
          excel.cells[col + 6, 2] := 'NÃO PROCURADO';
          excel.cells[col + 6, 2].font.color := clblue;
          excel.cells[col + 7, 2] := 'FALECIDO';
          excel.cells[col + 7, 2].font.color := clblue;
          excel.cells[col + 8, 2] := 'INFO ESCRITA PELO PORTEIRO';
          excel.cells[col + 8, 2].font.color := clblue;
          excel.cells[col + 9, 2] := 'OUTROS';
          excel.cells[col + 9, 2].font.color := clblue;
          excel.cells[col + 10, 2] := 'CEP ZERADO';
          excel.cells[col + 10, 2].font.color := clblue;
          excel.cells[col + 11, 2] := 'CEP GENÉRICO';
          excel.cells[col + 11, 2].font.color := clblue;
          excel.cells[col + 12, 2] := 'CEP ERRADO';
          excel.cells[col + 12, 2].font.color := clblue;
          excel.cells[col + 13, 2] := 'Total';
          sheet.cells[col + 13, 2].font.color := clred;
          sheet.cells[col + 13, 2].font.bold := true;
          inc(icount);
          col_atual2 := col + 14;
//          qryDevolARRem.Close;
//          qryDevolARRem.Open;
          qryDevolARRem.First;

          while not qryDevolARRem.Eof do
          begin
            if valor = qryDevolARRemFAMILIA.AsString then
            begin

              if qryDevolARRemMOTIVO.AsString = 'AUSENTE' then
              begin
                excel.cells[col, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'MUDOU-SE' then
              begin
                excel.cells[col + 1, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 1, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'ENDEREÇO INSUFICIENTE' then
              begin
                excel.cells[col + 2, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 2, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'NÃO EXISTE O NÚMERO INDICADO' then
              begin
                excel.cells[col + 3, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 3, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'DESCONHECIDO' then
              begin
                excel.cells[col + 4, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 4, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'RECUSADO' then
              begin
                excel.cells[col + 5, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 5, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'NÃO PROCURADO' then
              begin
                excel.cells[col + 6, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 6, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'FALECIDO' then
              begin
                excel.cells[col + 7, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 7, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'INFO ESCRITA PELO PORTEIRO' then
              begin
                excel.cells[col + 8, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 8, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'OUTROS' then
              begin
                excel.cells[col + 9, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 9, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'CEP ZERADO' then
              begin
                excel.cells[col + 10, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 10, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'CEP GENÉRICO' then
              begin
                excel.cells[col + 11, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 11, col_atual].font.color := clgreen;
              end;

              if qryDevolARRemMOTIVO.AsString = 'CEP ERRADO' then
              begin
                excel.cells[col + 12, col_atual] := qryDevolARRemQTDE.AsString;
                sheet.cells[col + 12, col_atual].font.color := clgreen;
              end;
              subtot  :=  subtot+qryDevolARRemqtde.AsInteger;
              qryDevolARRemqtde.Value;
            end;
            qryDevolARRem.Next;
          end;
          sheet.cells[col+13, col_atual].font.color := clred;
          sheet.cells[col+13, col_atual].Font.bold  :=  true;
          excel.cells[col+13, col_atual] := IntToStr(subtot);
          totdia  :=  totdia+subtot;
          subtot  :=  0;
          qryFamilia.Next;
        end;
  //      subtot  :=  0;

        for coluna := 1 to qryDatasREM.FieldCount do
        begin
          coluna_anterior := coluna_anterior + 1;
          sheet.cells[col_atual2, 1].font.color         :=  clred;
          sheet.cells[col_atual2, 1].Font.bold          :=  True;
          sheet.cells[col_atual2, 1]                    :=  'Total do Dia ==>';
          sheet.cells[col_atual2, col_atual].font.color :=  clred;
          sheet.cells[col_atual2, col_atual].Font.bold  :=  True;
          excel.cells[col+14,col_atual]                 :=  IntToStr(totdia);
          totger  :=  totger+totdia;
          totdia  :=  0;
          valor := qryDatasRem.Fields[coluna - 1].AsString;
          excel.cells[coluna, coluna_anterior + 2] := valor;
          col_atual := col_atual + 1;
        end;
        qryDatasREM.Next;
        excel.columns.AutoFit;
      end;
      sheet.cells[col_atual2+1,1].font.color := clred;
      sheet.cells[col_atual2+1, 1].font.bold  :=  true;
      excel.cells[col_atual2+1,1]           := 'Total Geral ==>';
      sheet.cells[col_atual2+1, 2].font.color := clred;
      sheet.cells[col_atual2+1, 2].font.bold  :=  true;
      excel.cells[col_atual2+1, 2]            := IntToStr(totger);
      totdia  :=  0;
{ TARJA-FAC}
      coluna_anterior := 0;
      col_atual := 3;
      qryFamilia.close;
      totger  :=  0;
      totdia  :=  0;
      subtot  :=  0;

      qryDatasFAC.Close;
      qryDatasFAC.ParamByName('DTINI').AsString := FormatDateTime('yyyy/mm/dd', StrToDate(sDataINI));
      qryDatasFAC.ParamByName('DTFIM').AsString := FormatDateTime('yyyy/mm/dd', StrToDate(sDataFIM));

      qryDatasFAC.Open;
      qryFamilia.Open;
      excel.Workbooks[1].Sheets.Add;
      excel.Workbooks[1].WorkSheets[1].Name := 'TARJA';
      Sheet := Excel.Workbooks[1].WorkSheets['TARJA'];
//      excel.Workbooks[1].WorkSheets[1].Name := 'TARJA_' + sNomeArq;
//      Sheet := Excel.Workbooks[1].WorkSheets['TARJA_' + sNomeArq];
      for linha := 0 to qryDatasFAC.RecordCount - 1 do
      begin
        datas := copy(qryDatasFACdt_devolucao.AsString, 6, 2) + '/' +copy(qryDatasFACdt_devolucao.AsString, 9, 2) + '/' +  copy(qryDatasFACdt_devolucao.AsString, 1, 4);
        datasql := StrToDateTime(datas);
        DecodeDate(datasql, ano, mes, dia);
        excel.columns.autofit;

        excel.cells[1, 1] := 'Data';
        excel.cells[2, 1] := 'Familia';
        sheet.cells[2, 1].font.bold := true;
        excel.cells[2, 2] := 'Motivo';
        sheet.cells[2, 2].font.bold := true;
        icount := 1;
        qryFamilia.First;
        datas2 :=  inttostr(ano)+ '/' +  inttostr(mes) + '/' + inttostr(dia);
        qryDevolFAC.Close;
        qryDevolFAC.SQL.Clear;
        qryDevolFAC.SQL.Add('SELECT  SUM(QTD_DEVOL) AS QTDE,  MOTIVO, DT_DEVOLUCAO,  FAMILIA  FROM(  SELECT ');
        qryDevolFAC.SQL.Add('COUNT(F.CODBIN) AS QTD_DEVOL,    D.DS_MOTIVO AS MOTIVO,    D.CD_MOTIVO AS COD_MOT,');
        qryDevolFAC.SQL.Add('    F.DT_DEVOLUCAO,    CF.FAMILIA  FROM    IBI_CONTROLE_DEVOLUCOES_FAC F    ');
        qryDevolFAC.SQL.Add('full join ibi_motivo_devolucoes D on D.CD_MOTIVO = F.CD_MOTIVO ');
        qryDevolFAC.SQL.Add('full join IBI_CADASTRO_FAMILIA CF on CF.CODBIN = F.CODBIN ');
        qryDevolFAC.SQL.Add('  WHERE (F.DT_DEVOLUCAO between :DTINI_FAC and :DTFIM_FAC) ');
        qryDevolFAC.SQL.Add('  GROUP BY    F.DT_DEVOLUCAO,    F.CODBIN,    F.CD_MOTIVO,D.DS_MOTIVO,D.CD_MOTIVO,');
        qryDevolFAC.SQL.Add('    CF.FAMILIA) TMP  GROUP BY MOTIVO,  DT_DEVOLUCAO,  FAMILIA ORDER BY DT_DEVOLUCAO,FAMILIA');
//--      qryConsolidado.ParamByName('DTINI_FAC').AsString :=  FormatDateTime('yyyymm',StrToDate(sDataINI));
//--      qryConsolidado.ParamByName('DTFIM_FAC').AsString :=  FormatDateTime('yyyyMm',StrToDate(sDataFIM));

        qryDevolFAC.ParamByName('DTINI_FAC').AsString :=  datas ;//FormatDateTime('yyyymm',StrToDate(sDataINI));
        qryDevolFAC.ParamByName('DTFIM_FAC').AsString :=  datas ;//FormatDateTime('yyyyMm',StrToDate(sDataFIM));
        qryDevolFAC.Open;
        qryDevolFAC.First;
//        if qryDevolFAC.RecordCount >0  then
//        InputBox('','', IntToStr(qryDevolFAC.RecordCount));
        for coluna := 1 to qryFamilia.RecordCount do
        begin
          valor := qryFamiliafamilia.AsString;

          if coluna = 1 then
          begin
            col := 3;
          end
          else
          begin
            col := coluna + 13 * icount;
            col := col - 10;
          end;

          excel.cells[col, 1] := valor;
          excel.cells[col, 2] := 'AUSENTE';
          sheet.cells[col, 2].font.color := clblue;
          excel.cells[col + 1, 2] := 'MUDOU-SE';
          excel.cells[col + 1, 2].font.color := clblue;
          excel.cells[col + 2, 2] := 'ENDERECO INSUFICIENTE';
          excel.cells[col + 2, 2].font.color := clblue;
          excel.cells[col + 3, 2] := 'NÃO EXISTE O NÚMERO INDICADO';
          excel.cells[col + 3, 2].font.color := clblue;
          excel.cells[col + 4, 2] := 'DESCONHECIDO';
          excel.cells[col + 4, 2].font.color := clblue;
          excel.cells[col + 5, 2] := 'RECUSADO';
          excel.cells[col + 5, 2].font.color := clblue;
          excel.cells[col + 6, 2] := 'NÃO PROCURADO';
          excel.cells[col + 6, 2].font.color := clblue;
          excel.cells[col + 7, 2] := 'FALECIDO';
          excel.cells[col + 7, 2].font.color := clblue;
          excel.cells[col + 8, 2] := 'INFO ESCRITA PELO PORTEIRO';
          excel.cells[col + 8, 2].font.color := clblue;
          excel.cells[col + 9, 2] := 'OUTROS';
          excel.cells[col + 9, 2].font.color := clblue;
          excel.cells[col + 10, 2] := 'CEP ZERADO';
          excel.cells[col + 10, 2].font.color := clblue;
          excel.cells[col + 11, 2] := 'CEP GENÉRICO';
          excel.cells[col + 11, 2].font.color := clblue;
          excel.cells[col + 12, 2] := 'CEP ERRADO';
          excel.cells[col + 12, 2].font.color := clblue;
          excel.cells[col + 13, 2] := 'Total';
          sheet.cells[col + 13, 2].font.color := clred;
          sheet.cells[col + 13, 2].font.bold := true;
          inc(icount);
          col_atual2 := col + 14;
          //qryDevolFAC.Close;
          //qryDevolFAC.Open;
          qryDevolFAC.First;

          while not qryDevolFAC.Eof do
          begin
            if valor = qryDevolFACFAMILIA.AsString then
            begin

              if qryDevolFACMOTIVO.AsString = 'AUSENTE' then
              begin
                excel.cells[col, 3] := qryDevolFACQTDE.AsString;
                sheet.cells[col, 3].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'MUDOU-SE' then
              begin
                excel.cells[col + 1, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 1, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'ENDEREÇO INSUFICIENTE' then
              begin
                excel.cells[col + 2, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 2, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'NÃO EXISTE O NÚMERO INDICADO' then
              begin
                excel.cells[col + 3, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 3, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'DESCONHECIDO' then
              begin
                excel.cells[col + 4, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 4, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'RECUSADO' then
              begin
                excel.cells[col + 5, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 5, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'NÃO PROCURADO' then
              begin
                excel.cells[col + 6, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 6, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'FALECIDO' then
              begin
                excel.cells[col + 7, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 7, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'INFO ESCRITA PELO PORTEIRO' then
              begin
                excel.cells[col + 8, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 8, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'OUTROS' then
              begin
                excel.cells[col + 9, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 9, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'CEP ZERADO' then
              begin
                excel.cells[col + 10, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 10, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'CEP GENÉRICO' then
              begin
                excel.cells[col + 11, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 11, col_atual].font.color := clgreen;
              end;

              if qryDevolFACMOTIVO.AsString = 'CEP ERRADO' then
              begin
                excel.cells[col + 12, col_atual] := qryDevolFACQTDE.AsString;
                sheet.cells[col + 12, col_atual].font.color := clgreen;
              end;
              subtot  :=  subtot+qryDevolFACQTDE.AsInteger;
            end;
            qryDevolFAC.Next;
          end;
          sheet.cells[col+13, col_atual].font.color := clred;
          sheet.cells[col+13, col_atual].Font.bold  :=  true;
          excel.cells[col+13, col_atual] := IntToStr(subtot);
          totdia  :=  totdia+subtot;
          subtot  :=  0;
          qryFamilia.Next;
        end;

        for coluna := 1 to qryDatasFAC.FieldCount do
        begin
          coluna_anterior := coluna_anterior + 1;
          sheet.cells[col_atual2, 1].font.color         :=  clred;
          sheet.cells[col_atual2, 1].font.Bold         :=  True;
          sheet.cells[col_atual2, 1]                    :=  'Total do Dia ==>';
          sheet.cells[col_atual2, col_atual].font.color :=  clred;
          sheet.cells[col_atual2, col_atual].Font.bold  :=  True;
          excel.cells[col+14,col_atual] :=  IntToStr(totdia);
          totger  :=  totger+totdia;
          totdia  :=  0;
          valor := qryDatasFAC.Fields[coluna - 1].AsString;
          excel.cells[coluna, coluna_anterior + 2] := valor;
          col_atual := col_atual + 1;
        end;
        qryDatasFAC.Next;
        excel.columns.AutoFit;
      end;
      sheet.cells[col_atual2+1,1].font.color  := clred;
      sheet.cells[col_atual2+1, 1].font.bold  :=  true;
      excel.cells[col_atual2+1,1]             := 'Total Geral ==>';
      sheet.cells[col_atual2+1, 2].font.color := clred;
      sheet.cells[col_atual2+1, 2].font.bold  :=  true;
      excel.cells[col_atual2+1, 2]            := IntToStr(totger);
      totdia  :=  0;

      excel.columns.AutoFit;
      EdArq.Text  :=  'F:\ibisis\RELATORIOS';
      if (not(DirectoryExists(EdArq.Text))) then
        MkDir(EdArq.Text);
// Original sNomeArq recebia mes e ano mmaaaa
      sNomeArq  :=  'Devolução por parceria';
      excel.WorkBooks[1].SaveAs(EdArq.Text+'\' + sNomeArq + '.XLS');
      EdArq.Text  :=  'F:\ibisis\RELATORIOS\'+ sNomeArq + '.XLS';
      excel.quit;

      pMSG.Caption := 'ARQUIVO EXCEL GERADO';
      pMSG.Font.Color := clRed;
      pmsg.Font.Height := 12;
      pMSG.Refresh;
      pMSG.Refresh;
    except on e:exception do
      begin
        Application.MessageBox(PChar(e.Message),'IBISIS',IDOK);
          pMSG.Caption := '';
          pMSG.Refresh;
      end;
    end;

  end;

  CheckListBox1.Clear;
  qryDatas.Close;
  qryDatas.Open;

  while not qryDatas.Eof do
  begin
    CheckListBox1.Items.Add(qryDatasmes.AsString+'/'+ qryDatasano.AsString);
    qryDatas.Next;
  end;

end;

function TfrmExcel.CalculaData(sData: string): string;
var
  dia, mes, ano: string;
begin

  mes := copy(sData, 1, 2);
  ano := copy(sData, 4, 4);

  if
    (mes = '01') or
    (mes = '03') or
    (mes = '05') or
    (mes = '07') or
    (mes = '08') or
    (mes = '10') or
    (mes = '12') then
  begin
    dia := '31';
  end;

  if
    (mes = '04') or
    (mes = '06') or
    (mes = '09') or
    (mes = '11') then
  begin
    dia := '30';
  end;

  if  (mes = '02') and (StrToInt(ano) mod 4 = 0) then
    dia := '28'
  else  if  (mes = '02') and (StrToInt(ano) mod 4 <> 0) then
    dia := '29';
  Result := dia + '/' + mes + '/' + ano;
end;

procedure TfrmExcel.btnSairClick(Sender: TObject);
begin
  close;
end;

end.

