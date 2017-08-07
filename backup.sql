--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY addresses (id, user_uuid, street_number, street_name, address_2, city, state, zip, google_place_id, uuid, created_at, updated_at) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-08-03 21:42:14.033245	2017-08-03 21:42:14.033245
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('addresses_id_seq', 1, true);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-08-04 02:32:34.039682	2017-08-04 02:32:34.039682
\.


--
-- Data for Name: callbacks; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY callbacks (id, place_id, call_back_date, called) FROM stdin;
\.


--
-- Name: callbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('callbacks_id_seq', 1, false);


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY carts (id, user_uuid, status, uuid, created_at, updated_at) FROM stdin;
\.


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('carts_id_seq', 1, false);


--
-- Data for Name: carts_products; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY carts_products (id, cart_uuid, product_uuid, amount, created_at, updated_at) FROM stdin;
\.


--
-- Name: carts_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('carts_products_id_seq', 1, false);


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY notes (id, place_id, note_text, created_at, updated_at) FROM stdin;
\.


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('notes_id_seq', 1, false);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY orders (id, cart_uuid, address_uuid, stripe_token_uuid, subtotal_cents, shipping_cents, tax_cents, total_cents, expected_delivery_date, delivered_at, paid, status, uuid, created_at, updated_at) FROM stdin;
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('orders_id_seq', 1, false);


--
-- Data for Name: place_statuses; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY place_statuses (id, place_id, status_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: place_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('place_statuses_id_seq', 1, false);


--
-- Data for Name: place_types; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY place_types (id, description, created_at, updated_at) FROM stdin;
\.


--
-- Name: place_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('place_types_id_seq', 1, false);


--
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY places (id, latitude, longitude, google_place_id, name, rating, created_at, updated_at, phone_number, address, place_type_id) FROM stdin;
\.


--
-- Name: places_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('places_id_seq', 1, false);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY products (id, name, image_url, description, uuid, created_at, updated_at, price_cents) FROM stdin;
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('products_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY schema_migrations (version) FROM stdin;
20170801200847
20170614194951
20170614201403
20170619181651
20170619220140
20170621154450
20170621154601
20170622185252
20170627001411
20170627001808
20170627002853
20170714163659
20170716163313
20170716163640
20170718190952
20170718201625
20170718231902
20170723015109
20170801174628
20170801174813
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY statuses (id, status) FROM stdin;
\.


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('statuses_id_seq', 1, false);


--
-- Data for Name: stripe_charges; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY stripe_charges (id, order_uuid, amount_cents, stripe_token_uuid, status, response, created_at, updated_at) FROM stdin;
\.


--
-- Name: stripe_charges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('stripe_charges_id_seq', 1, false);


--
-- Data for Name: stripe_tokens; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY stripe_tokens (id, user_uuid, last_4, token, response, active, uuid, created_at, updated_at) FROM stdin;
\.


--
-- Name: stripe_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('stripe_tokens_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sammy
--

COPY users (id, first_name, last_name, email, salt, encrypted_password, uuid, created_at, updated_at) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sammy
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

