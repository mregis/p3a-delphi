object qrForm_RelMotivos: TqrForm_RelMotivos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'qrForm_RelMotivos'
  ClientHeight = 353
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLRelMotivos: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 61
      BandType = btTitle
      object RLLabel1: TRLLabel
        Left = 3
        Top = 1
        Width = 136
        Height = 16
        Caption = 'ADDRESS SA -  C&A '
      end
      object RLLabel2: TRLLabel
        Left = 190
        Top = 0
        Width = 46
        Height = 16
        Caption = 'DATA: '
      end
      object RLLabel3: TRLLabel
        Left = 586
        Top = 16
        Width = 44
        Height = 16
        AutoSize = False
        Caption = 'PAG.: '
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 630
        Top = 16
        Width = 44
        Height = 16
        AutoSize = False
        Info = itPageNumber
      end
      object RLLabel4: TRLLabel
        Left = 3
        Top = 17
        Width = 153
        Height = 16
        Caption = 'PROCESSAMENTO DE: '
      end
      object qlPeriodo: TRLLabel
        Left = 190
        Top = 17
        Width = 48
        Height = 16
        Caption = 'Per'#237'odo'
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 57
        Width = 794
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object RLLabel5: TRLLabel
        Left = 151
        Top = 40
        Width = 373
        Height = 16
        Caption = 'RESUMO DO CONTROLE DE DEVOLU'#199#213'ES POR PRODUTO'
      end
      object RLDraw2: TRLDraw
        Left = -76
        Top = 38
        Width = 794
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 99
      Width = 718
      Height = 84
      object RLBand2: TRLBand
        Left = 0
        Top = 38
        Width = 718
        Height = 20
        object RLDBText3: TRLDBText
          Left = 3
          Top = 1
          Width = 70
          Height = 16
        end
        object RLDBText4: TRLDBText
          Left = 586
          Top = 1
          Width = 70
          Height = 16
          AutoSize = False
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 38
        BandType = btHeader
        object RLLabel6: TRLLabel
          Left = 3
          Top = 1
          Width = 119
          Height = 16
          AutoSize = False
          Caption = 'C'#243'digo do Produto: '
        end
        object RLLabel7: TRLLabel
          Left = 3
          Top = 17
          Width = 119
          Height = 16
          AutoSize = False
          Caption = 'Descri'#231#227'o: '
        end
        object RLDBText1: TRLDBText
          Left = 122
          Top = 1
          Width = 70
          Height = 16
          DataSource = DtsMotivosTot
        end
        object RLDBText2: TRLDBText
          Left = 122
          Top = 17
          Width = 70
          Height = 16
        end
        object RLLabel8: TRLLabel
          Left = 586
          Top = 17
          Width = 70
          Height = 16
          Caption = 'Quantidade'
        end
        object RLDraw3: TRLDraw
          Left = -76
          Top = 34
          Width = 794
          Height = 1
          DrawKind = dkLine
          Pen.Style = psDot
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 58
        Width = 718
        Height = 23
        BandType = btFooter
        object RLLabel9: TRLLabel
          Left = 489
          Top = 1
          Width = 97
          Height = 16
          AutoSize = False
          Caption = 'Total do Grupo: '
        end
        object RLDBResult1: TRLDBResult
          Left = 586
          Top = 1
          Width = 70
          Height = 16
          AutoSize = False
          DataSource = DM.dtsMotivo
          DisplayMask = '#,##0'
          Info = riSum
        end
        object RLDraw4: TRLDraw
          Left = -76
          Top = 1
          Width = 794
          Height = 1
          DrawKind = dkLine
          Pen.Style = psDot
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 183
      Width = 718
      Height = 25
      BandType = btSummary
      object RLLabel10: TRLLabel
        Left = 489
        Top = 8
        Width = 97
        Height = 16
        AutoSize = False
        Caption = 'Total Global:'
      end
      object RLDBResult2: TRLDBResult
        Left = 586
        Top = 8
        Width = 70
        Height = 16
        AutoSize = False
        DataSource = DtsMotivosTot
        DisplayMask = '#,##0'
        Info = riSum
      end
    end
  end
  object qraMotivosTot: TZReadOnlyQuery
    Connection = DM.ADOConnection1
    SQL.Strings = (
      'SELECT D.CD_MOTIVO, M.DS_MOTIVO, count(*)  as Total '
      'FROM CEA_CONTROLE_DEVOLUCOES_TEMP D, CEA_MOTIVOS_DEVOLUCOES M'
      'GROUP BY D.CD_MOTIVO, M.DS_MOTIVO '
      'ORDER BY M.DS_MOTIVO '
      '')
    Params = <>
    Left = 152
    Top = 8
  end
  object DtsMotivosTot: TDataSource
    DataSet = DevolucoesFrm.qraMotivo
    Left = 184
    Top = 8
  end
end
