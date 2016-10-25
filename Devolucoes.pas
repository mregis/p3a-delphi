//1.0.0.0  Versão legado
//2.0.0.1  inclusão da data de cadastro BD
unit Devolucoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, DBCtrls, ExtCtrls,
  Mask, Grids, DBGrids, ComCtrls, ZConnection,
  ZAbstractRODataset, ZDataset, ZAbstractDataset, ZAbstractTable;//, FileOs, BaseFc, ADODB;

type
  { Buffer de leitura }
  TRegDevolucao = packed record
    NR_CONTA: array[1..16] of Char;
    CD_PRODUTO: array[1..03] of Char;
    CD_MOTIVO: array[1..02] of Char;
    DT_DEVOLUCAO: array[1..08] of Char;
    CRLF: array[1..02] of Char;
  end;

  TDevolucoesFrm = class(TForm)
    Label1: TLabel;
    edCIF: TEdit;
    BtnCloseConsistencia: TBitBtn;
    ListBoxCIF: TListBox;
    BtnLimpaReprocesso: TBitBtn;
    dsMotivos: TDataSource;
    dsControle: TDataSource;
    Label2: TLabel;
    lcCD_MOTIVO: TDBLookupComboBox;
    lblDS_MOTIVO: TLabel;
    BtnRelatorio1: TBitBtn;
    lcCD_PRODUTO: TDBLookupComboBox;
    lblDS_PRODUTO: TLabel;
    dsProdutos: TDataSource;
    Bevel1: TBevel;
    Bevel2: TBevel;
    cbDT_INICIAL: TDateTimePicker;
    cbDT_FINAL: TDateTimePicker;
    Bevel3: TBevel;
    cbDT_DEVOLUCAO: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btRelMensal: TBitBtn;
    dsOrg: TDataSource;
    pmsg: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    btnProduto: TBitBtn;
    btnOrg: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    ADOConnection2: TZConnection;
    qraRelatorioTOT: TZReadOnlyQuery;
    qraRelatorioQtde: TZReadOnlyQuery;
    qraRetorno: TZReadOnlyQuery;
    qraMotivo: TZReadOnlyQuery;
    qraProduto: TZReadOnlyQuery;
    qAux: TZTable;
    qraOrg: TZQuery;
    qraControle: TZQuery;
    Edarq: TEdit;
    SqlAux: TZQuery;
    DtSAux: TDataSource;
    procedure cbDT_DEVOLUCAOEnter(Sender: TObject);
    procedure edCIFKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCloseConsistenciaClick(Sender: TObject);
    procedure BtnLimpaReprocessoClick(Sender: TObject);
    procedure lcCD_MOTIVOClick(Sender: TObject);
    procedure lcCD_MOTIVOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lcCD_MOTIVOKeyPress(Sender: TObject; var Key: Char);
    procedure lcCD_MOTIVOKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnRelatorio1Click(Sender: TObject);
    procedure lcCD_PRODUTOClick(Sender: TObject);
    procedure lcCD_PRODUTOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lcCD_PRODUTOKeyPress(Sender: TObject; var Key: Char);
    procedure lcCD_PRODUTOKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure MontaRetorno();
    procedure MontaRelatorio();
    procedure btRelMensalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnOrgClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    lin,S, cSQL, cArq,arqaus: string;
    cFieldName, cFieldValue: string;
    F,FA: TextFile;
    cBuf: TRegDevolucao;
    cPth: string;
    bCopia : boolean;
    bAusente: Boolean;
    sMensagem : String;
  public
    { Public declarations }
  end;

var
  DevolucoesFrm: TDevolucoesFrm;

implementation

uses Main, RelMensal, RelMotivos, Cadastro_Org_Bin, Cadastro_Org_Descricao, Cadastro_Produtos,
  CDDM, U_Func;

{$R *.DFM}

procedure TDevolucoesFrm.edCIFKeyPress(Sender: TObject; var Key: Char);
var
  cConta, sBin, cSql, sNumOrg: string;
  DataAtual: TDateTime;
