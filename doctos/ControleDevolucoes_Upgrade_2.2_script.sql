-- Criando a tabela de Servicos -- Versao 2.2 da aplicacao
CREATE TABLE public.servicos (
  id SERIAL, 
  descricao VARCHAR NOT NULL, 
  dt_cadastro DATE DEFAULT 'now'::text::date NOT NULL, 
  estado INTEGER DEFAULT 1 NOT NULL, 
  CONSTRAINT servicos_pkey PRIMARY KEY(id)
) WITHOUT OIDS;

ALTER TABLE public.servicos
  ALTER COLUMN id SET STATISTICS 0;

ALTER TABLE public.servicos
  ALTER COLUMN descricao SET STATISTICS 0;

COMMENT ON COLUMN public.servicos.id
IS 'Identificado do registro na Tabela';

COMMENT ON COLUMN public.servicos.descricao
IS 'Nome que Identifica o serviço ou contrato';

COMMENT ON COLUMN public.servicos.dt_cadastro
IS 'Data de criaçao do registro';

COMMENT ON COLUMN public.servicos.estado
IS 'Indica o estado do produto (0=inativo, 1=ativo, 9=cancelado)';


/* Data for the 'public.servicos' table  (Records 1 - 2) */

INSERT INTO public.servicos ("id", "descricao", "dt_cadastro", "estado")
VALUES (1, E'CARTOES BRADESCARD', E'2017-12-04', 1);

INSERT INTO public.servicos ("id", "descricao", "dt_cadastro", "estado")
VALUES (2, E'CARTOES LOSANGO', E'2017-12-04', 1);


BEGIN;
-- ########## Adicionando campo de servico a tabela de motivos de devolução IBI
ALTER TABLE public.ibi_motivo_devolucoes
  ADD COLUMN servico_id INTEGER DEFAULT 1 NOT NULL;

COMMENT ON COLUMN public.ibi_motivo_devolucoes.servico_id
IS 'Identificador do registro na tabela Servicos';  

-- Adicionando nova chave primaria
ALTER TABLE public.ibi_motivo_devolucoes
  DROP CONSTRAINT "MOTIVO_DEV_IBI_PK" RESTRICT;
  
ALTER TABLE public.ibi_motivo_devolucoes
  ADD CONSTRAINT "PK_MOTIVODEVOLUCAO" 
    PRIMARY KEY (cd_motivo, servico_id);

-- Novos dados para a tabela de Motivos de Devolução

INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'00',E'SEM MOTIVO DEFINIDO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'09',E'EXTRAVIADO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'12',E'REFUGADO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'19',E'ENDEREÇO INCORRETO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'22',E'REINTEGRADO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'26',E'NÃO PROCURADO - DEVOLVIDO AO REMETENTE',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'29',E'ROUBADO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'33',E'DOCUMENTAÇÃO NÃO FORNECIDA',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'34',E'LOGRADOURO COM NUMERAÇÃO IRREGULAR',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'71',E'MUDOU-SE',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'72',E'DESCONHECIDO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'73',E'RECUSADO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'74',E'INF PREST PELO PORTEIRO OU SINDICO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'75',E'ENDEREÇO INSUFICIENTE',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'76',E'NÃO EXISTE O NÚMERO INDICADO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'77',E'AUSENTE - DEVOLVIDO AO REMETENTE',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'78',E'NÃO PROCURADO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'79',E'FALECIDO',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'99',E'OUTROS',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'20',E'AUSENTE NOVA TENTATIVA',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'02',E'AUSENTE - ENCAMINHADO P/ ENTREGA INTERNA',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'24',E'DISPONÍVEL CAIXA POSTAL',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'46',E'ENTREGA NÃO EFETUADA',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'66',E'ÁREA RESTRIÇÃO DE ENTREGA',2);
INSERT INTO ibi_motivo_devolucoes (cd_motivo,ds_motivo,servico_id) VALUES (E'32',E'ENTREGA AGENDADA',2);
COMMIT;

-- Adicionando nova coluna na tabela de Lotes para separar os tipos de servicos
BEGIN;
ALTER TABLE public.lote  ADD COLUMN servico_id INTEGER DEFAULT 1 NOT NULL;
COMMENT ON COLUMN public.lote.servico_id IS 'Identificador do Tipo de servico ou empresa contratante';
ALTER TABLE public.lote
  ADD CONSTRAINT FK_LOTE_SERVICO FOREIGN KEY (servico_id)
    REFERENCES public.servicos(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
	
COMMIT;


-- Novos dados para a tabela de Familias de BINs
BEGIN;
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'302',E'VIVA INTERNACIONAL',E'423944',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'001',E'LOSANGO VISA',E'432031',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'003',E'RICARDO ELETRO/CITYLAR/CREDMOVEIS/ELETROSHOPPING/RABELO',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'004',E'CITYLAR',E'432032',E'LOSANGO VISA','1');
--INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'005',E'CREDMOVEIS',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'007',E'ELETROSHOPPING',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'010',E'VIVA NACIONAL',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'012',E'RABELO',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'019',E'MANLEC',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'020',E'FACIL VISA',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'024',E'CARRINHO CHEIO',E'432035',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'026',E'GABRYELLA',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'027',E'HERING',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'028',E'FUJIOKA',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'031',E'ATACADAO DOS ELETROS',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'032',E'COMERCIAL SÃO JORGE',E'432032',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'038',E'ATACADAO DM/VIVA NACIONAL/BISTECK/CARRINHO CHEIO',E'432035',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'040',E'VIVA NACIONAL',E'432035',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'046',E'CARTAO GUIDO',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'051',E'BISTECK',E'432035',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'053',E'SUPERMERCADO PREÇO BOM',E'432035',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'085',E'INSINUANTE',E'432032',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'086',E'COLOMBO',E'432032',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'090',E'LEROY MERLIN/VIVA INTERNACIONAL',E'400437',E'LOSANGO VISA','1');
-- INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'302',E'VIVA INTERNACIONAL',E'423944',E'LOSANGO VISA','1');

-- Resolução de problemas de falta de BIN para Cartões LOSANGO
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'302',E'VIVA INTERNACIONAL',E'407302',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'001',E'LOSANGO VISA',E'407001',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'003',E'RICARDO ELETRO',E'407003',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'004',E'CITYLAR',E'407004',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'005',E'CREDMOVEIS',E'407005',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'007',E'ELETROSHOPPING',E'407007',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'010',E'VIVA NACIONAL',E'407010',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'012',E'RABELO',E'407012',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'019',E'MANLEC',E'407019',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'020',E'FACIL VISA',E'407020',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'024',E'CARRINHO CHEIO',E'407024',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'026',E'GABRYELLA',E'407026',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'027',E'HERING',E'407027',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'028',E'FUJIOKA',E'407028',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'031',E'ATACADAO DOS ELETROS',E'407031',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'032',E'COMERCIAL SÃO JORGE',E'407032',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'038',E'ATACADAO DM',E'407038',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'040',E'VIVA NACIONAL',E'407040',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'046',E'CARTAO GUIDO',E'407046',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'051',E'BISTECK',E'407051',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'053',E'SUPERMERCADO PREÇO BOM',E'407053',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'085',E'INSINUANTE',E'407085',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'086',E'COLOMBO',E'407086',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'088',E'CARTAO UNIQUE',E'407088',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'089',E'POLISHOP',E'407089',E'LOSANGO VISA','1');
INSERT INTO ibi_cadastro_familia(org,logo,descricao,codbin,familia,priv_band) VALUES (E'407',E'090',E'LEROY MERLIN',E'407090',E'LOSANGO VISA','1');

COMMIT;

