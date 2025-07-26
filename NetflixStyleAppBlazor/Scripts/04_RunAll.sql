-- ================================================
-- Script: 04_RunAll.sql
-- Descrição: Script principal que executa todos os scripts em sequência
-- Autor: Sistema
-- Data: 2025-07-26
-- ================================================

PRINT '================================================';
PRINT 'INÍCIO DA CONFIGURAÇÃO DA BASE DE DADOS';
PRINT 'NetflixStyleApp Database Setup';
PRINT '================================================';
PRINT '';

-- ================================================
-- 1. Criar Base de Dados
-- ================================================
PRINT '1. A criar base de dados...';

USE master;
GO

-- Verifica se a base de dados já existe e elimina-a se necessário
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'NetflixStyleAppDb')
BEGIN
    DROP DATABASE NetflixStyleAppDb;
    PRINT '   ✓ Base de dados existente eliminada.';
END
GO

-- Cria a nova base de dados
CREATE DATABASE NetflixStyleAppDb;
PRINT '   ✓ Base de dados NetflixStyleAppDb criada com sucesso.';
GO

-- Muda para a nova base de dados
USE NetflixStyleAppDb;
GO

-- ================================================
-- 2. Criar Tabelas
-- ================================================
PRINT '';
PRINT '2. A criar tabelas...';

-- Tabela: Movies
CREATE TABLE Movies (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    ImageUrl NVARCHAR(500) NULL,
    Category NVARCHAR(100) NULL,
    Year INT NOT NULL,
    IsSeries BIT NOT NULL DEFAULT 0,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    UpdatedDate DATETIME2 DEFAULT GETDATE()
);
PRINT '   ✓ Tabela Movies criada.';

-- Tabela: Users
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    UpdatedDate DATETIME2 DEFAULT GETDATE()
);
PRINT '   ✓ Tabela Users criada.';

-- Tabela: Episodes
CREATE TABLE Episodes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SeriesId INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    Number INT NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    UpdatedDate DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT FK_Episodes_Movies FOREIGN KEY (SeriesId) REFERENCES Movies(Id) ON DELETE CASCADE
);
PRINT '   ✓ Tabela Episodes criada.';