begin
  // Salva as sequências
  if (Key = #13) then
  begin
    // Motivo da devolução
    if lblDS_MOTIVO.Caption = '' then
    begin
      MessageDlg('Motivo não selecionado!', mtError, [mbOK], 0);
      Abort;
    end;

    // Código do produto não selecionado
    if lblDS_PRODUTO.Caption = '' then
    begin
      MessageDlg('Produto não selecionado!', mtError, [mbOK], 0);
      Abort;
    end;

//    DataAtual := DataHoraSQL(qaux);
//    if (cbDT_DEVOLUCAO.Date) > Trunc(DataAtual + 1) then
//    begin
//      MessageDlg('Data de devolução maior que a atual!', mtInformation, [mbOK], 0);
//      Abort;
//    end;

    if (Length(edCIF.Text) <> 16) and (Length(edCIF.Text) <> 19) then
    begin
      MessageDlg('Número da Conta inválido! Tamanhos dif. de 16 ou 19 verifique!', mtError, [mbOK], 0);
//      Play
      edCIF.SetFocus;
      //pmsg.SetFocus;
      edCIF.Text := '';
      Abort;
    end
    else    if  (copy(edCIF.Text,1,16) =  '0000000000000000') or
                (copy(edCIF.Text,1,19) =  '0000000000000000000') then

//    (vernum(trim(edCIF.Text,1,l6) = '0000000000000000'<> 16) and (Length(edCIF.Text) <> 19) then
    begin
      edCIF.SetFocus;
      MessageDlg('Número da Conta inválido! Tamanhos dif. de 16 ou 19 verifique!', mtError, [mbOK], 0);
      edCIF.Text := '';
      Abort;
    end;
    if  (Length(trim(edCIF.Text))=16) and (copy(edCIF.Text,1,6) =  '000000') then
//    (vernum(trim(edCIF.Text,1,l6) = '0000000000000000'<> 16) and (Length(edCIF.Text) <> 19) then
    begin
      MessageDlg('Bin Inválido!', mtError, [mbOK], 0);
      edCIF.SetFocus;
      edCIF.Text := '';
      Abort;
    end;
    if  (Length(trim(edCIF.Text))=19) and (copy(edCIF.Text,4,6) =  '000000') then
//    (vernum(trim(edCIF.Text,1,l6) = '0000000000000000'<> 16) and (Length(edCIF.Text) <> 19) then
    begin
      MessageDlg('Bin Inválido!', mtError, [mbOK], 0);
      edCIF.SetFocus;
      edCIF.Text := '';
      Abort;
    end;

    if (vernum(trim(edCIF.Text)) = false) then
    begin
      MessageDlg('Número da Conta inválido! verifique!', mtError, [mbOK], 0);
      edCIF.SetFocus;
      edCIF.Text := '';
      Abort;
    end;


    if (Length(edCIF.Text) = 16) then
      cConta := edCIF.Text;

    if (Length(edCIF.Text) = 19) then
      cConta := Copy(edCIF.Text, 4, 16);

    //pega o numero do bin
    if (Length(edCIF.Text) = 16) then
      sBin := Copy(edCIF.Text, 1, 6);

    if (Length(edCIF.Text) = 19) then
      sBin := Copy(edCIF.Text, 4, 6);

//    with qraOrg as TADOQuery do
   { with qraOrg do
    begin
      Close;
      SQL.Clear;
      cSQL := '';
      cSQL := cSQL + 'SELECT NUM_ORG FROM CEA_ORG C ';
      cSQL := cSQL + 'WHERE ' + sBin + ' = C.BIN ';
      SQL.Add(cSQL);
      Open;
    end;

    sNumOrg := qraOrg.FieldByName('NUM_ORG').AsString;

    if Copy(sBin, 1, 1) = '0' then
      sNumOrg := '010'

    else if Copy(sBin, 1, 1) = '1' then
      sNumOrg := '010';}

    {if sNumOrg = '' then
    begin
      MessageDlg('Não existe ORG cadastrada para o cartão ' + edCIF.Text + ' !', mtError, [mbOK], 0);
      Abort;
    end;}

    // Procurar código da conta no arquivo de controle
    //qraControle.Close;
    //qraControle.ParamByName('NR_CONTA').AsString := cConta;
//    qraControle.Parameters.ParamByName('NR_CONTA').Value := cConta;
    //qraControle.Open;

    // Gravar dados para o relatório
//    with qraControle as TADOQuery do
    with qraControle do
    begin
     // solicitação feita pelo Hatsuo, se já existir a conta
     // inserir + um registro
     {
       if RecordCount = 0 then
            Append
       else
            Edit;
     }
{      Append;
      FieldByName('NR_CONTA').AsString := cConta;
      FieldByName('CD_PRODUTO').AsString := qraProduto.FieldByName('CD_PRODUTO').AsString;
      FieldByName('CD_MOTIVO').AsString := qraMotivo.FieldByName('CD_MOTIVO').AsString;
      FieldByName('DT_DEVOLUCAO').AsDateTime := cbDT_DEVOLUCAO.Date;
      FieldByName('NUM_ORG').AsString := sNumOrg;
      FieldByName('dt_cadastro').AsDateTime := DataAtual;
      Post;}
        SqlAux.Close;
        SqlAux.SQL.Clear;
        SqlAux.SQL.Add('insert into cea_controle_devolucoes (nro_conta,cd_produto,cd_motivo,codbin,codusu) values ');
        SqlAux.SQL.Add('('+chr(39)+cConta+chr(39)+','+chr(39)+lcCD_PRODUTO.KeyValue+chr(39)+','+chr(39)+lcCD_MOTIVO.KeyValue+chr(39)+','+chr(39)+copy(cConta,1,6)+chr(39)+','+IntToStr(DM.usuaces)+')');
        try
          SqlAux.ExecSQL;
        except on e:exception do
          begin
            Application.MessageBox(PChar(e.Message),'IBISIS',IDOK);
            edCIF.Clear;
            edcif.SetFocus();
            exit;
          end;
        end;
    end;

    // Adiciona no list box
    ListBoxCIF.Items.Add(EdCIF.Text);
    if ListBoxCIF.Items.Count = 30 then
      ListBoxCIF.Clear;
    // Restaura para a próxima leitura
    edCIF.SetFocus;
    edCIF.Text := '';
  end;
end;

procedure TDevolucoesFrm.BtnCloseConsistenciaClick(Sender: TObject);
begin
  Close;
end;

procedure TDevolucoesFrm.BtnLimpaReprocessoClick(Sender: TObject);
begin
  ListBoxCIF.Clear;
  EdCIF.SetFocus;
end;

procedure TDevolucoesFrm.lcCD_MOTIVOClick(Sender: TObject);
begin
  lblDS_MOTIVO.Caption := qraMotivo.FieldByName('DS_MOTIVO').AsString;
  edCIF.SetFocus;
end;

procedure TDevolucoesFrm.lcCD_MOTIVOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lcCD_MOTIVOClick(nil);
end;

procedure TDevolucoesFrm.lcCD_MOTIVOKeyPress(Sender: TObject;
  var Key: Char);
begin
  lcCD_MOTIVOClick(nil);
end;

procedure TDevolucoesFrm.lcCD_MOTIVOKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lcCD_MOTIVOClick(nil);
end;

procedure TDevolucoesFrm.FormShow(Sender: TObject);
begin
  // Abre as tabelas
  qraMotivo.Close;
  qraMotivo.Open;

  qraProduto.Close;
  qraProduto.Open;

  // Seta as datas
  cbDT_DEVOLUCAO.Date := Date;
  cbDT_INICIAL.Date := Date;
  cbDT_FINAL.Date := Date;

  // Reseta
  lblDS_MOTIVO.Caption := '';
  lblDS_PRODUTO.Caption := '';
  ListBoxCIF.Clear;

//  // Posiciona cursor
//  cbDT_DEVOLUCAO.SetFocus;

  // pega o path da aplicacao
//  cPth := 'ExtractFilePath(Application.ExeName);
  cPth := 'F:\ibisis\';

end;

procedure TDevolucoesFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //fecha as tabelas
  qraRetorno.Close;
  qraMotivo.Close;
  qraProduto.Close;
  qraControle.Close;
end;

procedure TDevolucoesFrm.BtnRelatorio1Click(Sender: TObject);
begin
  MontaRetorno();
  MontaRelatorio();
end;

procedure TDevolucoesFrm.MontaRetorno();
var     nPos,iObjetos: Integer;
begin
  bCopia := False;
  sMensagem := '';
  iObjetos := 0;
  //Procurar o intervalo de datas
//  with qraRetorno as TADOQuery do
  with qraRetorno do
  begin
    Close;
    SQL.Clear;
    cSQL := 'SELECT NRO_CONTA, CD_PRODUTO, CD_MOTIVO,DT_DEVOLUCAO FROM CEA_CONTROLE_DEVOLUCOES WHERE ';
    cSQL := cSQL + '(DT_DEVOLUCAO between ' + chr(39)+ FormatDateTime('yyyy/mm/dd',cbDT_INICIAL.Date)+chr(39);
    cSQL := cSQL + ' AND ';
    cSQL := cSQL + chr(39)+ FormatDateTime('yyyy/mm/dd',cbDT_FINAL.Date)+chr(39)+') ';
//    cSQL := cSQL + 'AND (D.CD_PRODUTO = P.CD_PRODUTO) ';
//    cSQL := cSQL + 'AND (D.CD_MOTIVO = M.CD_MOTIVO) ';
//    cSQL := cSQL + 'GROUP BY M.DS_MOTIVO, P.DS_PRODUTO ';
//    cSQL := cSQL + ',D.CD_PRODUTO ';
    cSQL := cSQL + 'ORDER BY DT_DEVOLUCAO, CD_PRODUTO, CD_MOTIVO ';
    SQL.Add(cSQL);
    Open;
  end;

  if qraRetorno.IsEmpty then
  begin
    Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    Abort;
    Exit;
  end;

  pMsg.Caption := 'Gerando arquivo. Aguarde!';
  pMsg.Refresh;

  try
    cArq    := dm.unidade + 'ibisis\RETORNO';
    if (not(DirectoryExists(cArq))) then
      MkDir(cArq);

    cArq      := cArq + '\ADDRESS2ACC.EXTRATO.IBI.';
    arqaus    := cArq + 'AUS.'+FormatDateTime('ddmmyyyy.',DM.dtatu)+ FormatDateTime('hhmmss', StrToTime(dm.hratu))+'.TMP';
    cArq      := cArq + FormatDateTime('ddmmyyyy.',DM.dtatu)+ FormatDateTime('hhmmss', StrToTime(dm.hratu))+'.TMP';
//    cArq := cArq + '_A_';
 //   cArq := cArq + FormatDateTime('ddmmyyyy',cbDT_FINAL.Date);
 //   cArq := cArq + '.TXT';
    Edarq.Text  :=  cArq;
    AssignFile(F, Edarq.Text);
    ReWrite(F);
    AssignFile(FA, arqaus);
    ReWrite(FA);

    while not qraRetorno.Eof do
    begin
      //S := '';
//      for nPos := 0 to (qraRetorno.FieldCount - 1) do
//      begin
        if  (qraRetorno.Fields[2].AsInteger=7)  then
//            ((qraRetorno.Fields[nPos].Va )then
          lin  := qraRetorno.Fields[0].AsString+qraRetorno.Fields[1].AsString+qraRetorno.Fields[2].AsString+ FormatDateTime('yyyymmdd',qraRetorno.Fields[3].AsDateTime)
        else
          S := qraRetorno.Fields[0].AsString+qraRetorno.Fields[1].AsString+qraRetorno.Fields[2].AsString+ FormatDateTime('yyyymmdd',qraRetorno.Fields[3].AsDateTime);
  //    end;

      if (Length(trim(S)) > 0) then
        WriteLn(F, S);
      if (Length(trim(lin)) > 0) then
        WriteLn(FA, lin);
      qraRetorno.Next;
      //inc(iObjetos);
    end;
  Application.MessageBox(PChar('Arquivo Gerado!'+chr(10)+Edarq.Text),'IBISIS',IDOK);
  except
    on Msg: Exception do
    begin
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
    end;
  end;
  CloseFile(F);
  CloseFile(FA);

  //if iObjetos > 0 then
   // bCopia:= CopyFile(pchar(cArq),pchar('\\192.168.11.10\CEA_ret\'+ExtractFileName(cArq)),false);

  //if not bCopia  then
  //begin
  //  sMensagem := 'Não foi possível copiar o(s) arquivo(s): ' + ExtractFileName(cArq);
  //  Application.MessageBox(pchar(sMensagem),'Aviso',MB_OK+MB_ICONERROR+MB_SYSTEMMODAL)
  //end;
end;

procedure TDevolucoesFrm.MontaRelatorio();
var
  nPos, nFieldSize,iObjetos: Integer;

begin
  bCopia := False;
  sMensagem := '';
//  with qraRelatorioQtde as TADOQuery do
  with qraRelatorioQtde do
  begin
    Close;
    SQL.Clear;

    cSQL := '';
    cSQL := cSQL + 'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE FROM CEA_CONTROLE_DEVOLUCOES CD, CEA_MOTIVOS_DEVOLUCOES MD ';
    cSQL := cSQL + 'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO ';
    cSQL := cSQL + ' AND ';
    cSQL := cSQL + '(CD.DT_DEVOLUCAO BETWEEN '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_INICIAL.Date)+chr(39) ;
