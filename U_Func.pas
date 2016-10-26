unit U_Func;

interface

uses
  SysUtils, Types, Classes,DB ,Variants,  Graphics, Controls, Forms,Dialogs,OleServer,
  OleConst,ShlObj,ComObj, ActiveX, OfficeXP,ExcelXP, SysConst;

  type
  // TDataSetToExcel
  TDataSetToExcel = class(TObject)
  protected
    procedure WriteToken(AToken: word; ALength: word);
    procedure WriteFont(const AFontName: string; AFontHeight,
      AAttribute: word);
    procedure WriteFormat(const AFormatStr: string);
  private
    FRow: word;
    FDataFile: file;
    FFileName: string;
    FDataSet: TDataSet;
    fcab    : string;
  public
    constructor Create(ADataSet: TDataSet; const AFileName,cab: string);
    function WriteFile: boolean;
  end;

Function FormataValor(Valor:string): string;
Function DifDias(DataFin:TDateTime;DataIni:TDateTime):String;
Function GeraNT(Texto:Variant;Tamanho:Integer):String;
Function Verifica(Str: string):string;
Function Codificar(Armazena: string; Chave:Integer):string;
Function Decodificar(Armazena: string; Chave:Integer):string;
function encryptstr(const InString:string; StartKey,MultKey,AddKey:Integer): string;
function decryptstr(const InString:string; StartKey,MultKey,AddKey:Integer): string;
Function GeraCodigo(numero:string;tipo:integer):string;
Function procarqconf(conf:string):String;
Function CriaDirRelGera():string;
Function VerificaDigito11(Valor: String; Base: Integer = 11; Resto: boolean = false) :String;
Function VerificaValidade_Codigo(verifica: String) :String;
Function vernum(Str: string):boolean;
Function verzero(Str: string):boolean;
Function vcobjnet(num:string;base:integer = 11):string;
Function GeraArquivo(Texto:Variant;Tamanho:Integer):String;
Function Remove(Str:String):String;
Function RemCaract(Str:String):String;
Function criadir(texto:String):String;
function tamlookcbo(tipo:integer):integer;
function VerificaDigito7(Valor: String; Base: Integer = 7; Resto: boolean = false) :String;
function VerDvCpf(Valor: String; Base: Integer = 11) :boolean;
Function SelecionaFormat(Valor : String):String;
function RestauraInteger(Valor: string): string;
Function ValorMonetario(Armazena: string; key:char):string;
function strtran(Str: String; Antigo: String; Novo: variant): string;
Function VirgPonto2(Valor: string): string;
function md5(const input : string) : string;
function md5File(const fileName : string) : string;
function validaNumObjCorreios(const numobj : string) : boolean;
implementation

uses CDDM, CDFac, U_FrmCadHost, IdHashMessageDigest, idHash;

Function FormataValor(Valor:string): string;
Var
  Moeda : real;
  resultado : string;
begin
 if (Valor <> ' ') and  (Valor <> '') then
   begin
     Resultado:='';
     try
      moeda := StrToFloat(valor);
     except
        begin
          valor  := '0';
          result := valor;
          exit;
        end;
     end;
      Valor := format('%m',[Moeda]);
      Valor := Verifica(Valor);
   end
 else
   valor := '0';
 result := Trim(valor);
end;
function EncryptSTR(const InString:string; StartKey,MultKey,AddKey:Integer): string;
var I : Byte;
begin
  {$i-}
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 6));
    StartKey := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
  end;
end;

function DecryptSTR(const InString:string; StartKey,MultKey,AddKey:Integer): string;
var I : Byte;
begin
  {$i-}
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 6));
    StartKey := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
   end;
end;

Function GeraCodigo(numero:string;tipo:integer):string;
var
  campo0 : array[1..3,1..24] of integer;
  campo1 : array[1..3,1..9]  of integer;
  campo2 : array[1..3,1..10] of integer;
  campo3 : array[1..3,1..43] of integer;
  campo4 : array[1..3,1..10] of integer;
  i,peso : integer;
  aux1,aux2,numerox: string;
  multiplica : integer;
  resultadox : integer;
  divide : double;
