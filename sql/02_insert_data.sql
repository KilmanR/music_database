-- Заполнение данными музыкальной базы данных

-- Жанры
INSERT INTO public.genres ("name") VALUES
('Grunge'),
('Dance Pop'),
('Electronic'),
('Dance');

-- Исполнители
INSERT INTO public.artists ("name") VALUES
('Nirvana'),
('Elton John, Dua Lipa'),
('Harper Quinn, Emily Esthela, Namté'),
('PHURS, Ivan Crooks, Rachel Morgan Perry'),
('Edo Denova, Sz_Becca');

-- Альбомы
INSERT INTO public.albums (title,"year") VALUES
('Nevermind',1991),
('Cold Heart (PNAU Remix)',2021),
('Stolen Dance',2025),
('Dancing In The Moonlight - Single',2025),
('Like A Prayer',2026);

-- Связь исполнитель-жанр
INSERT INTO public.artist_genre (artist_id,genre_id) VALUES
(1,1),
(2,2),
(3,3),
(4,3),
(5,4);

-- Связь исполнитель-альбом
INSERT INTO public.artist_album (artist_id,album_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

-- Треки
INSERT INTO public.tracks (title,duration_ms,album_id,file_path) VALUES
('Smells Like Teen Spirit',301000,1,'media/audio/nirvana_nevermind_01_smells_like_teen_spirit.mp3'),
('Cold Heart (PNAU Remix)',203000,2,'media/audio/elton_john_dua_lipa_cold_heart_pnau_remix.mp3'),
('Stolen Dance',157000,3,'media/audio/harper_quinn_emily_esthela_namte_stolen_dance.mp3'),
('Dancing In The Moonlight',146000,4,'media/audio/phurs_ivan_crooks_rachel_morgan_perry_dancing_in_the_moonlight.mp3'),
('Like A Prayer',148000,5,'media/audio/edo_denova_sz_becca_like_a_prayer.mp3');