//    cSQL := cSQL + DtSQL_Ini(cbDT_INICIAL.Date);
//    cSQL := cSQL + ' AND ';
    cSQL := cSQL + ' and '+chr(39) + FormatDateTime('yyyy/mm/dd',cbDT_FINAL.Date)+chr(39)+') ';
    cSQL := cSQL + 'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO ';
    cSQL := cSQL + 'ORDER BY CD.CD_MOTIVO';
//    inputbox('','',cSQL);

    SQL.Add(cSQL);
    Open;
  end;

//  with qraRelatorioTOT as TADOQuery do
  with qraRelatorioTOT do
  begin
    Close;
    SQL.Clear;
    cSQL := '';
    cSQL := cSQL + 'SELECT COUNT(*) AS TOTAL FROM CEA_CONTROLE_DEVOLUCOES ';
    cSQL := cSQL + 'WHERE (DT_DEVOLUCAO BETWEEN '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_INICIAL.Date)+chr(39);
//    cSQL := cSQL + DtSQL_Ini(cbDT_INICIAL.Date);
    cSQL := cSQL + ' AND '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_FINAL.Date)+chr(39)+') ';
//    cSQL := cSQL + DtSQL_Fim(cbDT_FINAL.Date)+;
    SQL.Add(cSQL);
    Open;
  end;

  if qraRelatorioQtde.IsEmpty then
  begin
    Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    Exit;
  end;

  try
    cArq := dm.unidade+ 'RELATORIOS\';;
