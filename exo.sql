-- 1
SELECT *
FROM `user` 
LEFT JOIN address
ON address.user_uuid = user.uuid;

-- 2
SELECT title, 
    CONCAT(ROUND(price/100, 2), "€"), 
    CONCAT(mileage, "km") 
FROM `listing` 
ORDER BY created_at DESC 
LIMIT 20;

-- 3
SELECT COUNT(brand.name), brand.name 
FROM `listing` 
JOIN model ON listing.model_id = model.id 
JOIN brand ON model.brand_id = brand.id 
GROUP BY brand.name;

-- 4/
SELECT description, mileage, price, title 
FROM `listing` 
JOIN model ON listing.model_id = model.id 
JOIN brand ON model.brand_id = brand.id 
WHERE mileage >= 50000 
    AND brand.name = "Renault";

-- 5
SELECT description, mileage, CONCAT(price/100, "€"), title 
FROM `listing` 
JOIN model ON listing.model_id = model.id 
JOIN brand ON model.brand_id = brand.id 
WHERE mileage >= 30000 
    AND brand.name = "Ford" 
    AND listing.price/100 <= 12000;

-- 6
-- SELECT user.email, listing.created_at
-- FROM `listing` 
-- JOIN user ON listing.owner_uuid = user.uuid 
-- WHERE listing.created_at >= '2024-12-12 15:43:53';

-- SELECT user.email, listing.created_at, DATEDIFF(NOW(), listing.created_at) 
-- FROM `listing` 
-- JOIN user ON listing.owner_uuid = user.uuid 
-- WHERE DATEDIFF(NOW(), listing.created_at) <= 180;

SELECT user.email, listing.created_at 
FROM `listing` 
JOIN user ON listing.owner_uuid = user.uuid 
WHERE listing.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH);

-- 7
SELECT COUNT(*), created_at AS "annees" 
FROM `listing` 
GROUP BY YEAR(created_at);

-- 8
SELECT model.name, COUNT(model.name) 
FROM `listing` 
JOIN model ON listing.model_id = model.id 
GROUP BY model.name 
ORDER BY COUNT(model.name) DESC 
LIMIT 5;

-- 9
SELECT * 
FROM `listing` 
JOIN fuel ON listing.fuel_id = fuel.id 
WHERE fuel.type = "Electric";

-- 10
-- pas correct
SELECT DISTINCT model.name 
FROM `model` 
JOIN listing ON listing.model_id = model.id 
JOIN fuel ON listing.fuel_id = fuel.id 
WHERE fuel.id != 5;

-- 11
SELECT * 
FROM `listing` 
LIMIT 40, 20;

-- 12
SELECT COUNT(*), city 
FROM `address` 
GROUP BY city 
ORDER BY city DESC;

-- 13
SELECT street_name, COUNT(street_name) 
FROM `address` 
GROUP BY street_name 
HAVING COUNT(street_name) > 1 
ORDER BY street_name DESC;

-- 14
SELECT user.first_name, user.uuid 
FROM `user` 
LEFT JOIN address ON address.user_uuid = user.uuid 
WHERE address.user_uuid IS NULL;

-- 15
SELECT * 
FROM `listing`
JOIN image ON image.listing_uuid = listing.uuid
WHERE image.path IS NULL;

-- 16
SELECT COUNT(image.listing_uuid), listing.title 
FROM `listing`
JOIN image ON image.listing_uuid = listing.uuid
GROUP BY image.listing_uuid
HAVING COUNT(image.listing_uuid) > 1;

-- 17
SELECT SUM(listing.price / 100) AS "price", brand.name
FROM `brand`
JOIN model ON model.brand_id = brand.id
JOIN listing ON listing.model_id = model.id
GROUP BY brand.name
ORDER BY listing.price DESC;

-- 18
SELECT COUNT(MONTH(created_at)) AS 'Annonces par mois', MONTH(created_at) AS 'mois'
FROM `listing`
WHERE YEAR(created_at) = 2025
GROUP BY MONTH(listing.created_at)
ORDER BY created_at DESC;