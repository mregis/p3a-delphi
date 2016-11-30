unit Devolucoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, DBCtrls, ExtCtrls, ComCtrls, Grids, Variants,
  Mask, DBGrids, ZConnection, 
  ZAbstractRODataset, ZDataset, ZAbstractDataset, ZAbstractTable,
  ZAbstractConnection;

type
  TDevolucoesFrm = class(TForm)
    lcCD_MOTIVO: TDBLookupComboBox;
    lblMotivo: TLabel;
    lcCD_PRODUTO: TDBLookupComboBox;
    LblProduto: TLabel;
    cbDT_DEVOLUCAO: TDateTimePicker;
    LblDtDevolucao: TLabel;
    GroupBoxLeituras: TGroupBox;
    LblCodigo: TLabel;
    edtCodigo: TEdit;
    StringGridFACsLidos: TStringGrid;
    StatusBarMessages: TStatusBar;
    btnFechar: TBitBtn;
    GroupBoxArquivo: TGroupBox;
    Label3: TLabel;
    cbDT_INICIAL: TDateTimePicker;
    Label4: TLabel;
    cbDT_FINAL: TDateTimePicker;
    btRelMensal: TBitBtn;
    BitBtnDiferenca: TBitBtn;
    PanelProgress: TPanel;
    PanelProgressBar: TProgressBar;
    btnArquivo: TBitBtn;
    btnSalvar: TBitBtn;
    BitBtnLimparLeituras: TBitBtn;
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnArquivoClick(Sender: TObject);
    procedure BitBtnAddProdutoClick(Sender: TObject);
    procedure StringGridFACsLidosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cbDT_INICIALChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure BitBtnLimparLeiturasClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnRelatorio1Click(Sender: TObject);

    procedure MontaRetorno();
    procedure MontaRelatorio();
    procedure btRelMensalClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnOrgClick(Sender: TObject);
    procedure BitBtnDiferencaClick(Sender: TObject);
  private
    { Private declarations }
    lin, S, cSQL, cArq, arqaus: string;
    cFieldName, cFieldValue: string;
    F,FA: TextFile;
    bCopia : boolean;
    sMensagem : String;
    procedure ProgressBarStepItOne;
  public
    { Public declarations }
  end;

var
  DevolucoesFrm: TDevolucoesFrm;

implementation

uses Main, RelMensal, RelMotivos, Cadastro_Org_Bin, Cadastro_Org_Descricao, Cadastro_Produtos,
  CDDM, U_Func;

{$R *.DFM}

procedure TDevolucoesFrm.edtCodigoChange(Sender: TObject);
begin
  StatusBarMessages.Panels.Items[4].Text := '';
end;

procedure TDevolucoesFrm.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var cConta, sBin : string;
  i : Integer;
begin
  if (Key = VK_RETURN) then
    begin
      if (validaNumCartaoCredito(edtCodigo.Text) = true) then
        begin
          // Verificando se já não é um item presente na lista.
          for i := 1 to StringGridFACsLidos.RowCount - 1 do
            begin
              if (StringGridFACsLidos.Cells[1, i] = edtCodigo.Text) then
                begin
                  StatusBarMessages.Panels.Items[4].Text :=
                        'Este item já foi lido. Ver linha ' + IntToStr(i);
                  Application.MessageBox(
                      PChar(StatusBarMessages.Panels.Items[4].Text),
                      'Aviso',
                      MB_OK + MB_ICONWARNING);
                  edtCodigo.Clear;
                  edtCodigo.SetFocus;
                  exit;
                end;
            end;

          cConta := Copy(edtCodigo.Text, Length(edtCodigo.Text) - 15, 16);
          sBin := Copy(cConta, 1, 6);
          // Adcionando a lista de leituras
          i := StringGridFACsLidos.RowCount;
          StringGridFACsLidos.RowCount := i + 1;
          StringGridFACsLidos.Cells[0, i] := IntToStr(i);
          StringGridFACsLidos.Cells[1, i] := cConta;
          StringGridFACsLidos.Cells[2, i] := sBin;
          StatusBarMessages.Panels.Items[1].Text := IntToStr(i);
          StatusBarMessages.Panels.Items[3].Text := cConta + ' | ' + sBin;
          edtCodigo.Clear;
          edtCodigo.SetFocus;
          btnSalvar.Enabled := true;
          BitBtnLimparLeituras.Enabled := true;
        end
      else
        begin
          StatusBarMessages.Panels.Items[4].Text := 'Código Inválido.';
          MessageDlg(StatusBarMessages.Panels.Items[4].Text,
              mtError, [mbOK], 0);
        end;

      edtCodigo.Clear;
      edtCodigo.SetFocus;
    end;

