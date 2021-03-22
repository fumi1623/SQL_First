/*--1
CREATE TABLE posts (
  message VARCHAR(140),
  likes INT
);

DESC posts;

SHOW TABLES;
*/

/*--2
DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  message VARCHAR(140), 
  likes INT
);

DESC posts;
SHOW TABLES;

-- INSERT INTO posts (message, likes) VALUES ('Thanks', 12);
-- INSERT INTO posts (message, likes) VALUES ('Arigato', 4);
INSERT INTO posts (message, likes) VALUES
  ('Thanks', 12),
  ('Arigato', 4);
  
SELECT * FROM posts;
*/

/*--3
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140), 
  likes INT UNSIGNED,
  mood DECIMAL(4, 2) UNSIGNED,
  lang CHAR(2)
);

INSERT INTO posts (message, likes, mood, lang) VALUES
  ('Thanks', 12, 7.825, 'EN'), 
  ('Arigato', 4, 4.2138, 'JA');

SELECT * FROM posts;
*/

/*---4
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140), 
  likes INT,
  category ENUM('Gadget', 'Game', 'Business')
);

-- INSERT INTO posts (message, likes, category) VALUES 
--   ('Thanks', 12, 'Gadget'),
--   ('Arigato', 4, 'Game'),
--   ('Marci', 4, 'Business');
INSERT INTO posts (message, likes, category) VALUES 
  ('Thanks', 12, 1),
  ('Arigato', 4, 2),
  ('Marci', 4, 3);

SELECT * FROM posts;
*/

/*---5
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140), 
  likes INT,
  categories SET('Gadget', 'Game', 'Business') -- 2^0, 2^1, 2^2, ...
);

-- INSERT INTO posts (message, likes, categories) VALUES 
--   ('Thanks', 12, 'Gadget,Game'),
--   ('Arigato', 4, 'Business'),
--   ('Merci', 4, 'Business,Gadget');
INSERT INTO posts (message, likes, categories) VALUES 
  ('Thanks', 12, 3),
  ('Arigato', 4, 4),
  ('Merci', 4, 5);

SELECT * FROM posts;
*/

/*---6
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140), 
  likes INT,
  is_draft BOOL,
  created DATETIME
);

INSERT INTO posts (message, likes, is_draft, created) VALUES 
  ('Tnanks', 12, TRUE, '2020-10-11 15:32:05'),
  ('Arigato', 4, FALSE, '2020-10-12'),
  ('Merci', 4, 0, NOW());

SELECT * FROM posts;
*/

/*---7
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140), 
  -- likes INT
  -- likes INT NOT NULL
  likes INT DEFAULT 0
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Arigato', 4),
  ('Merci', 4);
  
INSERT INTO posts (message) VALUES ('Gracias');

SELECT * FROM posts;
*/

/*---8
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140) UNIQUE, 
  likes INT CHECK (likes >= 0 AND likes <= 200)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Arigato', 4),
  ('Merci', 154),
  ('Arigato', 4);

SELECT * FROM posts;
*/

/*---9
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

-- INSERT INTO posts (id, message, likes) VALUES 
--   (1, 'Thanks', 12),
--   (2, 'Arigato', 4),
--   (3, 'Merci', 4);
INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Arigato', 4),
  ('Merci', 4);

SELECT * FROM posts;

/*---10
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Arigato', 4),
  ('Merci', 4),
  ('Gracias', 15),
  ('Danke', 23); 

-- SELECT * FROM posts;
-- SELECT id, message FROM posts;
-- SELECT * FROM posts WHERE likes >= 10;
SELECT * FROM posts WHERE message = 'Danke';
SELECT * FROM posts WHERE message != 'Danke';
SELECT * FROM posts WHERE message <> 'Danke';
*/

/*---11
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Arigato', 4),
  ('Merci', 4),
  ('Gracias', 15),
  ('Danke', 23);

-- SELECT * FROM posts WHERE likes >= 10 AND likes <= 20;
-- SELECT * FROM posts WHERE likes BETWEEN 10 AND 20;
-- SELECT * FROM posts WHERE likes NOT BETWEEN 10 AND 20;
SELECT * FROM posts WHERE likes = 4 OR likes = 12;
SELECT * FROM posts WHERE likes IN (4, 12);
SELECT * FROM posts WHERE likes NOT IN (4, 12);
*/

/*---12
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thank you!', 12),
  ('thanks 100%', 4),
  ('Gracias', 4),
  ('Arigato_gozaimasu', 15),
  ('Arigato! desu', 23);
  
-- SELECT * FROM posts WHERE message = 'Gracias';
-- SELECT * FROM posts WHERE message LIKE 't%';
-- SELECT * FROM posts WHERE message LIKE BINARY 't%';
SELECT * FROM posts WHERE message LIKE '%su';
SELECT * FROM posts WHERE message LIKE '%i%';
*/

