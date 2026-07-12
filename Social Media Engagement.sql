-- Drop tables if they already exist
DROP TABLE IF EXISTS Engagement;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Users;

-- Users table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100),
    join_date DATE
);

-- Posts table
CREATE TABLE IF NOT EXISTS Posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    content VARCHAR(255),
    post_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Engagement table
CREATE TABLE IF NOT EXISTS Engagement (
    engagement_id INT PRIMARY KEY,
    post_id INT,
    likes INT,
    comments INT,
    shares INT,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- Insert sample data
INSERT INTO Users VALUES (1, 'kristina', '2026-01-01');
INSERT INTO Users VALUES (2, 'alex', '2026-02-15');

INSERT INTO Posts VALUES (101, 1, 'First post about SQL!', '2026-07-01');
INSERT INTO Posts VALUES (102, 2, 'Learning social media analytics', '2026-07-02');
INSERT INTO Posts VALUES (103, 1, 'Exploring engagement metrics', '2026-07-03');

-- Engagement data with higher shares
INSERT INTO Engagement VALUES (1001, 101, 120, 45, 130); -- >100 shares
INSERT INTO Engagement VALUES (1002, 102, 200, 60, 150); -- >100 shares
INSERT INTO Engagement VALUES (1003, 103, 90, 20, 80);   -- <100 shares

-- Queries

-- Retrieve likes, comments, shares for each post
SELECT p.post_id, u.username, e.likes, e.comments, e.shares
FROM Engagement e
JOIN Posts p ON e.post_id = p.post_id
JOIN Users u ON p.user_id = u.user_id;

-- Find most popular posts (by likes)
SELECT p.post_id, p.content, e.likes
FROM Engagement e
JOIN Posts p ON e.post_id = p.post_id
ORDER BY e.likes DESC;

-- Calculate total engagement per user
SELECT u.username, SUM(e.likes + e.comments + e.shares) AS total_engagement
FROM Engagement e
JOIN Posts p ON e.post_id = p.post_id
JOIN Users u ON p.user_id = u.user_id
GROUP BY u.username;

-- Filter posts with more than 100 shares
SELECT p.post_id, p.content, e.shares
FROM Engagement e
JOIN Posts p ON e.post_id = p.post_id
WHERE e.shares > 100;