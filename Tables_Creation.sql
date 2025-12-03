/*

Tables creation 

*/

USE `olist_project`;

CREATE TABLE IF NOT EXISTS sellers(
	seller_id VARCHAR	(50) PRIMARY KEY, 
	seller_city VARCHAR (50), 
	seller_state VARCHAR (20) ); 

CREATE TABLE IF NOT EXISTS customers (
	customer_id VARCHAR(50) PRIMARY KEY,
	customer_unique_id VARCHAR (50), 
	customer_city VARCHAR (50), 
	customer_state VARCHAR(20) ); 

CREATE TABLE IF NOT EXISTS product_category_name (
	product_category_name VARCHAR (50) PRIMARY KEY, 
	product_category_name_english VARCHAR (50) ); 

CREATE TABLE IF NOT EXISTS orders( 
	order_id VARCHAR (50) PRIMARY KEY, 
	customer_id VARCHAR(50), 
	order_status VARCHAR(20), 
	order_purchase_timestamp TIMESTAMP, 
	order_approved_at TIMESTAMP, 
	order_delivered_carrier_date TIMESTAMP, 
	order_delivered_customer_date TIMESTAMP, 
	order_estimated_delivery_date TIMESTAMP, 
CONSTRAINT fk_orders_customers 
	FOREIGN KEY (customer_id) 
	REFERENCES customers(customer_id) ); 

create table if not exists products ( 
	product_id VARCHAR(50) PRIMARY KEY,
	product_category_name VARCHAR (50), 
	product_name_lenght INT, 
	product_description_lenght INT, 
	product_photos_qty INT, 
	product_weight_g DECIMAL (10,2), 
	product_length_cm DECIMAL (10,2), 
	product_height_cm DECIMAL (10,2), 
	product_width_cm DECIMAL (10,2), 
CONSTRAINT fk_products_product_category_name 
	FOREIGN KEY (product_category_name) 
	REFERENCES product_category_name(product_category_name) ); 

create table if not exists order_payments ( 
	order_id VARCHAR (50), 
	payment_sequential INT , 
	payment_type VARCHAR(25), 
	payment_installments INT, 
	payment_value DECIMAL (10,2),
PRIMARY KEY (order_id, payment_sequential), 
CONSTRAINT fk_order_payment_orders 
	FOREIGN KEY (order_id) 
	REFERENCES orders(order_id) ); 

create table if not exists order_items( 
	order_id VARCHAR(50), 
	order_item_id INT, 
	product_id VARCHAR (50), 
	seller_id VARCHAR(50), 
	shipping_limit_date TIMESTAMP, 
	price DECIMAL(10,2), 
	freight_value DECIMAL(10,2), 
PRIMARY KEY (order_id, order_item_id), 
CONSTRAINT fk_order_items_orders 
	FOREIGN KEY (order_id) 
	REFERENCES orders(order_id), 
CONSTRAINT fk_order_items_products 
	FOREIGN KEY (product_id) 
	REFERENCES products(product_id), 
CONSTRAINT fk_order_items_sellers 
	FOREIGN KEY (seller_id) 
	REFERENCES sellers(seller_id) );
