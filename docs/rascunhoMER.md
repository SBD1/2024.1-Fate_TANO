# MER

## Sumário MER

- [Entidades e Atributos](#entidades-e-atributos)
- [Relacionamentos e Cardinalidades](#relacionamentos-e-cardinalidades)

## Entidades e Atributos

### Personagem
    Id_personagem
    Nome
    Nivel
    Experiencia
    Proximo_Nivel_Experiencia
    Classe
    Extra_Classe
    Habilidade
    Mana_Max
    Mana_Atual
    Vida_Max
    Vida_Atual
    Dinheiro
        - Fisico (Multivalorado)
            - Inteligencia
            - Destreza
            - Sabedoria
            - Força
            - Defesa
            - Carisma
        - Equipamento (Multivalorado)
            - Cabeca
            - Torso
            - Mao_Direta
            - Mao_Esquerda
            - Duas_Maos
            - Calca
            - Pe
            - Acessorio (Multivalorado)
                - Acessorio_1
                - Acessorio_2
                - Acessorio_3
### Classe
        - Tipo_Classe
        - Bonus (Multivalorado)
            - Inteligencia
            - Destreza
            - Sabedoria
            - Força
            - Defesa
            - Carisma
#### Extra_Classe
        - Tipo_Extra_Classe
        - Bonus (Multivalorado)
            - Inteligencia
            - Destreza
            - Sabedoria
            - Força
            - Defesa
            - Carisma
        - Noble_Phantasm
### Habilidade
        - Id_Habilidade
        - Tipo_Habilidade
        - Classe_Habilidade
        - Valor
        - Descricao
### Evolucao_Habilidade
        - Id_Evolucao
        - Nivel_Requerido
        - Exp_Requerido
        - Material_Requerido
        - Quantidade_Material_Requerido
        - Bonus_Dano
        - Bonus_Dano_Habilidade
### NPC
        - Id_NPC
        - Nome
        - Alinhamento
        - Local_NPC
### Dialogo
        - Id_dialogo
        - Fala
### Inimigo
        - Id_Inimigo
        - Id_Inimigo
        - Nome
        - Vida
        - Dano
        - Tipo_Inimigo
        - Quantidade_Experiencia
        - Comum
            - Info
### Boss
            - Biografia
            - Classe
            - Vantagem
            - Desvantagem
            - Habilidade
### Instancia_Inimigo (Entidade_Fraca)
        - Id_Instancia
        - Id_Inimigo
        - Local
### Item
        - Id_Item
        - Nome
        - Valor
        - Tipo_Item
        - Info
### Equipamento
            - Nivel
            - Tipo_Equipamento
### Armadura
                - Tipo_Armadura
                - Bonus (Multivalorado)
                    - Inteligencia
                    - Destreza
                    - Sabedoria
                    - Força
                    - Defesa
                    - Carisma
                - Tipo_Classe
                - Habilidade_Especial
                - Num_Conjunto
### Arma
                - Evolucao
                - Tipo_Classe
                - Dano
                - Habilidade_Especial_1
                - Habilidade_Especial_2
                - Noble_Phantasm
### Acessorio
                - Bonus (Multivalorado)
                    - Inteligencia
                    - Destreza
                    - Sabedoria
                    - Força
                    - Defesa
                    - Carisma
                - Habilidade_Especial
### Consumivel
            - Tipo_Consumivel
            - Bonus (Multivalorado)
                - Inteligencia
                - Destreza
                - Sabedoria
                - Força
                - Defesa
                - Carisma
            - Habilidade
### Material
            - Tipo_Material
### Evolucao_Arma
        - Id_Evolucao
        - Nivel_Requerido
        - Material_Requerido
        - Quantidade_Material_Requerido
        - Bonus_Dano
        - Bonus_Dano_Habilidade
### Inventario (Entidade Fraca)
        - Id_Inventario
        - Item
        - Quantidade
### Missao
        - Id_Missao
        - Nome
        - Descricao
        - Nivel_Requerido
### Mundo
        - Id_Mundo
        - Nome
        - Descricao
### Regiao
        - Id_Regiao
        - Id_Mundo
        - Nome
        - Descricao
### Local
        - Id_Local
        - Id_Regiao
        - Local_Fechado
### Local_Fechado
        - Id_Local_Fechado
        - Tipo_Local_Fechado
        - Nome
        - Descricao
### Caverna
            - Num_Caverna
### Masmorra
            - Num_Masmorra
### Local_NPC
            - Tipo_Local
            - Id_NPC
### Loja
                - Estoque
### Pousada
                - Recompor_Mana
                - Recompor_Vida
### Oficina
                
                
### Recompensa
        - Id_Recompensa
        - Id_Missao
        - Item
        - Quantidade

## Relacionamentos e Cardinalidades

### Persongem
Personagem tem Classe
  - Personagem pode ter apenas uma entre as sete Classe: 0:1
  - Classe tem 7 classes que o Personagem pode ter: 0:7
Personagem pode ter Extra_Classe
  - Personagem pode ter apenas uma entre as oito Extra_Classes: 0:1
  - Extra_Classe tem 8 classes que o Personagem pode ter: 0:8
Personagem pode possuir Habilidade
  - Personagem pode possuir nenhuma ou várias Habilidade: 0:N
  - Habilidade pertence a um ou a nenhum Personagem: 0:1
Personagem possui Inventario
  - Personagem possui apenas um Inventario: 1:1
  - Inventaria pertence apenas a um Personagem: 1:1
Personagem luta contra Instancia_Inimigo
  - Personagem pode lutar com um ou mais Instancia_Inimigo: 1:N
  - Instancia_Inimigo podem enfrentar um Personagem: 1:1
Personagem está no Local
  - Personagem pode estar apenas em um Local: 1:1
  - Local pode ter um Personagem ou nenhum: 0:1
Personagem realiza Missao
  - Personagem pode realizar nenhuma ou varias Missao: 0:N
  - Missao deve ser realizada por um Personagem: 1:1
Personagem conversa com NPC
  - Personagem pode conversar com nenhum ou com um NPC: 0:N
  - NPC pode conversar com um Personagem: 1:1
Personagem tem Dialogo
  - Personagem tem um ou mais Dialogo: 1:N
  - Dialogo é de um Personagem: 1:1
Personagem pode comprar e vender na Loja
  - Personagem pode comprar e vender em uma ou em varias Loja: 1:N
  - Loja pode comprar e vender para um Personagem: 1:1
Personagem pode recarregar Mana e Vida na Pousada
  - Personagem pode recarregar em uma ou varias Pousada: 1:N
  - Pousada pode recarregar um Personagem: 1:1

### NPC
NPC tem Dialogo
  - NPC tem um ou varios Dialogo: 1:N
  - Dialogo é de um NPC: 1:1
NPC é proprietário de um Local_NPC
  - NPC é propritário de apenas um Local_NPC: 1:1
  - Local_NPC pertence à um NPC: 1:1
NPC pode gerar Missao
  - NPC pode gerar nenhuma ou várias Missao: 0:N
  - Missao pode ser gerado por nenhum ou vários NPC: 0:N

### Inimigo
Inimigo gera Instancia_Inimigo
  - Inimigo gera um ou várias Instancia_Inimigo: 1:N
  - Instancia_Inimigo é gerado por apenas um Inimigo: 1:1
Inimigo é Comum ou Boss
Boss tem Dialogo
  - Boss pode ter um ou vários Dialogo: 1:N
  - Dialogo pertence a um Boss: 1:1
Boss tem Habilidade
  - Boss poder ter um ou várias Habilidade: 1:N
  - Habilidade pertence a um ou a nenhum Boss: 0:1
Instancia_Inimigo pode estar no Local
  - Instancia_Inimigo pode estar em nenhum ou em vários Local: 0:N
  - Local pode ter nenhum ou várias Instancia_Inimigo: 0:N

### Item
Item é Equipamento ou Consumivel ou Material
Item pode estar no Local
  - Pode ter nenhum ou vários Item no Local: 0:N
  - No Local pode ter nenhum ou vários Item: 0:N
Equipamento é Armadura ou Arma ou Acessorio
Armadura pode ter Habilidade
  - Armadura pode ter nenhuma ou uma Habilidade: 0:1
  - Habilidade pertence a nenhuma ou a uma Armadura: 0:1
Arma pode ter Habilidade
  - Arma pode ter nenhuma ou até 3 Habilidade: 0:3
  - Habilidade pertence a nenhuma ou a uma Arma: 0:1
Acessorio pode ter Habilidade
  - Acessorio pode ter uma ou nenhuma Habilidade: 0:1
  - Habilidade pertence a um ou a nenhum Acessorio: 0:1
Arma possui Evolucao_Arma
  - Arma possui nenhuma ou até 5 Evolucao_Arma: 0:5
  - Evolucao_Arma pertence a uma Arma: 1:1
Consumivel pode ter Habilidade
  - Consumivel pode ter uma ou nenhuma Habilidade: 0:1
  - Habilidade pode pertencer a nenhum ou a vários Consumivel: 0:N

### Inventario
Inventario pode possuir Item
  - Inventario pode possuir nenhum ou vários Item: 0:N
  - Item pode pertencer a nenhum ou a um Inventario: 0:1

### Missao
Missao desbloqueia Dialogo
  - Missao desbloqueia um ou mais Dialogo: 1:N
  - Dialogo é desbloqueado por uma ou nenhuma Missao: 0:1

### Mundo
Mundo possui Regiao
  - Mundo possui várias Regiao: 1:N
  - Regiao possui apenas um Mundo: 1:1
Mundo pode ter conexão com Mundo
  - Mundo conecta em um ou nenhum Mundo: 0:1
  - Mundo está conectado em um ou nenhum Mundo: 0:1

### Regiao
Regiao possui Local
  - Regiao possui um ou vários Local: 1:N
  - Local pertence a uma Regiao: 1:1
Regiao pode ter conexão com outra Regiao
  - Regiao pode conectar em uma ou várias Regiao: 1:N
  - Regiao pode estar conectada em uma ou várias Regiao: 1:N

### Local
Local pode possuir Local_Fechado
  - Local pode possuir nenhum ou vários Local_Fechado: 0:N
  - Local_Fechado pertence a um Local: 1:1
Local pode ter conexão com outro Local
  - Local pode conectar em nenhum ou em até 4 Local: 0:4
  - Local pode estar conectado em nenhum ou em até 4 Local: 0:4

### Local_Fechado
Local_Fechado é Caverna ou Masmorra ou Local_NPC
Caverna pode ser mais profunda
  - Caverna pode estar conectado em apenas uma ou em até 4 Caverna: 0:4
  - Caverna pode estar conectado em nenhuma ou em até 4 Caverna: 0:4
Masmorra pode ter níveis de profundidade
  - Masmorra pode conectar em nenhum ou em até 4 Masmorra: 0:4
  - Masmorra pode estar conectado em nenhum ou em até 4 Masmorra: 0:4
Caverna pode possuir Masmorra
  - Caverna pode possuir nenhuma ou várias Masmorra: 0:N
  - Masmorra pertence a nenhuma ou a uma Caverna: 0:1
Local_NPC é Loja, Pousada ou Oficina
Loja tem estoque de Item
  - Loja tem estoque de um ou vários Item: 1:N
  - Item pode estar presente em um ou várias Loja: 1:N

### Habilidade
Habilidade possui Evolucao_Habilidade
  - Habilidade possui nenhuma ou até três Evolucao_Habilidade: 0:3
  - Evolucao_Habilidade pertence à apenas uma Habilidade: 1:1

### Habilidade
Recompensa pode ter Item
  - Recompensa pode ter de 1 a vários Item: 1:N
  - Item pode estar em nenhuma ou várias Recompensa: 1:N