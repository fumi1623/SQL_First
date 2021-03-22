/*---1
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('post-1', 12),
  ('post-2', 8),
  ('post-3', 11),
  ('post-4', 3),
  ('post-5', NULL),
  ('post-6', 9),
  ('post-7', 4),
  ('post-8', NULL),
  ('post-9', 31);

-- SELECT COUNT(likes) FROM posts;
-- SELECT COUNT(id) FROM posts;
-- SELECT COUNT(*) FROM posts;

SELECT SUM(likes) FROM posts;
SELECT AVG(likes) FROM posts;
SELECT MAX(likes) FROM posts;
SELECT MIN(likes) FROM posts;
*/

/*---2
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  area VARCHAR(140),
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes, area) VALUES 
  ('post-1', 12, 'Tokyo'),
  ('post-2', 8, 'Fukuoka'),
  ('post-3', 11, 'Tokyo'),
  ('post-4', 3, 'Osaka'),
  ('post-5', NULL, 'Tokyo'),
  ('post-6', 9, 'Osaka'),
  ('post-7', 4, 'Tokyo'),
  ('post-8', NULL, 'Osaka'),
  ('post-9', 31, 'Fukuoka');
  
-- SELECT * FROM posts;
-- SELECT DISTINCT area FROM posts;
SELECT area, SUM(likes) FROM posts GROUP BY area;
*/

/*---3
-- SELECT area, SUM(likes) FROM posts GROUP BY area;
-- SELECT
--   area,
--   SUM(likes)
-- FROM
--   posts
-- GROUP BY
--   area
-- -- WHERE
-- HAVING
--   SUM(likes) > 30;

SELECT
  area,
  SUM(likes)
FROM
  posts
WHERE
  likes > 10
GROUP BY
  area;
*/

/*---4
SELECT
  *,
  CASE
    WHEN likes > 10 THEN 'A'
    WHEN likes > 5 THEN 'B'
    ELSE 'C'
  END AS team
FROM
  posts;
*/

/*---5
DROP TABLE IF EXISTS posts_tokyo;
CREATE TABLE posts_tokyo AS SELECT * FROM posts WHERE area = 'Tokyo';

DROP TABLE IF EXISTS posts_copy;
CREATE TABLE posts_copy AS SELECT * FROM posts;

DROP TABLE IF EXISTS posts_skeleton;
CREATE TABLE posts_skeleton LIKE posts;

SHOW TABLES;
SELECT * FROM posts_tokyo;
SELECT * FROM posts_copy;
SELECT * FROM posts_skeleton;
*/

/*---6
-- DROP TABLE IF EXISTS posts_tokyo;
-- CREATE TABLE posts_tokyo AS SELECT * FROM posts WHERE area = 'Tokyo';
DROP TABLE IF EXISTS posts_tokyo_view;
CREATE VIEW posts_tokyo_view AS SELECT * FROM posts WHERE area = 'Tokyo';

UPDATE posts SET likes = 15 WHERE id = 1;

SELECT * FROM posts;
-- SELECT * FROM posts_tokyo;
SELECT * FROM posts_tokyo_view;
*/

/*---7
(SELECT * FROM posts ORDER BY likes DESC LIMIT 3)
UNION ALL
(SELECT * FROM posts ORDER BY likes LIMIT 1);
*/

/*--8
-- SELECT *, AVG(likes) AS avg FROM posts;
SELECT
  *,
  (SELECT AVG(likes)FROM posts) AS avg
FROM
  posts;
*/

/*---9
SELECT
  *,
  (SELECT AVG(likes) FROM posts) AS avg,
  (SELECT AVG(likes) FROM posts AS t2 WHERE t1.area = t2.area) AS area_avg
FROM
  posts AS t1;
*/

/*---10
SELECT
  *
FROM
  posts
WHERE
  likes = (SELECT MAX(likes) FROM posts);
*/

/*---11
SELECT area, COUNT(*) AS n FROM posts GROUP BY area;

SELECT
  AVG(n)
FROM
  (SELECT area, COUNT(*) AS n FROM posts GROUP BY area) AS t;
*/

/*---13
SELECT
  *,
  AVG(likes) OVER () AS avg,
  -- AVG(likes) OVER (PARTITION BY area) AS area_avg,
  -- SUM(likes) OVER (PARTITION BY area) AS area_sum
  AVG(likes) OVER w AS area_avg,
  SUM(likes) OVER w AS area_sum
FROM
  posts
WINDOW
  w AS (PARTITION BY area);
*/

/*---14
SELECT
  *,
  SUM(likes) OVER (
    PARTITION BY area
    ORDER BY likes
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
  ) AS area_sum
FROM
  posts;
*/

/*---15
SELECT
  *,
  ROW_NUMBER() OVER (ORDER BY likes) as num,
  RANK() OVER (ORDER BY likes) as rank,
  DENSE_RANK() OVER (ORDER BY likes) as dense
FROM
  posts;
*/

/*---16
SELECT
  *,
  -- LAG(likes, 1) OVER (ORDER BY likes) as lag,
  -- LEAD(likes, 1) OVER (ORDER BY likes) as lead
  -- LAG(likes) OVER (ORDER BY likes) as lag,
  -- LEAD(likes) OVER (ORDER BY likes) as lead
  likes - LAG(likes) OVER (ORDER BY likes) as diff
FROM
  posts;
*/

/*---18
START TRANSACTION;
UPDATE posts SET likes = likes - 1 WHERE id = 1;
-- UPDATE posts SET likes = likes + 1 WHERE id = 2;
-- COMMIT;
ROLLBACK;

SELECT * FROM posts;
*/

