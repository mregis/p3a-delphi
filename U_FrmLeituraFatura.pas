unit U_FrmLeituraFatura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, DBCtrls, DB, ZAbstractRODataset,
  ZDataset, ExtCtrls;

type
  TFormLeituraFatura = class(TForm)
    GroupBox1: TGroupBox;
    LabelNumCartao: TLabel;
    edtCodigo: TEdit;
    StringGridFaturasLidas: TStringGrid;
    lcCD_MOTIVO: TDBLookupComboBox;
    Label3: TLabel;
    btnFechar: TBitBtn;
    StatusBarMessages: TStatusBar;
    BitBtnLimparLeituras: TBitBtn;
    StringGridResumoLeituras: TStringGrid;
    LabelDataDevolucao: TLabel;
    cbDT_DEVOLUCAO: TDateTimePicker;
    LblProduto: TLabel;
    lcCD_PRODUTO: TDBLookupComboBox;
    PanelProgress: TPanel;
    PanelProgressBar: TProgressBar;
    procedure StringGridResumoLeiturasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcCD_MOTIVOKeyPress(Sender: TObject; var Key: Char);
    procedure lcCD_PRODUTOKeyPress(Sender: TObject; var Key: Char);
    procedure cbDT_DEVOLUCAOKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnLimparLeiturasClick(Sender: TObject);
    procedure StringGridResumoLeiturasDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridFaturasLidasDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnFecharClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoChange(Sender: TObject);
    procedure StringGridFaturasLidasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    procedure IncluirLeitura;
    procedure ProgressBarStepItOne;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLeituraFatura: TFormLeituraFatura;

implementation

uses CDDM, U_Func;

{$R *.dfm}

procedure TFormLeituraFatura.BitBtnLimparLeiturasClick(Sender: TObject);
var inTransaction : Boolean;
  i : Integer;
begin
  if Application.MessageBox(
              PChar('Limpar as Leituras irá remover todos os objetos lidos ' +
                'do sistema. Tem certeza que deseja remover todas as leituras ' + 
                'efetuadas nesta sessão?'),
              'Controle de Devoluções - FAC',
              MB_YESNO + MB_ICONWARNING) = ID_YES then
    begin
      inTransaction := False;
      try
        PanelProgressBar.Max := StringGridFaturasLidas.RowCount;
        PanelProgressBar.Step := 0;
        PanelProgress.Visible := True;

        With Dm.SqlAux do
          begin
            // Iniciando transação
            Close;
            SQL.Text := 'START TRANSACTION';
            Open;
            inTransaction := True;
            // Apagando os registros
            SQL.Clear;
            SQL.Add('DELETE FROM cea_controle_devolucoes');
            SQL.Add('WHERE id = :id');

            for i := 1 to StringGridFaturasLidas.RowCount - 1 do
              begin
                ProgressBarStepItOne;
                ParamByName('id').AsString := StringGridFaturasLidas.Cells[5, i];
                ExecSQL;
                if RowsAffected  < 1 then
                  begin
                    Application.MessageBox(
                        PChar('Ocorreu um erro ao tentar remover leituras da base.' +
                            'Entre em contato com o Administrador do sistema!'),
                        'Controle de Devoluções - FAC',
                        MB_OK + MB_ICONERROR);
                    SQL.Text := 'ROLLBACK';
                    ExecSQL;
                    exit;
                  end;
              end; // for            
            // Finalizando
            SQL.Text := 'COMMIT';
            ExecSQL;
            inTransaction := False;
            PanelProgressBar.Step := StringGridFaturasLidas.RowCount;
          end;
        StringGridFaturasLidas.RowCount := 1;
        StatusBarMessages.Panels.Items[1].Text := '0';
        BitBtnLimparLeituras.Enabled := false;
        StringGridResumoLeituras.RowCount := 1;
        Application.MessageBox(
                    PChar('As leituras foram removidas!'),
                    'Controle de Devoluções - FAC',
                MB_OK + MB_ICONINFORMATION);        
      finally
        if inTransaction then
          begin
            Dm.SqlAux.SQL.Text := 'ROLLBACK';
            Dm.SqlAux.ExecSQL;
          end;
        PanelProgress.Visible := False;
        PanelProgressBar.Step := 0;
      end;
    end;
