
-- Название и продолжительность самого длительного трека.

SELECT title, duration_ms
FROM tracks
ORDER BY duration_ms DESC
LIMIT 1;                    

SELECT title, duration_ms
FROM tracks
WHERE duration_ms = (SELECT MAX(duration_ms) FROM tracks);   

-- Название треков, продолжительность которых не менее 3,5 минут.

SELECT title
FROM tracks
WHERE duration_ms >= 210000;  -- 3.5 * 60 * 1000 = 210000 мс. 
-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.

SELECT title
FROM collection
WHERE year BETWEEN 2018 AND 2020;   

-- Исполнители, чьё имя состоит из одного слова.

SELECT name
FROM artists
WHERE name NOT LIKE '% %';  -- Имя без пробелов = одно слово. 

-- Название треков, которые содержат слово «мой» или «my».

SELECT title
FROM tracks
WHERE title ILIKE '%мой%' OR title ILIKE '%my%';   

