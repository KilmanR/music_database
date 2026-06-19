-- Заполнение данными музыкальной базы данных

-- Жанры
INSERT INTO public.genres ("name") VALUES
('Grunge'),
('Dance Pop'),
('Electronic'),
('Dance'),
('Synthpop');

-- Исполнители
INSERT INTO public.artists ("name") VALUES
('Nirvana'),
('Elton John, Dua Lipa'),
('Harper Quinn, Emily Esthela, Namté'),
('PHURS, Ivan Crooks, Rachel Morgan Perry'),
('Edo Denova, Sz_Becca'),
('Donna Lewis, Digital Farm Animals');

-- Альбомы
INSERT INTO public.albums (title,"year") VALUES
('Nevermind',1991),
('Cold Heart (PNAU Remix)',2021),
('Stolen Dance',2025),
('Dancing In The Moonlight - Single',2025),
('Like A Prayer',2026),
('ILYAF (I love you always forever)', 2023);

-- Связь исполнитель-жанр
INSERT INTO public.artist_genre (artist_id,genre_id) VALUES
(1,1),
(2,2),
(3,3),
(4,3),
(5,4),
(6,5);

-- Связь исполнитель-альбом
INSERT INTO public.artist_album (artist_id,album_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6);

-- Треки
INSERT INTO public.tracks (title,duration_ms,album_id,file_path) VALUES
('Smells Like Teen Spirit',301000,1,'media/audio/nirvana_nevermind_01_smells_like_teen_spirit.mp3'),
('Cold Heart (PNAU Remix)',203000,2,'media/audio/elton_john_dua_lipa_cold_heart_pnau_remix.mp3'),
('Stolen Dance',157000,3,'media/audio/harper_quinn_emily_esthela_namte_stolen_dance.mp3'),
('Dancing In The Moonlight',146000,4,'media/audio/phurs_ivan_crooks_rachel_morgan_perry_dancing_in_the_moonlight.mp3'),
('Like A Prayer',148000,5,'media/audio/edo_denova_sz_becca_like_a_prayer.mp3'),
('ILYAF (I love you always forever)', 166000, 6, 'media/audio/donna_lewis_digital_farm_animals_ilyaf.mp3');

-- ========================================
-- Добавление сборников (collection)
-- ========================================

-- 1. Создаем 5 сборников
INSERT INTO collection (collection_id, title, "year") VALUES
(1, 'Best of 90s', 2023),
(2, 'Dance Hits 2020s', 2024),
(3, 'Love Songs', 2023),
(4, 'Electronic Vibes', 2024),
(5, 'Best of 2019', 2019);

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

-- Сборник 5: Best of 2019 (треки 1, 2)
INSERT INTO collection_track (collection_id, track_id) VALUES
(5, 1),  -- Smells Like Teen Spirit
(5, 2);  -- Cold Heart