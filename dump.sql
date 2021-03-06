PGDMP     %                
    x            mini_chat_dev_db    12.5    12.5 �    L           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            O           1262    16384    mini_chat_dev_db    DATABASE     �   CREATE DATABASE mini_chat_dev_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';
     DROP DATABASE mini_chat_dev_db;
                mini_chat_dev    false            �            1259    16497    api_message    TABLE       CREATE TABLE public.api_message (
    id integer NOT NULL,
    content character varying(300) NOT NULL,
    room_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone,
    media boolean NOT NULL,
    media_src character varying(200)
);
    DROP TABLE public.api_message;
       public         heap    mini_chat_dev    false            �            1259    16495    api_message_id_seq    SEQUENCE     �   CREATE SEQUENCE public.api_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.api_message_id_seq;
       public          mini_chat_dev    false    221            P           0    0    api_message_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.api_message_id_seq OWNED BY public.api_message.id;
          public          mini_chat_dev    false    220            �            1259    16489    api_room    TABLE     d   CREATE TABLE public.api_room (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);
    DROP TABLE public.api_room;
       public         heap    mini_chat_dev    false            �            1259    16487    api_room_id_seq    SEQUENCE     �   CREATE SEQUENCE public.api_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.api_room_id_seq;
       public          mini_chat_dev    false    219            Q           0    0    api_room_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.api_room_id_seq OWNED BY public.api_room.id;
          public          mini_chat_dev    false    218            �            1259    16576    api_room_users    TABLE     |   CREATE TABLE public.api_room_users (
    id integer NOT NULL,
    room_id integer NOT NULL,
    user_id integer NOT NULL
);
 "   DROP TABLE public.api_room_users;
       public         heap    mini_chat_dev    false            �            1259    16574    api_room_users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.api_room_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.api_room_users_id_seq;
       public          mini_chat_dev    false    225            R           0    0    api_room_users_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.api_room_users_id_seq OWNED BY public.api_room_users.id;
          public          mini_chat_dev    false    224            �            1259    16460    api_user    TABLE       CREATE TABLE public.api_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    username character varying(300) NOT NULL,
    email character varying(40) NOT NULL,
    last_sign_in date,
    profile character varying(300)
);
    DROP TABLE public.api_user;
       public         heap    mini_chat_dev    false            �            1259    16473    api_user_groups    TABLE     ~   CREATE TABLE public.api_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 #   DROP TABLE public.api_user_groups;
       public         heap    mini_chat_dev    false            �            1259    16471    api_user_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.api_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.api_user_groups_id_seq;
       public          mini_chat_dev    false    215            S           0    0    api_user_groups_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.api_user_groups_id_seq OWNED BY public.api_user_groups.id;
          public          mini_chat_dev    false    214            �            1259    16458    api_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.api_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.api_user_id_seq;
       public          mini_chat_dev    false    213            T           0    0    api_user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.api_user_id_seq OWNED BY public.api_user.id;
          public          mini_chat_dev    false    212            �            1259    16481    api_user_user_permissions    TABLE     �   CREATE TABLE public.api_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 -   DROP TABLE public.api_user_user_permissions;
       public         heap    mini_chat_dev    false            �            1259    16479     api_user_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.api_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.api_user_user_permissions_id_seq;
       public          mini_chat_dev    false    217            U           0    0     api_user_user_permissions_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.api_user_user_permissions_id_seq OWNED BY public.api_user_user_permissions.id;
          public          mini_chat_dev    false    216            �            1259    16416 
   auth_group    TABLE     f   CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);
    DROP TABLE public.auth_group;
       public         heap    mini_chat_dev    false            �            1259    16414    auth_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public          mini_chat_dev    false    209            V           0    0    auth_group_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;
          public          mini_chat_dev    false    208            �            1259    16426    auth_group_permissions    TABLE     �   CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         heap    mini_chat_dev    false            �            1259    16424    auth_group_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public          mini_chat_dev    false    211            W           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;
          public          mini_chat_dev    false    210            �            1259    16408    auth_permission    TABLE     �   CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         heap    mini_chat_dev    false            �            1259    16406    auth_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public          mini_chat_dev    false    207            X           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
          public          mini_chat_dev    false    206            �            1259    16606    authtoken_token    TABLE     �   CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);
 #   DROP TABLE public.authtoken_token;
       public         heap    mini_chat_dev    false            �            1259    16552    django_admin_log    TABLE     �  CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         heap    mini_chat_dev    false            �            1259    16550    django_admin_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public          mini_chat_dev    false    223            Y           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
          public          mini_chat_dev    false    222            �            1259    16398    django_content_type    TABLE     �   CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         heap    mini_chat_dev    false            �            1259    16396    django_content_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public          mini_chat_dev    false    205            Z           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
          public          mini_chat_dev    false    204            �            1259    16387    django_migrations    TABLE     �   CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         heap    mini_chat_dev    false            �            1259    16385    django_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public          mini_chat_dev    false    203            [           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
          public          mini_chat_dev    false    202            �            1259    16624    django_session    TABLE     �   CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         heap    mini_chat_dev    false            `           2604    16500    api_message id    DEFAULT     p   ALTER TABLE ONLY public.api_message ALTER COLUMN id SET DEFAULT nextval('public.api_message_id_seq'::regclass);
 =   ALTER TABLE public.api_message ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    221    220    221            _           2604    16492    api_room id    DEFAULT     j   ALTER TABLE ONLY public.api_room ALTER COLUMN id SET DEFAULT nextval('public.api_room_id_seq'::regclass);
 :   ALTER TABLE public.api_room ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    219    218    219            c           2604    16579    api_room_users id    DEFAULT     v   ALTER TABLE ONLY public.api_room_users ALTER COLUMN id SET DEFAULT nextval('public.api_room_users_id_seq'::regclass);
 @   ALTER TABLE public.api_room_users ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    225    224    225            \           2604    16463    api_user id    DEFAULT     j   ALTER TABLE ONLY public.api_user ALTER COLUMN id SET DEFAULT nextval('public.api_user_id_seq'::regclass);
 :   ALTER TABLE public.api_user ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    212    213    213            ]           2604    16476    api_user_groups id    DEFAULT     x   ALTER TABLE ONLY public.api_user_groups ALTER COLUMN id SET DEFAULT nextval('public.api_user_groups_id_seq'::regclass);
 A   ALTER TABLE public.api_user_groups ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    215    214    215            ^           2604    16484    api_user_user_permissions id    DEFAULT     �   ALTER TABLE ONLY public.api_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.api_user_user_permissions_id_seq'::regclass);
 K   ALTER TABLE public.api_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    217    216    217            Z           2604    16419    auth_group id    DEFAULT     n   ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    209    208    209            [           2604    16429    auth_group_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    210    211    211            Y           2604    16411    auth_permission id    DEFAULT     x   ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    206    207    207            a           2604    16555    django_admin_log id    DEFAULT     z   ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    222    223    223            X           2604    16401    django_content_type id    DEFAULT     �   ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    205    204    205            W           2604    16390    django_migrations id    DEFAULT     |   ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public          mini_chat_dev    false    202    203    203            C          0    16497    api_message 
   TABLE DATA           b   COPY public.api_message (id, content, room_id, user_id, created_at, media, media_src) FROM stdin;
    public          mini_chat_dev    false    221   D�       A          0    16489    api_room 
   TABLE DATA           ,   COPY public.api_room (id, name) FROM stdin;
    public          mini_chat_dev    false    219   Z�       G          0    16576    api_room_users 
   TABLE DATA           >   COPY public.api_room_users (id, room_id, user_id) FROM stdin;
    public          mini_chat_dev    false    225   ��       ;          0    16460    api_user 
   TABLE DATA           �   COPY public.api_user (id, password, last_login, is_superuser, first_name, last_name, is_staff, is_active, date_joined, username, email, last_sign_in, profile) FROM stdin;
    public          mini_chat_dev    false    213   ��       =          0    16473    api_user_groups 
   TABLE DATA           @   COPY public.api_user_groups (id, user_id, group_id) FROM stdin;
    public          mini_chat_dev    false    215   8�       ?          0    16481    api_user_user_permissions 
   TABLE DATA           O   COPY public.api_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public          mini_chat_dev    false    217   U�       7          0    16416 
   auth_group 
   TABLE DATA           .   COPY public.auth_group (id, name) FROM stdin;
    public          mini_chat_dev    false    209   r�       9          0    16426    auth_group_permissions 
   TABLE DATA           M   COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public          mini_chat_dev    false    211   ��       5          0    16408    auth_permission 
   TABLE DATA           N   COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
    public          mini_chat_dev    false    207   ��       H          0    16606    authtoken_token 
   TABLE DATA           @   COPY public.authtoken_token (key, created, user_id) FROM stdin;
    public          mini_chat_dev    false    226   H�       E          0    16552    django_admin_log 
   TABLE DATA           �   COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public          mini_chat_dev    false    223   �       3          0    16398    django_content_type 
   TABLE DATA           C   COPY public.django_content_type (id, app_label, model) FROM stdin;
    public          mini_chat_dev    false    205   %�       1          0    16387    django_migrations 
   TABLE DATA           C   COPY public.django_migrations (id, app, name, applied) FROM stdin;
    public          mini_chat_dev    false    203   ��       I          0    16624    django_session 
   TABLE DATA           P   COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
    public          mini_chat_dev    false    227   ��       \           0    0    api_message_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.api_message_id_seq', 10, true);
          public          mini_chat_dev    false    220            ]           0    0    api_room_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.api_room_id_seq', 1, true);
          public          mini_chat_dev    false    218            ^           0    0    api_room_users_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.api_room_users_id_seq', 1, false);
          public          mini_chat_dev    false    224            _           0    0    api_user_groups_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.api_user_groups_id_seq', 1, false);
          public          mini_chat_dev    false    214            `           0    0    api_user_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.api_user_id_seq', 5, true);
          public          mini_chat_dev    false    212            a           0    0     api_user_user_permissions_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.api_user_user_permissions_id_seq', 1, false);
          public          mini_chat_dev    false    216            b           0    0    auth_group_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
          public          mini_chat_dev    false    208            c           0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);
          public          mini_chat_dev    false    210            d           0    0    auth_permission_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_permission_id_seq', 40, true);
          public          mini_chat_dev    false    206            e           0    0    django_admin_log_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);
          public          mini_chat_dev    false    222            f           0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 10, true);
          public          mini_chat_dev    false    204            g           0    0    django_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.django_migrations_id_seq', 71, true);
          public          mini_chat_dev    false    202            �           2606    16502    api_message api_message_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.api_message
    ADD CONSTRAINT api_message_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.api_message DROP CONSTRAINT api_message_pkey;
       public            mini_chat_dev    false    221            �           2606    16494    api_room api_room_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.api_room
    ADD CONSTRAINT api_room_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.api_room DROP CONSTRAINT api_room_pkey;
       public            mini_chat_dev    false    219            �           2606    16581 "   api_room_users api_room_users_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.api_room_users
    ADD CONSTRAINT api_room_users_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.api_room_users DROP CONSTRAINT api_room_users_pkey;
       public            mini_chat_dev    false    225            �           2606    16583 ;   api_room_users api_room_users_room_id_user_id_1dbb5861_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.api_room_users
    ADD CONSTRAINT api_room_users_room_id_user_id_1dbb5861_uniq UNIQUE (room_id, user_id);
 e   ALTER TABLE ONLY public.api_room_users DROP CONSTRAINT api_room_users_room_id_user_id_1dbb5861_uniq;
       public            mini_chat_dev    false    225    225            �           2606    16478 $   api_user_groups api_user_groups_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.api_user_groups DROP CONSTRAINT api_user_groups_pkey;
       public            mini_chat_dev    false    215            �           2606    16505 >   api_user_groups api_user_groups_user_id_group_id_9c7ddfb5_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_group_id_9c7ddfb5_uniq UNIQUE (user_id, group_id);
 h   ALTER TABLE ONLY public.api_user_groups DROP CONSTRAINT api_user_groups_user_id_group_id_9c7ddfb5_uniq;
       public            mini_chat_dev    false    215    215            {           2606    16468    api_user api_user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.api_user DROP CONSTRAINT api_user_pkey;
       public            mini_chat_dev    false    213            �           2606    16486 8   api_user_user_permissions api_user_user_permissions_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.api_user_user_permissions DROP CONSTRAINT api_user_user_permissions_pkey;
       public            mini_chat_dev    false    217            �           2606    16519 W   api_user_user_permissions api_user_user_permissions_user_id_permission_id_a06dd704_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_permission_id_a06dd704_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.api_user_user_permissions DROP CONSTRAINT api_user_user_permissions_user_id_permission_id_a06dd704_uniq;
       public            mini_chat_dev    false    217    217            ~           2606    16470    api_user api_user_username_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_username_key UNIQUE (username);
 H   ALTER TABLE ONLY public.api_user DROP CONSTRAINT api_user_username_key;
       public            mini_chat_dev    false    213            q           2606    16456    auth_group auth_group_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public            mini_chat_dev    false    209            v           2606    16442 R   auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 |   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
       public            mini_chat_dev    false    211    211            y           2606    16431 2   auth_group_permissions auth_group_permissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public            mini_chat_dev    false    211            s           2606    16421    auth_group auth_group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public            mini_chat_dev    false    209            l           2606    16433 F   auth_permission auth_permission_content_type_id_codename_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);
 p   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
       public            mini_chat_dev    false    207    207            n           2606    16413 $   auth_permission auth_permission_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public            mini_chat_dev    false    207            �           2606    16610 $   authtoken_token authtoken_token_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);
 N   ALTER TABLE ONLY public.authtoken_token DROP CONSTRAINT authtoken_token_pkey;
       public            mini_chat_dev    false    226            �           2606    16612 +   authtoken_token authtoken_token_user_id_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);
 U   ALTER TABLE ONLY public.authtoken_token DROP CONSTRAINT authtoken_token_user_id_key;
       public            mini_chat_dev    false    226            �           2606    16561 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public            mini_chat_dev    false    223            g           2606    16405 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public            mini_chat_dev    false    205    205            i           2606    16403 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public            mini_chat_dev    false    205            e           2606    16395 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public            mini_chat_dev    false    203            �           2606    16631 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public            mini_chat_dev    false    227            �           1259    16548    api_message_room_id_5e8f449d    INDEX     W   CREATE INDEX api_message_room_id_5e8f449d ON public.api_message USING btree (room_id);
 0   DROP INDEX public.api_message_room_id_5e8f449d;
       public            mini_chat_dev    false    221            �           1259    16549    api_message_user_id_7f9577a9    INDEX     W   CREATE INDEX api_message_user_id_7f9577a9 ON public.api_message USING btree (user_id);
 0   DROP INDEX public.api_message_user_id_7f9577a9;
       public            mini_chat_dev    false    221            �           1259    16594    api_room_users_room_id_beedcc98    INDEX     ]   CREATE INDEX api_room_users_room_id_beedcc98 ON public.api_room_users USING btree (room_id);
 3   DROP INDEX public.api_room_users_room_id_beedcc98;
       public            mini_chat_dev    false    225            �           1259    16595    api_room_users_user_id_a5e67ac2    INDEX     ]   CREATE INDEX api_room_users_user_id_a5e67ac2 ON public.api_room_users USING btree (user_id);
 3   DROP INDEX public.api_room_users_user_id_a5e67ac2;
       public            mini_chat_dev    false    225                       1259    16517 !   api_user_groups_group_id_3af85785    INDEX     a   CREATE INDEX api_user_groups_group_id_3af85785 ON public.api_user_groups USING btree (group_id);
 5   DROP INDEX public.api_user_groups_group_id_3af85785;
       public            mini_chat_dev    false    215            �           1259    16516     api_user_groups_user_id_a5ff39fa    INDEX     _   CREATE INDEX api_user_groups_user_id_a5ff39fa ON public.api_user_groups USING btree (user_id);
 4   DROP INDEX public.api_user_groups_user_id_a5ff39fa;
       public            mini_chat_dev    false    215            �           1259    16531 0   api_user_user_permissions_permission_id_305b7fea    INDEX        CREATE INDEX api_user_user_permissions_permission_id_305b7fea ON public.api_user_user_permissions USING btree (permission_id);
 D   DROP INDEX public.api_user_user_permissions_permission_id_305b7fea;
       public            mini_chat_dev    false    217            �           1259    16530 *   api_user_user_permissions_user_id_f3945d65    INDEX     s   CREATE INDEX api_user_user_permissions_user_id_f3945d65 ON public.api_user_user_permissions USING btree (user_id);
 >   DROP INDEX public.api_user_user_permissions_user_id_f3945d65;
       public            mini_chat_dev    false    217            |           1259    16503    api_user_username_cf4e88d2_like    INDEX     l   CREATE INDEX api_user_username_cf4e88d2_like ON public.api_user USING btree (username varchar_pattern_ops);
 3   DROP INDEX public.api_user_username_cf4e88d2_like;
       public            mini_chat_dev    false    213            o           1259    16457    auth_group_name_a6ea08ec_like    INDEX     h   CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public            mini_chat_dev    false    209            t           1259    16453 (   auth_group_permissions_group_id_b120cbf9    INDEX     o   CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
 <   DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
       public            mini_chat_dev    false    211            w           1259    16454 -   auth_group_permissions_permission_id_84c5c92e    INDEX     y   CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
 A   DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
       public            mini_chat_dev    false    211            j           1259    16439 (   auth_permission_content_type_id_2f476e4b    INDEX     o   CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
 <   DROP INDEX public.auth_permission_content_type_id_2f476e4b;
       public            mini_chat_dev    false    207            �           1259    16618 !   authtoken_token_key_10f0b77e_like    INDEX     p   CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);
 5   DROP INDEX public.authtoken_token_key_10f0b77e_like;
       public            mini_chat_dev    false    226            �           1259    16572 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public            mini_chat_dev    false    223            �           1259    16573 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public            mini_chat_dev    false    223            �           1259    16633 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public            mini_chat_dev    false    227            �           1259    16632 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public            mini_chat_dev    false    227            �           2606    16538 7   api_message api_message_room_id_5e8f449d_fk_api_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_message
    ADD CONSTRAINT api_message_room_id_5e8f449d_fk_api_room_id FOREIGN KEY (room_id) REFERENCES public.api_room(id) DEFERRABLE INITIALLY DEFERRED;
 a   ALTER TABLE ONLY public.api_message DROP CONSTRAINT api_message_room_id_5e8f449d_fk_api_room_id;
       public          mini_chat_dev    false    219    2956    221            �           2606    16543 7   api_message api_message_user_id_7f9577a9_fk_api_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_message
    ADD CONSTRAINT api_message_user_id_7f9577a9_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;
 a   ALTER TABLE ONLY public.api_message DROP CONSTRAINT api_message_user_id_7f9577a9_fk_api_user_id;
       public          mini_chat_dev    false    213    221    2939            �           2606    16584 =   api_room_users api_room_users_room_id_beedcc98_fk_api_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_room_users
    ADD CONSTRAINT api_room_users_room_id_beedcc98_fk_api_room_id FOREIGN KEY (room_id) REFERENCES public.api_room(id) DEFERRABLE INITIALLY DEFERRED;
 g   ALTER TABLE ONLY public.api_room_users DROP CONSTRAINT api_room_users_room_id_beedcc98_fk_api_room_id;
       public          mini_chat_dev    false    2956    225    219            �           2606    16589 =   api_room_users api_room_users_user_id_a5e67ac2_fk_api_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_room_users
    ADD CONSTRAINT api_room_users_user_id_a5e67ac2_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;
 g   ALTER TABLE ONLY public.api_room_users DROP CONSTRAINT api_room_users_user_id_a5e67ac2_fk_api_user_id;
       public          mini_chat_dev    false    213    2939    225            �           2606    16511 B   api_user_groups api_user_groups_group_id_3af85785_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_group_id_3af85785_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.api_user_groups DROP CONSTRAINT api_user_groups_group_id_3af85785_fk_auth_group_id;
       public          mini_chat_dev    false    2931    209    215            �           2606    16506 ?   api_user_groups api_user_groups_user_id_a5ff39fa_fk_api_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_a5ff39fa_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;
 i   ALTER TABLE ONLY public.api_user_groups DROP CONSTRAINT api_user_groups_user_id_a5ff39fa_fk_api_user_id;
       public          mini_chat_dev    false    2939    213    215            �           2606    16525 R   api_user_user_permissions api_user_user_permis_permission_id_305b7fea_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permis_permission_id_305b7fea_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.api_user_user_permissions DROP CONSTRAINT api_user_user_permis_permission_id_305b7fea_fk_auth_perm;
       public          mini_chat_dev    false    2926    207    217            �           2606    16520 S   api_user_user_permissions api_user_user_permissions_user_id_f3945d65_fk_api_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_f3945d65_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.api_user_user_permissions DROP CONSTRAINT api_user_user_permissions_user_id_f3945d65_fk_api_user_id;
       public          mini_chat_dev    false    217    213    2939            �           2606    16448 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public          mini_chat_dev    false    211    2926    207            �           2606    16443 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public          mini_chat_dev    false    209    2931    211            �           2606    16434 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public          mini_chat_dev    false    207    205    2921            �           2606    16619 ?   authtoken_token authtoken_token_user_id_35299eff_fk_api_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;
 i   ALTER TABLE ONLY public.authtoken_token DROP CONSTRAINT authtoken_token_user_id_35299eff_fk_api_user_id;
       public          mini_chat_dev    false    2939    213    226            �           2606    16562 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public          mini_chat_dev    false    205    2921    223            �           2606    16567 A   django_admin_log django_admin_log_user_id_c564eba6_fk_api_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;
 k   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_api_user_id;
       public          mini_chat_dev    false    223    2939    213            C     x�m��N�0�s��8�c��{G�x�]�:E[;m���b������Ơa�w�^j�Z�����f1���+�~�c� ;R�Zr��2���t��y���Ϻ�����a�{|>D�&����_�f�Пɐ���I�R߰�d8��X�o�h^�G�s��8���~�O%EHKh�1�1i��Il�*�6�O?�4�H��F&M�%���Q��ʍ��<����y����S}�OeZ����%����(1��io���e�c�      A      x�3��K-W(�������� '�      G      x������ � �      ;   �  x�}�[k�0ǟ�Oч�J]"+�!��`,�@�,kvbG����k�t�S�	�����ą�ޓ�=���g �s*�
 <���%�Ȍ��>�d8��P�y�W��\ �F�%����\ �Hk'���ʕ�?����k��������pΌr�S)uI]�����`�D���>ź)Y���)ҕ�6y��Mɴ���K6��n��;�1�&͆�űANU�]{�jsTl�T��r@3%�6z��UڳC[�ϙ���@��j*!"5\{j��V�R���J����P9Tz�\���!��j��7w��j����o��S}]����:��n�����ʷ}~��B�O_>攆q+��)�0�.��[�o��瞅���F�i����vi#�r"D�anò,{Ks��      =      x������ � �      ?      x������ � �      7      x������ � �      9      x������ � �      5   �  x�]�An�0E��)8A�d�+dY�B�E�&i���ߞ����O�'�ۙ�n(�˥�����2=�3��s��Ֆ��������#+/����5�?W���m��>��~�_��S�l#�;���O��I��;f�~
��T$Hg�vR.���SB��d���*�ð�oW,�ћ�D0�&��R������텇��}��W�m��}|�=	�f�A�2ό�#c�KX�c5��*#.�·LC>�v���)�������}�17��e�q
�OTmO�� ���8�N�<Q,����d$�m���6P� ��n#��1�fO!�͑6oG[�*#��������"��1�v��zt�7�_޶�j+UOA"s����K�jQPA�Rb>ެ�����       H   �   x�eιm�0���
7 a8��S��'f�H4ʑUfA�v����(3�Ƈ��B�~ :Gg��L@.Џ4̅e�}���'N'�j�4�B�?D���ܦ"�/�MK}���1Nt�3�!�I`=�Ԛߏ���yngC�X��Sq�R��Kwذ�3㋱Ny�����߻��n�C�      E      x������ � �      3   w   x�]��
1�ϓ����Kѡ�L�ia��.a���$�GNBo�,�:vZ}Ra��=�`�M�i+8�]�.�����H�c�?�iL��Xh(��I1�;.J��l�4Ռi;8/o!2n |�;�      1   �  x���[��0E��U���O�2��w��V���؁N��E
�|�V��Cw�y�/~� ��\�u����~�����Մo ��I��m����7���U��RZ���xW]Ǐ�g(��l��f�����������@�V_���Sx++Ŗ����"�7�����橊0�QE-*�^ez�r��8�%�
ы���h�atMw��Ů͆1Z�����Ќ�׺_���&�64,��4좡o�|VM}�Ʈ\u<:��]�Z?��o\�hN!,r&k����J�(��zI
Y��D��M��w��k*�m�
Z��讗��w�����Kc�f-e�'D�R?Ͼ 	���=���F	Iq�P�04�)����5\����:�����L���4y�Mur���>l�B"jJbf�7����8��0�`[���6d�	�#zA0�bΰ;�>4/�c��
EgT.h�u���
����S�Z(8�X�gT�Pd���Fmu�
-�2kX��Jka9��f;������Z"�������êu��^ڌc�ǿzUO2��4T@�j���X-9]�>J��?�gQ,R�v�����E���2�m��:�Җ2DE	�X.�&����%Pɲ@����Hm�A�a]
*�׍aQj���H��B���=��6����>�i(�K���*�L�L��&L�;�tg�×���i؆�W0r	XH�}뷻��8[\b�VBI����~��Ѽu�      I      x������ � �     