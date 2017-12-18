-- Sequence: public.ibi_lote_id_seq

-- DROP SEQUENCE public.ibi_lote_id_seq;

CREATE SEQUENCE public.ibi_lote_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.ibi_lote_id_seq
  OWNER TO postgres;
GRANT ALL ON SEQUENCE public.ibi_lote_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ibi_lote_id_seq TO dbdevuser;

-- Table: public.lote

-- DROP TABLE public.lote;

CREATE TABLE public.lote
(
  id integer NOT NULL DEFAULT nextval('lote_id_seq'::regclass),
  codigo character varying(40) NOT NULL, -- Geralmente o codigo é o numero da LOEC
  qtde integer NOT NULL, -- Quantidade de objetos presentes na lista
  dt_devolucao date NOT NULL, -- Data presente na listagem que indica a data de retirada dos objetos
  dt_abertura timestamp without time zone NOT NULL DEFAULT now(), -- A hora em que o lote foi criado
  dt_fechamento timestamp without time zone, -- O momento em que o lote foi marcado como finalizado
  CONSTRAINT id_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lote
  OWNER TO postgres;
GRANT ALL ON TABLE public.lote TO postgres;
GRANT ALL ON TABLE public.lote TO dbdevuser;
COMMENT ON TABLE public.lote
  IS 'O Lote é uma delimitação de objetos a serem lidos e destruídos. É também conhecido como Caixa. Possui um documento onde há um número de LOEC (Lista de Objetos Entregues ao Carteiro) e respectivamente a lista com os objetos devolvidos. ';
COMMENT ON COLUMN public.lote.codigo IS 'Geralmente o codigo é o numero da LOEC';
COMMENT ON COLUMN public.lote.qtde IS 'Quantidade de objetos presentes na lista';
COMMENT ON COLUMN public.lote.dt_devolucao IS 'Data presente na listagem que indica a data de retirada dos objetos';
COMMENT ON COLUMN public.lote.dt_abertura IS 'A hora em que o lote foi criado';
COMMENT ON COLUMN public.lote.dt_fechamento IS 'O momento em que o lote foi marcado como finalizado';


-- Index: public."IX_LOTE_LOEC_01"

-- DROP INDEX public."IX_LOTE_LOEC_01";

CREATE UNIQUE INDEX "IX_LOTE_LOEC_01"
  ON public.lote
  USING btree (codigo);

-- ######################################################  

-- Table: public.ibi_controle_devolucoes_ar
ALTER TABLE public.ibi_controle_devolucoes_ar
  ADD COLUMN "lote_id" Integer;

-- Index: public."IX_DEVOLUCAO_LOTE_01"

-- DROP INDEX public."IX_DEVOLUCAO_LOTE_01";

CREATE INDEX "IX_DEVOLUCAO_LOTE_01"
  ON public.ibi_controle_devolucoes_ar
  USING btree (lote_id);

ALTER TABLE public.ibi_controle_devolucoes_ar
  ADD CONSTRAINT ibi_contrl_devol_ar_lote_fk FOREIGN KEY (lote_id)
    REFERENCES public.lote(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
	  
-- Trigger: ibi_controle_devolucoes_ar_check_ar on public.ibi_controle_devolucoes_ar

DROP TRIGGER ibi_controle_devolucoes_ar_check_ar ON public.ibi_controle_devolucoes_ar;

-- Index: public."IX_DEVOLUCAOCEA_NROCONTA_01"

-- DROP INDEX public."IX_DEVOLUCAOCEA_NROCONTA_01";

CREATE INDEX "IX_DEVOLUCAOCEA_NROCONTA_01"
  ON public.cea_controle_devolucoes
  USING btree (nro_conta);
COMMENT ON INDEX public."IX_DEVOLUCAOCEA_NROCONTA_01"
  IS 'Indice para o numero da conta';
  
-- Index: public."IX_DEVOLUCAOCEA_DTDEVOLUCAO_02"

-- DROP INDEX public."IX_DEVOLUCAOCEA_DTDEVOLUCAO_02";

CREATE INDEX "IX_DEVOLUCAOCEA_DTDEVOLUCAO_02"
  ON public.cea_controle_devolucoes
  USING btree (dt_devolucao);


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
BEGIN;
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
COMMIT	

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

COMMIT;