-- spotify_indexing.sql
-- ----------------------------------------------------------------------------------
-- SQL Query Optimization Project
-- This script demonstrates the impact of indexing on query performance in PostgreSQL.
-- Run each section one by one to see the "before" and "after" performance of a query.
-- ----------------------------------------------------------------------------------

-- Note: Before running this script, ensure the 'spotify' table is populated with data.
-- If the indexes from a previous run already exist, you may need to drop them first.
-- Example: DROP INDEX IF EXISTS idx_artist;

-- ==================================================================================
-- OPTIMIZATION 1: INDEXING FOR A SIMPLE 'WHERE' CLAUSE
-- ==================================================================================

-- Step 1: Analyze the initial query performance without an index.
-- This query uses a full table scan, which is inefficient.
-- Look for 'Seq Scan' in the output of the query plan.
EXPLAIN ANALYZE
SELECT *
FROM spotify
WHERE artist = 'Ed Sheeran';

-- Step 2: Create a B-tree index on the 'artist' column.
CREATE INDEX idx_artist ON spotify(artist);

-- Step 3: Analyze the query performance again after creating the index.
-- The query plan should now show an 'Index Scan', and the execution time will be significantly lower.
EXPLAIN ANALYZE
SELECT *
FROM spotify
WHERE artist = 'Ed Sheeran';

-- ==================================================================================
-- OPTIMIZATION 2: INDEXING FOR A NUMERIC FILTER AND 'ORDER BY'
-- ==================================================================================

-- Step 1: Analyze the initial query performance without an index.
-- This query filters and sorts on a numeric column.
EXPLAIN ANALYZE
SELECT track, stream
FROM spotify
WHERE stream > 1000000000
ORDER BY stream DESC;

-- Step 2: Create a B-tree index on the 'stream' column.
CREATE INDEX idx_stream ON spotify(stream);

-- Step 3: Analyze the query performance again after creating the index.
-- The index will help both the filtering (WHERE) and the sorting (ORDER BY).
EXPLAIN ANALYZE
SELECT track, stream
FROM spotify
WHERE stream > 1000000000
ORDER BY stream DESC;

-- ==================================================================================
-- OPTIMIZATION 3: INDEXING FOR A CATEGORICAL FILTER
-- ==================================================================================

-- Step 1: Analyze the initial query performance without an index.
-- This query filters on the 'album_type' column.
EXPLAIN ANALYZE
SELECT track
FROM spotify
WHERE album_type = 'single';

-- Step 2: Create a B-tree index on the 'album_type' column.
CREATE INDEX idx_album_type ON spotify(album_type);

-- Step 3: Analyze the query performance again after creating the index.
-- Notice the improvement in execution time, especially on larger datasets.
EXPLAIN ANALYZE
SELECT track
FROM spotify
WHERE album_type = 'single';

-- ==================================================================================
-- OPTIMIZATION 4: USING A COMPOSITE INDEX
-- ==================================================================================

-- Step 1: Analyze the initial query performance without a composite index.
-- This query uses a combination of columns in its WHERE clause.
EXPLAIN ANALYZE
SELECT track
FROM spotify
WHERE artist = 'Dua Lipa' AND album = 'Future Nostalgia';

-- Step 2: Create a composite index on both 'artist' and 'album'.
-- The order of columns in the index matters; put the most selective column first.
CREATE INDEX idx_artist_album ON spotify(artist, album);

-- Step 3: Analyze the query performance again after creating the composite index.
-- The database can now use a single index to find the data, leading to a massive performance boost.
EXPLAIN ANALYZE
SELECT track
FROM spotify
WHERE artist = 'Dua Lipa' AND album = 'Future Nostalgia';
