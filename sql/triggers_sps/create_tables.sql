CREATE OR REPLACE FUNCTION tabelas_habilidades() RETURNS void AS $tabelas_habilidades$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'habilidade') THEN
        EXECUTE 'CREATE TABLE habilidade (
    id_habilidade INT PRIMARY KEY,
    tipo_habilidade TIPO_HABILIDADE NOT NULL,
    tipo_classe TIPO_CLASSE NOT NULL,
    numero INT NOT NULL,
    descricao VARCHAR(255),
    cooldown INT,
    custo_mana INT NOT NULL,
    ranque RANK_ NOT NULL
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'habilidade_extra') THEN
        EXECUTE 'CREATE TABLE habilidade_extra (
    id_habilidade_extra INT PRIMARY KEY,
    tipo_habilidade TIPO_HABILIDADE NOT NULL,
    tipo_exclasse TIPO_EXCLASSE NOT NULL,
    numero INT NOT NULL,
    descricao VARCHAR(255),
    cooldown INT,
    custo_mana INT NOT NULL,
    ranque RANK_ NOT NULL,
    CHECK(ranque IN (''ex'')),
    CHECK(tipo_habilidade IN (''noble_phantasm''))
);';
    END IF;
END;
$tabelas_habilidades$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tabelas_classe() RETURNS void AS $tabelas_classe$
BEGIN

    IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'classe') THEN
        EXECUTE 'CREATE TABLE classe (
    id_classe INT PRIMARY KEY,
    tipo_classe TIPO_CLASSE NOT NULL,
    b_inteligencia INT NOT NULL,
    b_destreza INT NOT NULL,
    b_sabedoria INT NOT NULL,
    b_forca INT NOT NULL,
    b_defesa INT NOT NULL,
    b_carisma INT NOT NULL,
    info VARCHAR(255)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'extra_classe') THEN
        EXECUTE 'CREATE TABLE extra_classe (
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
    CHECK(tipo_habilidade in (''noble_phantasm''))
);';
    END IF;

END;
$tabelas_classe$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tabelas_mapa() RETURNS void AS $tabelas_mapa$
BEGIN

    IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'mundo') THEN
        EXECUTE 'CREATE TABLE mundo (
    id_mundo INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(255),
    mundo_conecta INT,
    mundo_conectado INT,
    FOREIGN KEY (mundo_conecta) REFERENCES mundo(id_mundo),
    FOREIGN KEY (mundo_conectado) REFERENCES mundo(id_mundo)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'regiao') THEN
        EXECUTE 'CREATE TABLE regiao (
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
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'qtd_salas') THEN
        EXECUTE 'CREATE table qtd_salas (
    id_local INT PRIMARY KEY,
    UNIQUE(id_local)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'sala') THEN
        EXECUTE 'CREATE TABLE sala (
    id_local INT REFERENCES qtd_salas(id_local),
    tipo_local LOCAL_TIPO NOT NULL,
    tamanho INT NOT NULL,
	regiao INT NOT NULL,
    local_n INT,
    local_s INT,
    local_l INT,
    local_o INT,
    FOREIGN KEY (regiao) REFERENCES regiao(id_regiao)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'caverna') THEN
        EXECUTE 'CREATE TABLE caverna (
    local_caverna INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    num_caverna INT NOT NULL,
    FOREIGN KEY (local_caverna) REFERENCES qtd_salas(id_local)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'masmorra') THEN
        EXECUTE 'CREATE TABLE masmorra (
    local_masmorra INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    num_masmorra INT NOT NULL,
    ranque RANK_ NOT NULL,
    FOREIGN KEY (local_masmorra) REFERENCES qtd_salas(id_local)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'residencia') THEN
        EXECUTE 'CREATE TABLE residencia (
    residencia_npc INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    ranque RANK_ NOT NULL,
    tipo_residencia TIPO_RESIDENCIA NOT NULL,
    recompor_mana INT,
    recompor_vida INT,
    tipo_loja TIPO_ITEM,
    FOREIGN KEY (residencia_npc) REFERENCES qtd_salas(id_local)
);';
    END IF;

