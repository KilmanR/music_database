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