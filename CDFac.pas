unit CDFac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, ComCtrls, Buttons, DB, //ADODB,
  ZAbstractRODataset, ZDataset;

type
  TfrmCartao = class(TForm)
    pMsg: TPanel;
    gbxCartao: TGroupBox;
    Label2: TLabel;
    cbDT_DEVOLUCAO: TDateTimePicker;
    lcCD_MOTIVO: TDBLookupComboBox;
    Label3: TLabel;
    edtCartao: TEdit;
    mmCartoes: TMemo;
    Timer1: TTimer;
    lblQtde: TLabel;
    gbxProcessamento: TGroupBox;
    btnSalvar: TBitBtn;
    btnArquivo: TBitBtn;
    btnFechar: TBitBtn;
    Panel1: TPanel;
    mmCodBin: TMemo;
    edtBIN: TEdit;
    Label1: TLabel;
    qryFamilia: TZReadOnlyQuery;
    Edarq: TEdit;
    DTPFinal: TDateTimePicker;
    Label4: TLabel;
    FacRelQtde: TZReadOnlyQuery;
    FacRelTot: TZReadOnlyQuery;
    procedure edtCartaoEnter(Sender: TObject);
    procedure cbDT_DEVOLUCAOEnter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edtCartaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcCD_MOTIVOClick(Sender: TObject);
    procedure mmCartoesEnter(Sender: TObject);
    procedure lcCD_MOTIVOExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure mmCartoesChange(Sender: TObject);
    procedure btnArquivoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtBINChange(Sender: TObject);
    procedure montarel;
  private
    { Private declarations }
    s, sLinha1, sLinha2, sLinha3, sCDMotivo: string;
    k, i: integer;
    F,FA: TextFile;
    tarj : TextFile;
    mDir,sDir, sDev,srel,arqausente: string;
    ListaSLP: TStringList;
    sCartao,cSQL: string;
    ListaArq: TStringList;
    flqsalva,bAusente: Boolean;
    cFieldValue : Variant;
    cFieldName  : string;
    //nomarq  :

    function GerarArquivo: boolean;
    procedure EnviarArquivo;
    procedure lerBIN;
  public
    { Public declarations }
  end;

var
  frmCartao: TfrmCartao;
  ScartaoLido: string;

implementation
uses CDDM;//, Base;

{$R *.dfm}

procedure TfrmCartao.FormCreate(Sender: TObject);
begin
  DM.qMotivo.Close;
  DM.qMotivo.Open;
  DM.qData.Close;
  DM.qData.Open;
  cbDT_DEVOLUCAO.Date := DM.qDatadata.AsDateTime;
  i := 1;
  dm.SqlAux.Connection  :=  dm.ADOConnection1;
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
  if mmCartoes.Lines.Count>0 then
      btnSalvarClick(self);
  DM.qMotivo.Close;
  DM.qData.Close;
  DM.qFac.Close;
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

procedure TfrmCartao.mmCartoesEnter(Sender: TObject);
begin
  edtCartao.SetFocus;
end;

procedure TfrmCartao.lcCD_MOTIVOExit(Sender: TObject);
begin
  if lcCD_MOTIVO.KeyValue <> null then
  begin
    if mmCartoes.Lines.Count > 0 then
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
      edtCartao.SetFocus;
    end;
  end;
end;

procedure TfrmCartao.btnSalvarClick(Sender: TObject);
var
  iCod, iCont: integer;
  sMensagem: string;
