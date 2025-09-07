Spotify Data Analysis using SQL
Project Overview
This project involves an end-to-end data analysis of a Spotify dataset using SQL. It's designed to be a comprehensive guide to practicing and showcasing advanced SQL skills. The project covers a full workflow, from understanding a denormalized dataset to performing complex queries and, finally, optimizing query performance for efficiency.

The Dataset
The project utilizes a dataset containing detailed information about popular tracks, including:

Track Details: track, album, artist, and album_type.

Audio Metrics: danceability, energy, loudness, tempo, and other attributes that describe the song's musical characteristics.

Engagement Metrics: views, likes, comments, and stream count, providing insights into audience interaction.

Project Steps
Data Exploration: Before writing any code, it's essential to understand the dataset's structure, columns, and the type of data they hold.

Data Preparation: The project uses a single, denormalized table for simplicity. You will set up the database schema by executing the spotify_schema.sql file.

Data Ingestion: Load the data from the dataset_spotify.csv file into the spotify table using the spotify_queries.sql file.

Querying the Data: This is the core of the project. You will execute a series of queries to extract valuable insights, categorized by difficulty to help progressively build your skills.

Query Optimization: In this final step, you will focus on improving query performance. You will use EXPLAIN ANALYZE to measure performance and create indexes to demonstrate how they can drastically reduce query execution time.

15 Practice Questions
The spotify_queries.sql file contains the solutions to these problems.

Easy Level
Retrieve the names of all tracks that have more than 1 billion streams.

List all albums along with their respective artists.

Get the total number of comments for tracks where licensed = TRUE.

Find all tracks that belong to the album type single.

Count the total number of tracks by each artist.

Medium Level
Calculate the average danceability of tracks in each album.

Find the top 5 tracks with the highest energy values.

List all tracks along with their views and likes where official_video = TRUE.

For each album, calculate the total views of all associated tracks.

Retrieve the track names that have been streamed on Spotify more than YouTube.

Advanced Level
Find the top 3 most-viewed tracks for each artist using window functions.

Write a query to find tracks where the liveness score is above the average.

Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

Find tracks where the energy-to-liveness ratio is greater than 1.2.

Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

Query Optimization
This section is a dedicated part of the project that you can explore by running the query_optimization.sql file. It's a hands-on guide to using indexes to improve performance.

Before Indexing: The query plan will likely show a Seq Scan (Sequential Scan). This means the database is reading every single row of the table to find the data it needs. The Execution Time will be relatively high.

After Indexing: The query plan should change to an Index Scan or Index Only Scan. This indicates the database is now using the index to quickly locate the relevant rows, avoiding a full table scan. You will see a significant drop in the Execution Time.

Technology Stack
Database: PostgreSQL

SQL Queries: DDL, DML, Aggregations, Joins, Subqueries, Window Functions, CTEs

Tools: A SQL client (e.g., psql or pgAdmin 4)

How to Run the Project
Set Up the Database: Ensure you have a PostgreSQL database set up.

Create the Table: Execute the SQL commands in spotify_schema.sql to create the spotify table.

Load the Data: Execute the COPY command in spotify_queries.sql to load data from your dataset_spotify.csv file.

Run the Queries: Execute the rest of the queries in spotify_queries.sql to get the answers to the practice questions.

Analyze Performance: Open the query_optimization.sql file and follow the step-by-step instructions to understand the impact of indexing on performance.