begin
  case tipo of
    0:
      begin
        peso := 1;
        for i:= 1 to 24 do
          begin
            campo0[1,i] := strtoint(copy(numero,i,1));
            campo0[2,i] := peso;
            multiplica := campo0[1,i] * campo0[2,i];
            if multiplica > 9 then
              begin
                numerox := inttostr(multiplica);
                multiplica := strtoint(copy(numerox,1,1))+strtoint(copy(numerox,2,1));
              end;
            campo0[3,i] := multiplica;
            if peso = 1 then
              peso := 2
            else
              peso := 1;
          end;
        multiplica := 0;
        for i:=1 to 24 do
          begin
            multiplica := multiplica + campo0[3,i];
          end;
         resultadox := multiplica mod 10;
         resultadox:=  10-resultadox;
        if resultadox = 10 then
          resultadox := 0;
        result := inttostr(resultadox);
      end;
    1:
      begin
        peso := 2;
        for i:= 1 to 9 do
          begin
            campo1[1,i] := strtoint(copy(numero,i,1));
            campo1[2,i] := peso;
            multiplica := campo1[1,i] * campo1[2,i];
            if multiplica > 9 then
              begin
                numerox := inttostr(multiplica);
                multiplica := strtoint(copy(numerox,1,1))+strtoint(copy(numerox,2,1));
              end;
            campo1[3,i] := multiplica;
            if peso = 2 then
              peso := 1
            else
              peso := 2;
          end;
        multiplica := 0;
        for i:=1 to 9 do
         begin
           multiplica := multiplica + campo1[3,i];
         end;
        divide := StrToFloat(inttostr(multiplica));
        resultadox := multiplica mod 10;
        resultadox := 10 - resultadox;
        if resultadox = 10 then
          resultadox := 0;
        result := inttostr(resultadox);
      end;
    2:
      begin
        peso := 1;
        for i:= 1 to 10 do
          begin
            campo2[1,i] := strtoint(copy(numero,i,1));
            campo2[2,i] := peso;
            multiplica := campo2[1,i] * campo2[2,i];
            if multiplica > 9 then
              begin
                numerox := inttostr(multiplica);
                multiplica := strtoint(copy(numerox,1,1))+strtoint(copy(numerox,2,1));
              end;
            campo2[3,i] := multiplica;
            if peso = 1 then
              peso := 2
            else
              peso := 1;
          end;
        multiplica := 0;
        for i:=1 to 10 do
          begin
            multiplica := multiplica + campo2[3,i];
          end;
        divide := StrToFloat(inttostr(multiplica));
        resultadox := multiplica mod 10;
        resultadox := 10 - resultadox;
        if resultadox = 10 then
          resultadox := 0;
        result := inttostr(resultadox);
      end;
    3:
      begin
        peso := 1;
        for i:= 1 to 10 do
          begin
            campo4[1,i] := strtoint(copy(numero,i,1));
            campo4[2,i] := peso;
            multiplica := campo4[1,i] * campo4[2,i];
            if multiplica > 9 then
              begin
                numerox := inttostr(multiplica);
                multiplica := strtoint(copy(numerox,1,1))+strtoint(copy(numerox,2,1));
              end;
            campo4[3,i] := multiplica;
            if peso = 1 then
              peso := 2
            else
              peso := 1;
          end;
        multiplica := 0;
        for i:=1 to 10 do
          begin
            multiplica := multiplica + campo4[3,i];
          end;
        divide := StrToFloat(inttostr(multiplica));
        //resultadox := multiplica mod 10;
//        resultadox := 10 - resultadox;
        resultadox := 10 - (multiplica mod 10);
        if resultadox = 10 then
          resultadox := 0;
        result := inttostr(resultadox);
      end;
    4:
      begin
        peso := 4;
        for i:= 1 to 43 do
          begin
            campo3[1,i] := strtoint(copy(numero,i,1));
            campo3[2,i] := peso;
            multiplica := multiplica + campo3[1,i] * campo3[2,i];
            if peso = 2 then
              peso := 9
            else
              peso := peso - 1;
          end;
        multiplica := 0;
        for i:=1 to 43 do
         begin
           campo3[3,i] := campo3[1,i] * campo3[2,i];
           multiplica := multiplica + campo3[3,i];
         end;
        divide := StrToFloat(inttostr(multiplica));
        resultadox := multiplica mod 11;
        resultadox := 11 - resultadox;
        if (resultadox <= 1) or (resultadox > 9)then
          resultadox := 1;
        result := inttostr(resultadox);
      end;
  end;
end;

Function DifDias(DataFin:TDateTime;DataIni:TDateTime):String;

Var
  Data:TDateTime;
  Dia,Mes,Ano:Word;

Begin
  If Not(DataFin < DataIni) Then
     Begin
       Data := DataFin - DataIni;
       DecodeDate(Data,Ano,Mes,Dia);
       Result := FloatToStr(Data);
     End;
End;

Function Codificar(Armazena: string; Chave: integer):string;
Var
  Resultado: string;
  Temporario:Char;
  I,CodificaIndex:Integer;

Begin
  Resultado := '';
  Temporario := ' ';
  For I:= 1 to Length(Armazena)do
      Begin
        For CodificaIndex := 1 to Chave do
            Begin
              Temporario := Succ(Armazena[i]);
              Armazena[i]:= Temporario;
            End;
            Resultado := Resultado + Temporario;
      End;
      Codificar := Resultado;
End;

Function Decodificar(Armazena:string; Chave: Integer):string;
Var
  Resultado:string;
  Temporario:Char;
  I,DecodificaIndex:Integer;
Begin
  Resultado := '';
  Temporario := ' ';
  For I:= 1 to Length(Armazena) do
      Begin
        For DecodificaIndex := 1 to Chave do
            Begin
              Temporario := Pred(Armazena[I]);
              Armazena[I] := Temporario;
            End;
            Resultado := Resultado + Temporario;
      End;
      Decodificar := Resultado;
End;

Function GeraArquivo(Texto:Variant;Tamanho:Integer):String;
Var
  I,Dif:Integer;
  Aux:String;
Begin
  if texto = null then
    texto := ' ';
  Dif := Tamanho - Length(Texto);
  Aux := '';
  For I:=1 to Dif do
      Begin
        Aux := Aux+' ';
      End;
  Texto  := Texto+Aux;
  result := Texto;
End;

Function GeraNT(Texto:Variant;Tamanho:Integer):String;
Var
  I,Dif:Integer;
  Aux:String;
Begin
  if texto = null then
   texto := '0';
  Dif := Tamanho - Length(Texto);
  Aux := '';
  For I:=1 to Dif do
      Begin
        Aux := '0'+Aux;
      End;
  Texto  := Aux+Texto;
  result := Texto;
End;

Function Remove(Str:String):String;

  Const Cacentos='*^àáãâèéêìíîòóôõùúûüçÀÁÂÃÈÉÊÌÍÎÒÓÔÕÙÚÛÜÇºª§"/-&\'+CHR(39);
        Sacentos='   aaaaeeeiiioooouuuucAAAAEEEIIIOOOOUUUUC      E  ';

Var
  X:Integer;

Begin
  For X:= 1 to Length(Str) do
      Begin
        If Pos(Str[X],Cacentos) <> 0 Then
           Begin
             Str[X] := Sacentos[Pos(Str[X],Cacentos)];
           End;
      End;
      Result := Trim(Str);
End;
Function RemCaract(Str:String):String;

  Const num='0123456789';