/*---13
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thank you!', 12),
  ('thanks 100%', 4),
  ('Gracias', 4),
  ('Arigato_gozaimasu', 15),
  ('Arigato! desu', 23);

-- %: 0文字以上の任意の文字
-- _: 任意の1文字
-- SELECT * FROM posts WHERE message LIKE '__a%';
-- SELECT * FROM posts WHERE message NOT LIKE '__a%';
SELECT * FROM posts WHERE message LIKE '%\%%'
*/

/*---14
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Arigato', 4),
  ('Merci', NULL),
  ('Gracias', 15),
  ('Danke', NULL);
  
-- SELECT * FROM posts;
-- SELECT * FROM posts WHERE likes != 12;
-- SELECT * FROM posts WHERE likes != 12 OR likes IS NULL;
SELECT * FROM posts WHERE likes != 12 OR likes IS NOT NULL;
*/

/*---15
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Merci', 4),
  ('Arigato', 4),
  ('Gracias', 15),
  ('Danke', 8);
  
-- SELECT * FROM posts ORDER BY likes;
-- SELECT * FROM posts ORDER BY likes DESC;
-- SELECT * FROM posts ORDER BY likes DESC, message;
-- SELECT * FROM posts ORDER BY likes DESC, message LIMIT 3;
SELECT * FROM posts ORDER BY likes DESC, message LIMIT 3 OFFSET 2;
SELECT * FROM posts ORDER BY likes DESC, message LIMIT 2, 3;
*/

/*---16
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Merci', 4),
  ('Arigato', 4),
  ('Gracias', 15),
  ('Danke', 8);

SELECT
  likes * 500 / 3 AS Bonus,
  FLOOR(likes * 500 / 3) AS floor,
  CEIL(likes * 500 / 3) AS ceil,
  -- ROUND(likes * 500 / 3) AS round
  ROUND(likes * 500 / 3, 2) AS round
FROM
*/

/*---17
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Merci', 4),
  -- ('Arigato', 4),
  ('ありがとう', 4),
  ('Gracias', 15),
  ('Danke', 8);

-- SELECT message, SUBSTRING(message, 3) FROM posts;
-- SELECT message, SUBSTRING(message, 3, 2) FROM posts;
-- SELECT message, SUBSTRING(message, -3) FROM posts;
-- SELECT CONCAT(message, ' - ', likes) FROM posts;
-- SELECT message, LENGTH(message) as len FROM posts;
SELECT message, CHAR_LENGTH(message) as len FROM posts;
*/

/*---18
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  created DATETIME,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes, created) VALUES 
  ('Thanks', 12, '2020-05-01'),
  ('Merci', 4, '2020-05-03'),
  ('Arigato', 4, '2020-06-14'),
  ('Gracias', 15, '2020-07-04'),
  ('Danke', 8, '2020-08-22');
  
-- SELECT created, YEAR(created) FROM posts;
-- SELECT created, MONTH(created) FROM posts;
-- SELECT created, DAY(created) FROM posts;
SELECT
  created,
  DATE_FORMAT(created, '%M %D %Y, %W') AS date
FROM
  posts;
  
SELECT
  created,
  DATE_ADD(created, INTERVAL 7 DAY) AS next
FROM
  posts;

SELECT
  created,
  NOW(),
  DATEDIFF(created, NOW()) AS diff
FROM
  posts;
*/

/*---19
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Merci', 4),
  ('Arigato', 4),
  ('Gracias', 15),
  ('Danke', 8);

-- SELECT likes + 10 FROM posts;
-- UPDATE posts SET likes = likes + 5 WHERE likes >= 10;
UPDATE
  posts
SET
  likes = likes + 5,
  message = UPPER(message)
WHERE
  likes >= 10;
*/

/*---20
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Merci', 4),
  ('Arigato', 4),
  ('Gracias', 15),
  ('Danke', 8); 

-- DELETE FROM posts WHERE likes < 10;
-- DELETE FROM posts;
TRUNCATE TABLE posts;
INSERT INTO posts (message, likes) VALUES ('Xie Xie', 10);
SELECT * FROM posts;
*/

/*---21
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  created DATETIME DEFAULT NOW(),
  updated DATETIME DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Merci', 4),
  ('Arigato', 4),
  ('Gracias', 15),
  ('Danke', 8);

SELECT id, created, updated FROM posts;
SELECT SLEEP(3);
UPDATE posts SET likes = 100 WHERE id = 1;
SELECT id, created, updated FROM posts;
*/

/*---22
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140), 
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES 
  ('Thanks', 12),
  ('Merci', 4),
  ('Arigato', 4),
  ('Gracias', 15),
  ('Danke', 8);

-- ALTER TABLE posts ADD author VARCHAR(255); 
-- ALTER TABLE posts ADD author VARCHAR(255) AFTER id; 
-- ALTER TABLE posts ADD author VARCHAR(255) FIRST; 
-- ALTER TABLE posts DROP message;
-- ALTER TABLE posts CHANGE likes points INT;
DROP TABLE IF EXISTS messages;
ALTER TABLE posts RENAME messages;
SHOW TABLES;
*/

