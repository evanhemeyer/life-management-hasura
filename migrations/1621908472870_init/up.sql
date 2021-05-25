CREATE TABLE public.budget_item_transactions (
    id integer NOT NULL,
    from_budget_item_id integer NOT NULL,
    to_budget_item_id integer NOT NULL,
    amount numeric NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);
CREATE SEQUENCE public.budget_item_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.budget_item_transactions_id_seq OWNED BY public.budget_item_transactions.id;
CREATE TABLE public.budget_items (
    id integer NOT NULL,
    name character varying NOT NULL,
    budget_id integer,
    updated_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);
CREATE SEQUENCE public.budget_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.budget_items_id_seq OWNED BY public.budget_items.id;
CREATE TABLE public.budgets (
    id integer NOT NULL,
    user_id text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    name character varying NOT NULL
);
CREATE SEQUENCE public.budgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.budgets_id_seq OWNED BY public.budgets.id;
CREATE TABLE public.financial_account_types (
    id integer NOT NULL,
    name character varying NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.financial_account_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.financial_account_types_id_seq OWNED BY public.financial_account_types.id;
CREATE TABLE public.financial_accounts (
    id integer NOT NULL,
    name character varying NOT NULL,
    financial_account_type_id integer NOT NULL,
    budget_id integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.financial_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.financial_accounts_id_seq OWNED BY public.financial_accounts.id;
CREATE TABLE public.financial_transactions (
    id integer NOT NULL,
    memo character varying,
    payee_name character varying NOT NULL,
    inflow numeric,
    outflow numeric,
    budget_item_id integer NOT NULL,
    financial_account_id integer NOT NULL,
    transaction_date date NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.financial_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.financial_transactions_id_seq OWNED BY public.financial_transactions.id;
CREATE TABLE public.users (
    id integer NOT NULL,
    first_name text,
    last_name text,
    email text NOT NULL,
    google_uid text NOT NULL
);
CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
ALTER TABLE ONLY public.budget_item_transactions ALTER COLUMN id SET DEFAULT nextval('public.budget_item_transactions_id_seq'::regclass);
ALTER TABLE ONLY public.budget_items ALTER COLUMN id SET DEFAULT nextval('public.budget_items_id_seq'::regclass);
ALTER TABLE ONLY public.budgets ALTER COLUMN id SET DEFAULT nextval('public.budgets_id_seq'::regclass);
ALTER TABLE ONLY public.financial_account_types ALTER COLUMN id SET DEFAULT nextval('public.financial_account_types_id_seq'::regclass);
ALTER TABLE ONLY public.financial_accounts ALTER COLUMN id SET DEFAULT nextval('public.financial_accounts_id_seq'::regclass);
ALTER TABLE ONLY public.financial_transactions ALTER COLUMN id SET DEFAULT nextval('public.financial_transactions_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.budget_item_transactions
    ADD CONSTRAINT budget_item_transactions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.budget_items
    ADD CONSTRAINT budget_items_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.financial_account_types
    ADD CONSTRAINT financial_account_types_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.financial_accounts
    ADD CONSTRAINT financial_accounts_id_key UNIQUE (id);
ALTER TABLE ONLY public.financial_transactions
    ADD CONSTRAINT financial_transactions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.budget_items
    ADD CONSTRAINT budget_items_budget_id_fkey FOREIGN KEY (budget_id) REFERENCES public.budgets(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.financial_accounts
    ADD CONSTRAINT financial_accounts_budget_id_fkey FOREIGN KEY (budget_id) REFERENCES public.budgets(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.financial_accounts
    ADD CONSTRAINT financial_accounts_financial_account_type_id_fkey FOREIGN KEY (financial_account_type_id) REFERENCES public.financial_account_types(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.financial_transactions
    ADD CONSTRAINT financial_transactions_financial_account_id_fkey FOREIGN KEY (financial_account_id) REFERENCES public.financial_accounts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
