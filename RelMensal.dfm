object qrForm_RelMensal: TqrForm_RelMensal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'qrForm_RelMensal'
  ClientHeight = 486
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RLRelMensal: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    Background.AutoSize = False
    DataSource = DM.DtSRelMensal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PreviewOptions.Caption = 'Relat'#243'rio de Devolu'#231#245'es por Produto'
    object RLBandCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 70
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = RLBandCabecalhoBeforePrint
      object RLLabelTitulo: TRLLabel
        Left = 3
        Top = 0
        Width = 94
        Height = 16
        Caption = 'ADDRESS - IBI'
      end
      object RLLabelData: TRLLabel
        Left = 151
        Top = 0
        Width = 37
        Height = 15
        Caption = 'DATA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabelPagina: TRLLabel
        Left = 605
        Top = 0
        Width = 39
        Height = 16
        AutoSize = False
        Caption = 'P'#225'g.: '
      end
      object RLSystemInfoNumPag: TRLSystemInfo
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
      object RLLabelSubTitulo: TRLLabel
        Left = 169
        Top = 39
        Width = 382
        Height = 16
        Alignment = taCenter
        Caption = 'RESUMO DO CONTROLE DE DEVOLU'#199#213'ES POR PRODUTOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabelDataRelatorio: TRLLabel
        Left = 203
        Top = 0
        Width = 68
        Height = 16
        Caption = '10/11/2016'
      end
    end
    object RLGroupProdutos: TRLGroup
      Left = 38
      Top = 108
      Width = 718
      Height = 141
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      Borders.Width = 2
      DataFields = 'cd_produto;ds_produto'
      object RLDetailGridResumoLeituras: TRLDetailGrid
        Left = 0
        Top = 65
        Width = 718
        Height = 32
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.Style = bsHorizontal
        ColCount = 2
        object RLDTotalProduto: TRLDBResult
          Left = 269
          Top = 9
          Width = 81
          Height = 16
          Alignment = taRightJustify
          DataField = 'total'
          DataSource = DM.DtSRelMensal
          DisplayMask = '######0'
        end
        object RLDBTextMotivo: TRLDBText
          Left = 3
          Top = 9
          Width = 62
          Height = 16
          DataField = 'ds_motivo'
          DataSource = DM.DtSRelMensal
        end
      end
      object RLBandTotalProduto: TRLBand
        Left = 0
        Top = 97
        Width = 718
        Height = 32
        BandType = btSummary
        object RLLabelTotalGeral: TRLLabel
          Left = 496
          Top = 10
          Width = 94
          Height = 16
          Caption = 'Total Produto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBResultTotalProduto: TRLDBResult
          Left = 608
          Top = 10
          Width = 68
          Height = 16
          DataField = 'total'
          DataSource = DM.DtSRelMensal
          DisplayMask = '######0'
          Info = riSum
        end
      end
      object RLBandColumHeader: TRLBand
        Left = 0
        Top = 40
        Width = 718
        Height = 25
        BandType = btColumnHeader
        object RLLabelMotivos: TRLLabel
          Left = 4
          Top = 6
          Width = 49
          Height = 15
          Caption = 'MOTIVO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabelQtde: TRLLabel
          Left = 301
          Top = 6
          Width = 34
          Height = 15
          Caption = 'QTDE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBandHeaderProduto: TRLBand
        Left = 0
        Top = 2
        Width = 718
        Height = 38
        BandType = btHeader
        object RLLabelProduto: TRLLabel
          Left = 3
          Top = 6
          Width = 57
          Height = 16
          Caption = 'Produto: '
        end
        object RLDBTextCodProduto: TRLDBText
          Left = 66
          Top = 6
          Width = 68
          Height = 16
          Alignment = taRightJustify
          DataField = 'cd_produto'
          DataSource = DM.DtSRelMensal
        end
        object RLDBTextDescricaoProduto: TRLDBText
          Left = 140
          Top = 6
          Width = 68
          Height = 16
          DataField = 'ds_produto'
          DataSource = DM.DtSRelMensal
        end
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 249
      Width = 718
      Height = 40
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLDBResult1: TRLDBResult
        Left = 608
        Top = 18
        Width = 68
        Height = 16
        DataField = 'total'
        DataSource = DM.DtSRelMensal
        DisplayMask = '######0'
        Info = riSum
      end
      object RLLabel1: TRLLabel
        Left = 496
        Top = 18
        Width = 79
        Height = 16
        Caption = 'Total Geral:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
end
