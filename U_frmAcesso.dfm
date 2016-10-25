object FrmAcesso: TFrmAcesso
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FrmAcesso'
  ClientHeight = 197
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 20
    Top = 56
    Width = 32
    Height = 13
    Caption = 'Login: '
  end
  object Label3: TLabel
    Left = 20
    Top = 83
    Width = 37
    Height = 13
    Caption = 'Senha: '
  end
  object EdLogin: TEdit
    Left = 55
    Top = 48
    Width = 200
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 50
    TabOrder = 0
  end
  object EdSenha: TEdit
    Left = 55
    Top = 75
    Width = 200
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 50
    PasswordChar = '*'
    TabOrder = 1
  end
  object BtnAcesso: TBitBtn
    Left = 113
    Top = 102
    Width = 75
    Height = 25
    Caption = '&Acesso'
    TabOrder = 2
    OnClick = BtnAcessoClick
  end
end
