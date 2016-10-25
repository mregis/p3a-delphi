unit unRelAnFAC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB, //ADODB,
  ZAbstractRODataset, ZDataset;

type
  TfrmRelAnFAC = class(TForm)
    btnProc: TBitBtn;
    DTPinicial: TDateTimePicker;
    DTPFinal: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    qryRel: TZReadOnlyQuery;
    qryRelqtd_reg: TLargeintField;
    qryRelds_motivo: TStringField;
    qryRelcd_motivo: TStringField;
    qryRelfamilia: TStringField;
    Btnsair: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnProcClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelAnFAC: TfrmRelAnFAC;

implementation

{$R *.dfm}
uses cddm, U_Func;

procedure TfrmRelAnFAC.FormCreate(Sender: TObject);
begin

  DTPinicial.Date := Now - 30;
  DTPFinal.Date := now;
end;

procedure TfrmRelAnFAC.btnProcClick(Sender: TObject);
var
  dt_ini_edt, dt_ini, dt_fim_edt, dt_fim: string;
  rel: TextFile;
  sRel, sArq: string;
  contador: integer;
  totalgeral, subtotal: integer;
  tipo_prod_atual, tipo_prod_ant: string;
begin

  sArq := 'F:\ibisis\Relatorios\RelatorioAnaliticoFAC_' + FormatDateTime('DD_MM_YYYY', DTPinicial.DateTime) + '_A_' + FormatDateTime('DD_MM_YYYY', DTPFinal.DateTime) + '.TXT';
  dt_ini := FormatDateTime('YYYY-MM-DD', DTPinicial.Date);
  dt_fim := FormatDateTime('YYYY-MM-DD', DTPFinal.Date);
  dt_ini_edt := FormatDateTime('DD/MM/YYYY', DTPinicial.DateTime);
  dt_fim_edt := FormatDateTime('DD/MM/YYYY', DTPFinal.DateTime);

  qryRel.Close;

//  qryRel.Parameters.ParamByName('DT_INI').Value := dt_ini;
//  qryRel.Parameters.ParamByName('DT_FIM').Value := dt_fim;
  qryRel.Params[0].AsString  :=  FormatDateTime('mm/dd/yyyy/',DTPinicial.Date);//Trunc(DTPinicial.DateTime);
  qryRel.Params[1].AsString  :=  FormatDateTime('mm/dd/yyyy/',DTPFinal.Date);//Trunc(DTPFinal.DateTime);
  qryRel.Open;

  qryRel.First;
  case qryRel.RecordCount of
    0:  ShowMessage('Sem Registros para Relatório');
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
        Writeln(rel, format('%-72.72s%',['            RESUMO DO CONTROLE DE DEVOLUCOES     -    FAC']));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(Rel, format('%-32.32s%',['Tipo Prod'])+format('%-5.5s%',['QTDE'])+format('%-28.28s%',['Motivo'])+ format('%-7.7s%',['Cod Mot']));
        Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));

        //ShowMessage('REL');

        qryRel.First;
        tipo_prod_ant := qryRelFAMILIA.AsString;

        while not qryRel.Eof do
        begin
{          if contador = 0 then
          begin
            sRel := format('%-32.32s%',[UpperCase(qryRelFAMILIA.AsString)]); //'   ' +
            sRel := sRel+format('%4.4d',[(qryRelQTD_REG.AsInteger)]) + format('%-01.01s%',['']);
            sRel := sRel+format('%-33.33s%',[UpperCase(qryRelDS_MOTIVO.AsString)]);
            sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelCD_MOTIVO.AsString))]);
            Writeln(Rel, sRel);
            inc(contador);
            totalgeral := totalgeral + qryRelQTD_REG.AsInteger;
            subtotal := subtotal + qryRelQTD_REG.AsInteger;
            qryRel.Next;
            tipo_prod_atual := qryRelFAMILIA.AsString;
            tipo_prod_ant   := qryRelFAMILIA.AsString;
          end}
          if  (tipo_prod_ant = qryRelFAMILIA.AsString)  then
          begin
            sRel := format('%-32.32s%',[UpperCase(qryRelFAMILIA.AsString)]); //'   ' +
            sRel := sRel+format('%4.4d',[(qryRelQTD_REG.AsInteger)]) + format('%-01.01s%',['']);
            sRel := sRel+format('%-33.33s%',[UpperCase(qryRelDS_MOTIVO.AsString)]);
            sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelCD_MOTIVO.AsString))]);
            Writeln(Rel, sRel);
            inc(contador);
            totalgeral := totalgeral + qryRelQTD_REG.AsInteger;
            subtotal := subtotal + qryRelQTD_REG.AsInteger;
//            tipo_prod_ant := qryRelFAMILIA.AsString;
//            qryRel.Next;
//            tipo_prod_atual := qryRelFAMILIA.AsString;
          end
          else
          begin
            Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
            Writeln(Rel, format('%-10.10s%',['Sub-Total'])+StringOfChar('.', 58)+ format('%4.4d',[subtotal]));
            Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
            Writeln(Rel, ' ');
            subtotal := StrToInt('0');
            sRel := format('%-32.32s%',[UpperCase(qryRelFAMILIA.AsString)]); //'   ' +
            sRel := sRel+format('%4.4d',[(qryRelQTD_REG.AsInteger)]) + format('%-01.01s%',['']);
            sRel := sRel+format('%-33.33s%',[UpperCase(qryRelDS_MOTIVO.AsString)]);
            sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelCD_MOTIVO.AsString))]);
            Writeln(Rel, sRel);
//            Writeln(Rel, sRel);
            inc(contador);
            totalgeral := totalgeral + qryRelQTD_REG.AsInteger;
            subtotal := qryRelQTD_REG.AsInteger + subtotal;
            tipo_prod_ant := qryRelFAMILIA.AsString;
          //  qryRel.Next;
          //  tipo_prod_atual := qryRelFAMILIA.AsString;
          end;
          qryRel.Next;
        end;
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(Rel, format('%-10.10s%',['Sub-Total'])+StringOfChar('.', 60- Length(IntToStr(subtotal)))+ format('%4.4d',[subtotal]));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(rel,format('%-10.10s%',['Total'])+StringOfChar('.', 61-Length(IntToStr(totalgeral)))+ format('%4.4d',[totalgeral]));
      //  Writeln(Rel,  'Total' +''); //LPad('.', 62, '.') + //LPad(inttostr(totalgeral), 4, '0'));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Flush(rel);
        CloseFile(rel);
        Panel1.Caption := 'Relatório ' + ExtractFileName(sArq) + ' Gerado';
        Panel1.Refresh;
      end;
  end;

end;

procedure TfrmRelAnFAC.btnSairClick(Sender: TObject);
begin
  close;
end;

end.

