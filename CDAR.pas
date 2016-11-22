unit CDAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ComCtrls, ExtCtrls, OleServer, DB,
  ZAbstractRODataset, ZDataset, Grids;

type
  TfrmAR = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    pMsg: TPanel;
    gbxCartao: TGroupBox;
    edtCodigo: TEdit;
    cbDT_DEVOLUCAO: TDateTimePicker;
    lcCD_MOTIVO: TDBLookupComboBox;
    gbxProcessamento: TGroupBox;
    btnSalvar: TBitBtn;
    btnArquivo: TBitBtn;
    eBin: TEdit;
    LabelCodBin: TLabel;
    DtDevFim: TDateTimePicker;
    Label4: TLabel;
    Label1: TLabel;
    qryFamilia: TZReadOnlyQuery;
    qraRelatorioTOT: TZReadOnlyQuery;
    qraRelatorioQtde: TZReadOnlyQuery;
    StringGridARsLidos: TStringGrid;
    StatusBarMessages: TStatusBar;
    ListArq: TListBox;
    btnFechar: TBitBtn;
    BitBtnLimparLeituras: TBitBtn;
    procedure BitBtnLimparLeiturasClick(Sender: TObject);
    procedure StatusBarMessagesDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure StringGridARsLidosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cbDT_DEVOLUCAOEnter(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure lcCD_MOTIVOClick(Sender: TObject);
    procedure lcCD_MOTIVOExit(Sender: TObject);
    procedure btnArquivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eBinChange(Sender: TObject);
    procedure montarel;
  private
    { Private declarations }
    sCDMotivo,cSQL: string;
    ListaArq: TStringList;
    F, A,FA: TextFile;
    s, sAusente, sDir, arqausente, arqoutros, sRel : string;
    bAusente: Boolean;
    ListaSLP: TStringList;
    sCartao: string;
    iAux: integer;
    cFieldValue : Variant;
    cFieldName  : string;
    function GerarArquivo: boolean;

  public
    { Public declarations }
  end;

var
  frmAR: TfrmAR;
implementation

uses CDDM, U_Func;

{$R *.dfm}

procedure TfrmAR.edtCodigoChange(Sender: TObject);
var i : integer;
  msgs : String;
begin
  if (Length(edtCodigo.Text) > 12) then
    begin
      if (validaNumObjCorreios(edtCodigo.Text) = true) then
        begin
          StatusBarMessages.Panels.Items[4].Text := '';
          // Verificando se já não é um item presente na lista.
          for i := 1 to StringGridARsLidos.RowCount - 1 do
            begin
              if (StringGridARsLidos.Cells[1, i] = edtCodigo.Text) then
                begin
                  msgs := 'Este item já foi lido. Ver linha ' +
                  IntToStr(i);
                  StatusBarMessages.Panels.Items[4].Text := msgs;
                  Application.MessageBox(PChar(msgs), 'Aviso',
                      MB_OK + MB_ICONWARNING);
                  edtCodigo.Clear;
                  edtCodigo.SetFocus;
                  abort;
                end;
            end;

          // Chegou até aqui é porque o item não está presente
          eBin.SetFocus;
          StatusBarMessages.Panels.Items[1].Text := intToStr(StringGridARsLidos.RowCount - 1);
        end
      else
        begin
          msgs := 'Número de Objeto inválido!';
          Application.MessageBox(PChar(msgs), 'Aviso',
                      MB_OK + MB_ICONWARNING);
          StatusBarMessages.Panels.Items[4].Text := msgs;
          edtCodigo.SelectAll;
          abort;
        end;
  end;
end;


procedure TfrmAR.btnSalvarClick(Sender: TObject);
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
      qCodAR.Close;
      qCodAR.Open;

      qAR.Close;
      qAR.Open;

      qData.Close;
      qData.Open;
      try
        SqlAux.Close;
        SqlAux.SQL.Clear;
        // Para evitar problemas de concorrencia no Banco,
        // Sempre usar transações em bloco
        CtrlDvlDBConn.StartTransaction;

        // Instrução para inserir elementos
        SqlAux.SQL.Add('INSERT INTO ibi_controle_devolucoes_ar ');
        SqlAux.SQL.Add('(cod_ar,cd_motivo,codbin,codusu) ');
        SqlAux.SQL.Add('VALUES (:cod, :motivo,:bin,:codusu)');
        // Instrução para atualizar elementos
        ZQAux.Close;
        ZQAux.SQL.Clear;
        ZQAux.SQL.Add('UPDATE ibi_controle_devolucoes_ar ');
        ZQAux.SQL.Add('SET cd_motivo = :motivo ');
        ZQAux.SQL.Add('WHERE cod_ar = :cod AND dt_cadastro = :dt' );

        for iCont := 1 to StringGridARsLidos.RowCount - 1 do
          begin
            sMensagem := '';
            qBuscaAR.Close;
            qBuscaAR.ParamByName('cartao').AsString := StringGridARsLidos.Cells[1, iCont];
            qBuscaAR.ParamByName('data').AsDateTime := qDatadata.AsDateTime;
            qBuscaAR.Open;

            if qBuscaAR.IsEmpty then
              begin
                SqlAux.ParamByName('cod').AsString := StringGridARsLidos.Cells[1, iCont];
                SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
                SqlAux.ParamByName('bin').AsString := StringGridARsLidos.Cells[2, iCont];
                SqlAux.ParamByName('codusu').AsInteger := usuaces;
                SqlAux.ExecSQL;
              end
            else
              begin
                ZQAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
                ZQAux.ParamByName('cod').AsString    :=  StringGridARsLidos.Cells[1, iCont];
                ZQAux.ParamByName('dt').AsDateTime := DM.qDatadata.AsDateTime;
                ZQAux.ExecSQL;
              end;
          end; // for
        CtrlDvlDBConn.Commit;
        StringGridARsLidos.RowCount := 1;
        btnSalvar.Enabled := False;
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

procedure TfrmAR.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmAR.lcCD_MOTIVOClick(Sender: TObject);
begin
  if lcCD_MOTIVO.KeyValue <> null then
    if sCDMotivo = '' then
      sCDMotivo := lcCD_MOTIVO.KeyValue;
end;

procedure TfrmAR.lcCD_MOTIVOExit(Sender: TObject);
begin
  if lcCD_MOTIVO.KeyValue <> null then
    begin
      if StringGridARsLidos.RowCount > 1 then
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
              edtCodigo.SetFocus;
            end;
    end;
end;

Procedure TfrmAR.montarel;
var nPos : Integer;
begin
  with qraRelatorioQtde do
    begin
      Close;
      SQL.Clear;

      cSQL := '';
      cSQL := cSQL + 'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE FROM IBI_CONTROLE_DEVOLUCOES_AR CD, CEA_MOTIVOS_DEVOLUCOES MD ';
      cSQL := cSQL + 'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO ';
      cSQL := cSQL + ' AND ';
      cSQL := cSQL + '(CD.DT_DEVOLUCAO BETWEEN '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_DEVOLUCAO.Date)+chr(39) ;

      cSQL := cSQL + ' and '+chr(39) + FormatDateTime('yyyy/mm/dd',DtDevFim.Date)+chr(39)+') ';
      cSQL := cSQL + 'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO ';
      cSQL := cSQL + 'ORDER BY CD.CD_MOTIVO';

      SQL.Add(cSQL);
      Open;
  end;

  with qraRelatorioTOT do
    begin
      Close;
      SQL.Clear;
      cSQL := '';
      cSQL := cSQL + 'SELECT COUNT(*) AS TOTAL FROM IBI_CONTROLE_DEVOLUCOES_AR ';
      cSQL := cSQL + 'WHERE DT_DEVOLUCAO BETWEEN :dti AND :dtf ';
      SQL.Add(cSQL);
      ParamByName('dti').AsDate := cbDT_DEVOLUCAO.Date;
      ParamByName('dtf').AsDate := DtDevFim.Date;
      Open;
    end;

  if qraRelatorioQtde.IsEmpty then
    begin
      Application.MessageBox('Não existe dados para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      Exit;
    end;

  try
    sRel := dm.relatdir;
    sRel := sRel + 'IBI_REL_'+FormatDateTime('ddmmyyyy',DM.qDatadata.AsDateTime)+FormatDateTime('hhmmss',Time) +'.txt';
    AssignFile(F, sRel);
    ReWrite(F);
    WriteLn(F, format('%61.61s%',[StringOfChar('-',60)]));
    WriteLn(F, '');
    WriteLn(F, format('%-51.51s%',[' ADDRESS SA -  IBI CARTÕES AR'])+format('%-10.10s%',['PAGINA: 01']));
    WriteLn(F, '');
    WriteLn(F, ' PROCESSAMENTO DE: ' + DateToStr(cbDT_DEVOLUCAO.Date) + ' À ' + DateToStr(DtDevFim.Date));
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
        qraRelatorioQtde.Next;
      end;

    cFieldValue := qraRelatorioTOT.FieldByName(qraRelatorioTOT.Fields[0].FieldName).AsString;
    cFieldName  := qraRelatorioTOT.Fields[0].FieldName;
    S := StringOfChar(' ', (4 - Length(cFieldValue)));
    S := S + cFieldValue;
    WriteLn(F, format('%7.7s%', ['------']) + StringOfChar('-', 49) +
      format('%5.5s%', ['----']));
    WriteLn(F, format('%11.11s%',['TOTAL --->'])+ format('%46.46s%',[''])+format('%4.4d',[StrToInt(S)]));

  except on Msg: Exception do
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
  end;

  CloseFile(F);
end;

procedure TfrmAR.StatusBarMessagesDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
if Panel.Index = 4 then begin
  StatusBar.Canvas.Font.Style := [fsBold];
  StatusBar.Canvas.Font.Color := clRed;
//  StatusBar.Canvas.TextRect(Rect,Rect.Left,Rect.Top, 'It is me.');
end;
end;

procedure TfrmAR.StringGridARsLidosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var sMensagem : string;
    i, srow : Integer;
begin
  if Key = VK_DELETE then
    begin
      srow := StringGridARsLidos.Row;
      if (srow < 1 ) then exit; // Não apagar cabeçalhos

      sMensagem := 'Deseja remover o Objeto ' + StringGridARsLidos.Cells[1, srow] +
        ' da lista? Ele não será incluído nos arquivos.';
    if Application.MessageBox(pchar(sMensagem), 'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = id_yes then
      begin
        for i := srow to StringGridARsLidos.RowCount - 2 do
          begin
            if (StringGridARsLidos.Cells[0, i + 1] = '') then
              StringGridARsLidos.Cells[0, i] := ''
            else
              StringGridARsLidos.Cells[0, i] := IntToStr(i);
              
            StringGridARsLidos.Cells[1, i] := StringGridARsLidos.Cells[1, i + 1];
            StringGridARsLidos.Cells[2, i] := StringGridARsLidos.Cells[2, i + 1];
          end;
        StringGridARsLidos.RowCount := StringGridARsLidos.RowCount - 1;
        StatusBarMessages.Panels.Items[1].Text := IntToStr(StringGridARsLidos.RowCount - 1);
        btnSalvar.Enabled := StringGridARsLidos.RowCount > 1;
      end;
  end;
end;

procedure TfrmAR.BitBtnLimparLeiturasClick(Sender: TObject);
begin
  StringGridARsLidos.RowCount := 1;
  StatusBarMessages.Panels.Items[1].Text := '0';
  BitBtnLimparLeituras.Enabled := false;
  btnSalvar.Enabled := false;
end;

procedure TfrmAR.btnArquivoClick(Sender: TObject);
begin
  DM.qArqAR.Close;
  DM.qArqAR.ParamByName('dt_devolucao').AsDate := cbDT_DEVOLUCAO.Date;
  DM.qArqAR.ParamByName('dt_devfim').AsDate := DtDevFim.Date;
  DM.qArqAR.Open;
  if not DM.qArqAR.IsEmpty then
    begin
      if GerarArquivo then
        begin
          ListArq.Items.Add(arqausente);
          ListArq.Items.Add(arqoutros);
          montarel;
          Application.MessageBox('Arquivo gerado com sucesso.',
              'Aviso',
              MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        end;
    end
  else
    Application.MessageBox('Não existe devolução para a data selecionada.',
        'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);

end;

function TfrmAR.GerarArquivo: boolean;
begin
  Result := True;
  ListaArq := TStringList.Create;
  ListaSLP := TStringList.Create;
  sDir := DM.retdir;
  try

    DM.qParam.Close;
    DM.qParam.Open;
    bAusente := False;
    if DM.qParamAUSENTE.AsString = 'S' then
      begin
        DM.qAusente.Close;
        DM.qAusente.ParamByName('data').AsDate := cbDT_DEVOLUCAO.Date;
        DM.qAusente.ParamByName('cd_motivo').AsString := DM.qParamCD_MOTIVO.AsString;
        DM.qAusente.Open;

        if not DM.qAusente.IsEmpty then
          bAusente := True;
      end;

    sRel  :=  DM.relatdir;
    ListaSLP.Add(StringOfChar('-', 73));
    ListaSLP.Add('                       Devolução IBI - ARs                       ');
    ListaSLP.Add(StringOfChar('-', 73));
    ListaSLP.Add('Arquivo Ausente  :  ADDRESS2ACC.CARTAO.IBI.AR.' +
          'AUSR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) +
          FormatDateTime('HHNNSS',Time) + '.TMP');
    arqausente := sDir+'ADDRESS2ACC.CARTAO.IBI.AR.' + 'AUSR' +
          FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) +
          FormatDateTime('HHNNSS',Time) + '.TMP';
    ListaSLP.Add('Arquivo Outros   : ADDRESS2ACC.CARTAO.IBI.AR.' + 'OUTR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TMP');
    arqoutros :=  sDir+'ADDRESS2ACC.CARTAO.IBI.AR.'+ 'OUTR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TMP';
    ListaSLP.Add('Data da Devolução: ' + FormatDateTime('DD/MM/YYYY', cbDT_DEVOLUCAO.Date));
    if bAusente then
      begin
        ListaSLP.Add('Total de Objetos Outros   : ' + FormatFloat('##,##0;;', DM.qArqAR.RecordCount - DM.qAusente.RecordCount));
        ListaSLP.Add('Total de Objetos Ausentes : ' + FormatFloat('##,##0;;', DM.qAusente.RecordCount));
      end
    else
      begin
        ListaSLP.Add('Total de Objetos Outros   : ' + FormatFloat('##,##0;;', DM.qArqAR.RecordCount));
        ListaSLP.Add('Total de Objetos Ausentes : ' + FormatFloat('##,##0;;', 0));
      end;

    ListaSLP.Add(StringOfChar('-', 73));
    ListaSLP.Add('Código AR:');
    if bAusente then
      begin
        AssignFile(A, sRel +'ADDRESS2ACC.CARTAO.IBI.AR.'+ 'AUSR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TXT');
        Rewrite(A);
      end
    else
      begin
        AssignFile(A, sRel +'ADDRESS2ACC.CARTAO.IBI.AR.'+ 'OUTR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TXT');
        Rewrite(A);
      end;

    DM.qArqAR.First;
    sAusente := '';
    sCartao := '';
    iAux := 0;
    AssignFile(F, arqoutros);
    Rewrite(F);
    AssignFile(FA, arqausente);
    Rewrite(FA);

    while not DM.qArqAR.Eof do
      begin
        if not bAusente then
          s := DM.qArqARCOD_AR.AsString + DM.qArqARCD_MOTIVO.AsString + '005'
        else
          begin
            if DM.qArqARCD_MOTIVO.AsString = DM.qParamCD_MOTIVO.AsString then
              begin
                sAusente := DM.qArqARCOD_AR.AsString + DM.qArqARCD_MOTIVO.AsString + '005'; //FormatDateTime('ddmmyyyy', Trunc(DM.qArqARDATA.AsDateTime));
                s := '';
              end
            else
              begin
                s := DM.qArqARCOD_AR.AsString + DM.qArqARCD_MOTIVO.AsString+'005' ;//+ FormatDateTime('ddmmyyyy', Trunc(DM.qArqARDATA.AsDateTime));// '005';
                sAusente := '';
              end;
          end;

        if iAux < 5 then
          begin
            if iAux = 0 then
              begin
                sCartao := DM.qArqARCOD_AR.AsString;
                inc(iAux);
              end
            else
              begin
                if iAux <> 4 then
                  begin
                    sCartao := sCartao + '  ' + DM.qArqARCOD_AR.AsString;
                    inc(iAux);
                  end
                else
                  begin
                    sCartao := sCartao + '  ' + DM.qArqARCOD_AR.AsString;
                    ListaSLP.Add(sCartao);
                    iAux := 0;
                    sCartao := '';
                  end;
              end;
          end;

        if s <> '' then
          Writeln(F, s);

        if (sAusente <> '') then
          Writeln(FA, sAusente);

        DM.qArqAR.Next;
      end;

    ListaSLP.Add(sCartao);
    ListaSLP.Add(StringOfChar('-', 73));
    ListaSLP.Add(StringOfChar('-', 73));
    ListaSLP.Add(format('%-10.10s%',['©' + FormatDateTime('YYYY', DM.qdatadata.AsDateTime)])+format('%-44.44s%',['ADDRESS SA'])+ FormatDateTime('DD/MM/YYYY hh:nn',DM.qDatadata.AsDateTime));
    ListaSLP.SaveToFile(srel+'ADDRESS2ACC.CARTAO.IBI.AR.'+FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('hhnnss', DM.dtatu) + '.SLP');
    Application.ProcessMessages;
    CloseFile(F);
    CloseFile(FA);
    if bAusente then
      CloseFile(A);
  finally
    ListaSLP.Free;
  end;
end;

procedure TfrmAR.FormCreate(Sender: TObject);
begin
  DM.qMotivo.Close;
  DM.qMotivo.Open;
  DM.qData.Close;
  DM.qData.Open;
  cbDT_DEVOLUCAO.Date := DM.qDatadata.AsDateTime;
  DtDevFim.Date       := DM.qDatadata.AsDateTime;
  StringGridARsLidos.Cells[0,0] := '#';
  StringGridARsLidos.Cells[1,0] := 'Numero Objeto';
  StringGridARsLidos.Cells[2,0] := 'BIN';    
end;

procedure TfrmAR.FormShow(Sender: TObject);
begin
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('SELECT CURRENT_TIMESTAMP');
  dm.SqlAux.Open;
  cbDT_DEVOLUCAO.Date  :=  dm.SqlAux.Fields[0].AsDateTime;
end;

procedure TfrmAR.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (StringGridARsLidos.RowCount > 1) then
    if Application.MessageBox(pchar('A lista de ARs lidos não foi gravada! Deseja sair assim mesmo?'),
        'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = ID_NO then
        abort;
  CanClose := True;
end;

procedure TfrmAR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With DM do
    begin
      qMotivo.Close;
      qData.Close;
      qParam.Close;
      qAusente.Close;
      qAR.Close;
    end;
end;

procedure TfrmAR.eBinChange(Sender: TObject);
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
          btnSalvar.Enabled := true;
          BitBtnLimparLeituras.Enabled := true;
          r := StringGridARsLidos.RowCount;
          StringGridARsLidos.RowCount := StringGridARsLidos.RowCount + 1;
          StringGridARsLidos.Cells[0, r] := IntToStr(r);
          StringGridARsLidos.Cells[1, r] := edtCodigo.Text;
          StringGridARsLidos.Cells[2, r] := eBin.Text;
          StatusBarMessages.Panels.Items[1].Text := IntToStr(r);
          StatusBarMessages.Panels.Items[3].Text := edtCodigo.Text + ' | ' +
              eBin.Text;
          edtCodigo.Clear;
          eBin.Clear;
          edtCodigo.SetFocus;
        end
      else
        begin
          s := 'Este BIN não está cadastrado! Verifique a informação.' + #13#10 +
                'Caso esteja correto será necessário cadastrar a Família deste BIN';
          Application.MessageBox(
              PChar(s),
                'Controle de Devoluções - AR', MB_OK + MB_ICONWARNING);
          StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
          eBin.SetFocus;
        end;
    end;
end;

procedure TfrmAR.cbDT_DEVOLUCAOEnter(Sender: TObject);
begin
  With DM do
    begin
      SqlAux.Close;
      SqlAux.SQL.Clear;
      SqlAux.SQL.Add('SELECT CURRENT_TIMESTAMP');
      SqlAux.Open;
      cbDT_DEVOLUCAO.DateTime :=  SqlAux.Fields[0].AsDateTime;
    end;
end;

end.