END;
$tabelas_mapa$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tabelas_personagem() RETURNS void AS $tabelas_personagem$
BEGIN

    IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'personagem') THEN
        EXECUTE 'CREATE TABLE personagem (
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
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'atributos') THEN
        EXECUTE 'CREATE TABLE atributos (
    personagem INT PRIMARY KEY,
    inteligencia INT NOT NULL,
    destreza INT NOT NULL,
    sabedoria INT NOT NULL,
    forca INT NOT NULL,
    defesa INT NOT NULL,
    carisma INT NOT NULL,
    FOREIGN KEY (personagem) REFERENCES personagem(id_personagem)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'personagem_equip') THEN
        EXECUTE 'CREATE TABLE personagem_equip (
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
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'inventario') THEN
        EXECUTE 'CREATE TABLE inventario (
    id_inventario INT PRIMARY KEY,
    personagem INT NOT NULL,
    capacidade_max INT NOT NULL,
    FOREIGN KEY (personagem) REFERENCES personagem(id_personagem)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'habilidade_personagem') THEN
        EXECUTE 'CREATE TABLE habilidade_personagem (
    habilidade INT PRIMARY KEY,
    personagem INT NOT NULL REFERENCES personagem(id_personagem),
    nivel INT NOT NULL,
    exp_max INT NOT NULL,
    exp_atual INT NOT NULL,
    FOREIGN KEY (habilidade) REFERENCES habilidade(id_habilidade)
);';
    END IF;
    IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'evolucao_habilidade') THEN
        EXECUTE 'CREATE TABLE evolucao_habilidade (
    id_evolucao INT PRIMARY KEY,
    nivel_req INT NOT NULL,
    exp_req INT NOT NULL,
    bonus_num INT NOT NULL,
	habilidade INT NOT NULL REFERENCES habilidade_personagem(habilidade),
	UNIQUE(habilidade)
);';
    END IF;