//    cArq := cArq
    //cArq := cArq + FormatDateTime('YYYYMMDD', now)+ '\' ;

    if not DirectoryExists(cArq) then
       CreateDirectory(PAnsiChar(cArq),nil);

    cArq := cArq + 'CEA_REL_'+FormatDateTime('ddmmyyyy',cbDT_INICIAL.Date);
//    cArq := cArq + StrTran(DateToStr(cbDT_INICIAL.Date), '/', '_');
    cArq := cArq + '_A_';
//    cArq := cArq + StrTran(DateToStr(cbDT_FINAL.Date), '/', '_');
    cArq := cArq + 'CEA_REL_'+FormatDateTime('ddmmyyyy',cbDT_FINAL.Date);
    cArq := cArq + '.TXT';

    AssignFile(F, cArq);
    ReWrite(F);

    WriteLn(F, format('%61.61s%',[StringOfChar('-',60)]));
    WriteLn(F, '');
    WriteLn(F, format('%-51.51s%',[' ADDRESS SA -  C&A'])+format('%-10.10s%',['PAGINA: 01']));
    WriteLn(F, '');
    WriteLn(F, ' PROCESSAMENTO DE: ' + DateToStr(cbDT_INICIAL.Date) + ' A ' + DateToStr(cbDT_FINAL.Date));
    WriteLn(F, '');
    WriteLn(F, '                  RESUMO DO CONTROLE DE DEVOLUCOES');
    WriteLn(F, ' ____________________________________________________________');
    WriteLn(F, format('%-57.57s%',[' CODIGO DESCRICAO'])+format('%-04.04s%',['QTDE']));
    WriteLn(F, format('%7.7s%',['------'])+ StringOfChar('-',49)+format('%5.5s%',['----']));

    while not qraRelatorioQtde.Eof do
    begin
      S := ' ';
      for nPos := 0 to (qraRelatorioQtde.FieldCount - 1) do
      begin
        cFieldValue := qraRelatorioQtde.FieldByName(qraRelatorioQtde.Fields[nPos].FieldName).AsString;
        cFieldName := qraRelatorioQtde.Fields[nPos].FieldName;
        nFieldSize := qraRelatorioQtde.Fields[nPos].Size;

        if UpperCase(cFieldName) = 'CD_MOTIVO' then
          S := S + Format('%2.2d',[StrToInt(cFieldValue)]) + Format('%-5.5s%',[''])

        else if UpperCase(cFieldName) = 'DS_MOTIVO' then
        begin