Var
  i:Integer;
  aux:string;
Begin
aux:='';
  For i:= 1 to Length(Str) do
      Begin
        If Pos(Str[i],num) <> 0 Then
          aux:=aux+ copy(Str,i,1);
      End;
      Result := Trim(aux);
End;

Function Verifica(Str: string):string;
Const Num = '0123456789';
const alpha = 'ABCDEFGHIJKLMNOPQRSTUVXZWYabcdefghijklmnopqrstuvxzwy';
Var
  X: Integer;
  Aux : String;
  erro : string;
  Digito : array[0..0]of String;
Begin
 Aux := '';
 erro := '';
 //troquei o if que estava aqui por um case . Isso porque havia 2 opções,
 //agora há 3 ... aqui ele verifica o tamanho do protocolo
 //acrescendei mais uma opção pra DRC Carta Aviso 21/09/2005

 case (length(Str)) of
  18:
   begin
    for x:= 1 to Length(Str) do
       begin
         If Pos(Str[X],Num) <> 0 Then
           Aux := Aux+ copy(Str,X,1)
         else
           erro := 'erro';
       end;
   end;
  34:
    begin
      for x:= 1 to Length(Str) do
       begin
         If Pos(Str[X],Num) <> 0 Then
           Aux := Aux+ copy(Str,X,1)
         else
           erro := 'erro';
       end;
    end;
  15:
   begin
     for x := 1 to Length(Str) do
      begin
        if (Pos(Str[x],Num)<> 0 ) then
          Aux := Aux+ Copy(Str,x,1)
        else
          erro  := 'erro';
      end;
   end;
  16:
   begin
     for x := 1 to Length(Str) do
      begin
        if (Pos(Str[x],Num)<> 0 ) then
          Aux := Aux+ Copy(Str,x,1)
        else
          erro  := 'erro';
      end;
   end;
  17:
   begin
    for x:= 1 to Length(Str) do
       begin
         If Pos(Str[X],Num) <> 0 Then
           Aux := Aux+ copy(Str,X,1)
         else
           erro := 'erro';
       end;
   end;
  29:
   begin
    for x:= 1 to Length(Str) do
       begin
         If Pos(Str[X],Num) <> 0 Then
           Aux := Aux+ copy(Str,X,1)
         else
           erro := 'erro';
       end;
   end;
  11:
    begin
      case frmCartao.Tag of
        3,9:
          begin
            for x:= 1 to Length(Str) do
               begin
                 If Pos(Str[X],Num) <> 0 Then
                   Aux := Aux+ copy(Str,X,1)
                 else
                   erro := 'erro';
               end;
          end;
        else
          begin// Faz o looping em todos os digitos do protocolo
            for X:= 1 to Length(Str) do
             begin
               // O código abaixo verifica se o digito do protocolo tem como os 4 numeros iniciais '4120'
               // ,caso contrario, apresenta erro
               if (X = 1) then
                  begin
                    {case X of
                      1: Digito[0]:='4';
                      2: Digito[0]:='1';
                      3: Digito[0]:='2';
                      else Digito[0]:='0';
                    end;}
                    Digito[0] := '4';

                    if pos(str[X],Digito[0]) <> 0 then
                        Aux:=Aux+copy(Str,X,1)
                      else
                        begin
                          erro := 'erro';
                        end;

                  end
                else
                  //O código abaixo verifica se os digitos a partir do 5º são todos números
                  If Pos(Str[X],Num) <> 0 Then
                      Aux := Aux+ copy(Str,X,1)
                    else
                      erro := 'erro';
             end;
          end;
      end;
    end;
  else
   begin
    for x:= 1 to Length(Str) do
      begin
        { Aqui o programa verifica se o código tem 13 ou 12 digitos
        e , se chegou ao final em algum deles, confere se termina com
        alguma letra. Modifiquei essa parte logicamente, invertendo
        a ordem dos IF's.
        }
        if ((x = 12) and (Length(Str)=12)) or (x = 13) then
          begin
            If (Pos(Str[X],alpha) = 0) and (Pos(Str[X],Num) = 0) Then
              begin
                result := 'erro';
                ShowMessage('Caracter Inválido');
                exit;
              end
          end
        else
          begin
           { Abaixo verifica se o código tem 13 digitos , se faz parte
            da baixa de Extratos DRC (pela TAG), e se o digito verificado
            é o 12      }
           if ((Length(Str)=13) and (frmCartao.Tag = 3)) and (x=12) then
              begin
                If Pos(Str[X],'-') <> 0 Then
                    Aux := Aux+ copy(Str,X,1)
                  else
                    erro := 'erro';
              end
            else
              begin
                If (Pos(Str[X],Num) <> 0) or (Pos(Str[13],'P') <> 0)  Then
                    Aux := Aux+ copy(Str,X,1)
                  else
                    erro := 'erro';
              end;
          end;
      end;
   end;
  end;
    if erro = '' then
      Result := Trim(Aux)
    else
      result := 'erro';
End;


Function VirgPonto2(Valor: string): string;
Var
  i: Integer;
begin
if Valor <> ' ' then
   begin
   for i := 0 to Length(Valor) do
       begin
        if Valor[i] = ',' then
           begin
             Valor[i]:='.';
           end;
       end;
   end;
   Result := Valor;
end;

function VirgPonto(Valor: string): string;
Var
  i: Integer;
begin
if Valor <> ' ' then
   begin
   for i := 0 to Length(Valor) do
       begin
       if Valor[i]='.' then
          begin
          Valor[i]:=',';
          end
       else if Valor[i] = ',' then
               begin
               Valor[i]:='.';
               end;
       end;
   end;
   Result := Valor;
end;

function RestauraInteger(Valor: string): string;
Var
  i: Integer;
