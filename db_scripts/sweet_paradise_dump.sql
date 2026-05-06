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
-- Name: cake_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cake_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.cake_types OWNER TO postgres;

--
-- Name: cake_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cake_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cake_types_id_seq OWNER TO postgres;

--
-- Name: cake_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cake_types_id_seq OWNED BY public.cake_types.id;


--
-- Name: cakes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cakes (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    category_id integer,
    cake_type_id integer,
    description text,
    confectionery_id integer,
    supplier_id integer,
    price numeric(10,2) NOT NULL,
    unit character varying(20) DEFAULT 'шт.'::character varying,
    quantity_in_stock integer DEFAULT 0,
    discount numeric(5,2) DEFAULT 0,
    image_path character varying(500),
    CONSTRAINT cakes_discount_check CHECK (((discount >= (0)::numeric) AND (discount <= (100)::numeric))),
    CONSTRAINT cakes_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT cakes_quantity_in_stock_check CHECK ((quantity_in_stock >= 0))
);


ALTER TABLE public.cakes OWNER TO postgres;

--
-- Name: cakes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cakes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cakes_id_seq OWNER TO postgres;

--
-- Name: cakes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cakes_id_seq OWNED BY public.cakes.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: confectioneries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.confectioneries (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255),
    phone character varying(20)
);


ALTER TABLE public.confectioneries OWNER TO postgres;

--
-- Name: confectioneries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.confectioneries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confectioneries_id_seq OWNER TO postgres;

--
-- Name: confectioneries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.confectioneries_id_seq OWNED BY public.confectioneries.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    cake_id integer,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_statuses_id_seq OWNER TO postgres;

--
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_statuses_id_seq OWNED BY public.order_statuses.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer,
    status_id integer DEFAULT 1,
    pickup_point_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    delivery_date date,
    total_amount numeric(10,2) DEFAULT 0
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    address character varying(255) NOT NULL,
    working_hours character varying(100)
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- Name: pickup_points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pickup_points_id_seq OWNER TO postgres;

--
-- Name: pickup_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact_info text
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
-- Name: cake_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cake_types ALTER COLUMN id SET DEFAULT nextval('public.cake_types_id_seq'::regclass);


