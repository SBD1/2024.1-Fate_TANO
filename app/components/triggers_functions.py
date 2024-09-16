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

                    SELECT NEW.local_n INTO qtd_ids_n FROM sala WHERE id_local = NEW.id_local;
                    SELECT NEW.local_s INTO qtd_ids_s FROM sala WHERE id_local = NEW.id_local;
                    SELECT NEW.local_l INTO qtd_ids_l FROM sala WHERE id_local = NEW.id_local;
                    SELECT NEW.local_o INTO qtd_ids_o FROM sala WHERE id_local = NEW.id_local;

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
                ''')
    
    # Drop Types
    cur.execute('''
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
                ''')

    conn.commit()
    cur.close()
    conn.close()