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