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

def set_sps(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Stored Porcedure para sala
    cur.execute('''
                DROP TRIGGER IF EXISTS verifica_mapa_sala ON sala;

                CREATE TRIGGER verifica_mapa_sala
                BEFORE INSERT ON sala
                FOR EACH ROW EXECUTE PROCEDURE verifica_mapa();
                ''')
    
    conn.commit()
    cur.close()
    conn.close()