unit unRelAnAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, StdCtrls, Buttons, ComCtrls, //ADODB,
  ZAbstractRODataset, ZDataset;//base,ADODB,

type
  TfrmRelAnAR = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DTPinicial: TDateTimePicker;
    DTPFinal: TDateTimePicker;
    btnProc: TBitBtn;
    Panel1: TPanel;
    qryRelRE: TZReadOnlyQuery;
    qryRelCourier: TZReadOnlyQuery;
    qryRelREqtd_reg: TLargeintField;
    qryRelREds_motivo: TStringField;
    qryRelREcd_motivo: TStringField;
    qryRelREfamilia: TStringField;
    qryRelCourierqtd_reg: TLargeintField;
    qryRelCourierds_motivo: TStringField;
    qryRelCouriercd_motivo: TStringField;
    qryRelCourierfamilia: TStringField;
    Btnsair: TBitBtn;
    procedure BtnsairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProcClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GerarRelCourier;
    procedure GerarRelRE;
  end;

var
  frmRelAnAR: TfrmRelAnAR;
//  ArqCourier, ArqRE: string;
  dt_ini_edt, dt_ini, dt_fim_edt, dt_fim: string;
  rel: TextFile;
  sRel, sArq: string;
  contador: integer;
  totalgeral, subtotal: integer;
  tipo_prod_atual, tipo_prod_ant: string;

implementation

{$R *.dfm}
uses cddm;

procedure TfrmRelAnAR.BtnsairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRelAnAR.FormCreate(Sender: TObject);
begin
  dm.SqlAux.Close;
  dm.SqlAux.SQL.Clear;
  dm.SqlAux.SQL.Add('select current_date,localtime(0)');
  dm.SqlAux.Open;
  DTPinicial.Date :=  dm.SqlAux.Fields[0].AsDateTime;
  DTPFinal.Date   :=  dm.SqlAux.Fields[0].AsDateTime;

end;

procedure TfrmRelAnAR.btnProcClick(Sender: TObject);

begin

  //GerarRelCourier;
  GerarRelRE;

  Panel1.Caption := 'Relatório Gerado:' + sArq;
  Panel1.Refresh;


end;

procedure TfrmRelAnAR.GerarRelCourier;
begin

  sArq := 'F:\ibisis\RELATORIOS\' + 'RelatorioAnalicoAR_COURIER' + FormatDateTime('DD_MM_YYYY', DTPinicial.DateTime) + '_A_' + FormatDateTime('DD_MM_YYYY', DTPFinal.DateTime) + '.TXT';
  dt_ini := FormatDateTime('MM-DD-YYYY', DTPinicial.Date);
  dt_fim := FormatDateTime('MM-DD-YYYY', DTPFinal.Date);
  dt_ini_edt := FormatDateTime('DD/MM/YYYY', DTPinicial.DateTime);
  dt_fim_edt := FormatDateTime('DD/MM/YYYY', DTPFinal.DateTime);

  qryRelCourier.Close;
  qryRelCourier.ParamByName('DT_INI').Value := dt_ini;
  qryRelCourier.ParamByName('DT_FIM').Value := dt_fim;
  qryRelCourier.Open;

  qryRelCourier.First;
  case qryRelCourier.RecordCount of
    0 : ShowMessage('Sem Registros para Relatorio');
    else
    begin
      contador := 0;
      subtotal := 0;
      totalgeral := 0;
      AssignFile(rel, sArq);
      Rewrite(rel);
      Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
      Writeln(rel, format('%-15.15s%',['ADDRESS SA'])+ format('%-14.14s%',['-'])+ format('%-33.33s%',['BANCO IBI'])+ format('%-10.10s%',['PAGINA: 01']));
      Writeln(REL, format('%-72.72s%',['PROCESSAMENTO DE ' + dt_ini_edt + ' A ' + dt_fim_edt]));
      Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
      Writeln(rel, format('%-72.72s%',['']));
      Writeln(rel, format('%-72.72s%',['            RESUMO DO CONTROLE DE DEVOLUCOES    -   AR    -    COURRIER']));
      Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
      Writeln(Rel, format('%-28.28s%',['Tipo Prod'])+format('%-9.9s%',['QTDE'])+format('%-28.28s%',['Motivo'])+ format('%-7.7s%',['Cod Mot']));
      Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
      qryRelCourier.First;
      while not qryRelCourier.Eof do
      begin
        if contador = 0 then
        begin
  {        sRel := RPad(UpperCase(qryRelCourierFAMILIA.AsString), 25, ' ') + //'   ' +
            LPad(UpperCase(qryRelCourierQTD_REG.AsString), 4, '0') + LPad(' ', 5, ' ') +
            RPad(UpperCase(qryRelCourierDS_MOTIVO.AsString), 30, ' ') + LPad(' ', 3, ' ') +
            LPad(UpperCase(qryRelCourierCD_MOTIVO.AsString), 2, '0');}
          Writeln(Rel, sRel);
          inc(contador);
          totalgeral := totalgeral + qryRelCourierQTD_REG.AsInteger;
          subtotal := subtotal + qryRelCourierQTD_REG.AsInteger;
          qryRelCourier.Next;
          tipo_prod_atual := qryRelCourierFAMILIA.AsString;
          tipo_prod_ant := qryRelCourierFAMILIA.AsString;
        end
        else if tipo_prod_atual = tipo_prod_ant then
        begin
  {        sRel := RPad(UpperCase(qryRelCourierFAMILIA.AsString), 25, ' ') + //'   ' +
            LPad(UpperCase(qryRelCourierQTD_REG.AsString), 4, '0') + LPad(' ', 5, ' ') +
            RPad(UpperCase(qryRelCourierDS_MOTIVO.AsString), 30, ' ') + LPad(' ', 3, ' ') +
            LPad(UpperCase(qryRelCourierCD_MOTIVO.AsString), 2, '0');}
          Writeln(Rel, sRel);
          inc(contador);
          totalgeral := totalgeral + qryRelCourierQTD_REG.AsInteger;
          subtotal := subtotal + qryRelCourierQTD_REG.AsInteger;
          tipo_prod_ant := qryRelCourierFAMILIA.AsString;
          qryRelCourier.Next;
          tipo_prod_atual := qryRelCourierFAMILIA.AsString;
        end
        else
        begin
          Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
  //        Writeln(Rel, 'Sub-Total' + lpad('.', 58, '.') + lpad(inttostr(subtotal), 4, '0'));
          Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
          subtotal := 0;
  {        sRel := RPad(UpperCase(qryRelCourierFAMILIA.AsString), 25, ' ') + //'   ' +
            LPad(UpperCase(qryRelCourierQTD_REG.AsString), 4, '0') + LPad(' ', 5, ' ') +
            RPad(UpperCase(qryRelCourierDS_MOTIVO.AsString), 30, ' ') + LPad(' ', 3, ' ') +
            LPad(UpperCase(qryRelCourierCD_MOTIVO.AsString), 2, '0');}
          Writeln(Rel, sRel);
          inc(contador);
          totalgeral := totalgeral + qryRelCourierQTD_REG.AsInteger;
          subtotal := qryRelCourierQTD_REG.AsInteger + subtotal;
          tipo_prod_ant := qryRelCourierFAMILIA.AsString;
          qryRelCourier.Next;
          tipo_prod_atual := qryRelCourierFAMILIA.AsString;
        end;
      end;
      Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
    //  Writeln(Rel, 'Sub-Total' + lpad('.', 58, '.') + lpad(inttostr(subtotal), 4, '0'));
      Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
     // Writeln(Rel, 'Total' + lpad('.', 62, '.') + lpad(inttostr(totalgeral), 4, '0'));
      Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
      Flush(rel);
      CloseFile(rel);
    end;
  end;
