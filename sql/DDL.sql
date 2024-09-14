

--- CREATES
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

CREATE TABLE habilidade (
    id_habilidade INT PRIMARY KEY,
    tipo_habilidade TIPO_HABILIDADE NOT NULL,
    tipo_classe TIPO_CLASSE NOT NULL,
    numero INT NOT NULL,
    descricao VARCHAR(255),
    cooldown INT,
    custo_mana INT NOT NULL,
    ranque RANK_ NOT NULL
);

CREATE TABLE habilidade_extra (
    id_habilidade_extra INT PRIMARY KEY,
    tipo_habilidade TIPO_HABILIDADE NOT NULL,
    tipo_exclasse TIPO_EXCLASSE NOT NULL,
    numero INT NOT NULL,
    descricao VARCHAR(255),
    cooldown INT,
    custo_mana INT NOT NULL,
    ranque RANK_ NOT NULL,
    CHECK(ranque IN ('ex')),
    CHECK(tipo_habilidade IN ('noble_phantasm'))
);

CREATE TABLE classe (
    id_classe INT PRIMARY KEY,
    tipo_classe TIPO_CLASSE NOT NULL,
    b_inteligencia INT NOT NULL,
    b_destreza INT NOT NULL,
    b_sabedoria INT NOT NULL,
    b_forca INT NOT NULL,
    b_defesa INT NOT NULL,
    b_carisma INT NOT NULL,
    info VARCHAR(255)
);

CREATE TABLE extra_classe (
    id_exclasse INT PRIMARY KEY,
    tipo_exclasse TIPO_EXCLASSE NOT NULL,
    b_inteligencia INT NOT NULL,
    b_destreza INT NOT NULL,
    b_sabedoria INT NOT NULL,
    b_forca INT NOT NULL,
    b_defesa INT NOT NULL,
    b_carisma INT NOT NULL,
    noble_phantasm INT REFERENCES habilidade_extra(id_habilidade_extra),
    tipo_habilidade TIPO_HABILIDADE,
    info VARCHAR(255),
    CHECK(tipo_habilidade in ('noble_phantasm'))
);

CREATE TABLE mundo (
    id_mundo INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(255),
    mundo_conecta INT,
    mundo_conectado INT,
    FOREIGN KEY (mundo_conecta) REFERENCES mundo(id_mundo),
    FOREIGN KEY (mundo_conectado) REFERENCES mundo(id_mundo)
);

CREATE TABLE regiao (
    id_regiao INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(100),
    mundo INT NOT NULL,
    regiao_n INT,
    regiao_s INT,
    regiao_l INT,
    regiao_o INT,
    FOREIGN KEY (mundo) REFERENCES mundo(id_mundo),
    FOREIGN KEY (regiao_n) REFERENCES regiao(id_regiao),
    FOREIGN KEY (regiao_s) REFERENCES regiao(id_regiao),
    FOREIGN KEY (regiao_l) REFERENCES regiao(id_regiao),
    FOREIGN KEY (regiao_o) REFERENCES regiao(id_regiao)
);

CREATE table qtd_salas (
    id_local INT PRIMARY KEY,
    UNIQUE(id_local)
);

CREATE TABLE sala (
    id_local INT REFERENCES qtd_salas(id_local),
    tipo_local LOCAL_TIPO NOT NULL,
    tamanho INT NOT NULL,
	regiao INT NOT NULL,
    local_n INT,
    local_s INT,
    local_l INT,
    local_o INT,
    FOREIGN KEY (regiao) REFERENCES regiao(id_regiao)
);


CREATE TABLE caverna (
    local_caverna INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    num_caverna INT NOT NULL,
    FOREIGN KEY (local_caverna) REFERENCES qtd_salas(id_local)
);

CREATE TABLE masmorra (
    local_masmorra INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    num_masmorra INT NOT NULL,
    ranque RANK_ NOT NULL,
    FOREIGN KEY (local_masmorra) REFERENCES qtd_salas(id_local)
);

CREATE TABLE residencia (
    residencia_npc INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    ranque RANK_ NOT NULL,
    tipo_residencia TIPO_RESIDENCIA NOT NULL,
    recompor_mana INT,
    recompor_vida INT,
    tipo_loja TIPO_ITEM,
    FOREIGN KEY (residencia_npc) REFERENCES qtd_salas(id_local)
);