--
-- Name: cakes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cakes ALTER COLUMN id SET DEFAULT nextval('public.cakes_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: confectioneries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confectioneries ALTER COLUMN id SET DEFAULT nextval('public.confectioneries_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: order_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses ALTER COLUMN id SET DEFAULT nextval('public.order_statuses_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: pickup_points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points ALTER COLUMN id SET DEFAULT nextval('public.pickup_points_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cake_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cake_types (id, name) FROM stdin;
18	Праздничный
19	День рождения
20	Любой повод
21	Юбилей
22	Для него
23	Летний, Свадьба
24	Праздничный
25	Детский праздник
26	Для нее
27	Здоровое питание
28	Фуршет, Кофе-брейк
29	Свадьба
30	Детский праздник
31	Для взрослых
32	Свадебный
33	Романтический ужин
34	Чайный стол
35	Весенний праздник
36	Праздничный
37	Для аллергиков
38	Праздничный
39	День рождения
40	Любой повод
41	Юбилей
42	Для него
43	Летний, Свадьба
44	Праздничный
45	Детский праздник
46	Для нее
47	Здоровое питание
48	Фуршет, Кофе-брейк
49	Свадьба
50	Детский праздник
51	Для взрослых
52	Свадебный
53	Романтический ужин
54	Чайный стол
55	Весенний праздник
56	Праздничный
57	Для аллергиков
58	Праздничный
59	День рождения
60	Любой повод
61	Юбилей
62	Для него
63	Летний, Свадьба
64	Праздничный
65	Детский праздник
66	Для нее
67	Здоровое питание
68	Фуршет, Кофе-брейк
69	Свадьба
70	Детский праздник
71	Для взрослых
72	Свадебный
73	Романтический ужин
74	Чайный стол
75	Весенний праздник
76	Праздничный
77	Для аллергиков
78	Праздничный
79	День рождения
80	Любой повод
81	Юбилей
82	Для него
83	Летний, Свадьба
84	Праздничный
85	Детский праздник
86	Для нее
87	Здоровое питание
88	Фуршет, Кофе-брейк
89	Свадьба
90	Детский праздник
91	Для взрослых
92	Свадебный
93	Романтический ужин
94	Чайный стол
95	Весенний праздник
96	Праздничный
97	Для аллергиков
\.


--
-- Data for Name: cakes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cakes (id, name, category_id, cake_type_id, description, confectionery_id, supplier_id, price, unit, quantity_in_stock, discount, image_path) FROM stdin;
24	Наполеон	\N	\N	Классический торт "Наполеон" с заварным кремом и слоеными коржами, 2 кг	\N	2	2190.00	шт.	8	5.00	images/napoleon.jpg
25	Красный бархат	\N	\N	Яркий бисквит с какао и сливочно-сырным кремом "Чизкейк", 1.8 кг	\N	2	3244.00	шт.	13	2.00	images/red_velvet.jpg
26	Медовик	\N	\N	Нежный торт с медовыми коржами и сметанным кремом, 2 кг	\N	2	4499.00	шт.	5	4.00	images/medovik.jpg
27	Птичье молоко	\N	\N	Воздушное суфле на агар-агаре и шоколадная глазурь по ГОСТу, 1.5 кг	\N	2	3900.00	шт.	8	2.00	images/ptichye_moloko.jpg
28	Трюфельный	\N	\N	Шоколадный торт с нежным муссом и карамельной прослойкой, 1.7 кг	\N	2	3800.00	шт.	16	2.00	images/truffel.jpg
29	Фруктовый рай	\N	\N	Легкий бисквит с йогуртовым кремом и свежими сезонными ягодами, 2 кг	\N	2	4100.00	шт.	6	3.00	images/fruit_paradise.jpg
30	Прага	\N	\N	Шоколадный торт по рецепту пражского ресторана, с абрикосовым конфитюром, 1.6 кг	\N	2	2700.00	шт.	14	2.00	images/prague.jpg
31	Капкейки "Ассорти" (12 шт.)	\N	\N	Набор из 12 капкейков с разными начинками и украшениями	\N	2	1890.00	шт. (набор)	4	4.00	images/cupcakes.jpg
32	Сникерс	\N	\N	Торт-десерт на основе знаменитого батончика: арахис, нуга, карамель, шоколад, 1.8 кг	\N	2	4300.00	шт.	6	2.00	images/snickers.jpg
33	Морковный торт	\N	\N	Влажный бисквит с морковью, орехами и сливочным сыром, 1.5 кг	\N	2	2800.00	шт.	15	3.00	images/carrot_cake.jpg
34	Чизкейк Нью-Йорк	\N	\N	Классический выпеченный чизкейк на песочной основе, 1.2 кг	\N	2	3556.00	шт.	6	3.00	images/ny_cheesecake.jpg
35	Малиновый меридиан	\N	\N	Нежное малиновое муссовое кольцо на миндальном бисквите, 1.6 кг	\N	2	3800.00	шт.	14	2.00	images/raspberry_mousse.jpg
36	Детский "Смешарики"	\N	\N	Торт в виде любимых персонажей, цветной бисквит, сливочный крем, 2.5 кг	\N	2	5500.00	шт.	6	3.00	images/smeshariki.jpg
37	Кофейный "Гляссе"	\N	\N	Торт со вкусом кофе гляссе, кофейные коржи и нежный крем, 1.4 кг	\N	2	2100.00	шт.	3	2.00	images/coffee_glace.jpg
38	Свадебная феерия (3 яруса)	\N	\N	Трехъярусный свадебный торт с ванильным муссом и цветочным декором из мастики, 7 кг	\N	2	15400.00	шт.	1	4.00	images/wedding_cake.jpg
39	Тирамису	\N	\N	Классическое тирамису на основе маскарпоне, савоярди и кофе, 1.5 кг	\N	2	4600.00	шт.	9	2.00	images/tiramisu.jpg
40	Пирожное "Картошка" (10 шт.)	\N	\N	Набор из 10 пирожных "Картошка", посыпанных какао	\N	2	900.00	шт. (набор)	12	3.00	images/kartoshka.jpg
41	Лимонный курд	\N	\N	Освежающий торт с лимонным курдом, безе и хрустящим слоем, 1.8 кг	\N	2	6800.00	шт.	15	3.00	images/lemon_curd.jpg
42	Черный лес	\N	\N	Немецкий торт с шоколадными бисквитами, вишней и взбитыми сливками, 2 кг	\N	2	4200.00	шт.	9	2.00	images/black_forest.jpg
43	Безглютеновый шоколадный	\N	\N	Богатый шоколадный торт на миндальной муке, без глютена и лактозы, 1.5 кг	\N	2	4800.00	шт.	11	4.00	images/gluten_free.jpg
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
5	5
6	2
7	4
8	2
9	2
10	3
11	2
12	4
13	2
14	3
15	3
16	2
17	3
18	2
19	4
20	2
21	3
22	3
23	2
24	4
25	5
26	2
27	4
28	2
29	2
30	3
31	2
32	4
33	2
34	3
35	3
36	2
37	3
38	2
39	4
40	2
41	3
42	3
43	2
44	4
45	5
46	2
47	4
48	2
49	2
50	3
51	2
52	4
53	2
54	3
55	3
56	2
57	3
58	2
59	4
60	2
61	3
62	3
63	2
64	4
65	5
66	2
67	4
68	2
69	2
70	3
71	2
72	4
73	2
74	3
75	3
76	2
77	3
78	2
79	4
80	2
81	3
82	3
83	2
84	4
\.


--
-- Data for Name: confectioneries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.confectioneries (id, name, address, phone) FROM stdin;
21	Классический бисквитный	\N	\N
22	Американский	\N	\N
23	Классический медовый	\N	\N
24	Суфлейный (с агар-агаром)	\N	\N
25	Шоколадный муссовый	\N	\N
26	Фруктово-ягодный	\N	\N
27	Шоколадный бисквитный	\N	\N
28	Капкейки	\N	\N
29	Десертный (с нугой и карамелью)	\N	\N
30	Овощной бисквитный	\N	\N
31	Чизкейк (выпеченный)	\N	\N
32	Ягодный муссовый	\N	\N
33	Тематический бисквитный	\N	\N
34	Кофейно-сливочный	\N	\N
35	Многоярусный бисквитно-муссовый	\N	\N
36	Итальянский десерт	\N	\N
37	Кондитерское изделие	\N	\N
38	Цитрусовый муссовый	\N	\N
39	Шоколадно-вишневый	\N	\N
40	Безглютеновый	\N	\N
41	Классический бисквитный	\N	\N
42	Американский	\N	\N
43	Классический медовый	\N	\N
44	Суфлейный (с агар-агаром)	\N	\N
45	Шоколадный муссовый	\N	\N
46	Фруктово-ягодный	\N	\N
47	Шоколадный бисквитный	\N	\N
48	Капкейки	\N	\N
49	Десертный (с нугой и карамелью)	\N	\N
50	Овощной бисквитный	\N	\N
51	Чизкейк (выпеченный)	\N	\N
52	Ягодный муссовый	\N	\N
53	Тематический бисквитный	\N	\N
54	Кофейно-сливочный	\N	\N
55	Многоярусный бисквитно-муссовый	\N	\N
56	Итальянский десерт	\N	\N
57	Кондитерское изделие	\N	\N
58	Цитрусовый муссовый	\N	\N
59	Шоколадно-вишневый	\N	\N
60	Безглютеновый	\N	\N
61	Классический бисквитный	\N	\N
62	Американский	\N	\N
63	Классический медовый	\N	\N
64	Суфлейный (с агар-агаром)	\N	\N
65	Шоколадный муссовый	\N	\N
66	Фруктово-ягодный	\N	\N
67	Шоколадный бисквитный	\N	\N
68	Капкейки	\N	\N
69	Десертный (с нугой и карамелью)	\N	\N
70	Овощной бисквитный	\N	\N
71	Чизкейк (выпеченный)	\N	\N
72	Ягодный муссовый	\N	\N
73	Тематический бисквитный	\N	\N
74	Кофейно-сливочный	\N	\N
75	Многоярусный бисквитно-муссовый	\N	\N
76	Итальянский десерт	\N	\N
77	Кондитерское изделие	\N	\N
78	Цитрусовый муссовый	\N	\N
79	Шоколадно-вишневый	\N	\N
80	Безглютеновый	\N	\N
81	Классический бисквитный	\N	\N
82	Американский	\N	\N
83	Классический медовый	\N	\N
84	Суфлейный (с агар-агаром)	\N	\N
85	Шоколадный муссовый	\N	\N
86	Фруктово-ягодный	\N	\N
87	Шоколадный бисквитный	\N	\N
88	Капкейки	\N	\N
89	Десертный (с нугой и карамелью)	\N	\N
90	Овощной бисквитный	\N	\N
91	Чизкейк (выпеченный)	\N	\N
92	Ягодный муссовый	\N	\N
93	Тематический бисквитный	\N	\N
94	Кофейно-сливочный	\N	\N
95	Многоярусный бисквитно-муссовый	\N	\N
96	Итальянский десерт	\N	\N
97	Кондитерское изделие	\N	\N
98	Цитрусовый муссовый	\N	\N
99	Шоколадно-вишневый	\N	\N
100	Безглютеновый	\N	\N
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, cake_id, quantity, price) FROM stdin;
\.


--
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_statuses (id, name) FROM stdin;
1	Новый
2	В обработке
3	Готов
4	Выдан
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, status_id, pickup_point_id, order_date, delivery_date, total_amount) FROM stdin;
\.


