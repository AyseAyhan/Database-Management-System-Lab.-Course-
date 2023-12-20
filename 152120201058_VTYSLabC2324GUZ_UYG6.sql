-- 1) Her bir yöneticinin (manager) kimliði (staff_id), adý (first_name), soyadý (last_name) ve yönettiði çalýþanlarýn (staff) sayýsýný içeren sorgu-4 adet çýktý
SELECT s.manager_id, m.first_name, m.last_name, COUNT(*) as staff_member_count
FROM sales.staffs s
JOIN sales.staffs m ON s.manager_id = m.staff_id
GROUP BY s.manager_id, m.first_name, m.last_name;




--NOT: Tüm maðazalara bak, store ile stok eþleþtirilmeli, foreign key-primary key eþitle
--0 çýktý
-- 2) Belirli bir maðazada (stores) stokta (stocks) bulunan ve stok miktarý (quantity) tam olarak 26 olan tüm ürünlerin (products) isimlerini (product_name) listeleyiniz (ALL kullanarak yapýnýz)
SELECT p.product_name
FROM production.products p
WHERE p.product_id = ALL (
    SELECT s.product_id
    FROM production.stocks s
    WHERE s.store_id = 1 AND s.quantity = 26
);


--2

SELECT DISTINCT p.product_name
FROM production.products p
JOIN production.stocks s ON p.product_id = s.product_id
WHERE s.quantity = 26
AND s.store_id = ALL (SELECT store_id FROM sales.stores);




--92 adet çýktý
-- 3) Belirli bir maðazada (stores) stokta (stocks) bulunan miktarý (quantity) 26’dan fazla olan ürünlerin (products) isimlerini (product_name) listeleyiniz (ANY kullanarak yapýnýz)
SELECT p.product_name
FROM production.products p
WHERE 26 < ANY (
        SELECT  s.quantity FROM production.stocks s
        WHERE s.product_id = p.product_id);


		--3)Belirli bir maðazada (stores) stokta (stocks) bulunan miktarý quantity) 26’dan fazla olan
--ürünlerin (products) isimlerini (product_name) listeleyiniz 15p). ANY kullanarak yapýnýz!

SELECT production.products.product_name
FROM production.products
WHERE EXISTS ( 
	SELECT 1
    FROM production.stocks
    WHERE stocks.product_id = products.product_id
    AND stocks.quantity > 26
    AND stocks.store_id = ANY (SELECT store_id FROM sales.stores)
);



--3 adet çýktý
-- 4) Stokta (Stocks) miktarý (quantity) tam olarak 30 olan ve ayný zamanda ürün (products) fiyatý (list_price) 3000’den düþük olan en az bir ürünün (products) bulunduðu maðazalarýn (stores) isimlerini (store_name) listeleyiniz (EXISTS kullanarak yapýnýz)
SELECT DISTINCT st.store_name
FROM sales.stores st
WHERE EXISTS (
    SELECT 1
    FROM production.stocks s
    JOIN production.products p ON s.product_id = p.product_id
    WHERE s.store_id = st.store_id AND s.quantity = 30 AND p.list_price < 3000
);



--92 adet çýktý
-- 5) “Baldwin Bikes” adlý maðazadan (stores) alýþveriþ (orders) yapan her bir þehirdeki (city) müþteri (customers) sayýsýný hesaplayýnýz. Müþteri (customers) sayýsý 10’dan az olan þehirleri (city) seçiniz ve bu þehirleri (city) müþteri (customers) sayýsýna göre artan sýrayla listeleyiniz (HAVING kullanarak yapýnýz)
SELECT c.city, COUNT(c.customer_id) as customer_count
FROM sales.customers c
JOIN sales.orders o ON c.customer_id = o.customer_id
JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Baldwin Bikes'
GROUP BY c.city
HAVING COUNT(c.customer_id) < 10
ORDER BY customer_count;





--1160 satýr
-- 6) “Santa Cruz Bikes” adlý maðazadan (stores) sipariþ (orders) vermeyen müþterilerin (customers) isimlerini (first_name) ve soyisimlerini (last_name) listeleyiniz (EXCEPT kullanarak yapýnýz)
SELECT first_name, last_name
FROM sales.customers
EXCEPT
SELECT c.first_name, c.last_name
FROM sales.customers c
JOIN sales.orders o ON c.customer_id = o.customer_id
JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Santa Cruz Bikes';








--2 ve 3
--2

SELECT DISTINCT p.product_name
FROM production.products p
JOIN production.stocks s ON p.product_id = s.product_id
WHERE s.quantity = 26
AND s.store_id = ALL (SELECT store_id FROM sales.stores);





