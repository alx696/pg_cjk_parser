CREATE FUNCTION public.prsd2_cjk_start(IN internal, IN integer)
    RETURNS internal
    LANGUAGE 'c' STRICT
    
AS '$libdir/pg_cjk_parser.so', 'prsd2_start'
;

CREATE FUNCTION public.prsd2_cjk_nexttoken(IN internal, IN internal, IN internal)
    RETURNS internal
    LANGUAGE 'c' STRICT
    
AS '$libdir/pg_cjk_parser.so', 'prsd2_nexttoken'
;

	
CREATE FUNCTION public.prsd2_cjk_end(IN internal)
    RETURNS void
    LANGUAGE 'c' STRICT
    
AS '$libdir/pg_cjk_parser.so', 'prsd2_end'
;

CREATE FUNCTION public.prsd2_cjk_lextype(IN internal)
    RETURNS internal
    LANGUAGE 'c' STRICT
    
AS '$libdir/pg_cjk_parser.so', 'prsd2_lextype'
;

	
CREATE FUNCTION public.prsd2_cjk_headline(IN internal, IN internal, IN tsquery)
    RETURNS internal
    LANGUAGE 'c' STRICT
    
AS '$libdir/pg_cjk_parser.so', 'prsd2_headline'
;

CREATE FUNCTION public.cjk_zht2zhs(IN text)
    RETURNS text
    LANGUAGE 'c' STRICT
    
AS '$libdir/pg_cjk_parser.so', 'prsd2_zht2zhs'
;

CREATE TEXT SEARCH PARSER public.pg_cjk_parser (
    START = prsd2_cjk_start,
    GETTOKEN = prsd2_cjk_nexttoken,
    END = prsd2_cjk_end,
    LEXTYPES = prsd2_cjk_lextype,
    HEADLINE = prsd2_cjk_headline);

CREATE TEXT SEARCH CONFIGURATION public.config_2_gram_cjk (
    PARSER = pg_cjk_parser
);

SET default_text_search_config = 'public.config_2_gram_cjk';

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR asciihword
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR cjk
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR email
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR asciiword
    WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR entity
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR file
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR float
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR host
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR hword
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR hword_asciipart
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR hword_numpart
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR hword_part
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR int
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR numhword
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR numword
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR protocol
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR sfloat
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR tag
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR uint
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR url
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR url_path
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR version
    WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.config_2_gram_cjk
    ADD MAPPING FOR word
    WITH simple;