end;

procedure TDevolucoesFrm.edtCodigoKeyPress(Sender: TObject; var Key: Char);
var cConta, sBin : string;
  i : Integer;
begin
  if (Key = #13) then
    begin
      if (validaNumCartaoCredito(edtCodigo.Text) = true) then
        begin
            // Verificando se já não é um item presente na lista.
          for i := 1 to StringGridFACsLidos.RowCount - 1 do
            begin
              if (StringGridFACsLidos.Cells[1, i] = edtCodigo.Text) then
                begin
                  StatusBarMessages.Panels.Items[4].Text :=
                        'Este item já foi lido. Ver linha ' + IntToStr(i);
                  Application.MessageBox(
                      PChar(StatusBarMessages.Panels.Items[4].Text),
                      'Aviso',
                      MB_OK + MB_ICONWARNING);
                  edtCodigo.Clear;
                  edtCodigo.SetFocus;
                  exit;
                end;
            end;

          cConta := Copy(edtCodigo.Text, Length(edtCodigo.Text) - 15, 16);
          sBin := Copy(cConta, 1, 6);
          // Adcionando a lista de leituras
          i := StringGridFACsLidos.RowCount;
          StringGridFACsLidos.RowCount := i + 1;
          StringGridFACsLidos.Cells[0, i] := IntToStr(i);
          StringGridFACsLidos.Cells[1, i] := cConta;
          StringGridFACsLidos.Cells[2, i] := sBin;
          StatusBarMessages.Panels.Items[1].Text := IntToStr(i);
          StatusBarMessages.Panels.Items[3].Text := cConta + ' | ' + sBin;
          edtCodigo.Clear;
          edtCodigo.SetFocus;
          btnSalvar.Enabled := true;
          BitBtnLimparLeituras.Enabled := true;
        end
      else
        begin
          StatusBarMessages.Panels.Items[4].Text := 'Código Inválido.';
          MessageDlg(StatusBarMessages.Panels.Items[4].Text,
              mtError, [mbOK], 0);
        end;

      edtCodigo.Clear;
      edtCodigo.SetFocus;
    end;


end;

procedure TDevolucoesFrm.edtCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var cConta, sBin : string;
  i : Integer;
begin
  if (Key = VK_RETURN) then
    begin
      if (validaNumCartaoCredito(edtCodigo.Text) = true) then
        begin
          // Verificando se já não é um item presente na lista.
          for i := 1 to StringGridFACsLidos.RowCount - 1 do
            begin
              if (StringGridFACsLidos.Cells[1, i] = edtCodigo.Text) then
                begin
                  StatusBarMessages.Panels.Items[4].Text :=
                        'Este item já foi lido. Ver linha ' + IntToStr(i);
                  Application.MessageBox(
                      PChar(StatusBarMessages.Panels.Items[4].Text),
                      'Aviso',
                      MB_OK + MB_ICONWARNING);
                  edtCodigo.Clear;
                  edtCodigo.SetFocus;
                  exit;
                end;
            end;

          cConta := Copy(edtCodigo.Text, Length(edtCodigo.Text) - 15, 16);
          sBin := Copy(cConta, 1, 6);
          // Adcionando a lista de leituras
          i := StringGridFACsLidos.RowCount;
          StringGridFACsLidos.RowCount := i + 1;
          StringGridFACsLidos.Cells[0, i] := IntToStr(i);
          StringGridFACsLidos.Cells[1, i] := cConta;
          StringGridFACsLidos.Cells[2, i] := sBin;
          StatusBarMessages.Panels.Items[1].Text := IntToStr(i);
          StatusBarMessages.Panels.Items[3].Text := cConta + ' | ' + sBin;
          edtCodigo.Clear;
          edtCodigo.SetFocus;
          btnSalvar.Enabled := true;
          BitBtnLimparLeituras.Enabled := true;
        end
      else
        begin
          StatusBarMessages.Panels.Items[4].Text := 'Código Inválido.';
          MessageDlg(StatusBarMessages.Panels.Items[4].Text,
              mtError, [mbOK], 0);
        end;

      edtCodigo.Clear;
      edtCodigo.SetFocus;
    end;
end;

procedure TDevolucoesFrm.btnArquivoClick(Sender: TObject);
begin
  MontaRetorno();
  MontaRelatorio();
end;

procedure TDevolucoesFrm.btnFecharClick(Sender: TObject);
begin
  Close;
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
  // Definindo as datas
  cbDT_DEVOLUCAO.Date := Date;
  cbDT_INICIAL.Date := Date;
  cbDT_FINAL.Date := Date;

  // Reseta
  StringGridFACsLidos.RowCount := 1;
end;

procedure TDevolucoesFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  With DM do
    begin
      // Fecha as tabelas
      qraRetorno.Close;
      qraMotivo.Close;
      qraProduto.Close;
      qraControle.Close;
    end;
end;

procedure TDevolucoesFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
  if btnSalvar.Enabled then
    if Application.MessageBox('Há leituras que ainda não foram salvas. ' +
          'Deseja sair assim mesmo?','ATENÇÃO!!', MB_YESNO + MB_ICONWARNING) = mrNo then
       CanClose := false;

end;

procedure TDevolucoesFrm.FormCreate(Sender: TObject);
begin
  StringGridFACsLidos.Cells[0,0] := '#';
  StringGridFACsLidos.Cells[1,0] := 'Número Cartão';
  StringGridFACsLidos.Cells[2,0] := 'BIN';
end;

procedure TDevolucoesFrm.BtnRelatorio1Click(Sender: TObject);
begin
  MontaRetorno();
  MontaRelatorio();
end;

procedure TDevolucoesFrm.MontaRetorno();
var fname : String;
begin
  bCopia := False;
  sMensagem := '';
  //Procurar o intervalo de datas
//  with qraRetorno as TADOQuery do
  with DM.qraRetorno do
    begin
      Close;
      SQL.Clear;
      cSQL := 'SELECT NRO_CONTA, CD_PRODUTO, CD_MOTIVO, DT_DEVOLUCAO ' + #13#10 +
          'FROM CEA_CONTROLE_DEVOLUCOES ' +#13#10 +
          'WHERE DT_DEVOLUCAO between :dti AND :dtf ' + #13#10 +
          'ORDER BY DT_DEVOLUCAO, CD_PRODUTO, CD_MOTIVO ';
      SQL.Add(cSQL);
      ParamByName('dti').AsDate := cbDT_INICIAL.Date;
      ParamByName('dtf').AsDate := cbDT_FINAL.Date;
      Open;
    end;

  if DM.qraRetorno.IsEmpty then
    begin
      Application.MessageBox('Não existe dados para a data selecionada.',
      'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      Exit;
    end;

  PanelProgressBar.Max := Dm.qraRetorno.RecordCount;
  PanelProgress.Visible := True;
  PanelProgress.Refresh;

  try
    try
      cArq := dm.retdir;
      fname      :=  'ADDRESS2ACC.EXTRATO.IBI.' +
          FormatDateTime('ddmmyyyy.hhnnss', DM.dtatu) + '.tmp';
      arqaus    := 'ADDRESS2ACC.EXTRATO.IBI.AUS.' +
          FormatDateTime('ddmmyyyy.hhnnss', DM.dtatu) + '.tmp';

      AssignFile(F, dm.retdir + fname);
      ReWrite(F);
      AssignFile(FA, dm.retdir + arqaus);
      ReWrite(FA);

      With DM do
        begin
          while not qraRetorno.Eof do
            begin
              ProgressBarStepItOne;
              if  (qraRetorno.Fields[2].AsInteger = 7)  then
                lin := qraRetorno.Fields[0].AsString +
                    qraRetorno.Fields[1].AsString +
                    qraRetorno.Fields[2].AsString +
                    FormatDateTime('yyyymmdd', qraRetorno.Fields[3].AsDateTime)
              else
                S := qraRetorno.Fields[0].AsString + qraRetorno.Fields[1].AsString +
                     qraRetorno.Fields[2].AsString +
                     FormatDateTime('yyyymmdd', qraRetorno.Fields[3].AsDateTime);

              if (Length(trim(S)) > 0) then
                WriteLn(F, S);

              if (Length(trim(lin)) > 0) then
                WriteLn(FA, lin);

              qraRetorno.Next;
            end;
        end;
      Application.MessageBox(PChar('Arquivos ' + fname + ' e ' + arqaus +
            ' criados com sucesso no diretório ' + dm.retdir),
        'Controle de Devolução', IDOK);

    except on Msg: Exception do
      begin
        MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
      end;
    end;
  finally
    CloseFile(F);
    CloseFile(FA);
    PanelProgressBar.Step := 0;
    PanelProgress.Visible := false;
  end;

end;

procedure TDevolucoesFrm.StringGridFACsLidosKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  var sMensagem : string;
    i, srow : Integer;
begin
  if Key = VK_DELETE then
    begin
      srow := StringGridFACsLidos.Row;
      if (srow < 1 ) then exit; // Não apagar cabeçalhos

      sMensagem := 'Deseja remover o Cartão ' + StringGridFACsLidos.Cells[1, srow] +
        ' da lista? Ele não será incluído nos arquivos.';
    if Application.MessageBox(pchar(sMensagem), 'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = id_yes then
      begin
        for i := srow to StringGridFACsLidos.RowCount - 2 do
          begin
            if (StringGridFACsLidos.Cells[0, i + 1] = '') then
              StringGridFACsLidos.Cells[0, i] := ''
            else
              StringGridFACsLidos.Cells[0, i] := IntToStr(i);
              
            StringGridFACsLidos.Cells[1, i] := StringGridFACsLidos.Cells[1, i + 1];
            StringGridFACsLidos.Cells[2, i] := StringGridFACsLidos.Cells[2, i + 1];
          end;
        StringGridFACsLidos.RowCount := StringGridFACsLidos.RowCount - 1;
        StatusBarMessages.Panels.Items[1].Text := IntToStr(StringGridFACsLidos.RowCount - 1);
        btnSalvar.Enabled := StringGridFACsLidos.RowCount > 1;
        BitBtnLimparLeituras.Enabled := StringGridFACsLidos.RowCount > 1;
      end;
  end;
end;

procedure TDevolucoesFrm.MontaRelatorio();
var
  nPos : Integer;
  fname : String;
begin
  bCopia := False;
  sMensagem := '';

  Try
    with DM do
      begin
        qraRelatorioQtde.Close;
        qraRelatorioQtde.SQL.Clear;

        cSQL := 'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE ' + #13#10 +
             'FROM CEA_CONTROLE_DEVOLUCOES CD, CEA_MOTIVOS_DEVOLUCOES MD ' + #13#10 +
             'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO ' + #13#10 +
             ' AND CD.DT_DEVOLUCAO BETWEEN :dti AND :dtf ' + #13#10 +
             'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO ' + #13#10 +
             'ORDER BY CD.CD_MOTIVO';
        qraRelatorioQtde.SQL.Add(cSQL);
        qraRelatorioQtde.ParamByName('dti').AsDate := cbDT_INICIAL.Date;
        qraRelatorioQtde.ParamByName('dtf').AsDate := cbDT_FINAL.Date;
        qraRelatorioQtde.Open;

        qraRelatorioTOT.Close;
        qraRelatorioTOT.SQL.Clear;
        cSQL := '';
        cSQL := cSQL + 'SELECT COUNT(*) AS TOTAL FROM CEA_CONTROLE_DEVOLUCOES ';
        cSQL := cSQL + 'WHERE DT_DEVOLUCAO BETWEEN :dti AND :dtf ';
        qraRelatorioTOT.SQL.Add(cSQL);
        qraRelatorioTOT.ParamByName('dti').AsDate := cbDT_INICIAL.Date;
        qraRelatorioTOT.ParamByName('dtf').AsDate := cbDT_FINAL.Date;
        qraRelatorioTOT.Open;
        if qraRelatorioQtde.IsEmpty then
          begin
            Application.MessageBox('Não existe dados para a data selecionada.',
                'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
            Exit;
          end;

        PanelProgressBar.Max := qraRelatorioQtde.RecordCount;
        PanelProgress.Visible := True;
        PanelProgress.Refresh;

        try
          cArq := relatdir;
          fname := 'CEA_REL_' + FormatDateTime('ddmmyyyy', cbDT_INICIAL.Date) +
                '_A_' + 'CEA_REL_' + FormatDateTime('ddmmyyyy', cbDT_FINAL.Date) +
              '.txt';

          AssignFile(F, cArq + fname);
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
              ProgressBarStepItOne;
              for nPos := 0 to (qraRelatorioQtde.FieldCount - 1) do
                begin
                  cFieldValue := qraRelatorioQtde.FieldByName(qraRelatorioQtde.Fields[nPos].FieldName).AsString;
                  cFieldName := qraRelatorioQtde.Fields[nPos].FieldName;

                  if UpperCase(cFieldName) = 'CD_MOTIVO' then
                    S := S + Format('%2.2d',[StrToInt(cFieldValue)]) +
                        Format('%-5.5s%',[''])

                  else if UpperCase(cFieldName) = 'DS_MOTIVO' then
                      S := S + Format('%-49.49s%',[trim(cFieldValue) ])

                  else if UpperCase(cFieldName) = 'QTDE' then
                      S := S +  Format('%4.4d', [StrToInt(cFieldValue)])

                end;

              WriteLn(F, S);
              qraRelatorioQtde.Next;
            end;

          cFieldName  := qraRelatorioTOT.Fields[0].FieldName;
          cFieldValue := qraRelatorioTOT.FieldByName(cFieldName).AsString;

          S := StringOfChar(' ', (4 - Length(cFieldValue)));
          S := S + cFieldValue;
          WriteLn(F, format('%7.7s%',['------']) + StringOfChar('-',49) +
              Format('%5.5s%',['----']));
          WriteLn(F, format('%11.11s%',['TOTAL --->']) + Format('%46.46s%',['']) +
              Format('%4.4d',[StrToInt(S)]));
          ProgressBarStepItOne;
        except on Msg: Exception do
          Application.MessageBox('Erro ao criar relatorio.', 'ERRO',
              MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        end;
      end; // With

  finally
    CloseFile(F);
    PanelProgressBar.Step := 0;
    PanelProgress.Visible := false;
  end;

end;

procedure TDevolucoesFrm.btnSalvarClick(Sender: TObject);
var
  iCont: integer;
  sMensagem: string;
begin
  if lcCD_MOTIVO.KeyValue = null then
    begin
      Application.MessageBox('Selecione um Motivo de Devolução.', 'Aviso',
          MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      lcCD_MOTIVO.SetFocus;
      exit;
    end;

  if lcCD_PRODUTO.KeyValue = null then
    begin
      Application.MessageBox('Selecione um Produto.', 'Aviso',
            MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        lcCD_PRODUTO.SetFocus;
      exit;
    end;

  With DM do
    begin
      try
        SqlAux.Close;
        SqlAux.SQL.Clear;
        // Para evitar problemas de concorrencia no Banco,
        // Sempre usar transações em bloco
        CtrlDvlDBConn.StartTransaction;
        SqlAux.SQL.Add('INSERT INTO cea_controle_devolucoes ');
        SqlAux.SQL.Add('(nro_conta,cd_produto,cd_motivo,codbin,codusu) ');
        SqlAux.SQL.Add('VALUES (:cod, :produto, :motivo, :bin, :codusu)');
        // Instrução para atualizar elementos
        ZQAux.Close;
        ZQAux.SQL.Clear;
        ZQAux.SQL.Add('UPDATE cea_controle_devolucoes ');
        ZQAux.SQL.Add('SET cd_motivo = :motivo, produto = :produto ');
        ZQAux.SQL.Add('WHERE nro_conta = :cod AND dt_cadastro = :dt' );

        PanelProgressBar.Max := StringGridFACsLidos.RowCount;
        PanelProgress.Visible := True;
        PanelProgress.Refresh;
        sMensagem := '';
        for iCont := 1 to StringGridFACsLidos.RowCount - 1 do
          begin
            ProgressBarStepItOne;
            qraControle.Close;
            qraControle.ParamByName('nr_conta').AsString := StringGridFACsLidos.Cells[1, iCont];
            qraControle.ParamByName('dt_cadastro').AsDateTime := qDatadata.AsDateTime;
            qraControle.Open;

            if qraControle.IsEmpty then
              begin
                SqlAux.ParamByName('cod').AsString := StringGridFACsLidos.Cells[1, iCont];
                SqlAux.ParamByName('produto').AsString := lcCD_PRODUTO.KeyValue;
                SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
                SqlAux.ParamByName('bin').AsString := StringGridFACsLidos.Cells[2, iCont];
                SqlAux.ParamByName('codusu').AsInteger := usuaces;
                SqlAux.ExecSQL;
              end
            else
              begin
                ZQAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
                ZQAux.ParamByName('produto').AsString := lcCD_PRODUTO.KeyValue;
                ZQAux.ParamByName('cod').AsString    :=  StringGridFACsLidos.Cells[1, iCont];
                ZQAux.ParamByName('dt').AsDateTime := DM.qDatadata.AsDateTime;
                ZQAux.ExecSQL;
              end;
          end; // for
        CtrlDvlDBConn.Commit;
        StringGridFACsLidos.RowCount := 1;
        btnSalvar.Enabled := False;
        BitBtnLimparLeituras.Enabled := false;

        sMensagem := 'Informações salvas com sucesso!';
        Application.MessageBox( PChar(sMensagem), 'Aviso',
            MB_OK + MB_ICONINFORMATION);
        PanelProgressBar.Position := 0;
        PanelProgress.Visible := false;
        StatusBarMessages.Panels.Items[4].Text := sMensagem;
        StatusBarMessages.Panels.Items[1].Text := '0';
      except
        if CtrlDvlDBConn.InTransaction then
          CtrlDvlDBConn.Rollback;
        Application.MessageBox('Ocorreu um erro ao gravar as informações. ' +
              'Nenhuma informação foi salva. Tente novamente ou entre em ' +
              'contato com o Administrador', 'ATENÇÃO',
            MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
      end;    end;
end;

procedure TDevolucoesFrm.btRelMensalClick(Sender: TObject);
var cSQL : string;
begin
  bcopia := False;
  sMensagem :='';
  qrForm_RelMensal := TqrForm_RelMensal.Create(Self);
  try
    PanelProgress.Visible := True;
    PanelProgress.Refresh;
    PanelProgressBar.Step := 4;
    with DM do
      begin
        qraRelMensal.Close;
        qraRelMensal.SQL.Clear;

        cSQL := 'SELECT M.DS_MOTIVO, D.CD_PRODUTO, P.DS_PRODUTO, ' +
            'count(DISTINCT D.ID) as Total ' + #13#10 +
            'FROM CEA_CONTROLE_DEVOLUCOES D ' + #13#10 +
            '    INNER JOIN CEA_MOTIVOS_DEVOLUCOES M ON (D.CD_MOTIVO = M.CD_MOTIVO) ' + #13#10 +
            '    INNER JOIN CEA_PRODUTOS P ON (D.CD_PRODUTO = P.CD_PRODUTO) ' + #13#10 +
            'WHERE D.dt_devolucao BETWEEN :dtini AND :dtfim ' + #13#10 +
            'GROUP BY M.DS_MOTIVO, D.CD_PRODUTO, P.DS_PRODUTO ' + #13#10 +
            'ORDER BY D.CD_PRODUTO, P.DS_PRODUTO, M.DS_MOTIVO';
        qraRelMensal.SQL.Add(cSQL);
        qraRelMensal.ParamByName('dtini').AsDate := cbDT_INICIAL.Date;
        qraRelMensal.ParamByName('dtfim').AsDate := cbDT_FINAL.Date;
        qraRelMensal.Open;

        if qraRelMensal.IsEmpty then
          begin
            Application.MessageBox('Não existem dados para o período selecionado.',
                'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
            Exit;
          end;

        Application.CreateForm(TqrForm_RelMensal, qrForm_RelMensal);
        qrForm_RelMensal.dt_inicial := cbDT_INICIAL.Date;
        qrForm_RelMensal.dt_final := cbDT_FINAL.Date;
        ProgressBarStepItOne;
        qrForm_RelMensal.RLRelMensal.PreviewModal ;
        qrForm_RelMensal.RLRelMensal.Destroy;
        ProgressBarStepItOne;
      end;
  finally
    qrForm_RelMensal.Free;
    qrForm_RelMotivos.Free;
    PanelProgress.Visible := false;
    PanelProgressBar.Step := 0;
  end;
  
end;

procedure TDevolucoesFrm.cbDT_INICIALChange(Sender: TObject);
begin
  cbDT_FINAL.MinDate := cbDT_INICIAL.DateTime;
end;

procedure TDevolucoesFrm.BitBtn2Click(Sender: TObject);
begin
  OrgDescricaoFrm := TOrgDescricaoFrm.Create(self);
  OrgDescricaoFrm.ShowModal;
  OrgDescricaoFrm.Free;
end;

procedure TDevolucoesFrm.BitBtnLimparLeiturasClick(Sender: TObject);
begin
  StringGridFACsLidos.RowCount := 1;
  StatusBarMessages.Panels.Items[1].Text := '0';
  BitBtnLimparLeituras.Enabled := false;
  btnSalvar.Enabled := false;
end;

procedure TDevolucoesFrm.btnOrgClick(Sender: TObject);
begin
  OrgBinFrm := TOrgBinFrm.Create(Self);
  OrgBinFrm.ShowModal;
  OrgBinFrm.Free;
end;

procedure TDevolucoesFrm.BitBtnAddProdutoClick(Sender: TObject);
begin
  ProdutosFrm := TProdutosFrm.Create(self);
  ProdutosFrm.ShowModal;
  ProdutosFrm.Free;
end;

procedure TDevolucoesFrm.BitBtnDiferencaClick(Sender: TObject);
var
  Arq: TextFile;
  S, cArq, fname: string;
  nPos: Integer;
begin
  bCopia := False;
  sMensagem := '';
  try
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
        Application.MessageBox('Não existe dados para a data selecionada.',
            'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        Exit;
      end;

    try
      PanelProgressBar.Max := Dm.qraRetorno.RecordCount;
      PanelProgress.Visible := True;
      PanelProgress.Refresh;
      cArq := DM.retdir;
      cArq := cArq + 'PROC';
      cArq := cArq + FormatDateTime('ddmmyyyy', Date) + '\' ;

      if not DirectoryExists(cArq) then
         CreateDirectory(PAnsiChar(cArq), nil);


      fname := 'CEA_DIF_' + FormatDateTime('ddmmyyyy', cbDT_INICIAL.Date) +
            '_A_' + FormatDateTime('ddmmyyyy', cbDT_FINAL.Date) + '.txt';

      AssignFile(Arq, cArq + fname);
      ReWrite(Arq);

      With DM do
        begin
          while not qraRetorno.Eof do
            begin
              ProgressBarStepItOne;
              S := '';
              for nPos := 0 to (qraRetorno.FieldCount - 1) do
                S := S  + qraRetorno.FieldByName(qraRetorno.Fields[nPos].FieldName).AsString + ';';

              WriteLn(Arq, S);
              qraRetorno.Next;
            end;
        end;

      Application.MessageBox(PChar('Processamento concluído!' + #13#10 +
              'Arquivo ' + fname + ' criado em ' + cArq),
          'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    except on Msg: Exception do
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
    end;
  finally
    CloseFile(Arq);
    PanelProgressBar.Step := 0;
    PanelProgress.Visible := false;
  end;
end;

{
  Incrementa o contador do ProgressBar em 1 passo e atualizando sua
  exibição
}
procedure TDevolucoesFrm.ProgressBarStepItOne();
begin
    PanelProgressBar.StepBy(1);
    PanelProgressBar.StepBy(-1);
    PanelProgressBar.StepBy(1);
    PanelProgressBar.Update;
    PanelProgress.Refresh;
end;
end.

