PGDMP     )                    {            Zomato analysis    15.3    15.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16879    Zomato analysis    DATABASE     �   CREATE DATABASE "Zomato analysis" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 !   DROP DATABASE "Zomato analysis";
                postgres    false            �            1259    16880    goldusers_signup    TABLE     X   CREATE TABLE public.goldusers_signup (
    userid integer,
    gold_signup_date date
);
 $   DROP TABLE public.goldusers_signup;
       public         heap    postgres    false            �            1259    16889    product    TABLE     b   CREATE TABLE public.product (
    product_id integer,
    product_name text,
    price integer
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    16886    sales    TABLE     a   CREATE TABLE public.sales (
    userid integer,
    created_date date,
    product_id integer
);
    DROP TABLE public.sales;
       public         heap    postgres    false            �            1259    16883    users    TABLE     H   CREATE TABLE public.users (
    userid integer,
    signup_date date
);
    DROP TABLE public.users;
       public         heap    postgres    false            �          0    16880    goldusers_signup 
   TABLE DATA           D   COPY public.goldusers_signup (userid, gold_signup_date) FROM stdin;
    public          postgres    false    214   �
                 0    16889    product 
   TABLE DATA           B   COPY public.product (product_id, product_name, price) FROM stdin;
    public          postgres    false    217   �
                  0    16886    sales 
   TABLE DATA           A   COPY public.sales (userid, created_date, product_id) FROM stdin;
    public          postgres    false    216   �
       �          0    16883    users 
   TABLE DATA           4   COPY public.users (userid, signup_date) FROM stdin;
    public          postgres    false    215   m       �   !   x�3�4204�5��52�2�rLt��b���� T�         (   x�3�,0䴴0�2�,0�07�2�,0�466������ ]@O          t   x�E��1ߦe$|۽��:g�<w���95�Zͭ'.ȡ�d����*%<7N�g���;�q\i��S�����w����gJ��F���#E��ǫ;���;�)����}b'p      �   ,   x�3�4204�5��50�2qLuuM���2&���\1z\\\ �'4     