//          S := S + cFieldValue;
          S := S + Format('%-49.49s%',[trim(cFieldValue) ]);
//          S := S + ' ';
        end

        else if UpperCase(cFieldName) = 'QTDE' then
        begin
//          S := S + Replicate(' ', (4 - Length(cFieldValue)));
          S := S +  Format('%4.4d',[StrToInt(cFieldValue)]);
        end;
      end;
      WriteLn(F, S);
      qraRelatorioQtde.Next;
    end;
    cFieldValue := qraRelatorioTOT.FieldByName(qraRelatorioTOT.Fields[0].FieldName).AsString;
    cFieldName  := qraRelatorioTOT.Fields[0].FieldName;
    S := StringOfChar(' ', (4 - Length(cFieldValue)));
    S := S + cFieldValue;
    WriteLn(F, format('%7.7s%',['------'])+ StringOfChar('-',49)+format('%5.5s%',['----']));
    WriteLn(F, format('%11.11s%',['TOTAL --->'])+ format('%46.46s%',[''])+format('%4.4d',[StrToInt(S)]));

  except
    on Msg: Exception do
    begin
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
    end;
  end;
  CloseFile(F);

  if qraRelatorioQtde.RecordCount > 0 then
    //bCopia:= CopyFile(pchar(cArq),pchar('\\192.168.11.10\CEA_ret\'+ExtractFileName(cArq)),false);

  if not bCopia  then
  begin
    //sMensagem := 'Não foi possível copiar o(s) arquivo(s): ' + ExtractFileName(cArq);
    //Application.MessageBox(pchar(sMensagem),'Aviso',MB_OK+MB_ICONERROR+MB_SYSTEMMODAL)
  end;

  pMsg.Caption := 'Total de Objetos: ' + IntToStr(iObjetos);
  pMsg.Refresh;
