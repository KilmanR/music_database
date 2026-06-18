-- ========================================
-- Добавление сборников (collection)
-- ========================================

-- 1. Создаем 4 сборника
INSERT INTO collection (collection_id, title, "year") VALUES
(1, 'Best of 90s', 2023),
(2, 'Dance Hits 2020s', 2024),
(3, 'Love Songs', 2023),
(4, 'Electronic Vibes', 2024);

-- 2. Связи сборников с треками

-- Сборник 1: Best of 90s (трек 1 - Nirvana)
INSERT INTO collection_track (collection_id, track_id) VALUES
(1, 1);

-- Сборник 2: Dance Hits 2020s (треки 2, 3, 4, 6)
INSERT INTO collection_track (collection_id, track_id) VALUES
(2, 2),  -- Cold Heart
(2, 3),  -- Stolen Dance
(2, 4),  -- Dancing In The Moonlight
(2, 6);  -- ILYAF

-- Сборник 3: Love Songs (треки 5, 6)
INSERT INTO collection_track (collection_id, track_id) VALUES
(3, 5),  -- Like A Prayer
(3, 6);  -- ILYAF

-- Сборник 4: Electronic Vibes (треки 2, 3, 6)
INSERT INTO collection_track (collection_id, track_id) VALUES
(4, 2),  -- Cold Heart
(4, 3),  -- Stolen Dance
(4, 6);  -- ILYAF