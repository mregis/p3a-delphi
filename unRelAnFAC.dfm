object frmRelAnFAC: TfrmRelAnFAC
  Left = 531
  Top = 331
  BorderStyle = bsDialog
  Caption = 'Relatorio Analitico CRT - FAC'
  ClientHeight = 188
  ClientWidth = 389
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
    Left = 37
    Top = 29
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label2: TLabel
    Left = 232
    Top = 28
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object btnProc: TBitBtn
    Left = 35
    Top = 75
    Width = 75
    Height = 30
    Caption = 'Processar'
    TabOrder = 0
    OnClick = btnProcClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF7F2B287F2B28A18283A18283A18283A1
      8283A18283A18283A182837A1C1C7F2B28FF00FFFF00FFFF00FFFF00FF7F2B28
      CA4D4DB64545DDD4D5791617791617DCE0E0D7DADECED5D7BDBABD76100F9A2D
      2D7F2B28FF00FFFF00FFFF00FF7F2B28C24A4BB14444E2D9D9791617791617D9
      D8DAD9DEE1D3D9DCC1BDC1761111982D2D7F2B28FF00FFFF00FFFF00FF7F2B28
      C24A4AB04242E6DCDC791617791617D5D3D5D8DEE1D7DDE0C6C2C5700F0F962C
      2C7F2B28FF00FFFF00FFFF00FF7F2B28C24A4AB04141EADEDEE7DDDDDDD4D5D7
      D3D5D5D7D9D7D8DACAC2C57E17179E31317F2B28FF00FFFF00FFFF00FF7F2B28
      BF4748B84545BA4C4CBD5757BB5756B64E4EB44949BD5251BB4B4CB54242BF4A
      4A7F2B28FF00FFFF00FFFF00FF7F2B28A33B39B1605DC68684CB918FCC9190CC
      908FCB8988C98988CB9391CC9696BD4B4C7F2B28FF00FFFF00FFFF00FF7F2B28
      BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B
      4C7F2B28FF00FFFF00FFFF00FF7F2B28BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7
      F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B4C7F2B28FF00FFFF00FFFF00FF7F2B28
      BD4B4CF7F7F7BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF7F7F7BD4B
      4C7F2B28FF00FFFF00FFFF00FF7F2B28BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7
      F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B4C7F2B28FF00FFFF00FFFF00FF7F2B28
      BD4B4CF7F7F7BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF7F7F7BD4B
      4C7F2B28FF00FFFF00FFFF00FF7F2B28BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7
      F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B4C7F2B28FF00FFFF00FFFF00FFFF00FF
      7F2B28F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F77F2B
      28FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object DTPinicial: TDateTimePicker
    Left = 12
    Top = 48
    Width = 160
    Height = 21
    Date = 40042.608120729160000000
    Time = 40042.608120729160000000
    TabOrder = 1
  end
  object DTPFinal: TDateTimePicker
    Left = 208
    Top = 48
    Width = 160
    Height = 21
    Date = 40042.608140439810000000
    Time = 40042.608140439810000000
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 157
    Width = 389
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Btnsair: TBitBtn
    Left = 232
    Top = 75
    Width = 75
    Height = 30
    Caption = 'Sair'
    TabOrder = 4
    OnClick = btnSairClick
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
  object qryRel: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'select '
      
        #9'COUNT(A.NRO_CARTAO) AS QTD_REG, D.DS_MOTIVO,  A.CD_MOTIVO, F.FA' +
        'MILIA'
      'from '
      #9'IBI_CONTROLE_DEVOLUCOES_FAC A,'
      #9'IBI_MOTIVO_DEVOLUCOES D,'
      #9'IBI_CADASTRO_FAMILIA F'
      ''
      'WHERE '
      #9'(A.CODBIN = F.CODBIN) AND'
      #9'(A.CD_MOTIVO = D.CD_MOTIVO) AND'
      '  (DT_DEVOLUCAO >= :DT_INI AND DT_DEVOLUCAO <= :DT_FIM )'
      'GROUP BY  D.DS_MOTIVO, A.CD_MOTIVO, F.FAMILIA'
      'ORDER BY  F.FAMILIA,A.CD_MOTIVO, D.DS_MOTIVO'
      ''
      ''
      ''
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
    Left = 152
    Top = 80
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
    object qryRelqtd_reg: TLargeintField
      FieldName = 'qtd_reg'
      ReadOnly = True
    end
    object qryRelds_motivo: TStringField
      FieldName = 'ds_motivo'
      Required = True
      Size = 40
    end
    object qryRelcd_motivo: TStringField
      FieldName = 'cd_motivo'
      Required = True
      Size = 2
    end
    object qryRelfamilia: TStringField
      FieldName = 'familia'
      Required = True
      Size = 60
    end
  end
end