/*---20
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140), 
  PRIMARY KEY (id)
);

INSERT INTO posts (message) VALUES 
  ('post-1'),
  ('post-2'),
  ('post-3');

INSERT INTO comments (post_id, comment) VALUES 
  (1, 'comment-1-1'),
  (1, 'comment-1-2'),
  (3, 'comment-3-1'),
  (4, 'comment-4-1');

SELECT * FROM posts;
SELECT * FROM comments;
*/

/*---22
SELECT
  -- *
  -- posts.id, posts.message, comments.comment
  posts.id, message, comment
FROM
  -- posts INNER JOIN comments ON posts.id = comments.post_id;
  posts JOIN comments ON posts.id = comments.post_id;
*/

/*---23
SELECT
  *
FROM
  posts JOIN comments ON posts.id = comments.post_id;

SELECT
  *
FROM
  -- posts LEFT OUTER JOIN comments ON posts.id = comments.post_id;
  posts LEFT JOIN comments ON posts.id = comments.post_id;

SELECT
  *
FROM
  posts RIGHT JOIN comments ON posts.id = comments.post_id;
*/

/*---24
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  PRIMARY KEY (id)
);

CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140), 
  PRIMARY KEY (id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

INSERT INTO posts (message) VALUES 
  ('post-1'),
  ('post-2'),
  ('post-3');

INSERT INTO comments (post_id, comment) VALUES 
  (1, 'comment-1-1'),
  (1, 'comment-1-2'),
  (3, 'comment-3-1');
  -- (4, 'comment-4-1');

SELECT * FROM posts;
SELECT * FROM comments;
*/

/*---25
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  PRIMARY KEY (id)
);

CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140), 
  PRIMARY KEY (id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO posts (message) VALUES 
  ('post-1'),
  ('post-2'),
  ('post-3');

INSERT INTO comments (post_id, comment) VALUES 
  (1, 'comment-1-1'),
  (1, 'comment-1-2'),
  (3, 'comment-3-1');

DELETE FROM posts WHERE id = 3;
UPDATE posts SET id = 100 WHERE id = 1;

SELECT * FROM posts;
SELECT * FROM comments;
*/

/*---26
INSERT INTO posts (message) VALUES
  ('new post!');

INSERT INTO comments (post_id, comment) VALUES 
  (LAST_INSERT_ID(), 'new comment');

*/

/*---27
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  PRIMARY KEY (id)
);

CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140),
  parent_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO posts (message) VALUES 
  ('post-1'),
  ('post-2'),
  ('post-3');

INSERT INTO comments (post_id, comment, parent_id) VALUES 
  (1, 'comment-1-1', NULL),
  (1, 'comment-1-2', NULL),
  (3, 'comment-3-1', NULL),
  (1, 'comment-1-2-1', 2),
  (1, 'comment-1-2-1', 2),
  (1, 'comment-1-2-1-1', 4);

SELECT * FROM posts;
SELECT * FROM comments;
*/

/*---28
SELECT * FROM comments WHERE parent_id = 2
UNION ALL
SELECT
  comments.*
FROM
  comments JOIN (
    SELECT * FROM comments WHERE parent_id = 2
  ) AS t
ON
  comments.parent_id = t.id;
*/

/*---29
WITH t AS (
  SELECT * FROM comments WHERE parent_id = 2
)
SELECT
  comments.*
FROM
  comments JOIN t
ON
  comments.parent_id = t.id;
*/

/*---30
WITH RECURSIVE t AS (
  SELECT * FROM comments WHERE parent_id = 2
  UNION ALL
  SELECT
    comments.*
  FROM
    comments JOIN t
  ON
    comments.parent_id = t.id
)
SELECT * FROM t;
*/

/*---32
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS logs;
DROP TRIGGER IF EXISTS posts_update_trigger;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  PRIMARY KEY (id)
);

CREATE TABLE logs (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  created DATETIME DEFAULT NOW(),
  PRIMARY KEY (id)
);
*/

/*---33
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS logs;
DROP TRIGGER IF EXISTS posts_update_trigger;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  PRIMARY KEY (id)
);

CREATE TABLE logs (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  created DATETIME DEFAULT NOW(),
  PRIMARY KEY (id)
);

CREATE TRIGGER
  posts_update_trigger
AFTER UPDATE ON
  posts
FOR EACH ROW
  INSERT INTO
    logs (message)
  VALUES
    -- ('Updated');
    (CONCAT(OLD.message, ' ->', NEW.message));

INSERT INTO posts (message) VALUES
  ('post-1'),
  ('post-2'),
  ('post-3');
UPDATE posts SET message = 'post-1 updated' WHERE id = 1;

SELECT * FROM posts;
SELECT * FROM logs;

-- SHOW TRIGGERS;
SHOW TRIGGERS\G
*/

/*---34
DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  area VARCHAR(20),
  PRIMARY KEY (id)
);

LOAD DATA LOCAL INFILE 'data.csv' INTO TABLE posts
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (message, likes, area);

SELECT * FROM posts;
*/

/*---36
SHOW INDEX FROM posts\G
EXPLAIN SELECT * FROM posts WHERE id = 30\G
*/

/*---37
-- SHOW INDEX FROM posts\G
-- EXPLAIN SELECT * FROM posts WHERE id = 30\G

ALTER TABLE posts ADD INDEX index_area(area);
SHOW INDEX FROM posts\G
EXPLAIN SELECT * FROM posts WHERE area = 'Kyoto'\G
ALTER TABLE posts DROP INDEX index_area;
SHOW INDEX FROM posts\G
*/