end;

procedure TfrmRelAnAR.GerarRelRE;
begin
  sArq := 'F:\ibisis\RELATORIOS\' + 'RelatorioAnalitico.AR.' + FormatDateTime('DDMMYYYY', dm.SqlAux.Fields[0].AsDateTime) +FormatDateTime('HHMMSS',dm.SqlAux.Fields[1].AsDateTime) + '.TMP';
  dt_ini := FormatDateTime('MM-DD-YYYY', DTPinicial.Date);
  dt_fim := FormatDateTime('MM-DD-YYYY', DTPFinal.Date);
  dt_ini_edt := FormatDateTime('DD/MM/YYYY', DTPinicial.DateTime);
  dt_fim_edt := FormatDateTime('DD/MM/YYYY', DTPFinal.DateTime);
  qryRelRE.Close;
//  qryRelRE.Parameters.ParamByName('DT_INI').Value := dt_ini;
//  qryRelRE.Parameters.ParamByName('DT_FIM').Value := dt_fim;
  qryRelRE.ParamByName('DT_INI').Value := dt_ini;
  qryRelRE.ParamByName('DT_FIM').Value := dt_fim;
  qryRelRE.Open;
  qryRelRE.First;
  if qryRelRE.RecordCount = 0 then
  begin
    ShowMessage('Sem Registros para Relatorio');
  end
  else
  begin
    contador := 0;
    subtotal := 0;
    totalgeral := 0;
    AssignFile(rel, sArq);
    Rewrite(rel);
    Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
    Writeln(rel, format('%-15.15s%',['ADDRESS SA'])+ format('%-14.14s%',['-'])+ format('%-33.33s%',['BANCO IBI'])+ format('%-10.10s%',['PAGINA: 01']));
    Writeln(REL, format('%-72.72s%',['PROCESSAMENTO DE ' + dt_ini_edt + ' A ' + dt_fim_edt]));
    Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
    Writeln(rel, format('%-72.72s%',['']));
    Writeln(rel, format('%-72.72s%',['RESUMO DO CONTROLE DE DEVOLUCOES     -    AR   - REMESSA ECONOMICA']));
    Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
    Writeln(Rel, format('%-28.28s%',['Tipo Prod'])+format('%-9.9s%',['QTDE'])+format('%-28.28s%',['Motivo'])+ format('%-7.7s%',['Cod Mot']));
    Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
    qryRelRE.First;
    while not qryRelRE.Eof do
    begin
      if contador = 0 then
      begin
        sRel := format('%-28.28s%',[UpperCase(qryRelREFAMILIA.AsString)]); //'   ' +
        sRel := sRel+format('%4.4d',[(qryRelREqtd_reg.AsInteger)]) + format('%-05.05s%',['']);
        sRel := sRel+format('%-33.33s%',[UpperCase(qryRelREDS_MOTIVO.AsString)]);
        sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelRECD_MOTIVO.AsString))]);

      {        sRel := RPad(UpperCase(qryRelREFAMILIA.AsString), 25, ' ') + //'   ' +
          LPad(UpperCase(qryRelREQTD_REG.AsString), 4, '0') + LPad(' ', 5, ' ') +
          RPad(UpperCase(qryRelREDS_MOTIVO.AsString), 30, ' ') + LPad(' ', 3, ' ') +
          LPad(UpperCase(qryRelRECD_MOTIVO.AsString), 2, '0');}
        Writeln(Rel, sRel);
        inc(contador);
        totalgeral := totalgeral + qryRelREQTD_REG.AsInteger;
        subtotal := subtotal + qryRelREQTD_REG.AsInteger;
        qryRelRE.Next;
        tipo_prod_atual := qryRelREFAMILIA.AsString;
        tipo_prod_ant   := qryRelREFAMILIA.AsString;
      end
      else if tipo_prod_atual = tipo_prod_ant then
      begin
        sRel := format('%-28.28s%',[UpperCase(qryRelREFAMILIA.AsString)]);  //'   ' +
        sRel := sRel+format('%4.4d',[qryRelREQTD_REG.AsInteger]) + format('%-5.5s%',['']);
        sRel := sRel+format('%-33.33s%',[UpperCase(qryRelREDS_MOTIVO.AsString)]);
        sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelRECD_MOTIVO.AsString))]);


      {        sRel := RPad(UpperCase(qryRelREFAMILIA.AsString), 25, ' ') + //'   ' +
          LPad(UpperCase(qryRelREQTD_REG.AsString), 4, '0') + LPad(' ', 5, ' ') +
          RPad(UpperCase(qryRelREDS_MOTIVO.AsString), 30, ' ') + LPad(' ', 3, ' ') +
          LPad(UpperCase(qryRelRECD_MOTIVO.AsString), 2, '0');}
        Writeln(Rel, sRel);
        inc(contador);
        totalgeral := totalgeral + qryRelREQTD_REG.AsInteger;
        subtotal := subtotal + qryRelREQTD_REG.AsInteger;
        tipo_prod_ant := qryRelREFAMILIA.AsString;
        qryRelRE.Next;
        tipo_prod_atual := qryRelREFAMILIA.AsString;
      end
      else
      begin
        Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(Rel, format('%-10.10s%',['Sub-Total'])+StringOfChar('.', 58)+ format('%4.4d',[subtotal]));
        Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