begin
 if Valor <> ' ' then
   begin
   for i := 0 to Length(Valor) do
       begin
       if Valor[i]='.' then
          begin
            Delete(valor,i,1);
          end
       else
       if Valor[i] = ',' then
          begin
            Delete(valor,i,1);
          end;
       end;
   end;
   result := trim(valor);
end;


Function RetiraNegativo(Valor:string):string;
Var
  i: Integer;
begin
if Valor <> ' ' then
   begin
   for i := 0 to Length(Valor) do
       begin
       if Valor[i]='-' then
          begin
            Delete(valor,i,1);
          end;
       end;
   end;
   Result := Valor;
end;

Function SelecionaFormat(Valor : String):String;
Var
  i: Integer;
begin
  try
    if valor = '' then
      valor := '0';
      if Valor <> ' ' then
        begin
          for i := 0 to Length(Valor) do
            begin
              if Valor[i]='.' then
                begin
                  Delete(valor,i,1);
                end
              else
               if Valor[i] = ',' then
                 begin
                   Valor[i]:='.';
                 end;
            end;
        end;
  except
  end;
  Result := trim(Valor);
end;

Function VerificaDigito(Valor:String) : String;
Var
 Auxiliar      : string;
 Contador,Peso : integer;
 Digito        : integer;
Begin
  Auxiliar := '';
  Peso := 2  ;
  for Contador := Length(Valor) downto 1 do
  begin
    Auxiliar := IntToStr(StrToInt(Valor[Contador])* Peso) + Auxiliar;
    if Peso = 1 then
     Peso := 2
    else
     Peso := 1
  end;

  Digito := 0;
  for Contador := 1 to Length(Auxiliar) do
  begin
    Digito := Digito + StrToInt(Auxiliar[Contador]);
  end;

  Digito := 10 - (Digito mod 10);
    if (Digito > 9) then
      Digito := 0;
    Result := IntToStr(Digito);
 End;
function procarqconf(conf:string):String;
var
 configura : TStringList;
 indice,i  : integer;
 teste     : string;
begin
  indice :=0;
  configura := TStringList.Create;
  {$IFNDEF LINUX}
    begin
      try configura.LoadFromFile(Dm.currdir+'\ibisis.conf');
      except on e:exception do
        begin
          Application.CreateForm(TFrmCadHost,FrmCadHost);
          FrmCadHost.ShowModal;
          configura.LoadFromFile(Dm.currdir+'\ibisis.conf');
        end;
      end;
    end;
  {$Else}
    begin
      try configura.LoadFromFile(DM.currdir);
      except on e:exception do
        begin
          Application.CreateForm(TFrmCadHost,FrmCadHost);
          FrmCadHost.ShowModal;
          configura.LoadFromFile(DM.currdir+'/ibisis.conf');
        end;
      end;
    end;
  {$EndIf}
  for i := 1 to configura.count - 1 do
    begin
      teste := AnsiUpperCase (copy(configura.Strings[i],1,length(conf)));
      if AnsiUpperCase(conf) = teste then
        begin
          indice := i;
        end;
     end;
   result := configura.Strings[indice];
end;

Function CriaDirRelGera():string;
var
  nomearquivo : string;
begin
  {$IFNDEF LINUX}
    nomearquivo := DM.unidade + 'ibisis\relatorios\';
  {$Else}
    nomearquivo := DM.unidade + 'ibisis/relatorios/';
  {$EndIf}
     If not DirectoryExists(nomearquivo) then
       begin
         MkDir(nomearquivo);
         Application.MessageBox(PChar('O Sistema criou a pasta '+nomearquivo+' esta é uma pasta de sistema e não pode ser deletada!!!'),'Criação de Pasta');
       end;
  {$IFNDEF LINUX}
    nomearquivo := nomearquivo + 'ibisis\relatorios\geracao';
  {$Else}
    nomearquivo := nomearquivo + 'ibisis/relatorios/geracao';
  {$EndIf}
     If not DirectoryExists(nomearquivo) then
       begin
         MkDir(nomearquivo);
         Application.MessageBox(PChar('O Sistema criou a pasta '+nomearquivo+' esta é uma pasta de sistema e não pode ser deletada!!!'),'Criação de Pasta');
       end;
  {$IFNDEF LINUX}
    nomearquivo := nomearquivo+'\' ;
  {$Else}
    nomearquivo := nomearquivo+'/';
  {$endIF}
   result := nomearquivo;
