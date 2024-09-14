CREATE OR REPLACE FUNCTION criar_enums() RETURNS void AS $criar_enums$
BEGIN

    CREATE TYPE LOCAL_TIPO AS ENUM ('loja', 'pousada', 'oficina','grama', 'agua', 'ruina', 'buraco', 'caverna', 'masmorra','residencia');

    CREATE TYPE TIPO_RESIDENCIA AS ENUM ('loja', 'pousada', 'oficina');

    CREATE TYPE TIPO_CLASSE AS ENUM ('saber', 'lancer', 'archer', 'rider', 'caster', 'assassin', 'berserker');

    CREATE TYPE TIPO_EXCLASSE AS ENUM ('ruler', 'avenger', 'moon_cancer', 'alter_ego', 'foreigner', 'pretender', 'shielder', 'beast');

    CREATE TYPE RANK_ AS ENUM ('ex', 'sss', 'ss', 's', 'a', 'b', 'c', 'd', 'e', 'f', 'g');

    CREATE TYPE TIPO_HABILIDADE AS ENUM ('ativa', 'passiva', 'habilidade_especial', 'noble_phantasm');

    CREATE TYPE ALIGN AS ENUM ('good', 'neutral', 'evil');

    CREATE TYPE TIPO_INIMIGO AS ENUM ('comum', 'elite', 'miniboss', 'boss', 'raid_boss', 'special', 'event');


    CREATE TYPE TIPO_ITEM AS ENUM ('material', 'consumivel', 'acessorio', 'arma', 'armadura', 'artefato', 'item', 'magico');

    CREATE TYPE TIPO_MATERIAL AS ENUM ('lixo', 'mineral', 'raro', 'comum', 'toxico');

    CREATE TYPE TIPO_CONSUMIVEL AS ENUM ('pocao', 'pergaminho', 'alimento');

    CREATE TYPE TIPO_ARMADURA AS ENUM ('cabeca', 'torso', 'mao_direita', 'mao_esquerda', 'duas_maos', 'calca', 'pe', 'acessorio_1', 'acessorio_2', 'acessorio_3');

END;
$criar_enums$ LANGUAGE plpgsql;

--- Movimentacao Personagem

CREATE OR REPLACE FUNCTION movimento_personagem(movimento CHAR) RETURNS void AS $movimento_personagem$
BEGIN
    IF (movimento = 'up') THEN
        UPDATE personagem p SET localizacao = s.local_n FROM sala s WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'down') THEN 
        UPDATE personagem p SET localizacao = s.local_s FROM sala s WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'right') THEN
        UPDATE personagem p SET localizacao = s.local_l FROM sala s WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'left') THEN
        UPDATE personagem p SET localizacao = s.local_o FROM sala s WHERE p.localizacao = s.id_local;
	END IF;
END;
$movimento_personagem$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION drop_all() RETURNS void AS $drop_all$
DECLARE
    r RECORD;
BEGIN
    -- Loop sobre todas as tabelas no esquema atual
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || r.tablename || ' CASCADE';
    END LOOP;
    -- Loop sobre todos os tipos definidos pelo usuário
    FOR r IN (SELECT typname FROM pg_type WHERE typnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'public') AND typtype = 'c') LOOP
        -- Executa o comando DROP TYPE para cada tipo encontrado
        EXECUTE 'DROP TYPE IF EXISTS ' || quote_ident(r.typname) || ' CASCADE';
    END LOOP;
END
$drop_all$ LANGUAGE plpgsql;