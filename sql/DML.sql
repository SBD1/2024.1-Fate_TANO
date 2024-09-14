
--- Habilidades
-- dml/DML_Habilidades.sql

--- Habilidades Extra-Classe
INSERT INTO habilidade_extra (id_habilidade_extra, tipo_habilidade, tipo_exclasse, numero, descricao, cooldown, custo_mana, ranque)
VALUES
(1, 'noble_phantasm', 'ruler', 1, 'Domínio Supremo - Habilidade para controlar todas as regras da batalha', 5, 50, 'ex'),
(2, 'noble_phantasm', 'avenger', 1, 'Vingança Absoluta - Aumenta drasticamente o poder de ataque contra inimigos', 7, 60, 'ex'),
(3, 'noble_phantasm', 'moon_cancer', 1, 'Luz da Lua Destruidora - Convoca um poder místico da lua para atacar os inimigos', 6, 55, 'ex'),
(4, 'noble_phantasm', 'alter_ego', 1, 'Ego Devastador - Libera todo o poder oculto de sua personalidade múltipla', 4, 45, 'ex'),
(5, 'noble_phantasm', 'foreigner', 1, 'Chamado das Estrelas - Invoca entidades cósmicas para causar destruição em massa', 8, 70, 'ex'),
(6, 'noble_phantasm', 'pretender', 1, 'Mascarada Enganosa - Engana os inimigos e realiza um golpe mortal inesperado', 5, 40, 'ex'),
(7, 'noble_phantasm', 'shielder', 1, 'Escudo Absoluto - Cria uma barreira impenetrável para proteger a equipe', 3, 30, 'ex'),
(8, 'noble_phantasm', 'beast', 1, 'Fúria Bestial - Libera o poder destrutivo de uma besta para devastar o campo de batalha', 9, 80, 'ex'),
(9, 'noble_phantasm', 'moon_cancer', 2, 'Garras da Noite - Ataque rápido e furtivo sob a luz da lua', 6, 50, 'ex'),
(10, 'noble_phantasm', 'ruler', 2, 'Mandato do Céu - Imposição de regras divinas para enfraquecer os inimigos', 4, 45, 'ex');


--- Classes
INSERT INTO classe (id_classe, tipo_classe, b_inteligencia, b_destreza, b_sabedoria, b_forca, b_defesa, b_carisma, info) 
VALUES
(1, 'saber', 7, 8, 6, 9, 7, 6, 'Classe equilibrada com foco em força e destreza.'),
(2, 'lancer', 6, 9, 5, 8, 6, 5, 'Especialista em combate à distância com lanças e alta mobilidade.'),
(3, 'archer', 8, 9, 7, 5, 5, 6, 'Perito em ataques à distância com excelente precisão e destreza.'),
(4, 'rider', 7, 7, 6, 8, 6, 7, 'Classe veloz, especializada em montarias e ataques rápidos.'),
(5, 'caster', 9, 6, 9, 4, 4, 7, 'Mestres de magia com alta inteligência e sabedoria, mas baixa resistência física.'),
(6, 'assassin', 6, 9, 6, 7, 5, 8, 'Especialista em ataques furtivos com alta destreza e carisma.'),
(7, 'berserker', 5, 6, 4, 10, 8, 4, 'Classe de combate bruto, focada em força e resistência, mas com baixa sabedoria.');

--- Extra_Classes
INSERT INTO extra_classe (id_exclasse, tipo_exclasse, b_inteligencia, b_destreza, b_sabedoria, b_forca, b_defesa, b_carisma, noble_phantasm, tipo_habilidade, info)
VALUES
(1, 'ruler', 80, 75, 85, 70, 90, 95, NULL, 'noble_phantasm', 'Classe com grande liderança'),
(2, 'avenger', 60, 85, 65, 90, 70, 60, NULL, 'noble_phantasm', 'Classe com grande desejo de vingança'),
(3, 'moon_cancer', 85, 65, 90, 60, 75, 80, NULL, 'noble_phantasm', 'Classe misteriosa associada à lua'),
(4, 'alter_ego', 70, 80, 75, 85, 65, 70, NULL, 'noble_phantasm', 'Classe multifacetada'),
(5, 'foreigner', 90, 60, 95, 65, 80, 85, NULL, 'noble_phantasm', 'Classe alienígena ou de fora'),
(6, 'pretender', 75, 85, 80, 70, 65, 75, NULL, 'noble_phantasm', 'Classe enganosa e versátil'),
(7, 'shielder', 50, 70, 55, 95, 90, 60, NULL, 'noble_phantasm', 'Classe protetora e defensiva'),
(8, 'beast', 95, 70, 85, 90, 95, 80, NULL, 'noble_phantasm', 'Classe poderosa e monstruosa');

-- NPCs
-- dml/DML_NPCS.sql

--- Falas
-- dml/DML_falas.sql



