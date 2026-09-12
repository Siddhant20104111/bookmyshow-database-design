CREATE TABLE theatre (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_name VARCHAR(100) NOT NULL,
    location VARCHAR(150) NOT NULL
);


CREATE TABLE screen (
    screen_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT NOT NULL,
    screen_name VARCHAR(50) NOT NULL,

    CONSTRAINT fk_screen_theatre
        FOREIGN KEY (theatre_id)
        REFERENCES theatre(theatre_id),

    CONSTRAINT uq_theatre_screen
        UNIQUE (theatre_id, screen_name)
);

CREATE TABLE movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(150) NOT NULL,
    language VARCHAR(50) NOT NULL
);
	
CREATE TABLE show (
    show_id INT PRIMARY KEY AUTO_INCREMENT,

    screen_id INT NOT NULL,
    movie_id INT NOT NULL,

    show_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    format VARCHAR(10) NOT NULL,

    FOREIGN KEY (screen_id)
        REFERENCES screen(screen_id),

    FOREIGN KEY (movie_id)
        REFERENCES movie(movie_id),

    CHECK (format IN ('2D', '3D')),

    UNIQUE (screen_id, show_date, start_time)
);

INSERT INTO theatre (theatre_name, location)
VALUES
('PVR: Nexus', 'Kurla, Mumbai'),
('INOX Megaplex', 'Malad, Mumbai')

INSERT INTO screen (theatre_id, screen_name)
VALUES
(1, 'Screen 1'),
(1, 'Screen 2'),
(1, 'Screen 3'),
(2, 'Screen 1'),
(2, 'Screen 2');


INSERT INTO movie (movie_name, language)
VALUES
('Dasara', 'Telugu'),
('Kisi Ka Bhai Kisi Ki Jaan', 'Hindi'),
('Tu Jhoothi Main Makkaar', 'Hindi'),
('Avatar: The Way of Water', 'English');



INSERT INTO show
(screen_id, movie_id, show_date, start_time, end_time, format)
VALUES

-- Dasara
(1, 1, '2026-09-12', '12:15:00', '15:00:00', '2D'),

-- Kisi Ka Bhai Kisi Ki Jaan
(1, 2, '2026-09-12', '13:00:00', '16:00:00', '2D'),
(2, 2, '2026-09-12', '16:10:00', '19:10:00', '2D'),
(3, 2, '2026-09-12', '18:20:00', '21:20:00', '2D'),
(1, 2, '2026-09-12', '19:20:00', '22:20:00', '2D'),
(2, 2, '2026-09-12', '22:30:00', '01:30:00', '2D'),

-- Tu Jhoothi Main Makkaar
(3, 3, '2026-09-12', '21:15:00', '00:15:00', '2D'),

-- Avatar
(1, 4, '2026-09-12', '13:30:00', '16:30:00', '3D');



SELECT
    t.theatre_name,
    m.movie_name,
    m.language,
    sh.format,
    sh.show_date,
    sh.start_time,
    sh.end_time
FROM show sh
JOIN screen s
    ON sh.screen_id = s.screen_id
JOIN theatre t
    ON s.theatre_id = t.theatre_id
JOIN movie m
    ON sh.movie_id = m.movie_id
WHERE t.theatre_name = 'PVR: Nexus'
  AND sh.show_date = '2026-09-12'
ORDER BY sh.start_time;