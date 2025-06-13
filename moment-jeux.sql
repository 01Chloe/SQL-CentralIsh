-- 1
SELECT * 
FROM `game` 
ORDER BY game.published_at DESC 
LIMIT 9;

-- 2
SELECT COUNT(*), game.name 
FROM `game` 
JOIN user_own_game ON user_own_game.game_id = game.id 
GROUP BY user_own_game.game_id 
ORDER BY COUNT(*) DESC 
LIMIT 9;

-- 3
SELECT game.name
FROM `user_own_game`
JOIN game ON game.id = user_own_game.game_id
GROUP BY game.name
ORDER BY user_own_game.game_time DESC
LIMIT 9;

-- 4
SELECT user.nickname, game.name,review.rating, review.up_vote, review.down_vote
FROM `review`
JOIN user ON user.id = review.user_id
JOIN game ON game.id = review.game_id
ORDER BY review.created_at DESC
LIMIT 4;

-- 5
SELECT DISTINCT category.name
FROM `game_category`
JOIN user_own_game ON user_own_game.game_id = game_category.game_id
JOIN category ON game_category.category_id = category.id
ORDER BY user_own_game.game_time DESC 
LIMIT 9;

-- 6
SELECT user.nickname, SUM(user_own_game.game_time) AS 'temps de jeux total'
FROM user
JOIN user_own_game ON user_own_game.user_id = user.id
GROUP BY user.nickname;

-- 7
SELECT * 
FROM `game`
JOIN game_category ON game_category.game_id = game.id
JOIN category ON category.id = game_category.category_id
WHERE game.price < 30 
    AND category.name = "fps";
    