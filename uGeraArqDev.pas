unit uGeraArqDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

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
    SaveDialog: TSaveDialog;
    lblPlanilha: TLabel;
    cbgrupo: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbldataClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    grupoId : Integer;
    familia : Boolean;

    Function GerarArquivo_FAC(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;
    Function GerarArquivo_OUT(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;
    Function GerarArquivo_FACFat(dtini : TDate; dtfim : TDate; Query : TZQuery; progress : TProgressBar; statusbar : TStatusBar) : String;

    Function MontarFiltroGrupoBIN(grupo : integer; semFamilia : Boolean) : String;

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

  cbgrupo.Items.Clear;

  query := TB_AUX;
  query.Close;
  query.SQL.Clear;
  query.Params.Clear;
  query.SQL.Add('SELECT * FROM GRUPO ORDER BY ID');
  query.Open;
  if query.RecordCount <= 0 then
  begin
    Exit;
  end;

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
    Query.SQL.Add('SELECT');
    Query.SQL.Add('   (nro_cartao || ''005'' || cd_motivo || replace(dt_devolucao,''-'','''') || ''  '') AS LINHA');
    Query.SQL.Add('FROM');
    Query.SQL.Add('   ibi_controle_devolucoes_fac DV');
    Query.SQL.Add('WHERE');
    Query.SQL.Add('       DATA >= :XPDATAINI');
    Query.SQL.Add('   AND DATA <= :XPDATAFIM');
    Query.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
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
    Query.SQL.Add('   (cod_ar || cd_motivo || ''005'') AS LINHA');
    Query.SQL.Add('FROM');
    Query.SQL.Add('   ibi_controle_devolucoes_ar DV');
    Query.SQL.Add('WHERE');
    Query.SQL.Add('       DATA >= :XPDATAINI');
    Query.SQL.Add('   AND DATA <= :XPDATAFIM');
    Query.SQL.Add('   AND CD_MOTIVO <> :XPCD_MOTIVO');
    Query.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
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

procedure TfGeraArqDev.lbldataClick(Sender: TObject);
var
  xDiretorio : String;
begin
  SaveDialog.InitialDir := DM.currdir;
  SaveDialog.Execute;
  xDiretorio := ExtractFilePath(SaveDialog.FileName);
  ShowMessage(xDiretorio);
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
    Query.SQL.Add('   (nro_conta || ''007'' || cd_motivo || replace(dt_devolucao,''-'','''')) AS LINHA');
    Query.SQL.Add('FROM');
    Query.SQL.Add('   cea_controle_devolucoes DV');
    Query.SQL.Add('WHERE');
    Query.SQL.Add('       DATA >= :XPDATAINI');
    Query.SQL.Add('   AND DATA <= :XPDATAFIM');
    Query.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
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
begin
  try
    if panelBarra.Visible then
    begin
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
      if Application.MessageBox('As datas aparentemente estão invertidas, deseja que o sistema inverta ou prefere corrigi-la manualmente ? Sim(Automático) ou Não(Manual).', 'Confirmação', MB_YESNO+MB_ICONQUESTION) = ID_YES then
      begin
        xDtAux       := cbdtini.Date;
        cbdtini.Date := cbdtfim.Date;
        cbdtfim.Date := xDtAux;
      end
      else
      begin
        cbdtini.SetFocus;
        Exit;
      end;
    end;

    SaveDialog.Execute;
    xDiretorio := ExtractFilePath(SaveDialog.FileName);
    if (Trim(xDiretorio) = '') or
       (not DirectoryExists(xDiretorio)) then
    begin
      Application.MessageBox('Defina o local onde os arquivos serão salvos !', 'Atenção', MB_OK+MB_ICONWARNING);
      Exit;
    end;

    if not DirectoryExists(xDiretorio+'FAC_Fatura\') then
    begin
      if not CreateDir(xDiretorio+'FAC_Fatura\') then
      begin
        Application.MessageBox('Não foi possível criar o diretório p/ separar o arquivo FAC_Fatura !', 'Atenção', MB_OK+MB_ICONWARNING);
        Exit;
      end;
    end;

    grupoId := StrToInt(Copy(cbgrupo.Text, 1, 3));
    if Copy(cbgrupo.Text, 7, 1) = 'S' then
     familia := True
    else
     familia := False;


    xGerou := False;

    xDtInicial := Trunc(cbdtini.Date);
    xDtFinal   := Trunc(cbdtfim.Date);

    xArquivo := '';
    xArquivo := Trim(GerarArquivo_FAC(xDtInicial, xDtFinal, TB_AUX, ProgressBar, Status));
    if xArquivo <> '' then
    begin
      lblPlanilha.Caption := 'Arquivo 1 de 3...';
      lblPlanilha.Refresh;
      Application.ProcessMessages;

      xGerou   := True;
      xNomeArq := 'ADDRESS2ACC.CARTAO.FAC.'+FormatDateTime('DDMMYYYY', Now)+'.TMP';

      AssignFile(xFile, xDiretorio+xNomeArq);
      Rewrite(xFile);
      Write(xFile, xArquivo);
      CloseFile(xFile);
    end;

    xArquivo := '';
    xArquivo := Trim(GerarArquivo_OUT(xDtInicial, xDtFinal, TB_AUX, ProgressBar, Status));
    if xArquivo <> '' then
    begin
      lblPlanilha.Caption := 'Arquivo 2 de 3...';
      lblPlanilha.Refresh;
      Application.ProcessMessages;

      xGerou   := True;
      xNomeArq := 'ADDRESS2ACC.CARTAO.OUTR.'+FormatDateTime('DDMMYYYY', Now)+'.TMP';

      AssignFile(xFile, xDiretorio+xNomeArq);
      Rewrite(xFile);
      Write(xFile, xArquivo);
      CloseFile(xFile);
    end;

    xArquivo := '';
    xArquivo := Trim(GerarArquivo_FACFat(xDtInicial, xDtFinal, TB_AUX, ProgressBar, Status));
    if xArquivo <> '' then
    begin
      lblPlanilha.Caption := 'Arquivo 3 de 3...';
      lblPlanilha.Refresh;
      Application.ProcessMessages;

      xGerou   := True;
      xNomeArq := 'ADDRESS2ACC.CARTAO.FAC.'+FormatDateTime('DDMMYYYY', Now)+'.TMP';

      AssignFile(xFile, xDiretorio+'FAC_Fatura\'+xNomeArq);
      Rewrite(xFile);
      Write(xFile, xArquivo);
      CloseFile(xFile);
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

end.
