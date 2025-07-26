-- ================================================
-- Script: 03_InsertSampleData.sql
-- Descrição: Insere dados de exemplo na aplicação Netflix Style
-- Autor: Sistema
-- Data: 2025-07-26
-- ================================================

USE NetflixStyleAppDb;
GO

-- ================================================
-- Inserir Filmes
-- ================================================
INSERT INTO Movies (Title, Description, ImageUrl, Category, Year, IsSeries) VALUES 
('The Shawshank Redemption', 'Dois homens presos formam uma ligação ao longo de vários anos, encontrando consolo e eventual redenção através de atos de decência comum.', 'https://via.placeholder.com/300x450?text=Shawshank', 'Drama', 1994, 0),
('The Godfather', 'O patriarca envelhecido de uma dinastia do crime organizado transfere o controle do seu império clandestino para o seu filho relutante.', 'https://via.placeholder.com/300x450?text=Godfather', 'Crime', 1972, 0),
('The Dark Knight', 'Quando a ameaça conhecida como Joker surge do seu passado misterioso, ele faz estragos e caos nas pessoas de Gotham.', 'https://via.placeholder.com/300x450?text=DarkKnight', 'Ação', 2008, 0),
('Pulp Fiction', 'As vidas de dois assassinos da máfia, um boxeador, um gângster e sua esposa, e um par de bandidos se entrelaçam em quatro histórias de violência e redenção.', 'https://via.placeholder.com/300x450?text=PulpFiction', 'Crime', 1994, 0),
('Forrest Gump', 'As presidências de Kennedy e Johnson, a Guerra do Vietnã, o escândalo Watergate e outros eventos históricos se desenrolam através da perspectiva de um homem do Alabama.', 'https://via.placeholder.com/300x450?text=ForrestGump', 'Drama', 1994, 0),
('Inception', 'Um ladrão que rouba segredos corporativos através da tecnologia de compartilhamento de sonhos recebe a tarefa inversa de plantar uma ideia na mente de um CEO.', 'https://via.placeholder.com/300x450?text=Inception', 'Ficção Científica', 2010, 0),
('The Matrix', 'Um hacker de computador aprende de rebeldes misteriosos sobre a verdadeira natureza da sua realidade e o seu papel na guerra contra os seus controladores.', 'https://via.placeholder.com/300x450?text=Matrix', 'Ficção Científica', 1999, 0),
('Goodfellas', 'A história da ascensão e queda de Henry Hill e seus amigos durante três décadas, enquanto fazem o seu caminho através das fileiras da máfia.', 'https://via.placeholder.com/300x450?text=Goodfellas', 'Crime', 1990, 0),
('The Lord of the Rings: The Fellowship of the Ring', 'Um hobbit meek de Shire e oito companheiros partiram numa jornada para destruir o poderoso Um Anel e salvar a Terra Média do Senhor das Trevas Sauron.', 'https://via.placeholder.com/300x450?text=LOTR1', 'Fantasia', 2001, 0),
('Interstellar', 'Uma equipa de exploradores viaja através de um buraco de minhoca no espaço na tentativa de garantir a sobrevivência da humanidade.', 'https://via.placeholder.com/300x450?text=Interstellar', 'Ficção Científica', 2014, 0);

-- ================================================
-- Inserir Séries
-- ================================================
INSERT INTO Movies (Title, Description, ImageUrl, Category, Year, IsSeries) VALUES 
('Breaking Bad', 'Um professor de química do ensino médio diagnosticado com câncer de pulmão inoperável recorre à fabricação e venda de metanfetamina para garantir o futuro financeiro da sua família.', 'https://via.placeholder.com/300x450?text=BreakingBad', 'Crime', 2008, 1),
('Game of Thrones', 'Nove famílias nobres lutam pelo controlo das terras míticas de Westeros, enquanto um inimigo antigo retorna depois de estar adormecido por milénios.', 'https://via.placeholder.com/300x450?text=GameOfThrones', 'Fantasia', 2011, 1),
('The Office', 'Uma comédia mockumentary sobre um grupo de funcionários típicos de escritório, onde o dia de trabalho consiste em confrontos de ego, comportamento inadequado e tédio.', 'https://via.placeholder.com/300x450?text=TheOffice', 'Comédia', 2005, 1),
('Stranger Things', 'Quando um rapaz desaparece, a sua mãe, um chefe de polícia e os seus amigos devem confrontar forças aterrorizantes para o recuperar.', 'https://via.placeholder.com/300x450?text=StrangerThings', 'Ficção Científica', 2016, 1),
('The Crown', 'Segue a vida política rivalries e romance da Rainha Elizabeth II de Inglaterra e os eventos que moldaram a segunda metade do século XX.', 'https://via.placeholder.com/300x450?text=TheCrown', 'Drama', 2016, 1),
('Friends', 'Segue a vida pessoal e profissional de seis amigos de 20 e poucos anos vivendo em Manhattan.', 'https://via.placeholder.com/300x450?text=Friends', 'Comédia', 1994, 1),
('The Witcher', 'Geralt de Rívia, um caçador de monstros solitário, luta para encontrar o seu lugar num mundo onde as pessoas frequentemente se provam mais perversas que as bestas.', 'https://via.placeholder.com/300x450?text=TheWitcher', 'Fantasia', 2019, 1),
('Narcos', 'Uma história cronológica da guerra contra as drogas, centrada no infame narcotraficante colombiano Pablo Escobar e outros senhores da droga que assolaram o país.', 'https://via.placeholder.com/300x450?text=Narcos', 'Crime', 2015, 1);