end;

procedure TFormLeituraFatura.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormLeituraFatura.cbDT_DEVOLUCAOKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    lcCD_PRODUTO.SetFocus;
    
end;

procedure TFormLeituraFatura.edtCodigoChange(Sender: TObject);
var i : integer;
  msgs : String;
begin
  if (Length(edtCodigo.Text) > 18) then
    begin
      if (validaNumObjCorreios(edtCodigo.Text) = true) then
        begin
          StatusBarMessages.Panels.Items[4].Text := '';
          // Verificando se já não é um item presente na lista.
          for i := 1 to StringGridFaturasLidas.RowCount - 1 do
            begin
              if (StringGridFaturasLidas.Cells[1, i] = edtCodigo.Text) then
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
          StatusBarMessages.Panels.Items[1].Text := intToStr(StringGridFaturasLidas.RowCount - 1);
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

procedure TFormLeituraFatura.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    IncluirLeitura;
end;

procedure TFormLeituraFatura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.qraMotivo.Close;
  DM.qraProduto.Close;
end;

procedure TFormLeituraFatura.FormCreate(Sender: TObject);
begin
  StringGridFaturasLidas.Cells[0,0] := '#';
  StringGridFaturasLidas.Cells[1,0] := 'Numero Objeto';
  StringGridFaturasLidas.Cells[2,0] := 'BIN';
  StringGridFaturasLidas.Cells[3,0] := 'Motivo Devolução';
  StringGridFaturasLidas.Cells[4,0] := 'Operador';
  StringGridFaturasLidas.Cells[5,0] := 'ID';

  StringGridResumoLeituras.Canvas.Brush.Color := clNavy;
  StringGridResumoLeituras.Canvas.Font.Color:= clWhite;

  StringGridResumoLeituras.Cells[0,0] := 'Motivo Devolução';
  StringGridResumoLeituras.Cells[1,0] := 'Qtde';


  cbDT_DEVOLUCAO.DateTime := Date;
  cbDT_DEVOLUCAO.MaxDate := Date;
end;

procedure TFormLeituraFatura.FormShow(Sender: TObject);
begin
  DM.qraMotivo.Open;
  DM.qraProduto.Open;
end;

procedure TFormLeituraFatura.StringGridFaturasLidasDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  If (arow > 0)  then // testa se não é a primeira linha (fixa)
    begin
      StringGridFaturasLidas.Canvas.Font.Color:= clBlack;
      StringGridFaturasLidas.Canvas.Font.Style:= [];
      if (State = [gdSelected]) then
        StringGridFaturasLidas.Canvas.Brush.Color := clGray
      else
        if (odd(arow)) then
          // verifica se a linha é impar
          StringGridFaturasLidas.Canvas.Brush.Color := $009D9D4F
        else
          StringGridFaturasLidas.Canvas.Brush.Color := $00CDCD9C;
    end
  else   // Cabeçalhos
    begin
        StringGridFaturasLidas.Canvas.Font.Style:= [fsBold];
        StringGridFaturasLidas.Canvas.Brush.Color := clNavy;
        StringGridFaturasLidas.Canvas.Font.Color:= clWhite;
    end;

  StringGridFaturasLidas.Canvas.FillRect(Rect); // redesenha a celula
  StringGridFaturasLidas.Canvas.TextOut(Rect.Left + 2, Rect.Top,
  StringGridFaturasLidas.Cells[acol, arow]); // reimprime  o texto.
end;

procedure TFormLeituraFatura.StringGridFaturasLidasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var sMensagem : string;
    i, j, srow : Integer;
