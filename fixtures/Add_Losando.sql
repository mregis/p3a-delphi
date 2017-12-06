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


ALTER TABLE public.lote  ADD COLUMN servico_id INTEGER DEFAULT 1 NOT NULL;
ALTER TABLE public.lote  ADD CONSTRAINT "FK_LOTE_SERVICO" FOREIGN KEY (servico_id)  REFERENCES public.servicos(id)  ON DELETE NO ACTION  ON UPDATE NO ACTION  NOT DEFERRABLE;