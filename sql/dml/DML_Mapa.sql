INSERT INTO mundo (id_mundo, nome, descricao, mundo_conecta, mundo_conectado) VALUES
(1, 'Terra Magica', 'Um mundo repleto de magia e criaturas místicas.', NULL, 2),
(2, 'Netherworld', 'Um reino sombrio governado por forças malignas.', 1, 3),
(3, 'Skyland', 'Um mundo flutuante acima das nuvens, governado por seres celestiais.', 2, 4),
(4, 'Abyss', 'Uma dimensão profunda e misteriosa, lar de monstros e desafios ocultos.', 3, NULL);

--- Regiões para Terra Mágica
INSERT INTO regiao (id_regiao, nome, descricao, mundo, regiao_n, regiao_s, regiao_l, regiao_o) VALUES
(1, 'Floresta Encantada', 'Uma floresta mágica cheia de criaturas místicas.', 1, NULL, 2, 3, NULL),
(2, 'Montanhas Nebulosas', 'Montanhas cobertas por neblina e lar de dragões.', 1, 1, NULL, 4, 5),
(3, 'Lago dos Espíritos', 'Um lago sagrado onde espíritos antigos habitam.', 1, NULL, 4, NULL, 1),
(4, 'Campos Luminosos', 'Planícies abertas banhadas pela luz eterna.', 1, 3, 5, 6, 2),
(5, 'Caverna Cristalina', 'Uma caverna repleta de cristais mágicos.', 1, 4, NULL, 7, 2),
(6, 'Ruínas Antigas', 'Ruínas de uma antiga civilização mágica.', 1, 4, NULL, NULL, NULL),
(7, 'Vale Sombrio', 'Um vale assombrado onde poucos se atrevem a entrar.', 1, 5, NULL, NULL, NULL);

--- Regiões para Netherworld
INSERT INTO regiao (id_regiao, nome, descricao, mundo, regiao_n, regiao_s, regiao_l, regiao_o) VALUES
(8, 'Terra das Sombras', 'Uma região escura e nebulosa, cheia de perigos.', 2, NULL, 9, 10, NULL),
(9, 'Deserto Abissal', 'Um deserto árido e traiçoeiro, repleto de tempestades de areia.', 2, 8, 10, NULL, NULL),
(10, 'Cidades Perdidas', 'Ruínas de cidades antigas, agora habitadas por monstros.', 2, NULL, 11, 8, 12),
(11, 'Fenda das Almas', 'Uma fenda dimensional onde almas perdidas vagam.', 2, 10, NULL, NULL, NULL),
(12, 'Pântano das Trevas', 'Um pântano inóspito, cheio de criaturas horrendas e vegetação venenosa.', 2, NULL, NULL, 10, NULL);

-- Regiões para Skyland
INSERT INTO regiao (id_regiao, nome, descricao, mundo, regiao_n, regiao_s, regiao_l, regiao_o) VALUES
(13, 'Ilha das Nuvens', 'Uma ilha flutuante coberta por nuvens espessas e misteriosas.', 3, NULL, 14, NULL, NULL),
(14, 'Palácio Celestial', 'Um palácio magnífico no céu, onde vivem os seres celestiais.', 3, 13, NULL, 15, NULL),
(15, 'Jardins Flutuantes', 'Jardins exuberantes e flutuantes, repletos de flora mágica.', 3, NULL, NULL, 14, NULL);

--- Regiões para Abyss
INSERT INTO regiao (id_regiao, nome, descricao, mundo, regiao_n, regiao_s, regiao_l, regiao_o) VALUES
(16, 'Abismo Infernal', 'Uma região profunda e perturbadora, cheia de lava e demônios.', 4, NULL, 17, NULL, NULL),
(17, 'Cavernas do Caos', 'Cavernas instáveis e repletas de monstros aberrantes.', 4, 16, NULL, NULL, NULL);

--- Salas

-- Região Floresta Encantada
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(1, 'grama', 10, 1, 2, 4, 6, NULL),
(2, 'grama', 12, 1, 3, 1, 7, 8),
(3, 'agua', 8, 1, 4, 2, 9, NULL),
(4, 'ruina', 15, 1, 5, 1, 10, 11),
(5, 'buraco', 7, 1, 6, 4, NULL, NULL),
(6, 'grama', 11, 1, 7, 5, 12, 1),
(7, 'caverna', 20, 1, NULL, 6, 13, 2),
(8, 'masmorra', 25, 1, 9, 2, NULL, 1),
(9, 'caverna', 22, 1, 10, 8, 14, 3),
(10, 'agua', 13, 1, 11, 4, NULL, 9),
(11, 'grama', 14, 1, 12, 10, 15, 4),
(12, 'ruina', 16, 1, 13, 6, NULL, 11),
(13, 'buraco', 9, 1, 14, 12, 16, 7),
(14, 'caverna', 18, 1, 15, 13, 17, 9),
(15, 'residencia', 30, 1, 16, 14, 18, 11),
(16, 'pousada', 35, 1, 17, 15, 19, 13),
(17, 'oficina', 25, 1, 18, 16, 20, 14),
(18, 'masmorra', 27, 1, 19, 17, 21, 15),
(19, 'caverna', 20, 1, 20, 18, 22, 16),
(20, 'grama', 10, 1, 21, 19, 23, 17),
(21, 'agua', 8, 1, 22, 20, 24, 18),
(22, 'ruina', 12, 1, 23, 21, 25, 19),
(23, 'buraco', 7, 1, 24, 22, 26, 20),
(24, 'residencia', 28, 1, 25, 23, 27, 21),
(25, 'pousada', 32, 1, 26, 24, 28, 22),
(26, 'oficina', 26, 1, 27, 25, 29, 23),
(27, 'masmorra', 29, 1, 28, 26, 30, 24),
(28, 'caverna', 21, 1, 29, 27, NULL, 25),
(29, 'grama', 12, 1, 30, 28, NULL, 26),
(30, 'agua', 9, 1, NULL, 29, NULL, 27);

-- Adicionar cavernas, masmorras e residências
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(7, 'Caverna Profunda', 'Uma caverna muito profunda e escura.', 1),
(9, 'Caverna Escondida', 'Uma caverna oculta atrás de uma cachoeira.', 2),
(14, 'Caverna do Eco', 'Uma caverna onde os ecos são fortes.', 3);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(8, 'Masmoia dos Espinhos', 'Uma masmorra cheia de armadilhas e espinhos.', 1, 'a'),
(18, 'Masmoia da Perdição', 'Uma masmorra com muitos perigos e enigmas.', 2, 's'),
(27, 'Masmoia dos Labirintos', 'Uma masmorra com muitos labirintos e caminhos falsos.', 3, 'b');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(15, 'Casa do Ferreiro', 'Uma oficina onde ferreiros trabalham e vendem armas.', 'b', 'oficina', NULL, NULL, 'arma'),
(16, 'Pousada do Explorador', 'Uma pousada onde viajantes e aventureiros podem descansar.', 'a', 'pousada', 50, 100, NULL),
(17, 'Loja do Mago', 'Uma loja onde se vendem itens mágicos e pergaminhos.', 'a', 'loja', NULL, NULL, 'material'),
(24, 'Taverna dos Bravos', 'Uma taverna que oferece comida e bebida aos aventureiros.', 'c', 'pousada', 30, 50, NULL),
(25, 'Casa de Poções', 'Uma residência onde são feitas e vendidas poções mágicas.', 'b', 'oficina', NULL, NULL, 'consumivel');