CREATE TABLE personagem (
    id_personagem INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    exp_atual INT NOT NULL,
    exp_max INT NOT NULL,
    classe INT REFERENCES classe(id_classe),
    exclasse INT REFERENCES extra_classe(id_exclasse),
    mana_max INT NOT NULL,
    mana_atual INT NOT NULL,
    vida_max INT NOT NULL,
    vida_atual INT NOT NULL,
    dinheiro INT,
    localizacao INT NOT NULL,
    FOREIGN KEY (localizacao) REFERENCES qtd_salas(id_local)
);

CREATE TABLE atributos (
    personagem INT PRIMARY KEY,
    inteligencia INT NOT NULL,
    destreza INT NOT NULL,
    sabedoria INT NOT NULL,
    forca INT NOT NULL,
    defesa INT NOT NULL,
    carisma INT NOT NULL,
    FOREIGN KEY (personagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE personagem_equip (
    personagem INT PRIMARY KEY,
    cabeca INT,
    torso INT,
    mao_direita INT,
    mao_esquerda INT,
    duas_maos INT,
    calca INT,
    pe INT,
    acessorio_1 INT,
    acessorio_2 INT,
    acessorio_3 INT,
    FOREIGN KEY (personagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE inventario (
    id_inventario INT PRIMARY KEY,
    personagem INT NOT NULL,
    capacidade_max INT NOT NULL,
    FOREIGN KEY (personagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE habilidade_personagem (
    habilidade INT PRIMARY KEY,
    personagem INT NOT NULL REFERENCES personagem(id_personagem),
    nivel INT NOT NULL,
    exp_max INT NOT NULL,
    exp_atual INT NOT NULL,
    FOREIGN KEY (habilidade) REFERENCES habilidade(id_habilidade)
);

CREATE TABLE evolucao_habilidade (
    id_evolucao INT PRIMARY KEY,
    nivel_req INT NOT NULL,
    exp_req INT NOT NULL,
    bonus_num INT NOT NULL,
	habilidade INT NOT NULL REFERENCES habilidade_personagem(habilidade),
	UNIQUE(habilidade)
);

CREATE TABLE habilidade_evoluida (
    habilidade INT REFERENCES evolucao_habilidade(habilidade),
    evolucao_habilidade INT REFERENCES evolucao_habilidade(id_evolucao)
);

CREATE TABLE npc (
    id_npc INT PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    alinhamento ALIGN NOT NULL,
    biografia VARCHAR(255),
    residencia INT NOT NULL,
    qtd_iteracao INT,
    FOREIGN KEY (residencia) REFERENCES residencia(residencia_npc)
);

CREATE TABLE dialogo (
    id_dialogo INT PRIMARY KEY,
    fala VARCHAR(255)
);

CREATE TABLE inimigo (
    id_inimigo INT PRIMARY KEY,
    tipo_inimigo TIPO_INIMIGO NOT NULL
);

CREATE TABLE inimigo_comum (
    inimigo INT PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    vida INT NOT NULL,
    dano INT NOT NULL,
    qtd_exp INT NOT NULL,
    info VARCHAR(100),
    ranque RANK_ NOT NULL,
    FOREIGN KEY (inimigo) REFERENCES inimigo(id_inimigo)
);

CREATE TABLE inimigo_boss (
    inimigo INT PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    vida INT NOT NULL,
    dano INT NOT NULL,
    qtd_exp INT NOT NULL,
    biografia VARCHAR(255),
    ranque RANK_ NOT NULL,
    tipo_exclasse TIPO_EXCLASSE NOT NULL,
    vantagem INT NOT NULL,
    desvantagem INT NOT NULL,
    FOREIGN KEY (inimigo) REFERENCES inimigo(id_inimigo)
);

CREATE TABLE instancia_inimigo (
    id_instancia_inimigo INT PRIMARY KEY,
    inimigo INT NOT NULL,
    tipo_inimigo TIPO_INIMIGO NOT NULL,
    FOREIGN KEY (inimigo) REFERENCES inimigo(id_inimigo)
);

CREATE TABLE item (
    id_item INT PRIMARY KEY,
    tipo_item TIPO_ITEM NOT NULL
);

CREATE TABLE material (
    item INT PRIMARY KEY,
    nome CHAR(20),
    valor INT NOT NULL,
    ranque RANK_ NOT NULL,
    info VARCHAR(100),
    tipo_material TIPO_MATERIAL NOT NULL,
    FOREIGN KEY (item) REFERENCES item(id_item)
);


CREATE TABLE consumivel (
    item INT PRIMARY KEY,
    nome CHAR(20),
    valor INT NOT NULL,
    ranque RANK_ NOT NULL,
    info VARCHAR(100),
    tipo_consumivel TIPO_CONSUMIVEL NOT NULL,
    b_inteligencia INT NOT NULL,
    b_destreza INT NOT NULL,
    b_sabedoria INT NOT NULL,
    b_forca INT NOT NULL,
    b_defesa INT NOT NULL,
    b_carisma INT NOT NULL,
    FOREIGN KEY (item) REFERENCES item(id_item)
);

CREATE TABLE consumivel_habilidade (
    consumivel INT PRIMARY KEY,
    tipo_consumivel TIPO_CONSUMIVEL NOT NULL,
    habilidade INT NOT NULL REFERENCES habilidade(id_habilidade),
    CHECK(tipo_consumivel IN ('pergaminho'))
);

CREATE TABLE acessorio (
    item INT PRIMARY KEY,
    nome CHAR(20),
    valor INT NOT NULL,
    ranque RANK_ NOT NULL,
    descricao VARCHAR(100),
    nivel INT NOT NULL,
    b_inteligencia INT NOT NULL,
    b_destreza INT NOT NULL,
    b_sabedoria INT NOT NULL,
    b_forca INT NOT NULL,
    b_defesa INT NOT NULL,
    b_carisma INT NOT NULL,
    habilidade_especial INT REFERENCES habilidade(id_habilidade),
    tipo_habilidade TIPO_HABILIDADE,
    FOREIGN KEY (item) REFERENCES item(id_item),
    CHECK(tipo_habilidade IN ('habilidade_especial'))
);

CREATE TABLE arma (
    item INT PRIMARY KEY,
    nome CHAR(20),
    valor INT NOT NULL,
    ranque RANK_ NOT NULL,
    info VARCHAR(100),
    nivel INT NOT NULL,
    tipo_classe TIPO_CLASSE NOT NULL,
    dano INT NOT NULL,
    FOREIGN KEY (item) REFERENCES item(id_item)
);

CREATE TABLE arma_habilidade (
    id_arma_habilidade INT PRIMARY KEY,
    arma INT REFERENCES arma(item),
    habilidade INT REFERENCES habilidade(id_habilidade),
    tipo_habilidade TIPO_HABILIDADE NOT NULL,
    CHECK(tipo_habilidade IN ('habilidade_especial','noble_phantasm'))
);

CREATE TABLE evolucao_arma (
    id_evolucao INT PRIMARY KEY,
    bonus_dano INT NOT NULL,
    bonus_hdano INT NOT NULL,
    arma INT NOT NULL REFERENCES arma(item),
    tipo_item TIPO_ITEM NOT NULL,
    num_evolucao INT,
    CHECK(tipo_item IN ('arma')),
	UNIQUE(arma)
);

CREATE TABLE material_req (
    material INT PRIMARY KEY,
    evolucao INT REFERENCES evolucao_arma(id_evolucao),
    qtd INT,
    FOREIGN KEY (material) REFERENCES material(item)
);

CREATE TABLE arma_evoluida (
    arma INT REFERENCES evolucao_arma(arma),
    evolucao_arma INT REFERENCES evolucao_arma(id_evolucao)
);


CREATE TABLE conjunto_armadura (
    id_conjunto INT PRIMARY KEY,
    noble_phantasm INT REFERENCES habilidade(id_habilidade),
    tipo_habilidade TIPO_HABILIDADE,
    CHECK(tipo_habilidade IN ('noble_phantasm'))
);

CREATE TABLE armadura (
    item INT PRIMARY KEY,
    nome CHAR(20),
    valor INT NOT NULL,
    ranque RANK_ NOT NULL,
    info VARCHAR(100),
    nivel INT NOT NULL,
    tipo_armadura TIPO_ARMADURA NOT NULL,
    tipo_classe TIPO_CLASSE NOT NULL,
    b_inteligencia INT NOT NULL,
    b_destreza INT NOT NULL,
    b_sabedoria INT NOT NULL,
    b_forca INT NOT NULL,
    b_defesa INT NOT NULL,
    b_carisma INT NOT NULL,
    tipo_habilidade TIPO_HABILIDADE,
	habilidade_especial INT REFERENCES habilidade(id_habilidade),
    FOREIGN KEY (item) REFERENCES item(id_item),
    CHECK(tipo_habilidade in ('habilidade_especial'))
);

CREATE TABLE inventario_item (
    item INT REFERENCES item(id_item),
    inventario INT REFERENCES inventario(id_inventario),
    tipo_item TIPO_ITEM,
    qtd INT
);

CREATE TABLE missao (
    id_missao INT PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    descricao VARCHAR(100),
    nivel_req INT NOT NULL,
    ranque RANK_ NOT NULL,
    isRepetivel BOOLEAN NOT NULL,
    isRealizada BOOLEAN NOT NULL
);

CREATE TABLE missao_doing (
    missao INT PRIMARY KEY,
    req_atual INT NOT NULL,
    req_esperado INT NOT NULL,
    FOREIGN KEY (missao) REFERENCES missao(id_missao)
);

CREATE TABLE recompensa (
    id_recompensa INT PRIMARY KEY,
    missao INT NOT NULL,
    dinheiro INT NOT NULL,
    FOREIGN KEY (missao) REFERENCES missao(id_missao)
);

CREATE TABLE recompensa_item (
    item INT PRIMARY KEY,
    qtd INT NOT NULL,
    FOREIGN KEY (item) REFERENCES item(id_item)
);

CREATE TABLE dinheiro_e_item (
	recompensa INT REFERENCES recompensa(id_recompensa),
	recompensa_item INT REFERENCES recompensa_item(item)
);

CREATE TABLE missao_dialogo (
    missao INT PRIMARY KEY,
    dialogo INT NOT NULL REFERENCES dialogo(id_dialogo),
    taLiberado BOOLEAN NOT NULL,
    FOREIGN KEY (missao) REFERENCES missao(id_missao)
);



CREATE TABLE estoque (
    id_estoque INT PRIMARY KEY,
    tipo_local TIPO_RESIDENCIA NOT NULL,
    loja INT NOT NULL,
    FOREIGN KEY (loja) REFERENCES residencia(residencia_npc),
    CHECK(tipo_local IN ('loja'))
);

CREATE TABLE carrinho (
    item INT REFERENCES item(id_item),
    loja INT REFERENCES residencia(residencia_npc),
    tipo_loja TIPO_ITEM,
    qtd INT
);

CREATE TABLE boss_habilidade (
    habilidade INT REFERENCES habilidade(id_habilidade),
    boss INT REFERENCES inimigo(id_inimigo),
    tipo_inimigo TIPO_INIMIGO,
    CHECK(tipo_inimigo in ('boss'))
);

CREATE TABLE fala_npc (
    dialogo INT REFERENCES dialogo(id_dialogo),
    npc INT REFERENCES npc(id_npc),
    momento INT,
    qtd_min_iteracao INT,
    taLiberado BOOLEAN
);

CREATE TABLE fala_personagem (
    dialogo INT REFERENCES dialogo(id_dialogo),
    personagem INT REFERENCES personagem(id_personagem),
    momento INT
);

CREATE TABLE local_inimigo (
    sala INT REFERENCES qtd_salas(id_local),
    inimigo INT REFERENCES instancia_inimigo(id_instancia_inimigo)
);

CREATE TABLE fala_boss (
    dialogo INT REFERENCES dialogo(id_dialogo),
    boss INT REFERENCES inimigo(id_inimigo),
    tipo_inimigo TIPO_INIMIGO NOT NULL,
    momento INT,
    taLiberado BOOLEAN,
    CHECK(tipo_inimigo IN ('boss'))
);

CREATE TABLE item_sala (
    item INT REFERENCES item(id_item),
    sala INT REFERENCES qtd_salas(id_local),
    qtd INT
);

CREATE TABLE npc_missao (
    missao INT REFERENCES missao(id_missao),
    npc INT REFERENCES npc(id_npc),
    qtd_min_iteracao INT,
    atual_qtd_iteracao INT
);

CREATE TABLE luta (
    personagem INT NOT NULL,
    inimigo INT NOT NULL,
    qtd_rodadas INT NOT NULL,
    qtd_acertos INT NOT NULL,
    qtd_erros INT NOT NULL,
    qtd_uso_habilidades INT NOT NULL,
    FOREIGN KEY (personagem) REFERENCES personagem(id_personagem),
    FOREIGN KEY (inimigo) REFERENCES instancia_inimigo(id_instancia_inimigo)
);

CREATE TABLE drop_item (
    item INT REFERENCES item(id_item),
    inimigo INT REFERENCES inimigo(id_inimigo),
    qtd INT
);