end;


 Function VerificaDigito11(Valor: String; Base: Integer = 11; Resto: boolean = false) :String;
 Var
   Soma : integer;
   Contador, Peso, Digito : integer;
 begin
    soma := 0;
    Peso := 2;
    for Contador := Length(Valor) downto 1 do
      begin
        soma := soma + (StrToInt(Valor[Contador]) * Peso);
        if Peso < Base then
          Peso := peso + 1
        else
          Peso := 2;
      end;
      if Resto then
        Result := IntToStr(soma mod 11)
      else
         begin
           Digito := 11 - (Soma mod 11);
           if (Digito > 9) then
              Digito := 0;
            Result := IntToStr(Digito);
         end
 end;
 Function VerDvCpf(Valor: String; Base: Integer = 11) :boolean;
 Var
   Soma : integer;
   Contador, Peso, dv1,dv2,resto : integer;
   novovalor :string;
 begin
    soma := 0;
    Peso := 2;
    novovalor:=copy(valor,1,9);
    for Contador := Length(novovalor) downto 1 do
      begin
        soma := soma + (StrToInt(novovalor[Contador]) * Peso);
        if Peso = Base then
          Peso := 2
        else
          Peso := peso + 1;
      end;
    resto := (Soma mod 11);
    if resto = 0 then
      dv1 := 0
    else
      dv1 := 11 - resto;
    if (dv1 >9) then
      dv1 := 0;
    soma := 0;
    Peso := 2;
    novovalor:=copy(valor,1,10);
    for Contador := Length(novovalor) downto 1 do
      begin
        soma := soma + (StrToInt(novovalor[Contador]) * Peso);
        if Peso = Base then
          Peso := 2
        else
          Peso := peso + 1;
      end;
    resto := (Soma mod 11);
    if resto = 0 then
      dv2 := 0
    else
      dv2 := 11 - resto;
    if (dv2 > 9) then
      dv2 := 0;
    if (copy(valor,10,1) = IntToStr(dv1)) and (copy(valor,11,1) = IntToStr(dv2))  then
      Result := true
    else
      result:=false;
 end;

 Function VerificaDigito7(Valor: String; Base: Integer = 7; Resto: boolean = false) :String;
 Var
   Soma : integer;
   Contador, Peso, Digito : integer;
 begin
    soma := 0;
    Peso := 2;
    for Contador := Length(Valor) downto 1 do
      begin
        soma := soma + (StrToInt(Valor[Contador]) * Peso);
        if Peso = Base then
          Peso := 2
        else
          Peso := peso + 1
      end;
      if Resto then
        Result := IntToStr(soma mod 11)
      else
         begin
           Digito := 11 - (Soma mod 11);
           if (Digito > 9) then
              Digito := 0;
            Result := IntToStr(Digito);
         end
 end;

 Function VerificaValidade_Codigo(verifica: String) :String;
  var
    numeros:array[0..11] of integer;
    cont,atual_cont:Integer;
    codigo_correto:array[0..0] of String;
  begin
    numeros[0]:=6*7;
    atual_cont:=6;
    for cont:=1 to 11 do
      begin
        if cont=6 then
          atual_cont:=7;
        numeros[cont]:=StrToInt(copy(verifica,cont,1))*atual_cont;
        atual_cont:=atual_cont-1;
      end;
    codigo_correto[0]:=IntToStr((numeros[0]+numeros[1]+numeros[2]+numeros[3]+numeros[4]+numeros[5]+numeros[6]+numeros[7]+numeros[8]+numeros[9]+numeros[10]+numeros[11])mod(11));
    if codigo_correto[0]<>'0' then
      codigo_correto[0]:=IntToStr(11-StrToInt(codigo_correto[0]));
    if (codigo_correto[0]=copy(verifica,13,1)) or ((codigo_correto[0]='10') and (copy(verifica,13,1)='P')) then
        Result:='correto'
      else
        begin
          Result:='erro';
          //(pchar('O código digitado está incorreto!!!','Validação de código'),);
          showmessage('O código digitado está incorreto!!!');
        end;
  end;

Function vernum(Str: string):boolean;
Const Num = '0123456789';
Var
  X,digito,resto: Integer;
  Aux : String;
  flag:boolean;
Begin
 Aux := '';
 flag:=true;
  For x:= 1 To Length(Str) do
     Begin
       If Pos(Str[X],Num) = 0 Then
           flag := false
    end;
    Result := flag;
End;

Function verzero(Str: string):boolean;
Const Num = '000';
Var
  X: Integer;
Begin
result:=true;
  For x:= 1 To 3 do
     Begin
       If Pos(Str[X],Num) = 1 Then
           result := false
    end;
End;

Function vcobjnet(num: string;base:integer = 11):string;
var
 i,j,aux: integer;
 dv:string;
Begin
  j:= 7;
  aux:=0;
  for i := Length(num) downto 1 do
    begin
      case j of
        1:   j :=  2;
        10:  j :=  7;
      end;
      case j of
        7:  begin
            aux := (StrToInt(copy(num,i,1))* j) + aux;
            j:=j+2;
          end;
        9:
          begin
            aux := (StrToInt(copy(num,i,1))* j) + aux;
            j:=j-4;
          end;
        else
          begin
           if (j mod 2 = 0) then
            begin
              aux := (StrToInt(copy(num,i,1))* j) + aux;
              j:=j+2;
            end
           else
              begin
                aux := (StrToInt(copy(num,i,1))* j) + aux;
                j:=j-2;
              end;
          end;
      end;
    end;
    if (aux mod base = 0) then
      dv:='5'
    else if (aux mod base = 1) then
      dv:='0'
    else
    dv  := inttostr(11 - (aux mod base));
    result :=dv;

{EXT.TEXTO(B2;1;1)*8+EXT.TEXTO(B2;2;1)*6+EXT.TEXTO(B2;3;1)*4+
EXT.TEXTO(B2;4;1)*2+EXT.TEXTO(B2;5;1)*3+EXT.TEXTO(B2;6;1)*5+
EXT.TEXTO(B2;7;1)*9+EXT.TEXTO(B2;8;1)*7)}
{
SE(MOD((EXT.TEXTO(B2;1;1)*8+EXT.TEXTO(B2;2;1)*6+EXT.TEXTO(B2;3;1)*4+
EXT.TEXTO(B2;4;1)*2+EXT.TEXTO(B2;5;1)*3+EXT.TEXTO(B2;6;1)*5+
EXT.TEXTO(B2;7;1)*9+EXT.TEXTO(B2;8;1)*7);11)=0;5;
SE(MOD((EXT.TEXTO(B2;1;1)*8+EXT.TEXTO(B2;2;1)*6+EXT.TEXTO(B2;3;1)*4+
EXT.TEXTO(B2;4;1)*2+EXT.TEXTO(B2;5;1)*3+EXT.TEXTO(B2;6;1)*5+
EXT.TEXTO(B2;7;1)*9+EXT.TEXTO(B2;8;1)*7);11)=1;0;
11-MOD((EXT.TEXTO(B2;1;1)*8+EXT.TEXTO(B2;2;1)*6+EXT.TEXTO(B2;3;1)*4
+EXT.TEXTO(B2;4;1)*2+EXT.TEXTO(B2;5;1)*3+EXT.TEXTO(B2;6;1)*5+
EXT.TEXTO(B2;7;1)*9+EXT.TEXTO(B2;8;1)*7);11)))}

