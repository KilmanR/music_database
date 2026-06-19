
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
WHERE year BETWEEN 2018 AND 2020;    -- выдаёт сборник 5. работает.

-- Исполнители, чьё имя состоит из одного слова.

SELECT name
FROM artists
WHERE name NOT LIKE '% %';  -- Имя без пробелов = одно слово. 

-- Название треков, которые содержат слово «мой» или «my».

SELECT title
FROM tracks
WHERE title ILIKE '%мой%' OR title ILIKE '%my%';   

-- Количество исполнителей в каждом жанре.

SELECT g.name AS genre, COUNT(ag.artist_id) AS artists_count
FROM genres g
LEFT JOIN artist_genre ag ON g.id = ag.genre_id
GROUP BY g.id, g.name
ORDER BY artists_count DESC;

-- Количество треков, вошедших в альбомы 2019–2020 годов.

SELECT COUNT(t.id) AS tracks_count
FROM tracks t
JOIN albums a ON t.album_id = a.id
WHERE a.year BETWEEN 2019 AND 2020;

-- Средняя продолжительность треков по каждому альбому.

SELECT a.title AS album, AVG(t.duration_ms) AS avg_duration_ms
FROM albums a
JOIN tracks t ON a.id = t.album_id
GROUP BY a.id, a.title
ORDER BY avg_duration_ms DESC;

-- Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT DISTINCT ar.name AS artist_name
FROM artists ar
WHERE ar.id NOT IN (
    SELECT aa.artist_id
    FROM artist_album aa
    JOIN albums a ON aa.album_id = a.id
    WHERE a.year = 2020
)
ORDER BY ar.name;

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).

SELECT DISTINCT c.title AS collection_name
FROM collection c
JOIN collection_track ct ON c.collection_id = ct.collection_id
JOIN tracks t ON ct.track_id = t.id
JOIN albums a ON t.album_id = a.id
JOIN artist_album aa ON a.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
WHERE ar.name = 'Nirvana'
ORDER BY c.title;

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.

SELECT DISTINCT a.title
FROM albums a
JOIN artist_album aa ON a.id = aa.album_id
JOIN artist_genre ag ON aa.artist_id = ag.artist_id
GROUP BY a.id, a.title
HAVING COUNT(DISTINCT ag.genre_id) > 1;

-- Наименования треков, которые не входят в сборники.

SELECT title
FROM tracks
WHERE id NOT IN (
    SELECT track_id FROM collection_track
);

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько

SELECT ar.name AS artist, t.title, t.duration_ms
FROM artists ar
JOIN artist_album aa ON ar.id = aa.artist_id
JOIN tracks t ON aa.album_id = t.album_id
WHERE t.duration_ms = (SELECT MIN(duration_ms) FROM tracks)
ORDER BY ar.name;

-- Названия альбомов, содержащих наименьшее количество треков.

SELECT a.title, COUNT(t.id) AS tracks_count
FROM albums a
JOIN tracks t ON a.id = t.album_id
GROUP BY a.id, a.title
HAVING COUNT(t.id) = (
    SELECT COUNT(*)
    FROM tracks
    GROUP BY album_id
    ORDER BY COUNT(*) ASC
    LIMIT 1
)
ORDER BY a.title;