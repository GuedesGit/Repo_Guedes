-- ================================================
-- Script: 01_CreateDatabase.sql
-- Descrição: Cria a base de dados NetflixStyleAppDb
-- Autor: Sistema
-- Data: 2025-07-26
-- ================================================

USE master;
GO

-- Verifica se a base de dados já existe e elimina-a se necessário
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'NetflixStyleAppDb')
BEGIN
    DROP DATABASE NetflixStyleAppDb;
    PRINT 'Base de dados NetflixStyleAppDb eliminada.';
END
GO

-- Cria a nova base de dados
CREATE DATABASE NetflixStyleAppDb;
PRINT 'Base de dados NetflixStyleAppDb criada com sucesso.';
GO

-- Muda para a nova base de dados
USE NetflixStyleAppDb;
GO

PRINT 'Script 01_CreateDatabase.sql executado com sucesso!';