GO

-- ================================================
-- Inserir Utilizadores de exemplo
-- ================================================
INSERT INTO Users (Name, Email, PasswordHash) VALUES 
('João Silva', 'joao.silva@email.com', 'hashed_password_123'),
('Maria Santos', 'maria.santos@email.com', 'hashed_password_456'),
('Pedro Costa', 'pedro.costa@email.com', 'hashed_password_789'),
('Ana Oliveira', 'ana.oliveira@email.com', 'hashed_password_101'),
('Carlos Ferreira', 'carlos.ferreira@email.com', 'hashed_password_202');

GO

-- ================================================
-- Inserir Episódios para as Séries
-- ================================================

-- Episódios de Breaking Bad (SeriesId = 11)
INSERT INTO Episodes (SeriesId, Title, Number, Description) VALUES 
(11, 'Pilot', 1, 'Walter White, um professor de química, descobre que tem câncer e decide fabricar metanfetamina.'),
(11, 'Cat\'s in the Bag...', 2, 'Walter e Jesse tentam descobrir como descartar os corpos dos dealers mortos.'),
(11, '...And the Bag\'s in the River', 3, 'Walter debate-se com a decisão de matar Krazy-8.'),
(11, 'Cancer Man', 4, 'Walter conta à sua família sobre o seu cancro e Jesse tenta vender meth por conta própria.'),
(11, 'Gray Matter', 5, 'Walter fica furioso quando Elliott e Gretchen se oferecem para pagar o seu tratamento.');

-- Episódios de Game of Thrones (SeriesId = 12)
INSERT INTO Episodes (SeriesId, Title, Number, Description) VALUES 
(12, 'Winter Is Coming', 1, 'Eddard Stark é arrancado da sua vida pacífica como Senhor de Winterfell para servir como a Mão do Rei.'),
(12, 'The Kingsroad', 2, 'Enquanto Bran recupera de sua queda, Ned aceita relutantemente o papel de Mão do Rei.'),
(12, 'Lord Snow', 3, 'Jon Snow começa o seu treino com a Patrulha da Noite; Ned confronta a sua lealdade ao rei.'),
(12, 'Cripples, Bastards, and Broken Things', 4, 'Eddard investiga a morte de Jon Arryn; Jon protege Samwell Tarly na Patrulha da Noite.'),
(12, 'The Wolf and the Lion', 5, 'Catelyn captura Tyrion e planeia levá-lo para sua irmã Lysa no Vale.');

-- Episódios de Stranger Things (SeriesId = 14)
INSERT INTO Episodes (SeriesId, Title, Number, Description) VALUES 
(14, 'Chapter One: The Vanishing of Will Byers', 1, 'No caminho para casa de uma campanha de D&D, Will é aterrorizado por algo invisível e desaparece.'),
(14, 'Chapter Two: The Weirdo on Maple Street', 2, 'Lucas, Mike e Dustin tentam conversar com a rapariga que encontraram na floresta.'),
(14, 'Chapter Three: Holly, Jolly', 3, 'Uma ligação ansiosa não oficial de Hopper começa a dar frutos. Joyce e Hopper descobrem a verdade sobre os experimentos do laboratório.'),
(14, 'Chapter Four: The Body', 4, 'Recusando-se a acreditar que Will está morto, Joyce e Hopper quebram no laboratório de Hawkins National.'),
(14, 'Chapter Five: Dig Dug', 5, 'Nancy e Jonathan trocam teorias sobre o monstro. Enquanto isso, Hopper descobre a verdade sobre os experimentos de Hawkins Lab.');

GO

-- ================================================
-- Inserir alguns filmes favoritos para os utilizadores
-- ================================================
INSERT INTO UserFavorites (UserId, MovieId) VALUES 
(1, 1), -- João Silva gosta de Shawshank Redemption
(1, 3), -- João Silva gosta de The Dark Knight
(1, 11), -- João Silva gosta de Breaking Bad
(2, 2), -- Maria Santos gosta de The Godfather
(2, 5), -- Maria Santos gosta de Forrest Gump
(2, 12), -- Maria Santos gosta de Game of Thrones
(3, 6), -- Pedro Costa gosta de Inception
(3, 7), -- Pedro Costa gosta de The Matrix
(3, 14), -- Pedro Costa gosta de Stranger Things
(4, 9), -- Ana Oliveira gosta de LOTR
(4, 15), -- Ana Oliveira gosta de The Crown
(5, 4), -- Carlos Ferreira gosta de Pulp Fiction
(5, 8); -- Carlos Ferreira gosta de Goodfellas

GO

PRINT 'Dados de exemplo inseridos com sucesso!';
PRINT 'Script 03_InsertSampleData.sql executado com sucesso!';
