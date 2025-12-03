/*

Correction of Table Inconsistencies

*/

-- 1) Create products_raw table without FK

CREATE TABLE products_raw (
    product_id varchar(50),
    product_category_name varchar(50),
    product_name_lenght int,
    product_description_lenght int,
    product_photos_qty int, 
    product_weight_g decimal (10,2),
    product_length_cm decimal (10,2), 
    product_height_cm decimal (10,2), 
    product_width_cm decimal (10,2)
);


-- 2) Load CSV of products into products_raw


-- 3) INSERT INTO product_category_name (product_category_name)

SELECT DISTINCT product_category_name
FROM products_raw
WHERE product_category_name IS NOT NULL
 AND product_category_name NOT IN (
      SELECT product_category_name FROM product_category_name
  );


-- 4) Move data from products_raw to products

INSERT INTO products (
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM products_raw;