begin
  if lcCD_MOTIVO.KeyValue = null then
  begin
    Application.MessageBox('Selecione o motivo.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    lcCD_MOTIVO.SetFocus;
    exit;
  end;
  DM.qCodFac.Close;
  DM.qCodFac.Open;
  iCod := DM.qCodFaccodigo.AsInteger;
  try

  DM.qFac.Close;
  DM.qFac.Open;

  DM.qData.Close;
  DM.qData.Open;

    //DM.ADOConnection1. //.BeginTrans;
    for iCont := 0 to mmCartoes.Lines.Count - 1 do
    begin
      sMensagem := '';
      DM.qBuscaFAC.Close;
      DM.qBuscaFAC.ParamByName('cartao').Value := mmCartoes.Lines[icont];
      DM.qBuscaFAC.ParamByName('data').Value := FormatDateTime('YYYYMMDD', trunc(cbDT_DEVOLUCAO.Date));
      DM.qBuscaFAC.Open;

      if DM.qBuscaFAC.IsEmpty then
      begin
        DM.SqlAux.Close;
        DM.SqlAux.SQL.Clear;
        DM.SqlAux.SQL.Add('insert into ibi_controle_devolucoes_fac (nro_cartao,cd_motivo,codbin,codusu) values ');
        DM.SqlAux.SQL.Add('('+chr(39)+mmCartoes.Lines[icont]+chr(39)+','+chr(39)+lcCD_MOTIVO.KeyValue+chr(39)+','+chr(39)+mmCodBin.Lines[icont]+chr(39)+','+IntToStr(DM.usuaces)+ ')');
//        InputBox('','',DM.SqlAux.SQL.Text);
        //DM.SqlAux.SQL.Add('(:cod,:motivo,:bin)');
        //DM.SqlAux.ParamByName('cod').AsString := mmCodigo.Items[icont];
        //DM.SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
        //DM.SqlAux.ParamByName('bin').AsString := lBin.Items[icont];
//        DM.SqlAux.ParamByName('data').AsString := FormatDateTime('YYYYMMDD', DM.qDatadata.Value );
//        DM.qARDT_DEVOLUCAO.AsDateTime := trunc(cbDT_DEVOLUCAO.Date);
//        DM.qARDT_CADASTRO.AsDateTime := DM.qDatadata.AsDateTime;
        DM.SqlAux.ExecSQL;

        {DM.qFac.Append;
        DM.qFacID.AsInteger := iCod;
        DM.qFacNRO_CARTAO.AsString := mmCartoes.Lines[icont];
        DM.qFacCODBIN.AsString := mmCodBin.Lines[icont];
        DM.qFacCD_MOTIVO.AsString := lcCD_MOTIVO.KeyValue;
        DM.qFacDATA.AsString := FormatDateTime('YYYYMMDD', DM.qDatadata.AsDateTime);
        DM.qFacDT_DEVOLUCAO.AsDateTime := trunc(cbDT_DEVOLUCAO.Date);
        DM.qFacDT_CADASTRO.AsDateTime := DM.qDatadata.AsDateTime;
        DM.qFac.Post;
        inc(iCod);}
      end
      else
      begin
//        sMensagem := 'O cartão ' + mmCartoes.Lines[icont] + ' já foi salvo com o motivo ' + DM.qBuscaFACds_motivo.AsString + '. Deseja alterar o motivo?';
//        if Application.MessageBox(pchar(sMensagem), 'Aviso', MB_YESNO + MB_ICONWARNING + MB_SYSTEMMODAL) = id_yes then
//        begin
          DM.ZQAux.Close;
          DM.ZQAux.SQL.Clear;
          DM.ZQAux.SQL.Add('update ibi_controle_devolucoes_fac set cd_motivo=:motivo where (nro_cartao=:cod) and (dt_cadastro=(select current_date))' );
          DM.ZQAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
          DM.ZQAux.ParamByName('cod').AsString    :=  mmCartoes.Lines[icont];
//          DM.ZQAux.ParamByName('.AsDateTime := DM.qDatadata.AsDateTime;
//          DM.qBuscaAR.Post;
          DM.ZQAux.ExecSQL;

//          DM.qBuscaFAC.Edit;
//          DM.qBuscaFACCD_MOTIVO.AsString := lcCD_MOTIVO.KeyValue;
//          DM.qBuscaFAC.Post;
//        end;
      end;

    end;
    mmCartoes.Lines.Clear;
    mmCodBin.Clear;
    btnSalvar.Enabled := False;
    lblQtde.Caption := 'Quantidade de Cartões lidos: 0';
    //DM.ADOConnection1.CommitTrans;
  except
//    DM.ADOConnection1.RollbackTrans;
    Application.MessageBox('Erro ao atualizar o banco de dados.', 'Aviso', MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
  end;
end;

procedure TfrmCartao.cbDT_DEVOLUCAOEnter(Sender: TObject);
begin
  dm.SqlAux.Connection  :=  dm.ADOConnection1;
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date');
  dm.SqlAux.Open;
  cbDT_DEVOLUCAO.DateTime :=  dm.SqlAux.Fields[0].AsDateTime;

end;

procedure TfrmCartao.mmCartoesChange(Sender: TObject);
begin
  btnSalvar.Enabled := mmCartoes.Lines.Count > 0;
  case mmCartoes.Lines.Count of
    10  : frmCartao.btnSalvarClick(self);
  end;

end;
Procedure TfrmCartao.montarel;
var
  nPos, nFieldSize,iObjetos: Integer;

begin
//  bCopia := False;
//  sMensagem := '';
//  with qraRelatorioQtde as TADOQuery do
  with FacRelQtde do
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
    cSQL := cSQL + ' and '+chr(39) + FormatDateTime('yyyy/mm/dd',DTPFinal.Date)+chr(39)+') ';
    cSQL := cSQL + 'GROUP BY CD.CD_MOTIVO, MD.DS_MOTIVO ';
    cSQL := cSQL + 'ORDER BY CD.CD_MOTIVO';
//    inputbox('','',cSQL);

    SQL.Add(cSQL);
    Open;
  end;

//  with qraRelatorioTOT as TADOQuery do
  with FacRelTot do
  begin
    Close;
    SQL.Clear;
    cSQL := '';
    cSQL := cSQL + 'SELECT COUNT(*) AS TOTAL FROM IBI_CONTROLE_DEVOLUCOES_AR ';
    cSQL := cSQL + 'WHERE (DT_DEVOLUCAO BETWEEN '+chr(39)+FormatDateTime('yyyy/mm/dd',cbDT_DEVOLUCAO.Date)+chr(39);
//    cSQL := cSQL + DtSQL_Ini(cbDT_INICIAL.Date);
    cSQL := cSQL + ' AND '+chr(39)+FormatDateTime('yyyy/mm/dd',DTPFinal.Date)+chr(39)+') ';
//    cSQL := cSQL + DtSQL_Fim(cbDT_FINAL.Date)+;
    SQL.Add(cSQL);
    Open;
  end;

  if FacRelQtde.IsEmpty then
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
    WriteLn(F, format('%-51.51s%',[' ADDRESS SA -  IBI CARTÕES FAC'])+format('%-10.10s%',['PAGINA: 01']));
    WriteLn(F, '');
    WriteLn(F, ' PROCESSAMENTO DE: ' + DateToStr(cbDT_DEVOLUCAO.Date) + ' À ' + DateToStr(DTPFinal.Date));
    WriteLn(F, '');
    WriteLn(F, '                  RESUMO DO CONTROLE DE DEVOLUCOES');
    WriteLn(F, ' ____________________________________________________________');
    WriteLn(F, format('%-57.57s%',[' CODIGO DESCRICAO'])+format('%-04.04s%',['QTDE']));
    WriteLn(F, format('%7.7s%',['------'])+ StringOfChar('-',49)+format('%5.5s%',['----']));

    while not FacRelQtde.Eof do
    begin
      S := ' ';
      for nPos := 0 to (FacRelQtde.FieldCount - 1) do
      begin
        cFieldValue := FacRelQtde.FieldByName(FacRelQtde.Fields[nPos].FieldName).AsString;
        cFieldName := FacRelQtde.Fields[nPos].FieldName;
        nFieldSize := FacRelQtde.Fields[nPos].Size;

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
    begin
      MessageDlg(Msg.Message, mtInformation, [mbOK], 0)
    end;
  end;
  CloseFile(F);

  if FacRelQtde.RecordCount > 0 then
    //bCopia:= CopyFile(pchar(cArq),pchar('\\192.168.11.10\CEA_ret\'+ExtractFileName(cArq)),false);

//  if not bCopia  then
//  begin
    //sMensagem := 'Não foi possível copiar o(s) arquivo(s): ' + ExtractFileName(cArq);
    //Application.MessageBox(pchar(sMensagem),'Aviso',MB_OK+MB_ICONERROR+MB_SYSTEMMODAL)
//  end;

//  pMsg.Caption := 'Total de Objetos: ' + IntToStr(iObjetos);
//  pMsg.Refresh;
end;

procedure TfrmCartao.btnArquivoClick(Sender: TObject);
begin
  DM.qArqFac.Close;
  DM.qArqFac.Params[0].AsString  := FormatDateTime('mm/dd/yyyy',trunc(cbDT_DEVOLUCAO.Date));
  DM.qArqFac.Params[1].AsString  := FormatDateTime('mm/dd/yyyy',trunc(cbDT_DEVOLUCAO.Date));
//  DM.qArqFac.ParamByName('dt_devolucao').AsString := FormatDateTime('mm/dd/yyyy',cbDT_DEVOLUCAO.Date);
  DM.qArqFac.Open;

  if not DM.qArqFac.IsEmpty then
  begin
    if GerarArquivo then
    begin
      //EnviarArquivo;
      montarel;
      Application.MessageBox('Arquivo gerado com sucesso.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
    end;
  end
  else
  begin
    Application.MessageBox('Não existe devolução para a data selecionada.', 'Aviso', MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
  end;
end;

function TfrmCartao.GerarArquivo: boolean;
var
  iAux: integer;
begin
  Result := True;
  ListaArq := TStringList.Create;
  ListaSLP := TStringList.Create;
  sDir  :=  'F:\ibisis\retorno\';
  if (not(DirectoryExists(SDir))) then
    MkDir(sDir);
//  sDir  :=  sDir+'\cartao';
 // if (not(DirectoryExists(sDir))) then
  //  MkDir(sDir);

//  sDir := ExtractFilePath(Application.ExeName) +  mDir
  // '\Dev';
 // sDev := + '\'+FormatDateTime('YYYYMMDD', cbDT_DEVOLUCAO.Date);

 // sDir := sDir + sDev;
  //try
  //  if not DirectoryExists(sDir) then
  //  begin
  //    CreateDirectory(PAnsiChar(sDir), nil);
  //  end;
//    sDir  :=   sDir+'\TARJ' + FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date);// + '.TXT';
    Edarq.Text  :=  sDir+'ADDRESS2ACC.CARTAO.IBI.FAC.' + FormatDateTime('DDMMYYYY.', dm.dtatu) + FormatDateTime('hhmmss',Time) +'.TMP';
    arqausente  :=  sDir+'ADDRESS2ACC.CARTAOA.USR.IBI.FAC.' + FormatDateTime('DDMMYYYY.', dm.dtatu) + FormatDateTime('hhmmss',Time) +'.TMP';
    sRel  :=  DM.unidade+'ibisis\RELATORIOS\ADDRESS2ACC.CARTAO.IBI.FAC.'+FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date)+ '.SLP';
    AssignFile(FA, arqausente);
    Rewrite(FA);

//    if Not(FileExists(sDir)) then
//      MkDir(Edarq.Text);
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
 //     DM.qAusente.Parameters.ParamByName('data').Value := FormatDateTime('YYYYMMDD', trunc(cbDT_DEVOLUCAO.Date));
//      DM.qAusente.Parameters.ParamByName('cd_motivo').Value := DM.qParamCD_MOTIVO.AsString;
      DM.ZqAusFac.ParamByName('data').AsString := FormatDateTime('YYYYMMDD', trunc(cbDT_DEVOLUCAO.Date));
      DM.ZqAusFac.ParamByName('cd_motivo').AsString := DM.qParamCD_MOTIVO.AsString;
      DM.ZqAusFac.Open;

      if not DM.ZqAusFac.IsEmpty then
        bAusente := True;
    end;

//    sDir  :=  ;
//    ListaArq.Add('F:\ibisis\Relatorio\SLIP.CARTAO.IBI.FAC.'+FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + '.TMP');
    ListaSLP.Add(StringOfChar('-', 88));
    ListaSLP.Add('                       Devolução IBI - Cartões - FAC                      ');
    ListaSLP.Add(StringOfChar('-', 88));
    //F:\IBISIS\RETORNO\XXX

    ListaSLP.Add('Arquivo          : '+'ADDRESS2ACC.CARTAO.IBI.FAC'+copy(Edarq.Text,length(Edarq.Text)-(18+1),length(Edarq.Text)-18));
    //Edarq.Text);//+ copy(Edarq.Text,30,length(Edarq.Text)-29));

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
//    lblQtde.Caption := 'Qtde: '+ IntToStr(DM.qArqFac.RecordCount);
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
    +   format('%-57.57s%',['ADDRESS SA'])+ FormatDateTime('DD/MM/YYYY',DM.qDatadata.AsDateTime)+ ' - '+dm.hratu);
//    +   format('%-56.56s%',['ADDRESS SA'])+ FormatDateTime('DD/MM/YYYY',DM.qDatadata.AsDateTime)+ ' - HH:MM:SS',dm.hratu));

//    ListaSLP.Add('© ' + FormatDateTime('YYYY', DM.qdatadata.AsDateTime) + format('%-20.20s%',['ADDRESS SA'])+FormatDateTime('DD/MM/YYYY', DM.qDatadata.AsDateTime)+' - '+ dm.hratu);
    //;;sdir  :=
//    sdir  :=  copy(sdir,1,length(sdir)-7)+'\Slip';
 //   if (not(DirectoryExists(sdir)))  then
  //    MkDir(sdir);
  //  sdir  :=  sdir;
  //  Edarq.Text  :=  sdir+'Dev' + 'Slip'+FormatDateTime('DDMMYYYY', cbDT_DEVOLUCAO.Date) + '.TMP';
    ListaSLP.SaveToFile(sRel);
//    +FormatDateTime('HHMMSS',dm.SqlAux.Fields[1].AsDateTime)  + '.SLP');
    //pMsg.Caption := 'Aguarde. Enviando e-mail.';
    Application.ProcessMessages;
//    DM.EnviarEmail(0, ExtractFilePath(Application.ExeName) + 'Slip\Dev' + FormatDateTime('DDMM', cbDT_DEVOLUCAO.Date) + '_TARJA.SLP');
    pMsg.Caption := '';
    CloseFile(F);
  //finally
    ListaSLP.Free;
  //end;

end;

procedure TfrmCartao.btnFecharClick(Sender: TObject);
begin
    close;
end;

procedure TfrmCartao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  if mmCartoes.Lines.Count > 0 then
  begin
    if Application.MessageBox('Existe devolução não salva. As informações serão perdidas. Deseja continuar?', 'Aviso', MB_YESNO + MB_ICONWARNING + MB_SYSTEMMODAL) = id_no then
      CanClose := False;
  end;
end;

procedure TfrmCartao.EnviarArquivo;
var
  j: integer;
  sDir, sDev, sMensagem: string;
  bCopia: boolean;
  Lista: TStringList;
begin
  Lista := TStringList.Create;
  sDir := 'F:\ibisis\retorno\dev';
  if Not(DirectoryExists(sDir))   then
    MkDir(sDir);
  sDir  :=  sDir+'\cartao';
  if Not(DirectoryExists(sDir))   then
    MkDir(sDir );
  sDev := sDev+'\ADDRESS2ACC.CARTAO.IBI.'+FormatDateTime('yymmdddd.', cbDT_DEVOLUCAO.Date) + FormatDateTime('hhmmss',Time)+'.TMP';

  //sDir := sDir + sDev;
{  for j := 0 to ListaArq.Count - 1 do
  begin
    if FileExists('F:\ibisis\cartoes\' + ListaArq[j]) then
      DeleteFile('F:\ibisis\cartoes\' + ListaArq[j]);
    bCopia := CopyFile(pchar(sdir + ListaArq[j]), pchar('F:\ibisis\cartoes\' + ListaArq[j]), false);
    bCopia := CopyFile(pchar(sdir + ListaArq[j]), pchar(ListaArq[j]), false);
    if not bCopia then
      Lista.Add(ListaArq[j]);
  end;}

  {if Lista.Count > 0 then
  begin
    sMensagem := 'Não foi possível copiar o(s) arquivo(s):';
    for j := 0 to Lista.Count - 1 do
      sMensagem := sMensagem + '#10#13' + Lista[j];
    Application.MessageBox(pchar(sMensagem), 'Aviso', MB_OK + MB_ICONERROR + MB_SYSTEMMODAL)
  end;
  Lista.Free;
  ListaArq.Free;}
end;

procedure TfrmCartao.lerBIN;
begin
  edtBIN.SetFocus;

end;

procedure TfrmCartao.edtBINChange(Sender: TObject);

begin
  if Length(edtBIN.Text) = 6 then
  begin
  { valida bin}

    qryFamilia.Close;
    qryFamilia.ParamByName('COD_BIN').Value := edtBIN.Text;
    qryFamilia.Open;

    if qryFamilia.RecordCount > 0 then
    begin
      if flqsalva=False then
        flqsalva:=True;
      mmCodBin.Lines.Add(edtBIN.Text);
      edtBIN.Text := '';
      edtCartao.Text := '';
      //k :=  k+1;
      lblQtde.Caption := 'Quantidade de Cartões lidos: ' + IntToStr(k);
      edtCartao.SetFocus;
    end
    else
    begin
      mmCartoes.Lines.Delete(mmCartoes.Lines.IndexOf(ScartaoLido));
      ShowMessage('Código BIN Inválido');
      edtBIN.Text := '';
      edtCartao.Text := '';
      edtCartao.SetFocus;
      k:= k -1;
      lblQtde.Caption := 'Quantidade de Cartões lidos: ' + IntToStr(k);
    end;

  end;
end;

procedure TfrmCartao.edtCartaoEnter(Sender: TObject);
begin
  case  mmCodBin.Lines.Count of
    1:  frmCartao.btnSalvarClick(self);
  end;

end;

procedure TfrmCartao.edtCartaoKeyPress(Sender: TObject; var Key: Char);
begin
  Timer1.Enabled := False;
  pMsg.Caption := 'Lendo informações do Cartão';
  pMsg.Font.Color := clRed;
  try
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
var
  j: integer;
  scartao: string;

  bValida: boolean;
begin

  pMsg.Caption := 'Aguardando leitura do Cartão Magnético';
  pMsg.Font.Color := clBlue;
  if (sLinha1 <> '') then
  begin
    bValida := True;
    scartao := copy(sLinha1, 3, 16);

    for j := 1 to length(scartao) do
    begin
      if not (scartao[j] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
        bValida := False;
    end;

    if bValida then
      if length(trim(scartao)) <> 16 then
        bValida := False;
    if bValida then
    begin
      if mmCartoes.Lines.IndexOf(scartao) = -1 then
      begin
        k := k + 1;
        Panel1.Caption := '';
        Panel1.Refresh;
        mmCartoes.Lines.Add(scartao);
        sCartaoLido := scartao;
        edtBIN.Text :=  copy(scartao,1,6);
        //lerBIN;
      end
      else
      begin
        Timer1.Enabled := False;
        //Application.MessageBox('Cartão já incluído na lista.', 'Aviso', MB_OK + MB_SYSTEMMODAL + MB_ICONWARNING);
        edtCartao.Text := '';
        Timer1.Enabled := True;
      end;
    end
    else
    begin
      pMsg.Caption := 'Cartão inválido';
      pMsg.Font.Color := clRed;
    end;
    lblQtde.Caption := 'Quantidade de Cartões lidos: ' + IntToStr(k);
    lblQtde.Caption := 'Quantidade de Cartões lidos: ' + IntToStr(mmCartoes.Lines.Count);
    i := 1;
    sLinha1 := '';
    sLinha2 := '';
    sLinha3 := '';
    s := '';
  end;
end;


end.

