--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

SET default_table_access_method = heap;

--
-- Name: material_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.material_types OWNER TO postgres;

--
-- Name: material_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.material_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.material_types_id_seq OWNER TO postgres;

--
-- Name: material_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.material_types_id_seq OWNED BY public.material_types.id;


--
-- Name: materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materials (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    material_type_id integer,
    image_path character varying(500),
    price numeric(10,2),
    quantity integer DEFAULT 0,
    min_quantity integer DEFAULT 0,
    package_quantity integer DEFAULT 1,
    unit character varying(20) DEFAULT 'шт.'::character varying
);


ALTER TABLE public.materials OWNER TO postgres;

--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materials_id_seq OWNER TO postgres;

--
-- Name: materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.materials_id_seq OWNED BY public.materials.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(50),
    inn character varying(20),
    rating integer,
    start_date character varying(20)
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    fio character varying(255) NOT NULL,
    role_id integer DEFAULT 1
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: material_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_types ALTER COLUMN id SET DEFAULT nextval('public.material_types_id_seq'::regclass);


--
-- Name: materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials ALTER COLUMN id SET DEFAULT nextval('public.materials_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: material_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.material_types (id, name) FROM stdin;
1	Гранулы
2	Краски
3	Нитки
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.materials (id, name, material_type_id, image_path, price, quantity, min_quantity, package_quantity, unit) FROM stdin;
1	Гранулы белый 2x2	1		47680.00	76	8	7	л
2	Нить серый 1x0	2		27456.00	978	42	1	м
3	Нить белый 1x3	3		2191.00	406	27	8	м
4	Нить цветной 1x1	2	\\materials\\image_5.jpeg	8619.00	424	10	3	г
5	Нить цветной 2x0	2		16856.00	395	26	2	м
6	Краска синий 2x2	2		403.00	334	48	6	л
7	Нить синий 0x2	3		7490.00	654	10	9	м
8	Гранулы серый 2x2	1		15478.00	648	17	7	л
9	Краска синий 1x2	2		44490.00	640	50	2	л
10	Нить зеленый 2x0	2	\\materials\\image_10.jpeg	28301.00	535	45	5	м
11	Гранулы синий 1x2	1		9242.00	680	6	3	кг
12	Нить синий 3x2	3		10878.00	529	13	1	м
13	Краска белый 2x2	2	\\materials\\image_3.jpeg	29906.00	659	35	1	л
14	Краска зеленый 0x3	2		24073.00	50	48	2	л
15	Нить зеленый 2x3	3		20057.00	649	25	7	г
16	Краска белый 2x1	2		3353.00	790	8	2	л
17	Нить серый 2x3	3		22452.00	431	40	1	г
18	Гранулы серый 3x2	1		29943.00	96	9	5	л
19	Краска серый 3x2	2		55064.00	806	50	3	л
20	Гранулы белый 0x3	1		7183.00	538	11	3	кг
21	Краска цветной 1x1	2		43466.00	784	22	3	л
22	Гранулы белый 1x0	1		27718.00	980	41	3	кг
23	Краска серый 0x2	2		33227.00	679	36	3	кг
24	Гранулы серый 3x3	1		15170.00	2	38	5	л
25	Краска серый 3x0	2		19352.00	341	38	7	кг
26	Гранулы синий 2x1	1	\\materials\\image_2.jpeg	231.00	273	17	9	л
27	Гранулы синий 0x2	1		41646.00	576	36	9	л
28	Нить цветной 1x0	3		24948.00	91	38	5	г
29	Краска зеленый 2x2	2		19014.00	752	36	2	кг
30	Краска цветной 1x3	2		268.00	730	5	9	кг
31	Краска серый 2x0	2		35256.00	131	22	2	л
32	Нить зеленый 2x1	3		34556.00	802	16	6	м
33	Краска цветной 0x3	2		3322.00	324	9	10	л
34	Нить белый 2x3	3		10823.00	283	41	3	г
35	Гранулы синий 3x0	1		16665.00	411	8	1	кг
36	Гранулы синий 1x3	1		5668.00	41	30	8	л
37	Нить цветной 2x1	2		7615.00	150	22	3	м
38	Гранулы серый 3x0	1	\\materials\\image_7.jpeg	702.00	0	5	4	л
39	Краска синий 3x0	2		38644.00	523	42	7	л
40	Нить зеленый 0x0	2		41827.00	288	43	8	м
41	Гранулы белый 1x2	1		8129.00	77	46	4	л
42	Краска белый 3x0	2		51471.00	609	48	5	кг
43	Краска цветной 0x1	2		54401.00	43	8	6	л
44	Нить серый 1x1	3		14474.00	372	22	5	м
45	Краска синий 2x1	2		46848.00	642	29	9	л
46	Нить серый 3x0	3		29503.00	409	19	1	м
47	Краска зеленый 3x3	2		27710.00	601	32	6	л
48	Краска синий 2x0	2		40074.00	135	50	7	л
49	Гранулы синий 2x3	1		53482.00	749	45	2	л
50	Нить синий 0x3	2		32087.00	615	22	8	м
51	Нить синий 3x3	3		45774.00	140	12	7	г
52	Краска зеленый 2x3	2		44978.00	485	8	2	л
53	Нить синий 3x0	3		44407.00	67	23	10	м
54	Гранулы серый 2x1	1		50339.00	779	44	7	кг
55	Краска зеленый 0x1	2		30581.00	869	7	2	л
56	Краска синий 0x0	2		18656.00	796	29	8	кг
57	Краска серый 2x1	2		46579.00	706	45	5	л
58	Нить белый 0x1	3		36883.00	101	43	10	м
59	Гранулы зеленый 1x2	1		45083.00	575	15	9	л
60	Краска серый 0x1	2		35063.00	768	27	2	л
61	Гранулы цветной 0x1	1		24488.00	746	50	3	л
62	Гранулы белый 3x1	1		43711.00	995	27	8	л
63	Нить зеленый 0x2	3		17429.00	578	20	2	м
64	Гранулы зеленый 0x2	1		38217.00	206	34	4	л
65	Краска цветной 1x2	2		47701.00	299	50	10	л
66	Краска зеленый 1x0	2		52189.00	626	17	8	кг
67	Гранулы серый 0x0	1		16715.00	608	12	5	л
68	Гранулы синий 0x3	1		45134.00	953	48	5	кг
69	Краска цветной 2x1	2		1846.00	325	45	1	л
70	Нить синий 2x3	2		43659.00	10	21	5	м
71	Нить синий 2x1	2		12283.00	948	13	9	г
72	Гранулы белый 1x1	1		6557.00	93	11	4	л
73	Краска синий 1x3	2		38230.00	265	17	6	кг
74	Краска зеленый 3x0	2	\\materials\\image_1.jpeg	20226.00	261	7	2	л
75	Нить зеленый 1x0	3		8105.00	304	43	9	г
76	Краска цветной 0x2	2		2600.00	595	38	7	л
77	Нить синий 3x1	2		4920.00	579	48	7	м
78	Краска зеленый 0x2	2		39809.00	139	23	9	л
79	Краска синий 3x3	2		46545.00	740	24	6	кг
80	Краска зеленый 1x1	2	\\materials\\image_6.jpeg	40583.00	103	34	2	кг
81	Краска цветной 2x3	2		46502.00	443	46	9	л
82	Нить цветной 3x0	3		53651.00	989	14	1	м
83	Гранулы серый 2x3	1		47757.00	467	28	6	л
84	Краска белый 1x0	2		3543.00	95	6	6	л
85	Гранулы серый 3x1	1		10899.00	762	6	10	кг
86	Гранулы серый 2x0	1	\\materials\\image_8.jpeg	8939.00	312	21	3	кг
87	Нить белый 0x2	3		29271.00	43	19	4	г
88	Гранулы зеленый 1x1	1	\\materials\\image_4.jpeg	46455.00	10	19	4	л
89	Нить серый 0x2	2	\\materials\\image_9.jpeg	45744.00	504	10	3	м
90	Гранулы белый 0x2	1		9330.00	581	40	2	л
91	Нить цветной 3x2	3		2939.00	831	46	3	м
92	Гранулы белый 3x0	1		50217.00	208	7	6	л
93	Нить серый 1x2	3		30198.00	292	30	1	м
94	Краска белый 0x1	2		19777.00	423	47	7	л
95	Гранулы цветной 0x3	1		1209.00	723	44	7	кг
96	Нить серый 1x3	2		32002.00	489	25	1	г
97	Гранулы белый 2x3	1		32446.00	274	8	4	л
98	Краска зеленый 3x1	2		32487.00	657	19	10	л
99	Гранулы цветной 3x2	1		28596.00	32	45	1	л
100	Нить белый 2x0	2		46684.00	623	23	2	м
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name, type, inn, rating, start_date) FROM stdin;
51	ГаражТелекомГор	МКК	1718185951	36	20.12.2011
52	Компания Омск	ОАО	1878504395	2	2012-09-13
53	ГорМонтаж	ООО	1564667734	79	23 декабря 2016 г.
54	Микро	МКК	2293562756	64	2019-05-27
55	Электро	ЗАО	1755853973	14	16.06.2015
56	Компания Мотор	ООО	1429908355	50	27 декабря 2010 г.
57	Асбоцем	МФО	1944834477	20	10.04.2011
58	ВостокМети	ООО	1488487851	58	13 марта 2012 г.
59	МясКрепТеле	ПАО	2152486844	59	11 ноября 2018
60	Софт	МКК	1036521658	67	23 ноября 2011
61	Компания СервисМикроО	ООО	1178826599	5	2012-07-07
62	ИнфоГазМотор	ОАО	1954050214	42	2011-07-23
63	Монтаж	ОАО	1163880101	10	2016-05-23
64	ЭлектроЦвет	ОАО	1654184411	3	25 июня 2015 г.
65	Компания НефтьITИнф	ООО	1685247455	85	09 марта 2017
66	ТомскНефть	ООО	1002996016	95	07 мая 2015
67	ТомскТяжРеч	МФО	1102143492	36	22.12.2014
68	УралХме	ООО	2291253256	82	22 мая 2015 г.
69	ВодРыб	ЗАО	1113468466	21	25 ноября 2011
70	УралСервисМон	МКК	1892306757	26	20.12.2016
71	Казань	ОАО	1965011544	51	16.03.2015
72	Cиб	ОАО	1949139718	95	28.11.2011
73	ГаражГазМ	ОАО	1740623312	86	20 ноября 2011
74	МобайлДизайнОмск	ООО	1014490629	73	28 октября 2019
75	ЖелДорГаз	МФО	1255275062	76	04.09.2014
76	ТверьБухГаз	ОАО	2167673760	9	13.11.2013
77	ТелекомТранс	ОАО	2200735978	8	11 января 2015 г.
78	ГаражГлав	МКК	1404774111	89	28 июня 2013
79	Компания К	ПАО	1468114280	70	7 декабря 2018 г.
80	ТяжЛифтВостокС	ОАО	1032089879	66	2012-08-13
81	Компания Во	ПАО	2027005945	11	22.06.2016
82	МоторКаз	ОАО	1076279398	37	23 августа 2015 г.
83	Сервис	ОАО	2031832854	25	25.11.2011
84	ЮпитерТомс	ПАО	1551173338	60	28.07.2011
85	Мор	МКК	1906157177	82	06.03.2011
86	СеверТехВостокЛизинг	ООО	1846812080	30	26 февраля 2011 г.
87	ЦементОбл	ООО	2021607106	42	03 октября 2015
88	Компания КазаньАвтоCиб	МКК	1371692583	23	19.10.2015
89	ГаражХозФлот	ОАО	2164720385	7	28 августа 2018 г.
90	Компания МорМетал	ООО	1947163072	33	18.11.2013
91	ГлавРыб	МФО	1426268088	46	2018-11-09
92	CибCибОрио	ООО	1988313615	95	2018-01-13
93	ТелеРыбХм	ООО	2299034130	3	10 февраля 2012
94	ГлавАвтоГазТрест	МФО	2059691335	18	2014-08-04
95	ТяжКазаньБашкир	ПАО	1794419510	85	2015-12-22
96	Асбоцемент	МФО	1650212184	80	09 декабря 2018
97	Мотор	ПАО	1019917089	19	24.04.2017
98	МорФинансФинансМаш	ООО	1549496316	68	18 июня 2013 г.
99	РыбВектор	ОАО	2275526397	92	20.06.2011
100	Теле	ПАО	2170198203	11	01.05.2010
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, login, password, fio, role_id) FROM stdin;
1	admin	admin	Администратор	4
\.


--
-- Name: material_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.material_types_id_seq', 3, true);


--
-- Name: materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.materials_id_seq', 100, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 100, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: material_types material_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_types
    ADD CONSTRAINT material_types_pkey PRIMARY KEY (id);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: materials materials_material_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_material_type_id_fkey FOREIGN KEY (material_type_id) REFERENCES public.material_types(id);


--
-- PostgreSQL database dump complete
--