--
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickup_points (id, address, working_hours) FROM stdin;
36	420151, г. Сладкий, ул. Тортовая, 15	\N
37	420152, г. Сладкий, ул. Пирожная, 22	\N
38	420153, г. Сладкий, ул. Кремовая, 8	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	guest
2	client
3	manager
4	admin
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name, contact_info) FROM stdin;
2	Основной поставщик	\N
3	Основной поставщик	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, login, password, fio, role_id) FROM stdin;
11	admin	admin123	Администратор Системы	4
12	manager	manager123	Иван Петров	3
13	client	client123	Мария Иванова	2
14	kondratieva@cake-shop.ru	1989bcceabed7c55b209607574dc3cc0084cac72626841ee14037bfaa845f1c3	Кондратьева Алиса Михайловна	4
15	voloshin@cake-shop.ru	5a962acc275443c96d844416f782b0b6eeed735ddda14584ee1a96d20b74f2cd	Волошин Игорь Сергеевич	4
16	sladkoezhkina@cake-shop.ru	bccbbed43d2b730bc55f10bae1f8f989039f8d40976a270fe64e380c57b7abbc	Сладкоежкина Виктория Павловна	4
17	kremov@cake-shop.ru	ef95c917d4569964830da8fbce0b222c3ad6eb6529ff8a1c5de8f449c68f3633	Кремов Артем Дмитриевич	3
18	biskvitov@cake-shop.ru	ac8e07bfca8c4b5fa6eee771aca159d7914daee0f71599c2d9f2075476e62dcd	Бисквитов Петр Владимирович	3
19	yagodnaya@cake-shop.ru	8bdcd70622931464d37b906037a1bfb9388ba83cd047b984344a8f82f46633a6	Ягодная Елена Игоревна	3
20	saharova.client@mail.ru	162ac8c391b12f1b21314b525fb6b7eb9fd07be1fb5335c7872d5c5c948eb8b0	Сахарова Анна Викторовна	1
21	waffle.client@gmail.com	f21ac92e116ea41b81d332a54f604ba0340a2d580af40c94e862b73704f9c5fe	Вафельный Максим Олегович	1
22	chocolate.client@yandex.ru	42cde5d08e58f55a13d9f730c8cf96b23cf461721a19681b8c4780c78c234e0d	Шоколадов Кирилл Александрович	1
23	fruit.client@outlook.com	b2edcf26ae6eae93588839ebad4c779c3a627f6a657fd661c51857d5c9d0150c	Фруктовская Ольга Сергеевна	1
\.