End;
Function criadir(texto:String):String;
var
dir:string;
begin
  dir := getcurrentdir;
//  dir := copy(dir,length(dir)-3,3);
  dir :=  dir + texto;
  if Not(DirectoryExists(dir)) then
  begin
      Mkdir(dir);
      Application.MessageBox(PChar('O Sistema Criou a Pasta: '+texto),'ADS',0);
  end;
  result:=dir;
end;
//////////////////// classe excel

const
  // XL Tokens
  XL_DIM = $00;
  XL_BOF = $09;
  XL_EOF = $0A;
  XL_DOCUMENT = $10;
  XL_FORMAT = $1E;
  XL_COLWIDTH = $24;
  XL_FONT = $31;

  // XL Cell Types
  XL_INTEGER = $02;
  XL_DOUBLE = $03;
  XL_STRING = $04;

  // XL Cell Formats
  XL_INTFORMAT = $81;
  XL_DBLFORMAT = $82;
  XL_XDTFORMAT = $83;
  XL_DTEFORMAT = $84;
  XL_TMEFORMAT = $85;
  XL_HEADBOLD = $40;
  XL_HEADSHADE = $F8;

  // ========================
  // Create the class
  // ========================

constructor TDataSetToExcel.Create(ADataSet: TDataSet;
  const AFileName,cab: string);
begin
  FDataSet  := ADataSet;
  FFileName := ChangeFileExt(AFilename, '.xls');
  Fcab      :=  cab;
end;

// ====================================
// Write a Token Descripton Header
// ====================================

procedure TDataSetToExcel.WriteToken(AToken: word; ALength: word);
var
  aTOKBuffer: array[0..1] of word;
begin
  aTOKBuffer[0] := AToken;
  aTOKBuffer[1] := ALength;
  Blockwrite(FDataFile, aTOKBuffer, SizeOf(aTOKBuffer));
end;

// ====================================
// Write the font information
// ====================================

procedure TDataSetToExcel.WriteFont(const AFontName: string;
  AFontHeight, AAttribute: word);
var
  iLen: byte;
begin
  AFontHeight := AFontHeight * 20;
  WriteToken(XL_FONT, 5 + length(AFontName));
  BlockWrite(FDataFile, AFontHeight, 2);
  BlockWrite(FDataFile, AAttribute, 2);
  iLen := length(AFontName);
  BlockWrite(FDataFile, iLen, 1);
  BlockWrite(FDataFile, AFontName[1], iLen);
end;

// ====================================
// Write the format information
// ====================================

procedure TDataSetToExcel.WriteFormat(const AFormatStr: string);
var
  iLen: byte;
begin
  WriteToken(XL_FORMAT, 1 + length(AFormatStr));
  iLen := length(AFormatStr);
  BlockWrite(FDataFile, iLen, 1);
  BlockWrite(FDataFile, AFormatStr[1], iLen);
end;

// ====================================
// Write the XL file from data set
// ====================================

function TDataSetToExcel.WriteFile: boolean;
var
  bRetvar: boolean;
  aDOCBuffer: array[0..1] of word;
  aDIMBuffer: array[0..3] of word;
  aAttributes: array[0..2] of byte;
  i,clin,ctot: integer;
  iColNum,
    iDataLen: byte;
  sStrData: string;
  fDblData: double;
  wWidth: word;
begin
  bRetvar := true;
  FRow := 0;
  FillChar(aAttributes, SizeOf(aAttributes), 0);
  AssignFile(FDataFile, FFileName);

  try
    Rewrite(FDataFile, 1);
    // Beginning of File
    WriteToken(XL_BOF, 4);
    aDOCBuffer[0] := 0;
    aDOCBuffer[1] := XL_DOCUMENT;
    Blockwrite(FDataFile, aDOCBuffer, SizeOf(aDOCBuffer));

    // Font Table
    WriteFont('Arial', 10, 0);
    WriteFont('Arial', 10, 1);
    WriteFont('Courier New', 10, 0);

    // Column widths
    for i := 0 to FDataSet.FieldCount - 1 do
    begin
      wWidth := (FDataSet.Fields[i].DisplayWidth + 1) * 256;
      if FDataSet.FieldDefs[i].DataType = ftDateTime then
        inc(wWidth, 2000);
      if FDataSet.FieldDefs[i].DataType = ftDate then
        inc(wWidth, 1050);
      if FDataSet.FieldDefs[i].DataType = ftTime then
        inc(wWidth, 100);
      WriteToken(XL_COLWIDTH, 4);
      iColNum := i;
      BlockWrite(FDataFile, iColNum, 1);
      BlockWrite(FDataFile, iColNum, 1);
      BlockWrite(FDataFile, wWidth, 2);
    end;

    // Column Formats
    WriteFormat('Text');
    WriteFormat('0');
    WriteFormat('#.##0,00;;');
    WriteFormat('dd/mm/aaaa hh:mm:ss');
    WriteFormat('dd/mm/aaaa');
    WriteFormat('hh:mm:ss');

    // Dimensions
    WriteToken(XL_DIM, 8);
    aDIMBuffer[0] := 0;
//    aDIMBuffer[1] := Min(FDataSet.RecordCount, $FFFF);
    aDIMBuffer[1] := FDataSet.RecordCount;
    aDIMBuffer[2] := 0;
