-- =============================================
-- Script: Queries Úteis para Testes
-- Autor: Sistema
-- Data: 2025-07-26
-- =============================================

USE NetflixStyleAppDb;

-- =============================================
-- QUERIES DE CONSULTA
-- =============================================

-- 1. Listar todos os utilizadores
SELECT * FROM Users ORDER BY Name;

-- 2. Listar todos os filmes
SELECT * FROM Movies WHERE IsSeries = 0 ORDER BY Year DESC, Title;

-- 3. Listar todas as séries
SELECT * FROM Movies WHERE IsSeries = 1 ORDER BY Year DESC, Title;

-- 4. Listar todos os episódios com o nome da série
SELECT 
    s.Title as SerieName,
    e.Title as EpisodeTitle,
    e.Number as EpisodeNumber,
    e.Description
FROM Episodes e
INNER JOIN Movies s ON e.SeriesId = s.Id
ORDER BY s.Title, e.Number;

-- 5. Listar favoritos de cada utilizador
SELECT 
    u.Name as UserName,
    m.Title as MovieTitle,
    CASE WHEN m.IsSeries = 1 THEN 'Série' ELSE 'Filme' END as Type,
    m.Category,
    m.Year
FROM UserFavorites uf
INNER JOIN Users u ON uf.UserId = u.Id
INNER JOIN Movies m ON uf.MovieId = m.Id
ORDER BY u.Name, m.Title;

-- 6. Contar filmes por categoria
SELECT 
    Category,
    COUNT(*) as Total,
    CASE WHEN IsSeries = 1 THEN 'Séries' ELSE 'Filmes' END as Type
FROM Movies 
GROUP BY Category, IsSeries
ORDER BY Category, IsSeries;

-- 7. Utilizadores com mais favoritos
SELECT 
    u.Name,
    COUNT(uf.MovieId) as TotalFavorites
FROM Users u
LEFT JOIN UserFavorites uf ON u.Id = uf.UserId
GROUP BY u.Id, u.Name
ORDER BY TotalFavorites DESC;

-- 8. Séries com episódios
SELECT 
    m.Title as SerieName,
    COUNT(e.Id) as TotalEpisodes
FROM Movies m
LEFT JOIN Episodes e ON m.Id = e.SeriesId
WHERE m.IsSeries = 1
GROUP BY m.Id, m.Title
ORDER BY TotalEpisodes DESC, m.Title;

-- 9. Filmes/Séries mais populares (mais nos favoritos)
SELECT 
    m.Title,
    CASE WHEN m.IsSeries = 1 THEN 'Série' ELSE 'Filme' END as Type,
    m.Category,
    m.Year,
    COUNT(uf.UserId) as TimesFavorited
FROM Movies m
LEFT JOIN UserFavorites uf ON m.Id = uf.MovieId
GROUP BY m.Id, m.Title, m.IsSeries, m.Category, m.Year
ORDER BY TimesFavorited DESC, m.Title;

-- 10. Buscar por categoria específica
SELECT * FROM Movies WHERE Category = 'Ação' ORDER BY Year DESC;

PRINT 'Queries de teste executadas com sucesso!';
