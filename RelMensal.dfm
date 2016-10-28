object qrForm_RelMensal: TqrForm_RelMensal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'qrForm_RelMensal'
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
  object RLRelMensal: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = DM.DtSRelMensal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 58
      BandType = btHeader
      BeforePrint = RLBand1BeforePrint
      object RLLabel1: TRLLabel
        Left = 3
        Top = 0
        Width = 106
        Height = 16
        Caption = 'ADDRESS - C&A'
      end
      object RLLabel2: TRLLabel
        Left = 151
        Top = 0
        Width = 46
        Height = 16
        Caption = 'DATA: '
      end
      object RLLabel3: TRLLabel
        Left = 605
        Top = 0
        Width = 39
        Height = 16
        AutoSize = False
        Caption = 'P'#225'g.: '
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 643
        Top = 0
        Width = 39
        Height = 16
        AutoSize = False
        Info = itPageNumber
      end
      object RLPeriodo: TRLLabel
        Left = 152
        Top = 16
        Width = 64
        Height = 16
      end
      object RLLabel6: TRLLabel
        Left = 132
        Top = 37
        Width = 382
        Height = 16
        Caption = 'RESUMO DO CONTROLE DE DEVOLU'#199#213'ES POR PRODUTOS'
      end
      object RLDraw1: TRLDraw
        Left = 1
        Top = 34
        Width = 718
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object RLDraw2: TRLDraw
        Left = 0
        Top = 55
        Width = 718
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 96
      Width = 718
      Height = 113
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 36
        BandType = btHeader
        object RLLabel7: TRLLabel
          Left = 3
          Top = 0
          Width = 119
          Height = 16
          Caption = 'C'#243'digo do Produto: '
        end
        object RLDBText1: TRLDBText
          Left = 122
          Top = 0
          Width = 70
          Height = 16
        end
        object RLLabel8: TRLLabel
          Left = 3
          Top = 16
          Width = 70
          Height = 16
          Caption = 'Descri'#231#227'o: '
        end
        object RLDBText2: TRLDBText
          Left = 73
          Top = 16
          Width = 68
          Height = 16
          DataField = 'ds_produto'
        end
        object RLLabel9: TRLLabel
          Left = 528
          Top = 16
          Width = 70
          Height = 16
          Caption = 'Quantidade'
        end
        object RLDraw3: TRLDraw
          Left = 0
          Top = 32
          Width = 718
          Height = 1
          DrawKind = dkLine
          Pen.Style = psDot
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 36
        Width = 718
        Height = 21
        object RLDBText3: TRLDBText
          Left = 3
          Top = 1
          Width = 68
          Height = 16
          DataField = 'cd_produto'
        end
        object RLDraw4: TRLDraw
          Left = 0
          Top = 18
          Width = 718
          Height = 1
          DrawKind = dkLine
          Pen.Style = psDot
        end
        object RLDBText4: TRLDBText
          Left = 528
          Top = 1
          Width = 29
          Height = 16
          DataField = 'total'
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 57
        Width = 718
        Height = 21
        object RLLabel10: TRLLabel
          Left = 416
          Top = 2
          Width = 97
          Height = 16
          Caption = 'Total do Grupo: '
        end
        object RLDTotGrupo: TRLDBResult
          Left = 528
          Top = 0
          Width = 68
          Height = 16
          DataField = 'total'
          DisplayMask = '#,##0.00'
          Info = riSum
        end
      end
      object RLBand5: TRLBand
        Left = 0
        Top = 78
        Width = 718
        Height = 21
        object RLLabel11: TRLLabel
          Left = 416
          Top = 1
          Width = 103
          Height = 16
          Caption = 'Total do Global:: '
        end
        object RLDTotGer: TRLDBResult
          Left = 528
          Top = 1
          Width = 68
          Height = 16
          DataField = 'total'
          DisplayMask = '#,##0.00'
          Info = riSum
        end
      end
    end
  end
end
