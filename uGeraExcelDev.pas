unit uGeraExcelDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ComObj, DateUtils, Mask, DBCtrls;

type
  arrayDate = Array of TDate;

type
  TfGeraExcelDev = class(TForm)
    group: TGroupBox;
    lbldata: TLabel;
    Status: TStatusBar;
    panelBarra: TPanel;
    ProgressBar: TProgressBar;
    btnGerar: TBitBtn;
    TBLIMITE: TZQuery;
    TBDATAS: TZQuery;
    TBDEV: TZQuery;
    TBDEVFAC: TZQuery;
    TBDEVAR: TZQuery;
    TBFAMILIA: TZQuery;
    TBMOTIVO: TZQuery;
    TBCONSOLIDA: TZQuery;
    SaveDialog: TSaveDialog;
    cbdtini: TDateTimePicker;
    cbdtfim: TDateTimePicker;
    Label1: TLabel;
    cbgrupo: TComboBox;
    TB_AUX: TZQuery;
    LblProduto: TLabel;
    lcCD_SERVICO: TDBLookupComboBox;
    lblPlanilha: TLabel;
    procedure cbgrupoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbgrupoClick(Sender: TObject);
    procedure lcCD_SERVICOKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lcCD_SERVICOClick(Sender: TObject);
    procedure cbgrupoEndDock(Sender, Target: TObject; X, Y: Integer);
    procedure cbgrupoDropDown(Sender: TObject);
    procedure cbdtiniChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    idini1, idini2, idini3, idfim1, idfim2, idfim3 : Integer;
    xDtInicial, xDtFinal : TDate;
    arrayDataDev, arrayDataDevAR, arrayDataDevFAC : arrayDate;
    listOfQuery : TList;
    grupoId : Integer;
    familia : Boolean;

    Function AjustarProgressBar(progress : TProgressBar; arrayQuery : TList) : Boolean;
    Function AbrirTabelasDevolucoes(dtini : TDate; dtfim : TDate) : Boolean;
    Procedure ListarDatas(dtini : TDate; dtfim : TDate);
    Procedure LimitarRegistros(dtini : TDate; dtfim : TDate);
    Function GerarExcelDevolucao(Query : TZQuery; nomeAba : String; excel : Variant; datas : arrayDate) : Boolean;
    Function GerarExcelConsolidado(nomeAba : String; excel : Variant) : Boolean;
    Function MontarFiltroGrupoBIN(grupo : integer; semFamilia : Boolean) : String;
  public
    { Public declarations }
  end;

var
  fGeraExcelDev: TfGeraExcelDev;

implementation

uses CDDM;

{$R *.dfm}

Function TfGeraExcelDev.MontarFiltroGrupoBIN(grupo : integer; semFamilia : Boolean) : String;
begin
  try
    if semFamilia then
    begin
      Result := ' NOT IN(SELECT DISTINCT F.CODBIN FROM GRUPO_FAMILIA G JOIN IBI_CADASTRO_FAMILIA F ON F.ID = G.ID_FAMILIA WHERE G.ID_GRUPO <> ' + IntToStr(grupo)+')';
    end
    else
    begin
      Result := ' IN(SELECT DISTINCT F.CODBIN FROM GRUPO_FAMILIA G JOIN IBI_CADASTRO_FAMILIA F ON F.ID = G.ID_FAMILIA WHERE G.ID_GRUPO = ' + IntToStr(grupo)+')';
    end;
  except
    on E: Exception do
    begin
      
    end;
  end;
end;

Function TfGeraExcelDev.AjustarProgressBar(progress : TProgressBar; arrayQuery : TList) : Boolean;
var
  I: Integer;
begin
  try
    progress.Min      := 0;
    progress.Max      := 0;
    progress.Position := 0;
    progress.Step     := 1;

    for I := 0 to arrayQuery.Count - 1 do
    begin
      progress.Max := progress.Max + TZQuery(arrayQuery.Items[I]).RecordCount;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

