unit CDAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ComCtrls, ExtCtrls, OleServer, DB,
  ZAbstractRODataset, ZDataset; //ADODB;
//  ADODB;

type
  TfrmAR = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    pMsg: TPanel;
    gbxCartao: TGroupBox;
    edtCodigo: TEdit;
    cbDT_DEVOLUCAO: TDateTimePicker;
    lcCD_MOTIVO: TDBLookupComboBox;
    lblQtde: TLabel;
    gbxProcessamento: TGroupBox;
    btnSalvar: TBitBtn;
    btnArquivo: TBitBtn;
    btnFechar: TBitBtn;
    mmCodigo: TListBox;
    eBin: TEdit;
    lBin: TListBox;
    Label1: TLabel;
    Panel1: TPanel;
    qryFamilia: TZReadOnlyQuery;
    ListArq: TListBox;
    DtDevFim: TDateTimePicker;
    Label4: TLabel;
    qraRelatorioTOT: TZReadOnlyQuery;
    qraRelatorioQtde: TZReadOnlyQuery;
    procedure FormShow(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
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
    procedure mmCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eBinChange(Sender: TObject);
    procedure lBinKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure montarel;
  private
    { Private declarations }
    sCDMotivo,cSQL: string;
    ListaArq: TStringList;
    F, A,FA: TextFile;
    s, sAusente, sDir,arqausente,arqoutros, sDev,sRel: string;
    bAusente: Boolean;
    ListaSLP: TStringList;
    sCartao: string;
    iAux: integer;
    cFieldValue : Variant;
    cFieldName  : string;

    function GerarArquivo: boolean;

    procedure EnviarArquivo;
  public
    { Public declarations }
  end;

var
  frmAR: TfrmAR;
  qtdAR: Integer = 0;
implementation

uses CDDM, U_Func;

{$R *.dfm}

procedure TfrmAR.edtCodigoChange(Sender: TObject);

begin
  if length(trim(edtCodigo.Text)) = 13 then
  begin
    Panel1.Caption := '';
    Panel1.Refresh;
    if (validaNumObjCorreios(edtCodigo.Text) = true) then
      begin
        if mmCodigo.Items.IndexOf(edtCodigo.Text) = -1 then
          begin
            btnSalvar.Enabled := mmCodigo.Items.Count > 0;
            eBin.SetFocus;
            Inc(qtdAR);
          end
        else
          begin
            Panel1.Caption := 'Código AR já lido.';
            Panel1.Refresh;
            edtCodigo.Text := '';
            Panel1.SetFocus;
            edtCodigo.SetFocus;
            abort;
          end;
      end
    else
      begin
        Panel1.Caption := 'Código Inválido.';
        Panel1.Refresh;
        Panel1.SetFocus;
        abort;
      end;

    lblQtde.Caption := 'Quantidade de ARs lidos: ' + IntToStr(qtdAR);
    lblQtde.Caption := 'Quantidade de ARs lidos: ' + IntToStr(mmCodigo.Items.Count);
  end;

end;

procedure TfrmAR.edtCodigoEnter(Sender: TObject);
begin
  Case mmCodigo.Items.Count of
    1: frmAR.btnSalvarClick(self);
  end;
end;

procedure TfrmAR.btnSalvarClick(Sender: TObject);
var
  icod,iCont: integer;
  sMensagem: string;
begin
  if lcCD_MOTIVO.KeyValue = null then
  begin
    Application.MessageBox('Selecione o motivo.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    lcCD_MOTIVO.SetFocus;
    exit;
  end;
  DM.qCodAR.Close;
  DM.qCodAR.Open;
  iCod := DM.qCodARcodigo.AsInteger;

  DM.qAR.Close;
  DM.qAR.Open;

  DM.qData.Close;
  DM.qData.Open;

  try
//    DM.ADOConnection1.BeginTrans;
    for iCont := 0 to mmCodigo.Items.Count - 1 do
    begin
      sMensagem := '';
      DM.qBuscaAR.Close;
      DM.qBuscaAR.ParamByName('cartao').Value := mmCodigo.Items[icont];
      DM.qBuscaAR.ParamByName('data').Value := FormatDateTime('YYYYMMDD', DM.qDatadata.AsDateTime);
      DM.qBuscaAR.Open;

      if DM.qBuscaAR.IsEmpty then
      begin
        DM.SqlAux.Close;
        DM.SqlAux.SQL.Clear;
        DM.SqlAux.SQL.Add('insert into ibi_controle_devolucoes_ar (cod_ar,cd_motivo,codbin,codusu) values ');
        DM.SqlAux.SQL.Add('('+chr(39)+mmCodigo.Items[icont]+chr(39)+','+chr(39)+lcCD_MOTIVO.KeyValue+chr(39)+','+chr(39)+lBin.Items[icont]+chr(39)+','+IntToStr(DM.usuaces)+ ')');

        //InputBox('','',DM.SqlAux.SQL.Text);
        //DM.SqlAux.SQL.Add('(:cod,:motivo,:bin)');
        //DM.SqlAux.ParamByName('cod').AsString := mmCodigo.Items[icont];
        //DM.SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
        //DM.SqlAux.ParamByName('bin').AsString := lBin.Items[icont];
//        DM.SqlAux.ParamByName('data').AsString := FormatDateTime('YYYYMMDD', DM.qDatadata.Value );
//        DM.qARDT_DEVOLUCAO.AsDateTime := trunc(cbDT_DEVOLUCAO.Date);
//        DM.qARDT_CADASTRO.AsDateTime := DM.qDatadata.AsDateTime;
        DM.SqlAux.ExecSQL;
      end
      else
      begin
        //sMensagem := 'O cartão ' + mmCodigo.Items[icont] + ' já foi salvo com o motivo ' + DM.qBuscaARds_motivo.AsString + '. Deseja alterar o motivo?';
//        if Application.MessageBox(pchar(sMensagem), 'Aviso', MB_YESNO + MB_ICONWARNING + MB_SYSTEMMODAL) = id_yes then
  //      begin
          DM.ZQAux.Close;
          DM.ZQAux.SQL.Clear;
          DM.ZQAux.SQL.Add('update ibi_controle_devolucoes_ar set cd_motivo=:motivo where (nro_cartao=:cod) and (dt_cadastro=(select current_date))' );
          DM.ZQAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
          DM.ZQAux.ParamByName('cod').AsString    :=  mmCodigo.Items[icont];
//          DM.ZQAux.ParamByName('.AsDateTime := DM.qDatadata.AsDateTime;
//          DM.qBuscaAR.Post;
          DM.ZQAux.ExecSQL;
    //    end;
      end;

    end;
    mmCodigo.Items.Clear;
    lBin.Items.Clear;
    btnSalvar.Enabled := mmCodigo.Items.Count > 0;
    btnSalvar.Enabled := False;
    lblQtde.Caption := 'Quantidade de Cartões lidos: 0';
//    DM.ADOConnection1.CommitTrans;
    qtdAR := 0;
  except
//    DM.ADOConnection1.RollbackTrans;
    Application.MessageBox('Erro ao atualizar o banco de dados.', 'Aviso', MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
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
    if mmCodigo.Items.Count > 0 then
    begin
      if (sCDMotivo <> '') and (sCDMotivo <> lcCD_MOTIVO.KeyValue) then
      begin
        if Application.MessageBox('Existem leituras não salvas. Deseja alterar o motivo dessas leituras?', 'Aviso', MB_YESNO + MB_SYSTEMMODAL + MB_ICONWARNING) = id_no then
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
var
  nPos, nFieldSize,iObjetos: Integer;

begin
//  bCopia := False;
//  sMensagem := '';
//  with qraRelatorioQtde as TADOQuery do
  with qraRelatorioQtde do
  begin
    Close;
    SQL.Clear;

    cSQL := '';
    cSQL := cSQL + 'SELECT CD.CD_MOTIVO, MD.DS_MOTIVO, COUNT(*) AS QTDE FROM IBI_CONTROLE_DEVOLUCOES_AR CD, CEA_MOTIVOS_DEVOLUCOES MD ';
    cSQL := cSQL + 'WHERE CD.CD_MOTIVO = MD.CD_MOTIVO ';
    cSQL := cSQL + ' AND ';
    cSQL := cSQL + '(CD.DT_DEVOLUCAO BETWEEN '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_DEVOLUCAO.Date)+chr(39) ;
//    cSQL := cSQL + DtSQL_Ini(cbDT_INICIAL.Date);
//    cSQL := cSQL + ' AND ';
    cSQL := cSQL + ' and '+chr(39) + FormatDateTime('yyyy/mm/dd',DtDevFim.Date)+chr(39)+') ';
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
    cSQL := cSQL + 'SELECT COUNT(*) AS TOTAL FROM IBI_CONTROLE_DEVOLUCOES_AR ';
    cSQL := cSQL + 'WHERE (DT_DEVOLUCAO BETWEEN '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_DEVOLUCAO.Date)+chr(39);
//    cSQL := cSQL + DtSQL_Ini(cbDT_INICIAL.Date);
    cSQL := cSQL + ' AND '+chr(39)+FormatDateTime('yyyy/mm/dd',DtDevFim.Date)+chr(39)+') ';
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
    sRel := dm.unidade+ 'RELATORIOS\';;
//    cArq := cArq
    //cArq := cArq + FormatDateTime('YYYYMMDD', now)+ '\' ;

    if not DirectoryExists(sRel) then
       CreateDirectory(PAnsiChar(srel),nil);

    sRel := sRel + 'IBI_REL_'+FormatDateTime('ddmmyyyy',DM.qDatadata.AsDateTime)+FormatDateTime('hhmmss',Time) +'.txt';
//    cArq := cArq + StrTran(DateToStr(cbDT_INICIAL.Date), '/', '_');
//    cArq := cArq + '_A_';
//    cArq := cArq + StrTran(DateToStr(cbDT_FINAL.Date), '/', '_');
//    cArq := cArq + 'CEA_REL_'+FormatDateTime('ddmmyyyy',cbDT_FINAL.Date);
//    sRel := sRel + '.TXT';

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

//  if not bCopia  then
//  begin
    //sMensagem := 'Não foi possível copiar o(s) arquivo(s): ' + ExtractFileName(cArq);
    //Application.MessageBox(pchar(sMensagem),'Aviso',MB_OK+MB_ICONERROR+MB_SYSTEMMODAL)
//  end;

//  pMsg.Caption := 'Total de Objetos: ' + IntToStr(iObjetos);
//  pMsg.Refresh;
end;
procedure TfrmAR.btnArquivoClick(Sender: TObject);
begin
  DM.qArqAR.Close;
  DM.qArqAR.ParamByName('dt_devolucao').AsString  := FormatDateTime('yyyy/mm/dd',trunc(cbDT_DEVOLUCAO.Date));
  DM.qArqAR.ParamByName('dt_devfim').AsString     := FormatDateTime('yyyy/mm/dd',trunc(DtDevFim.Date));
///  DM.qArqAR.Parameters.ParamByName('dt_devolucao').Value := trunc(cbDT_DEVOLUCAO.Date);
  DM.qArqAR.Open;

  if not DM.qArqAR.IsEmpty then
  begin
    if GerarArquivo then
    begin
      //EnviarArquivo;
      Application.MessageBox('Arquivo gerado com sucesso.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
      ListArq.Items.Add(arqausente);
      ListArq.Items.Add(arqoutros);
      montarel;
    end;
  end
  else
  begin
    Application.MessageBox('Não existe devolução para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
  end;
end;

function TfrmAR.GerarArquivo: boolean;
begin
  Result := True;
  ListaArq := TStringList.Create;
  ListaSLP := TStringList.Create;
  sDir := 'F:\ibisis\Retorno\';//\Dev';
  //sDev := sDev +'\Dev'+FormatDateTime('YYYYMMDD', cbDT_DEVOLUCAO.Date) + '\';

  //sDir := sDir + sDev;
  try

    if not DirectoryExists(sDir) then
    begin
      CreateDirectory(PAnsiChar(sDir), nil);
    end;

    DM.qParam.Close;
    DM.qParam.Open;

    bAusente := False;
    if DM.qParamAUSENTE.AsString = 'S' then
    begin
      DM.qAusente.Close;
 //     DM.qAusente.Parameters.ParamByName('data').Value := FormatDateTime('YYYYMMDD', trunc(cbDT_DEVOLUCAO.Date));
//      DM.qAusente.Parameters.ParamByName('cd_motivo').Value := DM.qParamCD_MOTIVO.AsString;
      DM.qAusente.ParamByName('data').AsString := FormatDateTime('YYYYMMDD', trunc(cbDT_DEVOLUCAO.Date));
      DM.qAusente.ParamByName('cd_motivo').AsString := DM.qParamCD_MOTIVO.AsString;
      DM.qAusente.Open;

      if not DM.qAusente.IsEmpty then
        bAusente := True;
    end;
    //sDir := sDir + '/ADDRESS2ACC.CARTAO.IBI.AR.' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date)+FormatDateTime('HHMMSS',Time ) + '.TMP';
    //if FileExists(sDir ) then
    //begin
    //  if Application.MessageBox('O arquivo de retorno para a devolução selecionada já existe.Deseja continuar?', 'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = id_no then
    //  begin
    //    Result := False;
    //    exit;
    //  end;
    //end;
//    AssignFile(F, sDir);
//    Rewrite(F);
//    ListaArq.Add(sDir);
    sRel  :=  DM.unidade+'ibisis\RELATORIOS\';
    ListaSLP.Add(StringOfChar('-', 73));
    ListaSLP.Add('                       Devolução IBI - ARs                       ');
    ListaSLP.Add(StringOfChar('-', 73));
//    if bAusente then
//    begin
//      ListaSLP.Add('Arquivo Outros   :  ADDRESS2ACC.CARTAO.IBI.AR.'+ 'OUTR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TMP');
      ListaSLP.Add('Arquivo Ausente  :  ADDRESS2ACC.CARTAO.IBI.AR.'+ 'AUSR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TMP');
      arqausente:= sDir+'ADDRESS2ACC.CARTAO.IBI.AR.'+ 'AUSR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TMP';
//    end
//    else
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
//      ListaArq.Add('AUSR' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS',Time) + '.TMP');
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

          //sAusente := DM.qArqARCOD_AR.AsString + DM.qArqARCD_MOTIVO.AsString + '005'; //FormatDateTime('ddmmyyyy', Trunc(DM.qArqARDATA.AsDateTime));
          //s := '';

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
      if (sAusente <> '') then //and (bAusente) then
        Writeln(FA, sAusente);
//        Writeln(F, sAusente);

      DM.qArqAR.Next;
    end;
    {DM.qData.Close;
    DM.qData.Open; }
    ListaSLP.Add(sCartao);
    ListaSLP.Add(StringOfChar('-', 73));
//    ListaSLP.Add('©' + FormatDateTime('YYYY', DM.qdatadata.AsDateTime) + ' ADDRESS SA ' + '               ' + FormatDateTime('DD/MM/YYYY',DM.qDatadata.AsDateTime)+ ' - '+ DM.hratu);
    ListaSLP.Add(StringOfChar('-', 73));
    ListaSLP.Add(format('%-10.10s%',['©' + FormatDateTime('YYYY', DM.qdatadata.AsDateTime)])+format('%-44.44s%',['ADDRESS SA'])+ FormatDateTime('DD/MM/YYYY',DM.qDatadata.AsDateTime)+ ' ' +dm.hratu);
//    ListaSLP.SaveToFile('F:\ibisis\RELATORIO\'+ 'ADDRESS2ACC.CARTAO.IBI.AR.'+FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('HHMMSS', DM.qDatadata.AsDateTime) + '_AR.SLP');
    ListaSLP.SaveToFile(srel+'ADDRESS2ACC.CARTAO.IBI.AR.'+FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + FormatDateTime('hhmmss', StrToDateTime(DM.hratu)) + '.SLP');
//    ListaSLP.SaveToFile(sdir + FormatDateTime('DDMM', cbDT_DEVOLUCAO.Date) + '_AR.SLP');

    //    pMsg.Caption := 'Aguarde. Enviando e-mail.';
    Application.ProcessMessages;
//    DM.EnviarEmail(1, ExtractFilePath(Application.ExeName) + 'Slip\Dev' + FormatDateTime('DDMM', cbDT_DEVOLUCAO.Date) + '_AR.SLP');
    //pMsg.Caption := '';}
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
end;

procedure TfrmAR.FormShow(Sender: TObject);
begin
  dm.SqlAux.Connection  :=  dm.CtrlDvlDBConn;
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date,localtime(0)');
  dm.SqlAux.Open;
  self.cbDT_DEVOLUCAO.Date  :=  dm.SqlAux.Fields[0].AsDateTime;

end;

procedure TfrmAR.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if mmCodigo.Items.Count > 0 then
  begin
//    if Application.MessageBox('Existe devolução não salva. As informações serão perdidas. Deseja continuar?', 'Aviso', MB_YESNO + MB_ICONWARNING + MB_SYSTEMMODAL) = id_no then
      frmAR.btnSalvarClick(self);
//      CanClose := False;
  end;
end;

procedure TfrmAR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if mmCodigo.Items.Count>0 then
    btnSalvarClick(self);
  DM.qMotivo.Close;
  DM.qData.Close;
  DM.qParam.Close;
  DM.qAusente.Close;
  DM.qAR.Close;

end;

procedure TfrmAR.mmCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sMensagem: string;
  iInd: integer;
begin
  if key = vk_delete then
  begin

    iInd := mmCodigo.ItemIndex;
    sMensagem := 'Confirma a execlusão do Código AR ' + mmCodigo.Items[iInd] + '?';
    if Application.MessageBox(pchar(sMensagem), 'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = id_yes then
    begin
      mmCodigo.Items.Delete(iInd);
      lBin.Items.Delete(iInd);
    end;
    btnSalvar.Enabled := mmCodigo.Items.Count > 0;
    qtdAR := qtdAR - 1;
    case mmCodigo.Items.Count of
      10  : frmAR.btnSalvarClick(self);
    end;
    lblQtde.Caption := 'Quantidade de ARs lidos: ' + IntToStr(qtdAR);

  end;
end;

procedure TfrmAR.EnviarArquivo;
var
  j: integer;
  sDir, sDev, sMensagem: string;
  bCopia: boolean;
  Lista: TStringList;
begin
  Lista := TStringList.Create;
  sDir := ExtractFilePath(Application.ExeName) + 'F:\ibisis\Retorno\Dev';
  sDev := FormatDateTime('YYYYMMDD', cbDT_DEVOLUCAO.Date) + '\';

  sDir := sDir + sDev;
  for j := 0 to ListaArq.Count - 1 do
  begin
    if FileExists('\\192.168.11.10\cartoes\' + ListaArq[j]) then
      DeleteFile('\\192.168.11.10\cartoes\' + ListaArq[j]);
    if pos('AUSR', ListaArq[j]) = 0 then
      bCopia := CopyFile(pchar(sdir + ListaArq[j]), pchar('\\192.168.11.10\cartoes\outros\' + ListaArq[j]), false)
//      bCopia := CopyFile(pchar(sdir + ListaArq[j]), pchar(ListaArq[j]), false)
    else
      bCopia := CopyFile(pchar(sdir + ListaArq[j]), pchar('\\192.168.11.10\cartoes\ausentes\' + ListaArq[j]), false);
//      bCopia := CopyFile(pchar(sdir + ListaArq[j]), pchar(ListaArq[j]), false);
    if not bCopia then
      Lista.Add(ListaArq[j]);
  end;

  if Lista.Count > 0 then
  begin
    sMensagem := 'Não foi possível copiar o(s) arquivo(s):';
    for j := 0 to Lista.Count - 1 do
      sMensagem := sMensagem + '#10#13' + Lista[j];
    Application.MessageBox(pchar(sMensagem), 'Aviso', MB_OK + MB_ICONERROR + MB_SYSTEMMODAL)
  end;

  Lista.Free;
  ListaArq.Free;
end;

procedure TfrmAR.eBinChange(Sender: TObject);

begin
  if (length(trim(eBin.Text)) = 6) or (length(trim(eBin.Text)) = 5) then
  begin
    Panel1.Caption := '';
    Panel1.Refresh;
    qryFamilia.Close;
//    qryFamilia.Parameters.ParamByName('COD_BIN').Value := eBin.Text;
    if (length(trim(eBin.Text)) = 5) and (trim(eBin.Text)='52743') then
      eBin.Text :=  eBin.Text+'7'
    else if (length(trim(eBin.Text)) = 5) and (trim(eBin.Text)='51854') then
      eBin.Text :=  eBin.Text+'4'
    else if (length(trim(eBin.Text)) = 5) and (trim(eBin.Text)='53133') then
      eBin.Text :=  eBin.Text+'9';

    qryFamilia.ParamByName('COD_BIN').AsString := eBin.Text;
    qryFamilia.Open;

    if qryFamilia.RecordCount > 0 then
    begin
      mmCodigo.Items.Add(edtCodigo.Text);
      lBin.Items.Add(eBin.Text);
      edtCodigo.Text := '';
      eBin.Text := '';
      edtCodigo.SetFocus;
      if lBin.Items.Count > 0 then
        btnSalvar.Enabled := true;
    end
    else
    begin
      ShowMessage('Codigo BIN inválido ignorando AR');
      edtCodigo.Text := '';
      eBin.Text := '';
      edtCodigo.SetFocus;
    end;
  end;
end;

procedure TfrmAR.lBinKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sMensagem: string;
  iInd: integer;
begin
  if key = vk_delete then
  begin
    iInd := lBin.ItemIndex;
    sMensagem := 'Confirma a execlusão do Código AR ' + mmCodigo.Items[iInd] + '?';
    if Application.MessageBox(pchar(sMensagem), 'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = id_yes then
      lBin.Items.Delete(iInd);
    btnSalvar.Enabled := lBin.Items.Count > 0;
  end;

end;

procedure TfrmAR.cbDT_DEVOLUCAOEnter(Sender: TObject);
begin
  dm.SqlAux.Connection  :=  dm.CtrlDvlDBConn;
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date');
  dm.SqlAux.Open;
  cbDT_DEVOLUCAO.DateTime :=  dm.SqlAux.Fields[0].AsDateTime;

end;

end.

