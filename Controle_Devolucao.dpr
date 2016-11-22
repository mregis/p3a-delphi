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
  U_FrmConfig in 'U_FrmConfig.pas' {U_FrmConfig},
  uGeraArqDev in 'uGeraArqDev.pas' {fGeraArqDev},
  U_FrmLeituraCartao in 'U_FrmLeituraCartao.pas' {FormLeituraCartao};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DEVOLUÇÕES DE FATURAS E CARTÕES';
  Application.CreateForm(TDm, Dm);
  if DM.CtrlDvlDBConn.Connected = true then
    begin
      Application.CreateForm(TFrmAcesso, FrmAcesso);
      FrmAcesso.ShowModal;
      Application.Run;
    end
  else
    begin
      Application.MessageBox(
        Pchar('O Sistema não conseguiu se conectar ao Banco de Dados! ' +
            'Entre em contato com o Administrador!'),
          Pchar(Application.Title), 0);
      Application.Terminate;
    end;

end.
