unit uGeraArqDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, DBCtrls, FileCtrl;

type
  TfGeraArqDev = class(TForm)
    group: TGroupBox;
    cbdtini: TDateTimePicker;
    lbldata: TLabel;
    Status: TStatusBar;
    panelBarra: TPanel;
    ProgressBar: TProgressBar;
    btnGerar: TBitBtn;
    TB_AUX: TZQuery;
    cbdtfim: TDateTimePicker;
    lblPlanilha: TLabel;
    cbgrupo: TComboBox;
    Label1: TLabel;
    LblProduto: TLabel;
    lcCD_SERVICO: TDBLookupComboBox;
    procedure lcCD_SERVICOClick(Sender: TObject);
    procedure lcCD_SERVICOKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    grupoId : Integer;
    familia : Boolean;

    Function GerarArquivo_FAC(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;
    Function GerarArquivo_OUT(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;
    Function GerarArquivo_FACFat(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;

    Function MontarFiltroGrupoBIN(grupo : integer; semFamilia : Boolean) : String;

    procedure AtivaDemaisCampos;
  public
    { Public declarations }
  end;

var
  fGeraArqDev: TfGeraArqDev;

implementation

uses CDDM;

{$R *.dfm}


Function TfGeraArqDev.MontarFiltroGrupoBIN(grupo : integer; semFamilia : Boolean) : String;
begin
  try
    if semFamilia then
      begin
        Result := ' NOT IN(SELECT DISTINCT F.CODBIN FROM GRUPO_FAMILIA G JOIN IBI_CADASTRO_FAMILIA F ON F.ID = G.ID_FAMILIA WHERE G.ID_GRUPO <> '+IntToStr(grupo)+')';
      end
    else
      begin
        Result := ' IN(SELECT DISTINCT F.CODBIN FROM GRUPO_FAMILIA G JOIN IBI_CADASTRO_FAMILIA F ON F.ID = G.ID_FAMILIA WHERE G.ID_GRUPO = '+IntToStr(grupo)+')';
      end;
  except
    on E: Exception do
    begin
      
    end;
  end;
end;

procedure TfGeraArqDev.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I : Integer;
begin
  if panelBarra.Visible then
  begin
    Action := caNone;
    Exit;
  end;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Trim(UpperCase(Self.Components[I].ClassName)) = 'TZQUERY' then
    begin
      try
        TZQuery(Self.Components[I]).Close;
      except on E: Exception do
      end;
    end;
  end;
end;

procedure TfGeraArqDev.FormCreate(Sender: TObject);
var
  query : TZQuery;
  semFamilia : String;
begin
  cbdtini.Date := Now;
  cbdtfim.Date := Now;
  DM.qraServicos.Open;
  cbgrupo.Items.Clear;

  query := TB_AUX;
  query.Close;
  query.SQL.Clear;
  query.Params.Clear;
  query.SQL.Add('SELECT * FROM GRUPO ORDER BY ID');
  query.Open;
  if query.RecordCount <= 0 then
    Exit;

  while not query.Eof do
    begin
      if query.FieldByName('semfamilia').AsBoolean then
        semFamilia := 'S'
      else
        semFamilia := 'N';

      cbgrupo.Items.Add(FormatCurr('000', query.FieldByName('ID').AsInteger)+' - '+semFamilia+' - '+query.FieldByName('DESCRICAO').AsString);
      query.Next;
    end;

end;

Function TfGeraArqDev.GerarArquivo_FAC(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;
var
  xArqVirtual : String;
begin
  try
    Query.Close;
    Query.SQL.Clear;
    Query.Params.Clear;
    Query.SQL.Add('SELECT (DV.nro_cartao || ''005'' || DV.cd_motivo || ' +
                'to_char(DV.dt_devolucao, ''yyyyddmm'') || ''  '') AS LINHA');
    Query.SQL.Add('FROM ibi_controle_devolucoes_fac DV');
    Query.SQL.Add(' INNER JOIN ibi_motivo_devolucoes MD ON (DV.cd_motivo=MD.cd_motivo)');
    Query.SQL.Add('WHERE MD.servico_id=:SERVICO');
    Query.SQL.Add('   AND DV.DATA >= :XPDATAINI');
    Query.SQL.Add('   AND DV.DATA <= :XPDATAFIM');
    Query.SQL.Add('   AND DV.CODBIN ' + MontarFiltroGrupoBIN(grupoId, familia));
    Query.ParamByName('SERVICO').AsInteger := lcCD_SERVICO.KeyValue;
    Query.ParamByName('XPDATAINI').AsDate := dtini;
    Query.ParamByName('XPDATAFIM').AsDate := dtfim;
    Query.Open;
    Query.First;

    if (Query.IsEmpty) or
       (Query.RecordCount <= 0) then
      begin
        Result := '';
        Exit;
      end;

    if progress <> nil then
      begin
        panelBarra.Visible := True;
        progress.Min      := 1;
        progress.Max      := TB_AUX.RecordCount;
        progress.Position := 1;
      end;

    Application.ProcessMessages;
    xArqVirtual := '';
    while not TB_AUX.Eof do
      begin
        if statusbar <> nil then
          statusbar.Panels[0].Text := 'Processando '+IntToStr(Query.RecNo)+' de '+IntToStr(Query.RecordCount);

        Application.ProcessMessages;
        xArqVirtual := xArqVirtual + TB_AUX.Fields[0].AsString+#13+#10;
        Query.Next;

        if progress <> nil then
          progress.Position := progress.Position +1;

        Application.ProcessMessages;
      end;

    Result := xArqVirtual;

    Query.Close;
    Query.SQL.Clear;
    Query.Params.Clear;
    
    if progress <> nil then
      panelBarra.Visible := False;

    if statusbar <> nil then
      statusbar.Panels[0].Text := '';
  except
    on E: Exception do
    begin
      Result := '';
      Application.MessageBox(PCHAR('Ocorreu um problema durante a geração do arquivo! Erro:'+E.Message), 'ERRO', MB_OK+MB_ICONERROR);

      Query.Close;
      Query.SQL.Clear;
      Query.Params.Clear;

      if progress <> nil then
       panelBarra.Visible       := False;

      if statusbar <> nil then
        StatusBar.Panels[0].Text := '';
      Exit;
    end;
  end;
end;

Function TfGeraArqDev.GerarArquivo_OUT(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;
var
  xArqVirtual : String;
begin
  try
    Query.Close;
    Query.SQL.Clear;
    Query.Params.Clear;
    Query.SQL.Add('SELECT');
    Query.SQL.Add('   (DV.cod_ar || DV.cd_motivo || ''005'') AS LINHA');
    Query.SQL.Add('FROM ibi_controle_devolucoes_ar DV');
    Query.SQL.Add('   INNER JOIN ibi_motivo_devolucoes MD ON (DV.cd_motivo=MD.cd_motivo)');
    Query.SQL.Add('WHERE MD.servico_id=:SERVICO');
    Query.SQL.Add('   AND DV.DATA >= :XPDATAINI');
    Query.SQL.Add('   AND DV.DATA <= :XPDATAFIM');
    Query.SQL.Add('   AND DV.CD_MOTIVO <> :XPCD_MOTIVO');
    Query.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    Query.ParamByName('SERVICO').AsInteger    := lcCD_SERVICO.KeyValue;
    Query.ParamByName('XPDATAINI').AsDate     := dtini;
    Query.ParamByName('XPDATAFIM').AsDate     := dtfim;
    Query.ParamByName('XPCD_MOTIVO').AsString := '007';
    Query.Open;
    Query.First;

    if (Query.IsEmpty) or
       (Query.RecordCount <= 0) then
    begin
      Result := '';
      Exit;
    end;

    if progress <> nil then
    begin
      panelBarra.Visible := True;
      progress.Min      := 1;
      progress.Max      := TB_AUX.RecordCount;
      progress.Position := 1;
    end;

    Application.ProcessMessages;
    xArqVirtual := '';
    while not TB_AUX.Eof do
    begin
      if statusbar <> nil then
       statusbar.Panels[0].Text := 'Processando '+IntToStr(Query.RecNo)+' de '+IntToStr(Query.RecordCount);

      Application.ProcessMessages;
      xArqVirtual := xArqVirtual + TB_AUX.Fields[0].AsString+#13+#10;
      Query.Next;

      if progress <> nil then
       progress.Position := progress.Position +1;

      Application.ProcessMessages;
    end;

    Result := xArqVirtual;

    Query.Close;
    Query.SQL.Clear;
    Query.Params.Clear;
    
    if progress <> nil then
     panelBarra.Visible := False;

    if statusbar <> nil then
     statusbar.Panels[0].Text := '';
  except on E: Exception do
    begin
      Result := '';
      Application.MessageBox(PCHAR('Ocorreu um problema durante a geração do arquivo! Erro:'+E.Message), 'ERRO', MB_OK+MB_ICONERROR);

      Query.Close;
      Query.SQL.Clear;
      Query.Params.Clear;

      if progress <> nil then
       panelBarra.Visible       := False;

      if statusbar <> nil then
       StatusBar.Panels[0].Text := '';
      Exit;
    end;
  end;
end;

procedure TfGeraArqDev.lcCD_SERVICOClick(Sender: TObject);
begin
  AtivaDemaisCampos;
end;

procedure TfGeraArqDev.lcCD_SERVICOKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  AtivaDemaisCampos;
end;

Function TfGeraArqDev.GerarArquivo_FACFat(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;
var
  xArqVirtual : String;
begin
  try
    Query.Close;
    Query.SQL.Clear;
    Query.Params.Clear;
    Query.SQL.Add('SELECT');
    Query.SQL.Add('   (DV.nro_conta || ''007'' || DV.cd_motivo || TO_CHAR(DV.dt_devolucao,''yyyymmdd'')) AS LINHA');
    Query.SQL.Add('FROM cea_controle_devolucoes DV');
    Query.SQL.Add('   INNER JOIN ibi_motivo_devolucoes MD ON (DV.cd_motivo=MD.cd_motivo)');
    Query.SQL.Add('WHERE MD.servico_id=:SERVICO');
    Query.SQL.Add('   AND DV.DATA >= :XPDATAINI');
    Query.SQL.Add('   AND DV.DATA <= :XPDATAFIM');
    Query.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    Query.ParamByName('SERVICO').AsInteger := lcCD_SERVICO.KeyValue;
    Query.ParamByName('XPDATAINI').AsDate := dtini;
    Query.ParamByName('XPDATAFIM').AsDate := dtfim;
    Query.Open;
    Query.First;

    if (Query.IsEmpty) or
       (Query.RecordCount <= 0) then
    begin
      Result := '';
      Exit;
    end;

    if progress <> nil then
    begin
      panelBarra.Visible := True;
      progress.Min      := 1;
      progress.Max      := TB_AUX.RecordCount;
      progress.Position := 1;
    end;

    Application.ProcessMessages;
    xArqVirtual := '';
    while not TB_AUX.Eof do
    begin
      if statusbar <> nil then
       statusbar.Panels[0].Text := 'Processando '+IntToStr(Query.RecNo)+' de '+IntToStr(Query.RecordCount);

      Application.ProcessMessages;
      xArqVirtual := xArqVirtual + TB_AUX.Fields[0].AsString+#13+#10;
      Query.Next;

      if progress <> nil then
       progress.Position := progress.Position +1;

      Application.ProcessMessages;
    end;

    Result := xArqVirtual;

    Query.Close;
    Query.SQL.Clear;
    Query.Params.Clear;
    
    if progress <> nil then
     panelBarra.Visible := False;

    if statusbar <> nil then
     statusbar.Panels[0].Text := '';
  except
    on E: Exception do
    begin
      Result := '';
      Application.MessageBox(PCHAR('Ocorreu um problema durante a geração do arquivo! Erro:'+E.Message), 'ERRO', MB_OK+MB_ICONERROR);

      Query.Close;
      Query.SQL.Clear;
      Query.Params.Clear;

      if progress <> nil then
       panelBarra.Visible       := False;

      if statusbar <> nil then
       StatusBar.Panels[0].Text := '';
      Exit;
    end;
  end;
end;

procedure TfGeraArqDev.btnGerarClick(Sender: TObject);
var
  xFile  : TextFile;
  xNomeArq : String;
  xArquivo : String;
  xGerou : Boolean;
  xDiretorio : String;
  xDtAux : TDate;
  xDtInicial, xDtFinal : TDate;
  sDtExtr: String; // Data dos registros
begin
  try
    if panelBarra.Visible then
      Exit;

    if lcCD_SERVICO.KeyValue < 0 then
      begin
        Application.MessageBox('Selecione o serviço !', 'Atenção', MB_OK + MB_ICONWARNING);
        lcCD_SERVICO.SetFocus;
        Exit;
      end;

    if cbgrupo.ItemIndex < 0 then
      begin
        Application.MessageBox('Selecione o grupo !', 'Atenção', MB_OK+MB_ICONWARNING);
        cbgrupo.SetFocus;
        Exit;
      end;

    if cbdtini.Date = 0 then
      begin
        Application.MessageBox('Selecione a data inicial do período !', 'Atenção', MB_OK+MB_ICONWARNING);
        cbdtini.SetFocus;
        Exit;
      end;

    if cbdtfim.Date = 0 then
      begin
        Application.MessageBox('Selecione a data final do período !', 'Atenção', MB_OK+MB_ICONWARNING);
        cbdtfim.SetFocus;
        Exit;
      end;

    if cbdtini.Date > cbdtfim.Date then
      begin
        Application.MessageBox('Data final deve ser igual ou superior a data inicial.', 'Atenção', MB_OK + MB_ICONWARNING);
        cbdtini.SetFocus;
        Exit;
      end;

    sDtExtr:= FormatDateTime('DDMMYYYY', cbdtini.Date);
    if cbdtfim.Date > cbdtini.Date then
      sDtExtr:= sDtExtr + '_a_' + FormatDateTime('DDMMYYYY', cbdtfim.Date);
    
    xDiretorio:= GetCurrentDir;
    if not SelectDirectory(xDiretorio, [], 0) then
      begin
        Application.MessageBox('Nenhum diretório selecionado. O processo será abortado', 'Aviso', MB_OK + MB_ICONINFORMATION);
        exit;
      end;
    // Incluindo o separador de diretórios
    xDiretorio:=xDiretorio + '\';
    if not DirectoryExists(xDiretorio) then
      begin
        if not CreateDir(xDiretorio) then
          begin
            Application.MessageBox('Não foi possível criar o diretório onde os ' +
                  'arquivos seriam armazenados. Verifique as permissões ou ' +
                  'entre em contato com o administrador do sistema!',
                'Atenção', MB_OK + MB_ICONWARNING);
            Exit;
          end;
      end;

    panelBarra.Visible:= true;
    lblPlanilha.Caption := 'Iniciando criação dos arquivos. Aguarde...';
    lblPlanilha.Refresh;
    Application.ProcessMessages;

    // Chegou até arqui, diretório preparado para salvar os arquivos
    grupoId := StrToInt(Copy(cbgrupo.Text, 1, 3));
    if Copy(cbgrupo.Text, 7, 1) = 'S' then
      familia := True
    else
      familia := False;


    xGerou := False;
    // Mensagem sobre criação do primeiro arquivo
    lblPlanilha.Caption := 'Arquivo 1 de 3...';
    lblPlanilha.Refresh;
    Application.ProcessMessages;

    xDtInicial := Trunc(cbdtini.Date);
    xDtFinal   := Trunc(cbdtfim.Date);

    xArquivo := '';
    xArquivo := Trim(GerarArquivo_FAC(xDtInicial, xDtFinal, TB_AUX, ProgressBar, Status));

    if xArquivo <> '' then
      begin


        xGerou   := True;
        xNomeArq := 'ADDRESS2ACC.CARTAO.FAC.' + sDtExtr + '.TMP';

        AssignFile(xFile, xDiretorio+xNomeArq);
        Rewrite(xFile);
        Write(xFile, xArquivo);
        CloseFile(xFile);
      end
    else
      begin
        // Mensagem sobre inexistencia de dados
        lblPlanilha.Caption := 'Não há dados para gerar o arquivo ' + xNomeArq;
        lblPlanilha.Refresh;
        Application.ProcessMessages;
      end;

    // Mensagem sobre criação do primeiro arquivo
    lblPlanilha.Caption := 'Arquivo 2 de 3...';
    lblPlanilha.Refresh;
    Application.ProcessMessages;

    xArquivo := '';
    xArquivo := Trim(GerarArquivo_OUT(xDtInicial, xDtFinal, TB_AUX, ProgressBar, Status));
    if xArquivo <> '' then
      begin
        xGerou   := True;
        xNomeArq := 'ADDRESS2ACC.CARTAO.OUTR.' + sDtExtr +'.TMP';

        AssignFile(xFile, xDiretorio+xNomeArq);
        Rewrite(xFile);
        Write(xFile, xArquivo);
        CloseFile(xFile);
      end
    else
      begin
        // Mensagem sobre inexistencia de dados
        lblPlanilha.Caption := 'Não há dados para gerar o arquivo ' + xNomeArq;
        lblPlanilha.Refresh;
        Application.ProcessMessages;
      end;

    // Mensagem sobre criação do primeiro arquivo
    lblPlanilha.Caption := 'Arquivo 3 de 3...';
    lblPlanilha.Refresh;
    Application.ProcessMessages;

    xArquivo := '';
    xArquivo := Trim(GerarArquivo_FACFat(xDtInicial, xDtFinal, TB_AUX, ProgressBar, Status));
    if xArquivo <> '' then
      begin
        xGerou   := True;
        xNomeArq := 'ADDRESS2ACC.CARTAO.FAC.' + sDtExtr +'.TMP';

        AssignFile(xFile, xDiretorio + xNomeArq);
        Rewrite(xFile);
        Write(xFile, xArquivo);
        CloseFile(xFile);
      end
    else
      begin
        // Mensagem sobre inexistencia de dados
        lblPlanilha.Caption := 'Não há dados para gerar o arquivo ' + xNomeArq;
        lblPlanilha.Refresh;
        Application.ProcessMessages;
      end;

    if xGerou then
     Application.MessageBox('Arquivos gerados com sucesso !', 'Sucesso', MB_OK+MB_ICONINFORMATION)
    else
     Application.MessageBox('Não foram encontrados dados para o período informado !', 'Atenção', MB_OK+MB_ICONWARNING);
     
  except
    on E: Exception do
    begin
      Application.MessageBox(PCHAR('Ocorreu um problema durante a geração do arquivo! Erro:'+E.Message), 'ERRO', MB_OK+MB_ICONERROR);
      TB_AUX.Close;
      TB_AUX.SQL.Clear;
      TB_AUX.Params.Clear;
      panelBarra.Visible    := False;
      Status.Panels[0].Text := '';
      Exit;
    end;
  end;
end;

procedure TfGeraArqDev.AtivaDemaisCampos;
var st: Boolean;
begin
  st:= (lcCD_SERVICO.KeyValue > 0);
  cbgrupo.Enabled:= st;
  cbdtini.Enabled:= st;
  cbdtfim.Enabled:= st;
end;
end.
