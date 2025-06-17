-- 1
SELECT product.id, product.label, product.price, product.reference, SUM(product_order.quantity) AS sum
FROM product
JOIN product_order ON product_order.product_id = product.id
GROUP BY product.id
ORDER BY sum DESC
LIMIT 9;

-- 2
SELECT category.id, category.label, SUM(product_order.quantity) AS sum
FROM `category` 
JOIN product_categories ON product_categories.categories_id = category.id
JOIN product_order ON product_categories.products_id = product_order.product_id
GROUP BY category.label
ORDER BY sum DESC
LIMIT 4;

-- 3
SELECT product.id, product.label, product.price, product.reference
FROM `product`
JOIN product_order ON product_order.product_id = product.id
JOIN `order` ON product_order.order_id = `order`.id
ORDER BY `order`.created_at DESC
LIMIT 9;

-- 4
SELECT product.id, product.label, user.id, user.username, comment.rating, comment.created_at
FROM `comment`
JOIN product ON comment.product_id = product.id
JOIN user ON comment.user_id = user.id
ORDER BY comment.created_at DESC
LIMIT 4;

-- 5
SELECT user.id, user.username, user.first_name, user.last_name, address.*
FROM `user`
JOIN address ON address.user_id = user.id;

-- 6
SELECT user.id, user.username, user.first_name, user.last_name, address.*, COUNT(address.user_id) AS nb_address
FROM `address`
JOIN user ON address.user_id = user.id
GROUP BY address.user_id
HAVING COUNT(address.user_id) > 1
ORDER BY nb_address DESC;

-- 7
-- SELECT product.label
-- FROM category c1
-- JOIN category c2 ON c2.id = c1.parent_id
-- JOIN product_categories ON product_categories.categories_id = c1.id
-- JOIN product ON product_categories.products_id = product.id
-- WHERE c1.label LIKE "%Books%";

SELECT DISTINCT product_categories.products_id
FROM product_categories, category parent
LEFT JOIN category child ON child.parent_id = parent.id
WHERE parent.label = 'Books'
AND (
    product_categories.categories_id = parent.id
    OR
    product_categories.categories_id = child.id
);

-- OU

SELECT DISTINCT product_categories.products_id
FROM product_categories
JOIN category c ON c.id = categories_id

WHERE c.parent_id = (
    SELECT id
    FROM category c2
    WHERE c2.label = 'Books'
)
OR c.id = (
    SELECT id
    FROM category c2
    WHERE c2.label = 'Books'
);

-- 8
-- SELECT product.label, CONCAT("36", " / ", "116") AS "pagination"
-- FROM category c1
-- JOIN category c2 ON c2.id = c1.parent_id
-- JOIN product_categories ON product_categories.categories_id = c1.id
-- JOIN product ON product_categories.products_id = product.id
-- WHERE c1.label LIKE "%Books%"
-- LIMIT 36, 12;

SELECT  product.id,
        product.label,
        c.label,
                   (
                       SELECT COUNT(DISTINCT product_categories.products_id)
                       FROM product_categories, category parent
                       LEFT JOIN category child ON child.parent_id = parent.id
                       WHERE parent.label = 'Books'
                       AND (
                           product_categories.categories_id = parent.id
                           OR
                           product_categories.categories_id = child.id
                       ) 
                   ) AS "nbElements"

FROM product_categories

JOIN category c ON c.id = categories_id
JOIN product ON product_categories.products_id = product.id

WHERE c.parent_id = (
    SELECT id
    FROM category c2
    WHERE c2.label = 'Books'
)
OR c.id = (
    SELECT id
    FROM category c2
    WHERE c2.label = 'Books'
)

LIMIT 12  OFFSET 48;

-- 9
SELECT `order`.created_at, `order`.status, address.*, CONCAT(SUM(((product.price * product_order.quantity) - `order`.promotion) / 100), "€")
FROM `order`
JOIN address ON `order`.address_id = address.id
JOIN product_order ON product_order.order_id = `order`.id
JOIN product ON product_order.product_id = product.id
WHERE `order`.user_id = 5
GROUP BY `order`.id;

-- 10
-- Grocery - 15
-- Clothing & Sports - 46
-- Garden - 31
-- Baby, Games & Sports - 60
SELECT *
FROM `product`
JOIN product_categories ON product_categories.products_id = product.id
JOIN category ON product_categories.categories_id = category.id
WHERE product.id = 52;

SELECT *
FROM product
JOIN product_categories ON product_categories.products_id = product.id
WHERE product_categories.products_id IN (
    SELECT product_categories.categories_id
    FROM `product`
    WHERE product.id = 52
);