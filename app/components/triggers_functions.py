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
                ''')
    
    # Drop Tables
    cur.execute('''
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
                ''')

    conn.commit()
    cur.close()
    conn.close()