Function TfGeraExcelDev.AbrirTabelasDevolucoes(dtini : TDate; dtfim : TDate) : Boolean;
begin
  try
    TBDEV.Close;
    TBDEV.SQL.Clear;
    TBDEV.Params.Clear;
    TBDEV.SQL.Add('SELECT');
    TBDEV.SQL.Add('   COALESCE(F.FAMILIA, ''SEM FAMILIA'') AS FAMILIA, DV.DT_DEVOLUCAO, M.CD_MOTIVO,');
    TBDEV.SQL.Add('   M.DS_MOTIVO, COUNT(DV.ID) AS QTDDIA');
    TBDEV.SQL.Add('FROM');
    TBDEV.SQL.Add('        CEA_CONTROLE_DEVOLUCOES DV');
    TBDEV.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBDEV.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBDEV.SQL.Add('   LEFT JOIN IBI_CADASTRO_FAMILIA F ON F.CODBIN = DV.CODBIN');
    TBDEV.SQL.Add('WHERE');
    TBDEV.SQL.Add('       DV.ID >= :XPIDINI');
    TBDEV.SQL.Add('   AND DV.ID <= :XPIDFIM');
    TBDEV.SQL.Add('   AND DV.DT_DEVOLUCAO >= :XPDTINI');
    TBDEV.SQL.Add('   AND DV.DT_DEVOLUCAO <= :XPDTFIM');
    TBDEV.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBDEV.SQL.Add('   AND S.id= :SERVICO ');
    TBDEV.SQL.Add('GROUP BY');
    TBDEV.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, DV.DT_DEVOLUCAO');
    TBDEV.SQL.Add('ORDER BY');
    TBDEV.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, DV.DT_DEVOLUCAO DESC');
    TBDEV.ParamByName('XPIDINI').AsInteger := idini1;
    TBDEV.ParamByName('XPIDFIM').AsInteger := idfim1;
    TBDEV.ParamByName('XPDTINI').AsDate    := xDtInicial;
    TBDEV.ParamByName('XPDTFIM').AsDate    := xDtFinal;
    TBDEV.ParamByName('SERVICO').AsInteger := lcCD_SERVICO.KeyValue;
    TBDEV.Open;

    TBDEVAR.Close;
    TBDEVAR.SQL.Clear;
    TBDEVAR.Params.Clear;
    TBDEVAR.SQL.Add('SELECT');
    TBDEVAR.SQL.Add('   COALESCE(F.FAMILIA, ''SEM FAMILIA'') AS FAMILIA, DV.DT_DEVOLUCAO, M.CD_MOTIVO,');
    TBDEVAR.SQL.Add('   M.DS_MOTIVO, COUNT(DV.ID) AS QTDDIA');
    TBDEVAR.SQL.Add('FROM');
    TBDEVAR.SQL.Add('        IBI_CONTROLE_DEVOLUCOES_AR DV');
    TBDEVAR.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBDEVAR.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBDEVAR.SQL.Add('   LEFT JOIN IBI_CADASTRO_FAMILIA F ON F.CODBIN = DV.CODBIN');
    TBDEVAR.SQL.Add('WHERE');
    TBDEVAR.SQL.Add('       DV.ID >= :XPIDINI');
    TBDEVAR.SQL.Add('   AND DV.ID <= :XPIDFIM');
    TBDEVAR.SQL.Add('   AND DV.DT_DEVOLUCAO >= :XPDTINI');
    TBDEVAR.SQL.Add('   AND DV.DT_DEVOLUCAO <= :XPDTFIM');
    TBDEVAR.SQL.Add('   AND DV.CODBIN '+ MontarFiltroGrupoBIN(grupoId, familia));
    TBDEVAR.SQL.Add('   AND S.id=:SERVICO ');
    TBDEVAR.SQL.Add('GROUP BY');
    TBDEVAR.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, DV.DT_DEVOLUCAO');
    TBDEVAR.SQL.Add('ORDER BY');
    TBDEVAR.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, DV.DT_DEVOLUCAO DESC');
    TBDEVAR.ParamByName('XPIDINI').AsInteger := idini2;
    TBDEVAR.ParamByName('XPIDFIM').AsInteger := idfim2;
    TBDEVAR.ParamByName('XPDTINI').AsDate    := xDtInicial;
    TBDEVAR.ParamByName('XPDTFIM').AsDate    := xDtFinal;
    TBDEVAR.ParamByName('SERVICO').AsInteger := lcCD_SERVICO.KeyValue;
    TBDEVAR.Open;

    TBDEVFAC.Close;
    TBDEVFAC.SQL.Clear;
    TBDEVFAC.Params.Clear;
    TBDEVFAC.SQL.Add('SELECT');
    TBDEVFAC.SQL.Add('   COALESCE(F.FAMILIA, ''SEM FAMILIA'') AS FAMILIA, DV.DT_DEVOLUCAO, M.CD_MOTIVO,');
    TBDEVFAC.SQL.Add('   M.DS_MOTIVO, COUNT(DV.ID) AS QTDDIA');
    TBDEVFAC.SQL.Add('FROM');
    TBDEVFAC.SQL.Add('        IBI_CONTROLE_DEVOLUCOES_FAC DV');
    TBDEVFAC.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBDEVFAC.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBDEVFAC.SQL.Add('   LEFT JOIN IBI_CADASTRO_FAMILIA F ON F.CODBIN = DV.CODBIN');
    TBDEVFAC.SQL.Add('WHERE');
    TBDEVFAC.SQL.Add('       DV.ID >= :XPIDINI');
    TBDEVFAC.SQL.Add('   AND DV.ID <= :XPIDFIM');
    TBDEVFAC.SQL.Add('   AND DV.DT_DEVOLUCAO >= :XPDTINI');
    TBDEVFAC.SQL.Add('   AND DV.DT_DEVOLUCAO <= :XPDTFIM');
    TBDEVFAC.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBDEVFAC.SQL.Add('   AND S.id=:SERVICO ');
    TBDEVFAC.SQL.Add('GROUP BY');
    TBDEVFAC.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, DV.DT_DEVOLUCAO');
    TBDEVFAC.SQL.Add('ORDER BY');
    TBDEVFAC.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, DV.DT_DEVOLUCAO DESC');
    TBDEVFAC.ParamByName('XPIDINI').AsInteger := idini3;
    TBDEVFAC.ParamByName('XPIDFIM').AsInteger := idfim3;
    TBDEVFAC.ParamByName('XPDTINI').AsDate    := xDtInicial;
    TBDEVFAC.ParamByName('XPDTFIM').AsDate    := xDtFinal;
    TBDEVFAC.ParamByName('SERVICO').AsInteger := lcCD_SERVICO.KeyValue;
    TBDEVFAC.Open;

    TBCONSOLIDA.Close;
    TBCONSOLIDA.SQL.Clear;
    TBCONSOLIDA.Params.Clear;

    //BEGIN CORREÇÃO 13-02-2013 ERRO AO TOTALIZAR CONSOLIDADO PARTE 1 DE 3 - MATHEUS
    TBCONSOLIDA.SQL.Add('SELECT FAMILIA, CD_MOTIVO, DS_MOTIVO, SUM(QTDMOT) AS QTDMOT FROM (');
    //END CORREÇÃO 13-02-2013 ERRO AO TOTALIZAR CONSOLIDADO PARTE 1 DE 3 - MATHEUS

    TBCONSOLIDA.SQL.Add('SELECT');
    TBCONSOLIDA.SQL.Add('   COALESCE(F.FAMILIA, ''SEM FAMILIA'') AS FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, COUNT(DV.ID) AS QTDMOT');
    TBCONSOLIDA.SQL.Add('FROM');
    TBCONSOLIDA.SQL.Add('        CEA_CONTROLE_DEVOLUCOES DV');
    TBCONSOLIDA.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBCONSOLIDA.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBCONSOLIDA.SQL.Add('   LEFT JOIN IBI_CADASTRO_FAMILIA F ON F.CODBIN = DV.CODBIN');
    TBCONSOLIDA.SQL.Add('WHERE');
    TBCONSOLIDA.SQL.Add('       DV.ID >= :XPIDINI1');
    TBCONSOLIDA.SQL.Add('   AND DV.ID <= :XPIDFIM1');
    TBCONSOLIDA.SQL.Add('   AND DV.DT_DEVOLUCAO >= :XPDTINI1');
    TBCONSOLIDA.SQL.Add('   AND DV.DT_DEVOLUCAO <= :XPDTFIM1');
    TBCONSOLIDA.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBCONSOLIDA.SQL.Add('   AND S.id= :SERVICO ');
    TBCONSOLIDA.SQL.Add('GROUP BY');
    TBCONSOLIDA.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO');
    TBCONSOLIDA.SQL.Add('UNION ALL');
    TBCONSOLIDA.SQL.Add('SELECT');
    TBCONSOLIDA.SQL.Add('   COALESCE(F.FAMILIA, ''SEM FAMILIA'') AS FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, COUNT(DV.ID) AS QTDMOT');
    TBCONSOLIDA.SQL.Add('FROM');
    TBCONSOLIDA.SQL.Add('        IBI_CONTROLE_DEVOLUCOES_AR DV');
    TBCONSOLIDA.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBCONSOLIDA.SQL.Add('   INNER JOIN SERVICOS S ON M.servico_id = S.id');
    TBCONSOLIDA.SQL.Add('   LEFT JOIN IBI_CADASTRO_FAMILIA F ON F.CODBIN = DV.CODBIN');
    TBCONSOLIDA.SQL.Add('WHERE');
    TBCONSOLIDA.SQL.Add('       DV.ID >= :XPIDINI2');
    TBCONSOLIDA.SQL.Add('   AND DV.ID <= :XPIDFIM2');
    TBCONSOLIDA.SQL.Add('   AND DV.DT_DEVOLUCAO >= :XPDTINI2');
    TBCONSOLIDA.SQL.Add('   AND DV.DT_DEVOLUCAO <= :XPDTFIM2');
    TBCONSOLIDA.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBCONSOLIDA.SQL.Add('   AND S.id= :SERVICO2 ');
    TBCONSOLIDA.SQL.Add('GROUP BY');
    TBCONSOLIDA.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO');
    TBCONSOLIDA.SQL.Add('UNION ALL');
    TBCONSOLIDA.SQL.Add('SELECT');
    TBCONSOLIDA.SQL.Add('   COALESCE(F.FAMILIA, ''SEM FAMILIA'') AS FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO, COUNT(DV.ID) AS QTDMOT');
    TBCONSOLIDA.SQL.Add('FROM');
    TBCONSOLIDA.SQL.Add('        IBI_CONTROLE_DEVOLUCOES_FAC DV');
    TBCONSOLIDA.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBCONSOLIDA.SQL.Add('   INNER JOIN SERVICOS S ON M.servico_id = S.id');
    TBCONSOLIDA.SQL.Add('   LEFT JOIN IBI_CADASTRO_FAMILIA F ON F.CODBIN = DV.CODBIN');

    TBCONSOLIDA.SQL.Add('WHERE');
    TBCONSOLIDA.SQL.Add('       DV.ID >= :XPIDINI3');
    TBCONSOLIDA.SQL.Add('   AND DV.ID <= :XPIDFIM3');
    TBCONSOLIDA.SQL.Add('   AND DV.DT_DEVOLUCAO >= :XPDTINI3');
    TBCONSOLIDA.SQL.Add('   AND DV.DT_DEVOLUCAO <= :XPDTFIM3');
    TBCONSOLIDA.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBCONSOLIDA.SQL.Add('   AND S.id= :SERVICO3 ');
    TBCONSOLIDA.SQL.Add('GROUP BY');
    TBCONSOLIDA.SQL.Add('   F.FAMILIA, M.CD_MOTIVO, M.DS_MOTIVO');
    TBCONSOLIDA.SQL.Add('ORDER BY');
    TBCONSOLIDA.SQL.Add('   1, 3');

    //BEGIN CORREÇÃO 13-02-2013 ERRO AO TOTALIZAR CONSOLIDADO PARTE 2 DE 3 - MATHEUS
    TBCONSOLIDA.SQL.Add(') AS SOMADEV GROUP BY FAMILIA, CD_MOTIVO, DS_MOTIVO ORDER BY 1, 3');
    //BEGIN CORREÇÃO 13-02-2013 ERRO AO TOTALIZAR CONSOLIDADO PARTE 2 DE 3 - MATHEUS

    TBCONSOLIDA.ParamByName('XPIDINI1').AsInteger := idini1;
    TBCONSOLIDA.ParamByName('XPIDFIM1').AsInteger := idfim1;
    TBCONSOLIDA.ParamByName('XPDTINI1').AsDate    := xDtInicial;
    TBCONSOLIDA.ParamByName('XPDTFIM1').AsDate    := xDtFinal;
    TBCONSOLIDA.ParamByName('SERVICO').AsInteger  := lcCD_SERVICO.KeyValue;
    TBCONSOLIDA.ParamByName('XPIDINI2').AsInteger := idini2;
    TBCONSOLIDA.ParamByName('XPIDFIM2').AsInteger := idfim2;
    TBCONSOLIDA.ParamByName('XPDTINI2').AsDate    := xDtInicial;
    TBCONSOLIDA.ParamByName('XPDTFIM2').AsDate    := xDtFinal;
    TBCONSOLIDA.ParamByName('SERVICO2').AsInteger  := lcCD_SERVICO.KeyValue;
    TBCONSOLIDA.ParamByName('XPIDINI3').AsInteger := idini3;
    TBCONSOLIDA.ParamByName('XPIDFIM3').AsInteger := idfim3;
    TBCONSOLIDA.ParamByName('XPDTINI3').AsDate    := xDtInicial;
    TBCONSOLIDA.ParamByName('XPDTFIM3').AsDate    := xDtFinal;
    TBCONSOLIDA.ParamByName('SERVICO3').AsInteger  := lcCD_SERVICO.KeyValue;

    TBCONSOLIDA.Open;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

