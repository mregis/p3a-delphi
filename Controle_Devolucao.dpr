program Controle_Devolucao;

uses
  Forms,
  Cadastro_Org_Bin in 'Cadastro_Org_Bin.pas' {OrgBinFrm},
  Cadastro_Org_Descricao in 'Cadastro_Org_Descricao.pas' {OrgDescricaoFrm},
  Cadastro_Produtos in 'Cadastro_Produtos.pas' {ProdutosFrm},
  CDAR in 'CDAR.pas' {frmAR},
  CDFac in 'CDFac.pas' {frmCartao},
  Devolucoes in 'Devolucoes.pas' {DevolucoesFrm},
  Main in 'Main.pas' {frmMain},
  unFamila in 'unFamila.pas' {cadFamilia},
  unRelAnAR in 'unRelAnAR.pas' {frmRelAnAR},
  unRelAnFAC in 'unRelAnFAC.pas' {frmRelAnFAC},
  CDDM in 'CDDM.pas' {DM: TDataModule},
  U_Func in 'U_Func.pas',
  U_FrmCadHost in 'U_FrmCadHost.pas' {FrmCadHost},
  RelMensal in 'RelMensal.pas' {qrForm_RelMensal},
  RelMotivos in 'RelMotivos.pas' {qrForm_RelMotivos},
  U_Frmdevcrtsnh in 'U_Frmdevcrtsnh.pas' {Frmdevcrtsnh},
  unRelAnFat in 'unRelAnFat.pas' {frmRelAnFAT},
  U_FrmRelTot in 'U_FrmRelTot.pas' {FrmRelTot},
  U_FrmCadUsuario in 'U_FrmCadUsuario.pas' {FrmCadUsuario},
  U_frmAcesso in 'U_frmAcesso.pas' {FrmAcesso},
  uGeraExcelDev in 'uGeraExcelDev.pas' {fGeraExcelDev},
  uGeraArqDev in 'uGeraArqDev.pas' {fGeraArqDev};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IBISIS - CONTROLE DEVOLUÇÃO';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  frmMain.Show;
  Application.CreateForm(TFrmAcesso, FrmAcesso);
  FrmAcesso.ShowModal;
  Application.Run;
  //  Application.CreateForm(TfrmExcel, frmExcel);
  //  Application.CreateForm(TDM, DM);
end.
