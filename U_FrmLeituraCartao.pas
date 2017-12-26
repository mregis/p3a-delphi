unit U_FrmLeituraCartao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, DBCtrls, DB, ZAbstractRODataset,
  ZDataset, IniFiles, ExtCtrls;

type
  TFormLeituraCartao = class(TForm)
    GroupBoxDadosLote: TGroupBox;
    LabelDataDevolucao: TLabel;
    LabelNumCaixa: TLabel;
    EditNumCaixa: TEdit;
    cbDT_DEVOLUCAO: TDateTimePicker;
    EditQtde: TEdit;
    LabelQtde: TLabel;
    BitBtnIniciarLeituras: TBitBtn;
    GroupBoxLeituras: TGroupBox;
    LabelCodBin: TLabel;
    LabelNumObjeto: TLabel;
    edtCodigo: TEdit;
    eBin: TEdit;
    StringGridARsLidos: TStringGrid;
    lcCD_MOTIVO: TDBLookupComboBox;
    LabelMotivo: TLabel;
    btnFechar: TBitBtn;
    StatusBarMessages: TStatusBar;
    qryFamilia: TZReadOnlyQuery;
    EditQtdeRestante: TEdit;
    LabelQtdeRestante: TLabel;
    BitBtnLimparLeituras: TBitBtn;
    BitBtnFinalizarLeituras: TBitBtn;
    StringGridResumoLeituras: TStringGrid;
    SpeedButtonAddLeitura: TSpeedButton;
    PanelProgress: TPanel;
    PanelProgressBar: TProgressBar;
    lcCD_SERVICO: TDBLookupComboBox;
    LblProduto: TLabel;
    BitBtnCancelaLeitura: TBitBtn;
    procedure EditQtdeRestanteChange(Sender: TObject);
    procedure BitBtnCancelaLeituraClick(Sender: TObject);
    procedure lcCD_SERVICOClick(Sender: TObject);
    procedure EditQtdeChange(Sender: TObject);
    procedure lcCD_SERVICODropDown(Sender: TObject);
    procedure lcCD_SERVICOKeyPress(Sender: TObject; var Key: Char);
    procedure EditNumCaixaChange(Sender: TObject);
    procedure StringGridResumoLeiturasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButtonAddLeituraClick(Sender: TObject);
    procedure EditQtdeDblClick(Sender: TObject);
    procedure cbDT_DEVOLUCAOKeyPress(Sender: TObject; var Key: Char);
    procedure eBinExit(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure EditQtdeExit(Sender: TObject);
    procedure EditQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure EditNumCaixaExit(Sender: TObject);
    procedure EditNumCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnFinalizarLeiturasClick(Sender: TObject);
    procedure BitBtnLimparLeiturasClick(Sender: TObject);
    procedure StringGridResumoLeiturasDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridARsLidosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnFecharClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure eBinKeyPress(Sender: TObject; var Key: Char);
    procedure eBinChange(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure StringGridARsLidosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnIniciarLeiturasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AtivaBtnLeitura;
    procedure PreparaNovaLeitura;
  private
    { Private declarations }
    ListSiglas : TStringList;
    procedure RetomarLeituras;
    procedure ProgressBarStepItOne;
    function ExisteLeituras(const codigo : STring) : Integer;

  public
    { Public declarations }
  end;

var
  FormLeituraCartao: TFormLeituraCartao;

implementation

uses CDDM, U_Func;

{$R *.dfm}

procedure TFormLeituraCartao.BitBtnCancelaLeituraClick(Sender: TObject);
begin
  if Application.MessageBox( PChar('Tem certeza que deseja parar de ler ' +
            'objetos para este lote? Voc� poder� retormar a leitura mais tarde.'),
          'ATEN��O', MB_YESNO + MB_ICONQUESTION) = mrYes then
      PreparaNovaLeitura;
end;

procedure TFormLeituraCartao.BitBtnFinalizarLeiturasClick(Sender: TObject);
begin
  try
    if StrToInt(EditQtdeRestante.Text) = 0 then
      begin
        With DM.SqlAux do
          begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE lote SET dt_fechamento = CURRENT_TIMESTAMP');
            SQL.Add('WHERE codigo = :caixa');
            ParamByName('caixa').AsString := EditNumCaixa.Text;
            ExecSQL;
            if RowsAffected > 0 then
              begin
                PreparaNovaLeitura;
                Application.MessageBox(Pchar('A caixa ' + EditNumCaixa.Text +
                        ' foi fechada com sucesso! Voc� j� pode iniciar uma nova caixa.'),
                      'Controle de Devolu��es - Cart�es',
                      MB_OK + MB_ICONWARNING);

              end
            else
              Application.MessageBox(Pchar('Ocorreu um erro ao finalizar a caixa atual!' +
                        #13#10 + 'Contate o administrador do sistema informando o ocorrido!'),
                      'Controle de Devolu��es - Cart�es',
                      MB_OK + MB_ICONWARNING);
          end;
      end
    else
      Application.MessageBox(Pchar('Ainda faltam ler ' + EditQtdeRestante.Text +
            ' objetos de acordo com os dados informados. Corrija as ' +
            'informa��es antes de continuar.'),
          'Controle de Devolu��es - Cart�es', MB_OK + MB_ICONWARNING);

  Except
    Application.MessageBox(Pchar('Ocorreu um erro ao tentar finalizar a caixa.'),
          'Controle de Devolu��es - Cart�es', MB_OK + MB_ICONERROR);
  end;

end;

procedure TFormLeituraCartao.BitBtnIniciarLeiturasClick(Sender: TObject);
var int_temp, res : integer;
begin
  // Checando as informa��es dos dados de caixa
  // Verificando se � uma caixa j� com leituras
  res := ExisteLeituras(EditNumCaixa.Text);
  case res of
    1:
      begin
        if not TryStrToInt(EditQtde.Text, int_temp) then
          begin
            Application.MessageBox(PChar('Valor inv�lido para Quantidade!'), 'Controle de Devolu��es - AR',
                  MB_OK + MB_ICONWARNING);
            StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
            EditQtde.SetFocus;
          end;

        With Dm do
          begin
            SqlAux.Close;
            SqlAux.SQL.Clear;
            SqlAux.SQL.Add('INSERT INTO lote (codigo, qtde, dt_devolucao, servico_id) ');
            SqlAux.SQL.Add('VALUES (:codigo, :qtde, :dt_devolucao, :servico) ');
            SqlAux.ParamByName('codigo').AsString := EditNumCaixa.Text;
            SqlAux.ParamByName('qtde').AsInteger := int_temp;
            SqlAux.ParamByName('dt_devolucao').AsDate := cbDT_DEVOLUCAO.Date;
            SqlAux.ParamByName('servico').AsInteger:= lcCD_SERVICO.KeyValue;
            SqlAux.ExecSQL;
            if SqlAux.RowsAffected > 0 then
              begin
                EditNumCaixa.Enabled := False;
                cbDT_DEVOLUCAO.Enabled := false;
                lcCD_SERVICO.Enabled:= False;
                EditQtde.ReadOnly := True;
                BitBtnIniciarLeituras.Enabled := false;
                BitBtnCancelaLeitura.Enabled:= True;
                // habilitando campos
                lcCD_MOTIVO.Enabled := True;
                DM.qMotivo.Close;
                DM.qMotivo.ParamByName('servico').AsInteger:= lcCD_SERVICO.KeyValue;
                DM.qMotivo.Open;
                edtCodigo.Enabled := True;
                eBin.Enabled := True;
                EditQtdeRestante.Text := IntToStr(int_temp);

              end
            else
              begin
                Application.MessageBox( PChar('Erro ao abrir Lote de leitura.' + #13#10 +
                     'Contate o Administrador do Sistema!'),
                    'ERRO',
                    MB_OK + MB_ICONERROR);
                exit;
              end;
          end; // With
      end;

    2:
      begin
        // Leituras ainda n�o foram fechadas
          if Application.MessageBox( PChar('Esta caixa j� possui leituras!' + #13#10 +
                'Deseja retomar a leitura para esta caixa?'),
              'ATEN��O',
              MB_YESNO + MB_ICONQUESTION) = mrYes then
            RetomarLeituras;
        end
    else
      begin
        Application.MessageBox( PChar('Esta caixa j� est� fechada ' +
                    'e n�o pode ser retomada.'),
            'ERRO',
            MB_OK + MB_ICONERROR);
        EditNumCaixa.SetFocus;
      end;
  end;
end;

procedure TFormLeituraCartao.BitBtnLimparLeiturasClick(Sender: TObject);
begin
  if Application.MessageBox(
              PChar('Limpar as Leituras ir� remover o cadastro da Caixa e ' +
                    'todos os objetos lidos do sistema. Tem certeza que ' +
                    'deseja remover todas as leituras efetuadas '+
                    'desta lista?'),
              'Controle de Devolu��es - AR',
              MB_YESNO + MB_ICONWARNING) = ID_YES then
    begin
      // Remover as leituras desta caixa da base de dados
      With Dm.SqlAux do
        begin
          // Iniciando transa��o
          Close;
          SQL.Text := 'START TRANSACTION';
          ExecSQL;
          // Apagando os registros
          SQL.Clear;
          SQL.Add('DELETE FROM ibi_controle_devolucoes_ar');
          SQL.Add('WHERE cod_ar IN (SELECT a.cod_ar ');
          SQL.Add('    FROM ibi_controle_devolucoes_ar a ');
          SQL.Add('        INNER JOIN lote b ON (a.lote_id = b.id)');
          SQL.Add('    WHERE b.codigo = :codigo)');
          ParamByName('codigo').AsString := EditNumCaixa.Text;
          ExecSQL;
          if RowsAffected  < 1 then
            begin
              Application.MessageBox(
                  PChar('Ocorreu um erro ao tentar remover leituras da base.' +
                      'Entre em contato com o Administrador do sistema!'),
                  'Controle de Devolu��es - AR',
              MB_OK + MB_ICONERROR);
              SQL.Text := 'ROLLBACK';
              ExecSQL;
              exit;
            end;

          // removendo entradas da caixa
          SQl.Text := 'DELETE FROM lote WHERE codigo =:codigo AND servico_id= :servico';
          ParamByName('codigo').AsString := EditNumCaixa.Text;
          ParamByName('servico').AsInteger:= lcCD_SERVICO.KeyValue;
          ExecSQL;
          if RowsAffected  < 1 then
            begin
              Application.MessageBox(
                  PChar('Ocorreu um erro ao tentar remover a caixa da base.' +
                      'Entre em contato com o Administrador do sistema!'),
                  'Controle de Devolu��es - AR',
              MB_OK + MB_ICONERROR);
              SQL.Text := 'ROLLBACK';
              ExecSQL;
              exit;
            end;

          // Finalizando
          SQL.Text := 'COMMIT';
          ExecSQL;
        end;
      StringGridARsLidos.RowCount := 1;
      StatusBarMessages.Panels.Items[1].Text := '0';
      EditQtdeRestante.Text := IntToStr(StrToInt(EditQtde.Text) - (StringGridARsLidos.RowCount - 1));
      BitBtnLimparLeituras.Enabled := false;
      BitBtnIniciarLeituras.Enabled := True;
      EditNumCaixa.Clear;
      EditNumCaixa.Enabled := True;
      cbDT_DEVOLUCAO.Enabled := True;
      EditQtde.Enabled := True;
      EditQtde.Clear;

      StringGridResumoLeituras.RowCount := 1;
      BitBtnFinalizarLeituras.Enabled := False;
      Application.MessageBox(
                  PChar('As leituras foram removidas!'),
                  'Controle de Devolu��es - AR',
              MB_OK + MB_ICONINFORMATION);

    end;
end;

procedure TFormLeituraCartao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormLeituraCartao.cbDT_DEVOLUCAOKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    begin
      SelectNext(Sender as tWinControl, True, True);
      Key := #0;
    end;
    
end;

procedure TFormLeituraCartao.eBinChange(Sender: TObject);
var r : Integer;
  s : String;
begin
  eBin.Text := trim(eBin.Text);
  if (length(eBin.Text) > 5) then
    begin
      StatusBarMessages.Panels.Items[4].Text := '';
      qryFamilia.Close;
      qryFamilia.ParamByName('COD_BIN').AsString := eBin.Text;
      qryFamilia.Open;

      if qryFamilia.RecordCount > 0 then
        begin
          BitBtnLimparLeituras.Enabled := true;
          r := StringGridARsLidos.RowCount;
          StringGridARsLidos.RowCount := StringGridARsLidos.RowCount + 1;
          StringGridARsLidos.Cells[0, r] := IntToStr(r);
          StringGridARsLidos.Cells[1, r] := edtCodigo.Text;
          StringGridARsLidos.Cells[2, r] := eBin.Text;
          StringGridARsLidos.Cells[3, r] := Dm.qMotivocd_motivo.AsString ;
          StatusBarMessages.Panels.Items[1].Text := IntToStr(r);
          StatusBarMessages.Panels.Items[3].Text := edtCodigo.Text + ' | ' +
              eBin.Text;
          edtCodigo.Clear;
          edtCodigo.SetFocus;
        end
      else
        begin
          s := 'Este BIN n�o est� cadastrado! Verifique a informa��o.' + #13#10 +
                'Caso esteja correto ser� necess�rio cadastrar a Fam�lia deste BIN';
          Application.MessageBox(
              PChar(s),
                'Controle de Devolu��es - AR', MB_OK + MB_ICONWARNING);
          StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
          eBin.SetFocus;
        end;
    end;

end;

procedure TFormLeituraCartao.eBinExit(Sender: TObject);
var r, i: Integer;
  s, sql : String;
begin
StatusBarMessages.Panels.Items[4].Text := '';
if Trim(eBin.Text) <> '' then
  begin
    // Validando campo Motivo
    if lcCD_MOTIVO.KeyValue = null then
      begin
        Application.MessageBox('Selecione um Motivo de Devolu��o.', 'Aviso',
              MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        lcCD_MOTIVO.SetFocus;
        exit;
      end;

    // Validando o campo BIN
    if not (TryStrToInt(eBin.Text, r) ) then
      begin
        s := 'Valor inv�lido para o campo BIN! Verifique a informa��o.';
        Application.MessageBox(PChar(s), 'Controle de Devolu��es - Cart�es',
          MB_OK + MB_ICONWARNING);
        StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
        eBin.SetFocus;
        exit;
      end;

    // Verificando se o BIN est� cadastrado
    qryFamilia.Close;
    qryFamilia.ParamByName('COD_BIN').AsString := eBin.Text;
    qryFamilia.Open;

    if qryFamilia.IsEmpty then
      begin
        s := 'Este BIN n�o est� cadastrado! .' + #13#10 +
              'O valor do BIN est� correto?';
        if Application.MessageBox(PChar(s), 'Controle de Devolu��es - AR',
                    MB_YESNO + MB_ICONWARNING) = mrNo then
          begin
            StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
            eBin.SetFocus;
            exit;
          end;
      end;

    With DM do
      begin
        try
          // Verificando se o numero de objeto j� n�o foi lido anteriormente
          // em algum momento. Caso afirmativo mostra um aviso
          SqlAux.Close;
          SqlAux.SQL.Clear;
          SqlAux.SQL.Add('SELECT a.cod_ar, a.cd_motivo, a.codbin, a.codusu, ');
          SqlAux.SQL.Add(' a.data, a.dt_devolucao, b.codigo');
          SqlAux.SQL.Add('FROM ibi_controle_devolucoes_ar a');
          SqlAux.SQL.Add('  LEFT JOIN lote b ON (a.lote_id = b.id)');
          SqlAux.SQL.Add('WHERE a.cod_ar = :cod_ar');
          SqlAux.ParamByName('cod_ar').AsString := edtCodigo.Text;
          SqlAux.Open;

          if SqlAux.RecordCount > 0 then
            begin
              s := 'Este objeto j� foi lido anteriormente. Detalhes: ' + #13#10 +
                  'Leitura: ' + SqlAux.FieldByName('data').AsString +
                  ' | Movimento: ' + SqlAux.FieldByName('dt_devolucao').AsString;
              if (SqlAux.FieldByName('codigo').IsNull = false) AND (SqlAux.FieldByName('codigo').AsString <> EditNumCaixa.Text) then
                s := s + ' | Lista: ' + SqlAux.FieldByName('codigo').AsString;

              s := s + #13#10 + 'Deseja atualizar as informa��es existentes?';
              if Application.MessageBox(PChar(s), 'ERRO!',
                  MB_YESNO + MB_ICONWARNING + MB_SYSTEMMODAL) = ID_YES then
                begin
                  sql := 'UPDATE ibi_controle_devolucoes_ar SET codusu=:codusu,' +
                         'cd_motivo=:motivo, dt_devolucao = :dt_devolucao, codbin=:bin, ' +
                         'lote_id=(SELECT b.id FROM lote b ' +
                         'WHERE b.codigo = :codigo) ' + #13#10 +
                         'WHERE cod_ar=:cod';

                end
              else
                exit;
            end
          else
            sql := 'INSERT INTO ibi_controle_devolucoes_ar ' +
                '(cod_ar,cd_motivo,dt_devolucao,codbin,codusu,lote_id) ' +
                'SELECT :cod, :motivo, :dt_devolucao, :bin, :codusu, b.id ' +
                'FROM lote b WHERE b.codigo = :codigo';

          SqlAux.Close;

          // Instru��o para inserir elementos
          SqlAux.SQL.Clear;
          SqlAux.SQL.Add(sql);
          SqlAux.ParamByName('cod').AsString := edtCodigo.Text;
          SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
          SqlAux.ParamByName('dt_devolucao').AsDateTime := cbDT_DEVOLUCAO.DateTime;
          SqlAux.ParamByName('bin').AsString := eBin.Text;
          SqlAux.ParamByName('codusu').AsInteger := usuaces;
          SqlAux.ParamByName('codigo').AsString := EditNumCaixa.Text;
          SqlAux.ExecSQL;
          // Mesmo quando for atualiza��o, obrigatoriamente o n�mero da caixa
          // ou o id do lote precisar� ser modificado, pois somente com lote
          // diferente das outras leituras � que ele n�o teria sido recuperado
          // no momento da verifica��o da lista LOEC
          if SqlAux.RowsAffected < 1 then
            Raise Exception.Create('Nenhuma informa��o modificada!');

          // Incluindo a leitura na lista exibida
          BitBtnLimparLeituras.Enabled := true;
          r := StringGridARsLidos.RowCount;
          StringGridARsLidos.RowCount := r + 1;
          StringGridARsLidos.Cells[0, r] := IntToStr(r);
          StringGridARsLidos.Cells[1, r] := edtCodigo.Text;
          StringGridARsLidos.Cells[2, r] := eBin.Text;
          StringGridARsLidos.Cells[3, r] := Dm.qMotivodescricao.AsString;
          StringGridARsLidos.Cells[4, r] := Dm.operador;
          StringGridARsLidos.Row := r;
          // Adicionando a leitura no resumo por motivo
          // Buscando a entrada referente ao motivo lido
          for i := 1 to StringGridResumoLeituras.RowCount - 1 do
            begin
              if (StringGridResumoLeituras.Cells[0, i] = Dm.qMotivodescricao.AsString) then
                begin
                  StringGridResumoLeituras.Cells[1, i] := IntToStr(1 + StrToInt(StringGridResumoLeituras.Cells[1, i]));
                  s := 'T'; // Flag pra indicar que j� foi atualizado o motivo no resumo
                  break;
                end
            end; // for

          if s <> 'T' then
            begin
              i := StringGridResumoLeituras.RowCount;
              StringGridResumoLeituras.RowCount := i + 1;
              StringGridResumoLeituras.Cells[0, i] := Dm.qMotivodescricao.AsString;
              StringGridResumoLeituras.Cells[1, i] := '1';
            end;

          EditQtdeRestante.Text := IntToStr(StrToInt(EditQtde.Text) - r);

          // Verificando se j� leu toda a caixa
          if (EditQtdeRestante.Text = '0') then
            begin
              if Application.MessageBox(PChar('Voc� j� leu a quantidade ' +
                    'indicada para a caixa atual. Deseja Fechar a caixa agora?'),
                  'Aten��o',
                  MB_YESNO + MB_ICONQUESTION)= ID_YES then
                begin
                  BitBtnFinalizarLeituras.Click;
                  exit;
                end;
            end;

          StatusBarMessages.Panels.Items[1].Text := IntToStr(r);
          StatusBarMessages.Panels.Items[3].Text := edtCodigo.Text + ' | ' +
          eBin.Text;

          edtCodigo.Clear;
          edtCodigo.SetFocus;
        except
          Application.MessageBox('Ocorreu um erro ao gravar as informa��es. ' +
                      'Nenhuma informa��o foi salva. Tente novamente ou entre em ' +
                      'contato com o Administrador', 'ATEN��O',
                    MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
        end; // try..except
      end; // With
  end;
end;

procedure TFormLeituraCartao.eBinKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) and (Length(eBin.Text) > 5) then
    SpeedButtonAddLeitura.Click;

end;

procedure TFormLeituraCartao.EditNumCaixaChange(Sender: TObject);
begin
  AtivaBtnLeitura;
end;

procedure TFormLeituraCartao.EditNumCaixaExit(Sender: TObject);
var res : Integer;
begin
  if Length(EditNumCaixa.Text) > 0 then
    begin
      res := ExisteLeituras(EditNumCaixa.Text);
      if (res = 1) then
        exit
      else if res = 2 then
        begin // Existem leituras para o numero de caixa informado
            if Application.MessageBox(PChar('Esta caixa j� possui leituras!' + #13#10 +
                        'Deseja retomar a leitura para esta caixa?'),
                  'Controle de Devolu��es - Cart�es',
                  MB_YESNO + MB_ICONQUESTION) = ID_YES then
              RetomarLeituras // Retomando a leitura de onde parou
            else
              begin // Foi pedido para n�o retormar leiturass ent�o n�o podemos
                // liberar para continuar sem que seja alterado o c�digo da caixa
                EditNumCaixa.SetFocus;
                EditNumCaixa.SelectAll;
              end;
        end
      else if res = 3 then
        begin
          Application.MessageBox(PChar('Esta caixa j� est� fechada e n�o pode ser ' +
                        'retomada. Verifique as informa��es ou entre em contato ' +
                        'com o administrador do sistema'),
                  'Controle de Devolu��es - Cart�es',
                  MB_OK + MB_ICONWARNING);
          EditNumCaixa.SetFocus;
          EditNumCaixa.SelectAll;
        end;
    end;
end;

procedure TFormLeituraCartao.EditNumCaixaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    begin
      SelectNext(Sender as tWinControl, True, True);
      Key := #0;
    end;
end;

procedure TFormLeituraCartao.EditQtdeChange(Sender: TObject);
begin
  AtivaBtnLeitura;
end;

procedure TFormLeituraCartao.EditQtdeDblClick(Sender: TObject);
begin
  if EditQtde.ReadOnly then
      EditQtde.ReadOnly := False;

end;

procedure TFormLeituraCartao.EditQtdeExit(Sender: TObject);
var t : integer;
begin
  if trim(EditQtde.Text) <> '' then
    if not TryStrToInt(EditQtde.Text, t) then
      begin
        Application.MessageBox(PChar('Valor inv�lido para Quantidade!'), 'Controle de Devolu��es - AR',
              MB_OK + MB_ICONWARNING);
        StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
        EditQtde.SetFocus;
        EditQtde.SelectAll;
      end
    else
      begin          
        With DM.SqlAux Do
          begin
            if (BitBtnIniciarLeituras.Enabled) then
              begin
                SQL.Text := 'SELECT COUNT(a.*) as qtde ' + #13#10 +
                    'FROM ibi_controle_devolucoes_ar a ' + #13#10 +
                    '   INNER JOIN lote b ON (a.lote_id = b.id) ' + #13#10 +
                    'WHERE b.codigo = :codigo';
                ParamByName('codigo').AsString := EditNumCaixa.Text;
                Open;
                if not IsEmpty then
                  if FieldByName('qtde').AsInteger > t then
                    begin
                      Application.MessageBox(PChar('Existem ' + FieldByName('qtde').AsString +
                            ' objetos lidos para esta caixa. N�o � poss�vel usar um ' +
                            'valor menor do que esse para a quantidade.' + #13#10 +
                            'Corrija a informa��o ou remova algumas leituras.'),
                          'Controle de Devolu��es - AR',
                        MB_OK + MB_ICONERROR);
                      StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
                      EditQtde.Text := FieldByName('qtde').AsString;
                      EditQtde.SetFocus;
                      EditQtde.SelectAll;
                      exit;
                    end;
              end
            else
              begin
                // Indica que o campo quantidade foi editado para um lote j�
                // existente
                if (t < (StringGridARsLidos.RowCount - 1)) then
                  begin
                    Application.MessageBox(PChar('N�o � permitido modificar a ' 
                            + 'quantidade para um valor menor do que ' + 
                            IntToStr(StringGridARsLidos.RowCount - 1) +
                            '. Corrija a informa��o ou remova algumas leituras.'),
                          'Controle de Devolu��es - AR',
                        MB_OK + MB_ICONERROR);
                    StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
                    EditQtde.Text := IntToStr(StringGridARsLidos.RowCount - 1);
                    EditQtde.SetFocus;
                    EditQtde.SelectAll;
                    exit;
                  end;
                
                SQL.Text := 'UPDATE lote SET qtde=:qtde '+
                    'WHERE codigo = :codigo AND servico_id=:servico';
                ParamByName('qtde').AsInteger := t;
                ParamByName('codigo').AsString := EditNumCaixa.Text;
                ParamByName('servico').AsInteger := lcCD_SERVICO.KeyValue;
                ExecSQL;
                EditQtde.ReadOnly := True;
              end;
          end;

        EditQtdeRestante.Text := IntToStr(t - (StringGridARsLidos.RowCount - 1));
      end;          
    
end;

procedure TFormLeituraCartao.EditQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      SelectNext(Sender as tWinControl, True, True);
      Key := #0;
    end;
end;

procedure TFormLeituraCartao.EditQtdeRestanteChange(Sender: TObject);
begin
  // Verificando se j� leu toda a caixa
  BitBtnFinalizarLeituras.Enabled:= False;
  if (StringGridARsLidos.RowCount > 1) and (EditQtdeRestante.Text = '0') then
    begin
      BitBtnFinalizarLeituras.Enabled:= True;
      if Application.MessageBox(PChar('Voc� j� leu a quantidade ' +
                  'indicada para a caixa atual. Deseja Fechar a caixa agora?'),
                'Aten��o',
                MB_YESNO + MB_ICONQUESTION)= ID_YES then
        begin
          BitBtnFinalizarLeituras.Click;
          exit;
        end;
    end;
end;

procedure TFormLeituraCartao.edtCodigoChange(Sender: TObject);
var i : integer;
  msgs : String;
begin
  if (Length(edtCodigo.Text) > 12) then
    begin
      if (validaNumObjCorreios(edtCodigo.Text) = true) then
        begin
          StatusBarMessages.Panels.Items[4].Text := '';
          // Verificando se j� n�o � um item presente na lista.
          for i := 1 to StringGridARsLidos.RowCount - 1 do
            begin
              if (StringGridARsLidos.Cells[1, i] = edtCodigo.Text) then
                begin
                  msgs := 'Este item j� foi lido. Ver linha ' +
                  IntToStr(i);
                  StatusBarMessages.Panels.Items[4].Text := msgs;
                  Application.MessageBox(PChar(msgs), 'Aviso',
                      MB_OK + MB_ICONWARNING);
                  edtCodigo.Clear;
                  edtCodigo.SetFocus;
                  abort;
                end;
            end;

          // Chegou at� aqui � porque o item n�o est� presente
          eBin.SetFocus;
          StatusBarMessages.Panels.Items[1].Text := intToStr(StringGridARsLidos.RowCount - 1);
        end
      else
        begin
          msgs := 'N�mero de Objeto inv�lido!';
          Application.MessageBox(PChar(msgs), 'Aviso',
                      MB_OK + MB_ICONWARNING);
          StatusBarMessages.Panels.Items[4].Text := msgs;
          edtCodigo.SelectAll;
          abort;
        end;
  end;
end;

procedure TFormLeituraCartao.edtCodigoExit(Sender: TObject);
var i : integer;
  msgs, sigla : String;
begin
  if trim(edtCodigo.Text) <> '' then
    if (validaNumObjCorreios(edtCodigo.Text) = true) then
      begin
        if (StrToInt(EditQtde.Text) <= (StringGridARsLidos.RowCount - 1)) then
          begin
            Application.MessageBox(Pchar('Voc� j� leu a quantidade de objetos ' +
                'indicados no campo QUANTIDADE. Para contiuar as leituras ' +
                'modifique esse valor para maior.'),
                'ATEN��O', MB_OK + MB_ICONSTOP);
            exit;
          end;

        sigla := Copy(edtCodigo.Text, 1, 2);
        // Verificando se o n�mero de Objeto est� na lista
        if (ListSiglas.IndexOf(sigla) < 0) then
          begin
            if (Application.MessageBox(Pchar('Este n�mero de objeto n�o ' +
                  'possui uma sigla conhecida. Isso pode indicar que ele n�o ' +
                  'perten�a ao cliente atual. ' +#13#10 +
                  'Deseja incluir este objeto mesmo assim?'),
                'ATEN��O', MB_YESNO + MB_ICONWARNING) = ID_NO ) Then
              begin
                edtCodigo.Clear;
                edtCodigo.SetFocus;
                exit;
              end;

            // Continuando...
            if (Application.MessageBox(Pchar('Deseja incluir esta sigla na ' +
                    'lista de Siglas Conhecidas? ' + #13#10 +
                    'ATEN��O! Inclu�-la significar� que as pr�ximas leituras ' +
                    'dessa sigla ser�o adicionados sem aviso.'),
                'ATEN��O', MB_YESNO + MB_ICONQUESTION) = ID_YES ) Then
              begin
                ListSiglas.Add(sigla);
                DM.IniFile := TIniFile.Create(DM.iniFileName);
                DM.iniFile.WriteString('Geral', 'SiglasSedexValidas', ListSiglas.CommaText);
                DM.iniFile.Free;
                Application.MessageBox(Pchar('A sigla foi inclu�da com sucesso ' +
                      'na lista de Siglas Conhecidas. A leitura ir� continuar.'),
                'ATEN��O', MB_OK + MB_ICONINFORMATION);
              end;
          end;

        StatusBarMessages.Panels.Items[4].Text := '';
        // Verificando se j� n�o � um item presente na lista.
        for i := 1 to StringGridARsLidos.RowCount - 1 do
          begin
            if (StringGridARsLidos.Cells[1, i] = edtCodigo.Text) then
              begin
                msgs := 'Este item j� foi lido. Ver linha ' +
                IntToStr(i);
                StatusBarMessages.Panels.Items[4].Text := msgs;
                Application.MessageBox(PChar(msgs), 'Aviso',
                      MB_OK + MB_ICONWARNING);
                edtCodigo.Clear;
                edtCodigo.SetFocus;
                abort;
              end;
          end;

        // Chegou at� aqui � porque o item n�o est� presente
        eBin.SetFocus;
        StatusBarMessages.Panels.Items[1].Text := intToStr(StringGridARsLidos.RowCount - 1);
      end
    else
      begin
        msgs := 'N�mero de Objeto inv�lido!';
        Application.MessageBox(PChar(msgs), 'Aviso',
              MB_OK + MB_ICONWARNING);
        StatusBarMessages.Panels.Items[4].Text := msgs;
        edtCodigo.Clear;
        edtCodigo.SetFocus;
        exit;
      end;
end;

procedure TFormLeituraCartao.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      eBin.SetFocus;
      eBin.SelectAll;
    end;


end;

procedure TFormLeituraCartao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
  if (StringGridARsLidos.RowCount > 1) then
    if Application.MessageBox(pchar('A caixa ainda n�o foi fechada! Deseja sair assim mesmo?'),
        'Aviso', MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = ID_NO then
        abort;
  CanClose := True;
end;

procedure TFormLeituraCartao.FormCreate(Sender: TObject);
begin
  StringGridARsLidos.Cells[0,0] := '#';
  StringGridARsLidos.Cells[1,0] := 'Numero Objeto';
  StringGridARsLidos.Cells[2,0] := 'BIN';
  StringGridARsLidos.Cells[3,0] := 'Motivo Devolu��o';
  StringGridARsLidos.Cells[4,0] := 'Operador';

  StringGridResumoLeituras.Cells[0,0] := 'Motivo Devolu��o';
  StringGridResumoLeituras.Cells[1,0] := 'Qtde';
  
  cbDT_DEVOLUCAO.DateTime := Date;
  cbDT_DEVOLUCAO.MaxDate := Date;

  // Lista de Siglas de Objetos v�lidos
  ListSiglas := TStringList.Create;
  DM.IniFile := TIniFile.Create(Dm.iniFileName);
  ListSiglas.CommaText := DM.IniFile.ReadString('Geral', 'SiglasSedexValidas', '');

end;

procedure TFormLeituraCartao.FormShow(Sender: TObject);
begin
  DM.qraServicos.Open;
end;

procedure TFormLeituraCartao.lcCD_SERVICOClick(Sender: TObject);
begin
  EditNumCaixa.Enabled:= lcCD_SERVICO.KeyValue > 0;
  AtivaBtnLeitura;
end;

procedure TFormLeituraCartao.lcCD_SERVICODropDown(Sender: TObject);
begin
  EditNumCaixa.Enabled:= lcCD_SERVICO.KeyValue > 0;
  AtivaBtnLeitura;
end;

procedure TFormLeituraCartao.lcCD_SERVICOKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    begin
      SelectNext(Sender as tWinControl, True, True);
      Key := #0;
    end;
end;

{
  Recupera as informa��es de leituras efetuadas da caixa
  para que seja poss�vel continuar
}
procedure TFormLeituraCartao.RetomarLeituras;
var i, r : Integer;
  s : String;
begin
  // Recuperar informa��es da caixa do banco de dados
  With DM.SqlAux Do
    begin
      SQL.Text := 'SELECT id, codigo, qtde, dt_devolucao, ' +
            '   servico_id FROM lote ' +
            'WHERE codigo = :codigo AND servico_id = :servico';
      ParamByName('codigo').AsString := EditNumCaixa.Text;
      ParamByName('servico').AsInteger := lcCD_SERVICO.KeyValue;
      Open;
      if IsEmpty then
        begin
          Application.MessageBox(PChar('N�o foi poss�vel recuperar as leituras ' +
                    'para a caixa indicada. Procure o administrador do sistema.'),
                'ERRO', MB_OK + MB_ICONERROR);
          exit;
        end;
      cbDT_DEVOLUCAO.DateTime := FieldByName('dt_devolucao').AsDateTime;
      EditQtde.Text := IntToStr(FieldByName('qtde').AsInteger);
      i := FieldByName('id').AsInteger;
      // Recuperar informa��es dos objetos lidos
      SQL.Text := 'SELECT b.cod_ar, b.codbin, CAST (c.cd_motivo || '' - '' || c.ds_motivo AS VARCHAR) AS desc_motivo, ' +
            '    d.nomusu as operador ' +
            'FROM ibi_controle_devolucoes_ar b ' +
            '    INNER JOIN lote l ON (b.lote_id=l.id) ' +
            '	   INNER JOIN ibi_motivo_devolucoes c ON (b.cd_motivo = c.cd_motivo) ' +
    	      '               AND c.servico_id=l.servico_id ' +
            '    INNER JOIN ibi_cadusuario d ON (b.codusu = d.codusu) ' +
            'WHERE b.lote_id = :ID';
      ParamByName('ID').AsInteger := i;
      Open;
      StringGridARsLidos.RowCount := 1;
      while not Eof do
        begin
          s := '';
          // Incluindo a leitura na lista exibida
          r := StringGridARsLidos.RowCount;
          StringGridARsLidos.RowCount := r + 1;
          StringGridARsLidos.Cells[0, r] := IntToStr(r);
          StringGridARsLidos.Cells[1, r] := FieldByName('cod_ar').AsString;
          StringGridARsLidos.Cells[2, r] := FieldByName('codbin').AsString;
          StringGridARsLidos.Cells[3, r] := FieldByName('desc_motivo').AsString;
          StringGridARsLidos.Cells[4, r] := FieldByName('operador').AsString;
          StringGridARsLidos.Row := r;
          // Adicionando a leitura no resumo por motivo
          // Buscando a entrada referente ao motivo lido
          for i := 1 to StringGridResumoLeituras.RowCount - 1 do
            begin
              if (StringGridResumoLeituras.Cells[0, i] = FieldByName('desc_motivo').AsString) then
                begin
                  StringGridResumoLeituras.Cells[1, i] := IntToStr(1 + StrToInt(StringGridResumoLeituras.Cells[1, i]));
                  s := 'T'; // Flag pra indicar que j� foi atualizado o motivo no resumo
                  break;
                end
            end; // for

          if s <> 'T' then
            begin
              i := StringGridResumoLeituras.RowCount;
              StringGridResumoLeituras.RowCount := i + 1;
              StringGridResumoLeituras.Cells[0, i] := FieldByName('desc_motivo').AsString;
              StringGridResumoLeituras.Cells[1, i] := '1';
            end;
          Next;
        end; // while
      EditQtdeRestante.Text := IntToStr(StrToInt(EditQtde.Text) - (StringGridARsLidos.RowCount - 1));
      if StrToInt(EditQtdeRestante.Text) = 0 then
        if Application.MessageBox(PChar('Esta caixa j� teve todos os objetos ' +
                'lidos de acordo com as informa��es encontradas. Deseja fech�-la ' +
                'agora?'),
                'ERRO', MB_YESNO + MB_ICONQUESTION) = ID_YES then
          BitBtnFinalizarLeituras.Click;
            
      BitBtnIniciarLeituras.Enabled := False;
      BitBtnCancelaLeitura.Enabled:= True;
      BitBtnLimparLeituras.Enabled := StringGridARsLidos.RowCount > 1;
      EditNumCaixa.Enabled := False;
      cbDT_DEVOLUCAO.Enabled := false;
      EditQtde.ReadOnly := True;
      lcCD_MOTIVO.Enabled := True;
      DM.qMotivo.Close;
      DM.qMotivo.Open;
      edtCodigo.Enabled := True;
      eBin.Enabled := True;
    end;
end;

procedure TFormLeituraCartao.SpeedButtonAddLeituraClick(Sender: TObject);
var r, i: Integer;
  s, sql : String;
begin
StatusBarMessages.Panels.Items[4].Text := '';
if Trim(eBin.Text) <> '' then
  begin
    // Validando o campo Servi�o
    if lcCD_SERVICO.KeyValue = null then
      begin
        Application.MessageBox('Selecione um Servi�o.', 'Aviso',
            MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        lcCD_SERVICO.SetFocus;
        exit;
      end;

    // Validando campo Motivo
    if lcCD_MOTIVO.KeyValue = null then
      begin
        Application.MessageBox('Selecione um Motivo de Devolu��o.', 'Aviso',
              MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
        lcCD_MOTIVO.SetFocus;
        exit;
      end;

    // Validando o campo N�mero de Objeto
    if (validaNumObjCorreios(edtCodigo.Text) = false) then
      begin
        Application.MessageBox(PChar('N�mero de Objeto inv�lido!'), 'Aviso',
              MB_OK + MB_ICONWARNING);
        StatusBarMessages.Panels.Items[4].Text := 'N�mero de Objeto inv�lido!';
        edtCodigo.Clear;
        edtCodigo.SetFocus;
        exit;
      end;

    // Validando o campo BIN
    if not (TryStrToInt(eBin.Text, r) ) then
      begin
        s := 'Valor inv�lido para o campo BIN! Verifique a informa��o.';
        Application.MessageBox(PChar(s), 'Controle de Devolu��es - Cart�es',
          MB_OK + MB_ICONWARNING);
        StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
        eBin.SetFocus;
        exit;
      end;

    // Verificando se o BIN est� cadastrado
    qryFamilia.Close;
    qryFamilia.ParamByName('COD_BIN').AsString := eBin.Text;
    qryFamilia.Open;

    if qryFamilia.IsEmpty then
      begin
        s := 'Este BIN n�o est� cadastrado! .' + #13#10 +
              'O valor do BIN est� correto?';
        if Application.MessageBox(PChar(s), 'Controle de Devolu��es - AR',
                    MB_YESNO + MB_ICONWARNING) = mrNo then
          begin
            StatusBarMessages.Panels.Items[4].Text := 'ERRO!';
            eBin.SetFocus;
            eBin.SelectAll;
            exit;
          end;
      end;

    With DM do
      begin
        try
          // Verificando se o numero de objeto j� n�o foi lido anteriormente
          // em algum momento. Caso afirmativo mostra um aviso
          SqlAux.Close;
          SqlAux.SQL.Clear;
          SqlAux.SQL.Add('SELECT a.cod_ar, a.cd_motivo, a.codbin, a.codusu, ');
          SqlAux.SQL.Add(' a.data, a.dt_devolucao, b.codigo');
          SqlAux.SQL.Add('FROM ibi_controle_devolucoes_ar a');
          SqlAux.SQL.Add('  LEFT JOIN lote b ON (a.lote_id = b.id)');
          SqlAux.SQL.Add('WHERE a.cod_ar = :cod_ar');
          SqlAux.ParamByName('cod_ar').AsString := edtCodigo.Text;
          SqlAux.Open;

          if SqlAux.RecordCount > 0 then
            begin
              s := 'Este objeto j� foi lido anteriormente. Detalhes: ' + #13#10 +
                  'Leitura: ' + SqlAux.FieldByName('data').AsString +
                  ' | Movimento: ' + SqlAux.FieldByName('dt_devolucao').AsString;
              if (SqlAux.FieldByName('codigo').IsNull = false) AND (SqlAux.FieldByName('codigo').AsString <> EditNumCaixa.Text) then
                s := s + ' | Lista: ' + SqlAux.FieldByName('codigo').AsString;

              s := s + #13#10 + 'Deseja atualizar as informa��es existentes?';
              if Application.MessageBox(PChar(s), 'ERRO!',
                  MB_YESNO + MB_ICONWARNING + MB_SYSTEMMODAL) = ID_YES then
                begin
                  sql := 'UPDATE ibi_controle_devolucoes_ar SET codusu=:codusu,' +
                         'cd_motivo=:motivo, dt_devolucao = :dt_devolucao, codbin=:bin, ' +
                         'lote_id=(SELECT b.id FROM lote b ' +
                         'WHERE b.codigo = :codigo AND b.servico_id= :servico) ' + #13#10 +
                         'WHERE cod_ar=:cod';

                end
              else
                exit;
            end
          else
            sql := 'INSERT INTO ibi_controle_devolucoes_ar ' +
                '(cod_ar,cd_motivo,dt_devolucao,codbin,codusu,lote_id) ' +
                'SELECT :cod, :motivo, :dt_devolucao, :bin, :codusu, b.id ' +
                'FROM lote b WHERE b.codigo = :codigo AND b.servico_id = :servico';

          SqlAux.Close;

          // Instru��o para inserir elementos
          SqlAux.SQL.Clear;
          SqlAux.SQL.Add(sql);
          SqlAux.ParamByName('cod').AsString := edtCodigo.Text;
          SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
          SqlAux.ParamByName('dt_devolucao').AsDateTime := cbDT_DEVOLUCAO.DateTime;
          SqlAux.ParamByName('bin').AsString := eBin.Text;
          SqlAux.ParamByName('codusu').AsInteger := usuaces;
          SqlAux.ParamByName('codigo').AsString := EditNumCaixa.Text;
          SqlAux.ParamByName('servico').AsInteger := lcCD_SERVICO.KeyValue;
          SqlAux.ExecSQL;
          // Mesmo quando for atualiza��o, obrigatoriamente o n�mero da caixa
          // ou o id do lote precisar� ser modificado, pois somente com lote
          // diferente das outras leituras � que ele n�o teria sido recuperado
          // no momento da verifica��o da lista LOEC
          if SqlAux.RowsAffected < 1 then
            Raise Exception.Create('Nenhuma informa��o modificada!');

          // Incluindo a leitura na lista exibida
          BitBtnLimparLeituras.Enabled := true;
          r := StringGridARsLidos.RowCount;
          StringGridARsLidos.RowCount := r + 1;
          StringGridARsLidos.Cells[0, r] := IntToStr(r);
          StringGridARsLidos.Cells[1, r] := edtCodigo.Text;
          StringGridARsLidos.Cells[2, r] := eBin.Text;
          StringGridARsLidos.Cells[3, r] := Dm.qMotivodescricao.AsString;
          StringGridARsLidos.Cells[4, r] := Dm.operador;
          StringGridARsLidos.Row := r;
          // Adicionando a leitura no resumo por motivo
          // Buscando a entrada referente ao motivo lido
          for i := 1 to StringGridResumoLeituras.RowCount - 1 do
            begin
              if (StringGridResumoLeituras.Cells[0, i] = Dm.qMotivodescricao.AsString) then
                begin
                  StringGridResumoLeituras.Cells[1, i] := IntToStr(1 + StrToInt(StringGridResumoLeituras.Cells[1, i]));
                  s := 'T'; // Flag pra indicar que j� foi atualizado o motivo no resumo
                  break;
                end
            end; // for

          if s <> 'T' then
            begin
              i := StringGridResumoLeituras.RowCount;
              StringGridResumoLeituras.RowCount := i + 1;
              StringGridResumoLeituras.Cells[0, i] := Dm.qMotivodescricao.AsString;
              StringGridResumoLeituras.Cells[1, i] := '1';
            end;

          EditQtdeRestante.Text := IntToStr(StrToInt(EditQtde.Text) - r);

          StatusBarMessages.Panels.Items[1].Text := IntToStr(r);
          StatusBarMessages.Panels.Items[3].Text := edtCodigo.Text + ' | ' +
          eBin.Text;

          edtCodigo.Clear;
          edtCodigo.SetFocus;
        except
          Application.MessageBox('Ocorreu um erro ao gravar as informa��es. ' +
                      'Nenhuma informa��o foi salva. Tente novamente ou entre em ' +
                      'contato com o Administrador', 'ATEN��O',
                    MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
        end; // try..except
      end; // With
  end;

end;

procedure TFormLeituraCartao.StringGridARsLidosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (aRow > 0)  then // testa se n�o � a primeira linha (fixa)
    begin
      StringGridARsLidos.Canvas.Font.Color:= clBlack;
      StringGridARsLidos.Canvas.Font.Style:= [];
      if (State = [gdSelected]) then
        StringGridARsLidos.Canvas.Brush.Color := clGray
      else
        if (odd(aRow)) then
          // verifica se a linha � impar
          StringGridARsLidos.Canvas.Brush.Color := $009D9D4F
        else
          StringGridARsLidos.Canvas.Brush.Color := $00CDCD9C;
    end
  else   // Cabe�alhos
    begin
        StringGridARsLidos.Canvas.Font.Style:= [fsBold];
        StringGridARsLidos.Canvas.Brush.Color := clNavy;
        StringGridARsLidos.Canvas.Font.Color:= clWhite;
    end;

  StringGridARsLidos.Canvas.FillRect(Rect); // redesenha a celula
  StringGridARsLidos.Canvas.TextOut(Rect.Left + 2, Rect.Top,
  StringGridARsLidos.Cells[acol, arow]); // reimprime  o texto.
end;

procedure TFormLeituraCartao.StringGridARsLidosKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var sMensagem : string;
    i, j, srow : Integer;
begin
  if Key = VK_DELETE then
    begin
      srow := StringGridARsLidos.Row;
      if (srow < 1 ) then
        exit; // N�o apagar cabe�alhos

      sMensagem := 'Deseja remover o Objeto ' + StringGridARsLidos.Cells[1, srow] +
        ' da lista? Ele ser� removido tamb�m da base e n�o ser� ' +
        'inclu�do nos arquivos.';
    if Application.MessageBox(pchar(sMensagem), 'Aviso',
          MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = ID_YES then
      begin
        // Removendo da base de dados
        if StringGridARsLidos.Cells[4, srow] <> DM.operador then
          begin
            Application.MessageBox(pchar('Voc� n�o pode excluir uma leitura ' +
                    'feita por outro operador!'),
                'ATEN��O',
                MB_OK + MB_ICONWARNING);
            exit;
          end;
        
        With DM do
          begin
            SqlAux.Close;
            SqlAux.SQL.Text := 'DELETE FROM ibi_controle_devolucoes_ar ' +
                  'WHERE cod_ar = :codigo AND codusu = :codusu';
            SqlAux.ParamByName('codigo').AsString := StringGridARsLidos.Cells[1, srow];
            SqlAux.ParamByName('codusu').AsInteger := usuaces;
            SqlAux.ExecSQL;
            if SqlAux.RowsAffected > 0 then
              begin
                // Removendo a leitura do resumo
                for i := 1 to StringGridResumoLeituras.RowCount - 1 do
                  begin
                    if (StringGridResumoLeituras.Cells[0, i] = StringGridARsLidos.Cells[3, srow]) then
                      begin
                        StringGridResumoLeituras.Cells[1, i] := IntToStr(StrToInt(StringGridResumoLeituras.Cells[1, i]) -1 );
                        if (StringGridResumoLeituras.Cells[1, i] = '0') then
                          // Se zerar um dos motivos devemos remov�-lo da lista
                          begin
                            for j := i to StringGridResumoLeituras.RowCount - 2 do
                              begin
                                StringGridResumoLeituras.Cells[0, j] := StringGridResumoLeituras.Cells[0, j + 1];
                                StringGridResumoLeituras.Cells[1, j] := StringGridResumoLeituras.Cells[1, j + 1];
                              end; // for
                            StringGridResumoLeituras.RowCount := StringGridResumoLeituras.RowCount - 1;
                          end;
                      end;
                  end; // for

                for i := srow to StringGridARsLidos.RowCount - 2 do
                  begin
                    StringGridARsLidos.Cells[1, i] := StringGridARsLidos.Cells[1, i + 1];
                    StringGridARsLidos.Cells[2, i] := StringGridARsLidos.Cells[2, i + 1];
                    StringGridARsLidos.Cells[3, i] := StringGridARsLidos.Cells[3, i + 1];
                    StringGridARsLidos.Cells[4, i] := StringGridARsLidos.Cells[4, i + 1];
                  end; // for
                StringGridARsLidos.RowCount := StringGridARsLidos.RowCount - 1;
                StatusBarMessages.Panels.Items[1].Text := IntToStr(StringGridARsLidos.RowCount - 1);
                EditQtdeRestante.Text := IntToStr(StrToInt(EditQtdeRestante.Text) + 1);
                BitBtnLimparLeituras.Enabled := StringGridARsLidos.RowCount > 1;
              end
            else
              begin
                Application.MessageBox(pchar('Ocorreu um erro ao tentar excluir '+
                        'a entrada. Procure o administrador do sistema.'),
                    'ERRO',
                    MB_OK + MB_ICONERROR);
                exit;
              end;
          end; // with
      end;
  end;

end;

procedure TFormLeituraCartao.StringGridResumoLeiturasDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (aRow > 0)  then // testa se n�o � a primeira linha (fixa)
    begin
      StringGridResumoLeituras.Canvas.Font.Color:= clBlack;
      StringGridResumoLeituras.Canvas.Font.Style:= [];
      if (State = [gdSelected]) then
        StringGridResumoLeituras.Canvas.Brush.Color := clGray
      else
        if (odd(aRow)) then
          // verifica se a linha � impar
          StringGridResumoLeituras.Canvas.Brush.Color := $009D9D4F
        else
          StringGridResumoLeituras.Canvas.Brush.Color := $00CDCD9C;
    end
  else   // Cabe�alhos
    begin
        StringGridResumoLeituras.Canvas.Font.Style:= [fsBold];
        StringGridResumoLeituras.Canvas.Brush.Color := clNavy;
        StringGridResumoLeituras.Canvas.Font.Color:= clWhite;
    end;

  StringGridResumoLeituras.Canvas.FillRect(Rect); // redesenha a celula
  StringGridResumoLeituras.Canvas.TextOut(Rect.Left + 2, Rect.Top,
  StringGridResumoLeituras.Cells[acol, arow]); // reimprime  o texto.
end;


procedure TFormLeituraCartao.StringGridResumoLeiturasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  var sMensagem : string;
    i, srow, qtde, k: Integer;
    myTmpGrid : TStringGrid;
begin
  if Key = VK_DELETE then
    begin
      srow := StringGridResumoLeituras.Row;
      if (srow < 1 ) then
        exit; // N�o apagar cabe�alhos
      sMensagem := 'Deseja remover todas as leituras com o motivo ' +
        StringGridResumoLeituras.Cells[0, srow] +
        ' da lista? Eles ser�o removidos tamb�m da base e n�o ser�o ' +
        'inclu�dos nos arquivos.';
      if Application.MessageBox(pchar(sMensagem), 'Aviso',
          MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = ID_YES then
        begin
          // Exibindo o ProgressBar
          PanelProgressBar.Max := StrToInt(StringGridResumoLeituras.Cells[1, srow]);
          PanelProgressBar.Step := 0;
          PanelProgress.Visible := True;
          // Removendo da base de dados
          With DM do
            begin
              SqlAux.Close;
              // SQL base para a execu��o em lote
              SqlAux.SQL.Text := 'DELETE FROM ibi_controle_devolucoes_ar ' +
                  'WHERE cod_ar=:cod_ar AND codusu=:codusu';
              qtde := 0;
              myTmpGrid := TStringGrid.Create(Self);
              myTmpGrid.ColCount := StringGridARsLidos.ColCount;
              myTmpGrid.RowCount := 1;
              for i := 1 to StringGridARsLidos.RowCount - 1 do
                begin;
                  // Verificando se � um motivo para ser removido e que tenha
                  // sido lido pelo operador autenticado
                  if (StringGridARsLidos.Cells[3, i] = StringGridResumoLeituras.Cells[0, srow]) AND
                      (StringGridARsLidos.Cells[4, i] = operador) then
                    begin
                      SqlAux.ParamByName('codusu').AsInteger := usuaces; // Limitando apenas ao usu�rio autenticado
                      SqlAux.ParamByName('cod_ar').AsString := StringGridARsLidos.Cells[1, i];
                      SqlAux.ExecSQL;
                      if SqlAux.RowsAffected < 1 then
                        begin
                          sMensagem := SqlAux.SQL.GetText;
                          Application.MessageBox(pchar('Ocorreu um erro ao tentar excluir '+
                                'as entradas. Procure o administrador do sistema.'),
                            'ERRO',
                            MB_OK + MB_ICONERROR);
                          exit;
                        end;
                      qtde := qtde + 1;
                    end
                  else
                    begin
                      // Copiando Item que n�o deve ser removido
                      // Para uma Grid tempor�ria
                      myTmpGrid.Cells[0, myTmpGrid.RowCount - 1] := IntToStr(myTmpGrid.RowCount);
                      for k := 1 to StringGridARsLidos.ColCount - 1 do
                        begin
                          myTmpGrid.Cells[k, myTmpGrid.RowCount - 1] := StringGridARsLidos.Cells[k, i];
                        end;

                      myTmpGrid.RowCount := myTmpGrid.RowCount + 1;
                    end;
                  ProgressBarStepItOne;
                end; // for

              // Ap�s ter executado as instru��es de remo��o da base,
              // Copiar os itens que est�o na lista tempor�ria
              StringGridARsLidos.RowCount := 1;
              for i := 0 to myTmpGrid.RowCount - 2 do
                begin
                  StringGridARsLidos.RowCount := StringGridARsLidos.RowCount + 1;
                  // Copiando todos os dados do item posterior
                  for k := 0 to myTmpGrid.ColCount do
                    StringGridARsLidos.Cells[k, StringGridARsLidos.RowCount - 1] := myTmpGrid.Cells[k, i];
                end; //for 1

              // Verificando se � necess�rio remover o item da lista de resumo
              // ou somente reduzir o valor
              if (StrToInt(StringGridResumoLeituras.Cells[1, srow]) > qtde) then
                  StringGridResumoLeituras.Cells[1, srow] := IntToStr(StrToInt(StringGridResumoLeituras.Cells[1, srow]) - qtde )
              else
                begin
                  for i := srow to StringGridResumoLeituras.RowCount - 2 do
                    begin
                      StringGridResumoLeituras.Cells[0, i] := StringGridResumoLeituras.Cells[0, i + 1];
                      StringGridResumoLeituras.Cells[1, i] := StringGridResumoLeituras.Cells[1, i + 1];
                    end;
                  StringGridResumoLeituras.RowCount := StringGridResumoLeituras.RowCount - 1;
                end;

              StatusBarMessages.Panels.Items[1].Text := IntToStr(StringGridARsLidos.RowCount);
              EditQtdeRestante.Text := IntToStr(StrToInt(EditQtde.Text) - (StringGridARsLidos.RowCount - 1));
              BitBtnLimparLeituras.Enabled := StringGridARsLidos.RowCount > 1;
              myTmpGrid.Free;
              PanelProgress.Hide;
            end; // with
        end;
    end;
end;

{
  Verifica se a lista j� possui entradas no sistema
  �til quando leituras s�o interrompidas antes de efetuar o fechamento da caixa
  Existem 4 possibilidades para a verifica��o
  1 - N�o h� leituras para o c�digo informado
  2 - H� leituras para o c�digo informado e a caixa ainda n�o est� fechada
  3 - H� leituras para o c�digo informado e a caixa est� fechada
}
function TFormLeituraCartao.ExisteLeituras(const codigo : String) : Integer;
begin
  result := 1;
  With DM do
    begin
      SqlAux.Close;
      SqlAux.SQL.Clear;
      SqlAux.SQL.Add('SELECT l.codigo, l.qtde, l.dt_fechamento ');
      SqlAux.SQL.Add('FROM lote l ');
      SqlAux.SQL.Add('WHERE l.codigo = :caixa ');
      SqlAux.ParamByName('caixa').AsString := EditNumCaixa.Text;
      SqlAux.Open;
      if SqlAux.IsEmpty then // Provavelmente o mais comum ser� a verifica��o
        // retornar vazia
        exit;

      if SqlAux.FieldByName('dt_fechamento').IsNull then
        result := 2
      else
        result := 3;
        
    end;
end;

procedure TFormLeituraCartao.ProgressBarStepItOne;
begin
  // Remover as leituras desta caixa da base de dados
  PanelProgressBar.StepBy(1);
  PanelProgressBar.StepBy(-1);
  PanelProgressBar.StepBy(1);
  PanelProgressBar.Update;
  PanelProgress.Refresh;
end;

procedure TFormLeituraCartao.AtivaBtnLeitura;
var qt_temp: Integer;
begin
  qt_temp:= 0;
  TryStrToInt(EditQtde.Text, qt_temp);
  BitBtnIniciarLeituras.Enabled:= (qt_temp > 0) and
    (Length(EditNumCaixa.Text) > 0) and
    (lcCD_SERVICO.KeyValue > 0) and
    (BitBtnLimparLeituras.Enabled=false);
end;

procedure TFormLeituraCartao.PreparaNovaLeitura;
begin
  // Limpando os dados do formul�rio para preparar para nova
  // caixa
  StringGridARsLidos.RowCount := 1;
  StatusBarMessages.Panels.Items[1].Text := '0';
  BitBtnLimparLeituras.Enabled := false;
  StringGridResumoLeituras.RowCount := 1;
  BitBtnFinalizarLeituras.Enabled := False;
  lcCD_MOTIVO.Enabled := False;
  edtCodigo.Clear;
  edtCodigo.Enabled := False;
  eBin.Clear;
  eBin.Enabled := False;
  EditQtdeRestante.Text := '0';
  // Liberando os campos para novas informa��es
  EditNumCaixa.Clear;
  EditNumCaixa.Enabled := True;
  cbDT_DEVOLUCAO.Enabled := True;
  cbDT_DEVOLUCAO.DateTime := Date;
  EditQtde.Text := '0';
  EditQtde.ReadOnly := False;
  BitBtnCancelaLeitura.Enabled:= False;
  lcCD_SERVICO.Enabled:= True;
  lcCD_SERVICO.SetFocus;
end;

end.