--- Região Montanhas Nebulosas

-- Criar 20 salas para a região Montanhas Nebulosas
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(31, 'caverna', 20, 2, 32, 30, 33, 35),
(32, 'agua', 12, 2, 33, 31, 34, 30),
(33, 'buraco', 10, 2, 34, 32, 35, 31),
(34, 'masmorra', 25, 2, 35, 33, 30, 32),
(35, 'residencia', 28, 2, 36, 34, 31, 33),
(36, 'grama', 14, 2, 37, 35, 38, 32),
(37, 'agua', 11, 2, 38, 36, 39, 33),
(38, 'ruina', 17, 2, 39, 37, 40, 34),
(39, 'buraco', 8, 2, 40, 38, 41, 35),
(40, 'caverna', 22, 2, 41, 39, 42, 36),
(41, 'masmorra', 30, 2, 42, 40, 43, 37),
(42, 'grama', 16, 2, 43, 41, 44, 38),
(43, 'agua', 9, 2, 44, 42, 45, 39),
(44, 'ruina', 14, 2, 45, 43, 46, 40),
(45, 'buraco', 6, 2, 46, 44, 47, 41),
(46, 'caverna', 18, 2, 47, 45, 48, 42),
(47, 'masmorra', 24, 2, 48, 46, 49, 43),
(48, 'grama', 12, 2, 49, 47, 50, 44),
(49, 'agua', 10, 2, 50, 48, NULL, 45),
(50, 'ruina', 13, 2, NULL, 49, NULL, 46);

-- Adicionar cavernas, masmorras e residências
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(31, 'Caverna dos Ventos', 'Uma caverna onde o vento faz um som misterioso.', 4),
(40, 'Caverna do Cristal', 'Uma caverna cheia de cristais brilhantes.', 5),
(46, 'Caverna dos Ecos', 'Uma caverna com ecos estrondosos.', 6);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(34, 'Masmoia das Nebulosas', 'Uma masmorra com neblina densa e traiçoeira.', 4, 'a'),
(41, 'Masmoia dos Gelo', 'Uma masmorra com um frio intenso e gelo por todo lado.', 5, 'b'),
(47, 'Masmoia das Correntes', 'Uma masmorra com correntes e armadilhas.', 6, 's');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(35, 'Refúgio do Alquimista', 'Uma residência onde alquimistas produzem elixires e poções.', 'a', 'loja', NULL, NULL, 'consumivel'),
(36, 'Aposento do Místico', 'Uma residência para místicos e praticantes de magia.', 'b', 'pousada', 60, 120, NULL),
(37, 'Loja dos Magos', 'Uma loja especializada em itens mágicos e encantamentos.', 'a', 'loja', NULL, NULL, 'material'),
(38, 'Cabana do Explorador', 'Uma cabana para aventureiros descansarem e reabastecerem.', 'b', 'pousada', 50, 100, NULL),
(39, 'Casa de Poções Raras', 'Uma residência que vende poções raras e poderosas.', 'a', 'loja', NULL, NULL, 'consumivel');


--- Região Lago dos Espíritos

-- Criar 20 salas para a região Lago dos Espíritos
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(50, 'agua', 20, 3, 51, 55, 52, 54),
(51, 'grama', 12, 3, 52, 50, 53, 55),
(52, 'ruina', 15, 3, 53, 51, 54, 50),
(53, 'buraco', 8, 3, 54, 52, 55, 51),
(54, 'caverna', 18, 3, 55, 53, 50, 52),
(55, 'masmorra', 22, 3, 56, 54, 51, 53),
(56, 'residencia', 30, 3, 57, 55, 52, 54),
(57, 'agua', 19, 3, 58, 56, 58, 55),
(58, 'grama', 13, 3, 59, 57, 60, 56),
(59, 'ruina', 16, 3, 60, 58, 61, 57),
(60, 'buraco', 10, 3, 61, 59, 62, 58),
(61, 'caverna', 21, 3, 62, 60, 63, 59),
(62, 'masmorra', 25, 3, 63, 61, 64, 60),
(63, 'residencia', 28, 3, 64, 62, 65, 61),
(64, 'agua', 14, 3, 65, 63, 66, 62),
(65, 'grama', 11, 3, 66, 64, 67, 63),
(66, 'ruina', 17, 3, 67, 65, 68, 64),
(67, 'buraco', 9, 3, 68, 66, 69, 65),
(68, 'caverna', 20, 3, 69, 67, 70, 66),
(69, 'masmorra', 27, 3, 70, 68, 71, 67),
(70, 'residencia', 22, 3, 71, 69, NULL, 68),
(71, 'agua', 18, 3, NULL, 70, NULL, 69);

-- Adicionar cavernas, masmorras e residências
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(51, 'Caverna das Águas Profundas', 'Uma caverna submersa com águas profundas.', 7),
(56, 'Caverna dos Espelhos', 'Uma caverna com paredes de cristal que refletem imagens distorcidas.', 8),
(62, 'Caverna da Névoa', 'Uma caverna envolta em névoa mágica que obscurece a visão.', 9);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(54, 'Masmoia das Almas Perdidas', 'Uma masmorra assombrada por espíritos inquietos.', 7, 'a'),
(60, 'Masmoia das Sombras', 'Uma masmorra envolta em escuridão e mistérios.', 8, 'b'),
(69, 'Masmoia dos Espíritos', 'Uma masmorra onde o som dos espíritos ecoa constantemente.', 9, 's');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(55, 'Casa do Espírito Guia', 'Uma residência onde espíritos guiam os viajantes.', 'a', 'pousada', 40, 80, NULL),
(57, 'Loja da Mística', 'Uma loja que vende artefatos místicos e encantamentos.', 'b', 'loja', NULL, NULL, 'material'),
(63, 'Refúgio dos Viajantes', 'Uma residência para aventureiros encontrarem descanso e reabastecimento.', 'a', 'pousada', 50, 100, NULL),
(65, 'Loja dos Feitiçaria', 'Uma loja especializada em feitiçaria e itens mágicos.', 'b', 'loja', NULL, NULL, 'consumivel');


--- Região Campos Luminosos

