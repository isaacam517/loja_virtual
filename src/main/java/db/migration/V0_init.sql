--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.25
-- Dumped by pg_dump version 9.5.25

-- Started on 2024-04-12 11:09:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2345 (class 1262 OID 634883)
-- Name: loja_virtual; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE loja_virtual WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese_Brazil.1252' LC_CTYPE = 'Portuguese_Brazil.1252';


ALTER DATABASE loja_virtual OWNER TO postgres;

\connect loja_virtual

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 221 (class 1255 OID 769743)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

BEGIN
	existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_id);
	if(existe <= 0) then
		existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_id);
	if(existe <= 0) then
		raise exception 'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
	end if;	
	end if;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 769755)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

BEGIN
	existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_forn_id);
	if(existe <= 0) then
		existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_forn_id);
	if(existe <= 0) then
		raise exception 'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
	end if;	
	end if;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 634884)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 769569)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 634889)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria_produto (
    id bigint NOT NULL,
    nome_descricao character varying(255) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 635010)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_pagar (
    id bigint NOT NULL,
    dt_pagamento date,
    valor_desconto numeric(19,2),
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_vencimento date,
    status character varying(255),
    valor_total numeric(19,2) NOT NULL
);


ALTER TABLE public.conta_pagar OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 634993)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_receber (
    id bigint NOT NULL,
    dt_pagamento date,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2),
    pessoa_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL
);


ALTER TABLE public.conta_receber OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 769610)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cup_desc (
    id bigint NOT NULL,
    cod_desc character varying(255) NOT NULL,
    data_validade_cupom date NOT NULL,
    valor_porcent_desc numeric(19,2),
    valor_real_desc numeric(19,2)
);


ALTER TABLE public.cup_desc OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 769579)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logra character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 635003)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 769597)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 769531)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venda_loja (
    id bigint NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virtu_id bigint NOT NULL,
    quantidade double precision NOT NULL
);


ALTER TABLE public.item_venda_loja OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 634902)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca_produto (
    id bigint NOT NULL,
    nome_descricao character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 769620)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_icms numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 769638)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 700458)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_item_produto (
    id bigint NOT NULL,
    produto_id bigint NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    quantidade double precision NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 634907)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_fisica (
    id bigint NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_fisica OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 769561)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_juridica (
    id bigint NOT NULL,
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 769657)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    alerta_qtd_de_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtd_alerta_estoque integer,
    qtd_de_clique integer,
    qtd_estoque integer NOT NULL,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(19,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 634938)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acesso OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 769554)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avaliacao_produto OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 634940)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria_produto OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 635018)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_pagar OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 635001)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_receber OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 700416)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cup_desc OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 634942)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_endereco OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 635008)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forma_pagamento OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 700434)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagem_produto OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 769536)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_venda_loja OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 634944)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marca_produto OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 700451)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 769487)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 700463)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_item_produto OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 634946)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 700436)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_produto OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 769477)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status_rastreio OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 634948)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 769494)
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 769469)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 769685)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 634931)
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usuarios_acesso OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 769698)
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vd_cp_loja_virt (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(19,2),
    valor_fret numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    cupom_desc_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 2300 (class 0 OID 634884)
-- Dependencies: 181
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2331 (class 0 OID 769569)
-- Dependencies: 212
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.avaliacao_produto (id, descricao, nota, pessoa_id, produto_id) VALUES (4, 'teste avaliação produto trigger', 10, 1, 1);
INSERT INTO public.avaliacao_produto (id, descricao, nota, pessoa_id, produto_id) VALUES (5, 'teste avaliação produto trigger', 10, 1, 1);


--
-- TOC entry 2301 (class 0 OID 634889)
-- Dependencies: 182
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2315 (class 0 OID 635010)
-- Dependencies: 196
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2311 (class 0 OID 634993)
-- Dependencies: 192
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2334 (class 0 OID 769610)
-- Dependencies: 215
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2332 (class 0 OID 769579)
-- Dependencies: 213
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2313 (class 0 OID 635003)
-- Dependencies: 194
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2333 (class 0 OID 769597)
-- Dependencies: 214
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2327 (class 0 OID 769531)
-- Dependencies: 208
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2302 (class 0 OID 634902)
-- Dependencies: 183
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2335 (class 0 OID 769620)
-- Dependencies: 216
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2336 (class 0 OID 769638)
-- Dependencies: 217
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2321 (class 0 OID 700458)
-- Dependencies: 202
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2303 (class 0 OID 634907)
-- Dependencies: 184
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pessoa_fisica (id, cpf, data_nascimento, email, nome, telefone) VALUES (1, '01466817461', '1988-07-23', 'isaacam517@gmail.com', 'isaac martiniano', '81995073317');


--
-- TOC entry 2330 (class 0 OID 769561)
-- Dependencies: 211
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2337 (class 0 OID 769657)
-- Dependencies: 218
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produto (id, alerta_qtd_de_estoque, altura, ativo, descricao, largura, link_youtube, nome, peso, profundidade, qtd_alerta_estoque, qtd_de_clique, qtd_estoque, tipo_unidade, valor_venda) VALUES (1, true, 10, true, 'produto teste', 50.200000000000003, 'asddsadsd', 'nome produto teste', 50, 80, 1, 50, 22, 'UN', 50.00);


--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 186
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 210
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto', 1, false);


--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 187
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 197
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_conta_pagar', 1, false);


--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 193
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_conta_receber', 1, false);


--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 198
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cup_desc', 1, false);


--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 188
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 195
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_forma_pagamento', 1, false);


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 199
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 209
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_item_venda_loja', 1, false);


--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 189
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_marca_produto', 1, false);


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 201
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 206
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_venda', 1, false);


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 203
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_item_produto', 1, false);


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 190
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 200
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 205
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_status_rastreio', 1, false);


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 191
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 207
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_vd_cp_loja_virt', 1, false);


--
-- TOC entry 2323 (class 0 OID 769469)
-- Dependencies: 204
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2338 (class 0 OID 769685)
-- Dependencies: 219
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2304 (class 0 OID 634931)
-- Dependencies: 185
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2339 (class 0 OID 769698)
-- Dependencies: 220
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2111 (class 2606 OID 634888)
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2137 (class 2606 OID 769573)
-- Name: avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2113 (class 2606 OID 634893)
-- Name: categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2127 (class 2606 OID 635017)
-- Name: conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 2123 (class 2606 OID 635000)
-- Name: conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 2143 (class 2606 OID 769614)
-- Name: cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 2139 (class 2606 OID 769586)
-- Name: endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 2125 (class 2606 OID 635007)
-- Name: forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2141 (class 2606 OID 769604)
-- Name: imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2133 (class 2606 OID 769535)
-- Name: item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 2115 (class 2606 OID 634906)
-- Name: marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2145 (class 2606 OID 769627)
-- Name: nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 2147 (class 2606 OID 769645)
-- Name: nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 2129 (class 2606 OID 700462)
-- Name: nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2117 (class 2606 OID 634914)
-- Name: pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 769568)
-- Name: pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 2149 (class 2606 OID 769664)
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2131 (class 2606 OID 769476)
-- Name: status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 2119 (class 2606 OID 634969)
-- Name: uk_8bak9jswon2id2jbunuqlfl9e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT uk_8bak9jswon2id2jbunuqlfl9e UNIQUE (acesso_id);