//        Writeln(Rel, format('%-72.72s%',['_']));
        subtotal := 0;
        sRel := format('%-28.28s%',[UpperCase(qryRelREFAMILIA.AsString)]); //'   ' +
        sRel := sRel+format('%4.4d',[(qryRelREQTD_REG.AsInteger)]) + format('%-05.05s%',['']);
        sRel := sRel+format('%-33.33s%',[UpperCase(qryRelREDS_MOTIVO.AsString)]);
        sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelRECD_MOTIVO.AsString))]);


        {        sRel := RPad(UpperCase(qryRelREFAMILIA.AsString), 25, ' ') + //'   ' +
          LPad(UpperCase(qryRelREQTD_REG.AsString), 4, '0') + LPad(' ', 5, ' ') +
          RPad(UpperCase(qryRelREDS_MOTIVO.AsString), 30, ' ') + LPad(' ', 3, ' ') +
          LPad(UpperCase(qryRelRECD_MOTIVO.AsString), 2, '0');}
        Writeln(Rel, sRel);
        inc(contador);
        totalgeral := totalgeral + qryRelREQTD_REG.AsInteger;
        subtotal := qryRelREQTD_REG.AsInteger + subtotal;
        tipo_prod_ant := qryRelREFAMILIA.AsString;
        qryRelRE.Next;
        tipo_prod_atual := qryRelREFAMILIA.AsString;
      end;
    end;
  end;
  Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
  Writeln(Rel, format('%-10.10s%',['Sub-Total'])+StringOfChar('.', 58)+ format('%4.4d',[subtotal]));
  Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
  Writeln(rel,format('%-10.10s%',['Total'])+StringOfChar('.',57)+ format('%5.5d',[totalgeral]));

  //  Writeln(Rel, 'Sub-Total' + lpad('.', 58, '.') + lpad(inttostr(subtotal), 4, '0'));
//  Writeln(rel, '________________________________________________________________________');
//  Writeln(Rel, 'Total' + lpad('.', 62, '.') + lpad(inttostr(totalgeral), 4, '0'));
  Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));
  Flush(rel);
  CloseFile(rel);
end;

end.