begin
  if Key = VK_DELETE then
    begin
      srow := StringGridFaturasLidas.Row;
      if (srow < 1 ) then
        exit; // Não apagar cabeçalhos

      sMensagem := 'Deseja remover o cartão ' + StringGridFaturasLidas.Cells[1, srow] +
        ' da lista? Ele será removido também da base e não será ' +
        'incluído nos arquivos.';
    if Application.MessageBox(pchar(sMensagem), 'Aviso',
          MB_YESNO + MB_ICONQUESTION + MB_SYSTEMMODAL) = ID_YES then
      begin
        // Removendo da base de dados
        With DM do
          begin
            SqlAux.Close;
            SqlAux.SQL.Text := 'DELETE FROM cea_controle_devolucoes ' +
                  'WHERE id=:id';
            SqlAux.ParamByName('id').AsInteger := StrToInt64(StringGridFaturasLidas.Cells[4, srow]);
            SqlAux.ExecSQL;
            if SqlAux.RowsAffected > 0 then
              begin
                // Removendo a leitura do resumo
                for i := 1 to StringGridResumoLeituras.RowCount - 1 do
                  begin
                    if (StringGridResumoLeituras.Cells[0, i] = StringGridFaturasLidas.Cells[3, srow]) then
                      begin
                        StringGridResumoLeituras.Cells[1, i] := IntToStr(StrToInt(StringGridResumoLeituras.Cells[1, i]) -1 );
                        if (StringGridResumoLeituras.Cells[1, i] = '0') then
                          // Se zerar um dos motivos devemos removê-lo da lista 
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

                for i := srow to StringGridFaturasLidas.RowCount - 2 do
                  begin
                    if (StringGridFaturasLidas.Cells[0, i + 1] = '') then
                      StringGridFaturasLidas.Cells[0, i] := ''
                    else
                      StringGridFaturasLidas.Cells[0, i] := IntToStr(i);

                    StringGridFaturasLidas.Cells[1, i] := StringGridFaturasLidas.Cells[1, i + 1];
                    StringGridFaturasLidas.Cells[2, i] := StringGridFaturasLidas.Cells[2, i + 1];
                  end; // for
                StringGridFaturasLidas.RowCount := StringGridFaturasLidas.RowCount - 1;
                StatusBarMessages.Panels.Items[1].Text := IntToStr(StringGridFaturasLidas.RowCount - 1);
                BitBtnLimparLeituras.Enabled := StringGridFaturasLidas.RowCount > 1;
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

procedure TFormLeituraFatura.StringGridResumoLeiturasDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  If (arow > 0)  then // testa se não é a primeira linha (fixa)
    begin
      StringGridResumoLeituras.Canvas.Font.Color:= clBlack;
      StringGridResumoLeituras.Canvas.Font.Style:= [];
      if (odd(arow)) then
        // verifica se a linha é impar
        StringGridResumoLeituras.Canvas.Brush.Color:= clSilver
      else
        StringGridResumoLeituras.Canvas.Brush.Color:= clGray;

      StringGridResumoLeituras.Canvas.FillRect(Rect); // redesenha a celula
      StringGridResumoLeituras.Canvas.TextOut(Rect.Left + 2, Rect.Top,
        StringGridResumoLeituras.Cells[acol, arow]); // reimprime  o texto.
    end;
end;

{ Valida os dados e Inclui a leitura efetivamente na base de dados }
procedure TFormLeituraFatura.IncluirLeitura;
var sBin, s, sql, id : string;
  i, r: Integer;
  inTransaction : Boolean;