-- Criar 20 salas para a região Campos Luminosos
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(72, 'agua', 10, 4, 73, 71, 74, 75),
(73, 'ruina', 12, 4, 74, 72, 75, 71),
(74, 'buraco', 8, 4, 75, 73, 71, 72),
(75, 'caverna', 18, 4, 76, 74, 72, 73),
(76, 'masmorra', 20, 4, 77, 75, 73, 74),
(77, 'residencia', 22, 4, 78, 76, 74, 75),
(78, 'grama', 14, 4, 79, 77, 76, 74),
(79, 'agua', 16, 4, 80, 78, 77, 75),
(80, 'ruina', 11, 4, 81, 79, 78, 76),
(81, 'buraco', 9, 4, 82, 80, 79, 77),
(82, 'caverna', 17, 4, 83, 81, 80, 78),
(83, 'masmorra', 24, 4, 84, 82, 81, 79),
(84, 'residencia', 26, 4, 85, 83, 82, 80),
(85, 'grama', 19, 4, 86, 84, 83, 81),
(86, 'agua', 13, 4, 87, 85, 84, 82),
(87, 'ruina', 15, 4, 88, 86, 85, 83),
(88, 'buraco', 10, 4, 89, 87, 86, 84),
(89, 'caverna', 21, 4, 90, 88, 87, 85),
(90, 'masmorra', 28, 4, 91, 89, 88, 86),
(91, 'residencia', 30, 4, 92, 90, 89, 87),
(92, 'grama', 12, 4, NULL, 91, 90, 88),
(93, 'agua', 11, 4, NULL, 92, 91, 89),
(94, 'ruina', 14, 4, NULL, 93, 92, 90),
(95, 'buraco', 10, 4, NULL, 94, 93, 91),
(96, 'caverna', 18, 4, NULL, 95, 94, 92);

-- Adicionar cavernas, masmorras e residências
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(76, 'Caverna das Luzes Perdidas', 'Uma caverna brilhante com luzes mágicas e flutuantes.', 10),
(82, 'Caverna da Aurora', 'Uma caverna que reflete as cores da aurora boreal.', 11),
(90, 'Caverna dos Ecos', 'Uma caverna onde os ecos dos sons criam padrões luminosos.', 12);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(75, 'Masmoia das Estrelas Caídas', 'Uma masmorra onde o céu noturno é refletido nas paredes.', 10, 'a'),
(84, 'Masmoia dos Cristais Luminosos', 'Uma masmorra adornada com cristais que emitem uma luz suave.', 11, 'b'),
(91, 'Masmoia da Luz Eterna', 'Uma masmorra iluminada por uma fonte de luz eterna.', 12, 's');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(77, 'Aconchego dos Iluminados', 'Uma residência confortável que irradia uma luz reconfortante.', 'a', 'pousada', 50, 100, NULL),
(85, 'Loja da Luz Radiante', 'Uma loja que vende itens encantados com luz e energia mágica.', 'b', 'loja', NULL, NULL, 'material'),
(92, 'Refúgio dos Exploradores', 'Uma residência para aventureiros descansarem e se prepararem.', 'a', 'pousada', 60, 120, NULL);

--- Região Caverna Cristalina
-- Criar 20 salas para a região Caverna Cristalina
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(97, 'caverna', 25, 5, 98, 100, 99, 96),
(98, 'caverna', 22, 5, 99, 101, 100, 97),
(99, 'caverna', 18, 5, 100, 102, 101, 98),
(100, 'caverna', 30, 5, 101, 103, 102, 99),
(101, 'caverna', 28, 5, 102, 104, 103, 100),
(102, 'caverna', 24, 5, 103, 105, 104, 101),
(103, 'caverna', 26, 5, 104, 106, 105, 102),
(104, 'caverna', 27, 5, 105, 107, 106, 103),
(105, 'caverna', 23, 5, 106, 108, 107, 104),
(106, 'caverna', 21, 5, 107, 109, 108, 105),
(107, 'caverna', 29, 5, 108, 110, 109, 106),
(108, 'caverna', 31, 5, 109, 111, 110, 107),
(109, 'caverna', 32, 5, 110, 112, 111, 108),
(110, 'caverna', 34, 5, 111, 113, 112, 109),
(111, 'caverna', 35, 5, 112, 114, 113, 110),
(112, 'caverna', 37, 5, 113, 115, 114, 111),
(113, 'caverna', 39, 5, 114, 116, 115, 112),
(114, 'caverna', 41, 5, 115, NULL, 116, 113),
(115, 'caverna', 43, 5, 116, NULL, NULL, 114),
(116, 'caverna', 45, 5, NULL, NULL, NULL, 115);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(97, 'Caverna dos Cristais Brilhantes', 'Uma caverna com cristais que emitem uma luz ofuscante.', 13),
(104, 'Caverna das Estalactites Mágicas', 'Uma caverna adornada com estalactites que brilham com magia.', 14),
(112, 'Caverna do Reflexo Eterno', 'Uma caverna onde as paredes refletem imagens eternas de luz.', 15);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(96, 'Masmoia da Tempestade Cristalina', 'Uma masmorra com tempestades de cristais e energia mágica.', 13, 'a'),
(105, 'Masmoia das Luzes Arcanas', 'Uma masmorra com luzes arcanas que iluminam o caminho.', 14, 'b'),
(113, 'Masmoia do Prisma Eterno', 'Uma masmorra onde os prismas mágicos criam um ambiente eterno.', 15, 's');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(101, 'Refúgio dos Cristais', 'Uma residência acolhedora entre cristais mágicos que restauram energia.', 'b', 'pousada', 70, 140, NULL),
(112, 'Loja dos Cristais Místicos', 'Uma loja especializada na venda de cristais mágicos e itens encantados.', 'a', 'loja', NULL, NULL, 'magico'),
(116, 'Aconchego dos Exploradores Cristalinos', 'Uma residência para aventureiros relaxarem e se prepararem com a energia dos cristais.', 'b', 'pousada', 80, 160, NULL);

