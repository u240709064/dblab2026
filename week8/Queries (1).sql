USE movie_db;

# 1. Show the Quentin Tarantino films which have more than 500000 votes and produced before 2000.
SELECT m.title, m.votes, m.year
FROM movies m
JOIN movie_directors md ON m.movie_id = md.movie_id
JOIN directors d ON md.director_id = d.director_id
WHERE d.director_name = 'Quentin Tarantino'
  AND m.votes > 500000
  AND m.year < 2000;

# 2. Show the films that Tom Hanks has act and have won more than 3 Oscars.
SELECT m.title, m.oscars
FROM movies m
JOIN movie_stars ms ON m.movie_id = ms.movie_id
JOIN stars s ON ms.star_id = s.star_id
WHERE s.star_name = 'Tom Hanks'
  AND m.oscars > 3;

# 3. Show the history films produced in USA and whose duration is between 100-200 minutes.
SELECT m.title, m.duration
FROM movies m
JOIN genres g ON m.movie_id = g.movie_id
JOIN producer_countries pc ON m.movie_id = pc.movie_id
JOIN countries c ON pc.country_id = c.country_id
WHERE g.genre_name = 'History'
  AND c.country_name = 'USA'
  AND m.duration BETWEEN 100 AND 200;

# 4. Compute the average budget of the films directed by Peter Jackson.
SELECT AVG(m.budget) AS average_budget
FROM movies m
JOIN movie_directors md ON m.movie_id = md.movie_id
JOIN directors d ON md.director_id = d.director_id
WHERE d.director_name = 'Peter Jackson';

# 5. Show the Francis Ford Coppola film that has the maximum budget.
SELECT m.title, m.budget
FROM movies m
JOIN movie_directors md ON m.movie_id = md.movie_id
JOIN directors d ON md.director_id = d.director_id
WHERE d.director_name = 'Francis Ford Coppola'
  AND m.budget = (
      SELECT MAX(m2.budget)
      FROM movies m2
      JOIN movie_directors md2 ON m2.movie_id = md2.movie_id
      JOIN directors d2 ON md2.director_id = d2.director_id
      WHERE d2.director_name = 'Francis Ford Coppola'
  );

# 6. Show the film that has the most vote and has been produced in USA.
SELECT m.title, m.votes
FROM movies m
JOIN producer_countries pc ON m.movie_id = pc.movie_id
JOIN countries c ON pc.country_id = c.country_id
WHERE c.country_name = 'USA'
  AND m.votes = (
      SELECT MAX(m2.votes)
      FROM movies m2
      JOIN producer_countries pc2 ON m2.movie_id = pc2.movie_id
      JOIN countries c2 ON pc2.country_id = c2.country_id
      WHERE c2.country_name = 'USA'
  );

# 7. List all stars who have acted in more than 1 films.
SELECT s.star_name, COUNT(ms.movie_id) AS film_count
FROM stars s
JOIN movie_stars ms ON s.star_id = ms.star_id
GROUP BY s.star_id, s.star_name
HAVING COUNT(ms.movie_id) > 1;