end;

procedure TDevolucoesFrm.lcCD_PRODUTOClick(Sender: TObject);
begin
  lblDS_PRODUTO.Caption := qraProduto.FieldByName('DS_PRODUTO').AsString;
  edCIF.SetFocus;
end;

procedure TDevolucoesFrm.lcCD_PRODUTOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  lcCD_PRODUTOClick(nil);
end;

procedure TDevolucoesFrm.lcCD_PRODUTOKeyPress(Sender: TObject;
  var Key: Char);
begin
  lcCD_PRODUTOClick(nil);
end;

procedure TDevolucoesFrm.lcCD_PRODUTOKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lcCD_PRODUTOClick(nil);
end;

procedure TDevolucoesFrm.btRelMensalClick(Sender: TObject);
var
  F: TextFile;
  S, cSQL, cArq: string;
  nPos, nFieldSize: Integer;
  cFieldName, cFieldValue: string;

begin
  bcopia := False;
  sMensagem :='';

  cArq := cPth;
  cArq := cArq + 'RELATORIOS';

  if not DirectoryExists(cArq) then
     CreateDirectory(PAnsiChar(cArq),nil);
  cArq := cArq + '\PROC'+FormatDateTime('YYYYMMDD', now)+ '\' ;

  cArq := cArq + 'RELATORIO_MENSAL_PRODUTOS_';
//  cArq := cArq + StrTran(DateToStr(cbDT_INICIAL.Date), '/', '_');
  cArq := cArq + '_A_';
 // cArq := cArq + StrTran(DateToStr(cbDT_FINAL.Date), '/', '_');
  cArq := cArq + '.TXT';

  qrForm_RelMensal := TqrForm_RelMensal.Create(Self);
  try
    with qrForm_RelMensal.qraRelMensal do
    begin
      Close;
      SQL.Clear;
      cSQL := '';
{          cSQL := cSQL + 'SELECT  M.DS_MOTIVO, C.DESCRICAO, C.NUM_ORG, count(C.Descricao)  as TOTAL ';
          cSQL := cSQL + 'FROM CEA_CONTROLE_DEVOLUCOES D, CEA_ORG_DESCRICAO C, CEA_MOTIVOS_DEVOLUCOES M ';
          cSQL := cSQL + 'WHERE ';
          cSQL := cSQL + '(D.DT_DEVOLUCAO BETWEEN ';
//          cSQL := cSQL + DtSQL_Ini( cbDT_INICIAL.Date );
          cSQL := cSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', cbDT_INICIAL.Date) + ' 00:00.000 ' ) ;
          cSQL := cSQL + ' AND ';
  //        cSQL := cSQL + DtSQL_Fim( cbDT_FINAL.Date   );
          cSQL := cSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', cbDT_FINAL.Date +1 ) + ' 00:00:00.000 )' );
          cSQL := cSQL + ' AND ';
          cSQL := cSQL + '(D.NUM_ORG = C.NUM_ORG)';
          cSQL := cSQL + ' AND ';
          cSQL := cSQL + '(D.CD_MOTIVO = M.CD_MOTIVO) ';
          cSQL := cSQL + 'GROUP BY M.DS_MOTIVO, C.DESCRICAO, C.NUM_ORG ';
          cSQL := cSQL + 'ORDER BY C.DESCRICAO, M.DS_MOTIVO, C.NUM_ORG';}

      cSQL := cSQL + 'SELECT M.DS_MOTIVO, D.CD_PRODUTO, P.DS_PRODUTO, count(D.CD_PRODUTO)  as Total ';
      cSQL := cSQL + 'FROM CEA_CONTROLE_DEVOLUCOES D, CEA_MOTIVOS_DEVOLUCOES M, CEA_PRODUTOS P ';
      cSQL := cSQL + 'WHERE ';
      cSQL := cSQL + '(d.dt_devolucao BETWEEN '+QuotedStr(FormatDateTime('yyyy/mm/dd', cbDT_INICIAL.Date)) ;
//      cSQL := cSQL + DtSQL_Ini(cbDT_INICIAL.Date);
      cSQL := cSQL + ' AND ';
      cSQL := cSQL +QuotedStr(FormatDateTime('yyyy/mm/dd',cbDT_FINAL.Date))+') ';
      //      cSQL := cSQL + 'd.dt_devolucao <= ';