//    aDIMBuffer[3] := Min(FDataSet.FieldCount - 1, $FFFF);
    aDIMBuffer[3] := FDataSet.FieldCount - 1;
    Blockwrite(FDataFile, aDIMBuffer, SizeOf(aDIMBuffer));

    // Column Headers
    if (trim(fcab) <> '') then
      begin
        sStrData := Fcab;
        iDataLen := length(sStrData);
        WriteToken(XL_STRING, iDataLen + 8);
        WriteToken(FRow, i);
        aAttributes[1] := XL_HEADBOLD;
        BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
        BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
        //if iDataLen > 0 then
          BlockWrite(FDataFile, sStrData[1], iDataLen);
        //  ;
        aAttributes[2] := 0;
        inc(FRow);
      end;
    for i := 0 to FDataSet.FieldCount - 1 do
    begin
      sStrData := FDataSet.Fields[i].DisplayName;
      iDataLen := length(sStrData);
      WriteToken(XL_STRING, iDataLen + 8);
      WriteToken(FRow, i);
      aAttributes[1] := XL_HEADBOLD;
//  XL_HEADSHADE
      aAttributes[2] := XL_HEADSHADE;
      BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
      BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
      //if iDataLen > 0 then
        BlockWrite(FDataFile, sStrData[1], iDataLen);
      //  ;
      aAttributes[2] := 0;
    end;
      //Header par Seg de Registros;
      if (trim(fcab) <> '') then
        begin
          sStrData := 'Seq. Registros';
          iDataLen := length(sStrData);
          WriteToken(XL_STRING, iDataLen + 8);
          WriteToken(FRow, i);
          aAttributes[1] := XL_HEADBOLD;
          aAttributes[2] := XL_HEADSHADE;
          BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
          BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
          BlockWrite(FDataFile, sStrData[1], iDataLen);
          aAttributes[2] := 0;
        // Data Rows
        end;
    clin:=1;
    ctot:=0;
    while not FDataSet.Eof do
    begin
      inc(FRow);
      for i := 0 to FDataSet.FieldCount - 1 do
      begin
        case FDataSet.FieldDefs[i].DataType of
          ftBoolean,
            ftWideString,
            ftFixedChar,
            ftString,
            ftUnknown,
            ftMemo:
            begin
              sStrData := FDataSet.Fields[i].AsString;
              iDataLen := length(sStrData);
              WriteToken(XL_STRING, iDataLen + 8);
              WriteToken(FRow, i);
              aAttributes[1] := 0;
              BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
              BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
              if iDataLen > 0 then
                BlockWrite(FDataFile, sStrData[1], iDataLen);
            end;

          ftAutoInc,
            ftSmallInt,
            ftInteger,
            ftWord,
            ftLargeInt:
            begin
              if (trim(fcab) = '') then
                begin
                  if i = 6 then
                    begin
                      sStrData := GeraNT(FDataSet.Fields[i].AsString,5);
                      iDataLen := length(sStrData);
                      WriteToken(XL_STRING, iDataLen + 8);
                      WriteToken(FRow, i);
                      aAttributes[1] := 0;
                      BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
                      BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
                    BlockWrite(FDataFile, sStrData[1], iDataLen);
                    end
                  else
                  begin
                    fDblData := FDataSet.Fields[i].AsFloat;
                    iDataLen := SizeOf(fDblData);
                    WriteToken(XL_DOUBLE, 15);
                    WriteToken(FRow, i);
                    aAttributes[1] := XL_INTFORMAT;
                    BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
                    BlockWrite(FDataFile, fDblData, iDatalen);
                  end;
                end
              else
                begin
                  sStrData := GeraNT(FDataSet.Fields[i].AsString,5);
                  iDataLen := length(sStrData);
                  WriteToken(XL_STRING, iDataLen + 8);
                  WriteToken(FRow, i);
                  aAttributes[1] := 0;
                  BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
                  BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
                BlockWrite(FDataFile, sStrData[1], iDataLen);
                end;
            end;

          ftFloat,
            ftCurrency,
            ftBcd:
            begin
              if (trim(fcab) <> '') then
                begin
                  if i = 3 then
                    begin
                      sStrData := GeraNT(FDataSet.Fields[i].AsString,5);
                      iDataLen := length(sStrData);
                      WriteToken(XL_STRING, iDataLen + 8);
                      WriteToken(FRow, i);
                      aAttributes[1] := 0;
                      BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
                      BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
                    BlockWrite(FDataFile, sStrData[1], iDataLen);
                    end
                  else
                    begin
                      fDblData := FDataSet.Fields[i].AsFloat;
                      iDataLen := SizeOf(fDblData);
                      WriteToken(XL_DOUBLE, 15);
                      WriteToken(FRow, i);
                      aAttributes[1] := XL_DBLFORMAT;
                      BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
                      BlockWrite(FDataFile, fDblData, iDatalen);
                    end;
                end;
            end;

          ftDateTime:
            begin
              fDblData := FDataSet.Fields[i].AsFloat;
              iDataLen := SizeOf(fDblData);
              WriteToken(XL_DOUBLE, 15);
              WriteToken(FRow, i);
              aAttributes[1] := XL_XDTFORMAT;
              BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
              BlockWrite(FDataFile, fDblData, iDatalen);
            end;

          ftDate:
            begin
              fDblData := FDataSet.Fields[i].AsFloat;
              iDataLen := SizeOf(fDblData);
              WriteToken(XL_DOUBLE, 15);
              WriteToken(FRow, i);
              aAttributes[1] := XL_DTEFORMAT;
              BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
              BlockWrite(FDataFile, fDblData, iDatalen);
            end;

          ftTime:
            begin
              fDblData := FDataSet.Fields[i].AsFloat;
              iDataLen := SizeOf(fDblData);
              WriteToken(XL_DOUBLE, 15);
              WriteToken(FRow, i);
              aAttributes[1] := XL_TMEFORMAT;
              BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
              BlockWrite(FDataFile, fDblData, iDatalen);
            end;

        end;
      end;
      if (fcab<>'') then
        begin
          sStrData := GeraNT(inttostr(clin),7);
          iDataLen := length(sStrData);
          WriteToken(XL_STRING, iDataLen + 8);
          WriteToken(FRow, i);
          aAttributes[1] := 0;
          BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
          BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
    //      if iDataLen > 0 then
            BlockWrite(FDataFile, sStrData[1], iDataLen);
          clin:=clin+1;
        end;
