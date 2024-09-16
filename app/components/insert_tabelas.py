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

def insert_habilidades(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()
    # Inserindo Habilidades +++++
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()
def insert_classe(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_map(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_personagem(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_he_iInimigo(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_item(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_ch_ea(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_mr_missao(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_md_ri(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()

def insert_di_di(self):
    conn = get_game_db_connection(self.game_number)
    cur = conn.cursor()

    # Inserindo 
    cur.execute('''''')

    conn.commit()
    cur.close()
    conn.close()