//      cSQL := cSQL + DtSQL_Fim(cbDT_FINAL.Date);
      cSQL := cSQL + ' AND (D.CD_PRODUTO = P.CD_PRODUTO) ';
      cSQL := cSQL + ' AND (D.CD_MOTIVO = M.CD_MOTIVO) ';
      cSQL := cSQL + 'GROUP BY M.DS_MOTIVO, D.CD_PRODUTO, P.DS_PRODUTO ';
      cSQL := cSQL + 'ORDER BY D.CD_PRODUTO, P.DS_PRODUTO, M.DS_MOTIVO ';
      //inputbox('','',csql);
      SQL.Add(cSQL);
      Open;
    end;

    if qrForm_RelMensal.qraRelMensal.IsEmpty then
    begin
      Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      Exit;
    end;

    pMsg.Caption := 'Gerando arquivo. Aguarde!';
    pMsg.Refresh;
    Application.CreateForm(TqrForm_RelMensal,qrForm_RelMensal);
//    qrForm_RelMensal.RLPeriodo.Caption := DateToStr(cbDT_INICIAL.Date) + ' A ' + DateToStr(cbDT_FINAL.Date);
    qrForm_RelMensal.RLRelMensal.PreviewModal ;//.ex ExportToFilter (TQRAsciiExportFilter.create(cArq));
    qrForm_RelMensal.RLRelMensal.Destroy;

    //if qrForm_RelMensal.qraRelMensal.IsEmpty then
    //  bCopia:= CopyFile(pchar(cArq),pchar('\\192.168.100.4\ibisis\CEA_RETORNO\'+ExtractFileName(cArq)),false);

    //if not bCopia  then
    //begin
//      sMensagem := 'Não foi possível copiar o(s) arquivo(s): ' + bCopia;
      //Application.MessageBox(pchar(sMensagem),'Aviso',MB_OK+MB_ICONERROR+MB_SYSTEMMODAL)
    //end;

  finally
    qrForm_RelMensal.Free;
  end;

  bcopia := False;
  sMensagem :='';

  cArq := cPth;
  cArq := cArq + 'RELATORIOS\';
//  cArq := cArq + 'ADDRESS2ACC.FATURA.'+FormatDateTime('YYYYMMDD', now)+ '.TXT' ;

  if not DirectoryExists(cArq) then
     CreateDirectory(PAnsiChar(cArq),nil);
  cArq := cArq + 'RELATORIO_MENSAL_MOTIVOS_';
  cArq := cArq + FormatDateTime('dd-mm-yyyy', cbDT_INICIAL.Date);
  cArq := cArq + '_A_';
  cArq := cArq + FormatDateTime('dd-mm-yyyy',cbDT_FINAL.Date);
  cArq := cArq + '.TXT';

  qrForm_RelMotivos := TqrForm_RelMotivos.Create(Self);
  try
    with qrForm_RelMotivos.qraMotivosTot do
    begin
      Close;
      SQL.Clear;
      cSQL := '';
      cSQL := cSQL + 'SELECT D.CD_MOTIVO, M.DS_MOTIVO, count(D.CD_MOTIVO)  as Total ';
      cSQL := cSQL + 'FROM CEA_CONTROLE_DEVOLUCOES D, CEA_MOTIVOS_DEVOLUCOES M ';
      cSQL := cSQL + 'WHERE ';
      cSQL := cSQL + '(d.dt_devolucao between '+QuotedStr(FormatDateTime('yyyy/mm/dd', cbDT_INICIAL.Date));
      cSQL := cSQL + ' AND '+QuotedStr(FormatDateTime('yyyy/mm/dd',cbDT_FINAL.Date));
//      cSQL := cSQL + 'd.dt_devolucao <= ';
//      cSQL := cSQL + DtSQL_Fim(cbDT_FINAL.Date);
      cSQL := cSQL + ') AND (D.CD_MOTIVO = M.CD_MOTIVO) ';
      cSQL := cSQL + 'GROUP BY D.CD_MOTIVO, M.DS_MOTIVO ';
      cSQL := cSQL + 'ORDER BY M.DS_MOTIVO ';
      cSQL := cSQL + '';
      SQL.Add(cSQL);
      Open;
    end;
    qrForm_RelMotivos.qlPeriodo.Caption := DateToStr(cbDT_INICIAL.Date) + ' A ' + DateToStr(cbDT_FINAL.Date);
//    qrForm_RelMotivos.ExportToFilter(TQRAsciiExportFilter.create(cArq));
    qrForm_RelMotivos.qraMotivosTot.Close;

//    if qrForm_RelMotivos.qraMotivos .RecordCount > 0 then
//      bCopia:= CopyFile(pchar(cArq),pchar('\\192.168.11.10\CEA_ret\'+ExtractFileName(cArq)),false);

    {if not bCopia  then
    begin
      sMensagem := 'Não foi possível copiar o(s) arquivo(s): ' + ExtractFileName(cArq);
      Application.MessageBox(pchar(sMensagem),'Aviso',MB_OK+MB_ICONERROR+MB_SYSTEMMODAL)
    end;}


    pMsg.Caption := 'Final da Geração';
    pMsg.Refresh;
  finally
    qrForm_RelMotivos.Free;
  end;