--- Região Ruinas Antigas
-- Criar 20 salas para a região Ruínas Antigas
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(117, 'ruina', 35, 6, 118, 119, 120, NULL),
(118, 'ruina', 40, 6, 119, 121, 120, 117),
(119, 'ruina', 38, 6, 120, 122, 121, 118),
(120, 'ruina', 42, 6, 121, 123, 122, 119),
(121, 'ruina', 37, 6, 122, 124, 123, 120),
(122, 'ruina', 36, 6, 123, 125, 124, 121),
(123, 'ruina', 39, 6, 124, 126, 125, 122),
(124, 'ruina', 41, 6, 125, 127, 126, 123),
(125, 'ruina', 44, 6, 126, 128, 127, 124),
(126, 'ruina', 46, 6, 127, 129, 128, 125),
(127, 'ruina', 50, 6, 128, 130, 129, 126),
(128, 'ruina', 48, 6, 129, 131, 130, 127),
(129, 'ruina', 52, 6, 130, 132, 131, 128),
(130, 'ruina', 55, 6, 131, 133, 132, 129),
(131, 'ruina', 57, 6, 132, 134, 133, 130),
(132, 'ruina', 59, 6, 133, 135, 134, 131),
(133, 'ruina', 61, 6, 134, 136, 135, 132),
(134, 'ruina', 63, 6, 135, 137, 136, 133),
(135, 'ruina', 65, 6, 136, 138, 137, 134),
(136, 'ruina', 67, 6, 137, NULL, 138, 135),
(137, 'ruina', 70, 6, 138, NULL, NULL, 136),
(138, 'ruina', 72, 6, NULL, NULL, NULL, 137);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(118, 'Caverna dos Segredos Perdidos', 'Uma caverna antiga cheia de segredos e inscrições esquecidas.', 16),
(124, 'Caverna das Relíquias Antigas', 'Uma caverna onde relíquias antigas estão guardadas.', 17),
(130, 'Caverna dos Ecos Esquecidos', 'Uma caverna que ecoa os sons do passado.', 18);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(117, 'Masmoia dos Guardiões Ancestrais', 'Uma masmorra guardada por antigos espíritos de guardiões.', 16, 'a'),
(123, 'Masmoia das Ruínas Eternas', 'Uma masmorra que se estende eternamente através das ruínas.', 17, 'b'),
(132, 'Masmoia da Eternidade Perdida', 'Uma masmorra onde o tempo parece ter parado.', 18, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(121, 'Refúgio dos Exploradores Antigos', 'Uma residência que oferece descanso e conhecimento sobre as ruínas.', 'b', 'pousada', 60, 120, NULL),
(130, 'Loja dos Artefatos Ancestrais', 'Uma loja que vende artefatos antigos e relíquias mágicas.', 'a', 'loja', NULL, NULL, 'artefato'),
(138, 'Aconchego dos Guardiões das Ruínas', 'Uma residência onde os guardiões das ruínas oferecem proteção e descanso.', 'b', 'pousada', 70, 140, NULL);

--- Região Vale Sombrio
-- Criar 20 salas para a região Vale Sombrio
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(139, 'ruina', 30, 7, 140, 141, 142, NULL),
(140, 'ruina', 32, 7, 141, 143, 142, 139),
(141, 'ruina', 34, 7, 142, 144, 143, 140),
(142, 'ruina', 36, 7, 143, 145, 144, 141),
(143, 'ruina', 38, 7, 144, 146, 145, 142),
(144, 'ruina', 40, 7, 145, 147, 146, 143),
(145, 'ruina', 42, 7, 146, 148, 147, 144),
(146, 'ruina', 44, 7, 147, 149, 148, 145),
(147, 'ruina', 46, 7, 148, 150, 149, 146),
(148, 'ruina', 48, 7, 149, 151, 150, 147),
(149, 'ruina', 50, 7, 150, 152, 151, 148),
(150, 'ruina', 52, 7, 151, 153, 152, 149),
(151, 'ruina', 54, 7, 152, 154, 153, 150),
(152, 'ruina', 56, 7, 153, 155, 154, 151),
(153, 'ruina', 58, 7, 154, 156, 155, 152),
(154, 'ruina', 60, 7, 155, 157, 156, 153),
(155, 'ruina', 62, 7, 156, 158, 157, 154),
(156, 'ruina', 64, 7, 157, 159, 158, 155),
(157, 'ruina', 66, 7, 158, NULL, 159, 156),
(158, 'ruina', 68, 7, 159, NULL, NULL, 157),
(159, 'ruina', 70, 7, NULL, NULL, NULL, 158);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(141, 'Caverna das Sombras Profundas', 'Uma caverna envolta em sombras e mistério.', 19),
(146, 'Caverna dos Ecos Perdidos', 'Uma caverna onde os ecos dos passos são amplificados.', 20),
(152, 'Caverna do Vento Uivante', 'Uma caverna onde o vento uiva incessantemente.', 21);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(139, 'Masmoia dos Desafios Sombrios', 'Uma masmorra que testa a coragem dos aventureiros com desafios sombrios.', 19, 'a'),
(148, 'Masmoia das Trevas Eternas', 'Uma masmorra onde as trevas parecem não ter fim.', 20, 'b'),
(155, 'Masmoia do Destino Incerto', 'Uma masmorra onde o destino dos aventureiros é incerto.', 21, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(143, 'Refúgio dos Sábios das Sombras', 'Uma residência que oferece conhecimento sobre as trevas e sombra.', 'b', 'pousada', 50, 100, NULL),
(150, 'Loja dos Artifícios Obscuros', 'Uma loja especializada em artefatos e itens sombrios.', 'a', 'loja', NULL, NULL, 'artefato'),
(159, 'Aconchego dos Guardiões das Trevas', 'Uma residência onde guardiões das trevas oferecem proteção e descanso.', 'b', 'pousada', 60, 120, NULL);

--- Região Terra das Sombras
-- Criar 20 salas para a região Terra das Sombras
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(160, 'ruina', 28, 8, 161, 162, 163, NULL),
(161, 'ruina', 30, 8, 162, 164, 163, 160),
(162, 'ruina', 32, 8, 163, 165, 164, 161),
(163, 'ruina', 34, 8, 164, 166, 165, 162),
(164, 'ruina', 36, 8, 165, 167, 166, 163),
(165, 'ruina', 38, 8, 166, 168, 167, 164),
(166, 'ruina', 40, 8, 167, 169, 168, 165),
(167, 'ruina', 42, 8, 168, 170, 169, 166),
(168, 'ruina', 44, 8, 169, 171, 170, 167),
(169, 'ruina', 46, 8, 170, 172, 171, 168),
(170, 'ruina', 48, 8, 171, 173, 172, 169),
(171, 'ruina', 50, 8, 172, 174, 173, 170),
(172, 'ruina', 52, 8, 173, 175, 174, 171),
(173, 'ruina', 54, 8, 174, 176, 175, 172),
(174, 'ruina', 56, 8, 175, 177, 176, 173),
(175, 'ruina', 58, 8, 176, 178, 177, 174),
(176, 'ruina', 60, 8, 177, 179, 178, 175),
(177, 'ruina', 62, 8, 178, NULL, 179, 176),
(178, 'ruina', 64, 8, 179, NULL, NULL, 177),
(179, 'ruina', 66, 8, NULL, NULL, NULL, 178);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(165, 'Caverna dos Lamentos', 'Uma caverna onde os lamentos das almas perdidas ecoam.', 22),
(172, 'Caverna da Escuridão Absoluta', 'Uma caverna envolta em escuridão total.', 23),
(178, 'Caverna das Visões Perturbadoras', 'Uma caverna que causa visões perturbadoras em quem entra.', 24);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(160, 'Masmoia dos Pesadelos', 'Uma masmorra repleta de pesadelos e desafios aterrorizantes.', 22, 'b'),
(167, 'Masmoia das Sombras Profundas', 'Uma masmorra nas profundezas das sombras.', 23, 'a'),
(176, 'Masmoia dos Ecos Obscuros', 'Uma masmorra onde os ecos das sombras são fortes e constantes.', 24, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(161, 'Refúgio dos Guardiões das Sombras', 'Uma residência que oferece proteção e descanso aos guardiões das sombras.', 'a', 'pousada', 70, 140, NULL),
(169, 'Loja dos Segredos Sombrios', 'Uma loja especializada em itens e artefatos das sombras.', 'b', 'loja', NULL, NULL, 'artefato'),
(177, 'Aconchego dos Sábios das Trevas', 'Uma residência onde sábios das trevas oferecem conselhos e descanso.', 'a', 'pousada', 80, 160, NULL);

--- Região Deserto Abissal
-- Criar 20 salas para a região Deserto Abissal
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(180, 'grama', 20, 9, 181, 182, 183, NULL),
(181, 'grama', 22, 9, 182, 184, 183, 180),
(182, 'grama', 24, 9, 183, 185, 184, 181),
(183, 'grama', 26, 9, 184, 186, 185, 182),
(184, 'grama', 28, 9, 185, 187, 186, 183),
(185, 'grama', 30, 9, 186, 188, 187, 184),
(186, 'grama', 32, 9, 187, 189, 188, 185),
(187, 'grama', 34, 9, 188, 190, 189, 186),
(188, 'grama', 36, 9, 189, 191, 190, 187),
(189, 'grama', 38, 9, 190, 192, 191, 188),
(190, 'grama', 40, 9, 191, 193, 192, 189),
(191, 'grama', 42, 9, 192, 194, 193, 190),
(192, 'grama', 44, 9, 193, 195, 194, 191),
(193, 'grama', 46, 9, 194, 196, 195, 192),
(194, 'grama', 48, 9, 195, 197, 196, 193),
(195, 'grama', 50, 9, 196, 198, 197, 194),
(196, 'grama', 52, 9, 197, 199, 198, 195),
(197, 'grama', 54, 9, 198, NULL, 199, 196),
(198, 'grama', 56, 9, 199, NULL, NULL, 197),
(199, 'grama', 58, 9, NULL, NULL, NULL, 198);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(186, 'Caverna das Areias Movediças', 'Uma caverna escondida entre areias que se movem constantemente.', 25),
(192, 'Caverna do Vento Uivante', 'Uma caverna onde o vento uiva incessantemente.', 26),
(199, 'Caverna dos Ecos Perdidos', 'Uma caverna onde ecos de gritos perdidos reverberam.', 27);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(180, 'Masmoia dos Segredos Abissais', 'Uma masmorra onde segredos e mistérios do deserto são guardados.', 25, 'b'),
(187, 'Masmoia dos Poços Secos', 'Uma masmorra repleta de poços secos e armadilhas.', 26, 'a'),
(194, 'Masmoia das Tempestades de Areia', 'Uma masmorra onde tempestades de areia são comuns.', 27, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(181, 'Oásis dos Mercadores', 'Um oásis onde mercadores oferecem itens e descanso.', 'b', 'loja', NULL, NULL, 'item'),
(190, 'Refúgio dos Nômades', 'Uma residência que oferece abrigo e descanso para nômades do deserto.', 'a', 'pousada', 60, 120, NULL),
(198, 'Aconchego do Viajante', 'Uma residência onde viajantes podem descansar e se recuperar.', 'b', 'pousada', 70, 140, NULL);

--- Região Cidades Perdidas
-- Criar 20 salas para a região Cidades Perdidas
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(200, 'ruina', 22, 10, 201, 202, 203, NULL),
(201, 'ruina', 24, 10, 202, 204, 203, 200),
(202, 'ruina', 26, 10, 203, 205, 204, 201),
(203, 'ruina', 28, 10, 204, 206, 205, 202),
(204, 'ruina', 30, 10, 205, 207, 206, 203),
(205, 'ruina', 32, 10, 206, 208, 207, 204),
(206, 'ruina', 34, 10, 207, 209, 208, 205),
(207, 'ruina', 36, 10, 208, 210, 209, 206),
(208, 'ruina', 38, 10, 209, 211, 210, 207),
(209, 'ruina', 40, 10, 210, 212, 211, 208),
(210, 'ruina', 42, 10, 211, 213, 212, 209),
(211, 'ruina', 44, 10, 212, 214, 213, 210),
(212, 'ruina', 46, 10, 213, 215, 214, 211),
(213, 'ruina', 48, 10, 214, 216, 215, 212),
(214, 'ruina', 50, 10, 215, 217, 216, 213),
(215, 'ruina', 52, 10, 216, 218, 217, 214),
(216, 'ruina', 54, 10, 217, 219, 218, 215),
(217, 'ruina', 56, 10, 218, 220, 219, 216),
(218, 'ruina', 58, 10, 219, NULL, 220, 217),
(219, 'ruina', 60, 10, NULL, NULL, NULL, 218),
(220, 'ruina', 62, 10, NULL, NULL, NULL, 219);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(203, 'Caverna das Relíquias Perdidas', 'Uma caverna onde relíquias antigas são encontradas.', 28),
(211, 'Caverna das Inscrições Antigas', 'Uma caverna com inscrições de antigas civilizações.', 29),
(219, 'Caverna dos Ecos Históricos', 'Uma caverna onde ecos do passado reverberam.', 30);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(200, 'Masmoia da Cidade Esquecida', 'Uma masmorra encontrada nas ruínas de uma cidade antiga.', 28, 'b'),
(206, 'Masmoia dos Segredos Subterrâneos', 'Uma masmorra que guarda segredos das profundezas.', 29, 'a'),
(212, 'Masmoia dos Reinos Perdidos', 'Uma masmorra onde reinos esquecidos estão enterrados.', 30, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(201, 'Casa do Historiador', 'Uma residência onde historiadores e estudiosos podem se encontrar.', 'b', 'loja', NULL, NULL, 'item'),
(208, 'Refúgio dos Sobreviventes', 'Um refúgio para aqueles que sobreviveram às calamidades da cidade perdida.', 'a', 'pousada', 60, 120, NULL),
(216, 'Abrigo do Guardião Antigo', 'Uma residência que oferece proteção e conhecimento sobre as cidades antigas.', 'b', 'pousada', 70, 140, NULL);

--- Região Fenda das Almas
-- Criar 20 salas para a região Fenda das Almas
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(221, 'buraco', 20, 11, 222, 223, 224, NULL),
(222, 'buraco', 22, 11, 223, 225, 224, 221),
(223, 'buraco', 24, 11, 224, 226, 225, 222),
(224, 'buraco', 26, 11, 225, 227, 226, 223),
(225, 'buraco', 28, 11, 226, 228, 227, 224),
(226, 'buraco', 30, 11, 227, 229, 228, 225),
(227, 'buraco', 32, 11, 228, 230, 229, 226),
(228, 'buraco', 34, 11, 229, 231, 230, 227),
(229, 'buraco', 36, 11, 230, 232, 231, 228),
(230, 'buraco', 38, 11, 231, 233, 232, 229),
(231, 'buraco', 40, 11, 232, 234, 233, 230),
(232, 'buraco', 42, 11, 233, 235, 234, 231),
(233, 'buraco', 44, 11, 234, 236, 235, 232),
(234, 'buraco', 46, 11, 235, 237, 236, 233),
(235, 'buraco', 48, 11, 236, 238, 237, 234),
(236, 'buraco', 50, 11, 237, 239, 238, 235),
(237, 'buraco', 52, 11, 238, 240, 239, 236),
(238, 'buraco', 54, 11, 239, 241, 240, 237),
(239, 'buraco', 56, 11, 240, 242, 241, 238),
(240, 'buraco', 58, 11, 241, NULL, 242, 239),
(241, 'buraco', 60, 11, NULL, NULL, NULL, 240),
(242, 'buraco', 62, 11, NULL, NULL, NULL, 241);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(224, 'Caverna dos Ecos Perdidos', 'Uma caverna onde ecos de almas antigas são ouvidos.', 31),
(232, 'Caverna das Almas Esquecidas', 'Uma caverna que guarda as almas esquecidas das profundezas.', 32),
(240, 'Caverna do Abismo', 'Uma caverna profunda que leva ao abismo das almas.', 33);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(221, 'Masmoia da Fenda Sombria', 'Uma masmorra encontrada na fenda que parece se estender sem fim.', 31, 'b'),
(227, 'Masmoia das Almas Penadas', 'Uma masmorra onde almas penadas vagam sem descanso.', 32, 'a'),
(233, 'Masmoia do Crepúsculo Eterno', 'Uma masmorra que nunca vê a luz do dia.', 33, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(222, 'Refúgio do Guardião das Almas', 'Uma residência que oferece abrigo e conhecimento sobre as almas perdidas.', 'a', 'pousada', 80, 160, NULL),
(228, 'Abrigo dos Condenados', 'Um abrigo onde almas perdidas podem encontrar algum conforto.', 'b', 'pousada', 90, 180, NULL),
(234, 'Casa do Vidente', 'Uma residência onde um vidente oferece visões das almas além do véu.', 'a', 'loja', NULL, NULL, 'item');

--- Região Pântano das Trevas
-- Criar 20 salas para a região Pântano das Travas
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(242, 'agua', 15, 12, 243, 244, 245, NULL),
(243, 'agua', 17, 12, 244, 246, 245, 242),
(244, 'agua', 19, 12, 245, 247, 246, 243),
(245, 'agua', 21, 12, 246, 248, 247, 244),
(246, 'agua', 23, 12, 247, 249, 248, 245),
(247, 'agua', 25, 12, 248, 250, 249, 246),
(248, 'agua', 27, 12, 249, 251, 250, 247),
(249, 'agua', 29, 12, 250, 252, 251, 248),
(250, 'agua', 31, 12, 251, 253, 252, 249),
(251, 'agua', 33, 12, 252, 254, 253, 250),
(252, 'agua', 35, 12, 253, 255, 254, 251),
(253, 'agua', 37, 12, 254, 256, 255, 252),
(254, 'agua', 39, 12, 255, 257, 256, 253),
(255, 'agua', 41, 12, 256, 258, 257, 254),
(256, 'agua', 43, 12, 257, 259, 258, 255),
(257, 'agua', 45, 12, 258, 260, 259, 256),
(258, 'agua', 47, 12, 259, 261, 260, 257),
(259, 'agua', 49, 12, 260, 262, 261, 258),
(260, 'agua', 51, 12, 261, 263, 262, 259),
(261, 'agua', 53, 12, 262, NULL, 263, 260),
(262, 'agua', 55, 12, NULL, NULL, NULL, 261);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(244, 'Caverna das Lendas Perdidas', 'Uma caverna que guarda histórias e mistérios esquecidos.', 34),
(254, 'Caverna das Névoas Eternas', 'Uma caverna envolta em névoas que nunca se dissipam.', 35),
(262, 'Caverna do Abismo Verde', 'Uma caverna profunda no coração do pântano, onde a água parece não ter fim.', 36);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(242, 'Masmoia da Lama Sinistra', 'Uma masmorra em meio à lama e neblina, cheia de perigos.', 34, 'b'),
(247, 'Masmoia das Serpentes', 'Uma masmorra infestada por serpentes e criaturas do pântano.', 35, 'a'),
(252, 'Masmoia dos Enganadores', 'Uma masmorra que confunde e engana aqueles que se aventuram por ela.', 36, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(243, 'Refúgio do Caçador de Pântano', 'Uma residência que oferece abrigo e informações sobre o pântano.', 'a', 'pousada', 70, 140, NULL),
(248, 'Abrigo dos Sobreviventes', 'Um abrigo que ajuda os viajantes a se recuperarem das jornadas pelo pântano.', 'b', 'pousada', 80, 160, NULL),
(253, 'Casa do Curandeiro', 'Uma residência onde um curandeiro oferece remédios e poções para os males do pântano.', 'a', 'loja', NULL, NULL, 'item');

--- Região Ilha das Nuvens
-- Criar 20 salas para a região Ilha das Nuvens
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(262, 'grama', 12, 13, 263, 264, 265, NULL),
(263, 'grama', 14, 13, 264, 266, 265, 262),
(264, 'grama', 16, 13, 265, 267, 266, 263),
(265, 'grama', 18, 13, 266, 268, 267, 264),
(266, 'grama', 20, 13, 267, 269, 268, 265),
(267, 'grama', 22, 13, 268, 270, 269, 266),
(268, 'grama', 24, 13, 269, 271, 270, 267),
(269, 'grama', 26, 13, 270, 272, 271, 268),
(270, 'grama', 28, 13, 271, 273, 272, 269),
(271, 'grama', 30, 13, 272, 274, 273, 270),
(272, 'grama', 32, 13, 273, 275, 274, 271),
(273, 'grama', 34, 13, 274, 276, 275, 272),
(274, 'grama', 36, 13, 275, 277, 276, 273),
(275, 'grama', 38, 13, 276, 278, 277, 274),
(276, 'grama', 40, 13, 277, 279, 278, 275),
(277, 'grama', 42, 13, 278, 280, 279, 276),
(278, 'grama', 44, 13, 279, 281, 280, 277),
(279, 'grama', 46, 13, 280, 282, 281, 278),
(280, 'grama', 48, 13, 281, 283, 282, 279),
(281, 'grama', 50, 13, 282, 284, 283, 280),
(282, 'grama', 52, 13, 283, 285, 284, 281);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(264, 'Caverna das Nuvens Flutuantes', 'Uma caverna em que a gravidade parece ser alterada pelas nuvens.', 37),
(274, 'Caverna do Vento Eterno', 'Uma caverna onde o vento nunca para e cria uma sensação de movimento constante.', 38),
(282, 'Caverna do Céu Azul', 'Uma caverna com uma bela vista do céu através de aberturas naturais.', 39);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(262, 'Masmoia das Nuvens Espessas', 'Uma masmorra cheia de névoas densas e desafios ocultos.', 37, 'b'),
(268, 'Masmoia dos Ventos Fortes', 'Uma masmorra com ventos fortes e inimigos imprevisíveis.', 38, 'a'),
(274, 'Masmoia do Horizonte Perdido', 'Uma masmorra que desafia a percepção com ilusões e horizontes distantes.', 39, 'c');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(263, 'Casa do Viajante das Nuvens', 'Uma residência onde os viajantes podem encontrar abrigo e dicas sobre a ilha.', 'a', 'pousada', 60, 120, NULL),
(274, 'Abrigo do Navegador do Céu', 'Um abrigo que oferece refúgio e informações sobre a navegação através das nuvens.', 'b', 'pousada', 70, 140, NULL),
(282, 'Loja das Nuvens Douradas', 'Uma loja especializada em itens raros encontrados nas nuvens.', 'a', 'loja', NULL, NULL, 'item');

--- Região Palácio Celestial
-- Criar 20 salas para a região Palácio Celestial
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(282, 'ruina', 20, 14, 283, 284, 285, 286),
(283, 'ruina', 22, 14, 284, 287, 286, 282),
(284, 'ruina', 24, 14, 285, 288, 287, 283),
(285, 'ruina', 26, 14, 286, 289, 288, 284),
(286, 'ruina', 28, 14, 287, 290, 289, 285),
(287, 'ruina', 30, 14, 288, 291, 290, 286),
(288, 'ruina', 32, 14, 289, 292, 291, 287),
(289, 'ruina', 34, 14, 290, 293, 292, 288),
(290, 'ruina', 36, 14, 291, 294, 293, 289),
(291, 'ruina', 38, 14, 292, 295, 294, 290),
(292, 'ruina', 40, 14, 293, 296, 295, 291),
(293, 'ruina', 42, 14, 294, 297, 296, 292),
(294, 'ruina', 44, 14, 295, 298, 297, 293),
(295, 'ruina', 46, 14, 296, 299, 298, 294),
(296, 'ruina', 48, 14, 297, 300, 299, 295),
(297, 'ruina', 50, 14, 298, 301, 300, 296),
(298, 'ruina', 52, 14, 299, 302, 301, 297),
(299, 'ruina', 54, 14, 300, 303, 302, 298),
(300, 'ruina', 56, 14, 301, 304, 303, 299),
(301, 'ruina', 58, 14, 302, 305, 304, 300),
(302, 'ruina', 60, 14, 303, 306, 305, 301);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(284, 'Caverna das Estrelas Perdidas', 'Uma caverna repleta de ruínas antigas e estrelas piscando.', 40),
(295, 'Caverna do Céu Eterno', 'Uma caverna com uma visão do céu infinito e segredos ocultos.', 41),
(302, 'Caverna das Luzes Celestiais', 'Uma caverna iluminada por luzes misteriosas e encantadoras.', 42);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(282, 'Masmoia do Trono Celestial', 'Uma masmorra cheia de enigmas e desafios reais.', 40, 'a'),
(288, 'Masmoia do Guardião das Nuvens', 'Uma masmorra protegida por guardiões celestiais e armadilhas.', 41, 'b'),
(295, 'Masmoia da Grande Ascensão', 'Uma masmorra que leva aos céus através de desafios e ilusões.', 42, 'a');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(283, 'Palácio dos Nove Céus', 'Uma residência luxuosa onde viajantes e aventureiros podem encontrar descanso e orientação.', 'a', 'pousada', 80, 160, NULL),
(295, 'Fortaleza Celestial', 'Uma fortaleza que oferece abrigo e sabedoria sobre as terras celestiais.', 'b', 'pousada', 90, 180, NULL),
(302, 'Loja das Joias Celestiais', 'Uma loja especializada em joias e artefatos encontrados nas alturas.', 'a', 'loja', NULL, NULL, 'item');

--- Região Jardins Flutuantes
-- Criar 20 salas para a região Jardins Flutuantes
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(303, 'grama', 15, 15, 304, 305, 306, 307),
(304, 'grama', 17, 15, 305, 308, 307, 303),
(305, 'grama', 19, 15, 306, 309, 308, 304),
(306, 'grama', 21, 15, 307, 310, 309, 305),
(307, 'grama', 23, 15, 308, 311, 310, 306),
(308, 'grama', 25, 15, 309, 312, 311, 307),
(309, 'grama', 27, 15, 310, 313, 312, 308),
(310, 'grama', 29, 15, 311, 314, 313, 309),
(311, 'grama', 31, 15, 312, 315, 314, 310),
(312, 'grama', 33, 15, 313, 316, 315, 311),
(313, 'grama', 35, 15, 314, 317, 316, 312),
(314, 'grama', 37, 15, 315, 318, 317, 313),
(315, 'grama', 39, 15, 316, 319, 318, 314),
(316, 'grama', 41, 15, 317, 320, 319, 315),
(317, 'grama', 43, 15, 318, 321, 320, 316),
(318, 'grama', 45, 15, 319, 322, 321, 317),
(319, 'grama', 47, 15, 320, 323, 322, 318),
(320, 'grama', 49, 15, 321, 324, 323, 319),
(321, 'grama', 51, 15, 322, 325, 324, 320),
(322, 'grama', 53, 15, 323, 326, 325, 321),
(323, 'grama', 55, 15, 324, NULL, 326, 322);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(305, 'Caverna das Flores Eternas', 'Uma caverna submersa em um mar de flores eternas e fragrâncias.', 43),
(312, 'Caverna do Jardim Secreto', 'Uma caverna escondida atrás de uma cortina de flores místicas.', 44),
(320, 'Caverna das Nuvens de Pétalas', 'Uma caverna onde nuvens de pétalas flutuam suavemente.', 45);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(303, 'Masmoia do Jardim Místico', 'Uma masmorra que desafia os aventureiros com ilusões e enigmas florais.', 43, 'a'),
(308, 'Masmoia do Labirinto Verde', 'Uma masmorra repleta de labirintos e armadilhas de vegetação.', 44, 'b'),
(315, 'Masmoia da Grande Floração', 'Uma masmorra que apresenta desafios e quebra-cabeças baseados em floração.', 45, 'a');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(304, 'Pousada das Flores Brilhantes', 'Uma pousada em meio ao jardim, oferecendo conforto e descanso em um ambiente florido.', 'a', 'pousada', 70, 140, NULL),
(312, 'Oficina dos Jardineiros Celestiais', 'Uma oficina que vende e conserta ferramentas e itens para jardinagem e cultivo.', 'b', 'oficina', NULL, NULL, 'item'),
(323, 'Loja das Essências Mágicas', 'Uma loja especializada em poções e essências extraídas das plantas mágicas.', 'a', 'loja', NULL, NULL, 'item');

--- Região Abismo Infernal
-- Criar 20 salas para a região Abismo Infernal
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(323, 'buraco', 60, 16, 324, 325, 326, 327),
(324, 'buraco', 62, 16, 325, 328, 327, 323),
(325, 'buraco', 64, 16, 326, 329, 328, 324),
(326, 'buraco', 66, 16, 327, 330, 329, 325),
(327, 'buraco', 68, 16, 328, 331, 330, 326),
(328, 'buraco', 70, 16, 329, 332, 331, 327),
(329, 'buraco', 72, 16, 330, 333, 332, 328),
(330, 'buraco', 74, 16, 331, 334, 333, 329),
(331, 'buraco', 76, 16, 332, 335, 334, 330),
(332, 'buraco', 78, 16, 333, 336, 335, 331),
(333, 'buraco', 80, 16, 334, 337, 336, 332),
(334, 'buraco', 82, 16, 335, 338, 337, 333),
(335, 'buraco', 84, 16, 336, 339, 338, 334),
(336, 'buraco', 86, 16, 337, 340, 339, 335),
(337, 'buraco', 88, 16, 338, 341, 340, 336),
(338, 'buraco', 90, 16, 339, 342, 341, 337),
(339, 'buraco', 92, 16, 340, 343, 342, 338),
(340, 'buraco', 94, 16, 341, 344, 343, 339),
(341, 'buraco', 96, 16, 342, 345, 344, 340),
(342, 'buraco', 98, 16, 343, NULL, 345, 341);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(326, 'Caverna das Chamas Eterna', 'Uma caverna repleta de lava e chamas eternas, onde o calor é intenso.', 46),
(336, 'Caverna do Abismo Sombrio', 'Uma caverna profunda, mergulhada na escuridão e envolta em sombras ameaçadoras.', 47),
(340, 'Caverna da Fenda de Fogo', 'Uma caverna que emite uma luz avermelhada devido a fissuras de magma.', 48);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(323, 'Masmorra do Inferno Flamejante', 'Uma masmorra com desafios de fogo e lava, repleta de armadilhas flamejantes.', 46, 'a'),
(330, 'Masmorra do Labirinto de Cinzas', 'Uma masmorra com um labirinto de cinzas e obstáculos de magma.', 47, 'b'),
(338, 'Masmorra do Tormento das Sombras', 'Uma masmorra que desafia os aventureiros com sombras e ilusões infernais.', 48, 'a');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(324, 'Pousada das Chamas Afiadas', 'Uma pousada localizada na borda de uma fenda de magma, oferecendo um refúgio quente.', 'a', 'pousada', 80, 160, NULL),
(331, 'Oficina dos Forjadores do Abismo', 'Uma oficina especializada em itens e armas adaptadas ao ambiente infernal.', 'b', 'oficina', NULL, NULL, 'item'),
(342, 'Loja dos Encantamentos Flamejantes', 'Uma loja que vende encantamentos e itens mágicos relacionados ao fogo e à lava.', 'a', 'loja', NULL, NULL, 'item');

--- Região Cavernas do Caos
-- Criar 20 salas para a região Cavernas do Caos
INSERT INTO sala (id_local, tipo_local, tamanho, regiao, local_n, local_s, local_l, local_o) VALUES
(342, 'caverna', 50, 17, 343, 344, 345, 346),
(343, 'caverna', 52, 17, 344, 347, 346, 342),
(344, 'caverna', 54, 17, 345, 348, 347, 343),
(345, 'caverna', 56, 17, 346, 349, 348, 344),
(346, 'caverna', 58, 17, 347, 350, 349, 345),
(347, 'caverna', 60, 17, 348, 351, 350, 346),
(348, 'caverna', 62, 17, 349, 352, 351, 347),
(349, 'caverna', 64, 17, 350, 353, 352, 348),
(350, 'caverna', 66, 17, 351, 354, 353, 349),
(351, 'caverna', 68, 17, 352, 355, 354, 350),
(352, 'caverna', 70, 17, 353, 356, 355, 351),
(353, 'caverna', 72, 17, 354, 357, 356, 352),
(354, 'caverna', 74, 17, 355, 358, 357, 353),
(355, 'caverna', 76, 17, 356, 359, 358, 354),
(356, 'caverna', 78, 17, 357, 360, 359, 355),
(357, 'caverna', 80, 17, 358, 361, 360, 356),
(358, 'caverna', 82, 17, 359, 362, 361, 357),
(359, 'caverna', 84, 17, 360, 363, 362, 358),
(360, 'caverna', 86, 17, 361, 364, 363, 359),
(361, 'caverna', 88, 17, 362, NULL, 364, 360);

-- Adicionar cavernas e masmorras
INSERT INTO caverna (local_caverna, nome, descricao, num_caverna) VALUES
(345, 'Caverna do Caos Fractal', 'Uma caverna onde as formações rochosas seguem padrões caóticos e fractais.', 49),
(355, 'Caverna dos Ecos Distantes', 'Uma caverna profunda, onde os ecos dos passos e sons se tornam confusos e distantes.', 50),
(360, 'Caverna da Confusão Eterna', 'Uma caverna enigmática, onde as direções e caminhos parecem mudar constantemente.', 51);

INSERT INTO masmorra (local_masmorra, nome, descricao, num_masmorra, ranque) VALUES
(342, 'Masmorra dos Labirintos Caóticos', 'Uma masmorra repleta de labirintos e desafios que desafiam a percepção e a orientação.', 49, 'a'),
(351, 'Masmorra do Abismo Turbulento', 'Uma masmorra que se desdobra em várias seções turbulentas, cheias de obstáculos imprevisíveis.', 50, 'b'),
(359, 'Masmorra dos Engenhos Caóticos', 'Uma masmorra onde mecanismos e armadilhas são projetados para desorientar e confundir os aventureiros.', 51, 'a');

INSERT INTO residencia (residencia_npc, nome, descricao, ranque, tipo_residencia, recompor_mana, recompor_vida, tipo_loja) VALUES
(343, 'Pousada dos Cavaleiros do Caos', 'Uma pousada localizada nas profundezas da caverna, oferecendo abrigo e proteção contra os perigos.', 'b', 'pousada', 70, 140, NULL),
(352, 'Oficina dos Artífices Caóticos', 'Uma oficina especializada em criar itens e equipamentos com propriedades caóticas.', 'a', 'oficina', NULL, NULL, 'item'),
(361, 'Loja das Maravilhas Caóticas', 'Uma loja que vende artefatos e itens mágicos com propriedades imprevisíveis e caóticas.', 'b', 'loja', NULL, NULL, 'item');