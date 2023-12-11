use BikeStores;

--1
--Ürünler tablosundan model yýlý 2016 olan tüm ürünlerin adýný, marka kimliðini ve liste fiyatýný listeledim
Select product_name,brand_id,list_price from  Production.products
where model_year=2016

--2
--Ürünler tablosundaki kategorisi 6 olan tüm benzersiz marka numaralarýný listeledim-select dintinct ile unique veriler gösterilir
Select Distinct brand_id from production.products
where category_id=6;

--3
--Þipariþler tablosunda, sipariþ durumu 'Tamamlanmýþ' (4) olan veya 'Reddedilmiþ' (3) olan 
--sipariþlerin sipariþ numarasýný, müþteri kimliðini ve sipariþ durumunu listeledim
SELECT order_id, customer_id, order_status
FROM sales.orders
WHERE order_status IN (3, 4);

--4
----Maðazalar tablosuna yeni bir maðaza ekledim. Maðaza adý 'New Store', e-posta adresi 
--'newstore@email.com' ancak telefon numarasý ve adres bilgileri olmadan-null
INSERT INTO sales.stores (store_name, email)
VALUES ('New Store', 'newstore@email.com');
--sonda silinen maðazanýn gösterilmesinde tablo boþ olur, o sebeple buraya gösterge ekledim
Select*from  sales.stores
where store_name='New Store' and email='newstore@email.com'

--5
--a) Ürünler tablosunda, ürün adý 'NewProductName' olan ve model yýlý 2016 olan ürünün liste 
--fiyatýný '3500' olarak güncelledim
UPDATE production.products
SET list_price = 3500
WHERE product_name = 'NewProductName' AND model_year = 2016;

--b) Maðazalar tablosuna yeni eklenen maðazayý sildim
DELETE FROM sales.stores
WHERE store_name = 'New Store' AND email = 'newstore@email.com';

--b)Maðaza adý 'New Store', e-posta adresi 
--'newstore@email.com', sonra ürün listesini SELECT sorgusu ile çekiniz
SELECT * FROM sales.stores
WHERE store_name = 'New Store' AND email = 'newstore@email.com';


--SELECT TOP 5 Ad, Soyad FROM sales.Customers order by yas desc;  5* olursa her þeyi getirir
--SELECT MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice FROM Products;
--SELECT COUNT(*) AS NumOfOrders FROM Orders WHERE CustomerID = 1;
--SELECT SUM(Quantity) AS TotalQuantity FROM OrderDetails;
--SELECT AVG(Price) AS AveragePrice FROM Products;
--SELECT * FROM Products WHERE ProductName LIKE 'App%';
--SELECT first_name from sales.customers C where first_name like 'a%' and last_name like '%a'
--SELECT * FROM Customers WHERE Country IN ('USA', 'Canada', 'Mexico');
--SELECT * FROM Products WHERE Price BETWEEN 10 AND 50;
--SELECT ProductName AS Product, Price * 1.1 AS NewPrice FROM Products;

--SELECT p.product_name, s.quantity
--FROM production.stocks s
--JOIN production.products p ON s.product_id = p.product_id;

--
--SELECT DISTINCT first_name, last_name from sales.customers C 
--INNER JOIN sales.orders O on C.customer_id = O.customer_id
--INNER JOIN sales.order_items OI on OI.order_id = O.order_id
--INNER JOIN  production.products P on P.product_id = OI.product_id where P.model_year between 2010 and 2015


--SELECT DISTINCT TOP(10) first_name, last_name, St.store_name from sales.customers C 
--INNER JOIN sales.orders O on C.customer_id = O.customer_id 
--INNER JOIN sales.stores St on St.store_id = O.store_id where store_name IN('LA','')

----

--SELECT COUNT(*) AS CategoryCount FROM production.categories;
--SELECT COUNT(*) AS BrandCount FROM production.brands;
--SELECT SUM(list_price) AS TotalListPrice FROM production.products;
--SELECT AVG(list_price) AS AvgListPrice FROM production.products;
--SELECT COUNT(*) AS StoreCount FROM sales.stores;
--SELECT COUNT(*) AS StaffCount FROM sales.staffs;
--SELECT order_status, COUNT(*) AS OrderCount FROM sales.orders GROUP BY order_status;
--SELECT COUNT(*) AS OrderCount FROM sales.orders WHERE order_date = '2023-11-14';
--SELECT customer_id, COUNT(*) AS TotalOrders FROM sales.orders WHERE customer_id = 1 GROUP BY customer_id;

--SELECT p.product_name, s.quantity
--FROM production.stocks s
--JOIN production.products p ON s.product_id = p.product_id;