--
-- TOC entry 2121 (class 2606 OID 634937)
-- Name: unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 2151 (class 2606 OID 769692)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2153 (class 2606 OID 769702)
-- Name: vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 2170 (class 2620 OID 769758)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.conta_receber FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2178 (class 2620 OID 769764)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2180 (class 2620 OID 769766)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2182 (class 2620 OID 769768)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2184 (class 2620 OID 769771)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2171 (class 2620 OID 769763)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.conta_receber FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2179 (class 2620 OID 769765)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2181 (class 2620 OID 769767)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2183 (class 2620 OID 769770)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2185 (class 2620 OID 769772)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2176 (class 2620 OID 769744)
-- Name: validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2177 (class 2620 OID 769749)
-- Name: validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2172 (class 2620 OID 769753)
-- Name: validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2173 (class 2620 OID 769754)
-- Name: validachavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2174 (class 2620 OID 769756)
-- Name: validachavepessoacontapagarpessoafornid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoafornid BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa2();


--
-- TOC entry 2175 (class 2620 OID 769757)
-- Name: validachavepessoacontapagarpessoafornid2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoafornid2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa2();


--
-- TOC entry 2154 (class 2606 OID 634950)
-- Name: acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 2163 (class 2606 OID 769628)
-- Name: conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 2165 (class 2606 OID 769718)
-- Name: cupom_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT cupom_desc_fk FOREIGN KEY (cupom_desc_id) REFERENCES public.cup_desc(id);


--
-- TOC entry 2166 (class 2606 OID 769723)
-- Name: endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 2167 (class 2606 OID 769728)
-- Name: endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 2168 (class 2606 OID 769733)
-- Name: forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 2156 (class 2606 OID 769633)
-- Name: nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 2169 (class 2606 OID 769738)
-- Name: nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 2161 (class 2606 OID 769665)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 2162 (class 2606 OID 769670)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 2159 (class 2606 OID 769675)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 2157 (class 2606 OID 769680)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 2155 (class 2606 OID 769693)
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 2164 (class 2606 OID 769708)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 2158 (class 2606 OID 769713)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 2160 (class 2606 OID 769703)
-- Name: venda_compraloja_virtu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT venda_compraloja_virtu_fk FOREIGN KEY (venda_compra_loja_virtu_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-04-12 11:09:57

--
-- PostgreSQL database dump complete
--

