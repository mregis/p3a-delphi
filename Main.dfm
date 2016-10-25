object frmMain: TfrmMain
  Left = 144
  Top = 175
  BorderIcons = [biSystemMenu]
  Caption = 'Controle de Devolu'#231#227'o - Ibi Cart'#245'es'
  ClientHeight = 598
  ClientWidth = 711
  Color = clHotLight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 579
    Width = 711
    Height = 19
    Panels = <
      item
        Text = 'Address SA'
        Width = 80
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end>
    ExplicitTop = 559
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object Cadastros: TMenuItem
      Caption = 'Cadastros'
      object CadUsuario: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = CadUsuarioClick
      end
      object Logof: TMenuItem
        Caption = 'Logof'
        OnClick = LogofClick
      end
    end
    object Devolucao: TMenuItem
      Caption = 'Devolu'#231#227'o'
      object AR1: TMenuItem
        Caption = '&AR'
        OnClick = AR1Click
      end
      object Fac1: TMenuItem
        Caption = 'C&art'#227'o FAC'
        OnClick = Fac1Click
      end
      object Correspondencias: TMenuItem
        Caption = '&Correspond'#234'ncias'
        OnClick = CorrespondenciasClick
      end
      object CartaSenha: TMenuItem
        Caption = 'Carta Senha'
        OnClick = CartaSenhaClick
      end
    end
    object Relatorios: TMenuItem
      Caption = 'Relat'#243'rios'
      object AR2: TMenuItem
        Caption = 'AR'
        OnClick = AR2Click
      end
      object FAC2: TMenuItem
        Caption = 'FAC'
        OnClick = FAC2Click
      end
      object N1: TMenuItem
        Caption = '-'
        Visible = False
      end
      object CadFamilia1: TMenuItem
        Caption = 'Cad. Familia'
        Visible = False
        OnClick = CadFamilia1Click
      end
      object RelatoriosAnalitcos1: TMenuItem
        Caption = 'Relatorios Anal'#237'ticos'
        object AR3: TMenuItem
          Caption = 'AR'
          OnClick = AR3Click
        end
        object FAC3: TMenuItem
          Caption = 'FAC'
          OnClick = FAC3Click
        end
        object FAT3: TMenuItem
          Caption = 'FATURA'
          OnClick = FAT3Click
        end
        object Totalizar: TMenuItem
          Caption = 'Totalizar'
          object RelAna: TMenuItem
            Caption = 'Anal'#237'tico'
            OnClick = RelAnaClick
          end
          object RelSin: TMenuItem
            Caption = 'Sint'#233'tico'
            OnClick = RelSinClick
          end
        end
      end
      object GerarPlanilhas1: TMenuItem
        Caption = 'Gerar Planilhas'
        OnClick = GerarPlanilhas1Click
      end
      object GerarArqDevoluo1: TMenuItem
        Caption = 'Gerar Arq. Devolu'#231#227'o'
        OnClick = GerarArqDevoluo1Click
      end
      object GerarPlanilhadeDevoluo1: TMenuItem
        Caption = 'Gerar Planilha de Devolu'#231#227'o'
        OnClick = GerarPlanilhadeDevoluo1Click
      end
    end
    object Sair: TMenuItem
      Caption = '&Sair'
      OnClick = SairClick
    end
  end
  object TimerMenu: TTimer
    OnTimer = TimerMenuTimer
    Left = 48
    Top = 8
  end
end