begin
  StatusBarMessages.Panels.Items[4].Text := '';
  inTransaction := False;
  s := '';
  id := '';
  r := 0;
  if Trim(edtCodigo.Text) <> '' then
    begin
      // Validando o campo Produto
      if lcCD_PRODUTO.KeyValue = null then
        begin
          Application.MessageBox('Selecione um Produto.', 'Aviso',
            MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
          lcCD_PRODUTO.SetFocus;
          exit;
        end;

      // Validando campo Motivo
      if lcCD_MOTIVO.KeyValue = null then
        begin
          Application.MessageBox('Selecione um Motivo de Devolução.', 'Aviso',
              MB_OK + MB_ICONWARNING + MB_SYSTEMMODAL);
          lcCD_MOTIVO.SetFocus;
          exit;
        end;
      // Validando o código (Número do Cartão)
      if validaNumCartaoCredito(edtCodigo.Text) then
        With DM do
          begin
            try
              // Para evitar problemas de concorrencia no Banco,
              // Sempre usar transações em bloco
              SqlAux.Close;
              SqlAux.SQL.Text := 'START TRANSACTION';
              SqlAux.ExecSQL;
              inTransaction := True;
              // Verificando se já não é um item presente na lista.
              for i := 1 to StringGridFaturasLidas.RowCount - 1 do
                begin
                  if (StringGridFaturasLidas.Cells[1, i] = edtCodigo.Text) then
                    begin
                      s := 'Já existe um item na lista com esse número de cartão na ' +
                          'linha ' + IntToStr(i) + '. Deseja incluir este código ' +
                          ' mesmo assim?';
                      if Application.MessageBox(PChar(s), 'Aviso',
                          MB_YESNO + MB_ICONQUESTION) = ID_NO then
                        begin
                          edtCodigo.Clear;
                          edtCodigo.SetFocus;
                          exit;
                        end
                      else
                        begin
                          r := 1; // indicador de que existe na lista
                          break;
                        end;
                    end;
                end; // for

              sql := 'INSERT INTO cea_controle_devolucoes ' +
                  '(id,nro_conta,cd_motivo,cd_produto,dt_devolucao,codbin,codusu) ' +
                  'VALUES (:id,:cod, :motivo, :produto, :dt_devolucao, :bin, :codusu) ';
              // Verificando se o numero de objeto já não foi lido anteriormente
              // em algum momento. Caso afirmativo mostra um aviso
              SqlAux.SQL.Clear;
              if (r <> 1) then
                begin
                  SqlAux.SQL.Add('SELECT a.id, a.nro_conta, a.data, a.codbin, a.cd_produto,');
                  SqlAux.SQL.Add('a.cd_motivo, a.dt_devolucao, a.hr_devolucao,');
                  SqlAux.SQL.Add('a.dt_cadastro, a.hr_cadastro, a.codusu');
                  SqlAux.SQL.Add('FROM cea_controle_devolucoes a');
                  SqlAux.SQL.Add('WHERE a.nro_conta=:cod AND a.dt_devolucao=:dt_devolucao');
                  SqlAux.ParamByName('cod').AsString := edtCodigo.Text;
                  SqlAux.ParamByName('dt_devolucao').AsDate := cbDT_DEVOLUCAO.Date;
                  SqlAux.Open;
                  if (SqlAux.RecordCount > 0) then
                    begin
                      id := SqlAux.FieldByName('id').AsString;
                      s := 'Já há uma ou mais leituras com este número de cartão para esta ' +
                          'mesma data de devolução lido em ' +
                          SqlAux.FieldByName('dt_cadastro').AsString + ' as ' +
                          SqlAux.FieldByName('hr_cadastro').AsString +
                          #13#10 + 'Deseja incluir essa leitura assim mesmo? ' +
                          'Escolha NÃO para atualizar as informações existentes com ' +
                          'os dados atuais ou CANCELAR para não fazer nada';
                      r := Application.MessageBox(PChar(s), 'AVISO!',
                            MB_YESNOCANCEL + MB_ICONQUESTION);
                      case r of
                        ID_YES : id := ''; // Forçar a criação de uma nova entrada mais abaixo
                        ID_NO : sql := 'UPDATE cea_controle_devolucoes SET codusu=:codusu,' +
                                 'cd_motivo=:motivo, dt_devolucao=:dt_devolucao, ' +
                                 'cd_produto=:produto,codbin=:bin ' +
                                 'WHERE nro_conta=:cod AND id = :id ';
                        ID_CANCEL : exit;
                      end;
                      SqlAux.Close;
                    end;
                end;

              sBin := Copy(edtCodigo.Text, 1, 6);

              if id='' then
                begin
                  SqlAux.SQL.Text := 'SELECT NEXTVAL(:seq) as id';
                  SqlAux.ParamByName('seq').AsString := 'cea_controle_devolucoes_id_seq';
                  SqlAux.Open;
                  id := SqlAux.FieldByName('id').AsString;
                end;

              // Instrução para inserir elementos
              SqlAux.SQL.Clear;
              SqlAux.SQL.Add(sql);
              SqlAux.ParamByName('cod').AsString := edtCodigo.Text;
              SqlAux.ParamByName('motivo').AsString := lcCD_MOTIVO.KeyValue;
              SqlAux.ParamByName('produto').AsString := lcCD_PRODUTO.KeyValue;
              SqlAux.ParamByName('dt_devolucao').AsDate := cbDT_DEVOLUCAO.Date;
              SqlAux.ParamByName('bin').AsString := sBin;
              SqlAux.ParamByName('codusu').AsInteger := usuaces;
              SqlAux.ParamByName('id').AsInteger := StrToInt64(id);
              SqlAux.ExecSQL;
              // Mesmo quando for atualização, obrigatoriamente o número da caixa
              // ou o id do lote precisará ser modificado, pois somente com lote
              // diferente das outras leituras é que ele não teria sido recuperado
              // no momento da verificação da lista LOEC
              if SqlAux.RowsAffected < 1 then
                Raise Exception.Create('Nenhuma informação modificada!');

              // Incluindo a leitura na lista exibida
              BitBtnLimparLeituras.Enabled := true;
              r := StringGridFaturasLidas.RowCount;
              StringGridFaturasLidas.RowCount := r + 1;
              StringGridFaturasLidas.Cells[0, r] := IntToStr(r);
              StringGridFaturasLidas.Cells[1, r] := edtCodigo.Text;
              StringGridFaturasLidas.Cells[2, r] := sBin;
              StringGridFaturasLidas.Cells[3, r] := Dm.qraMotivoDescricao.AsString;
              StringGridFaturasLidas.Cells[4, r] := id;
              StringGridFaturasLidas.Row := r;
              // Adicionando a leitura no resumo por motivo
              // Buscando a entrada referente ao motivo lido
              for i := 1 to StringGridResumoLeituras.RowCount - 1 do
                begin
                  if (StringGridResumoLeituras.Cells[0, i] = Dm.qraMotivoDescricao.AsString) then
                    begin
                      StringGridResumoLeituras.Cells[1, i] := IntToStr(1 + StrToInt(StringGridResumoLeituras.Cells[1, i]));
                      s := 'T'; // Flag pra indicar que já foi atualizado o motivo no resumo
                      break;
                    end
                end; // for

              if s <> 'T' then
                begin
                  i := StringGridResumoLeituras.RowCount;
                  StringGridResumoLeituras.RowCount := i + 1;
                  StringGridResumoLeituras.Cells[0, i] := Dm.qraMotivoDescricao.AsString;
                  StringGridResumoLeituras.Cells[1, i] := '1';
                end;

              SqlAux.SQL.Text := 'COMMIT';
              SqlAux.ExecSQL;
              inTransaction := False;

              StatusBarMessages.Panels.Items[1].Text := IntToStr(r);
              StatusBarMessages.Panels.Items[3].Text := edtCodigo.Text;

              edtCodigo.Clear;
              edtCodigo.SetFocus;
            except
              if InTransaction then
                begin
                  SqlAux.SQL.Text := 'ROLLBACK';
                  SqlAux.ExecSQL;
                end;

              Application.MessageBox('Ocorreu um erro ao gravar as informações. ' +
                        'Nenhuma informação foi salva. Tente novamente ou entre em ' +
                        'contato com o Administrador', 'ERRO',
                      MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
            end; // try..except
          end // With
      else
        Application.MessageBox('Valor inválido para o campo Número Cartão! ',
            'ERRO',
            MB_OK + MB_ICONERROR + MB_SYSTEMMODAL);
    end; // if
end;

procedure TFormLeituraFatura.lcCD_MOTIVOKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    edtCodigo.SetFocus;
end;

procedure TFormLeituraFatura.lcCD_PRODUTOKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    lcCD_MOTIVO.SetFocus;
end;

procedure TFormLeituraFatura.ProgressBarStepItOne;
begin
  // Remover as leituras desta caixa da base de dados
  PanelProgressBar.StepBy(1);
  PanelProgressBar.StepBy(-1);
  PanelProgressBar.StepBy(1);
  PanelProgressBar.Update;
  PanelProgress.Refresh;
end;

end.
