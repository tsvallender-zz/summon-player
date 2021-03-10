SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ad_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ad_tags (
    id bigint NOT NULL,
    ad_id integer,
    tag_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ad_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ad_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ad_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ad_tags_id_seq OWNED BY public.ad_tags.id;


--
-- Name: ads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ads (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    title character varying,
    text character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category_id bigint NOT NULL
);


--
-- Name: ads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ads_id_seq OWNED BY public.ads.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    stub character varying
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    username character varying NOT NULL,
    description text
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ad_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ad_tags ALTER COLUMN id SET DEFAULT nextval('public.ad_tags_id_seq'::regclass);


--
-- Name: ads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public.ads_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ad_tags ad_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ad_tags
    ADD CONSTRAINT ad_tags_pkey PRIMARY KEY (id);


--
-- Name: ads ads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_ad_tags_on_ad_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ad_tags_on_ad_id ON public.ad_tags USING btree (ad_id);


--
-- Name: index_ad_tags_on_ad_id_and_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_ad_tags_on_ad_id_and_tag_id ON public.ad_tags USING btree (ad_id, tag_id);


--
-- Name: index_ad_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ad_tags_on_tag_id ON public.ad_tags USING btree (tag_id);


--
-- Name: index_ads_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ads_on_category_id ON public.ads USING btree (category_id);


--
-- Name: index_ads_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ads_on_user_id ON public.ads USING btree (user_id);


--
-- Name: index_ads_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ads_on_user_id_and_created_at ON public.ads USING btree (user_id, created_at);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON public.users USING btree (username);


--
-- Name: ads fk_rails_400d8fa7ce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_rails_400d8fa7ce FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: ads fk_rails_b1934989b5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_rails_b1934989b5 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210124121829'),
('20210209113309'),
('20210209123115'),
('20210221175428'),
('20210308093511'),
('20210308102556'),
('20210310094905'),
('20210310095008'),
('20210310114338');


