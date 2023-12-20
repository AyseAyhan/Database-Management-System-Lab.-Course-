-- 1) Her bir y�neticinin (manager) kimli�i (staff_id), ad� (first_name), soyad� (last_name) ve y�netti�i �al��anlar�n (staff) say�s�n� i�eren sorgu-4 adet ��kt�
SELECT s.manager_id, m.first_name, m.last_name, COUNT(*) as staff_member_count
FROM sales.staffs s
JOIN sales.staffs m ON s.manager_id = m.staff_id
GROUP BY s.manager_id, m.first_name, m.last_name;




--NOT: T�m ma�azalara bak, store ile stok e�le�tirilmeli, foreign key-primary key e�itle
--0 ��kt�
-- 2) Belirli bir ma�azada (stores) stokta (stocks) bulunan ve stok miktar� (quantity) tam olarak 26 olan t�m �r�nlerin (products) isimlerini (product_name) listeleyiniz (ALL kullanarak yap�n�z)
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
AND s.store_id = ALL (SELECT store_id FROM�sales.stores);




--92 adet ��kt�
-- 3) Belirli bir ma�azada (stores) stokta (stocks) bulunan miktar� (quantity) 26�dan fazla olan �r�nlerin (products) isimlerini (product_name) listeleyiniz (ANY kullanarak yap�n�z)
SELECT p.product_name
FROM production.products p
WHERE 26 < ANY (
        SELECT  s.quantity FROM production.stocks s
        WHERE s.product_id = p.product_id);


		--3)Belirli bir ma�azada (stores) stokta (stocks) bulunan miktar� quantity) 26�dan fazla olan
--�r�nlerin (products) isimlerini (product_name) listeleyiniz 15p). ANY kullanarak yap�n�z!

SELECT production.products.product_name
FROM production.products
WHERE EXISTS ( 
	SELECT 1
    FROM production.stocks
    WHERE stocks.product_id = products.product_id
    AND stocks.quantity > 26
    AND stocks.store_id = ANY (SELECT store_id FROM sales.stores)
);



--3 adet ��kt�
-- 4) Stokta (Stocks) miktar� (quantity) tam olarak 30 olan ve ayn� zamanda �r�n (products) fiyat� (list_price) 3000�den d���k olan en az bir �r�n�n (products) bulundu�u ma�azalar�n (stores) isimlerini (store_name) listeleyiniz (EXISTS kullanarak yap�n�z)
SELECT DISTINCT st.store_name
FROM sales.stores st
WHERE EXISTS (
    SELECT 1
    FROM production.stocks s
    JOIN production.products p ON s.product_id = p.product_id
    WHERE s.store_id = st.store_id AND s.quantity = 30 AND p.list_price < 3000
);



--92 adet ��kt�
-- 5) �Baldwin Bikes� adl� ma�azadan (stores) al��veri� (orders) yapan her bir �ehirdeki (city) m��teri (customers) say�s�n� hesaplay�n�z. M��teri (customers) say�s� 10�dan az olan �ehirleri (city) se�iniz ve bu �ehirleri (city) m��teri (customers) say�s�na g�re artan s�rayla listeleyiniz (HAVING kullanarak yap�n�z)
SELECT c.city, COUNT(c.customer_id) as customer_count
FROM sales.customers c
JOIN sales.orders o ON c.customer_id = o.customer_id
JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Baldwin Bikes'
GROUP BY c.city
HAVING COUNT(c.customer_id) < 10
ORDER BY customer_count;





--1160 sat�r
-- 6) �Santa Cruz Bikes� adl� ma�azadan (stores) sipari� (orders) vermeyen m��terilerin (customers) isimlerini (first_name) ve soyisimlerini (last_name) listeleyiniz (EXCEPT kullanarak yap�n�z)
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
AND s.store_id = ALL (SELECT store_id FROM�sales.stores);





