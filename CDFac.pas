unit CDFac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, ComCtrls, Buttons, DB, //ADODB,
  ZAbstractRODataset, ZDataset, Grids;

type
  TfrmCartao = class(TForm)
    pMsg: TPanel;
    Timer1: TTimer;
    gbxProcessamento: TGroupBox;
    qryFamilia: TZReadOnlyQuery;
    FacRelQtde: TZReadOnlyQuery;
    FacRelTot: TZReadOnlyQuery;
    LblDtInicio: TLabel;
    cbDT_DEVOLUCAO: TDateTimePicker;
    LblDtFinal: TLabel;
    DTPFinal: TDateTimePicker;
    LblMotivoDevol: TLabel;
    lcCD_MOTIVO: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    LabelCodBin: TLabel;
    Label2: TLabel;
    edtCartao: TEdit;
    eBIN: TEdit;
    StringGridFACsLidos: TStringGrid;
    StatusBarMessages: TStatusBar;
    BitBtnSalvar: TBitBtn;
    BitBtnArquivo: TBitBtn;
    Edarq: TEdit;
    LblArq: TLabel;
    btnFechar: TBitBtn;
    procedure edtCartaoKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnArquivoClick(Sender: TObject);
    procedure BitBtnSalvarClick(Sender: TObject);
    procedure StringGridFACsLidosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eBinChange(Sender: TObject);
    procedure cbDT_DEVOLUCAOEnter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcCD_MOTIVOClick(Sender: TObject);
    procedure lcCD_MOTIVOExit(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure montarel;
  private
    { Private declarations }
    s, sLinha1, sLinha2, sLinha3, sCDMotivo: string;
    i: integer;
    F,FA: TextFile;
    sDir, srel, arqausente : string;
    ListaSLP: TStringList;
    sCartao,cSQL: string;
    ListaArq: TStringList;
    flqsalva,bAusente: Boolean;
    cFieldValue : Variant;
    cFieldName  : string;
    function GerarArquivo: boolean;
  public
    { Public declarations }
  end;

var
  frmCartao: TfrmCartao;
  ScartaoLido: string;

implementation
uses CDDM, U_Func;

{$R *.dfm}

procedure TfrmCartao.FormCreate(Sender: TObject);
begin
  DM.qMotivo.Close;
  DM.qMotivo.Open;
  DM.qData.Close;
  DM.qData.Open;
  cbDT_DEVOLUCAO.Date := DM.qDatadata.AsDateTime;
  i := 1;
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date,localtime(0)');
  dm.SqlAux.Open;
  self.cbDT_DEVOLUCAO.Date  :=  dm.SqlAux.Fields[0].AsDateTime;
  self.DTPFinal.Date        :=  dm.SqlAux.Fields[0].AsDateTime;
  flqsalva:= False;
end;

procedure TfrmCartao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With DM do
    begin
      DM.qMotivo.Close;
      DM.qData.Close;
      DM.qFac.Close;
    end;
  Action := caFree;
end;

procedure TfrmCartao.lcCD_MOTIVOClick(Sender: TObject);
begin
  if lcCD_MOTIVO.KeyValue <> null then
  begin
    if sCDMotivo = '' then
      sCDMotivo := lcCD_MOTIVO.KeyValue;

  end;
end;

procedure TfrmCartao.lcCD_MOTIVOExit(Sender: TObject);
begin
  if lcCD_MOTIVO.KeyValue <> null then
    begin
      if StringGridFACsLidos.RowCount > 1 then
        begin
          if (sCDMotivo <> '') and (sCDMotivo <> lcCD_MOTIVO.KeyValue) then
            begin
              if Application.MessageBox('Você está a prestes a alterar o Motivo de ' +
                    'Devolução de todas as leituras efetuadas presentes na lista. ' + #13#10 +
                    'Tem certeza que deseja continuar?', 'ATENÇÃO',
                  MB_YESNO + MB_SYSTEMMODAL + MB_ICONWARNING) = id_no then
                lcCD_MOTIVO.KeyValue := sCDMotivo
              else
                sCDMotivo := lcCD_MOTIVO.KeyValue;
            end;
        end
          else
            begin
              sCDMotivo := lcCD_MOTIVO.KeyValue;
              edtCartao.SetFocus;
            end;
    end;
end;

procedure TfrmCartao.cbDT_DEVOLUCAOEnter(Sender: TObject);
begin
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('SELECT CURRENT_DATE');
  dm.SqlAux.Open;
  cbDT_DEVOLUCAO.Date :=  dm.SqlAux.Fields[0].AsDateTime;
end;

Procedure TfrmCartao.montarel;
var
  nPos : Integer;
begin
  with FacRelQtde do
    begin
      Close;
      SQL.Clear;

      cSQL := '';
      cSQL := cSQL + 'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE FROM IBI_CONTROLE_DEVOLUCOES_AR CD, CEA_MOTIVOS_DEVOLUCOES MD ';
      cSQL := cSQL + 'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO ';
      cSQL := cSQL + ' AND ';
      cSQL := cSQL + '(CD.DT_DEVOLUCAO BETWEEN '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_DEVOLUCAO.Date)+chr(39) ;
      cSQL := cSQL + ' and '+chr(39) + FormatDateTime('yyyy/mm/dd',DTPFinal.Date)+chr(39)+') ';
      cSQL := cSQL + 'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO ';
      cSQL := cSQL + 'ORDER BY CD.CD_MOTIVO';

      SQL.Add(cSQL);
      Open;
    end;

  with FacRelTot do
    begin
      Close;
      SQL.Clear;
      cSQL := '';
      cSQL := cSQL + 'SELECT COUNT(*) AS TOTAL FROM IBI_CONTROLE_DEVOLUCOES_AR ';
      cSQL := cSQL + 'WHERE DT_DEVOLUCAO BETWEEN :dti AND :dtf ';
      SQL.Add(cSQL);
      ParamByName('dti').AsDate := cbDT_DEVOLUCAO.Date;
      ParamByName('dtf').AsDate := DTPFinal.Date;
      Open;
    end;

  if FacRelQtde.IsEmpty then
    begin
      Application.MessageBox('Não existem dados para a data selecionada.',
          'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      Exit;
    end;

  try
    sRel := dm.relatdir;
    sRel := sRel + 'IBI_REL_' + FormatDateTime('ddmmyyyy', DM.qDatadata.AsDateTime) +
          FormatDateTime('hhnnss',Time) + '.txt';
    AssignFile(F, sRel);
    ReWrite(F);
    WriteLn(F, format('%61.61s%', [StringOfChar('-',60)]));
    WriteLn(F, '');
    WriteLn(F, format('%-51.51s%', [' ADDRESS SA -  IBI CARTÕES FAC']) +
          format('%-10.10s%', ['PAGINA: 01']));
    WriteLn(F, '');
    WriteLn(F, ' PROCESSAMENTO DE: ' + DateToStr(cbDT_DEVOLUCAO.Date) +
        ' À ' + DateToStr(DTPFinal.Date));
    WriteLn(F, '');
    WriteLn(F, '                  RESUMO DO CONTROLE DE DEVOLUCOES');
    WriteLn(F, ' ____________________________________________________________');
    WriteLn(F, format('%-57.57s%', [' CODIGO DESCRICAO']) +
        format('%-04.04s%', ['QTDE']));
    WriteLn(F, format('%7.7s%',['------']) + StringOfChar('-', 49) +
        format('%5.5s%', ['----']));

    While not FacRelQtde.Eof do
      begin
        S := ' ';
        for nPos := 0 to (FacRelQtde.FieldCount - 1) do
          begin
            cFieldValue := FacRelQtde.FieldByName(FacRelQtde.Fields[nPos].FieldName).AsString;
            cFieldName := FacRelQtde.Fields[nPos].FieldName;

            if UpperCase(cFieldName) = 'CD_MOTIVO' then
              S := S + Format('%2.2d',[StrToInt(cFieldValue)]) + Format('%-5.5s%',[''])

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
        FacRelQtde.Next;
      end;

    cFieldValue := FacRelTot.FieldByName(FacRelTot.Fields[0].FieldName).AsString;
    cFieldName  := FacRelTot.Fields[0].FieldName;
    S := StringOfChar(' ', (4 - Length(cFieldValue)));
    S := S + cFieldValue;
    WriteLn(F, format('%7.7s%',['------'])+ StringOfChar('-',49)+format('%5.5s%',['----']));
    WriteLn(F, format('%11.11s%',['TOTAL --->'])+ format('%46.46s%',[''])+format('%4.4d',[StrToInt(S)]));

  except
    on Msg: Exception do
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
  end;

  CloseFile(F);
end;

procedure TfrmCartao.StringGridFACsLidosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var j, srow : Integer;
    sMensagem : String;
begin
  if Key = VK_DELETE then
    begin
      srow := StringGridFACsLidos.Row;
      if (srow < 1 ) then exit; // Não apagar cabeçalhos

      sMensagem := 'Deseja remover o Objeto ' + StringGridFACsLidos.Cells[1, srow] +
        ' da lista? Ele não será incluído nos arquivos.';
    if Application.MessageBox(pchar(sMensagem), 'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = id_yes then
      begin
        for j := srow to StringGridFACsLidos.RowCount - 2 do
          begin
            if (StringGridFACsLidos.Cells[0, j + 1] = '') then
              StringGridFACsLidos.Cells[0, j] := ''
            else
              StringGridFACsLidos.Cells[0, j] := IntToStr(i);

            StringGridFACsLidos.Cells[1, j] := StringGridFACsLidos.Cells[1, j + 1];
            StringGridFACsLidos.Cells[2, j] := StringGridFACsLidos.Cells[2, j + 1];
          end;
        StringGridFACsLidos.RowCount := StringGridFACsLidos.RowCount - 1;
        StatusBarMessages.Panels.Items[1].Text := IntToStr(StringGridFACsLidos.RowCount - 1);
        BitBtnSalvar.Enabled := StringGridFACsLidos.RowCount > 1;
      end;
  end;
end;

procedure TfrmCartao.BitBtnArquivoClick(Sender: TObject);
begin
  With DM do
    begin
      qArqFac.Close;
      qArqFac.ParamByName('dt1').AsDate := cbDT_DEVOLUCAO.Date;
      qArqFac.ParamByName('dt2').AsDate := cbDT_DEVOLUCAO.Date;
      qArqFac.Open;
      if not DM.qArqFac.IsEmpty then
        begin
          if GerarArquivo then
            begin
              montarel;
              Application.MessageBox('Arquivo gerado com sucesso.',
                  'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
            end;
        end
      else
        begin
          Application.MessageBox('Não existe devolução para a data selecionada.',
                'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        end;
    end;
end;

procedure TfrmCartao.BitBtnSalvarClick(Sender: TObject);
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

  With DM do
    begin
      try
        qCodFac.Close;
        qFac.Close;
        qData.Close;

        // Para evitar problemas de concorrencia no Banco,
        // Sempre usar transações em bloco
        CtrlDvlDBConn.StartTransaction;
        qCodFac.Open;
        qFac.Open;
        qData.Open;
        // Instrução de inclusão
        SqlAux.Close;
        SqlAux.SQL.Clear;
        SqlAux.SQL.Add('INSERT INTO ibi_controle_devolucoes_fac ');
        SqlAux.SQL.Add('(nro_cartao,cd_motivo,codbin,codusu)');
        SqlAux.SQL.Add('VALUES :cartao, :motivo, :bin, :codusu');
        // Instrução de atualização
        ZQAux.Close;
        ZQAux.SQL.Clear;
        ZQAux.SQL.Add('UPDATE ibi_controle_devolucoes_fac ');
        ZQAux.SQL.Add('SET cd_motivo=:motivo ');
        ZQAux.SQL.Add('WHERE nro_cartao=:cartao AND dt_cadastro = :dt');

        for iCont := 1 to StringGridFACsLidos.RowCount - 1 do
          begin
            sMensagem := '';
            qBuscaFAC.Close;
            qBuscaFAC.ParamByName('cartao').AsString := StringGridFACsLidos.Cells[1, iCont];
            qBuscaFAC.ParamByName('data').AsDate := cbDT_DEVOLUCAO.Date;
            qBuscaFAC.Open;

            // Verificando se o cartao já foi lido na data passada
            if qBuscaFAC.IsEmpty then
              begin
                // Não existe entrada, será criado uma
                SqlAux.ParamByName('cartao').AsString := StringGridFACsLidos.Cells[1, iCont];
                SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
                SqlAux.ParamByName('bin').AsString := StringGridFACsLidos.Cells[2, iCont];
                SqlAux.ParamByName('codusu').AsInteger := DM.usuaces;
                SqlAux.ExecSQL;
              end
            else
              begin
                ZQAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
                ZQAux.ParamByName('cartao').AsString := StringGridFACsLidos.Cells[1, iCont];
                ZQAux.ParamByName('dt').AsDateTime := qDatadata.AsDateTime;
                ZQAux.ExecSQL;
              end;
          end; // for
        CtrlDvlDBConn.Commit;
        StringGridFACsLidos.RowCount := 1;
        BitbtnSalvar.Enabled := False;
        sMensagem := 'Informações salvas com sucesso!';
        Application.MessageBox( PChar(sMensagem), 'Aviso',
            MB_OK + MB_ICONINFORMATION);
        StatusBarMessages.Panels.Items[4].Text := sMensagem;
        StatusBarMessages.Panels.Items[1].Text := '0';

      except
        if CtrlDvlDBConn.InTransaction then
          CtrlDvlDBConn.Rollback;
        Application.MessageBox('Ocorreu um erro ao gravar as informações. ' +
              'Nenhuma informação foi salva. Tente novamente ou entre em ' +
              'contato com o Administrador', 'ATENÇÃO',
            MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
      end;
    end;
end;

function TfrmCartao.GerarArquivo: boolean;
var
  iAux: integer;
begin
  Result := True;
  ListaArq := TStringList.Create;
  ListaSLP := TStringList.Create;
  sDir  :=  DM.retdir;

  Edarq.Text := sDir + 'ADDRESS2ACC.CARTAO.IBI.FAC.' + FormatDateTime('DDMMYYYY.hhnnss', dm.dtatu) + '.TMP';
  arqausente := sDir + 'ADDRESS2ACC.CARTAOA.USR.IBI.FAC.' + FormatDateTime('DDMMYYYY.hhnnss', dm.dtatu) + '.TMP';
  sRel := DM.relatdir + 'ADDRESS2ACC.CARTAO.IBI.FAC.' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date)+ '.SLP';
  AssignFile(FA, arqausente);
  Rewrite(FA);

  AssignFile(F,Edarq.Text);
  Rewrite(F);
  DM.qArqFac.First;
  sCartao := '';
  iAux := 0;
  DM.qParam.Close;
  DM.qParam.Open;

  bAusente := False;
  if DM.qParamAUSENTE.AsString = 'S' then
    begin
      DM.ZqAusFac.Close;
      DM.ZqAusFac.ParamByName('data').AsDate := cbDT_DEVOLUCAO.Date;
      DM.ZqAusFac.ParamByName('cd_motivo').AsString := DM.qParamCD_MOTIVO.AsString;
      DM.ZqAusFac.Open;

      if not DM.ZqAusFac.IsEmpty then
        bAusente := True;
    end;

    ListaSLP.Add(StringOfChar('-', 88));
    ListaSLP.Add('                       Devolução IBI - Cartões - FAC                      ');
    ListaSLP.Add(StringOfChar('-', 88));
    ListaSLP.Add('Arquivo          : '+'ADDRESS2ACC.CARTAO.IBI.FAC'+copy(Edarq.Text,length(Edarq.Text)-(18+1),length(Edarq.Text)-18));
    ListaSLP.Add('Data da Devolução: ' + FormatDateTime('DD/MM/YYYY', cbDT_DEVOLUCAO.Date));
    if bAusente then
      begin
        ListaSLP.Add('Total de Objetos Outros   : ' + FormatFloat('##,##0;;', DM.qArqFac.RecordCount - DM.ZqAusFac.Fields.Fields[0].AsInteger));
        ListaSLP.Add('Total de Objetos Ausentes : ' + FormatFloat('##,##0;;', DM.ZqAusFac.Fields.Fields[0].AsInteger));
      end
    else
      begin
        ListaSLP.Add('Total de Objetos Outros   : ' + FormatFloat('##,##0;;', DM.qArqFac.RecordCount));
        ListaSLP.Add('Total de Objetos Ausentes : ' + FormatFloat('##,##0;;', 0));
      end;

    ListaSLP.Add('Total de Objetos : ' + FormatFloat('##,##0', DM.qArqFac.RecordCount));
    ListaSLP.Add(StringOfChar('-', 88));
    ListaSLP.Add('Cartões:');

    while not DM.qArqFac.Eof do
      begin
        if  (DM.qArqFacCD_MOTIVO.AsInteger = 7) then
          begin
            s := DM.qArqFacNRO_CARTAO.AsString + '005' + DM.qArqFacCD_MOTIVO.AsString + FormatDateTime('ddmmyyyy', DM.qArqFacDATA.AsDateTime);
            Writeln(FA, s);
          end
        else
          begin
            s := DM.qArqFacNRO_CARTAO.AsString + '005' + DM.qArqFacCD_MOTIVO.AsString + FormatDateTime('ddmmyyyy', DM.qArqFacDATA.AsDateTime);
            Writeln(F, s);
          end;

        if iAux < 5 then
          begin
            if iAux = 0 then
              begin
                sCartao := DM.qArqFacNRO_CARTAO.AsString;
                inc(iAux);
              end
            else
              begin
                if iAux <> 4 then
                  begin
                    sCartao := sCartao + '  ' + DM.qArqFacNRO_CARTAO.AsString;
                    inc(iAux);
                  end
                else
                  begin
                    sCartao := sCartao + '  ' + DM.qArqFacNRO_CARTAO.AsString;
                    ListaSLP.Add(sCartao);
                    iAux := 0;
                    sCartao := '';
                  end;
              end;
          end;

        DM.qArqFac.Next;
      end;

    ListaSLP.Add(sCartao);
    ListaSLP.Add(StringOfChar('-', 88));
    ListaSLP.Add(format('%-10.10s%',['© ' + FormatDateTime('YYYY', DM.qdatadata.AsDateTime)])
    +   format('%-57.57s%',['ADDRESS SA'])+ FormatDateTime('DD/MM/YYYY - hh:nn:ss',DM.qDatadata.AsDateTime));
    ListaSLP.SaveToFile(sRel);
    Application.ProcessMessages;
    pMsg.Caption := '';
    CloseFile(F);
    ListaSLP.Free;
end;

procedure TfrmCartao.btnFecharClick(Sender: TObject);
begin
    close;
end;

procedure TfrmCartao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (StringGridFACsLidos.RowCount > 1) then
    if Application.MessageBox(pchar('A lista de FACs lidos não foi gravada! Deseja sair assim mesmo?'),
        'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = ID_NO then
        abort;
  CanClose := True;

end;

procedure TfrmCartao.eBinChange(Sender: TObject);
var r : Integer;
  s : String;
begin
  eBin.Text := trim(eBin.Text);
  if (length(eBin.Text) > 4) then
    begin
      if (eBin.Text = '52743') then
        eBin.Text := eBin.Text + '7'
      else if (eBin.Text = '51854') then
        eBin.Text := eBin.Text + '4'
      else if (eBin.Text = '53133') then
        eBin.Text := eBin.Text + '9';
    end;

  if (length(eBin.Text) > 5) then
    begin
      StatusBarMessages.Panels.Items[4].Text := '';
      qryFamilia.Close;
      qryFamilia.ParamByName('COD_BIN').AsString := eBin.Text;
      qryFamilia.Open;

      if qryFamilia.RecordCount > 0 then
        begin
          BitbtnSalvar.Enabled := true;
          r := StringGridFACsLidos.RowCount;
          StringGridFACsLidos.RowCount := StringGridFACsLidos.RowCount + 1;
          StringGridFACsLidos.Cells[0, r] := IntToStr(r);
          StringGridFACsLidos.Cells[1, r] := edtCartao.Text;
          StringGridFACsLidos.Cells[2, r] := eBin.Text;
          StatusBarMessages.Panels.Items[1].Text := IntToStr(r);
          StatusBarMessages.Panels.Items[3].Text := edtCartao.Text + ' | ' +
              eBin.Text;
          edtCartao.Clear;
          eBin.Clear;
          edtCartao.SetFocus;
        end
      else
        begin
          s := 'Este BIN não está cadastrado! Verifique a informação.' + #13#10 +
                'Caso esteja correto será necessário cadastrar a Família deste BIN';
          Application.MessageBox(
              PChar(s),
                'Controle de Devoluções - FAC', MB_OK + MB_ICONWARNING);
          StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
          eBin.SetFocus;
        end;
    end;
end;

procedure TfrmCartao.edtCartaoKeyPress(Sender: TObject; var Key: Char);
begin
  Timer1.Enabled := False;
  pMsg.Caption := 'Lendo informações do Cartão';
  pMsg.Font.Color := clRed;
  try
    // Evitando problema de teclado trocado?? 
    if (key = '?') or (key = 'ç') then
      begin
        s := s + ':';
        if i = 1 then
          begin
            sLinha1 := s;
            if (Length(sLinha1) < 77) and (Length(sLinha1) > 78) then
              begin
                sLinha1 := '';
              end;
            inc(i);
          end;
        if i = 2 then
          begin
            sLinha2 := s;
            inc(i);
          end;
        if i = 3 then
          begin
            sLinha3 := s;
            inc(i);
          end;
        s := '=';
      end
    else if s <> '=' then
      s := s + key
    else
      s := '';
  finally
    Timer1.Enabled := True;
  end;
end;

procedure TfrmCartao.Timer1Timer(Sender: TObject);
var scartao: string;
begin

  pMsg.Caption := 'Aguardando leitura do Cartão Magnético';
  pMsg.Font.Color := clBlue;
  if (sLinha1 <> '') then
    begin
      scartao := copy(sLinha1, 3, 16);

      if (validaNumCartaoCredito(trim(scartao))) then
        begin
          eBIN.Text :=  copy(scartao,1,6);
          sCartaoLido := scartao;
          eBIN.SetFocus;
        end
      else
        begin
          pMsg.Caption := 'Cartão inválido';
          pMsg.Font.Color := clRed;
          Timer1.Enabled := True;
        end;
    end;
end;


end.

