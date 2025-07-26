-- ================================================
-- Script: 02_CreateTables.sql
-- Descrição: Cria as tabelas da aplicação Netflix Style
-- Autor: Sistema
-- Data: 2025-07-26
-- ================================================

USE NetflixStyleAppDb;
GO

-- ================================================
-- Tabela: Movies
-- Descrição: Armazena filmes e séries
-- ================================================
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
GO

-- ================================================
-- Tabela: Users
-- Descrição: Armazena utilizadores da aplicação
-- ================================================
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    UpdatedDate DATETIME2 DEFAULT GETDATE()
);
GO

-- ================================================
-- Tabela: Episodes
-- Descrição: Armazena episódios das séries
-- ================================================
CREATE TABLE Episodes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SeriesId INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    Number INT NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    UpdatedDate DATETIME2 DEFAULT GETDATE(),
    
    -- Chave estrangeira para Movies (séries)
    CONSTRAINT FK_Episodes_Movies FOREIGN KEY (SeriesId) REFERENCES Movies(Id) ON DELETE CASCADE
);
GO

-- ================================================
-- Tabela: UserFavorites
-- Descrição: Tabela de ligação para filmes favoritos dos utilizadores
-- ================================================
CREATE TABLE UserFavorites (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    MovieId INT NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    
    -- Chaves estrangeiras
    CONSTRAINT FK_UserFavorites_Users FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_UserFavorites_Movies FOREIGN KEY (MovieId) REFERENCES Movies(Id) ON DELETE CASCADE,
    
    -- Índice único para evitar duplicados
    CONSTRAINT UQ_UserFavorites_UserMovie UNIQUE (UserId, MovieId)
);
GO

-- ================================================
-- Índices para melhor performance
-- ================================================

-- Índice para pesquisa por categoria
CREATE INDEX IX_Movies_Category ON Movies(Category);

-- Índice para pesquisa por ano
CREATE INDEX IX_Movies_Year ON Movies(Year);

-- Índice para pesquisa por tipo (filme/série)
CREATE INDEX IX_Movies_IsSeries ON Movies(IsSeries);

-- Índice para episódios por série
CREATE INDEX IX_Episodes_SeriesId ON Episodes(SeriesId);

-- Índice para pesquisa de utilizadores por email
CREATE INDEX IX_Users_Email ON Users(Email);

GO

PRINT 'Tabelas criadas com sucesso!';
PRINT 'Script 02_CreateTables.sql executado com sucesso!';
