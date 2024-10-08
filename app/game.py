import psycopg2
import tkinter as tk
from tkinter import ttk
from components import db_config
from components import game_function as gf

# Função para criar um banco de dados se ele não existir
def create_database_if_not_exists(db_name):
    conn = psycopg2.connect(
        host='localhost',
        port='5434',
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
        port='5434',
        user='your_user',
        password='your_password',
        dbname=db_name
    )

# Conexão com o banco de dados
def get_game_db_connection_delete(game_number):
    db_name = f'game_{game_number}_db'
    return psycopg2.connect(
        host='localhost',
        port='5434',
        user='your_user',
        password='your_password',
        dbname=db_name
    )

# Funções do jogo
def move_player(conn, direction):
    cur = conn.cursor()

    cur.execute('SELECT movimento_personagem(%s)', (direction,))
    movimento = cur.fetchone()
    cur.execute('SELECT s.id_local, s.local_n, s.local_s, s.local_l, s.local_o FROM sala s, personagem p WHERE s.id_local = p.localizacao')
    sala = cur.fetchone()
    conn.commit()
    cur.close()
    sala = tuple('x' if valor is None else valor for valor in sala)
    return f"""-
-                                   {movimento[0]:^10}
-
-                                      North
-                                      
-                                    {sala[1]:^10}
-
-                     West {sala[4]:>10}{sala[0]:^10}{sala[3]:<10} East
-
-                                    {sala[2]:^10}
-                                      
-                                      South
-
"""

# Interface gráfica
class GameApp(tk.Tk):
    def __init__(self):
        super().__init__()

        largura_tela = self.winfo_screenwidth()
        altura_tela = self.winfo_screenheight()

        proporcao_largura = 0.3
        proporcao_altura = 0.6

        largura_tela = int(largura_tela * proporcao_largura)
        altura_tela = int(altura_tela * proporcao_altura)

        self.title("Fate - The Awakening of The New Order")
        self.geometry(f"{largura_tela}x{altura_tela}")

        self.game_number = None

        # Frame inicial (para criar ou carregar o jogo)
        self.start_frame = ttk.Frame(self)
        self.start_frame.grid(row=0, column=0, sticky="nsew")

        # Configurar as colunas e linhas para expandir
        for i in range(11):
            self.grid_columnconfigure(i, weight=10)
            self.grid_rowconfigure(i, weight=10)

        ttk.Label(self.start_frame).grid(row=0, column=0, padx=150, pady=50)
        ttk.Label(self.start_frame).grid(row=7, column=4, columnspan=2, padx=10, pady=10)
        start_label = ttk.Label(self.start_frame, text="Fate - The Awakening of The New Order")
        start_label.grid(row=5, column=2, columnspan=10, padx=10, pady=10, sticky=tk.E+tk.W)

        ttk.Button(self.start_frame, text="Criar Novo Jogo", command=self.create_new_game).grid(row=6, column=4, padx=10, pady=10, sticky=tk.E+tk.W)
        ttk.Button(self.start_frame, text="Carregar Jogo", command=self.load_game).grid(row=6, column=5, padx=10, pady=10, sticky=tk.E+tk.W)
        ttk.Button(self.start_frame, text="Deletar Jogo", command=self.delete_game).grid(row=8, column=4, columnspan=2, padx=10, pady=10, sticky=tk.E+tk.W)

        # Frame de jogo
        self.game_frame = ttk.Frame(self)

        self.status_text = tk.Text(self.game_frame, height=16, width=80, state=tk.DISABLED)
        self.status_text.grid(row=0, column=0, columnspan=10, padx=50, pady=5)

        ttk.Button(self.game_frame, text="Move Up", command=lambda: self.move("up")).grid(row=1, column=0, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Move Down", command=lambda: self.move("down")).grid(row=1, column=1, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Move Left", command=lambda: self.move("left")).grid(row=2, column=0, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Move Right", command=lambda: self.move("right")).grid(row=2, column=1, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Pause", command=self.show_pause_screen).grid(row=4, column=0, columnspan=2, padx=5, pady=5, sticky=tk.W+tk.E)
        ttk.Button(self.game_frame, text="Menu Inicial", command=self.show_start_screen).grid(row=5, column=0, columnspan=2, padx=5, pady=5, sticky=tk.W+tk.E)

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
        else:
            response = "Unknown command."
        conn.close()
        self.update_status(response)

    def move(self, direction):
        """Movimenta o jogador."""
        self.status_text.config(state=tk.NORMAL)
        self.status_text.delete(1.0, tk.END)
        self.status_text.tag_add("center", "1.0", "end")
        command = f"move {direction}"
        self.send_game_command(command)
        self.status_text.config(state=tk.DISABLED)

    def create_new_game(self):
        """Cria um novo jogo."""
        self.game_number = 1  # Aqui você pode adicionar lógica para criar jogos com IDs diferentes
        self.initialize_database()
        self.show_game_screen()

    def load_game(self):
        """Carrega um jogo existente."""
        self.game_number = 1  # Aqui você pode adicionar lógica para carregar jogos diferentes
        self.show_game_screen()

    def initialize_database(self):
        """Inicializa o banco de dados do jogo."""
        conn = get_game_db_connection(self.game_number)
        cur = conn.cursor()

        # Cria tabelas e insere infromações nelas
        db_config.criar_tabelas(self)
        
        db_config.inseri_tabelas(self)

        conn.commit()
        cur.close()
        conn.close()
    
    def delete_game(self):
        """Inicializa o banco de dados do jogo."""
        conn = get_game_db_connection_delete(self.game_number)
        cur = conn.cursor()

        # Deleta tabelas
        db_config.delete(self)

        conn.commit()
        cur.close()
        conn.close()


if __name__ == "__main__":
    app = GameApp()
    app.mainloop()