unit unRelAnFat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZDataset, ExtCtrls, StdCtrls, Buttons,
  ComCtrls;

type
  TfrmRelAnFAT = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DTPinicial: TDateTimePicker;
    DTPFinal: TDateTimePicker;
    btnProc: TBitBtn;
    Btnsair: TBitBtn;
    Panel1: TPanel;
    qryRelFAT: TZReadOnlyQuery;
    qryRelFATqtd_reg: TLargeintField;
    qryRelFATds_motivo: TStringField;
    qryRelFATcd_motivo: TStringField;
    qryRelFATfamilia: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnProcClick(Sender: TObject);
    procedure BtnsairClick(Sender: TObject);
  private
  rel: TextFile;
  sRel, sArq: string;
  contador: integer;
  totalgeral, subtotal: integer;
  tipo_prod_ant: string;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelAnFAT: TfrmRelAnFAT;

implementation

uses Main, CDDM;

{$R *.dfm}

procedure TfrmRelAnFAT.btnProcClick(Sender: TObject);
begin
  sArq := DM.relatdir;
  sArq  :=  sArq + 'RelatorioAnaliticoFAT_' + FormatDateTime('DD_MM_YYYY', DTPinicial.DateTime) + '_A_' + FormatDateTime('DD_MM_YYYY', DTPFinal.DateTime) + '.TXT';
  qryRelFAT.Close;
  qryRelFAT.ParamByName('DT_INI').AsDate := DTPinicial.Date;
  qryRelFAT.ParamByName('DT_FIM').AsDate := DTPFinal.Date;

  qryRelFAT.Open;

  qryRelFAT.First;
  case qryRelFAT.RecordCount of
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
        Writeln(REL, format('%-72.72s%',['PROCESSAMENTO DE ' + FormatDateTime('dd/mm/yyyy',DTPinicial.Date) + ' A ' + FormatDateTime('dd/mm/yyyy',DTPFinal.Date)]));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(rel, format('%-72.72s%',['']));
        Writeln(rel, format('%-72.72s%',['            RESUMO DO CONTROLE DE DEVOLUCOES     -    FATURA']));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(Rel, format('%-32.328s%',['Tipo Prod'])+format('%-5.5s%',['QTDE'])+format('%-28.28s%',['Motivo'])+ format('%-7.7s%',['Cod Mot']));
        Writeln(Rel, format('%-72.72s%',[StringOfChar('_',72)]));

        //ShowMessage('REL');

        qryRelFAT.First;
        tipo_prod_ant   := qryRelFATFAMILIA.AsString;
        while not qryRelFAT.Eof do
        begin
          {if contador = 0 then
          begin
            sRel := format('%-28.28s%',[UpperCase(qryRelFATFAMILIA.AsString)]); //'   ' +
            sRel := sRel+format('%4.4d',[(qryRelFATQTD_REG.AsInteger)]) + format('%-05.05s%',['']);
            sRel := sRel+format('%-33.33s%',[UpperCase(qryRelFATDS_MOTIVO.AsString)]);
            sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelFATCD_MOTIVO.AsString))]);
            Writeln(Rel, sRel);
            inc(contador);
            totalgeral := totalgeral + qryRelFATQTD_REG.AsInteger;
            subtotal := subtotal + qryRelFATQTD_REG.AsInteger;
            qryRelFAT.Next;
            tipo_prod_atual := qryRelFATFAMILIA.AsString;
            tipo_prod_ant   := qryRelFATFAMILIA.AsString;
          end;}

          if  (qryRelFATFAMILIA.AsString = tipo_prod_ant) then
          begin
            sRel := format('%-32.32s%',[UpperCase(qryRelFATFAMILIA.AsString)]); //'   ' +
            sRel := sRel+format('%4.4d',[(qryRelFATQTD_REG.AsInteger)]) + format('%-01.01s%',['']);
            sRel := sRel+format('%-33.33s%',[UpperCase(qryRelFATDS_MOTIVO.AsString)]);
            sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelFATCD_MOTIVO.AsString))]);
            Writeln(Rel, sRel);

            inc(contador);
            totalgeral := totalgeral + qryRelFATQTD_REG.AsInteger;
            subtotal := subtotal + qryRelFATQTD_REG.AsInteger;
          //  tipo_prod_ant := qryRelFATFAMILIA.AsString;
           // tipo_prod_atual := qryRelFATFAMILIA.AsString;
          end
          else
          begin
            Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
            Writeln(Rel, format('%-10.10s%',['Sub-Total'])+StringOfChar('.', 59-Length(IntToStr(subtotal)))+ format('%4.4d',[subtotal]));
            Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
            Writeln(Rel, ' ');
            totalgeral := totalgeral + subtotal;
            subtotal := StrToInt('0');
            sRel := format('%-32.32s%',[UpperCase(qryRelFATFAMILIA.AsString)]); //'   ' +
            sRel := sRel+format('%4.4d',[(qryRelFATQTD_REG.AsInteger)]) + format('%-01.01s%',['']);
            sRel := sRel+format('%-33.33s%',[UpperCase(qryRelFATDS_MOTIVO.AsString)]);
            sRel := sRel+format('%2.2d',[StrToInt(UpperCase(qryRelFATCD_MOTIVO.AsString))]);
            Writeln(Rel, sRel);
            //Writeln(Rel, sRel);
            inc(contador);
//            totalgeral := totalgeral + qryRelFATQTD_REG.AsInteger;
            subtotal := qryRelFATQTD_REG.AsInteger + subtotal;
            tipo_prod_ant := qryRelFATFAMILIA.AsString;

            //qryRelFAT.Prior;
            //tipo_prod_atual := qryRelFATFAMILIA.AsString;
          end;
            qryRelFAT.Next;

        end;
{        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(Rel, format('%-10.10s%',['Sub-Total'])+StringOfChar('.', 58)+ format('%4.4d',[subtotal]));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(Rel, ' ');}
        totalgeral := totalgeral + subtotal;
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(Rel, format('%-10.10s%',['Sub-Total'])+StringOfChar('.', 59-Length(IntToStr(subtotal)))+ format('%4.4d',[subtotal]));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Writeln(rel,format('%-10.10s%',['Total'])+StringOfChar('.', 60-Length(IntToStr(totalgeral)))+ format('%4.4d',[totalgeral]));
      //  Writeln(Rel,  'Total' +''); //LPad('.', 62, '.') + //LPad(inttostr(totalgeral), 4, '0'));
        Writeln(rel, format('%-72.72s%',[StringOfChar('_',72)]));
        Flush(rel);
        CloseFile(rel);
        Panel1.Caption := 'Relatório ' + ExtractFileName(sArq) + ' Gerado';
        Panel1.Refresh;
      end;
  end;

end;

procedure TfrmRelAnFAT.BtnsairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRelAnFAT.FormCreate(Sender: TObject);
begin
  DTPinicial.Date := Now - 30;
  DTPFinal.Date := now;
end;

end.