//      if FRow > 3 then
//        ctot  :=  ctot+FDataSet.Fields[2].AsInteger;
      FDataSet.Next;
    end;
    if (ctot>0) then
        begin
          sStrData := format('%4.4d',[ctot]);
          iDataLen := length(sStrData);
          WriteToken(XL_STRING, iDataLen + 8);
          WriteToken(FRow, i);
          aAttributes[1] := 0;
          BlockWrite(FDataFile, aAttributes, SizeOf(aAttributes));
          BlockWrite(FDataFile, iDataLen, SizeOf(iDataLen));
    //      if iDataLen > 0 then
          BlockWrite(FDataFile, sStrData[1], iDataLen);
        end;
    // End of File
    WriteToken(XL_EOF, 0);
    CloseFile(FDataFile);
  except
    bRetvar := false;
  end;

  Result := bRetvar;
end;
function tamlookcbo(tipo:integer):integer;
begin
  with dm do
  begin
    case tipo of
    0:  begin
        SqlAux.Close;
        SqlAux.SQL.Clear;
        SqlAux.SQL.Add('select max(length(trim(ds_motivo))) as "tam" from ibi_motivo_devolucoes');
        SqlAux.Open;
        end;
    end;
  result  :=  SqlAux.Fields[0].AsInteger*8;
  end;
end;

Function ValorMonetario(Armazena: string; key:char):string;
var
    Aux    : string;
begin
  try
     begin
        armazena  := armazena + key;
        aux       := RestauraInteger(Armazena);
        aux       := (FormatFloat('#,##0.000;;', StrToFloat(aux)/100));
        result    :=  copy(aux,1,Length(aux)-1);
     end;
  except
  end;
end;
function strtran(Str: String; Antigo: String; Novo: variant): string;
var
Buffer : string;
x      : integer;
begin
  Buffer := '';
    for x := 1 to length(Str) do begin
      if copy(Str,x,1) = Antigo then begin
        Buffer := Buffer + Novo;
      end else begin
        Buffer := Buffer + copy(Str,x,1);
      end;
    end;
    Result := Buffer;
end;

{
  Obtem o hash Message Digest 5 de um arquivo
}
function md5File(const fileName : string) : string;
var  idmd5 : TIdHashMessageDigest5;
  fs : TFileStream;
  hash : T4x4LongWordRecord;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  fs := TFileStream.Create(fileName, fmOpenRead OR fmShareDenyWrite);
  try
    result := idmd5.AsHex(idmd5.HashValue(fs)) ;
  finally
    fs.Free;
    idmd5.Free;
  end;
end;

{
  Obtem o hash Message Digest 5 de uma string
}
function md5(const input : string) : string;
 var idmd5 : TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := LowerCase(idmd5.AsHex(idmd5.HashValue(input)));
  finally
    idmd5.Free;
  end;
end;

{
  Função que valida um número de Objeto do Correios
  Um número de objeto completo é composto por
  [SIGLA OBJ] + [NUM OBJETO] + [DV] + [SIGLA PAIS]
  Ex.: DQ080916102BR desmembra-se em [DG] + [08091610] + [2] + [BR]
  O DV do número de objeto é calculado através do seguinte calculo
  1 - multiplicase um dos 8 termos que o compõe por um multiplicador
      seguindo a ordem abaixo
    TERMO | MULTIPLICADOR | EXEMPLO | RESULTADO
      1   |     8         |  0 * 8  |    0
      2   |     6         |  8 * 6  |   48
      3   |     4         |  0 * 4  |    0
      4   |     2         |  9 * 2  |   18
      5   |     3         |  1 * 3  |    3
      6   |     5         |  6 * 5  |   30
      7   |     9         |  1 * 9  |    9
      8   |     7         |  0 * 7  |    0
  2 - Em seguida somam-se todos os resultados
    Ex.: 0 + 48 + 0 + 18 + 3 + 30 + 9 + 0 = 108
  3 - Divide-se o resultado por 11 e recupera-se o resto (Mod)
     108/11 = 9 + Resto 9
  4 - Subtrai-se o resto de 11 e obteremos o DV
     11 - 9 = 2
     NOTA: Se o Resto for 0, então o DV será 5
           Se o Resto for 1, então o DV será 0
}
function validaNumObjCorreios(const numobj : string) : boolean;
const STR_CALC = '86423597';
var soma, i, resto: Integer;
  dv : String;
begin
   result := false;
  // Validação básica
  // 13 caracteres
  // 2 primeiros caracteres são ALFABÉTICOS
  // do caractere 3 ao 11 são caracteres são NUMÉRICOS
  // caracteres 12 e 13 são ALFABÉTICOS

  if ( (Length(numobj) = 13) AND
      (numobj[1] in ['A'..'Z', 'a'..'z']) AND (numobj[2] in ['A'..'Z', 'a'..'z']) AND
      (numobj[12] in ['A'..'Z', 'a'..'z']) AND (numobj[13] in ['A'..'Z', 'a'..'z'])
      ) then
    begin
      soma := 0;
      for i := 1 to 8 do
        soma:= soma + StrToInt(numobj[i+2]) * StrToInt(STR_CALC[i]);
        
      resto := soma Mod 11;
      if resto = 0 then
        dv := '5'
      else if resto = 1 then
        dv := '0'
      else
        dv := IntToStr(11 - resto);
      if (numobj[11] = dv) then
        result := true;
    end;
end;

end.


