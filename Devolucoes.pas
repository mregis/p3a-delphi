//1.0.0.0  Versão legado
//2.0.0.1  inclusão da data de cadastro BD
unit Devolucoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, DBCtrls, ExtCtrls,
  Mask, Grids, DBGrids, ComCtrls, ZConnection,
  ZAbstractRODataset, ZDataset, ZAbstractDataset, ZAbstractTable,
  ZAbstractConnection;

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
    Label2: TLabel;
    lcCD_MOTIVO: TDBLookupComboBox;
    lblDS_MOTIVO: TLabel;
    BtnRelatorio1: TBitBtn;
    lcCD_PRODUTO: TDBLookupComboBox;
    lblDS_PRODUTO: TLabel;
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
    pmsg: TPanel;
    Label7: TLabel;
    btnProduto: TBitBtn;
    btnOrg: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Edarq: TEdit;
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
    procedure btnProdutoClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnOrgClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    lin,S, cSQL, cArq,arqaus: string;
    cFieldName, cFieldValue: string;
    F,FA: TextFile;
    cPth: string;
    bCopia : boolean;
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
  cConta, sBin : string;
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

    With DM do
      begin
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
    end;

    // Adiciona no list box
    ListBoxCIF.Items.Add(EdCIF.Text);
    if ListBoxCIF.Items.Count = 30 then
      ListBoxCIF.Clear;
    // Restaura para a próxima leitura
    edCIF.SetFocus;
    edCIF.Text := '';
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
  lblDS_MOTIVO.Caption := DM.qraMotivo.FieldByName('DS_MOTIVO').AsString;
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
  With DM do
    begin
      qraMotivo.Close;
      qraMotivo.Open;
      qraProduto.Close;
      qraProduto.Open;
    end;
  // Seta as datas
  cbDT_DEVOLUCAO.Date := Date;
  cbDT_INICIAL.Date := Date;
  cbDT_FINAL.Date := Date;

  // Reseta
  lblDS_MOTIVO.Caption := '';
  lblDS_PRODUTO.Caption := '';
  ListBoxCIF.Clear;

  cPth := DM.currdir;

end;

procedure TDevolucoesFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  With DM do
    begin
      //fecha as tabelas
      qraRetorno.Close;
      qraMotivo.Close;
      qraProduto.Close;
      qraControle.Close;
    end;
end;

procedure TDevolucoesFrm.BtnRelatorio1Click(Sender: TObject);
begin
  MontaRetorno();
  MontaRelatorio();
end;

procedure TDevolucoesFrm.MontaRetorno();
begin
  bCopia := False;
  sMensagem := '';
  //Procurar o intervalo de datas
//  with qraRetorno as TADOQuery do
  with DM.qraRetorno do
    begin
      Close;
      SQL.Clear;
      cSQL := 'SELECT NRO_CONTA, CD_PRODUTO, CD_MOTIVO,DT_DEVOLUCAO FROM CEA_CONTROLE_DEVOLUCOES WHERE ';
      cSQL := cSQL + 'DT_DEVOLUCAO between :dti AND :dtf ';
      cSQL := cSQL + 'ORDER BY DT_DEVOLUCAO, CD_PRODUTO, CD_MOTIVO ';
      SQL.Add(cSQL);
      ParamByName('dti').AsDate := cbDT_INICIAL.Date;
      ParamByName('dtf').AsDate := cbDT_FINAL.Date;
      Open;
  end;

  if DM.qraRetorno.IsEmpty then
  begin
    Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    Abort;
    Exit;
  end;

  pMsg.Caption := 'Gerando arquivo. Aguarde!';
  pMsg.Refresh;

  try
    cArq := dm.retdir;

    cArq      := cArq + 'ADDRESS2ACC.EXTRATO.IBI.';
    arqaus    := cArq + 'AUS.' + FormatDateTime('ddmmyyyy.hhmmss', DM.dtatu) + '.TMP';
    cArq      := cArq + FormatDateTime('ddmmyyyy.hhmmss', DM.dtatu) + '.TMP';

    Edarq.Text  :=  cArq;
    AssignFile(F, Edarq.Text);
    ReWrite(F);
    AssignFile(FA, arqaus);
    ReWrite(FA);

    With DM do
      begin
        while not qraRetorno.Eof do
          begin
            if  (qraRetorno.Fields[2].AsInteger=7)  then
              lin := qraRetorno.Fields[0].AsString +
                  qraRetorno.Fields[1].AsString +
                  qraRetorno.Fields[2].AsString +
                  FormatDateTime('yyyymmdd',qraRetorno.Fields[3].AsDateTime)
            else
              S := qraRetorno.Fields[0].AsString+qraRetorno.Fields[1].AsString+qraRetorno.Fields[2].AsString+ FormatDateTime('yyyymmdd',qraRetorno.Fields[3].AsDateTime);

            if (Length(trim(S)) > 0) then
              WriteLn(F, S);

            if (Length(trim(lin)) > 0) then
              WriteLn(FA, lin);

            qraRetorno.Next;
          end;
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
end;

