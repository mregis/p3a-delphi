object frmRelAr: TfrmRelAr
  Left = 342
  Top = 264
  BorderStyle = bsDialog
  Caption = 'Relatorios AR'
  ClientHeight = 461
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 14
    Width = 145
    Height = 16
    Caption = 'Data de Devolu'#231#227'o :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sbRel: TSpeedButton
    Left = 13
    Top = 44
    Width = 120
    Height = 51
    Caption = 'Gerar Excel'
    Glyph.Data = {
      4C050000424D4C05000000000000C20100002800000020000000200000000100
      0800010000008A030000120B0000120B00006300000063000000000000000368
      03000E5F1400091E18001C771D000C271E00203A260012342800194C29002541
      2C00096C2F00194432000E6B32003187340011733600204E38001B6B39001979
      3B00217E3F002B6541002C8746003F93460039724B004A964C00348C4E00395E
      5000489B530038975400407A5600425E5800568259003E9E590054A459004680
      5C00569A5D0044A35E004A6A5F004C876100609963005BAA640050756500548E
      660063AC680057966A0067B06E005E9B71006CB6740062B2750065A076006BA6
      7B0072BB7B006B977D0070AA800072BA830075AF85007BC1850075A0860081AA
      8D0081BC900088C792008AB7950094C79C009DD0A700A8C2A800AAD6B200BADE
      C000C4E5CA00CDDACD00D2E4D200CCE9D200D5E5D500D8E7D800D9E8D900DAE9
      DA00DCEADB00DEEBDE00DFECDF00E0EEE000E3EBE300E2EEE300E4EFE400E6F0
      E600E8F1E800EAF2E900EBF3EB00EDF5ED00EFF6EF00F1F7F100F3F8F300F5F9
      F500F6FAF500F6FAF600F8FAF800F9FBFA00FAFDFA00FBFEFB00FDFEFD00FEFF
      FE00FFFFFF0000020202011C060F060B0607050504030000000400001C270423
      00161F1F1F1B1B1B181814141412121211110E0E0E0C0A030000000500001C27
      330007280724091D010C0103000000170000212F33525251504F4F4D4C4B4A4A
      4948474746464600044400031D0E03000000001E0000212F3353525251504F4F
      4D4C4B4A4A494847474646464444441D0E050000001E0000212F335453525251
      504F4F4D4C4B4A4A4948474746464644441D0E050000001E0000253533555453
      525251504F4F4D4C4B4A4A49484747464646441D110500000014000025353355
      555453525251504F4F4D4C40260906060004461D110500000007000025373856
      17000909000E08020D0D0E1013131906461D12050000001E0000293A3857170E
      0E1010131319191901043B2E141412120147461D12070000001E0000293B3858
      49172E32322E2C272001153E2E15181414013D47471D12070000001E0000293D
      38585849172E32322A2001153E2C1A1A151801083F48472414070000001E0000
      2B3D3859585849172E2C2001153E2E20201A1A01141202494824140700000010
      00002B3E395A595858491720011540320420000A01161E291E4A492414070000
      001E00002D3E395B5A595858490415403727272020163F4F4D4C4B4A4A241807
      0000001E00002D40395C5B5A59583D17413B2A2A27201E01434F4F4D4C4B4A24
      180B0000001E00002D40395D5C5B5A3D1A413D2E2C2A271E221E01434F4F4D4C
      4B241B0B0000001E00003040395E5D5C3D20423D32322E2A1E2C2E201E01434F
      4F4D4C281B0B0000001E00003041395E5E3D27423B3737322C1E2C32322E201E
      01434F4F4D281B0B0000001E000031413C5F3D2C423E3B373732263F262E3232
      2E201E01434F4F281F0B0000001E000031413C602E423E3B3B3B352647584326
      2E32322E201E01504F281F0B0000001E000031423C612E2E2C2A2A26264E5958
      5843262626291E1E1E5150281F0F0000001E000034423C6261605F5E5E5D5C5B
      5A59585857565555545352525128230F0000001E000034423C626261605F5E5E
      5D5C5B5A595858575655555453525228230F0000001E000034453C6262626160
      5F5E5E5D5C5B5A5958585756555554535228230F00000005000036453900073C
      0539063805330123010F0000001E0000364545454242424141414040403E3E3D
      3D3B3A3735352F2F2F27270F0000001E00003636363434343131313030302D2D
      2D2B2929292525252121211C1C1C0001}
    OnClick = sbRelClick
  end
  object SBtRel: TSpeedButton
    Left = 135
    Top = 43
    Width = 120
    Height = 51
    Caption = '&Relatorio '
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6C6A6AAAA7A7A19F9F6C6A6A6C
      6A6A6C6A6AE5E3E36C6A6A6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FFFF00FF
      6C6A6ADAD9D9A19F9FA19F9FA19F9F3736363535356C6D6DBFBFBFE1E2E2B7B6
      B66C6A6A6C6A6A6C6A6AFF00FF6C6A6AD4D3D3CACACA8E8C8C8E8C8C8E8C8C3C
      3B3B0A090A0707070B0B0B0707077A7A7ABBBBBB6C6A6AFF00FF6C6A6ACACACA
      CACACA8E8C8CD7D4D4CECBCBBFBCBCB1AFAFA3A0A08886865E5B5C0707070909
      090808086C6A6A7673736C6A6ACACACA8E8C8CEFEEEEFFFEFEFBFAFAE3E0E1DE
      DEDEDEDDDDCFCECEBDBCBCADABAB8B89895856567A78787573736C6A6A8E8C8C
      FFFFFFFEFCFCFAFAFAD5D4D5989193A09899B2ABACC4C0C1D7D7D7D8D8D8C7C6
      C6B7B6B6918F8F6C6969FF00FF6C6A6A6C6A6AEDEBEBB1A6A77A6F728A838896
      92959690919D97989A93959E9899BBBABAD1D1D1C2C2C26C6A6AFF00FFFF00FF
      FF00FF6C6A6ABB897FA7876D8B6F647D67606F62657973798F8B8EA9A3A4CBCA
      CAC1C1C16C6A6AFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFE3B4FFD39FE9
      B281C99973BA916CBD8281807D7E6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFBD8281FFE0B8FFD3A7FFD09DFFCE90FFC688BD8281FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC08683FFE7CFFFE0C0FFD9B2FF
      D3A5FFD099BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFBD8281FEEBD8FFE6CCFFDEBDFFD8B1FED3A4BD8281FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFFFF2FFFFF2FFEBD8FFE5CAFF
      E1BDF3C7A7BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      BD8281BD8281BD8281FBEFE2FBE3CFFBDDC2BD8281FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281BD8281BD
      8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    OnClick = SBtRelClick
  end
  object pMSG: TPanel
    Left = 0
    Top = 417
    Width = 747
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object cbDT_Devolucao: TDateTimePicker
    Left = 166
    Top = 12
    Width = 129
    Height = 21
    Date = 36526.601912013890000000
    Time = 36526.601912013890000000
    TabOrder = 1
    OnChange = BtnImprimeClick
  end
  object BtnImprime: TBitBtn
    Left = 304
    Top = 8
    Width = 80
    Height = 25
    Caption = 'Imprime'
    TabOrder = 2
    OnClick = BtnImprimeClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6C6A6AAAA7A7A19F9F6C6A6A6C
      6A6A6C6A6AE5E3E36C6A6A6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FFFF00FF
      6C6A6ADAD9D9A19F9FA19F9FA19F9F3736363535356C6D6DBFBFBFE1E2E2B7B6
      B66C6A6A6C6A6A6C6A6AFF00FF6C6A6AD4D3D3CACACA8E8C8C8E8C8C8E8C8C3C
      3B3B0A090A0707070B0B0B0707077A7A7ABBBBBB6C6A6AFF00FF6C6A6ACACACA
      CACACA8E8C8CD7D4D4CECBCBBFBCBCB1AFAFA3A0A08886865E5B5C0707070909
      090808086C6A6A7673736C6A6ACACACA8E8C8CEFEEEEFFFEFEFBFAFAE3E0E1DE
      DEDEDEDDDDCFCECEBDBCBCADABAB8B89895856567A78787573736C6A6A8E8C8C
      FFFFFFFEFCFCFAFAFAD5D4D5989193A09899B2ABACC4C0C1D7D7D7D8D8D8C7C6
      C6B7B6B6918F8F6C6969FF00FF6C6A6A6C6A6AEDEBEBB1A6A77A6F728A838896
      92959690919D97989A93959E9899BBBABAD1D1D1C2C2C26C6A6AFF00FFFF00FF
      FF00FF6C6A6ABB897FA7876D8B6F647D67606F62657973798F8B8EA9A3A4CBCA
      CAC1C1C16C6A6AFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFE3B4FFD39FE9
      B281C99973BA916CBD8281807D7E6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFBD8281FFE0B8FFD3A7FFD09DFFCE90FFC688BD8281FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC08683FFE7CFFFE0C0FFD9B2FF
      D3A5FFD099BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFBD8281FEEBD8FFE6CCFFDEBDFFD8B1FED3A4BD8281FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFFFF2FFFFF2FFEBD8FFE5CAFF
      E1BDF3C7A7BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      BD8281BD8281BD8281FBEFE2FBE3CFFBDDC2BD8281FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281BD8281BD
      8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object BtnSair: TBitBtn
    Left = 258
    Top = 44
    Width = 130
    Height = 49
    Caption = 'Sair'
    TabOrder = 3
    OnClick = BtnSairClick
    Glyph.Data = {
      B60D0000424DB60D000000000000360000002800000030000000180000000100
      180000000000800D0000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF
      FFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
      CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8C6363424242424242FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFE8E0E0DADADA
      DADADAFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FF8C636342424242
      4242B55A00B55A004242428C63638C63638C63638C63638C63638C63638C6363
      8C63638C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFE8E0E0DADADADADADAF1DECCF1DECCDADADAE8E0E0E8E0E0E8E0E0E8E0E0E8
      E0E0E8E0E0E8E0E0E8E0E0E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      FF00FF8C6363424242B55A00B55A00A55208B55A00C65A0042424210AD8410AD
      8410AD8410AD8410AD8410AD8410AD8410AD848C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFFFCCFFE8E0E0DADADAF1DECCF1DECCEDDDCEF1DECCF4DECC
      DADADAD0EFE7D0EFE7D0EFE7D0EFE7D0EFE7D0EFE7D0EFE7D0EFE7E8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363B55A00B55A00B55A00C65A00C6
      5A00C65A00C65A0042424210AD8410AD8410AD8410AD8410AD8418A57B18A57B
      18A57B8C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F1DECCF1DE
      CCF1DECCF4DECCF4DECCF4DECCF4DECCDADADAD0EFE7D0EFE7D0EFE7D0EFE7D0
      EFE7D1EDE5D1EDE5D1EDE5E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      8C6363C65A00C65A00C65A00C65A00C65A00CE6300CE630042424210AD8418A5
      7B18A57B18A57B189C7B189C73219473398C6B8C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFE8E0E0F4DECCF4DECCF4DECCF4DECCF4DECCF6E0CCF6E0CC
      DADADAD0EFE7D1EDE5D1EDE5D1EDE5D1ECE5D1ECE3D3EAE3D8E8E2E8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363C65A00CE6300CE6300CE6300CE
      6300CE6300CE630042424229846321947321947321947321946B218C6B298C6B
      42846B8C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F4DECCF6E0
      CCF6E0CCF6E0CCF6E0CCF6E0CCF6E0CCDADADAD5E7E0D3EAE3D3EAE3D3EAE3D3
      EAE2D3E8E2D5E8E2DAE7E2E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      8C6363CE6300CE6300CE6300CE6B00CE6B00CE6B00CE630042424229735A218C
      6B298C6B298C63298C6B298463298463298C6B8C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFE8E0E0F6E0CCF6E0CCF6E0CCF6E2CCF6E2CCF6E2CCF6E0CC
      DADADAD5E3DED3E8E2D5E8E2D5E8E0D5E8E2D5E7E0D5E7E0D5E8E2E8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363CE6300CE6B00CE6B00CE6B00CE
      6B00CE6B00D67300424242298C6B29846329845A317B5A317B52317B5A39845A
      427B638C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F6E0CCF6E2
      CCF6E2CCF6E2CCF6E2CCF6E2CCF7E3CCDADADAD5E8E2D5E7E0D5E7DED6E5DED6
      E5DDD6E5DED8E7DEDAE5E0E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      8C6363CE6B00CE6B00CE6B00D67300D67300FFBD6BD67300424242316B4A397B
      52397B5231734A397B524A7B5A5A6B525A6B528C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFE8E0E0F6E2CCF6E2CCF6E2CCF7E3CCF7E3CCFFF2E2F7E3CC
      DADADAD6E2DBD8E5DDD8E5DDD6E3DBD8E5DDDBE5DEDEE2DDDEE2DDE8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363D67300D67300D67300D67300FF
      D6A5FFE7C6FFBD6B4242425A6B525A6B5231734A637B52637B5294946BB59C73
      F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F7E3CCF7E3
      CCF7E3CCF7E3CCFFF7EDFFFBF4FFF2E2DADADADEE2DDDEE2DDD6E3DBE0E5DDE0
      E5DDEAEAE2F1ECE3FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      8C6363D67300D67300D67300D67300D67300FFD6A5D67300424242F7B584F7B5
      84F7B584F7B584F7B584F7B584F7B584F7B5848C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFE8E0E0F7E3CCF7E3CCF7E3CCF7E3CCF7E3CCFFF7EDF7E3CC
      DADADAFEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7E8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363D67300D67300DE7B00DE7B00DE
      7B00DE7B00DE7B00424242F7B584F7B584F7B584F7B584F7B584F7B584F7B584
      F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F7E3CCF7E3
      CCF9E5CCF9E5CCF9E5CCF9E5CCF9E5CCDADADAFEF1E7FEF1E7FEF1E7FEF1E7FE
      F1E7FEF1E7FEF1E7FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      8C6363DE7B00DE7B00DE7B00DE7B00DE7B00DE7B00DE7B00424242F7B584F7B5
      84FFE7DEFFE7DEFFE7DEFFDECEF7B584F7B5848C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFE8E0E0F9E5CCF9E5CCF9E5CCF9E5CCF9E5CCF9E5CCF9E5CC
      DADADAFEF1E7FEF1E7FFFBF9FFFBF9FFFBF9FFF9F6FEF1E7FEF1E7E8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363DE7B00E77B00E77B00DE7B00DE
      7B00EF7B00EF7B00424242EFCEBDFFE7DEFFE7DEFFDECEF7D6CEEFCEBDFFE7DE
      F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F9E5CCFBE5
      CCFBE5CCF9E5CCF9E5CCFCE5CCFCE5CCDADADAFCF6F2FFFBF9FFFBF9FFF9F6FE
      F7F6FCF6F2FFFBF9FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      8C6363FF8400EF7B00EF7B00EF7B00EF7B00EF7B00EF7B00424242F7B584F7C6
      A5F7CEBDFFE7DEF7D6CEF7CEBDF7C6A5F7B5848C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFE8E0E0FFE7CCFCE5CCFCE5CCFCE5CCFCE5CCFCE5CCFCE5CC
      DADADAFEF1E7FEF4EDFEF6F2FFFBF9FEF7F6FEF6F2FEF4EDFEF1E7E8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363D67300FF8400FF8400F78400F7
      7B00EF7B00EF7B00424242F7B584F7B584F7B584EFCEBDEFCEBDEFCEBDF7B584
      F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F7E3CCFFE7
      CCFFE7CCFEE7CCFEE5CCFCE5CCFCE5CCDADADAFEF1E7FEF1E7FEF1E7FCF6F2FC
      F6F2FCF6F2FEF1E7FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      FF00FFAD6B63AD6B63D67300FF8400EF7B00F78400FF8400424242F7B584F7B5
      84F7B584F7B584F7B584F7B584F7B584F7B5848C6363FF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFFFCCFFEFE2E0EFE2E0F7E3CCFFE7CCFCE5CCFEE7CCFFE7CC
      DADADAFEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7E8E0E0FFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFAD6B63AD6B63D6
      7300FF8400FF8400424242848484848484848484848484848484848484848484
      848484848484FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFEFE2E0EFE2E0F7E3CCFFE7CCFFE7CCDADADAE7E7E7E7E7E7E7E7E7E7E7E7E7
      E7E7E7E7E7E7E7E7E7E7E7E7E7E7FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFAD6B63AD6B63AD6B63AD6B63FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFEFE2E0EFE2E0EFE2E0
      EFE2E0FFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
      CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF
      FFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
      FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
      CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF}
    NumGlyphs = 2
  end
  object StringGrid1: TStringGrid
    Left = 4
    Top = 96
    Width = 729
    Height = 307
    ColCount = 4
    DefaultColWidth = 80
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
    ParentFont = False
    TabOrder = 4
  end
  object qryTotaisCorrier: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT  '
      #9'FM.FAMILIA,'
      #9'COUNT(F.COD_AR) AS QTD,'
      #9'D.DS_MOTIVO'
      'FROM  '
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA FM'
      'WHERE'
      #9'D.CD_MOTIVO = F.CD_MOTIVO '
      #9'AND FM.CODBIN = F.CODBIN '
      #9'AND F.COD_AR  LIKE '#39'IB%'#39' '
      #9'AND F.DT_DEVOLUCAO >=  :DT_INI '
      #9'AND F.DT_DEVOLUCAO <=  :DT_FIM '
      'GROUP BY '
      #9'D.DS_MOTIVO,FM.FAMILIA '
      'ORDER BY'
      #9'FM.FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    Left = 168
    Top = 272
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    object qryTotaisCorrierfamilia: TStringField
      FieldName = 'familia'
      Required = True
      Size = 60
    end
    object qryTotaisCorrierqtd: TLargeintField
      FieldName = 'qtd'
      ReadOnly = True
    end
    object qryTotaisCorrierds_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
  end
  object qryFamilaCOR: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT  '
      'distinct'#9'FM.FAMILIA'
      'FROM  '
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA FM'
      'WHERE'
      #9'D.CD_MOTIVO = F.CD_MOTIVO '
      #9'AND FM.CODBIN = F.CODBIN '
      #9'AND F.COD_AR  LIKE '#39'IB%'#39' '
      #9'AND F.DT_DEVOLUCAO >=  :DT_INI '
      #9'AND F.DT_DEVOLUCAO <=  :DT_FIM '
      'GROUP BY '
      #9'D.DS_MOTIVO,FM.FAMILIA '
      'ORDER BY'
      #9'FM.FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    Left = 168
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    object qryFamilaCORfamilia: TStringField
      FieldName = 'familia'
      Required = True
      Size = 60
    end
  end
  object qryTotaisRemessa: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT  '
      #9'FM.FAMILIA,'
      #9'COUNT(F.COD_AR) AS QTD,'
      #9'D.DS_MOTIVO'
      'FROM  '
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA FM'
      'WHERE'
      #9'D.CD_MOTIVO = F.CD_MOTIVO '
      #9'AND FM.CODBIN = F.CODBIN '
      #9'AND F.COD_AR  NOT LIKE '#39'IB%'#39' '
      #9'AND F.DT_DEVOLUCAO >=  :DT_INI '
      #9'AND F.DT_DEVOLUCAO <=  :DT_FIM '
      'GROUP BY '
      #9'D.DS_MOTIVO,FM.FAMILIA '
      'ORDER BY'
      #9'FM.FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    Left = 208
    Top = 272
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    object qryTotaisRemessafamilia: TStringField
      FieldName = 'familia'
      Required = True
      Size = 60
    end
    object qryTotaisRemessaqtd: TLargeintField
      FieldName = 'qtd'
      ReadOnly = True
    end
    object qryTotaisRemessads_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
  end
  object qryFamilaRE: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT  '
      'distinct'#9'FM.FAMILIA'
      'FROM  '
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA FM'
      'WHERE'
      #9'D.CD_MOTIVO = F.CD_MOTIVO '
      #9'AND FM.CODBIN = F.CODBIN '
      #9'AND F.COD_AR  NOT LIKE '#39'IB%'#39' '
      #9'AND F.DT_DEVOLUCAO >=  :DT_INI '
      #9'AND F.DT_DEVOLUCAO <=  :DT_FIM '
      'GROUP BY '
      #9'D.DS_MOTIVO,FM.FAMILIA '
      'ORDER BY'
      #9'FM.FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    Left = 208
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_INI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DT_FIM'
        ParamType = ptUnknown
      end>
    object qryFamilaREfamilia: TStringField
      FieldName = 'familia'
      Required = True
      Size = 60
    end
  end
  object qryResumoREM: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,  MOTIVO,COD_MOT,  DT_DEVOLUCAO'
      'FROM('
      '  SELECT'
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM'
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE'
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN AND'
      '    F.COD_AR NOT LIKE '#39'IB%'#39' '
      ''
      '  GROUP BY'
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN,'
      '    F.CD_MOTIVO,'
      '    D.DS_MOTIVO,'#9
      '    D.CD_MOTIVO,'#9
      '    CF.FAMILIA'
      ')TMP'
      'GROUP BY'
      ' MOTIVO,COD_MOT,'
      '  DT_DEVOLUCAO'
      'ORDER BY DT_DEVOLUCAO, COD_MOT , MOTIVO'
      '')
    Params = <>
    Left = 432
    Top = 224
    object qryResumoREMqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryResumoREMmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryResumoREMcod_mot: TStringField
      FieldName = 'cod_mot'
      ReadOnly = True
      Size = 2
    end
    object qryResumoREMdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
  end
  object qryDatasREM: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'select distinct cast(dt_devolucao as  CHAR(10)) as dt_devolucao'
      'from ibi_controle_devolucoes_AR'
      'where cod_ar not like '#39'IB%'#39
      'group by dt_devolucao'
      'order by dt_devolucao desc'
      '')
    Params = <>
    Left = 432
    Top = 256
    object qryDatasREMdt_devolucao: TStringField
      FieldName = 'dt_devolucao'
      ReadOnly = True
      Size = 10
    end
  end
  object qryTotaisREM: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO'
      'FROM('
      '  SELECT'
      '     COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      ' FROM'
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE'
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN  '
      'AND F.COD_AR NOT  LIKE '#39'IB%'#39' '
      'AND    F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY'
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN,'
      '    F.CD_MOTIVO,D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO'
      'ORDER BY DT_DEVOLUCAO, MOTIVO'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Left = 432
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryTotaisREMqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryTotaisREMmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryTotaisREMdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
  end
  object qryDevolARRem: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM('
      '  SELECT  '
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM '
      '    IBI_CONTROLE_DEVOLUCOES_AR F, '
      '    IBI_MOTIVO_DEVOLUCOES D,  '
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE '
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN '
      'AND F.COD_AR NOT LIKE '#39'IB%'#39
      'AND F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY '
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN, '
      '  F.CD_MOTIVO,D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'ORDER BY DT_DEVOLUCAO,FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Left = 432
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryDevolARRemqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryDevolARRemmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryDevolARRemdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
    object qryDevolARRemfamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
  end
  object qryResumoCour: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO'
      'FROM('
      '  SELECT'
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM'
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE'
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN and'
      '   F.COD_AR LIKE '#39'IB%'#39
      '  GROUP BY'
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN,'
      '    F.CD_MOTIVO,D.DS_MOTIVO,D.CD_MOTIVO,'
      '    CF.FAMILIA'
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO'
      'ORDER BY DT_DEVOLUCAO, MOTIVO'
      '')
    Params = <>
    Left = 432
    Top = 352
    object qryResumoCourqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryResumoCourmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryResumoCourdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
  end
  object qryTotaisCour: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO'
      'FROM('
      '  SELECT'
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM'
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE'
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN  '
      'AND F.COD_AR  LIKE '#39'IB%'#39' '
      'AND    F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY'
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN,'
      '    F.CD_MOTIVO,D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO'
      'ORDER BY DT_DEVOLUCAO, MOTIVO'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Left = 480
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryTotaisCourqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryTotaisCourmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryTotaisCourdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
  end
  object qryDevolARCou: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM('
      '  SELECT  '
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM '
      '    IBI_CONTROLE_DEVOLUCOES_AR F, '
      '    IBI_MOTIVO_DEVOLUCOES D,  '
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE '
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN '
      'AND F.COD_AR LIKE '#39'IB%'#39
      'AND F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY '
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN, '
      '    F.CD_MOTIVO, D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ''
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'ORDER BY DT_DEVOLUCAO,FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Left = 480
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryDevolARCouqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryDevolARCoumotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryDevolARCoudt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
    object qryDevolARCoufamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
  end
  object qryTotais: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO'
      'FROM('
      '  SELECT'
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM'
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE'
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN  and'
      '    F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY'
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN,'
      '    F.CD_MOTIVO,D.CD_MOTIVO,D.DS_MOTIVO,'
      '    CF.FAMILIA'
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO'
      'ORDER BY DT_DEVOLUCAO, MOTIVO'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Left = 480
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryTotaisqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryTotaismotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryTotaisdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
  end
  object qryDevolAR: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM('
      '  SELECT  '
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM '
      '    IBI_CONTROLE_DEVOLUCOES_AR F, '
      '    IBI_MOTIVO_DEVOLUCOES D,  '
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE '
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN '
      'AND F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY '
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN, '
      '    F.CD_MOTIVO, D.DS_MOTIVO,D.CD_MOTIVO,'
      '    CF.FAMILIA'
      ''
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA,COD_MOT'
      'ORDER BY DT_DEVOLUCAO,FAMILIA'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    Properties.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA'
      'FROM('
      '  SELECT  '
      '    COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM '
      '    IBI_CONTROLE_DEVOLUCOES_AR F, '
      '    IBI_MOTIVO_DEVOLUCOES D,  '
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE '
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN '
      'AND F.DT_DEVOLUCAO = :DT_DEVOL'
      '  GROUP BY '
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN, '
      '    F.CD_MOTIVO, D.DS_MOTIVO,D.CD_MOTIVO,'
      '    CF.FAMILIA'
      ''
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO,'
      '  FAMILIA,COD_MOT'
      'ORDER BY DT_DEVOLUCAO,FAMILIA')
    Left = 480
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT_DEVOL'
        ParamType = ptUnknown
      end>
    object qryDevolARqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryDevolARmotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryDevolARdt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
    object qryDevolARfamilia: TStringField
      FieldName = 'familia'
      ReadOnly = True
      Size = 60
    end
  end
  object qryResumo: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'SELECT'
      '  SUM(QTD_DEVOL) AS QTDE,'
      '  MOTIVO,'
      '  DT_DEVOLUCAO'
      'FROM('
      '  SELECT'
      '   COUNT(F.CODBIN) AS QTD_DEVOL, D.DS_MOTIVO AS MOTIVO,'
      '    D.CD_MOTIVO AS COD_MOT,'#9'F.DT_DEVOLUCAO, CF.FAMILIA'
      '  FROM'
      '    IBI_CONTROLE_DEVOLUCOES_AR F,'
      '    IBI_MOTIVO_DEVOLUCOES D,'
      '    IBI_CADASTRO_FAMILIA CF'
      '  WHERE'
      '    F.CD_MOTIVO = D.CD_MOTIVO  and'
      '    F.CODBIN = CF.CODBIN'
      '  GROUP BY'
      '    F.DT_DEVOLUCAO,'
      '    F.CODBIN,'
      '    F.CD_MOTIVO,D.DS_MOTIVO,D.CD_MOTIVO,'
      '    CF.FAMILIA'
      ')TMP'
      'GROUP BY'
      ' MOTIVO,'
      '  DT_DEVOLUCAO'
      'ORDER BY DT_DEVOLUCAO, MOTIVO'
      '')
    Params = <>
    Left = 480
    Top = 352
    object qryResumoqtde: TFloatField
      FieldName = 'qtde'
      ReadOnly = True
    end
    object qryResumomotivo: TStringField
      FieldName = 'motivo'
      ReadOnly = True
      Size = 40
    end
    object qryResumodt_devolucao: TDateField
      FieldName = 'dt_devolucao'
      ReadOnly = True
    end
  end
  object qryDatas: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'select distinct cast(dt_devolucao as CHAR(10)) as dt_devolucao'
      'from ibi_controle_devolucoes_AR'
      'group by dt_devolucao'
      'order by dt_devolucao desc'
      '')
    Params = <>
    Left = 584
    Top = 272
    object qryDatasdt_devolucao: TStringField
      FieldName = 'dt_devolucao'
      ReadOnly = True
      Size = 10
    end
  end
  object qryDatasCour: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'select distinct cast(dt_devolucao as CHAR(10)) as dt_devolucao'
      'from ibi_controle_devolucoes_AR'
      'where cod_ar  like '#39'IB%'#39
      'group by dt_devolucao'
      'order by dt_devolucao desc'
      '')
    Params = <>
    Properties.Strings = (
      'select distinct(cast(dt_devolucao as  CHAR(10))) as dt_devolucao'
      'from ibi_controle_devolucoes_AR'
      'where cod_ar  like '#39'IB%'#39
      'group by dt_devolucao'
      'order by dt_devolucao desc')
    Left = 592
    Top = 312
    object qryDatasCourdt_devolucao: TStringField
      FieldName = 'dt_devolucao'
      ReadOnly = True
      Size = 10
    end
  end
  object qryDevolAR2: TZTable
    Left = 520
    Top = 328
  end
  object qryFamilia: TZReadOnlyQuery
    Connection = DM.CtrlDvlDBConn
    SQL.Strings = (
      'select distinct familia from ibi_cadastro_familia'
      'ORDER BY FAMILIA'
      '')
    Params = <>
    Left = 568
    Top = 224
    object qryFamiliafamilia: TStringField
      FieldName = 'familia'
      Required = True
      Size = 60
    end
  end
end