end;

procedure TDevolucoesFrm.cbDT_DEVOLUCAOEnter(Sender: TObject);
begin
  SqlAux.Connection  :=  ADOConnection2;
  SqlAux.Close;
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add('select current_date');
  SqlAux.Open;
  cbDT_DEVOLUCAO.DateTime :=  SqlAux.Fields[0].AsDateTime;

end;

procedure TDevolucoesFrm.FormCreate(Sender: TObject);
var
  FileName: string;
begin
//  ConectaSQL(ADOConnection2, 'Devolucao');
    ADOConnection2.Connected  :=  true;
end;

procedure TDevolucoesFrm.btnProdutoClick(Sender: TObject);
begin
  ProdutosFrm := TProdutosFrm.Create(self);
  ProdutosFrm.ShowModal;
  ProdutosFrm.Free;
end;

procedure TDevolucoesFrm.BitBtn2Click(Sender: TObject);
begin
  OrgDescricaoFrm := TOrgDescricaoFrm.Create(self);
  OrgDescricaoFrm.ShowModal;
  OrgDescricaoFrm.Free;
end;

procedure TDevolucoesFrm.btnOrgClick(Sender: TObject);
begin
  OrgBinFrm := TOrgBinFrm.Create(Self);
  OrgBinFrm.ShowModal;
  OrgBinFrm.Free;
end;

procedure TDevolucoesFrm.BitBtn1Click(Sender: TObject);
var
  Arq: TextFile;
  S, cSQL, cArq: string;
  nPos: Integer;
begin
  bCopia := False;
  sMensagem := '';
//  with qraRetorno as TADOQuery do

  with qraRetorno do
  begin
    Close;
    SQL.Clear;
    cSQL := 'SELECT * FROM CEA_CONTROLE_DEVOLUCOES WHERE ';
    cSQL := cSQL + '(DT_DEVOLUCAO between ' + chr(39)+ FormatDateTime('yyyy/mm/dd',cbDT_INICIAL.Date)+chr(39)+ ' AND ';
    cSQL := cSQL + chr(39)+ FormatDateTime('yyyy/mm/dd',cbDT_FINAL.Date)+chr(39)+') ';
    cSQL := cSQL + 'ORDER BY DT_CADASTRO';
    SQL.Add(cSQL);
    Open;
  end;

  if qraRetorno.IsEmpty then
  begin
    Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    Abort;
    Exit;
  end;

  pMsg.Caption := 'Gerando arquivo. Aguarde!';
  pMsg.Refresh;

  try
    cArq := cPth;
    cArq := cPth;
    cArq := cArq + 'retorno';
    if (not(DirectoryExists(cArq))) then
      MkDir(cArq);
    cArq := cArq + '\PROC';
    cArq := cArq + FormatDateTime('ddmmyyyy', now)+ '\' ;

    if not DirectoryExists(cArq) then
       CreateDirectory(PAnsiChar(cArq),nil);

    cArq := cArq + 'CEA_DIF_';
    cArq := cArq + FormatDateTime('ddmmyyyy',cbDT_INICIAL.Date);
    cArq := cArq + '_A_';
    cArq := cArq + FormatDateTime('ddmmyyyy',cbDT_FINAL.Date);
    cArq := cArq + '.TXT';
    AssignFile(Arq, cArq);
    ReWrite(Arq);

    while not qraRetorno.Eof do
    begin
      S := '';
      for nPos := 0 to (qraRetorno.FieldCount - 1) do
      begin
          S := S  + qraRetorno.FieldByName(qraRetorno.Fields[nPos].FieldName).AsString + ';';
      end;

      WriteLn(Arq, S);
      qraRetorno.Next;
    end;

  pMsg.Caption := 'Processamento concluído!';
  pMsg.Refresh;

  except
    on Msg: Exception do
    begin
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
    end;
  end;
  CloseFile(Arq);

//  if qraRetorno.RecordCount > 0 then
 //   bCopia:= CopyFile(pchar(cArq),pchar('\\192.168.11.10\CEA_ret\'+ExtractFileName(cArq)),false);

//  if not bCopia  then
//  begin
//    sMensagem := 'Não foi possível copiar o(s) arquivo(s): ' + ExtractFileName(cArq);
//    Application.MessageBox(pchar(sMensagem),'Aviso',MB_OK+MB_ICONERROR+MB_SYSTEMMODAL)
//  end;

end;

end.