procedure TDevolucoesFrm.MontaRelatorio();
var
  nPos : Integer;

begin
  bCopia := False;
  sMensagem := '';
//  with qraRelatorioQtde as TADOQuery do
  with DM.qraRelatorioQtde do
  begin
    Close;
    SQL.Clear;

    cSQL := '';
    cSQL := cSQL + 'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE FROM CEA_CONTROLE_DEVOLUCOES CD, CEA_MOTIVOS_DEVOLUCOES MD ';
    cSQL := cSQL + 'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO ';
    cSQL := cSQL + ' AND CD.DT_DEVOLUCAO BETWEEN :dti AND :dtf ';
    cSQL := cSQL + 'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO ';
    cSQL := cSQL + 'ORDER BY CD.CD_MOTIVO';
    SQL.Add(cSQL);
    ParamByName('dti').AsDate := cbDT_INICIAL.Date;
    ParamByName('dtf').AsDate := cbDT_FINAL.Date;
    Open;
  end;

//  with qraRelatorioTOT as TADOQuery do
  with DM.qraRelatorioTOT do
  begin
    Close;
    SQL.Clear;
    cSQL := '';
    cSQL := cSQL + 'SELECT COUNT(*) AS TOTAL FROM CEA_CONTROLE_DEVOLUCOES ';
    cSQL := cSQL + 'WHERE DT_DEVOLUCAO BETWEEN :dti AND :dtf ';
    SQL.Add(cSQL);
    ParamByName('dti').AsDate := cbDT_INICIAL.Date;
    ParamByName('dtf').AsDate := cbDT_FINAL.Date;
    Open;
  end;

  if DM.qraRelatorioQtde.IsEmpty then
  begin
    Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    Exit;
  end;

  try
    cArq := DM.relatdir;
    if not DirectoryExists(cArq) then
       CreateDirectory(PAnsiChar(cArq),nil);

    cArq := cArq + 'CEA_REL_'+FormatDateTime('ddmmyyyy',cbDT_INICIAL.Date);
    cArq := cArq + '_A_';
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

    With DM do
      begin
        while not qraRelatorioQtde.Eof do
          begin
            S := ' ';
            for nPos := 0 to (qraRelatorioQtde.FieldCount - 1) do
              begin
                cFieldValue := qraRelatorioQtde.FieldByName(qraRelatorioQtde.Fields[nPos].FieldName).AsString;
                cFieldName := qraRelatorioQtde.Fields[nPos].FieldName;

                if UpperCase(cFieldName) = 'CD_MOTIVO' then
                  S := S + Format('%2.2d',[StrToInt(cFieldValue)]) +
                      Format('%-5.5s%',[''])

                else if UpperCase(cFieldName) = 'DS_MOTIVO' then
                  begin
                    S := S + Format('%-49.49s%',[trim(cFieldValue) ]);
                  end

                else if UpperCase(cFieldName) = 'QTDE' then
                  begin
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
      end;
  except on Msg: Exception do
    begin
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
    end;
  end;
  CloseFile(F);
  pMsg.Caption := 'Total de Objetos: ' + cFieldValue;
  pMsg.Refresh;
end;

procedure TDevolucoesFrm.lcCD_PRODUTOClick(Sender: TObject);
begin
  lblDS_PRODUTO.Caption := DM.qraProduto.FieldByName('DS_PRODUTO').AsString;
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
  cSQL, cArq: string;