--
-- Name: cake_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cake_types_id_seq', 97, true);


--
-- Name: cakes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cakes_id_seq', 43, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 84, true);


--
-- Name: confectioneries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.confectioneries_id_seq', 100, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- Name: order_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_statuses_id_seq', 4, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: pickup_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickup_points_id_seq', 38, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 53, true);


--
-- Name: cake_types cake_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cake_types
    ADD CONSTRAINT cake_types_pkey PRIMARY KEY (id);


--
-- Name: cakes cakes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cakes
    ADD CONSTRAINT cakes_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: confectioneries confectioneries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confectioneries
    ADD CONSTRAINT confectioneries_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: pickup_points unique_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT unique_address UNIQUE (address);


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
-- Name: cakes cakes_cake_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cakes
    ADD CONSTRAINT cakes_cake_type_id_fkey FOREIGN KEY (cake_type_id) REFERENCES public.cake_types(id);


--
-- Name: cakes cakes_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cakes
    ADD CONSTRAINT cakes_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: cakes cakes_confectionery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cakes
    ADD CONSTRAINT cakes_confectionery_id_fkey FOREIGN KEY (confectionery_id) REFERENCES public.confectioneries(id);


--
-- Name: cakes cakes_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cakes
    ADD CONSTRAINT cakes_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: order_items order_items_cake_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_cake_id_fkey FOREIGN KEY (cake_id) REFERENCES public.cakes(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders orders_pickup_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_id_fkey FOREIGN KEY (pickup_point_id) REFERENCES public.pickup_points(id);


--
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_statuses(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

