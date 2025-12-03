/* 

NIVEL 1- CONSULTAS BASICAS 

*/

-- 1) Listar todas las ciudades donde hay clientes, ordenadas alfabéticamente.
select distinct 
	customer_city
from customers 
order by customer_city;


-- 2) Mostrar los primeros 50 productos que aparecen en la tabla.
select 
	product_id 
from products 
limit 50;


-- 3) Contar cuántos vendedores hay en total.
select count(seller_id) as Cant_Vendedores
from sellers;

-- 4) Mostrar los distintos tipos de pago registrados en la tabla order_payments.
select distinct 
	payment_type as Tipos_Pagos
from order_payments 
order by payment_type desc;


-- 5) Listar los 20 productos con mayor cantidad de fotos (product_photos_qty).
select 
	product_id,
	product_photos_qty
from products 
order by product_photos_qty desc
limit 20;


/* 

NIVEL 2- FILTROS, AGREGACIONES Y JOINS 

*/

-- 6) Listar los pedidos realizados en el año 2018 (sin importar el mes).
select 
	order_id,
	order_purchase_timestamp 
from orders 
where year(order_purchase_timestamp) = 2018
order by order_purchase_timestamp desc;


-- 7) Obtener cuántos pedidos hay por cada estado del cliente (customer_state).
select 
	c.customer_state,
	count(o.order_id) as Cant_Pedidos
from customers c
join orders o 
	on c.customer_id = o.customer_id
group by c.customer_state
order by Cant_Pedidos desc;


-- 8) Mostrar las órdenes junto con la ciudad del cliente que las realizó.
select 
	o.order_id,
	c.customer_city
from orders o 
join customers c
	on o.customer_id = c.customer_id;


-- 9) Listar los ítems de pedido (order_items) junto con el nombre de la categoría del producto (products + product_category_name).
select 
	oi.order_id,
	oi.order_item_id,
	p.product_category_name
from order_items oi
join products p
	on oi.product_id = p.product_id
order by p.product_category_name desc;

-- 10) Calcular el total facturado (suma de payment_value) por cada tipo de pago (payment_type).
select
	payment_type,
	sum(payment_value) as total_facturado
from order_payments 
group by payment_type
order by total_facturado desc;


/* 

NIVEL 3- SUBCONSULTAS Y ANALISIS MAS AVANZADOS 

*/

-- 11) Listar los vendedores que vendieron al menos 10 productos (order_items).
select
	s.seller_id,
	count(oi.order_item_id) as cant_ventas
from sellers s
join order_items oi
	on s.seller_id = oi.seller_id
group by s.seller_id
having count(oi.order_item_id) >= 10
order by cant_ventas desc;


-- 12) Mostrar los productos cuyo peso está por encima del peso promedio general de todos los productos.
select 
	product_id,
	product_weight_g as peso
from products 
where product_weight_g > (
	select
		avg(product_weight_g) 
	from products)
order by peso desc;


-- 13) Listar los clientes que hicieron al menos una orden.
select 
	c.customer_id
from customers c
where exists (
	select 1 
	from orders o 
	where o.customer_id = c.customer_id);

-- 14) Listar los productos cuyo peso es mayor al peso promedio de SU MISMA categoría
select 
	pcn.product_category_name,
	pcn.product_category_name_english,
	p.product_weight_g
from  product_category_name pcn 
join products p
	on pcn.product_category_name = p.product_category_name
where p.product_weight_g > (
	select 
		x.promedio_categoria
	from (
		select 
			pcn2.product_category_name,
			avg(p2.product_weight_g) as promedio_categoria
		from product_category_name pcn2
		join products p2
			on pcn2.product_category_name = p2.product_category_name
		group by pcn2.product_category_name
		)x
	where x.product_category_name = p.product_category_name
)
order by pcn.product_category_name desc;


-- 15) Listar los clientes cuyo ticket promedio (total gastado / cantidad de pedidos) es mayor al ticket promedio general de todos los clientes.
select
	t.customer_id,
	t.ticket_promedio
from (
	select 
		c.customer_id,
		sum(oi.price) as gasto_total,
		count(distinct(oi.order_id)) as cant_ordenes,
		sum(oi.price) / count(distinct(oi.order_id))  as ticket_promedio
	from customers c
	join orders o
		on c.customer_id = o.customer_id
	join order_items oi 
		on o.order_id = oi.order_id
	group by customer_id
	)t
where t.ticket_promedio > (
	select 
		avg(t2.ticket_promedio)
	from (
		select 
			c.customer_id,
			sum(oi.price) as gasto_total,
			count(distinct(o.order_id)) as cant_ordenes, 
			sum(oi.price) / count(distinct(o.order_id)) as ticket_promedio
		from customers c
		join orders o
			on c.customer_id = o.customer_id 
		join order_items oi 
			on o.order_id = oi.order_id
		group by c.customer_id
		)t2
);