begin
  bcopia := False;
  sMensagem :='';
  cArq := DM.relatdir;


  cArq := cArq + 'PROC' + FormatDateTime('YYYYMMDD', now) + '\' ;
  cArq := cArq + 'RELATORIO_MENSAL_PRODUTOS_';
  cArq := cArq + '_A_';
  cArq := cArq + '.TXT';

  qrForm_RelMensal := TqrForm_RelMensal.Create(Self);
  try
    with DM.qraRelMensal do
    begin
      Close;
      SQL.Clear;

      cSQL := 'SELECT M.DS_MOTIVO, D.CD_PRODUTO, P.DS_PRODUTO, ' +
          'count(D.CD_PRODUTO) as Total ' + #13#10 +
          'FROM CEA_CONTROLE_DEVOLUCOES D ' + #13#10 +
          '    INNER JOIN CEA_MOTIVOS_DEVOLUCOES M ON (D.CD_MOTIVO = M.CD_MOTIVO) ' + #13#10 +
          '    INNER JOIN CEA_PRODUTOS P ON (D.CD_PRODUTO = P.CD_PRODUTO) ' + #13#10 +
          'WHERE D.dt_devolucao BETWEEN :dtini AND :dtfim ' + #13#10 +
          'GROUP BY M.DS_MOTIVO, D.CD_PRODUTO, P.DS_PRODUTO ' + #13#10 +
          'ORDER BY D.CD_PRODUTO, P.DS_PRODUTO, M.DS_MOTIVO';
      SQL.Add(cSQL);
      ParamByName('dtini').AsDate := cbDT_INICIAL.Date;
      ParamByName('dtfim').AsDate := cbDT_FINAL.Date;
      Open;
    end;

    if DM.qraRelMensal.IsEmpty then
    begin
      Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      Exit;
    end;

    pMsg.Caption := 'Gerando arquivo. Aguarde!';
    pMsg.Refresh;
    Application.CreateForm(TqrForm_RelMensal,qrForm_RelMensal);
    qrForm_RelMensal.RLRelMensal.PreviewModal ;
    qrForm_RelMensal.RLRelMensal.Destroy;

  finally
    qrForm_RelMensal.Free;
  end;

  bcopia := False;
  sMensagem :='';

  cArq := DM.relatdir;
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
      cSQL := cSQL + ') AND (D.CD_MOTIVO = M.CD_MOTIVO) ';
      cSQL := cSQL + 'GROUP BY D.CD_MOTIVO, M.DS_MOTIVO ';
      cSQL := cSQL + 'ORDER BY M.DS_MOTIVO ';
      cSQL := cSQL + '';
      SQL.Add(cSQL);
      Open;
    end;
    qrForm_RelMotivos.qlPeriodo.Caption := DateToStr(cbDT_INICIAL.Date) + ' A ' + DateToStr(cbDT_FINAL.Date);
    qrForm_RelMotivos.qraMotivosTot.Close;
    pMsg.Caption := 'Final da Geração';
    pMsg.Refresh;
  finally
    qrForm_RelMotivos.Free;
  end;
end;

procedure TDevolucoesFrm.cbDT_DEVOLUCAOEnter(Sender: TObject);
begin
  With DM do
    begin
      SqlAux.Close;
      SqlAux.SQL.Clear;
      SqlAux.SQL.Add('SELECT CURRENT_DATE');
      SqlAux.Open;
      cbDT_DEVOLUCAO.DateTime :=  SqlAux.Fields[0].AsDateTime;
    end;
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
  S, cArq: string;
  nPos: Integer;
begin
  bCopia := False;
  sMensagem := '';

  with DM.qraRetorno do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CEA_CONTROLE_DEVOLUCOES');
      SQL.Add('WHERE DT_DEVOLUCAO between :dti AND :dtf ');
      SQL.Add('ORDER BY DT_CADASTRO');
      ParamByName('dti').AsDate := cbDT_INICIAL.Date;
      ParamByName('dtf').AsDate := cbDT_FINAL.Date;
      Open;
    end;

  if DM.qraRetorno.IsEmpty then
    begin
      Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      Abort;
      Exit;
    end;

  pMsg.Caption := 'Gerando arquivo. Aguarde!';
  pMsg.Refresh;

  try
    cArq := DM.retdir;
    cArq := cArq + 'PROC';
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

    With DM do
      begin
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

      end;
    pMsg.Caption := 'Processamento concluído!';
    pMsg.Refresh;

  except on Msg: Exception do
    begin
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
    end;
  end;
  CloseFile(Arq);

end;

end.

