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

CREATE OR REPLACE FUNCTION movimento_personagem(movimento CHAR) RETURNS char AS $movimento_personagem$
DECLARE
    local_next_n INT;
    local_next_s INT;
    local_next_l INT;
    local_next_o INT;
BEGIN
    SELECT s.local_n INTO local_next_n FROM sala s, personagem p WHERE s.id_local = p.localizacao;
    SELECT s.local_s INTO local_next_s FROM sala s, personagem p WHERE s.id_local = p.localizacao;
    SELECT s.local_l INTO local_next_l FROM sala s, personagem p WHERE s.id_local = p.localizacao;
    SELECT s.local_o INTO local_next_o FROM sala s, personagem p WHERE s.id_local = p.localizacao;

    IF (local_next_n = NULL OR local_next_s = NULL OR local_next_l = NULL OR local_next_o = NULL) THEN
        RETURN 'Não pode movimentar por esse lado!!!';
    END IF;


    IF (movimento = 'up') THEN
        UPDATE personagem p SET localizacao = s.local_n FROM sala s WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'down') THEN 
        UPDATE personagem p SET localizacao = s.local_s FROM sala s WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'right') THEN
        UPDATE personagem p SET localizacao = s.local_l FROM sala s WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'left') THEN
        UPDATE personagem p SET localizacao = s.local_o FROM sala s WHERE p.localizacao = s.id_local;
	END IF;

    RETURN 'Movimentou!!';
END;
$movimento_personagem$ LANGUAGE plpgsql;

--- Verifica se mais de uma sala tem o mesmo id
CREATE OR REPLACE FUNCTION movimento_personagem(movimento CHAR) RETURNS text AS $movimento_personagem$
DECLARE
    local_next_n INT;
    local_next_s INT;
    local_next_l INT;
    local_next_o INT;
BEGIN
    -- Obter os valores das direções em uma única consulta
    SELECT s.local_n, s.local_s, s.local_l, s.local_o
    INTO local_next_n, local_next_s, local_next_l, local_next_o
    FROM sala s
    JOIN personagem p ON s.id_local = p.localizacao;

    -- Verificar se qualquer uma das direções é NULL
    IF ((local_next_n IS NULL AND movimento = 'up') OR (local_next_s IS NULL AND movimento = 'down') OR (local_next_l IS NULL AND movimento = 'right') OR (local_next_o IS NULL AND movimento = 'left')) THEN
        RETURN 'Não pode movimentar por esse lado!!!';
    END IF;

    -- Movimentar o personagem de acordo com o movimento
    IF (movimento = 'up') THEN  -- 'u' para 'up'
        UPDATE personagem p
        SET localizacao = local_next_n
        FROM sala s
        WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'down') THEN  -- 'd' para 'down'
        UPDATE personagem p
        SET localizacao = local_next_s
        FROM sala s
        WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'right') THEN  -- 'r' para 'right'
        UPDATE personagem p
        SET localizacao = local_next_l
        FROM sala s
        WHERE p.localizacao = s.id_local;
    ELSIF (movimento = 'left') THEN  -- 'l' para 'left'
        UPDATE personagem p
        SET localizacao = local_next_o
        FROM sala s
        WHERE p.localizacao = s.id_local;
    ELSE
        RETURN 'Movimento inválido!';
    END IF;

    RETURN 'Movimentou!!';
END;
$movimento_personagem$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS verifica_mapa_sala ON sala;

CREATE TRIGGER verifica_mapa_sala
BEFORE INSERT ON sala
FOR EACH ROW EXECUTE PROCEDURE verifica_mapa();


CREATE OR REPLACE FUNCTION drop_all_tabelas() RETURNS void AS $drop_all_tabelas$
DECLARE
    r RECORD;
BEGIN
    -- Loop sobre todas as tabelas no esquema atual
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || r.tablename || ' CASCADE';
    END LOOP;
END
$drop_all_tabelas$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION drop_all_types() RETURNS void AS $drop_all_types$
DECLARE
    r RECORD;
BEGIN
    -- Loop sobre todos os tipos definidos pelo usuário
    FOR r IN (SELECT typname FROM pg_type WHERE typnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'public') AND typtype = 'c') LOOP
        -- Executa o comando DROP TYPE para cada tipo encontrado
        EXECUTE 'DROP TYPE IF EXISTS ' || quote_ident(r.typname) || ' CASCADE';
    END LOOP;
END
$drop_all_types$ LANGUAGE plpgsql;