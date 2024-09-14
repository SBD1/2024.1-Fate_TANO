import psycopg2
import tkinter as tk
from tkinter import ttk
from components import db_config

# Função para criar um banco de dados se ele não existir
def create_database_if_not_exists(db_name):
    conn = psycopg2.connect(
        host='localhost',
        port='5432',
        user='your_user',
        password='your_password',
        dbname='postgres'
    )
    conn.autocommit = True
    cur = conn.cursor()
    cur.execute(f"SELECT 1 FROM pg_database WHERE datname = '{db_name}'")
    exists = cur.fetchone()

    if not exists:
        cur.execute(f'CREATE DATABASE {db_name};')
        print(f"Banco de dados {db_name} criado.")
   

    cur.close()
    conn.close()

# Conexão com o banco de dados
def get_game_db_connection(game_number):
    db_name = f'game_{game_number}_db'
    create_database_if_not_exists(db_name)
    return psycopg2.connect(
        host='localhost',
        port='5432',
        user='your_user',
        password='your_password',
        dbname=db_name
    )

# Funções do jogo
def move_player(conn, direction):
    cur = conn.cursor()

    if direction == "up":
        cur.execute('UPDATE personagem p SET localizacao = s.local_n FROM sala s WHERE p.localizacao = s.id_local')
    elif direction == "down":
        cur.execute('UPDATE personagem p SET localizacao = s.local_s FROM sala s WHERE p.localizacao = s.id_local')
    elif direction == "right":
        cur.execute('UPDATE personagem p SET localizacao = s.local_l FROM sala s WHERE p.localizacao = s.id_local')
    elif direction == "left":
        cur.execute('UPDATE personagem p SET localizacao = s.local_o FROM sala s WHERE p.localizacao = s.id_local')
    cur.execute('SELECT localizacao FROM personagem')
    id_local = cur.fetchone()
    conn.commit()
    cur.close()
    return f"Player moved {direction}{id_local}"

def attack(conn):
    cur = conn.cursor()
    cur.execute('SELECT s.id_local, s.local_n, s.local_s, s.local_l, s.local_o FROM sala s, personagem p WHERE s.id_local = p.localizacao')
    sala = cur.fetchone()
    conn.commit()
    cur.close()
    return f"Player located in {sala[0]}\nNorth {sala[1]}\nSouth {sala[2]}\nEast {sala[3]}\nWest {sala[4]}"
    

# Interface gráfica
class GameApp(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("Offline MUD Game com Pausa")
        self.geometry("400x300")

        self.game_number = None

        # Frame inicial (para criar ou carregar o jogo)
        self.start_frame = ttk.Frame(self)
        self.start_frame.grid(row=0, column=0, sticky="nsew")

        start_label = ttk.Label(self.start_frame, text="Bem-vindo ao MUD Game!")
        start_label.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

        ttk.Button(self.start_frame, text="Criar Novo Jogo", command=self.create_new_game).grid(row=1, column=0, padx=10, pady=10)
        ttk.Button(self.start_frame, text="Carregar Jogo", command=self.load_game).grid(row=1, column=1, padx=10, pady=10)

        # Frame de jogo
        self.game_frame = ttk.Frame(self)

        self.status_text = tk.Text(self.game_frame, height=10, width=50, state=tk.DISABLED)
        self.status_text.grid(row=0, column=0, columnspan=2, padx=5, pady=5)

        ttk.Button(self.game_frame, text="Move Up", command=lambda: self.move("up")).grid(row=1, column=0, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Move Down", command=lambda: self.move("down")).grid(row=1, column=1, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Move Left", command=lambda: self.move("left")).grid(row=2, column=0, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Move Right", command=lambda: self.move("right")).grid(row=2, column=1, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Ver Local", command=self.attack).grid(row=3, column=0, columnspan=2, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Pause", command=self.show_pause_screen).grid(row=4, column=0, columnspan=2, padx=5, pady=5, sticky=tk.W+tk.E)

        # Frame de pausa
        self.pause_frame = ttk.Frame(self)
        
        pause_label = ttk.Label(self.pause_frame, text="Jogo Pausado")
        pause_label.grid(row=0, column=0, padx=20, pady=20)
        
        ttk.Button(self.pause_frame, text="Voltar ao Jogo", command=self.show_game_screen).grid(row=1, column=0, padx=5, pady=5)

        # Mostrar a tela inicial primeiro
        self.show_start_screen()

    def show_start_screen(self):
        """Mostra a tela inicial (Criar/Carregar Jogo)."""
        self.game_frame.grid_forget()
        self.pause_frame.grid_forget()
        self.start_frame.grid(row=0, column=0, sticky="nsew")

    def show_game_screen(self):
        """Mostra a tela de jogo."""
        self.pause_frame.grid_forget()
        self.start_frame.grid_forget()
        self.game_frame.grid(row=0, column=0, sticky="nsew")

    def show_pause_screen(self):
        """Mostra a tela de pausa."""
        self.game_frame.grid_forget()
        self.pause_frame.grid(row=0, column=0, sticky="nsew")

    def update_status(self, message):
        """Atualiza a área de status do jogo."""
        self.status_text.config(state=tk.NORMAL)
        self.status_text.insert(tk.END, message + "\n")
        self.status_text.config(state=tk.DISABLED)
        self.status_text.yview(tk.END)

    def send_game_command(self, command):
        """Envia um comando do jogador."""
        conn = get_game_db_connection(self.game_number)
        if command.startswith("move"):
            direction = command.split()[1]
            response = move_player(conn, direction)
        elif command == "attack":
            response = attack(conn)
        else:
            response = "Unknown command."
        conn.close()
        self.update_status(response)

    def move(self, direction):
        """Movimenta o jogador."""
        command = f"move {direction}"
        self.send_game_command(command)

    def attack(self):
        """Ataca um inimigo."""
        command = "attack"
        self.send_game_command(command)

    def create_new_game(self):
        """Cria um novo jogo."""
        self.game_number = 1  # Aqui você pode adicionar lógica para criar jogos com IDs diferentes
        self.initialize_database()
        self.show_game_screen()

    def load_game(self):
        """Carrega um jogo existente."""
        self.game_number = 1  # Aqui você pode adicionar lógica para carregar jogos diferentes
        self.initialize_database()
        self.show_game_screen()

    def initialize_database(self):
        """Inicializa o banco de dados do jogo."""
        conn = get_game_db_connection(self.game_number)
        cur = conn.cursor()

        # Criar tabelas
        db_config.criar_tabelas(self)
        
        db_config.inseri_tabelas(self)

        conn.commit()
        cur.close()
        conn.close()


if __name__ == "__main__":
    app = GameApp()
    app.mainloop()
