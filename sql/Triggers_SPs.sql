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

CREATE OR REPLACE FUCTION movimento_personagem(id_local INT) RETURNS void AS $movimento_personagem$
BEGIN
    IF (SELECT * FROM sala s  WHERE s.local_n = id_local OR s.local_s = id_local OR s.local_l = id_local OR s.local_o = id_local) THEN
    UPDATE personagem SET localizao = id_local;
END;
$movimento_personagem$ LANGUAGE plpgsql;