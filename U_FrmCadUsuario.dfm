object FrmCadUsuario: TFrmCadUsuario
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Usu'#225'rio'
  ClientHeight = 373
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 22
    Width = 34
    Height = 13
    Caption = 'Nome: '
  end
  object Label2: TLabel
    Left = 20
    Top = 56
    Width = 32
    Height = 13
    Caption = 'Login: '
  end
  object Label3: TLabel
    Left = 266
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Senha: '
  end
  object EdNome: TEdit
    Left = 55
    Top = 16
    Width = 450
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 0
    OnKeyPress = EdNomeKeyPress
  end
  object EdLogin: TEdit
    Left = 55
    Top = 48
    Width = 200
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 50
    TabOrder = 1
  end
  object EdSenha: TEdit
    Left = 305
    Top = 48
    Width = 200
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 50
    PasswordChar = '*'
    TabOrder = 2
    OnKeyPress = EdSenhaKeyPress
  end
  object Btninclui: TBitBtn
    Left = 168
    Top = 81
    Width = 75
    Height = 25
    Caption = '&Inclui'
    Enabled = False
    TabOrder = 3
    OnClick = BtnincluiClick
  end
  object BtnAltera: TBitBtn
    Left = 248
    Top = 81
    Width = 75
    Height = 25
    Caption = 'Altera'
    Enabled = False
    TabOrder = 4
    OnClick = BtnAlteraClick
  end
  object BtnDesativa: TBitBtn
    Left = 332
    Top = 81
    Width = 75
    Height = 25
    Caption = 'Desativa'
    Enabled = False
    TabOrder = 5
    OnClick = BtnDesativaClick
  end
  object DBGridUsuario: TDBGrid
    Left = 55
    Top = 120
    Width = 450
    Height = 240
    DataSource = DM.DtUsuario
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGridUsuarioDblClick
    OnKeyDown = DBGridUsuarioKeyDown
    OnKeyPress = DBGridUsuarioKeyPress
    OnKeyUp = DBGridUsuarioKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'nomusu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Title.Caption = 'Usu'#225'rio'
        Title.Color = clSkyBlue
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'logusu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Title.Caption = 'Login'
        Title.Color = clSkyBlue
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Width = 125
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'flgusu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Title.Caption = 'Ativo'
        Title.Color = clSkyBlue
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Width = 35
        Visible = True
      end>
  end
end