Procedure TfGeraExcelDev.ListarDatas(dtini : TDate; dtfim : TDate);
begin
  try
    arrayDataDev    := nil;
    arrayDataDevAR  := nil;
    arrayDataDevFAC := nil;


    LimitarRegistros(dtini, dtfim);
    if (TBLIMITE.IsEmpty) or
       (TBLIMITE.RecordCount <= 0) then
    begin
      Exit;
    end;

    TBDATAS.Close;
    TBDATAS.SQL.Clear;
    TBDATAS.Params.Clear;
    TBDATAS.SQL.Add('SELECT');
    TBDATAS.SQL.Add('   DISTINCT DV.DT_DEVOLUCAO, ''DEV'' AS TPDEV');
    TBDATAS.SQL.Add('FROM CEA_CONTROLE_DEVOLUCOES DV');
    TBDATAS.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBDATAS.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBDATAS.SQL.Add('WHERE');
    TBDATAS.SQL.Add('       DV.DT_DEVOLUCAO >= :XPDTINI1');
    TBDATAS.SQL.Add('   AND DV.DT_DEVOLUCAO <= :XPDTFIM1');
    TBDATAS.SQL.Add('   AND DV.ID >= :XPIDINI1');
    TBDATAS.SQL.Add('   AND DV.ID <= :XPIDFIM1');
    TBDATAS.SQL.Add('   AND CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBDATAS.SQL.Add('   AND S.id=:SERVICO');

    TBDATAS.SQL.Add('UNION');
    TBDATAS.SQL.Add('SELECT');
    TBDATAS.SQL.Add('   DISTINCT ars.DT_DEVOLUCAO, ''DEV_AR'' AS TPDEV');
    TBDATAS.SQL.Add('FROM IBI_CONTROLE_DEVOLUCOES_AR ars');
    TBDATAS.SQL.Add('   INNER JOIN LOTE l on (ars.lote_id = l.id) ');
    TBDATAS.SQL.Add('WHERE ars.DT_DEVOLUCAO >= :XPDTINI2');
    TBDATAS.SQL.Add('   AND ars.DT_DEVOLUCAO <= :XPDTFIM2');
    TBDATAS.SQL.Add('   AND ars.ID >= :XPIDINI2');
    TBDATAS.SQL.Add('   AND ars.ID <= :XPIDFIM2');
    TBDATAS.SQL.Add('   AND l.id = :SERVICO2');
    TBDATAS.SQL.Add('   AND ars.CODBIN ' + MontarFiltroGrupoBIN(grupoId, familia));

    TBDATAS.SQL.Add('UNION');
    TBDATAS.SQL.Add('SELECT');
    TBDATAS.SQL.Add('   DISTINCT FAC.DT_DEVOLUCAO, ''DEV_FAC'' AS TPDEV');
    TBDATAS.SQL.Add('FROM IBI_CONTROLE_DEVOLUCOES_FAC FAC');
    TBDATAS.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = FAC.CD_MOTIVO');
    TBDATAS.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBDATAS.SQL.Add('WHERE');
    TBDATAS.SQL.Add('       FAC.DT_DEVOLUCAO >= :XPDTINI3');
    TBDATAS.SQL.Add('   AND FAC.DT_DEVOLUCAO <= :XPDTFIM3');
    TBDATAS.SQL.Add('   AND FAC.ID >= :XPIDINI3');
    TBDATAS.SQL.Add('   AND FAC.ID <= :XPIDFIM3');
    TBDATAS.SQL.Add('   AND FAC. CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBDATAS.SQL.Add('   AND S.id=:SERVICO3');
    TBDATAS.SQL.Add('ORDER BY');
    TBDATAS.SQL.Add('   TPDEV, DT_DEVOLUCAO DESC');
    TBDATAS.ParamByName('XPDTINI1').AsDate    := dtini;
    TBDATAS.ParamByName('XPDTFIM1').AsDate    := dtfim;
    TBDATAS.ParamByName('XPDTINI2').AsDate    := dtini;
    TBDATAS.ParamByName('XPDTFIM2').AsDate    := dtfim;
    TBDATAS.ParamByName('XPDTINI3').AsDate    := dtini;
    TBDATAS.ParamByName('XPDTFIM3').AsDate    := dtfim;
    TBDATAS.ParamByName('XPIDINI1').AsInteger := idini1;
    TBDATAS.ParamByName('XPIDFIM1').AsInteger := idfim1;
    TBDATAS.ParamByName('XPIDINI2').AsInteger := idini2;
    TBDATAS.ParamByName('XPIDFIM2').AsInteger := idfim2;
    TBDATAS.ParamByName('XPIDINI3').AsInteger := idini3;
    TBDATAS.ParamByName('XPIDFIM3').AsInteger := idfim3;
    TBDATAS.ParamByName('SERVICO').AsInteger := lcCD_SERVICO.KeyValue;
    TBDATAS.ParamByName('SERVICO2').AsInteger := lcCD_SERVICO.KeyValue;
    TBDATAS.ParamByName('SERVICO3').AsInteger := lcCD_SERVICO.KeyValue;

    TBDATAS.Open;

    arrayDataDev    := nil;
    arrayDataDevAR  := nil;
    arrayDataDevFAC := nil;
    if (not TBDATAS.IsEmpty) and
       (TBDATAS.RecordCount >= 1) then
    begin
      SetLength(arrayDataDev, 0);
      SetLength(arrayDataDevAR, 0);
      SetLength(arrayDataDevFAC, 0);

      TBDATAS.First;
      while not TBDATAS.Eof do
      begin

        if TBDATAS.FieldByName('TPDEV').AsString = 'DEV' then
        begin
          SetLength(arrayDataDev, Length(arrayDataDev)+1);
          arrayDataDev[Length(arrayDataDev)-1] := TBDATAS.FieldByName('DT_DEVOLUCAO').AsDateTime;
        end;

        if TBDATAS.FieldByName('TPDEV').AsString = 'DEV_AR' then
        begin
          SetLength(arrayDataDevAR, Length(arrayDataDevAR)+1);
          arrayDataDevAR[Length(arrayDataDevAR)-1] := TBDATAS.FieldByName('DT_DEVOLUCAO').AsDateTime;
        end;

        if TBDATAS.FieldByName('TPDEV').AsString = 'DEV_FAC' then
        begin
          SetLength(arrayDataDevFAC, Length(arrayDataDevFAC)+1);
          arrayDataDevFAC[Length(arrayDataDevFAC)-1] := TBDATAS.FieldByName('DT_DEVOLUCAO').AsDateTime;
        end;

        TBDATAS.Next;
      end;
    end;

  except
    on E : Exception do
    begin
      Application.MessageBox(PCHAR('Erro ao listar datas ! MSG: '+E.Message), 'ERRO', MB_OK+MB_ICONERROR);
      Exit;
    end;
  end;
end;

Procedure TfGeraExcelDev.LimitarRegistros(dtini : TDate; dtfim : TDate);
var s: string;
begin
  try
    idini1 := 0;
    idini2 := 0;
    idini3 := 0;
    idfim1 := 0;
    idfim2 := 0;
    idfim3 := 0;

    TBLIMITE.Close;
    TBLIMITE.SQL.Clear;
    TBLIMITE.Params.Clear;
    TBLIMITE.SQL.Add('SELECT');
    TBLIMITE.SQL.Add('   MIN(DV.ID) AS MINIMO, MAX(DV.ID) AS MAXIMO, ''DEV'' AS TPDEV');
    TBLIMITE.SQL.Add('FROM CEA_CONTROLE_DEVOLUCOES DV');
    TBLIMITE.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = DV.CD_MOTIVO');
    TBLIMITE.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBLIMITE.SQL.Add('WHERE');
    TBLIMITE.SQL.Add('   DV.DT_DEVOLUCAO >= :XPDTINI1 AND DV.DT_DEVOLUCAO <= :XPDTFIM1');
    TBLIMITE.SQL.Add('   AND DV.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBLIMITE.SQL.Add('   AND S.id=:SERVICO');
    TBLIMITE.SQL.Add('GROUP BY');
    TBLIMITE.SQL.Add('   3');
    TBLIMITE.SQL.Add('UNION');
    TBLIMITE.SQL.Add('SELECT');
    TBLIMITE.SQL.Add('   MIN(FAC.ID) AS MINIMO, MAX(FAC.ID) AS MAXIMO, ''DEV_FAC'' AS TPDEV');
    TBLIMITE.SQL.Add('FROM IBI_CONTROLE_DEVOLUCOES_FAC FAC');
    TBLIMITE.SQL.Add('   INNER JOIN IBI_MOTIVO_DEVOLUCOES M ON M.CD_MOTIVO = FAC.CD_MOTIVO');
    TBLIMITE.SQL.Add('   INNER JOIN SERVICOS S ON (M.servico_id=S.id) ');
    TBLIMITE.SQL.Add('WHERE');
    TBLIMITE.SQL.Add('   FAC.DT_DEVOLUCAO >= :XPDTINI2 AND FAC.DT_DEVOLUCAO <= :XPDTFIM2');
    TBLIMITE.SQL.Add('   AND FAC.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBLIMITE.SQL.Add('   AND S.id=:SERVICO2');
    TBLIMITE.SQL.Add('GROUP BY');
    TBLIMITE.SQL.Add('   3');
    TBLIMITE.SQL.Add('UNION');
    TBLIMITE.SQL.Add('SELECT');
    TBLIMITE.SQL.Add('   MIN(ars.ID) AS MINIMO, MAX(ars.ID) AS MAXIMO, ''DEV_AR'' AS TPDEV');
    TBLIMITE.SQL.Add('FROM IBI_CONTROLE_DEVOLUCOES_AR ars ');
    TBLIMITE.SQL.Add('   INNER JOIN Lote l ON (ars.lote_id=l.id) ');
    TBLIMITE.SQL.Add('WHERE');
    TBLIMITE.SQL.Add('   ars.DT_DEVOLUCAO >= :XPDTINI3 AND ars.DT_DEVOLUCAO <= :XPDTFIM3');
    TBLIMITE.SQL.Add('   AND ars.CODBIN '+MontarFiltroGrupoBIN(grupoId, familia));
    TBLIMITE.SQL.Add('   AND l.servico_id = :SERVICO3');
    TBLIMITE.SQL.Add('GROUP BY');
    TBLIMITE.SQL.Add('   3');

    TBLIMITE.ParamByName('XPDTINI1').AsDate := dtini;
    TBLIMITE.ParamByName('XPDTFIM1').AsDate := dtfim;
    TBLIMITE.ParamByName('SERVICO').AsInteger := lcCD_SERVICO.KeyValue;
    TBLIMITE.ParamByName('XPDTINI2').AsDate := dtini;
    TBLIMITE.ParamByName('XPDTFIM2').AsDate := dtfim;
    TBLIMITE.ParamByName('SERVICO2').AsInteger := lcCD_SERVICO.KeyValue;
    TBLIMITE.ParamByName('XPDTINI3').AsDate := dtini;
    TBLIMITE.ParamByName('XPDTFIM3').AsDate := dtfim;
    TBLIMITE.ParamByName('SERVICO3').AsInteger := lcCD_SERVICO.KeyValue;

    TBLIMITE.Open;

    if (TBLIMITE.IsEmpty) or
       (TBLIMITE.RecordCount <= 0) then
    begin
      Exit;
    end;

    if TBLIMITE.Locate('TPDEV', 'DEV', []) then
    begin
      idini1 := TBLIMITE.FieldByName('MINIMO').AsInteger;
      idfim1 := TBLIMITE.FieldByName('MAXIMO').AsInteger;
    end;

    if TBLIMITE.Locate('TPDEV', 'DEV_AR', []) then
    begin
      idini2 := TBLIMITE.FieldByName('MINIMO').AsInteger;
      idfim2 := TBLIMITE.FieldByName('MAXIMO').AsInteger;
    end;

    if TBLIMITE.Locate('TPDEV', 'DEV_FAC', []) then
    begin
      idini3 := TBLIMITE.FieldByName('MINIMO').AsInteger;
      idfim3 := TBLIMITE.FieldByName('MAXIMO').AsInteger;
    end;

  except
    on E : Exception do
    begin
      Application.MessageBox(PCHAR('Erro ao limitar resultados ! MSG: '+E.Message), 'ERRO', MB_OK+MB_ICONERROR);
      Exit;
    end;
  end;
end;

Function TfGeraExcelDev.GerarExcelDevolucao(Query : TZQuery; nomeAba : String; excel : Variant; datas : arrayDate) : Boolean;
var
  xLinha :integer;
  xPlanilha : Variant;
  I: Integer;
  colunaDias : Integer;
  xTotalDiaFamilia, xTotalDia : Array of Integer;
  xTextoCell : String;
  xTotalGeral : Integer;
begin
  try
    SetLength(xTotalDiaFamilia, Length(datas));
    SetLength(xTotalDia, Length(datas));

    Excel.WorkBooks[1].WorkSheets.Add;
    Excel.WorkBooks[1].WorkSheets[1].Name := nomeAba;
    xPlanilha                             := Excel.WorkBooks[1].WorkSheets[nomeAba];
    if datas = nil then
      begin
        Result := True;
        Exit;
      end;

    xPlanilha.Cells[1,1]           := 'Data';
    xPlanilha.Cells[2,1].Font.Bold := True;
    xPlanilha.Cells[2,1]           := 'Familia';
    xPlanilha.Cells[2,2].Font.Bold := True;
    xPlanilha.Cells[2,2]           := 'Motivo';

    for I := 0 to Length(datas) - 1 do
      xPlanilha.Cells[1,3+I] := StrToDate(FormatDateTime('DD/MM/YYYY', (datas[I])));


    colunaDias := 3;
    xLinha     := 3;

    for I := 0 to Length(xTotalDia) - 1 do
      xTotalDia[I] := 0;

    lblPlanilha.Caption := 'Planilha '+nomeAba;

    TBFAMILIA.Close;
    TBFAMILIA.ParamByName('SERVICO').AsInteger:= lcCD_SERVICO.KeyValue;
    TBFAMILIA.Open;
    TBFAMILIA.First;
    while not TBFAMILIA.Eof do
      begin
        if Query.Filtered then
          begin
            Query.Filter   := '';
            Query.Filtered := False;
          end;


        if Query.Locate('FAMILIA', TBFAMILIA.FieldByName('FAMILIA').AsString, []) then
          begin
            Application.ProcessMessages;
            Status.Panels[0].Text := 'Processando: Família['+TBFAMILIA.FieldByName('FAMILIA').AsString+']';
            Application.ProcessMessages;

            for I := 0 to Length(xTotalDiaFamilia) - 1 do
              xTotalDiaFamilia[I] := 0;

        //if gambiarra para adequar ao layout do banco IBI
            if xLinha <> 3 then
              xPlanilha.Cells[xLinha, 1] := TBFAMILIA.FieldByName('FAMILIA').AsString;

            TBMOTIVO.Close;
            TBMOTIVO.ParamByName('SERVICO').AsInteger:= lcCD_SERVICO.KeyValue;
            TBMOTIVO.Open;
            TBMOTIVO.First;
            while not TBMOTIVO.Eof do
              begin
                Application.ProcessMessages;
                Status.Panels[0].Text := 'Processando: Família['+TBFAMILIA.FieldByName('FAMILIA').AsString+'] MOTIVO['+TBMOTIVO.FieldByName('DS_MOTIVO').AsString+']';
                Application.ProcessMessages;

                xPlanilha.Cells[xLinha, 2].Font.Color := clBlue;
                xPlanilha.Cells[xLinha, 2]            := TBMOTIVO.FieldByName('DS_MOTIVO').AsString;

                Query.Filter   := 'FAMILIA ='+QuotedStr(TBFAMILIA.FieldByName('FAMILIA').AsString)+
                            ' AND CD_MOTIVO='+QuotedStr(TBMOTIVO.FieldByName('CD_MOTIVO').AsString);
                Query.Filtered := True;
                if (Query.IsEmpty) or
                 (Query.RecordCount <= 0) then
                  begin
                    for I := 0 to Length(datas)-1 do
                      begin
                        xPlanilha.Cells[xLinha, colunaDias+I].Font.Color := clGreen;
                        xPlanilha.Cells[xLinha, colunaDias+I]            := 0;
                      end;
                  end
                else
                  begin
                    Query.First;
                    while not Query.Eof do
                      begin
                        for I := 0 to Length(datas)-1 do
                          begin
                            if Query.FieldByName('DT_DEVOLUCAO').AsDateTime = datas[I] then
                              begin
                                xPlanilha.Cells[xLinha, colunaDias+I].Font.Color := clGreen;
                                xPlanilha.Cells[xLinha, colunaDias+I]            := Query.FieldByName('QTDDIA').AsInteger;
                                xTotalDiaFamilia[I]                              := xTotalDiaFamilia[I] + Query.FieldByName('QTDDIA').AsInteger;
                                xTotalDia[I]                                     := xTotalDia[I] + Query.FieldByName('QTDDIA').AsInteger;
                                ProgressBar.StepIt;
                              end
                            else
                              begin
                                xTextoCell := VarToStr(xPlanilha.Cells[xLinha,colunaDias+I]);
                                if Trim(xTextoCell) = '' then
                                    begin
                                    xPlanilha.Cells[xLinha, colunaDias+I].Font.Color := clGreen;
                                    xPlanilha.Cells[xLinha, colunaDias+I]            := 0;
                                  end;
                              end;
                          end;

                        Query.Next;
                      end;
                  end;

                Query.Filter   := '';
                Query.Filtered := False;

                xLinha := xLinha + 1;
                TBMOTIVO.Next;
              end;

            xPlanilha.Cells[xLinha, 2]            := 'Total';
            xPlanilha.Cells[xLinha, 2].Font.Color := clRed;
            xPlanilha.Cells[xLinha, 2].Font.Bold  := True;
            for I := 0 to Length(xTotalDiaFamilia)-1 do
              begin
                xPlanilha.Cells[xLinha, colunaDias+I]            := xTotalDiaFamilia[I];
                xPlanilha.Cells[xLinha, colunaDias+I].Font.Color := clRed;
                xPlanilha.Cells[xLinha, colunaDias+I].Font.Bold  := True;
              end;

            xLinha := xLinha + 1;
          end
        else
          begin
            Application.ProcessMessages;
            Status.Panels[0].Text := 'Processando: Família['+TBFAMILIA.FieldByName('FAMILIA').AsString+']';
            Application.ProcessMessages;

            for I := 0 to Length(xTotalDiaFamilia) - 1 do
              xTotalDiaFamilia[I] := 0;

            //if gambiarra para adequar ao layout do banco IBI
            if xLinha <> 3 then
              xPlanilha.Cells[xLinha, 1] := TBFAMILIA.FieldByName('FAMILIA').AsString;

            TBMOTIVO.Close;
            TBMOTIVO.ParamByName('SERVICO').AsInteger:= lcCD_SERVICO.KeyValue;
            TBMOTIVO.Open;
            TBMOTIVO.First;
            while not TBMOTIVO.Eof do
              begin
                Application.ProcessMessages;
                Status.Panels[0].Text := 'Processando: Família['+TBFAMILIA.FieldByName('FAMILIA').AsString+'] MOTIVO['+TBMOTIVO.FieldByName('DS_MOTIVO').AsString+']';
                Application.ProcessMessages;

                xPlanilha.Cells[xLinha, 2].Font.Color := clBlue;
                xPlanilha.Cells[xLinha, 2]            := TBMOTIVO.FieldByName('DS_MOTIVO').AsString;

                for I := 0 to Length(datas)-1 do
                  begin
                    xPlanilha.Cells[xLinha, colunaDias+I].Font.Color := clGreen;
                    xPlanilha.Cells[xLinha, colunaDias+I]            := 0;
                  end;

                xLinha := xLinha + 1;
                TBMOTIVO.Next;
              end;

            xPlanilha.Cells[xLinha, 2]            := 'Total';
            xPlanilha.Cells[xLinha, 2].Font.Color := clRed;
            xPlanilha.Cells[xLinha, 2].Font.Bold  := True;
            for I := 0 to Length(xTotalDiaFamilia)-1 do
              begin
                xPlanilha.Cells[xLinha, colunaDias+I]            := xTotalDiaFamilia[I];
                xPlanilha.Cells[xLinha, colunaDias+I].Font.Color := clRed;
                xPlanilha.Cells[xLinha, colunaDias+I].Font.Bold  := True;
              end;

            xLinha := xLinha + 1;
          end;

        //if gambiarra para adequar ao layout do banco IBI
        if TBFAMILIA.RecNo = 1 then
          xLinha := xLinha + 1;

        TBFAMILIA.Next;
      end;

    xTotalGeral                           := 0;
    xPlanilha.Cells[xLinha, 1]            := 'Total do Dia ==>';
    xPlanilha.Cells[xLinha, 1].Font.Color := clRed;
    xPlanilha.Cells[xLinha, 1].Font.Bold  := True;
    for I := 0 to Length(xTotalDia)-1 do
      begin
        xPlanilha.Cells[xLinha, colunaDias+I]            := xTotalDia[I];
        xPlanilha.Cells[xLinha, colunaDias+I].Font.Color := clRed;
        xPlanilha.Cells[xLinha, colunaDias+I].Font.Bold  := True;
        xTotalGeral := xTotalGeral + xTotalDia[I];
      end;

    xLinha := xLinha + 1;
    xPlanilha.Cells[xLinha, 1]            := 'Total Geral ==>';
    xPlanilha.Cells[xLinha, 1].Font.Color := clRed;
    xPlanilha.Cells[xLinha, 1].Font.Bold  := True;

    xPlanilha.Cells[xLinha, 2]            := xTotalGeral;
    xPlanilha.Cells[xLinha, 2].Font.Color := clRed;
    xPlanilha.Cells[xLinha, 2].Font.Bold  := True;

    Status.Panels[0].Text := '';
    Excel.columns.AutoFit;
    Result := True;
  except
    on E: Exception do
      Result := False;
  end;
end;

procedure TfGeraExcelDev.lcCD_SERVICOClick(Sender: TObject);
begin
  if (lcCD_SERVICO.KeyValue < 1) then
    begin
      cbgrupo.Enabled:= false;
      cbdtini.Enabled:= false;
      cbdtfim.Enabled:= false;
      btnGerar.Enabled:= false;
    end
  else
    cbgrupo.Enabled:= true;
end;

procedure TfGeraExcelDev.lcCD_SERVICOKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lcCD_SERVICOClick(Self);
end;

Function TfGeraExcelDev.GerarExcelConsolidado(nomeAba : String; excel : Variant) : Boolean;
var
  xLinha :integer;
  xPlanilha : Variant;
  I: Integer;
  colunaMotivos : Integer;
  xTotalMotivo : Array of Integer;
  xTextoCell   : String;
  xTotalGeral  : Integer;
begin

  try

    Excel.WorkBooks[1].WorkSheets.Add;
    Excel.WorkBooks[1].WorkSheets[1].Name := nomeAba;
    xPlanilha                             := Excel.WorkBooks[1].WorkSheets[nomeAba];

    xPlanilha.Cells[1,1].Font.Bold := True;
    xPlanilha.Cells[1,1]           := 'FAMILIA';

    SetLength(xTotalMotivo, TBMOTIVO.RecordCount);
    TBMOTIVO.Close;
    TBMOTIVO.ParamByName('SERVICO').AsInteger:= lcCD_SERVICO.KeyValue;
    TBMOTIVO.Open;
    TBMOTIVO.First;
    for I := 0 to TBMOTIVO.RecordCount - 1 do
    begin
      xPlanilha.Cells[1, 2+I].Font.Bold := True;
      xPlanilha.Cells[1, 2+I]           := TBMOTIVO.FieldByName('DS_MOTIVO').AsString;

      xTotalMotivo[I] := 0;
      TBMOTIVO.Next;
    end;

    colunaMotivos := 2;
    xLinha        := 2;

    lblPlanilha.Caption := 'Planilha '+nomeAba;

    TBFAMILIA.Close;
    TBFAMILIA.ParamByName('SERVICO').AsInteger:= lcCD_SERVICO.KeyValue;
    TBFAMILIA.Open;
    TBFAMILIA.First;
    while not TBFAMILIA.Eof do
    begin
      if TBCONSOLIDA.Filtered then
      begin
        TBCONSOLIDA.Filter   := '';
        TBCONSOLIDA.Filtered := False;
      end;

      if TBCONSOLIDA.Locate('FAMILIA', TBFAMILIA.FieldByName('FAMILIA').AsString, []) then
      begin

        Application.ProcessMessages;
        Status.Panels[0].Text := 'Processando: Família['+TBFAMILIA.FieldByName('FAMILIA').AsString+']';
        Application.ProcessMessages;

        xPlanilha.Cells[xLinha, 1] := TBFAMILIA.FieldByName('FAMILIA').AsString;

        TBCONSOLIDA.Filter   := 'FAMILIA ='+QuotedStr(TBFAMILIA.FieldByName('FAMILIA').AsString);
        TBCONSOLIDA.Filtered := True;

        if (TBCONSOLIDA.IsEmpty) or
           (TBCONSOLIDA.RecordCount <= 0) then
        begin
          for I := 0 to TBMOTIVO.RecordCount-1 do
          begin
            xPlanilha.Cells[xLinha, colunaMotivos+I] := 0;
          end;
        end
        else
        begin
          TBCONSOLIDA.First;
          while not TBCONSOLIDA.Eof do
          begin
            TBMOTIVO.First;
            for I := 0 to TBMOTIVO.RecordCount-1 do
            begin
              if TBCONSOLIDA.FieldByName('CD_MOTIVO').AsString = TBMOTIVO.FieldByName('CD_MOTIVO').AsString then
              begin
                //BEGIN CORREÇÃO 13-02-2013 ERRO AO TOTALIZAR CONSOLIDADO PARTE 3 DE 3 - MATHEUS
                xTextoCell := VarToStr(xPlanilha.Cells[xLinha, colunaMotivos+I]);
                if Trim(xTextoCell) <> '' then
                begin
                  try
                    StrToInt(xTextoCell);
                  except
                    xTextoCell := '0';
                  end;
                end
                else
                begin
                  xTextoCell := '0';
                end;

                xPlanilha.Cells[xLinha, colunaMotivos+I] := StrToInt(xTextoCell) + TBCONSOLIDA.FieldByName('QTDMOT').AsInteger;
                xTotalMotivo[I]                          := xTotalMotivo[I] + TBCONSOLIDA.FieldByName('QTDMOT').AsInteger;
                //xPlanilha.Cells[xLinha, colunaMotivos+I] := TBCONSOLIDA.FieldByName('QTDMOT').AsInteger;
                //END CORREÇÃO 13-02-2013 ERRO AO TOTALIZAR CONSOLIDADO PARTE 1 DE 3 - MATHEUS

                ProgressBar.StepIt;
              end
              else
              begin
                xTextoCell := VarToStr(xPlanilha.Cells[xLinha, colunaMotivos+I]);
                if Trim(xTextoCell) = '' then
                begin
                  xPlanilha.Cells[xLinha, colunaMotivos+I] := 0;
                end;
              end;

              TBMOTIVO.Next;
            end;

            TBCONSOLIDA.Next;
          end;
        end;

        TBCONSOLIDA.Filter   := '';
        TBCONSOLIDA.Filtered := False;

        xLinha               := xLinha + 1;
      end;

      TBFAMILIA.Next;
    end;

    xTotalGeral                           := 0;
    xPlanilha.Cells[xLinha, 1]            := 'Total';
    xPlanilha.Cells[xLinha, 1].Font.Color := clBlue;
    xPlanilha.Cells[xLinha, 1].Font.Bold  := True;
    for I := 0 to Length(xTotalMotivo)-1 do
    begin
      xPlanilha.Cells[xLinha, colunaMotivos+I].Font.Color := clBlue;
      xPlanilha.Cells[xLinha, colunaMotivos+I].Font.Bold  := True;
      xPlanilha.Cells[xLinha, colunaMotivos+I]            := xTotalMotivo[I];
      xTotalGeral                                         := xTotalGeral + xTotalMotivo[I];
    end;

    xLinha                                := xLinha + 1;
    xPlanilha.Cells[xLinha, 1].Font.Color := clRed;
    xPlanilha.Cells[xLinha, 1].Font.Bold  := True;
    xPlanilha.Cells[xLinha, 1]            := 'Total Geral ==>';
    xPlanilha.Cells[xLinha, 2].Font.Color := clRed;
    xPlanilha.Cells[xLinha, 2].Font.Bold  := True;
    xPlanilha.Cells[xLinha, 2]            := xTotalGeral;


    Status.Panels[0].Text := '';
    Excel.columns.AutoFit;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;

end;

procedure TfGeraExcelDev.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
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

procedure TfGeraExcelDev.FormCreate(Sender: TObject);
var
  query : TZQuery;
  semFamilia : String;
begin
  // Exibindo a lista de Servicos
  DM.qraServicos.Open;

  cbdtini.DateTime := Date;
  cbdtini.MaxDate := Date;

  cbdtfim.Date := Date;
  cbdtfim.MinDate:= cbdtini.Date;

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

  try
    TBFAMILIA.Open;
    TBMOTIVO.Open;
  except
    on E: Exception do
    begin
      TBFAMILIA.Close;
      TBMOTIVO.Close;
      Close;
    end;
  end;
end;

procedure TfGeraExcelDev.btnGerarClick(Sender: TObject);
var
  xGerou : Boolean;
  xDiretorio : String;
  xDtAux : TDate;
  excel : Variant;
  xInstallExcel : Boolean;
begin
  try
    if panelBarra.Visible then
      Exit;

    if lcCD_SERVICO.KeyValue < 1 then
      begin
        Application.MessageBox('Selecione o Serviço!', 'Atenção', MB_OK+MB_ICONWARNING);
        cbgrupo.SetFocus;
        Exit;
      end;
    if cbgrupo.ItemIndex < 0 then
      begin
        Application.MessageBox('Selecione o grupo!', 'Atenção', MB_OK+MB_ICONWARNING);
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
        Application.MessageBox('A data inicial não deve ser maior que a data final', 'Atenção', MB_OK + MB_ICONWARNING);
        cbdtini.SetFocus;
        Exit;
    end;

    grupoId := StrToInt(Copy(cbgrupo.Text, 1, 3));
    if Copy(cbgrupo.Text, 7, 1) = 'S' then
     familia := True
    else
     familia := False;


    xDtInicial := Trunc(cbdtini.Date);
    xDtFinal   := Trunc(cbdtfim.Date);
    ListarDatas(xDtInicial, xDtFinal);
    if (arrayDataDev = Nil) and
       (arrayDataDevAR = Nil) and
       (arrayDataDevFAC = Nil) then
    begin
      Application.MessageBox('Não há dados para gerar a planilha!', 'Aviso',
          MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    xGerou := True;

    if not AbrirTabelasDevolucoes(xDtInicial, xDtFinal) then
    begin
      Application.MessageBox('Ocorreu um erro inesperado. ' +
              'Entre em contato com administrador do sistema',
          'ERRO', MB_OK + MB_ICONERROR);
      Exit;
    end;

    try
    SaveDialog.InitialDir := DM.currdir;
    SaveDialog.FileName := 'Relatorio_Devolucoes_' +
      FormatDateTime('dd-mm-yyyy', cbdtini.Date) + '_a_' +
      FormatDateTime('dd-mm-yyyy', cbdtini.Date) + '.xls';
    if SaveDialog.Execute = false then exit;
    xDiretorio := ExtractFilePath(SaveDialog.FileName);
    if (Trim(xDiretorio) = '') or
       (not DirectoryExists(xDiretorio)) then
    begin
      Application.MessageBox('Defina o local onde os arquivos serão salvos !', 'Atenção', MB_OK+MB_ICONWARNING);
      Exit;
    end;


      excel := CreateOleObject('\excel.application\');
      excel.WorkBooks.Add;
      xInstallExcel := True;
    except
      on E: Exception do
      begin
        xInstallExcel := False;
      end;
    end;

    if xInstallExcel then
    begin
      listOfQuery := TList.Create;
      listOfQuery.Add(TBCONSOLIDA);
      listOfQuery.Add(TBDEV);
      listOfQuery.Add(TBDEVFAC);
      listOfQuery.Add(TBDEVAR);

      AjustarProgressBar(ProgressBar, listOfQuery);
      panelBarra.Visible := True;

      GerarExcelConsolidado('Resumo_consolidado', excel);
      GerarExcelDevolucao(TBDEV,    'FATURA',     excel, arrayDataDev);
      GerarExcelDevolucao(TBDEVAR,  'AR_RE',      excel, arrayDataDevAR);
      GerarExcelDevolucao(TBDEVFAC, 'TARJA',      excel, arrayDataDevFAC);

      excel.WorkBooks[1].Sheets[5].Delete;
      excel.WorkBooks[1].Sheets[5].Delete;
      excel.WorkBooks[1].Sheets[5].Delete;

      panelBarra.Visible   := False;
      ProgressBar.Position := 0;

      try
        excel.WorkBooks[1].SaveAs(SaveDialog.FileName);
      except
        Application.MessageBox('Não foi possível salvar a planilha, salve-a antes de fechá-la !', 'Informação', MB_OK+MB_ICONINFORMATION);
      end;

      excel.Visible :=True;

      if xGerou then
       Application.MessageBox('Planilha(s) gerada(s) com sucesso !', 'Sucesso', MB_OK+MB_ICONINFORMATION)
      else
       Application.MessageBox('Não foram encontrados dados para o período informado !', 'Atenção', MB_OK+MB_ICONWARNING);
    end
    else
    begin
      Application.MessageBox('Para gerar planilhas é necessário ter o Excel instalado na máquina! Verifique.', 'Atenção', MB_OK+MB_ICONWARNING);
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PCHAR('Ocorreu um problema durante a geração da(s) planilhas! Erro:'+E.Message), 'ERRO', MB_OK+MB_ICONERROR);
      TBLIMITE.Close;
      TBLIMITE.SQL.Clear;
      TBLIMITE.Params.Clear;
      panelBarra.Visible    := False;
      Status.Panels[0].Text := '';
      Exit;
    end;
  end;
end;

procedure TfGeraExcelDev.cbdtiniChange(Sender: TObject);
begin
  cbdtfim.MinDate:= cbdtini.Date;
end;

procedure TfGeraExcelDev.cbgrupoClick(Sender: TObject);
begin
  cbdtini.Enabled:= cbgrupo.ItemIndex > -1;
  cbdtfim.Enabled:= cbgrupo.ItemIndex > -1;
  btnGerar.Enabled:= cbgrupo.ItemIndex > -1;
end;

procedure TfGeraExcelDev.cbgrupoDropDown(Sender: TObject);
begin
  cbdtini.Enabled:= cbgrupo.ItemIndex > -1;
  cbdtfim.Enabled:= cbgrupo.ItemIndex > -1;
  btnGerar.Enabled:= cbgrupo.ItemIndex > -1;
end;

procedure TfGeraExcelDev.cbgrupoEndDock(Sender, Target: TObject; X, Y: Integer);
begin
  cbdtini.Enabled:= cbgrupo.ItemIndex > -1;
  cbdtfim.Enabled:= cbgrupo.ItemIndex > -1;
  btnGerar.Enabled:= cbgrupo.ItemIndex > -1;
end;

procedure TfGeraExcelDev.cbgrupoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  cbgrupoClick(Self);
end;

end.

