object cadFamilia: TcadFamilia
  Left = 224
  Top = 116
  BorderStyle = bsDialog
  Caption = 'Cadastro Familia'
  ClientHeight = 439
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 320
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 0
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 8
    Width = 825
    Height = 393
    ActivePage = TabSheet1
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Dados'
      object DBGrid1: TDBGrid
        Left = 16
        Top = 16
        Width = 785
        Height = 329
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Detalhes'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 27
        Top = 19
        Width = 24
        Height = 13
        Caption = 'ORG'
      end
      object Label2: TLabel
        Left = 23
        Top = 51
        Width = 30
        Height = 13
        Caption = 'LOGO'
      end
      object Label3: TLabel
        Left = 4
        Top = 82
        Width = 48
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label4: TLabel
        Left = 12
        Top = 115
        Width = 41
        Height = 13
        Caption = 'CODBIN'
      end
      object Label5: TLabel
        Left = 19
        Top = 146
        Width = 32
        Height = 13
        Caption = 'Familia'
      end
      object Label6: TLabel
        Left = 6
        Top = 179
        Width = 54
        Height = 13
        Caption = 'Priv./Band.'
      end
      object DBORG: TDBEdit
        Left = 85
        Top = 16
        Width = 257
        Height = 21
        DataField = 'ORG'
        DataSource = DataSource1
        TabOrder = 0
      end
      object DBLOGO: TDBEdit
        Left = 85
        Top = 48
        Width = 257
        Height = 21
        DataField = 'LOGO'
        DataSource = DataSource1
        TabOrder = 1
      end
      object DBDESC: TDBEdit
        Left = 85
        Top = 80
        Width = 257
        Height = 21
        DataField = 'DESCRICAO'
        DataSource = DataSource1
        TabOrder = 2
      end
      object DBCODBIN: TDBEdit
        Left = 85
        Top = 112
        Width = 257
        Height = 21
        DataField = 'CODBIN'
        DataSource = DataSource1
        TabOrder = 3
      end
      object DBFAM: TDBEdit
        Left = 85
        Top = 144
        Width = 257
        Height = 21
        DataField = 'FAMILIA'
        DataSource = DataSource1
        TabOrder = 4
      end
      object DBPRIV: TDBEdit
        Left = 85
        Top = 176
        Width = 257
        Height = 21
        DataField = 'PRIV_BAND'
        DataSource = DataSource1
        TabOrder = 5
      end
      object CoolBar1: TCoolBar
        Left = 0
        Top = 312
        Width = 817
        Height = 53
        Align = alBottom
        Bands = <>
        object sbPrimeiro: TSpeedButton
          Left = 15
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Primeiro'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D4046209
            035F09035606014F04014C04014C04014C04014C04014C04014C04014C04013D
            03C8D0D4DDE2E49FAE9F9FAD9F9FAA9F9FA89F9FA79F9FA79F9FA79F9FA79F9F
            A79F9FA79F9FA79F9FA49FDDE2E40782160C9C23099A1D07961505920F03900B
            038F0A038F0A03900A03900A038F0A03960B027407013D039FBA9F9FC6A09FC5
            A09FC39F9FC19F9FC09F9FC09F9FC09F9FC09F9FC09F9FC09F9FC39F9FB49F9F
            A49F0D982513B53A0FAF2D0CAC2309AB1C06A71504A50E03A50C03A50C03A50C
            03A40C03AC0D03960A014C049FC4A09FD3A49FCFA19FCEA09FCDA09FCB9F9FCA
            9F9FCA9F9FCA9F9FCA9F9FCA9F9FCE9F9FC39F9FA79F10A02D1CB44916AD39FF
            FFFFFFFFFF059F10059F10059F10039E0CFFFFFFFFFFFF03A40C03900A014D04
            9FC8A1A0D2A79FCEA3FFFFFFFFFFFF9FC79F9FC79F9FC79F9FC79FFFFFFFFFFF
            FF9FCA9F9FC09F9FA79F11A12F28B85B1FB24CFFFFFFFFFFFF05A01305A01305
            A013FFFFFFFFFFFFFFFFFF03A50C03900A014C049FC8A1A0D4ABA0D1A7FFFFFF
            FFFFFF9FC89F9FC89F9FC89FFFFFFFFFFFFFFFFFFF9FCA9F9FC09F9FA79F11A1
            2F3EC2702DBA5FFFFFFFFFFFFF13AB3613AB36FFFFFFFFFFFFFFFFFF049E0F03
            A40C03900A014C049FC8A1A4DAB3A1D5ADFFFFFFFFFFFF9FCDA39FCDA3FFFFFF
            FFFFFFFFFFFF9FC79F9FCA9F9FC09F9FA79F11A12F5CCC8838BD67FFFFFFFFFF
            FF18B043FFFFFFFFFFFFFFFFFF14AC3A08A11905A71203910B014D049FC8A1AC
            E0BCA3D7AFFFFFFFFFFFFF9FD0A5FFFFFFFFFFFFFFFFFF9FCEA49FC8A09FCB9F
            9FC19F9FA79F11A12F70D49742C270FFFFFFFFFFFF1BB24DFFFFFFFFFFFFFFFF
            FF18B0470BA62309A91C0593110254059FC8A1B3E4C3A5DAB3FFFFFFFFFFFFA0
            D1A7FFFFFFFFFFFFFFFFFF9FD0A69FCBA09FCCA09FC29F9FAA9F11A12F7DD79F
            4AC576FFFFFFFFFFFF1DB25013AC37FFFFFFFFFFFFFFFFFF0FA92D0DAC270999
            1B035F099FC8A1B8E6C7A7DCB5FFFFFFFFFFFFA0D1A99FCEA3FFFFFFFFFFFFFF
            FFFF9FCCA19FCEA09FC4A09FAD9F11A12F86DAA654C97FFFFFFFFFFFFF1CB24D
            1CB24D1CB24DFFFFFFFFFFFFFFFFFF12AF350D9E25056B0C9FC8A1BCE8CBAADE
            B8FFFFFFFFFFFFA0D1A7A0D1A7A0D1A7FFFFFFFFFFFFFFFFFF9FCFA39FC7A09F
            B19F11A12F93DEB166CF8CFFFFFFFFFFFF2BB85C2BB85C2BB85C23B555FFFFFF
            FFFFFF17B14210A12F06760F9FC8A1C2EAD1AFE1BEFFFFFFFFFFFFA1D4ACA1D4
            ACA1D4ACA0D3AAFFFFFFFFFFFF9FD1A59FC8A19FB59F11A13099E1B590DDAD78
            D59A6CD0915DCB864CC6783FC16D2CBA5D20B5531DB2511CB54F15A93D088414
            9FC8A1C4ECD3C0E9CEB6E5C5B2E2C1ADDFBCA7DCB6A4D9B2A1D5ADA0D3AAA0D1
            A9A0D3A89FCCA49FBB9F11A12F79D79F99E1B69DE2B893DEB183DAA56DD3954F
            C97E35BF6824B75920B5551FB85818AD43098E169FC8A1B6E6C7C4ECD3C7EDD4
            C2EAD1BAE8CAB2E4C2A8DEB8A3D8AFA0D4ABA0D3AAA0D4AB9FCEA59FBF9FC8D0
            D422A94037B55539B55637B55433B2502AAF4921AA401AA63913A43112A13212
            A4310C9A23C8D0D4DDE2E4A0CCA4A3D3AAA3D3AAA3D3AAA2D1A9A1CFA7A0CDA4
            A0CBA39FCAA29FC8A29FCAA29FC5A0DDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbPrimeiroClick
        end
        object sbAnterior: TSpeedButton
          Left = 71
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Anterior'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D4046209
            035F09035606014F04014C04014C04014C04014C04014C04014C04014C04013D
            03C8D0D4DDE2E49FAE9F9FAD9F9FAA9F9FA89F9FA79F9FA79F9FA79F9FA79F9F
            A79F9FA79F9FA79F9FA49FDDE2E40782160C9C23099A1D07961505920F03900B
            038F0A038F0A03900A03900A038F0A03960B027407013D039FBA9F9FC6A09FC5
            A09FC39F9FC19F9FC09F9FC09F9FC09F9FC09F9FC09F9FC09F9FC39F9FB49F9F
            A49F0D982513B53A0FAF2D0CAC2309AB1C06A71504A50E03A50C03A50C03A50C
            03A40C03AC0D03960A014C049FC4A09FD3A49FCFA19FCEA09FCDA09FCB9F9FCA
            9F9FCA9F9FCA9F9FCA9F9FCA9F9FCE9F9FC39F9FA79F10A02D1CB44916AD3911
            A92F0DA726059F10059F10FFFFFFFFFFFF039D0B039C0B03A40C03900A014D04
            9FC8A1A0D2A79FCEA39FCCA19FCBA09FC79F9FC79FFFFFFFFFFFFF9FC79F9FC6
            9F9FCA9F9FC09F9FA79F11A12F28B85B1FB24C18AD3D12AA3505A013FFFFFFFF
            FFFFFFFFFF039F0D039D0B03A50C03900A014C049FC8A1A0D4ABA0D1A79FCEA4
            9FCDA39FC89FFFFFFFFFFFFFFFFFFF9FC79F9FC79F9FCA9F9FC09F9FA79F11A1
            2F3EC2702DBA5F1FB54E18AD42FFFFFFFFFFFFFFFFFF13AB3606A016049E0F03
            A40C03900A014C049FC8A1A4DAB3A1D5ADA0D3A89FCEA5FFFFFFFFFFFFFFFFFF
            9FCDA39FC89F9FC79F9FCA9F9FC09F9FA79F11A12F5CCC8838BD6724B757FFFF
            FFFFFFFFFFFFFF14AC3A14AC3A14AC3A08A11905A71203910B014D049FC8A1AC
            E0BCA3D7AFA0D4AAFFFFFFFFFFFFFFFFFF9FCEA49FCEA49FCEA49FC8A09FCB9F
            9FC19F9FA79F11A12F70D49742C2702AB85BFFFFFFFFFFFFFFFFFF18B04718B0
            4718B0470BA62309A91C0593110254059FC8A1B3E4C3A5DAB3A1D4ABFFFFFFFF
            FFFFFFFFFF9FD0A69FD0A69FD0A69FCBA09FCCA09FC29F9FAA9F11A12F7DD79F
            4AC5762FBB5F24B757FFFFFFFFFFFFFFFFFF13AC3713AC370FA92D0DAC270999
            1B035F099FC8A1B8E6C7A7DCB5A1D6ADA0D4AAFFFFFFFFFFFFFFFFFF9FCEA39F
            CEA39FCCA19FCEA09FC4A09FAD9F11A12F86DAA654C97F3DC06B35BD651CB24D
            FFFFFFFFFFFFFFFFFF18B04515AD3B12AF350D9E25056B0C9FC8A1BCE8CBAADE
            B8A4D9B1A3D7AFA0D1A7FFFFFFFFFFFFFFFFFF9FD0A69FCEA49FCFA39FC7A09F
            B19F11A12F93DEB166CF8C43C2703FC16D2BB85C2BB85CFFFFFFFFFFFF1DB250
            19B04817B14210A12F06760F9FC8A1C2EAD1AFE1BEA5DAB3A4D9B2A1D4ACA1D4
            ACFFFFFFFFFFFFA0D1A9A0D0A79FD1A59FC8A19FB59F11A13099E1B590DDAD78
            D59A6CD0915DCB864CC6783FC16D2CBA5D20B5531DB2511CB54F15A93D088414
            9FC8A1C4ECD3C0E9CEB6E5C5B2E2C1ADDFBCA7DCB6A4D9B2A1D5ADA0D3AAA0D1
            A9A0D3A89FCCA49FBB9F11A12F79D79F99E1B69DE2B893DEB183DAA56DD3954F
            C97E35BF6824B75920B5551FB85818AD43098E169FC8A1B6E6C7C4ECD3C7EDD4
            C2EAD1BAE8CAB2E4C2A8DEB8A3D8AFA0D4ABA0D3AAA0D4AB9FCEA59FBF9FC8D0
            D422A94037B55539B55637B55433B2502AAF4921AA401AA63913A43112A13212
            A4310C9A23C8D0D4DDE2E4A0CCA4A3D3AAA3D3AAA3D3AAA2D1A9A1CFA7A0CDA4
            A0CBA39FCAA29FC8A29FCAA29FC5A0DDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbAnteriorClick
        end
        object sbProximo: TSpeedButton
          Left = 127
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Proximo'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D4046209
            035F09035606014F04014C04014C04014C04014C04014C04014C04014C04013D
            03C8D0D4DDE2E49FAE9F9FAD9F9FAA9F9FA89F9FA79F9FA79F9FA79F9FA79F9F
            A79F9FA79F9FA79F9FA49FDDE2E40782160C9C23099A1D07961505920F03900B
            038F0A038F0A03900A03900A038F0A03960B027407013D039FBA9F9FC6A09FC5
            A09FC39F9FC19F9FC09F9FC09F9FC09F9FC09F9FC09F9FC09F9FC39F9FB49F9F
            A49F0D982513B53A0FAF2D0CAC2309AB1C06A71504A50E03A50C03A50C03A50C
            03A40C03AC0D03960A014C049FC4A09FD3A49FCFA19FCEA09FCDA09FCB9F9FCA
            9F9FCA9F9FCA9F9FCA9F9FCA9F9FCE9F9FC39F9FA79F10A02D1CB44916AD3911
            A92F0DA726FFFFFFFFFFFF059F10039E0C039D0B039C0B03A40C03900A014D04
            9FC8A1A0D2A79FCEA39FCCA19FCBA0FFFFFFFFFFFF9FC79F9FC79F9FC79F9FC6
            9F9FCA9F9FC09F9FA79F11A12F28B85B1FB24C18AD3D12AA35FFFFFFFFFFFFFF
            FFFF05A013039F0D039D0B03A50C03900A014C049FC8A1A0D4ABA0D1A79FCEA4
            9FCDA3FFFFFFFFFFFFFFFFFF9FC89F9FC79F9FC79F9FCA9F9FC09F9FA79F11A1
            2F3EC2702DBA5F1FB54E18AD4213AB36FFFFFFFFFFFFFFFFFF06A016049E0F03
            A40C03900A014C049FC8A1A4DAB3A1D5ADA0D3A89FCEA59FCDA3FFFFFFFFFFFF
            FFFFFF9FC89F9FC79F9FCA9F9FC09F9FA79F11A12F5CCC8838BD6724B7571FB4
            5018B04314AC3AFFFFFFFFFFFFFFFFFF08A11905A71203910B014D049FC8A1AC
            E0BCA3D7AFA0D4AAA0D2A99FD0A59FCEA4FFFFFFFFFFFFFFFFFF9FC8A09FCB9F
            9FC19F9FA79F11A12F70D49742C2702AB85B21B5531BB24D18B047FFFFFFFFFF
            FFFFFFFF0BA62309A91C0593110254059FC8A1B3E4C3A5DAB3A1D4ABA0D3AAA0
            D1A79FD0A6FFFFFFFFFFFFFFFFFF9FCBA09FCCA09FC29F9FAA9F11A12F7DD79F
            4AC5762FBB5F24B7571DB250FFFFFFFFFFFFFFFFFF13AC370FA92D0DAC270999
            1B035F099FC8A1B8E6C7A7DCB5A1D6ADA0D4AAA0D1A9FFFFFFFFFFFFFFFFFF9F
            CEA39FCCA19FCEA09FC4A09FAD9F11A12F86DAA654C97F3DC06B35BD65FFFFFF
            FFFFFFFFFFFF1CB24D18B04515AD3B12AF350D9E25056B0C9FC8A1BCE8CBAADE
            B8A4D9B1A3D7AFFFFFFFFFFFFFFFFFFFA0D1A79FD0A69FCEA49FCFA39FC7A09F
            B19F11A12F93DEB166CF8C43C2703FC16DFFFFFFFFFFFF2BB85C23B5551DB250
            19B04817B14210A12F06760F9FC8A1C2EAD1AFE1BEA5DAB3A4D9B2FFFFFFFFFF
            FFA1D4ACA0D3AAA0D1A9A0D0A79FD1A59FC8A19FB59F11A13099E1B590DDAD78
            D59A6CD0915DCB864CC6783FC16D2CBA5D20B5531DB2511CB54F15A93D088414
            9FC8A1C4ECD3C0E9CEB6E5C5B2E2C1ADDFBCA7DCB6A4D9B2A1D5ADA0D3AAA0D1
            A9A0D3A89FCCA49FBB9F11A12F79D79F99E1B69DE2B893DEB183DAA56DD3954F
            C97E35BF6824B75920B5551FB85818AD43098E169FC8A1B6E6C7C4ECD3C7EDD4
            C2EAD1BAE8CAB2E4C2A8DEB8A3D8AFA0D4ABA0D3AAA0D4AB9FCEA59FBF9FC8D0
            D422A94037B55539B55637B55433B2502AAF4921AA401AA63913A43112A13212
            A4310C9A23C8D0D4DDE2E4A0CCA4A3D3AAA3D3AAA3D3AAA2D1A9A1CFA7A0CDA4
            A0CBA39FCAA29FC8A29FCAA29FC5A0DDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbProximoClick
        end
        object sbUltimo: TSpeedButton
          Left = 183
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Ultimo'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D4046209
            035F09035606014F04014C04014C04014C04014C04014C04014C04014C04013D
            03C8D0D4DDE2E49FAE9F9FAD9F9FAA9F9FA89F9FA79F9FA79F9FA79F9FA79F9F
            A79F9FA79F9FA79F9FA49FDDE2E40782160C9C23099A1D07961505920F03900B
            038F0A038F0A03900A03900A038F0A03960B027407013D039FBA9F9FC6A09FC5
            A09FC39F9FC19F9FC09F9FC09F9FC09F9FC09F9FC09F9FC09F9FC39F9FB49F9F
            A49F0D982513B53A0FAF2D0CAC2309AB1C06A71504A50E03A50C03A50C03A50C
            03A40C03AC0D03960A014C049FC4A09FD3A49FCFA19FCEA09FCDA09FCB9F9FCA
            9F9FCA9F9FCA9F9FCA9F9FCA9F9FCE9F9FC39F9FA79F10A02D1CB44916AD39FF
            FFFFFFFFFF059F10059F10059F10039E0CFFFFFFFFFFFF03A40C03900A014D04
            9FC8A1A0D2A79FCEA3FFFFFFFFFFFF9FC79F9FC79F9FC79F9FC79FFFFFFFFFFF
            FF9FCA9F9FC09F9FA79F11A12F28B85B1FB24CFFFFFFFFFFFFFFFFFF05A01305
            A01305A013FFFFFFFFFFFF03A50C03900A014C049FC8A1A0D4ABA0D1A7FFFFFF
            FFFFFFFFFFFF9FC89F9FC89F9FC89FFFFFFFFFFFFF9FCA9F9FC09F9FA79F11A1
            2F3EC2702DBA5F1FB54EFFFFFFFFFFFFFFFFFF13AB3613AB36FFFFFFFFFFFF03
            A40C03900A014C049FC8A1A4DAB3A1D5ADA0D3A8FFFFFFFFFFFFFFFFFF9FCDA3
            9FCDA3FFFFFFFFFFFF9FCA9F9FC09F9FA79F11A12F5CCC8838BD6724B7571FB4
            50FFFFFFFFFFFFFFFFFF14AC3AFFFFFFFFFFFF05A71203910B014D049FC8A1AC
            E0BCA3D7AFA0D4AAA0D2A9FFFFFFFFFFFFFFFFFF9FCEA4FFFFFFFFFFFF9FCB9F
            9FC19F9FA79F11A12F70D49742C2702AB85B21B553FFFFFFFFFFFFFFFFFF18B0
            47FFFFFFFFFFFF09A91C0593110254059FC8A1B3E4C3A5DAB3A1D4ABA0D3AAFF
            FFFFFFFFFFFFFFFF9FD0A6FFFFFFFFFFFF9FCCA09FC29F9FAA9F11A12F7DD79F
            4AC5762FBB5FFFFFFFFFFFFFFFFFFF13AC3713AC37FFFFFFFFFFFF0DAC270999
            1B035F099FC8A1B8E6C7A7DCB5A1D6ADFFFFFFFFFFFFFFFFFF9FCEA39FCEA3FF
            FFFFFFFFFF9FCEA09FC4A09FAD9F11A12F86DAA654C97FFFFFFFFFFFFFFFFFFF
            1CB24D1CB24D1CB24DFFFFFFFFFFFF12AF350D9E25056B0C9FC8A1BCE8CBAADE
            B8FFFFFFFFFFFFFFFFFFA0D1A7A0D1A7A0D1A7FFFFFFFFFFFF9FCFA39FC7A09F
            B19F11A12F93DEB166CF8CFFFFFFFFFFFF2BB85C2BB85C2BB85C23B555FFFFFF
            FFFFFF17B14210A12F06760F9FC8A1C2EAD1AFE1BEFFFFFFFFFFFFA1D4ACA1D4
            ACA1D4ACA0D3AAFFFFFFFFFFFF9FD1A59FC8A19FB59F11A13099E1B590DDAD78
            D59A6CD0915DCB864CC6783FC16D2CBA5D20B5531DB2511CB54F15A93D088414
            9FC8A1C4ECD3C0E9CEB6E5C5B2E2C1ADDFBCA7DCB6A4D9B2A1D5ADA0D3AAA0D1
            A9A0D3A89FCCA49FBB9F11A12F79D79F99E1B69DE2B893DEB183DAA56DD3954F
            C97E35BF6824B75920B5551FB85818AD43098E169FC8A1B6E6C7C4ECD3C7EDD4
            C2EAD1BAE8CAB2E4C2A8DEB8A3D8AFA0D4ABA0D3AAA0D4AB9FCEA59FBF9FC8D0
            D422A94037B55539B55637B55433B2502AAF4921AA401AA63913A43112A13212
            A4310C9A23C8D0D4DDE2E4A0CCA4A3D3AAA3D3AAA3D3AAA2D1A9A1CFA7A0CDA4
            A0CBA39FCAA29FC8A29FCAA29FC5A0DDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbUltimoClick
        end
        object sbAdd: TSpeedButton
          Left = 239
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Adicionar'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D46C2A00
            6828005D24005320004F1F004F1F004F1F004F1F004F1F004F1F004F1F004018
            00C8D0D4DDE2E4B2A19FAFA09FADA09FAAA09FA8A09FA8A09FA8A09FA8A09FA8
            A09FA8A09FA8A09FA49F9FDDE2E4973B00BB4900B44600AA4200A03F00993C00
            973B00973B00993C00993C00973B009E3E007B3000401800C3A49FD6A79FD2A6
            9FCDA59FC8A49FC4A49FC3A49FC3A49FC4A49FC4A49FC3A49FC7A49FB7A19FA4
            9F9FB84800E35900D45300CC5000C54D00BB4900B14500AF4400AF4400AF4400
            AF4400B647009E3E004F1F00D4A79FEDAB9FE4AA9FE0A99FDCA79FD6A79FD1A6
            9FCFA69FCFA69FCFA69FCFA69FD3A69FC7A49FA8A09FC74E00F05E00E15800D1
            5200C74E00C04B00FFFFFFFFFFFFD45300A74100A54100AF4400993C00511F00
            DDA89FF5AD9FECAB9FE3A99FDDA89FD9A79FFFFFFFFFFFFFE4AA9FCBA59FCAA5
            9FCFA69FC4A49FA9A09FCA4F00FF6802F66000E35900D45300CA4F00FFFFFFFF
            FFFFD45300AA4200A74100AF4400993C004F1F00DFA89FFFAF9FF9AD9FEDAB9F
            E4AA9FDFA89FFFFFFFFFFFFFE4AA9FCDA59FCBA59FCFA69FC4A49FA8A09FCA4F
            00FF7A16FF6C06FF6A04FF6A04FF6A04FFFFFFFFFFFFD45300D45300D45300AF
            4400993C004F1F00DFA89FFFB69FFFB29FFFB19FFFB19FFFB19FFFFFFFFFFFFF
            E4AA9FE4AA9FE4AA9FCFA69FC4A49FA8A09FCA4F00FF9035FF750FFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB647009C3D00511F00DFA89FFF
            C0A3FFB49FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3A69F
            C6A49FA9A09FCA4F00FF9F4EFF7D19FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFC04B00A34000592300DFA89FFFC7A8FFB8A0FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9A79FC9A49FABA09FCA4F00FFA65A
            FF8221FF6E08FF6601FF6A04FFFFFFFFFFFFFF6A04D95500CF5100CC5000B145
            006A2900DFA89FFFCBABFFBAA0FFB29FFFAF9FFFB19FFFFFFFFFFFFFFFB19FE7
            AA9FE1A99FE0A99FD1A69FB1A19FCA4F00FFAD67FF8A2DFF7813FF730DFF6903
            FFFFFFFFFFFFFF6A04E65A00DE5700D95500BD4A00792F00DFA89FFFCEAFFFBD
            A1FFB69FFFB49FFFB09FFFFFFFFFFFFFFFB19FEFAB9FEAAA9FE7AA9FD7A79FB6
            A19FCA4F00FFB676FF9741FF7E1BFF7A16FF720CFFFFFFFFFFFFFF6A04F05E00
            E95B00E65A00C74E00873500DFA89FFFD3B5FFC3A5FFB8A0FFB69FFFB39FFFFF
            FFFFFFFFFFB19FF5AD9FF1AB9FEFAB9FDDA89FBCA39FCA4F00FFBB7FFFB472FF
            A456FF9A46FF9035FF8424FF7A16FF6B05F86200F05E00F05E00D95500993C00
            DFA89FFFD6B8FFD2B3FFCAAAFFC5A6FFC0A3FFBBA0FFB69FFFB19FFBAE9FF5AD
            9FF5AD9FE7AA9FC4A49FCA4F00FFA558FFBB7FFFBD83FFB676FFAC65FF9D4AFF
            8728FF740EFF6601F86200FB6300E35900A54100DFA89FFFCAABFFD6B8FFD7BA
            FFD3B5FFCEAFFFC7A7FFBCA0FFB49FFFAF9FFBAE9FFCAE9FEDAB9FCAA59FC8D0
            D4EE5D00FF700AFF720CFF700AFF6C06FF6601EE5D00DE5700D15200CC5000CF
            5100B84800C8D0D4DDE2E4F4AD9FFFB39FFFB39FFFB39FFFB29FFFAF9FF4AD9F
            EAAA9FE3A99FE0A99FE1A99FD4A79FDDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbAddClick
        end
        object sbRemove: TSpeedButton
          Left = 295
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Remover'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D46C2A00
            6828005D24005320004F1F004F1F004F1F004F1F004F1F004F1F004F1F004018
            00C8D0D4DDE2E4B2A19FAFA09FADA09FAAA09FA8A09FA8A09FA8A09FA8A09FA8
            A09FA8A09FA8A09FA49F9FDDE2E4973B00BB4900B44600AA4200A03F00993C00
            973B00973B00993C00993C00973B009E3E007B3000401800C3A49FD6A79FD2A6
            9FCDA59FC8A49FC4A49FC3A49FC3A49FC4A49FC4A49FC3A49FC7A49FB7A19FA4
            9F9FB84800E35900D45300CC5000C54D00BB4900B14500AF4400AF4400AF4400
            AF4400B647009E3E004F1F00D4A79FEDAB9FE4AA9FE0A99FDCA79FD6A79FD1A6
            9FCFA69FCFA69FCFA69FCFA69FD3A69FC7A49FA8A09FC74E00F05E00E15800D1
            5200C74E00C04B00B64700A74100A74100A74100A54100AF4400993C00511F00
            DDA89FF5AD9FECAB9FE3A99FDDA89FD9A79FD3A69FCBA59FCBA59FCBA59FCAA5
            9FCFA69FC4A49FA9A09FCA4F00FF6802F66000E35900D45300CA4F00AA4200AA
            4200AA4200AA4200A74100AF4400993C004F1F00DFA89FFFAF9FF9AD9FEDAB9F
            E4AA9FDFA89FCDA59FCDA59FCDA59FCDA59FCBA59FCFA69FC4A49FA8A09FCA4F
            00FF7A16FF6C06FF6A04FF6A04FF6A04FF6A04FF6A04D45300D45300D45300AF
            4400993C004F1F00DFA89FFFB69FFFB29FFFB19FFFB19FFFB19FFFB19FFFB19F
            E4AA9FE4AA9FE4AA9FCFA69FC4A49FA8A09FCA4F00FF9035FF750FFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB647009C3D00511F00DFA89FFF
            C0A3FFB49FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3A69F
            C6A49FA9A09FCA4F00FF9F4EFF7D19FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFC04B00A34000592300DFA89FFFC7A8FFB8A0FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9A79FC9A49FABA09FCA4F00FFA65A
            FF8221FF6E08FF6601FF6A04FF6A04FF6A04FF6A04D95500CF5100CC5000B145
            006A2900DFA89FFFCBABFFBAA0FFB29FFFAF9FFFB19FFFB19FFFB19FFFB19FE7
            AA9FE1A99FE0A99FD1A69FB1A19FCA4F00FFAD67FF8A2DFF7813FF730DFF6903
            E65A00E65A00E65A00E65A00DE5700D95500BD4A00792F00DFA89FFFCEAFFFBD
            A1FFB69FFFB49FFFB09FEFAB9FEFAB9FEFAB9FEFAB9FEAAA9FE7AA9FD7A79FB6
            A19FCA4F00FFB676FF9741FF7E1BFF7A16FF720CFF6B05F05E00F05E00F05E00
            E95B00E65A00C74E00873500DFA89FFFD3B5FFC3A5FFB8A0FFB69FFFB39FFFB1
            9FF5AD9FF5AD9FF5AD9FF1AB9FEFAB9FDDA89FBCA39FCA4F00FFBB7FFFB472FF
            A456FF9A46FF9035FF8424FF7A16FF6B05F86200F05E00F05E00D95500993C00
            DFA89FFFD6B8FFD2B3FFCAAAFFC5A6FFC0A3FFBBA0FFB69FFFB19FFBAE9FF5AD
            9FF5AD9FE7AA9FC4A49FCA4F00FFA558FFBB7FFFBD83FFB676FFAC65FF9D4AFF
            8728FF740EFF6601F86200FB6300E35900A54100DFA89FFFCAABFFD6B8FFD7BA
            FFD3B5FFCEAFFFC7A7FFBCA0FFB49FFFAF9FFBAE9FFCAE9FEDAB9FCAA59FC8D0
            D4EE5D00FF700AFF720CFF700AFF6C06FF6601EE5D00DE5700D15200CC5000CF
            5100B84800C8D0D4DDE2E4F4AD9FFFB39FFFB39FFFB39FFFB29FFFAF9FF4AD9F
            EAAA9FE3A99FE0A99FE1A99FD4A79FDDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbRemoveClick
        end
        object sbEditar: TSpeedButton
          Left = 351
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Editar'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D46C2A00
            6828005D24005320004F1F004F1F004F1F004F1F004F1F004F1F004F1F004018
            00C8D0D4DDE2E4B2A19FAFA09FADA09FAAA09FA8A09FA8A09FA8A09FA8A09FA8
            A09FA8A09FA8A09FA49F9FDDE2E4973B00BB4900B44600AA4200A03F00993C00
            973B00973B00993C00993C00973B009E3E007B3000401800C3A49FD6A79FD2A6
            9FCDA59FC8A49FC4A49FC3A49FC3A49FC4A49FC4A49FC3A49FC7A49FB7A19FA4
            9F9FB84800E35900D45300CC5000C54D00BB4900B14500AF4400AF4400AF4400
            AF4400B647009E3E004F1F00D4A79FEDAB9FE4AA9FE0A99FDCA79FD6A79FD1A6
            9FCFA69FCFA69FCFA69FCFA69FD3A69FC7A49FA8A09FC74E00F05E00E15800D1
            5200C74E00C04B00B64700A74100A74100A74100A54100AF4400993C00511F00
            DDA89FF5AD9FECAB9FE3A99FDDA89FD9A79FD3A69FCBA59FCBA59FCBA59FCAA5
            9FCFA69FC4A49FA9A09FCA4F00FF6802D45300D45300D45300D45300D45300D4
            5300D45300D45300D45300D45300993C004F1F00DFA89FFFAF9FE4AA9FE4AA9F
            E4AA9FE4AA9FE4AA9FE4AA9FE4AA9FE4AA9FE4AA9FE4AA9FC4A49FA8A09FCA4F
            00FF7A16D45300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD4
            5300993C004F1F00DFA89FFFB69FE4AA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFE4AA9FC4A49FA8A09FCA4F00FF9035FF750FD45300FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD45300B647009C3D00511F00DFA89FFF
            C0A3FFB49FE4AA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4AA9FD3A69F
            C6A49FA9A09FCA4F00FF9F4EFF7D19FF6A04D45300FFFFFFFFFFFFFFFFFFFFFF
            FFD45300C24C00C04B00A34000592300DFA89FFFC7A8FFB8A0FFB19FE4AA9FFF
            FFFFFFFFFFFFFFFFFFFFFFE4AA9FDAA79FD9A79FC9A49FABA09FCA4F00FFA65A
            FF8221FF6E08FF6601D45300FFFFFFFFFFFFD45300D95500CF5100CC5000B145
            006A2900DFA89FFFCBABFFBAA0FFB29FFFAF9FE4AA9FFFFFFFFFFFFFE4AA9FE7
            AA9FE1A99FE0A99FD1A69FB1A19FCA4F00FFAD67FF8A2DFF7813FF730DFF6903
            D45300D45300E65A00E65A00DE5700D95500BD4A00792F00DFA89FFFCEAFFFBD
            A1FFB69FFFB49FFFB09FE4AA9FE4AA9FEFAB9FEFAB9FEAAA9FE7AA9FD7A79FB6
            A19FCA4F00FFB676FF9741FF7E1BFF7A16FF720CFF6B05F05E00F05E00F05E00
            E95B00E65A00C74E00873500DFA89FFFD3B5FFC3A5FFB8A0FFB69FFFB39FFFB1
            9FF5AD9FF5AD9FF5AD9FF1AB9FEFAB9FDDA89FBCA39FCA4F00FFBB7FFFB472FF
            A456FF9A46FF9035FF8424FF7A16FF6B05F86200F05E00F05E00D95500993C00
            DFA89FFFD6B8FFD2B3FFCAAAFFC5A6FFC0A3FFBBA0FFB69FFFB19FFBAE9FF5AD
            9FF5AD9FE7AA9FC4A49FCA4F00FFA558FFBB7FFFBD83FFB676FFAC65FF9D4AFF
            8728FF740EFF6601F86200FB6300E35900A54100DFA89FFFCAABFFD6B8FFD7BA
            FFD3B5FFCEAFFFC7A7FFBCA0FFB49FFFAF9FFBAE9FFCAE9FEDAB9FCAA59FC8D0
            D4EE5D00FF700AFF720CFF700AFF6C06FF6601EE5D00DE5700D15200CC5000CF
            5100B84800C8D0D4DDE2E4F4AD9FFFB39FFFB39FFFB39FFFB29FFFAF9FF4AD9F
            EAAA9FE3A99FE0A99FE1A99FD4A79FDDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbEditarClick
        end
        object sbAplicar: TSpeedButton
          Left = 407
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Aplicar'
          Enabled = False
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D4003A95
            00399200358700317E002F79002F79002F79002F79002F79002F79002F790029
            6AC8D0D4DDE2E49FA4C29FA3C19FA3BC9FA2B89FA1B69FA1B69FA1B69FA1B69F
            A1B69FA1B69FA1B69FA1B1DDE2E4004BC00058E10055D90052D1004EC7004BC0
            004BC0004BC0004BC0004BC0004BC0004DC50041A500296A9FA7D99FABEC9FAA
            E79FA9E39FA8DD9FA7D99FA7D99FA7D99FA7D99FA7D99FA7D99FA7DC9FA5CA9F
            A1B10057DE0268FF0062F8005EF0005CEB0058E10054D70054D70054D70054D7
            0054D70056DC004DC5002F799FAAEA9FAFFF9FAEFB9FADF59FACF29FABEC9FAA
            E69FAAE69FAAE69FAAE69FAAE69FAAE99FA7DC9FA1B6005DEE066CFF0167FF00
            60F6005DEE005AE60056DC0054D70052D10051CF0050CC0054D7004BC000307B
            9FADF49FB2FF9FAFFF9FADF99FADF49FABEF9FAAE99FAAE69FA9E39FA9E19FA9
            E09FAAE69FA7D99FA1B7005EF00F75FF086EFF0268FF0665EAFFFFFFFFFFFF06
            65EA0665EA0665EA0051CF0054D7004BC0002F799FADF59FB4FF9FB2FF9FAFFF
            9FAFF2FFFFFFFFFFFF9FAFF29FAFF29FAFF29FA9E19FAAE69FA7D99FA1B6005E
            F02686FF1579FF0665EAFFFFFFFFFFFFFFFFFFFFFFFF0665EA0665EA0053D400
            54D7004BC0002F799FADF5A0BCFF9FB6FF9FAFF2FFFFFFFFFFFFFFFFFFFFFFFF
            9FAFF29FAFF29FAAE49FAAE69FA7D99FA1B6005EF0469AFF1F81FF8EC4FFFFFF
            FF0665EA0665EAFFFFFFFFFFFF0665EA0057DE0056DC004CC200307B9FADF5A6
            C5FFA0BAFFBFDBFFFFFFFF9FAFF29FAFF2FFFFFFFFFFFF9FAFF29FAAEA9FAAE9
            9FA7DA9FA1B7005EF05CA7FF2988FF1277FF0A70FF0667F20667F20667F2FFFF
            FFFFFFFF005BE9005AE6004FCA0033829FADF5ACCBFFA1BCFF9FB6FF9FB3FF9F
            AFF79FAFF79FAFF7FFFFFFFFFFFF9FABF19FABEF9FA8DF9FA2BA005EF069AFFF
            328EFF187BFF005FF3005FF3005FF3005FF3005FF3FFFFFFFFFFFF005EF00054
            D7003A959FADF5B0CFFFA2BFFF9FB7FF9FADF79FADF79FADF79FADF79FADF7FF
            FFFFFFFFFF9FADF59FAAE69FA4C2005EF074B5FF3D95FF2484FF0166FF0166FF
            0166FF0166FF0166FF0166FFFFFFFF0064FF0059E30040A39FADF5B4D3FFA4C2
            FFA0BBFF9FAFFF9FAFFF9FAFFF9FAFFF9FAFFF9FAFFFFFFFFF9FAFFF9FABED9F
            A4C9005EF081BCFF50A0FF2B89FF2686FF1B7EFF1378FF1277FF0C72FF066CFF
            0369FF0268FF005DEE0044AF9FADF5BAD6FFA9C8FFA1BDFFA0BCFFA0B8FF9FB6
            FF9FB6FF9FB3FF9FB2FF9FB0FF9FAFFF9FADF49FA6CF005EF08AC1FF7FBBFF65
            ACFF56A4FF469AFF3590FF2686FF1378FF096FFF066CFF066CFF0064FF004BC0
            9FADF5BDD9FFB8D6FFAFCEFFAACAFFA6C5FFA3C0FFA0BCFF9FB6FF9FB2FF9FB2
            FF9FB2FF9FAFFF9FA7D9005EF067ADFF8AC1FF8FC4FF81BCFF72B4FF5AA6FF37
            91FF1E80FF0D73FF096FFF0A70FF0268FF0050CC9FADF5AFCEFFBDD9FFC0DBFF
            BAD6FFB3D2FFABCBFFA3C1FFA0B9FF9FB4FF9FB2FF9FB3FF9FAFFF9FA9E0C8D0
            D4056BFF197DFF1B7EFF197DFF1579FF0D73FF056BFF0166FF0060F6005EF000
            5FF30057DEC8D0D4DDE2E49FB1FFA0B8FFA0B8FFA0B8FF9FB6FF9FB4FF9FB1FF
            9FAFFF9FADF99FADF59FADF79FAAEADDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbAplicarClick
        end
        object sbCancelar: TSpeedButton
          Left = 463
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Cancelar'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D4003A95
            00399200358700317E002F79002F79002F79002F79002F79002F79002F790029
            6AC8D0D4DDE2E49FA4C29FA3C19FA3BC9FA2B89FA1B69FA1B69FA1B69FA1B69F
            A1B69FA1B69FA1B69FA1B1DDE2E4004BC00058E10055D90052D1004EC7004BC0
            004BC0004BC0004BC0004BC0004BC0004DC50041A500296A9FA7D99FABEC9FAA
            E79FA9E39FA8DD9FA7D99FA7D99FA7D99FA7D99FA7D99FA7D99FA7DC9FA5CA9F
            A1B10057DE0268FF0062F8005EF0005CEB0058E10054D70054D70054D70054D7
            0054D70056DC004DC5002F799FAAEA9FAFFF9FAEFB9FADF59FACF29FABEC9FAA
            E69FAAE69FAAE69FAAE69FAAE69FAAE99FA7DC9FA1B6005DEE066CFF0167FF00
            60F6005DEE005AE60056DC0054D70052D10051CF0050CC0054D7004BC000307B
            9FADF49FB2FF9FAFFF9FADF99FADF49FABEF9FAAE99FAAE69FA9E39FA9E19FA9
            E09FAAE69FA7D99FA1B7005EF00F75FF086EFF0268FFFFFFFFC1DEFC0665EA00
            58E188BAEFFFFFFF0051CF0054D7004BC0002F799FADF59FB4FF9FB2FF9FAFFF
            FFFFFFD9EAFD9FAFF29FABECBCD5F5FFFFFF9FA9E19FAAE69FA7D99FA1B6005E
            F02686FF1579FF086EFFC2E0FFFFFFFFC1DEFC88BDF8FFFFFFC1DCF80053D400
            54D7004BC0002F799FADF5A0BCFF9FB6FF9FB2FFDAEBFFFFFFFFD9EAFDBCD7FB
            FFFFFFD9E9FB9FAAE49FAAE69FA7D99FA1B6005EF0469AFF1F81FF0D73FF1176
            FFC2E0FFFFFFFFFFFFFFC1DEFC0665EA0057DE0056DC004CC200307B9FADF5A6
            C5FFA0BAFF9FB4FF9FB5FFDAEBFFFFFFFFFFFFFFD9EAFD9FAFF29FAAEA9FAAE9
            9FA7DA9FA1B7005EF05CA7FF2988FF1277FF0A70FF8EC4FFFFFFFFFFFFFFC1DE
            FE0667F2005BE9005AE6004FCA0033829FADF5ACCBFFA1BCFF9FB6FF9FB3FFBF
            DBFFFFFFFFFFFFFFD9EAFF9FAFF79FABF19FABEF9FA8DF9FA2BA005EF069AFFF
            328EFF187BFF93C7FFFFFFFFC4E1FFC4E1FFFFFFFFC1E0FF005FF3005EF00054
            D7003A959FADF5B0CFFFA2BFFF9FB7FFC2DDFFFFFFFFDBECFFDBECFFFFFFFFD9
            EBFF9FADF79FADF59FAAE69FA4C2005EF074B5FF3D95FF2484FFEEF6FFC9E3FF
            1579FF1377FFC4E1FFFFFFFF0166FF0064FF0059E30040A39FADF5B4D3FFA4C2
            FFA0BBFFF4F9FFDEEDFF9FB6FF9FB6FFDBECFFFFFFFF9FAFFF9FAFFF9FABED9F
            A4C9005EF081BCFF50A0FF2B89FF2686FF1B7EFF1378FF1277FF0C72FF066CFF
            0369FF0268FF005DEE0044AF9FADF5BAD6FFA9C8FFA1BDFFA0BCFFA0B8FF9FB6
            FF9FB6FF9FB3FF9FB2FF9FB0FF9FAFFF9FADF49FA6CF005EF08AC1FF7FBBFF65
            ACFF56A4FF469AFF3590FF2686FF1378FF096FFF066CFF066CFF0064FF004BC0
            9FADF5BDD9FFB8D6FFAFCEFFAACAFFA6C5FFA3C0FFA0BCFF9FB6FF9FB2FF9FB2
            FF9FB2FF9FAFFF9FA7D9005EF067ADFF8AC1FF8FC4FF81BCFF72B4FF5AA6FF37
            91FF1E80FF0D73FF096FFF0A70FF0268FF0050CC9FADF5AFCEFFBDD9FFC0DBFF
            BAD6FFB3D2FFABCBFFA3C1FFA0B9FF9FB4FF9FB2FF9FB3FF9FAFFF9FA9E0C8D0
            D4056BFF197DFF1B7EFF197DFF1579FF0D73FF056BFF0166FF0060F6005EF000
            5FF30057DEC8D0D4DDE2E49FB1FFA0B8FFA0B8FFA0B8FF9FB6FF9FB4FF9FB1FF
            9FAFFF9FADF99FADF59FADF79FAAEADDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbCancelarClick
        end
        object sbRefresh: TSpeedButton
          Left = 519
          Top = 9
          Width = 57
          Height = 25
          Hint = 'Recarregar'
          Glyph.Data = {
            CE040000424DCE0400000000000036000000280000001C0000000E0000000100
            1800000000009804000000000000000000000000000000000000C8D0D408397B
            08398408398408398408398C08398C08398408398408397B08397B0839730831
            6BC8D0D4DDE2E49FA3B79FA3BB9FA3BB9FA3BB9FA3BE9FA3BE9FA3BB9FA3BB9F
            A3B79FA3B79FA3B49FA2B1DDE2E408398C0852AD085ABD085ABD085ABD085ABD
            085ABD085ABD085ABD085ABD0852B50852AD08398C0031639FA3BE9FA9CE9FAB
            D79FABD79FABD79FABD79FABD79FABD79FABD79FABD79FA9D39FA9CE9FA3BE9F
            A2AE084A9C085ABD0863D60863D60863DE0863DE0863DE0863DE0863DE0863DE
            0863D60852B5084A9C0839739FA7C69FABD79FAEE59FAEE59FAEEA9FAEEA9FAE
            EA9FAEEA9FAEEA9FAEEA9FAEE59FA9D39FA7C69FA3B40852B50863D6086BEF08
            73FF0873FF0873FF0873FF0873FF0873FF0873FF086BEF085ABD0852AD08397B
            9FA9D39FAEE59FB1F59FB4FF9FB4FF9FB4FF9FB4FF9FB4FF9FB4FF9FB4FF9FB1
            F59FABD79FA9CE9FA3B7085ABD0863DE0873FF0873FF9FC9F7FFFFFFFFFFFFFF
            FFFF9FC9F70873FF086BEF085ACE0852B50839849FABD79FAEEA9FB4FF9FB4FF
            C7DEFAFFFFFFFFFFFFFFFFFFC7DEFA9FB4FF9FB1F59FABE19FA9D39FA3BB0863
            D60873FF0873FF9FC9F7FFFFFF9FC9F70873FF0873FFFFFFFF9FC9F7086BEF08
            5ACE085ABD08398C9FAEE59FB4FF9FB4FFC7DEFAFFFFFFC7DEFA9FB4FF9FB4FF
            FFFFFFC7DEFA9FB1F59FABE19FABD79FA3BE0863DE0873FF0873FFFFFFFF9FC9
            F70873FF0873FF0873FF0873FFFFFFFF086BEF085ABD085ABD084A9C9FAEEA9F
            B4FF9FB4FFFFFFFFC7DEFA9FB4FF9FB4FF9FB4FF9FB4FFFFFFFF9FB1F59FABD7
            9FABD79FA7C6086BEF0873FF0873FFFFFFFF9FC9F70873FF9FC9F70873FF0873
            FF0873FF086BEF085ABD085ABD084A9C9FB1F59FB4FF9FB4FFFFFFFFC7DEFA9F
            B4FFC7DEFA9FB4FF9FB4FF9FB4FF9FB1F59FABD79FABD79FA7C60873FF107BFF
            107BFFFFFFFFFFFFFF0873FFFFFFFFFFFFFF0873FF0873FF086BEF085ABD085A
            BD084A9C9FB4FF9FB7FF9FB7FFFFFFFFFFFFFF9FB4FFFFFFFFFFFFFF9FB4FF9F
            B4FF9FB1F59FABD79FABD79FA7C60873FF218CFF218CFF107BFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF0873FF086BEF085ABD085ABD084A9C9FB4FFA0BEFFA0BE
            FF9FB7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FB4FF9FB1F59FABD79FABD79F
            A7C6107BFF399CFF319CFF1884FF1884FF1884FFFFFFFFFFFFFF1884FF1884FF
            086BEF085ABD085ABD084A9C9FB7FFA3C6FFA2C6FF9FBBFF9FBBFF9FBBFFFFFF
            FFFFFFFF9FBBFF9FBBFF9FB1F59FABD79FABD79FA7C6218CFF52ADFF399CFF21
            8CFF1884FF1884FF9FC9F71884FF0873FF1884FF086BEF0863D6085ABD084A9C
            A0BEFFA9CEFFA3C6FFA0BEFF9FBBFF9FBBFFC7DEFA9FBBFF9FB4FF9FBBFF9FB1
            F59FAEE59FABD79FA7C6319CFF6BB5FF52ADFF399CFF319CFF218CFF1884FF18
            84FF107BFF087BFF0873FF086BEF085ABD083984A2C6FFB1D3FFA9CEFFA3C6FF
            A2C6FFA0BEFF9FBBFF9FBBFF9FB7FF9FB7FF9FB4FF9FB1F59FABD79FA3BBC8D0
            D4319CFF1884FF107BFF0873FF0873FF0873FF0873FF086BEF0863DE0863D608
            5ABD0852ADC8D0D4DDE2E4A2C6FF9FBBFF9FB7FF9FB4FF9FB4FF9FB4FF9FB4FF
            9FB1F59FAEEA9FAEE59FABD79FA9CEDDE2E4}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbRefreshClick
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = qryFamilia
    Left = 400
    Top = 112
  end
  object qryFamilia: TZTable
    Connection = DM.ADOConnection1
    TableName = 'ibi_cadastro_familia'
    Left = 392
    Top = 56
  end
end