END;
$tabelas_personagem$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION criar_tabelas() RETURNS void AS $criar_tabelas$
BEGIN
	
	
	
	
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'habilidade_evoluida') THEN
        EXECUTE 'CREATE TABLE habilidade_evoluida (
    habilidade INT REFERENCES evolucao_habilidade(habilidade),
    evolucao_habilidade INT REFERENCES evolucao_habilidade(id_evolucao)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'npc') THEN
        EXECUTE 'CREATE TABLE npc (
    id_npc INT PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    alinhamento ALIGN NOT NULL,
    biografia VARCHAR(255),
    residencia INT NOT NULL,
    qtd_iteracao INT,
    FOREIGN KEY (residencia) REFERENCES residencia(residencia_npc)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'dialogo') THEN
        EXECUTE 'CREATE TABLE dialogo (
    id_dialogo INT PRIMARY KEY,
    fala VARCHAR(255)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'inimigo') THEN
        EXECUTE 'CREATE TABLE inimigo (
    id_inimigo INT PRIMARY KEY,
    tipo_inimigo TIPO_INIMIGO NOT NULL
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'inimigo_comum') THEN
        EXECUTE 'CREATE TABLE inimigo_comum (
    inimigo INT PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    vida INT NOT NULL,
    dano INT NOT NULL,
    qtd_exp INT NOT NULL,
    info VARCHAR(100),
    ranque RANK_ NOT NULL,
    FOREIGN KEY (inimigo) REFERENCES inimigo(id_inimigo)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'inimigo_boss') THEN
        EXECUTE 'CREATE TABLE inimigo_boss (
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
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'instancia_inimigo') THEN
        EXECUTE 'CREATE TABLE instancia_inimigo (
    id_instancia_inimigo INT PRIMARY KEY,
    inimigo INT NOT NULL,
    tipo_inimigo TIPO_INIMIGO NOT NULL,
    FOREIGN KEY (inimigo) REFERENCES inimigo(id_inimigo)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'item') THEN
        EXECUTE 'CREATE TABLE item (
    id_item INT PRIMARY KEY,
    tipo_item TIPO_ITEM NOT NULL
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'material') THEN
        EXECUTE 'CREATE TABLE material (
    item INT PRIMARY KEY,
    nome CHAR(20),
    valor INT NOT NULL,
    ranque RANK_ NOT NULL,
    info VARCHAR(100),
    tipo_material TIPO_MATERIAL NOT NULL,
    FOREIGN KEY (item) REFERENCES item(id_item)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'consumivel') THEN
        EXECUTE 'CREATE TABLE consumivel (
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
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'consumivel_habilidade') THEN
        EXECUTE 'CREATE TABLE consumivel_habilidade (
    consumivel INT PRIMARY KEY,
    tipo_consumivel TIPO_CONSUMIVEL NOT NULL,
    habilidade INT NOT NULL REFERENCES habilidade(id_habilidade),
    CHECK(tipo_consumivel IN (''pergaminho''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'acessorio') THEN
        EXECUTE 'CREATE TABLE acessorio (
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
    CHECK(tipo_habilidade IN (''habilidade_especial''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'arma') THEN
        EXECUTE 'CREATE TABLE arma (
    item INT PRIMARY KEY,
    nome CHAR(20),
    valor INT NOT NULL,
    ranque RANK_ NOT NULL,
    info VARCHAR(100),
    nivel INT NOT NULL,
    tipo_classe TIPO_CLASSE NOT NULL,
    dano INT NOT NULL,
    FOREIGN KEY (item) REFERENCES item(id_item)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'arma_habilidade') THEN
        EXECUTE 'CREATE TABLE arma_habilidade (
    id_arma_habilidade INT PRIMARY KEY,
    arma INT REFERENCES arma(item),
    habilidade INT REFERENCES habilidade(id_habilidade),
    tipo_habilidade TIPO_HABILIDADE NOT NULL,
    CHECK(tipo_habilidade IN (''habilidade_especial'',''noble_phantasm''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'evolucao_arma') THEN
        EXECUTE 'CREATE TABLE evolucao_arma (
    id_evolucao INT PRIMARY KEY,
    bonus_dano INT NOT NULL,
    bonus_hdano INT NOT NULL,
    arma INT NOT NULL REFERENCES arma(item),
    tipo_item TIPO_ITEM NOT NULL,
    num_evolucao INT,
    CHECK(tipo_item IN (''arma'')),
	UNIQUE(arma)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'material_req') THEN
        EXECUTE 'CREATE TABLE material_req (
    material INT PRIMARY KEY,
    evolucao INT REFERENCES evolucao_arma(id_evolucao),
    qtd INT,
    FOREIGN KEY (material) REFERENCES material(item)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'arma_evoluida') THEN
        EXECUTE 'CREATE TABLE arma_evoluida (
    arma INT REFERENCES evolucao_arma(arma),
    evolucao_arma INT REFERENCES evolucao_arma(id_evolucao)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'conjunto_armadura') THEN
        EXECUTE 'CREATE TABLE conjunto_armadura (
    id_conjunto INT PRIMARY KEY,
    noble_phantasm INT REFERENCES habilidade(id_habilidade),
    tipo_habilidade TIPO_HABILIDADE,
    CHECK(tipo_habilidade IN (''noble_phantasm''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'armadura') THEN
        EXECUTE 'CREATE TABLE armadura (
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
    CHECK(tipo_habilidade in (''habilidade_especial''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'inventario_item') THEN
        EXECUTE 'CREATE TABLE inventario_item (
    item INT REFERENCES item(id_item),
    inventario INT REFERENCES inventario(id_inventario),
    tipo_item TIPO_ITEM,
    qtd INT
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'missao') THEN
        EXECUTE 'CREATE TABLE missao (
    id_missao INT PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    descricao VARCHAR(100),
    nivel_req INT NOT NULL,
    ranque RANK_ NOT NULL,
    isRepetivel BOOLEAN NOT NULL,
    isRealizada BOOLEAN NOT NULL
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'missao_doing') THEN
        EXECUTE 'CREATE TABLE missao_doing (
    missao INT PRIMARY KEY,
    req_atual INT NOT NULL,
    req_esperado INT NOT NULL,
    FOREIGN KEY (missao) REFERENCES missao(id_missao)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'recompensa') THEN
        EXECUTE 'CREATE TABLE recompensa (
    id_recompensa INT PRIMARY KEY,
    missao INT NOT NULL,
    dinheiro INT NOT NULL,
    FOREIGN KEY (missao) REFERENCES missao(id_missao)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'recompensa_item') THEN
        EXECUTE 'CREATE TABLE recompensa_item (
    item INT PRIMARY KEY,
    qtd INT NOT NULL,
    FOREIGN KEY (item) REFERENCES item(id_item)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'dinheiro_e_item') THEN
        EXECUTE 'CREATE TABLE dinheiro_e_item (
	recompensa INT REFERENCES recompensa(id_recompensa),
	recompensa_item INT REFERENCES recompensa_item(item)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'missao_dialogo') THEN
        EXECUTE 'CREATE TABLE missao_dialogo (
    missao INT PRIMARY KEY,
    dialogo INT NOT NULL REFERENCES dialogo(id_dialogo),
    taLiberado BOOLEAN NOT NULL,
    FOREIGN KEY (missao) REFERENCES missao(id_missao)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'estoque') THEN
        EXECUTE 'CREATE TABLE estoque (
    id_estoque INT PRIMARY KEY,
    tipo_local TIPO_RESIDENCIA NOT NULL,
    loja INT NOT NULL,
    FOREIGN KEY (loja) REFERENCES residencia(residencia_npc),
    CHECK(tipo_local IN (''loja''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'carrinho') THEN
        EXECUTE 'CREATE TABLE carrinho (
    item INT REFERENCES item(id_item),
    loja INT REFERENCES residencia(residencia_npc),
    tipo_loja TIPO_ITEM,
    qtd INT
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'boss_habilidade') THEN
        EXECUTE 'CREATE TABLE boss_habilidade (
    habilidade INT REFERENCES habilidade(id_habilidade),
    boss INT REFERENCES inimigo(id_inimigo),
    tipo_inimigo TIPO_INIMIGO,
    CHECK(tipo_inimigo in (''boss''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'fala_npc') THEN
        EXECUTE 'CREATE TABLE fala_npc (
    dialogo INT REFERENCES dialogo(id_dialogo),
    npc INT REFERENCES npc(id_npc),
    momento INT,
    qtd_min_iteracao INT,
    taLiberado BOOLEAN
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'fala_personagem') THEN
        EXECUTE 'CREATE TABLE fala_personagem (
    dialogo INT REFERENCES dialogo(id_dialogo),
    personagem INT REFERENCES personagem(id_personagem),
    momento INT
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'local_inimigo') THEN
        EXECUTE 'CREATE TABLE local_inimigo (
    sala INT REFERENCES qtd_salas(id_local),
    inimigo INT REFERENCES instancia_inimigo(id_instancia_inimigo)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'fala_boss') THEN
        EXECUTE 'CREATE TABLE fala_boss (
    dialogo INT REFERENCES dialogo(id_dialogo),
    boss INT REFERENCES inimigo(id_inimigo),
    tipo_inimigo TIPO_INIMIGO NOT NULL,
    momento INT,
    taLiberado BOOLEAN,
    CHECK(tipo_inimigo IN (''boss''))
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'item_sala') THEN
        EXECUTE 'CREATE TABLE item_sala (
    item INT REFERENCES item(id_item),
    sala INT REFERENCES qtd_salas(id_local),
    qtd INT
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'npc_missao') THEN
        EXECUTE 'CREATE TABLE npc_missao (
    missao INT REFERENCES missao(id_missao),
    npc INT REFERENCES npc(id_npc),
    qtd_min_iteracao INT,
    atual_qtd_iteracao INT
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'luta') THEN
        EXECUTE 'CREATE TABLE luta (
    personagem INT NOT NULL,
    inimigo INT NOT NULL,
    qtd_rodadas INT NOT NULL,
    qtd_acertos INT NOT NULL,
    qtd_erros INT NOT NULL,
    qtd_uso_habilidades INT NOT NULL,
    FOREIGN KEY (personagem) REFERENCES personagem(id_personagem),
    FOREIGN KEY (inimigo) REFERENCES instancia_inimigo(id_instancia_inimigo)
);';
    END IF;
	IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'drop_item') THEN
        EXECUTE 'CREATE TABLE drop_item (
    item INT REFERENCES item(id_item),
    inimigo INT REFERENCES inimigo(id_inimigo),
    qtd INT
);';
    END IF;
END;
$criar_tabelas$ LANGUAGE plpgsql;