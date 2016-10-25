unit U_Frmdevcrtsnh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZConnection, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, DBCtrls;

type
  TFrmdevcrtsnh = class(TForm)
    Label6: TLabel;
    SqlAux: TZQuery;
    DtSAux: TDataSource;
    dbdevibicon: TZConnection;
    dsMotivos: TDataSource;
    qraMotivo: TZReadOnlyQuery;
    qraMotivoid: TIntegerField;
    qraMotivocd_motivo: TStringField;
    qraMotivods_motivo: TStringField;
    Bevel1: TBevel;
    lcCD_MOTIVO: TDBLookupComboBox;
    lblDS_MOTIVO: TLabel;
    lcCD_PRODUTO: TDBLookupComboBox;
    lblDS_PRODUTO: TLabel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbDT_INICIAL: TDateTimePicker;
    cbDT_FINAL: TDateTimePicker;
    BtnRelatorio1: TBitBtn;
    btRelMensal: TBitBtn;
    Edarq: TEdit;
    pmsg: TPanel;
    BtnCloseConsistencia: TBitBtn;
    Edcod: TEdit;
    procedure EdcodKeyPress(Sender: TObject; var Key: Char);
    procedure lcCD_MOTIVOKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lcCD_MOTIVOKeyPress(Sender: TObject; var Key: Char);
    procedure lcCD_MOTIVOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lcCD_MOTIVOClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCloseConsistenciaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure salvareg;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmdevcrtsnh: TFrmdevcrtsnh;

implementation

uses Main, U_Func;

{$R *.dfm}

procedure TFrmdevcrtsnh.BtnCloseConsistenciaClick(Sender: TObject);
begin
  close;
end;
procedure TFrmdevcrtsnh.salvareg;
begin
  SqlAux.Close;
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add('insert into ibi_crtsnh_dev (nrocta,codmot,codbin) values (:nrocta,:codmot,:codbin)');
  SqlAux.ParamByName('nrocta').AsString :=  trim(Edcod.Text);
  SqlAux.ParamByName('codmot').Value    :=  lcCD_MOTIVO.KeyValue;
  SqlAux.ParamByName('codbin').AsString :=  copy(trim(Edcod.Text),1,6);
  try
    SqlAux.ExecSQL;
  except on e:exception do
    pmsg.Caption  :=  e.Message;
  end;
  Edcod.Clear;
end;
procedure TFrmdevcrtsnh.EdcodKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      if (vernum(Edcod.Text)=false) or (trim(Edcod.Text)='') then
        begin
          pmsg.Caption  :=  'Erro: ';
          Edcod.Clear;
          exit;
        end
      else
        begin
          salvareg;
        end;
    end;

end;

procedure TFrmdevcrtsnh.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action  :=  caFree;
end;

procedure TFrmdevcrtsnh.FormCreate(Sender: TObject);
begin
  dbdevibicon.Connected :=  true;
  self.qraMotivo.Open;
end;

procedure TFrmdevcrtsnh.lcCD_MOTIVOClick(Sender: TObject);
begin
  lblDS_MOTIVO.Caption  :=   qraMotivo.FieldByName('DS_MOTIVO').AsString;
  Edcod.SetFocus;
end;

procedure TFrmdevcrtsnh.lcCD_MOTIVOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Frmdevcrtsnh.lcCD_MOTIVOClick(SELF);
end;

procedure TFrmdevcrtsnh.lcCD_MOTIVOKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #119 then
    lcCD_MOTIVO.KeyValue  :=  Null;
  if key = #13 then
    Frmdevcrtsnh.lcCD_MOTIVOClick(self);
end;

procedure TFrmdevcrtsnh.lcCD_MOTIVOKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    Frmdevcrtsnh.lcCD_MOTIVOClick(self);
end;

end.
