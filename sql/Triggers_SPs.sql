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
    SELECT s.local_n, s.local_s, s.local_l, s.local_o
    INTO local_next_n, local_next_s, local_next_l, local_next_o
    FROM sala s
    JOIN personagem p ON s.id_local = p.localizacao;

    IF ((local_next_n = NULL AND movimento = 'up') OR (local_next_s = NULL AND movimento = 'down') OR (local_next_l = NULL AND movimento = 'right') OR (local_next_o = NULL AND movimento = 'left')) THEN
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
CREATE OR REPLACE FUNCTION verifica_mapa() RETURNS trigger AS $verifica_mapa$
DECLARE
    qtd_ids INT;
    qtd_ids_n INT;
    qtd_ids_s INT;
    qtd_ids_l INT;
    qtd_ids_o INT;
BEGIN
    SELECT COUNT(*) INTO qtd_ids FROM qtd_salas WHERE id_local = NEW.id_local;
    IF qtd_ids > 1 THEN
        RAISE EXCEPTION 'Não pode ter duas sala com mesmo ID!!!';
    END IF;

    SELECT NEW.local_n, NEW.local_s, NEW.local_l, NEW.local_o 
    INTO qtd_ids_n, qtd_ids_s, qtd_ids_l, qtd_ids_o
    FROM sala
    WHERE id_local = NEW.id_local;

    IF (qtd_ids_n = qtd_ids_s OR qtd_ids_l = qtd_ids_o) THEN
        RAISE EXCEPTION 'Não pode ter salas futuras sala com mesmo ID!!!';
    END IF;
    IF (qtd_ids_n = qtd_ids_l OR qtd_ids_s = qtd_ids_o) THEN
        RAISE EXCEPTION 'Não pode ter salas futuras sala com mesmo ID!!!';
    END IF;
    IF (qtd_ids_n = qtd_ids_o OR qtd_ids_l = qtd_ids_s) THEN
        RAISE EXCEPTION 'Não pode ter salas futuras sala com mesmo ID!!!';
    END IF;
    RETURN NEW; 
END;
$verifica_mapa$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS verifica_mapa_sala ON sala;

CREATE TRIGGER verifica_mapa_sala
BEFORE INSERT ON sala
FOR EACH ROW EXECUTE PROCEDURE verifica_mapa();


CREATE OR REPLACE FUNCTION drop_all_tabelas() RETURNS void AS $drop_all_tabelas$
BEGIN
    DROP TABLE IF EXISTS CASCADE;
    DROP TABLE IF EXISTS habilidade CASCADE;
    DROP TABLE IF EXISTS habilidade_extra CASCADE;
    DROP TABLE IF EXISTS classe CASCADE;
    DROP TABLE IF EXISTS personagem CASCADE;
    DROP TABLE IF EXISTS pericia CASCADE;
    DROP TABLE IF EXISTS atributos CASCADE;
    DROP TABLE IF EXISTS personagem_equip CASCADE;
    DROP TABLE IF EXISTS inventario CASCADE;
    DROP TABLE IF EXISTS extra_classe CASCADE;
    DROP TABLE IF EXISTS habilidade_personagem CASCADE;
    DROP TABLE IF EXISTS evolucao_habilidade CASCADE;
    DROP TABLE IF EXISTS habilidade_evoluida CASCADE;
    DROP TABLE IF EXISTS npc CASCADE;
    DROP TABLE IF EXISTS dialogo CASCADE;
    DROP TABLE IF EXISTS inimigo CASCADE;
    DROP TABLE IF EXISTS inimigo_comum CASCADE;
    DROP TABLE IF EXISTS inimigo_boss CASCADE;
    DROP TABLE IF EXISTS instancia_inimigo CASCADE;
    DROP TABLE IF EXISTS item CASCADE;
    DROP TABLE IF EXISTS material CASCADE;
    DROP TABLE IF EXISTS consumivel CASCADE;
    DROP TABLE IF EXISTS consumivel_habilidade CASCADE;
    DROP TABLE IF EXISTS acessorio CASCADE;
    DROP TABLE IF EXISTS arma CASCADE;
    DROP TABLE IF EXISTS arma_habilidade CASCADE;
    DROP TABLE IF EXISTS evoluca_arma CASCADE;
    DROP TABLE IF EXISTS material_req CASCADE;
    DROP TABLE IF EXISTS arma_evoluidade CASCADE;
    DROP TABLE IF EXISTS conjunto_armadura CASCADE;
    DROP TABLE IF EXISTS armadura CASCADE;
    DROP TABLE IF EXISTS inventario_item CASCADE;
    DROP TABLE IF EXISTS missao CASCADE;
    DROP TABLE IF EXISTS missao_doing CASCADE;
    DROP TABLE IF EXISTS recompensa CASCADE;
    DROP TABLE IF EXISTS recompensa_item CASCADE;
    DROP TABLE IF EXISTS missao_dialogo CASCADE;
    DROP TABLE IF EXISTS mundo CASCADE;
    DROP TABLE IF EXISTS regiao CASCADE;
    DROP TABLE IF EXISTS qtd_salas CASCADE;
    DROP TABLE IF EXISTS sala CASCADE;
    DROP TABLE IF EXISTS caverna CASCADE;
    DROP TABLE IF EXISTS masmorra CASCADE;
    DROP TABLE IF EXISTS residencia CASCADE;
    DROP TABLE IF EXISTS estoque CASCADE;
    DROP TABLE IF EXISTS carrinho CASCADE;
    DROP TABLE IF EXISTS boss_habilidade CASCADE;
    DROP TABLE IF EXISTS fala_npc CASCADE;
    DROP TABLE IF EXISTS fala_personagem CASCADE;
    DROP TABLE IF EXISTS local_inimigo CASCADE;
    DROP TABLE IF EXISTS fala_boss CASCADE;
    DROP TABLE IF EXISTS item_sala CASCADE;
    DROP TABLE IF EXISTS npc_missao CASCADE;
    DROP TABLE IF EXISTS luta CASCADE;
    DROP TABLE IF EXISTS drop_item CASCADE;
END;
$drop_all_tabelas$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION drop_all_types() RETURNS void AS $drop_all_types$
BEGIN
    DROP TYPE IF EXISTS LOCAL_TIPO CASCADE;
    DROP TYPE IF EXISTS TIPO_RESIDENCIA CASCADE;
    DROP TYPE IF EXISTS TIPO_CLASSE CASCADE;
    DROP TYPE IF EXISTS PERICIAS CASCADE;
    DROP TYPE IF EXISTS ATRIBUTOS CASCADE;
    DROP TYPE IF EXISTS TIPO_EXCLASSE CASCADE;
    DROP TYPE IF EXISTS RANK_ CASCADE;
    DROP TYPE IF EXISTS TIPO_HABILIDADE CASCADE;
    DROP TYPE IF EXISTS ALIGN CASCADE;
    DROP TYPE IF EXISTS TIPO_ITEM CASCADE;
    DROP TYPE IF EXISTS TIPO_MATERIAL CASCADE;
    DROP TYPE IF EXISTS TIPO_CONSUMIVE CASCADE;
    DROP TYPE IF EXISTS TIPO_ARMADURA CASCADE;
    DROP TYPE IF EXISTS TIPO_INIMIGO CASCADE;
END;
$drop_all_types$ LANGUAGE plpgsql;