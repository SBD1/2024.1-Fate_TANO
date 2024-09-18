import psycopg2

def get_game_db_connection(game_number):
    db_name = f'game_{game_number}_db'
    return psycopg2.connect(
        host='localhost',
        port='5434',
        user='your_user',
        password='your_password',
        dbname=db_name
    )
    


def create_functions_triggers(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()
    
    # movimento_personagem()
    cur.execute('''
                CREATE OR REPLACE FUNCTION movimento_personagem(movimento CHAR) RETURNS text AS                 $movimento_personagem$
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
                ''')
    
    # Trigger na inserção do Mapa
    cur.execute('''
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
                ''')
    
    # Drop Tables
    cur.execute('''
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
                ''')
    
    # Drop Types
    cur.execute('''
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
                ''')

    conn.commit()
    cur.close()
    conn.close()