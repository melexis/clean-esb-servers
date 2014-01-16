--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: config; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE config (
    id integer NOT NULL,
    namespace character varying(50),
    filter character varying(50),
    config_key character varying(4096),
    config_value character varying(40960),
    deleted character(1),
    updated_by character varying(50),
    last_update timestamp without time zone
);


ALTER TABLE public.config OWNER TO ewafermap;

--
-- Name: config_old; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE config_old (
    id bigint NOT NULL,
    namespace bytea,
    filter character varying(255),
    key character varying(255),
    value character varying(8192),
    lastupdate timestamp without time zone,
    lastupdatedby character varying(255)
);


ALTER TABLE public.config_old OWNER TO ewafermap;

--
-- Name: confirm_lot_aggregation; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE confirm_lot_aggregation (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.confirm_lot_aggregation OWNER TO ewafermap;

--
-- Name: confirm_lot_aggregation_completed; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE confirm_lot_aggregation_completed (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.confirm_lot_aggregation_completed OWNER TO ewafermap;

--
-- Name: conti_confirmation_aggregation; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE conti_confirmation_aggregation (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.conti_confirmation_aggregation OWNER TO ewafermap;

--
-- Name: conti_confirmation_aggregation_completed; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE conti_confirmation_aggregation_completed (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.conti_confirmation_aggregation_completed OWNER TO ewafermap;

--
-- Name: dataschema_version; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE dataschema_version (
    version integer
);


ALTER TABLE public.dataschema_version OWNER TO ewafermap;

--
-- Name: event; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE event (
    id bigint NOT NULL,
    sessionid character varying(255),
    to_uri character varying(255),
    from_uri character varying(255),
    when_event timestamp without time zone,
    lot_id bigint
);


ALTER TABLE public.event OWNER TO ewafermap;

--
-- Name: ewaf_sequence; Type: SEQUENCE; Schema: public; Owner: ewafermap
--

CREATE SEQUENCE ewaf_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ewaf_sequence OWNER TO ewafermap;

--
-- Name: external_formats; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE external_formats (
    id bigint,
    wafermap_id bigint,
    format character varying(255),
    reference character varying(255)
);


ALTER TABLE public.external_formats OWNER TO ewafermap;

--
-- Name: external_formats_old; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE external_formats_old (
    wafermap_id bigint NOT NULL,
    wafermap character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.external_formats_old OWNER TO ewafermap;

--
-- Name: fill_postprocessing_collectionplan_aggregation; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE fill_postprocessing_collectionplan_aggregation (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.fill_postprocessing_collectionplan_aggregation OWNER TO ewafermap;

--
-- Name: fill_postprocessing_collectionplan_aggregation_completed; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE fill_postprocessing_collectionplan_aggregation_completed (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.fill_postprocessing_collectionplan_aggregation_completed OWNER TO ewafermap;

--
-- Name: fill_sawing_collectionplan_aggregation; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE fill_sawing_collectionplan_aggregation (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.fill_sawing_collectionplan_aggregation OWNER TO ewafermap;

--
-- Name: fill_sawing_collectionplan_aggregation_completed; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE fill_sawing_collectionplan_aggregation_completed (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.fill_sawing_collectionplan_aggregation_completed OWNER TO ewafermap;

--
-- Name: inkless_trigger; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE inkless_trigger (
    id bigint NOT NULL,
    lotname character varying(255),
    item character varying(255),
    organization character varying(255),
    probelocation character varying(255),
    partner character varying(255),
    date timestamp without time zone,
    wafer1 integer,
    wafer2 integer,
    wafer3 integer,
    wafer4 integer,
    wafer5 integer,
    wafer6 integer,
    wafer7 integer,
    wafer8 integer,
    wafer9 integer,
    wafer10 integer,
    wafer11 integer,
    wafer12 integer,
    wafer13 integer,
    wafer14 integer,
    wafer15 integer,
    wafer16 integer,
    wafer17 integer,
    wafer18 integer,
    wafer19 integer,
    wafer20 integer,
    wafer21 integer,
    wafer22 integer,
    wafer23 integer,
    wafer24 integer,
    wafer25 integer,
    triggeredby character varying(50)
);


ALTER TABLE public.inkless_trigger OWNER TO ewafermap;

--
-- Name: keyvalue; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE keyvalue (
    id bigint NOT NULL,
    key character varying(255),
    value bytea
);


ALTER TABLE public.keyvalue OWNER TO ewafermap;

--
-- Name: lot; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE lot (
    id bigint NOT NULL,
    name character varying(255),
    item character varying(255),
    organization character varying(255),
    probelocation character varying(255),
    subcontractor character varying(255),
    wafers_in_lot integer
);


ALTER TABLE public.lot OWNER TO ewafermap;

--
-- Name: lot_config; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE lot_config (
    id bigint,
    lot_id bigint,
    config_key character varying(255),
    config_value text
);


ALTER TABLE public.lot_config OWNER TO ewafermap;

--
-- Name: mfi_fill_postprocessing_collectionplan_aggregation; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE mfi_fill_postprocessing_collectionplan_aggregation (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.mfi_fill_postprocessing_collectionplan_aggregation OWNER TO ewafermap;

--
-- Name: mfi_fill_postprocessing_collectionplan_aggregation_completed; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE mfi_fill_postprocessing_collectionplan_aggregation_completed (
    id character varying(255) NOT NULL,
    exchange bytea NOT NULL
);


ALTER TABLE public.mfi_fill_postprocessing_collectionplan_aggregation_completed OWNER TO ewafermap;

--
-- Name: validationmessages; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE validationmessages (
    id bigint,
    wafer_id bigint,
    message character varying(2048)
);


ALTER TABLE public.validationmessages OWNER TO ewafermap;

--
-- Name: validationmessages_old; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE validationmessages_old (
    wafer_id bigint NOT NULL,
    message character varying(255)
);


ALTER TABLE public.validationmessages_old OWNER TO ewafermap;

--
-- Name: wafer; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE wafer (
    id bigint NOT NULL,
    wafernumber integer,
    passdies integer,
    lot_id bigint
);


ALTER TABLE public.wafer OWNER TO ewafermap;

--
-- Name: wafer_property; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE wafer_property (
    id bigint,
    wafer_id bigint,
    property_key character varying(255),
    property_value text
);


ALTER TABLE public.wafer_property OWNER TO ewafermap;

--
-- Name: wafermap; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE wafermap (
    id bigint NOT NULL,
    name character varying(255),
    th01 character varying(255),
    wafer_id bigint
);


ALTER TABLE public.wafermap OWNER TO ewafermap;

--
-- Name: wafermap_transfer; Type: TABLE; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE TABLE wafermap_transfer (
    id bigint NOT NULL,
    lot_id bigint,
    sent_date timestamp without time zone,
    confirmed_date timestamp without time zone,
    checksum character varying(50)
);


ALTER TABLE public.wafermap_transfer OWNER TO ewafermap;

--
-- Name: config_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY config_old
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


--
-- Name: confirm_lot_aggregation_completed_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY confirm_lot_aggregation_completed
    ADD CONSTRAINT confirm_lot_aggregation_completed_pkey PRIMARY KEY (id);


--
-- Name: confirm_lot_aggregation_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY confirm_lot_aggregation
    ADD CONSTRAINT confirm_lot_aggregation_pkey PRIMARY KEY (id);


--
-- Name: conti_confirmation_aggregation_completed_pk; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY conti_confirmation_aggregation_completed
    ADD CONSTRAINT conti_confirmation_aggregation_completed_pk PRIMARY KEY (id);


--
-- Name: conti_confirmation_aggregation_pk; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY conti_confirmation_aggregation
    ADD CONSTRAINT conti_confirmation_aggregation_pk PRIMARY KEY (id);


--
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: external_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY external_formats_old
    ADD CONSTRAINT external_formats_pkey PRIMARY KEY (wafermap_id, name);


--
-- Name: fill_postprocessing_collectionplan_aggregation_completed_pk; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY fill_postprocessing_collectionplan_aggregation_completed
    ADD CONSTRAINT fill_postprocessing_collectionplan_aggregation_completed_pk PRIMARY KEY (id);


--
-- Name: fill_postprocessing_collectionplan_aggregation_pk; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY fill_postprocessing_collectionplan_aggregation
    ADD CONSTRAINT fill_postprocessing_collectionplan_aggregation_pk PRIMARY KEY (id);


--
-- Name: fill_sawing_collectionplan_aggregation_completed_pk; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY fill_sawing_collectionplan_aggregation_completed
    ADD CONSTRAINT fill_sawing_collectionplan_aggregation_completed_pk PRIMARY KEY (id);


--
-- Name: fill_sawing_collectionplan_collectionplan_aggregation_pk; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY fill_sawing_collectionplan_aggregation
    ADD CONSTRAINT fill_sawing_collectionplan_collectionplan_aggregation_pk PRIMARY KEY (id);


--
-- Name: inkless_trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY inkless_trigger
    ADD CONSTRAINT inkless_trigger_pkey PRIMARY KEY (id);


--
-- Name: keyvalue_key_key; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY keyvalue
    ADD CONSTRAINT keyvalue_key_key UNIQUE (key);


--
-- Name: keyvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY keyvalue
    ADD CONSTRAINT keyvalue_pkey PRIMARY KEY (id);


--
-- Name: lot_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY lot
    ADD CONSTRAINT lot_pkey PRIMARY KEY (id);


--
-- Name: mfi_fill_postprocessing_collectionplan_aggregation_complet_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY mfi_fill_postprocessing_collectionplan_aggregation_completed
    ADD CONSTRAINT mfi_fill_postprocessing_collectionplan_aggregation_complet_pkey PRIMARY KEY (id);


--
-- Name: mfi_fill_postprocessing_collectionplan_aggregation_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY mfi_fill_postprocessing_collectionplan_aggregation
    ADD CONSTRAINT mfi_fill_postprocessing_collectionplan_aggregation_pkey PRIMARY KEY (id);


--
-- Name: pk_config; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY config
    ADD CONSTRAINT pk_config PRIMARY KEY (id);


--
-- Name: wafer_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY wafer
    ADD CONSTRAINT wafer_pkey PRIMARY KEY (id);


--
-- Name: wafermap_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY wafermap
    ADD CONSTRAINT wafermap_pkey PRIMARY KEY (id);


--
-- Name: wafermap_transfer_pkey; Type: CONSTRAINT; Schema: public; Owner: ewafermap; Tablespace: 
--

ALTER TABLE ONLY wafermap_transfer
    ADD CONSTRAINT wafermap_transfer_pkey PRIMARY KEY (id);


--
-- Name: idx_wafer_property_key_value; Type: INDEX; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE INDEX idx_wafer_property_key_value ON wafer_property USING btree (property_key, property_value);


--
-- Name: idx_wafermap_transfer_checksum; Type: INDEX; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE INDEX idx_wafermap_transfer_checksum ON wafermap_transfer USING btree (checksum);


--
-- Name: idx_wafermap_transfer_confirmed_date; Type: INDEX; Schema: public; Owner: ewafermap; Tablespace: 
--

CREATE INDEX idx_wafermap_transfer_confirmed_date ON wafermap_transfer USING btree (confirmed_date);


--
-- Name: fk5c6729a2c46134; Type: FK CONSTRAINT; Schema: public; Owner: ewafermap
--

ALTER TABLE ONLY event
    ADD CONSTRAINT fk5c6729a2c46134 FOREIGN KEY (lot_id) REFERENCES lot(id);


--
-- Name: fk6ba90892c46134; Type: FK CONSTRAINT; Schema: public; Owner: ewafermap
--

ALTER TABLE ONLY wafer
    ADD CONSTRAINT fk6ba90892c46134 FOREIGN KEY (lot_id) REFERENCES lot(id);


--
-- Name: fk77d916e8c4da4400; Type: FK CONSTRAINT; Schema: public; Owner: ewafermap
--

ALTER TABLE ONLY external_formats_old
    ADD CONSTRAINT fk77d916e8c4da4400 FOREIGN KEY (wafermap_id) REFERENCES wafermap(id);


--
-- Name: fk8bb5c33de4fd7b4; Type: FK CONSTRAINT; Schema: public; Owner: ewafermap
--

ALTER TABLE ONLY wafermap
    ADD CONSTRAINT fk8bb5c33de4fd7b4 FOREIGN KEY (wafer_id) REFERENCES wafer(id);


--
-- Name: fkde6cc0c5de4fd7b4; Type: FK CONSTRAINT; Schema: public; Owner: ewafermap
--

ALTER TABLE ONLY validationmessages_old
    ADD CONSTRAINT fkde6cc0c5de4fd7b4 FOREIGN KEY (wafer_id) REFERENCES wafer(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