-- Tabela: UserFavorites
CREATE TABLE UserFavorites (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    MovieId INT NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT FK_UserFavorites_Users FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_UserFavorites_Movies FOREIGN KEY (MovieId) REFERENCES Movies(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_UserFavorites_UserMovie UNIQUE (UserId, MovieId)
);
PRINT '   ✓ Tabela UserFavorites criada.';

-- Criar Índices
CREATE INDEX IX_Movies_Category ON Movies(Category);
CREATE INDEX IX_Movies_Year ON Movies(Year);
CREATE INDEX IX_Movies_IsSeries ON Movies(IsSeries);
CREATE INDEX IX_Episodes_SeriesId ON Episodes(SeriesId);
CREATE INDEX IX_Users_Email ON Users(Email);
PRINT '   ✓ Índices criados.';

-- ================================================
-- 3. Inserir Dados de Exemplo
-- ================================================
PRINT '';
PRINT '3. A inserir dados de exemplo...';

-- Inserir Filmes
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
PRINT '   ✓ Filmes inseridos.';

-- Inserir Séries
INSERT INTO Movies (Title, Description, ImageUrl, Category, Year, IsSeries) VALUES 
('Breaking Bad', 'Um professor de química do ensino médio diagnosticado com câncer de pulmão inoperável recorre à fabricação e venda de metanfetamina para garantir o futuro financeiro da sua família.', 'https://via.placeholder.com/300x450?text=BreakingBad', 'Crime', 2008, 1),
('Game of Thrones', 'Nove famílias nobres lutam pelo controlo das terras míticas de Westeros, enquanto um inimigo antigo retorna depois de estar adormecido por milénios.', 'https://via.placeholder.com/300x450?text=GameOfThrones', 'Fantasia', 2011, 1),
('The Office', 'Uma comédia mockumentary sobre um grupo de funcionários típicos de escritório, onde o dia de trabalho consiste em confrontos de ego, comportamento inadequado e tédio.', 'https://via.placeholder.com/300x450?text=TheOffice', 'Comédia', 2005, 1),
('Stranger Things', 'Quando um rapaz desaparece, a sua mãe, um chefe de polícia e os seus amigos devem confrontar forças aterrorizantes para o recuperar.', 'https://via.placeholder.com/300x450?text=StrangerThings', 'Ficção Científica', 2016, 1),
('The Crown', 'Segue a vida política rivalries e romance da Rainha Elizabeth II de Inglaterra e os eventos que moldaram a segunda metade do século XX.', 'https://via.placeholder.com/300x450?text=TheCrown', 'Drama', 2016, 1),
('Friends', 'Segue a vida pessoal e profissional de seis amigos de 20 e poucos anos vivendo em Manhattan.', 'https://via.placeholder.com/300x450?text=Friends', 'Comédia', 1994, 1),
('The Witcher', 'Geralt de Rívia, um caçador de monstros solitário, luta para encontrar o seu lugar num mundo onde as pessoas frequentemente se provam mais perversas que as bestas.', 'https://via.placeholder.com/300x450?text=TheWitcher', 'Fantasia', 2019, 1),
('Narcos', 'Uma história cronológica da guerra contra as drogas, centrada no infame narcotraficante colombiano Pablo Escobar e outros senhores da droga que assolaram o país.', 'https://via.placeholder.com/300x450?text=Narcos', 'Crime', 2015, 1);
PRINT '   ✓ Séries inseridas.';

-- Inserir Utilizadores
INSERT INTO Users (Name, Email, PasswordHash) VALUES 
('João Silva', 'joao.silva@email.com', 'hashed_password_123'),
('Maria Santos', 'maria.santos@email.com', 'hashed_password_456'),
('Pedro Costa', 'pedro.costa@email.com', 'hashed_password_789'),
('Ana Oliveira', 'ana.oliveira@email.com', 'hashed_password_101'),
('Carlos Ferreira', 'carlos.ferreira@email.com', 'hashed_password_202');
PRINT '   ✓ Utilizadores inseridos.';

-- Inserir Episódios
INSERT INTO Episodes (SeriesId, Title, Number, Description) VALUES 
(11, 'Pilot', 1, 'Walter White, um professor de química, descobre que tem câncer e decide fabricar metanfetamina.'),
(11, 'Cat''s in the Bag...', 2, 'Walter e Jesse tentam descobrir como descartar os corpos dos dealers mortos.'),
(11, '...And the Bag''s in the River', 3, 'Walter debate-se com a decisão de matar Krazy-8.'),
(12, 'Winter Is Coming', 1, 'Eddard Stark é arrancado da sua vida pacífica como Senhor de Winterfell para servir como a Mão do Rei.'),
(12, 'The Kingsroad', 2, 'Enquanto Bran recupera de sua queda, Ned aceita relutantemente o papel de Mão do Rei.'),
(14, 'Chapter One: The Vanishing of Will Byers', 1, 'No caminho para casa de uma campanha de D&D, Will é aterrorizado por algo invisível e desaparece.'),
(14, 'Chapter Two: The Weirdo on Maple Street', 2, 'Lucas, Mike e Dustin tentam conversar com a rapariga que encontraram na floresta.');
PRINT '   ✓ Episódios inseridos.';

-- Inserir Favoritos
INSERT INTO UserFavorites (UserId, MovieId) VALUES 
(1, 1), (1, 3), (1, 11),
(2, 2), (2, 5), (2, 12),
(3, 6), (3, 7), (3, 14),
(4, 9), (4, 15),
(5, 4), (5, 8);
PRINT '   ✓ Favoritos dos utilizadores inseridos.';

-- ================================================
-- 4. Verificação Final
-- ================================================
PRINT '';
PRINT '4. Verificação final...';

DECLARE @MovieCount INT, @UserCount INT, @EpisodeCount INT, @FavoriteCount INT;

SELECT @MovieCount = COUNT(*) FROM Movies;
SELECT @UserCount = COUNT(*) FROM Users;
SELECT @EpisodeCount = COUNT(*) FROM Episodes;
SELECT @FavoriteCount = COUNT(*) FROM UserFavorites;

PRINT '   ✓ Total de Filmes/Séries: ' + CAST(@MovieCount AS NVARCHAR(10));
PRINT '   ✓ Total de Utilizadores: ' + CAST(@UserCount AS NVARCHAR(10));
PRINT '   ✓ Total de Episódios: ' + CAST(@EpisodeCount AS NVARCHAR(10));
PRINT '   ✓ Total de Favoritos: ' + CAST(@FavoriteCount AS NVARCHAR(10));

PRINT '';
PRINT '================================================';
PRINT 'CONFIGURAÇÃO CONCLUÍDA COM SUCESSO! ✓';
PRINT 'A base de dados NetflixStyleAppDb está pronta para uso.';
PRINT '================================================';
