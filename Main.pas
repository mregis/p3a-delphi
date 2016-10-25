unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls;//basefc, base,
  // rxAnimate, rxGIFCtrl, Animate, GIFCtrl;

type
  TfrmMain = class(TForm)
//    AniGif: TRxGIFAnimator;
    MainMenu1: TMainMenu;
    Devolucao: TMenuItem;
    AR1: TMenuItem;
    Fac1: TMenuItem;
    Sair: TMenuItem;
    Correspondencias: TMenuItem;
    Relatorios: TMenuItem;
    AR2: TMenuItem;
    FAC2: TMenuItem;
    N1: TMenuItem;
    CadFamilia1: TMenuItem;
    RelatoriosAnalitcos1: TMenuItem;
    AR3: TMenuItem;
    FAC3: TMenuItem;
    GerarPlanilhas1: TMenuItem;
    StatusBar: TStatusBar;
    TimerMenu: TTimer;
    CartaSenha: TMenuItem;
    FAT3: TMenuItem;
    Totalizar: TMenuItem;
    Cadastros: TMenuItem;
    CadUsuario: TMenuItem;
    Logof: TMenuItem;
    RelAna: TMenuItem;
    RelSin: TMenuItem;
    GerarArqDevoluo1: TMenuItem;
    GerarPlanilhadeDevoluo1: TMenuItem;
    procedure GerarPlanilhadeDevoluo1Click(Sender: TObject);
    procedure GerarArqDevoluo1Click(Sender: TObject);
    procedure RelSinClick(Sender: TObject);
    procedure RelAnaClick(Sender: TObject);
    procedure LogofClick(Sender: TObject);
    procedure CadUsuarioClick(Sender: TObject);
    procedure FAT3Click(Sender: TObject);
    procedure CartaSenhaClick(Sender: TObject);
    procedure TimerMenuTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fac1Click(Sender: TObject);
    procedure AR1Click(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure CorrespondenciasClick(Sender: TObject);
    procedure AR2Click(Sender: TObject);
    procedure FAC2Click(Sender: TObject);
    procedure CadFamilia1Click(Sender: TObject);
    procedure AR3Click(Sender: TObject);
    procedure FAC3Click(Sender: TObject);
    procedure GerarPlanilhas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses unRelFAC, unRelAR, CDFac, CDAR, Devolucoes, unFamila, unRelAnFAC, unRelAnAR, unExcel,
  CDDM, U_Frmdevcrtsnh, unRelAnFat, U_FrmRelTot, U_FrmCadUsuario, RelMotivos,
  U_frmAcesso, uGeraArqDev, uGeraExcelDev;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  sDir: string;
begin
//  sDir := ExtractFilePath(Application.ExeName);
//  AniGif.Image.LoadFromFile(sdir + 'img\menu.gif');
//  AniGif.Align := alClient;

//  Caption := Caption + ' - Versão : ' + ExtraiVersionInfo(Application.ExeName, 'FileVersion');

//  if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Relatorios\') then
//    CreateDirectory(pchar(ExtractFilePath(Application.exename) + 'Relatorios\'), nil);

end;

procedure TfrmMain.Fac1Click(Sender: TObject);
begin
  frmCartao := TfrmCartao.Create(self);
  frmCartao.ShowModal;
  frmCartao.Free;
end;

procedure TfrmMain.RelAnaClick(Sender: TObject);
begin
  FrmRelTot  :=  TFrmRelTot.create(self);
  FrmRelTot.Tag :=  0;
  FrmRelTot.ShowModal;
  FrmRelTot.Free;

end;

procedure TfrmMain.RelSinClick(Sender: TObject);
begin
  FrmRelTot  :=  TFrmRelTot.create(self);
  FrmRelTot.Tag :=  1;
  FrmRelTot.ShowModal;

  FrmRelTot.Free;

end;

procedure TfrmMain.AR1Click(Sender: TObject);
begin
  frmAR := TfrmAR.Create(self);
  frmAR.ShowModal;
  SetFocus;
  frmAR.Free;
end;

procedure TfrmMain.SairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.TimerMenuTimer(Sender: TObject);
begin
  StatusBar.Panels[2].Text  :=  FormatDateTime('dd/mm/yyyy',DM.dtatu)+' : '+TimeToStr(Time);
end;

procedure TfrmMain.CorrespondenciasClick(Sender: TObject);
begin
  DevolucoesFrm := TDevolucoesFrm.Create(self);
  DevolucoesFrm.ShowModal;
  DevolucoesFrm.Free;
end;

procedure TfrmMain.AR2Click(Sender: TObject);
begin
  frmRelAr := TfrmRelAr.Create(Self);
  frmRelAr.ShowModal;
  frmRelAr.Free;
end;

procedure TfrmMain.FAC2Click(Sender: TObject);
begin
  frmRelFAC := TfrmRelFAC.Create(Self);
  frmRelFAC.ShowModal;
  frmRelFAC.Free;
end;

procedure TfrmMain.CadFamilia1Click(Sender: TObject);
begin
  cadFamilia := TcadFamilia.Create(Self);
  cadFamilia.ShowModal;
  cadFamilia.Free;

end;

procedure TfrmMain.CadUsuarioClick(Sender: TObject);
begin
  FrmCadUsuario :=  TFrmCadUsuario.Create(Self);
  FrmCadUsuario.ShowModal;
  FrmCadUsuario.Free;
end;

procedure TfrmMain.CartaSenhaClick(Sender: TObject);
begin
  Frmdevcrtsnh  :=  TFrmdevcrtsnh.Create(Self);
  Frmdevcrtsnh.ShowModal;
  Frmdevcrtsnh.Free;
end;

procedure TfrmMain.AR3Click(Sender: TObject);
begin
  frmRelAnAR := TfrmRelAnAR.Create(Self);
  frmRelAnAR.ShowModal;
  frmRelAnAR.Free;
end;

procedure TfrmMain.FAC3Click(Sender: TObject);
begin
  frmRelAnFAC := TfrmRelAnFAC.Create(Self);
  frmRelAnFAC.ShowModal;
  frmRelAnFAC.Free;
end;

procedure TfrmMain.FAT3Click(Sender: TObject);
begin
  frmRelAnFAT := TfrmRelAnFAT.Create(Self);
  frmRelAnFAT.ShowModal;
  frmRelAnFAT.Free;

end;

procedure TfrmMain.GerarArqDevoluo1Click(Sender: TObject);
begin
  fGeraArqDev := TfGeraArqDev.Create(Self);
  fGeraArqDev.ShowModal;
  fGeraArqDev.Free;
end;

procedure TfrmMain.GerarPlanilhadeDevoluo1Click(Sender: TObject);
begin
  fGeraExcelDev := TfGeraExcelDev.Create(Self);
  fGeraExcelDev.ShowModal;
  fGeraExcelDev.Free;
end;

procedure TfrmMain.GerarPlanilhas1Click(Sender: TObject);
begin
  frmExcel := TfrmExcel.Create(Self);
  frmExcel.ShowModal;
  frmExcel.Free;
end;

procedure TfrmMain.LogofClick(Sender: TObject);
begin
  FrmAcesso :=  TFrmAcesso.Create(Self);
  FrmAcesso.ShowModal;
  FrmAcesso.Free;
end;


end.

