object FormLeituraFatura: TFormLeituraFatura
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Controle de Devolu'#231#245'es - Leitura de Cart'#245'es Devolvidos'
  ClientHeight = 507
  ClientWidth = 717
  Color = clHotLight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 689
    Height = 432
    Caption = 'Leituras FACs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object LabelNumCartao: TLabel
      Left = 440
      Top = 80
      Width = 92
      Height = 14
      Caption = 'Numero Cart'#227'o'
      FocusControl = edtCodigo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 13
      Top = 80
      Width = 110
      Height = 14
      Caption = 'Motivo Devolu'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelDataDevolucao: TLabel
      Left = 13
      Top = 23
      Width = 96
      Height = 14
      Caption = 'Data Devolu'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblProduto: TLabel
      Left = 153
      Top = 23
      Width = 51
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigo: TEdit
      Left = 440
      Top = 96
      Width = 235
      Height = 31
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 19
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtCodigoKeyPress
    end
    object StringGridFaturasLidas: TStringGrid
      Left = 13
      Top = 129
      Width = 412
      Height = 285
      TabStop = False
      Color = clSilver
      Ctl3D = False
      DefaultRowHeight = 22
      FixedColor = clNavy
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 4
      OnDrawCell = StringGridFaturasLidasDrawCell
      OnKeyUp = StringGridFaturasLidasKeyUp
      ColWidths = (
        30
        138
        60
        163
        0)
    end
    object lcCD_MOTIVO: TDBLookupComboBox
      Left = 13
      Top = 99
      Width = 412
      Height = 24
      Hint = 'Selecione o motivo da devolu'#231#227'o'
      DropDownRows = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      KeyField = 'cd_motivo'
      ListField = 'descricao'
      ListSource = DM.dsMotivos
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnKeyPress = lcCD_MOTIVOKeyPress
    end
    object StringGridResumoLeituras: TStringGrid
      Left = 440
      Top = 132
      Width = 237
      Height = 285
      TabStop = False
      Color = clSilver
      ColCount = 2
      Ctl3D = False
      DefaultRowHeight = 22
      FixedColor = clNavy
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 5
      OnDrawCell = StringGridResumoLeiturasDrawCell
      ColWidths = (
        195
        39)
    end
    object cbDT_DEVOLUCAO: TDateTimePicker
      Left = 13
      Top = 39
      Width = 134
      Height = 27
      Hint = 'Data da retirada da caixa de objetos da ag'#234'ncia'
      Date = 42697.765975347210000000
      Time = 42697.765975347210000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyPress = cbDT_DEVOLUCAOKeyPress
    end
    object lcCD_PRODUTO: TDBLookupComboBox
      Left = 153
      Top = 39
      Width = 370
      Height = 27
      Hint = 'Selecione o C'#243'digo do Produto'
      DropDownRows = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      KeyField = 'cd_produto'
      ListField = 'descricao'
      ListSource = DM.dsProdutos
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnKeyPress = lcCD_PRODUTOKeyPress
    end
    object PanelProgress: TPanel
      AlignWithMargins = True
      Left = 230
      Top = 271
      Width = 315
      Height = 68
      Align = alCustom
      Anchors = []
      BevelInner = bvRaised
      BevelOuter = bvNone
      BorderWidth = 1
      BorderStyle = bsSingle
      Caption = 'Executando a opera'#231#227'o. Aguarde...'
      UseDockManager = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      VerticalAlignment = taAlignTop
      Visible = False
      ExplicitLeft = 227
      ExplicitTop = 268
      object PanelProgressBar: TProgressBar
        AlignWithMargins = True
        Left = 24
        Top = 26
        Width = 265
        Height = 23
        BorderWidth = 2
        Smooth = True
        TabOrder = 0
      end
    end
  end
  object btnFechar: TBitBtn
    Left = 553
    Top = 435
    Width = 126
    Height = 41
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnFecharClick
    Glyph.Data = {
      360C0000424D360C000000000000360400002800000040000000200000000100
      08000000000000080000120B0000120B0000000100000001000000000000CCCC
      CC00666666000000A5008383830000085A000065C60052525200003EA5006767
      C300FAFAFC00ACACAC00333333003A3AB400001EAD00516AAF008484DF00EEEE
      EE003A3A3A007B7B7B0007287E000000B5008787C30090A9DD00003ACF003064
      C8002626A600DFDFDF000011B20000187F006E73DC00A4A4A4004A4A4A005151
      B0001D40A7005A5A5A005970C900000FA400ADADC5006B6B6B0000009900BABA
      DF00292929002222A400005BCC006A6AD400004CAF0045548F0023239A003237
      C6000071D800000093009494E100A9A9CD00737373000000BD00CBCBE000004E
      CA0000008C000020C7008086BE004B63A4006666D600BEBEC5001616B300E5E5
      E5009797C60042424200B7B7DD004E86BE001E63D80019429B007192CA004848
      C3001A1AA200BDBDBD00687EC700063CC500274BD300F7F7F7000047C3002626
      C3000000C60095959500767CA700006DD6000039BD00002392000000AD000018
      90004160BA003651AC000E0EC600797BDF00ABABE5007A83B0006666B80084A7
      D300BDBDEF00A0ADD2001846B200345AC8007A7AD400CDD4E6000051AA000032
      B3009C9CD400E4E4F3000036B500002BCB000764D9005F98D8005251C8004949
      A9000012C3008A8CE2004572AA000F53D7000080DD000019A3004C6AD2002F2F
      B300577CE100A3A3E20016169300B3B3B300D7D7D700BFC4D70026269800DEDD
      E7004861BE008A9BC800022E9200FFFFFF00B5B5ED0000268B008C99BD002121
      21000051D4006883E100005BDA007598C100B2B2D3000005BE00D1D7F0000000
      CC00002CB3000041CF00004BBB000707B100000AB6008C8C8C00B7B7CD004454
      D5007C7DBF001427CB0096A4C80000079F001313A8001B38C500121293007381
      D800C6CEE9007272D9004242B0004040C8002828B40006068C00518ECE001442
      A4003A6CD1009FBEE700007ADF005672D3000066CC00C4C4DF00EEEEF7002D52
      AB00485B9A008B90E4007884E0000404A7009696CC004A4AD2001B1BBC005C5C
      B7009C9CE6006E7EDB00005AB900C6C6F0007474C200426ACD004950BE00868C
      E1000052C5000013BF005A5AC3002020B400006ADF006161C3005E6BD4000052
      DE003333CC00A0A0A000D4D4E200003399000606C700ADADEB00D7DDEF00D0D0
      EC000025820006279D003147B20030309E00C4C4C4009899E6000044BE003B3D
      CB000062DD000046D3000027AE009CB9E000005AD9000547B3008989BC000043
      C500A7B1D700008CE6005066C600072F89000023BE00111C9B003568D8000800
      B500CFCFD700004AD5000019C4000031BF000A0ABE000019AC00E3E7F500A7A7
      D500BDC5DC000013AF002828AE00002CC700B5B5E6001C1CAB000043B1000033
      CC007979C60005059A00CBCBE500007CE9007A89E2009494D600858585858585
      85858585854F4F11411B1B41114F4F0A85858585858585858585858585858585
      85858585854F4F11411B1B41114F4F0A85858585858585858585858585858585
      85850A4F413FE0B90D79790D219A98414F0A8585858585858585858585858585
      85850A4F414B53362307070727974B414F0A8585858585858585858585858585
      854F4126495C5252373737373752CED942410A85858585858585858585858585
      854F417D27120C0C0C0C0C0C0C0C0C231F410A85858585858585858585858585
      4FEAC49191371515030303030315379191A57F0A858585858585858585858585
      4F01360C0C0C2A2A2A2A2A2A2A2A0C0C0C02D60A85858585858585858585854F
      98519137150303039D9D9D9D0303035837915C6A0A858585858585858585854F
      4B200C0C2A2A2A2A2A2A2A2A2A2A2A2A2A0C120B0A8585858585858585850A98
      B8521558030325EFDCDC6C6C6CDC250303155252B68585858585858585850A4B
      430C2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A0C1F858585858585858585EAB8
      37155803250E926C6CD8D8C2C2C2C269B5B55837378E8585858585858585EA43
      0C2A2A2A2A2A2A2A2A0C0C0C0C0C0C2A2A2A2A2A0C4B8585858585858511A437
      155858F30EDC565050C22C2C2C2CC2C2D8F3031515B88185858585858511230C
      2A2A2A2A2A2A0C0C0C0C0C0C0C0C0C0C0C2A2A2A2A431B858585858585421515
      1558F325481769C2AEAE555555C26FAB94D81C585815098585858585851F2A2A
      2A2A2A2A07232A0C0C0C0C0C0C0C20232A2A2A2A2A2A13858585858511A61515
      15F3774C858561F855ACACACBCA88585DDDF5658585895CC8585858511202A2A
      2A2A2A201313072A0C0C0C0C0C201313232A2A2A2A2A0C7E8585858535585858
      96EF5B85858585612E76E3BCA885858585486CE6585858FA858585857D2A2A2A
      2A2A1213131313072A0C120C4313131313202A2A2A2A2A9785858585B9585858
      ECEDD383858585856168684585858585F2A95018961515790A858585362A2A2A
      2A2A2A0713131313072A2A4313131313022A2A0C2A2A2A200A85854FF458588F
      F593E15783858585858D7485858585F2CD508A93C31558B58185854F202A2A2A
      0C0C0C890713131313201213131313022A0C0C0C0C2A2A2A1B858581B5581572
      18DBDE2C87888585858585858585F2E5948CEB18EC1515034485851B0C2A2A0C
      0C0C0C0C8907131313131313131302890C0C0C0C0C2A2A2A4B858538030315EC
      18EBDEC6AED2888585858585857F1494DA8ADBF9EC1515036A8585012A2A2A0C
      0C0C0C0C0C890713131313131302892A0C0C0C0C0C2A2A2A0B8585AF0303153B
      93EB8CC6FD06052685858585810508C6DEDB186DEC155803FF8585012A2A2A0C
      0C0C0C0C120C89231313131327892A120C0C0C0C0C2A2A2A1F858538280315EC
      93EB8CC6C6CD2F11858585854F541D39EB186D3B721558286A8585EA2A2A2A0C
      0C0C0C0C0C2A0C36131313131343890C0C0C0C0C0C2A2A2A0B858581FB0315EC
      93EBDE6ECDB20A858585858585855F1D4DF93B728F1503284485851B2A2A2A0C
      0C0C0C0C2A12131313131313131320890C0C0C0C0C2A2A2A4B85854F2B28588F
      F97546083D0A858585F29C858585855F599F9B8F8F1503289085854F432A2A2A
      0C12122A121313131302071313131320890C0C0C0C2A2A2A1B8585852128038F
      4EE8640F0A85858567478463858585853CE73131EE58284A0A85858502892A2A
      12430C1213131313272A2A2313131313202A12120C2A2A120A8585856A3303E9
      99650F8585858590B119AA22E2858585859AF4B7B8033360858585850B892A2A
      43434313131313270C12430C2313131313200C430C2A2A1385858585B07C2858
      D97882A28585D05ABF7A7A78D44485856BB949B715283AFC85858585110C2A2A
      43204327131327124320202012021313364343432A2A89EA8585858585163A03
      401EADE490F024AD8B8B8B8BC8C0AFB0C770A33103337185858585858553892A
      0C072043273620200707070720430236204307122A89028585858585854F8033
      03B7C1BBA1A1BBFEB4B4B4B45DA3A3662D103EB528A7D08585858585854F4389
      2A4323070707070707070707070707070707072A2A2A1B85858585858585FC3A
      3AB5A3D7C1C1B3B37373737373737310347340283AB68585858585858585EA89
      892A072323232323232323232323232323230C2A891F858585858585858585F1
      3A3A9E66CFBABABABABABABABABABACF34C5283ABE858585858585858585857D
      89892A07022323232323232323232302230C2A89048585858585858585858585
      F1A7339DC7CF6286CFCFCFCF866262669E33339A858585858585858585858585
      7D2A892A2002020202020202020202072A2A8997858585858585858585858585
      85FCD53A3AF72D7B62BDBDBD5E6679283A7CF185858585858585858585858585
      85EA2089890C20230227272702071289890C7D85858585858585858585858585
      858585B6303A3A289EF4F4F79D3333A0BEB08585858585858585858585858585
      858585CB438989890C0C0C0C2A2A890C04118585858585858585858585858585
      858585858529BEA41A4A4A2B0D60F1B085858585858585858585858585858585
      858585850AD604234312124307137D1185858585858585858585858585858585
      8585858585858585B0D1D16B8585858585858585858585858585858585858585
      8585858585858585117E7E418585858585858585858585858585858585858585
      8585858585858585858585858585858585858585858585858585858585858585
      8585858585858585858585858585858585858585858585858585}
    NumGlyphs = 2
  end
  object StatusBarMessages: TStatusBar
    Left = 0
    Top = 481
    Width = 717
    Height = 26
    Panels = <
      item
        Alignment = taRightJustify
        Text = 'Itens lidos:'
        Width = 80
      end
      item
        Text = '0'
        Width = 30
      end
      item
        Alignment = taRightJustify
        Text = #218'ltimo Objeto Lido:'
        Width = 140
      end
      item
        Width = 140
      end
      item
        Style = psOwnerDraw
        Width = 295
      end>
    SimpleText = 'DFASD AsdDASF DASF'
  end
  object BitBtnLimparLeituras: TBitBtn
    Left = 189
    Top = 435
    Width = 149
    Height = 41
    Caption = '&Limpar Leituras'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtnLimparLeiturasClick
    Glyph.Data = {
      360C0000424D360C000000000000360400002800000040000000200000000100
      08000000000000080000120B0000120B0000000100000001000000000000DBB3
      930096918E007171710051494300FFFFDF00A4A4A5000000B400DCE2E700CF94
      640039393900D4CDC80086868600E9D7C70061616100A39E9C00C4B8AE007575
      CC00352C25005A5AC8009494E000D0B097007D777300DCC7B600F3F3EB00D1A4
      820041414100B6B6B600D5BBA600595959002323BE0020202000E2E2D2008282
      82009E9A9700CE8C5700D1BBA900EBEBEB00DCBDA600CCCCD2008A858100B1AD
      AB0070696500ADAAA700DBDBDB00F5E1D0008A8A8A0075757500333333005151
      51001212BD001C1C1C00413933004D4941009292DB00C2C2D80028231E00BBBB
      BB00E5D2C000D7D7D700BBBBDC00F7F7F300CF9F7600D1AE9300E8E4E100382F
      29005D5D5D00FFFFFF008888D000BEBED700938F8B00E1D6CC00C7C7C700F0F0
      EA009E9E9E00DCC3AF0048403B00E4E4E70096969600D8C3B100A1A1A100EFE7
      E100564E4900A5A5E100726D6800D4D2D100DDCABA0079797900241B1500CCCC
      CC006F6FC600D9D9DA00C9A5890028282800DEDEDF00C2C2C200DED1C5007878
      D900DBB99D00CD996F00D3B8A2005A5551003D3D3D006C6560002A2AC1003C35
      2F005F5C5900FBFBE100D4C1B200453C3600FAFAF600181818007D7D7D00CFCF
      D800EBF1F500DDD8D3004D4D4D00605953002D2D2D008F8A8600A69E9800D3D0
      CD00FFFFF500EAE3DD0045454500F2F4F60024242400E3C6AE003D342E00D8DE
      E300E0CAB600E2E7EB00D6C4B600E6EBF000D7AE8C00ADADAD00C7C9CB008781
      7E00D7B39600B3B0AE000808BC00E0E6EB00C2C2BE00D1D1EB0033333300D7AC
      88002A201A00302620005555550066666600F1F0EE006D6D6D00B3A59800F3F3
      F3008181CB00484848005A524D00696969009D9DE100F0D6C000F4F7FB004E46
      4000655F5900AAA6A300D29A6D00E9DFD800E4E4E400C4C4E7006B6BD600D0A1
      7B00D6A883008E8EDD001C1CB900D2BDAD00E3DFDB003A322D005D5A59008282
      DC00453E3800EDDCCD00D8B29300DDCDC100E1C2A700E3D2C600DEBCA100DAC4
      B3001414140092929200DBB79B00ACA8A6009B9BDF008E8E8E00BDBDBD00EEEE
      EF0045413900DFE4EA00D0CECD000000B800EBE4DE00D8D8EE00FFFFEB007F7F
      CF003434C500E5DBD200C7C7D6009B989500CCCCCC00ACACE100CEAA92008E8A
      890099999900E8E8E70050494500E1E0DF00D6B69C00ECD3BC00EBECED00D3D4
      D500E7CEB800D1C6BC0032292300D7D7D100E3E3EF00B1B1B100E3E3D900C6C6
      C200FBFBFB00D7C6B7009F9FA100E4C8B1008A878600EFEFF400B0B2B400DEDC
      DC00EEECEC00433A3500D2986900A4A19E00F0DBC900493D3900D29D7100E8E8
      DB00CE9A6F00F7F7F700D7BEAA00DFBFA600DFC5B100F1F1F000B2AEAE00E7E6
      E400DECEC00069625D001A1AC100655E5A00CF9F78008A827D00434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      E29925A62CD9C4485FC01B1B1B48C0D22EBF4AC4F3F343434343434343434343
      E29925A62CD9C4485FC01B1B1B48C0BB57574EC4F3F34343434343434343C15E
      5E5E2C2C3B3B555555C4C4C4C45F4A06DFDF870648E9D525434343434343D82C
      2C2C2C3B3B3B55C4C4C4C4C4C4395703030303571B2C5ED343434343431B4C12
      AFAF3434B24CA1D49C9C757575E448DDD9D9D9DDE8039CA20F4343434387301F
      7E5D5D5D767630300A0A66666695700C0CE6E6E603740A7C4E43434343EB2A48
      C05F485959D93B2C5E5E25874A7927CCE05BF145F1394A02AF43434343301A70
      70707021210C0C2EBFBF4E97950C0C0CBFBFBF21BB2F0E421F43434343EB46E2
      40A57B7B7B5151515118AE4E4827CAFC7105C98C44E01BD16943434343304250
      BBBBBBBBBBBB4E4E4ED2BF0E700C317C0CD29D6697BF2F1D7E434343436D777D
      B5868A8ABCBCB8F5E59F9850209AC5C56811C5C5325B552F80434343430A1D4A
      0C032F2F2F575770212E9D9D2E9D0A0A74950A0A1A2E0C741F434343436D77A0
      60B46262B8F5F5E53AEE78E8C4205A07070707AC37F13B0C41434343430A1D4A
      0C2F5757575770210CBF95030C2E0E0A0A0A0A7C21BB2E941F434343436D7799
      A6A6D3D3EA96963DE2E287485E5E6B131E1E1E3CC84DF7D212434343430A1DD2
      BBBB4E4E4ED2D24A4A509721BFBFD2429B9B9B214ABBD20E33434343436D7799
      A6A6D32525F7F7F3E2431BC4D349CF61B1B1AB14DE3DE2CD12434343430A1DD2
      BBBBBB4E4ED2D24A4A062F0C4E4E70970303032F4E4A500E33434343436D777D
      6086BCBCBCB87FDA9F2D1088183CA8B1BEA7ABAB9EF7E246AF434343430A1D4A
      0C032F5757572121E6BB2F21D20C959757E62F2F57D2501D1F434343436D777D
      56A9AAAA9191BCB6E5D7821BD8D853BEC17A8F53C7E2D3CD69434343430A1D4A
      219D970303035770210C212F4E4E7057D250BF57BB504E0E7E434343436D77C1
      7360474747CBA57B51511879D93DF7F73D996EE77AC13B8B41434343430A1DD2
      2E0C0C2E2E2EBFBF4E4ED20C0CD2D2D24A4A4AD250D22E031F434343436D28D3
      5E8D8D85858572727D7DA0A0D92CF3F3F3F3F343E7D9F72941434343430A944E
      BFBBBB4E4E4ED2D24A4A4A4AE6E64A4A4A4A4A06D20CD2031F434343436D28D3
      DB3FD6D6D6D6264B82823A0DB3E30B4DE7E7D87384B7F3BD41434343430A944E
      21032F2F2F2F577021210C2E2E2121BBD2D2D22E70E64A971F43434343B2894D
      2409F2F2F23E3EAA8601BCB8B6E5E5F44F4F4FF5F5F6992B41434343430A31BB
      570E959595959D97032F2F5770217070707070707070D2971F43434343B289A6
      DBD6641CF4F4F4F44F175656FAFAB7B7B70D0D0DB7B7992B41434343430A94BB
      702F2F57575757577070210C0C0C0C0C0C2E2E2E0C0CD2971F434343436D7725
      5E838D8D8D8D8D8D818108C3C3C3C3C3C3C385727285992941434343430A1D4E
      BF4EBBBBBBBBBBBBBFBFBBBBBBBBBBBBBBBB4ED2D2D2D2971F434343436D77F7
      474B171717B9B917B9ADAD6C6C6CE3E3E3E3E3B7B747F32941434343430A1DD2
      E6702121212121217070707070707070707070E6E6E64A031F434343436D77A0
      4B230909ECA4A4A4A4A4A463633E3EA9A9A9A91991B8E28B41434343430A1D4A
      70420E0E9595959595959595959D9D9D9D9D9D9D03574A031F434343436D77A0
      FAAA868686B401010101BC8AD05CD03F3F1515151582438B41434343430A1D4A
      0C97030303032F2F2F2F2F2F9797030303030303032106031F4343434334CD43
      4343434343434343434343434325D9D9D9D9D9D9D9D97DC0AF43434343300E06
      500606060606060606060606064E0C0C0CE6E6E6E6E64A571F43434343040421
      707021210C0C0CE6E6E6E6E6BFBF7095421D6A6A6A6A6A656D43434343667631
      313131319494941D1D1D1D1D1D1D311A660A0A0A0A0A0A0A5D434343439C9358
      585892929393DC1241AFAF3434B2A1D4D44158925892589341434343437C6FBA
      BABABABA6F3333331F1F1F7E7E7E7676761FBABABABABA6F1F43434343A1DCDC
      1212AFAFAF3434B24C4CA1040452526565A2A1933038663812434343430A3333
      331F1F1F1F7E5D5D5D767676303030300A66766F1F6F5D6F334343434389044C
      A10404525265657575FDFDFB67672A2A545416FB6AA16A5267434343432F3076
      76763030300A0A0A0A66661A1A1A7C7C7C7C741A0A760A309443434343F3CD89
      774602CD0F0FA32B298B8B8B8B8B2BA3A30F2222462816CD7D43434343F35731
      1D42420E959D9D970303030303030397979D9595421D74579943434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343434343434343
      4343434343434343434343434343434343434343434343434343}
    NumGlyphs = 2
  end
end