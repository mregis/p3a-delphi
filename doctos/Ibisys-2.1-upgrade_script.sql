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
  codigo character varying(40) NOT NULL, -- Geralmente o codigo � o numero da LOEC
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
  IS 'O Lote � uma delimita��o de objetos a serem lidos e destru�dos. � tamb�m conhecido como Caixa. Possui um documento onde h� um n�mero de LOEC (Lista de Objetos Entregues ao Carteiro) e respectivamente a lista com os objetos devolvidos. ';
COMMENT ON COLUMN public.lote.codigo IS 'Geralmente o codigo � o numero da LOEC';
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
  