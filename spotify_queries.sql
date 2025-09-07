-- spotify_queries.sql
-- DML to import data from a CSV file.
-- This command assumes you are running this from a PostgreSQL terminal (psql)
-- and that the 'dataset_spotify.csv' file is in the same directory.
-- If you are using a client like pgAdmin, you may need to use \copy.

COPY spotify FROM 'dataset_spotify.csv' DELIMITER ',' CSV HEADER;

-- Easy Level Queries

-- Q1: Retrieve the names of all tracks that have more than 1 billion streams.
SELECT track
FROM spotify
WHERE stream > 1000000000;

-- Q2: List all albums along with their respective artists.
SELECT album, artist
FROM spotify;

-- Q3: Get the total number of comments for tracks where licensed = TRUE.
SELECT SUM(comments) AS total_licensed_comments
FROM spotify
WHERE licensed = TRUE;

-- Q4: Find all tracks that belong to the album type 'single'.
SELECT track
FROM spotify
WHERE album_type = 'single';

-- Q5: Count the total number of tracks by each artist.
SELECT artist, COUNT(track) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks DESC;

-- Medium Level Queries

-- Q1: Calculate the average danceability of tracks in each album.
SELECT album, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album;

-- Q2: Find the top 5 tracks with the highest energy values.
SELECT track, energy
FROM spotify
ORDER BY energy DESC
LIMIT 5;

-- Q3: List all tracks along with their views and likes where official_video = TRUE.
SELECT track, views, likes
FROM spotify
WHERE official_video = TRUE;

-- Q4: For each album, calculate the total views of all associated tracks.
SELECT album, SUM(views) AS total_views
FROM spotify
GROUP BY album
ORDER BY total_views DESC;

-- Q5: Retrieve the track names that have been streamed on Spotify more than YouTube.
-- 'views' column likely represents YouTube views based on project context
SELECT track
FROM spotify
WHERE stream > views;

-- Advanced Level Queries

-- Q1: Find the top 3 most-viewed tracks for each artist using window functions.
SELECT artist, track, views
FROM (
    SELECT
        artist,
        track,
        views,
        ROW_NUMBER() OVER(PARTITION BY artist ORDER BY views DESC) as rn
    FROM spotify
) AS ranked_views
WHERE rn <= 3;

-- Q2: Write a query to find tracks where the liveness score is above the average.
SELECT track, liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);

-- Q3: Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
WITH cte AS (
    SELECT 
        album,
        MAX(energy) AS highest_energy,
        MIN(energy) AS lowest_energy
    FROM spotify
    GROUP BY album
)
SELECT 
    album,
    highest_energy - lowest_energy AS energy_diff
FROM cte
ORDER BY energy_diff DESC;

-- Q4: Find tracks where the energy-to-liveness ratio is greater than 1.2.
SELECT track
FROM spotify
WHERE (energy / liveness) > 1.2;

-- Q5: Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
SELECT 
    track,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views DESC) AS cumulative_likes
FROM spotify;
