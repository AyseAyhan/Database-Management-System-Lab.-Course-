use BikeStores

--1) Ürünlerin max ve min fiyatý
Select min(list_price) from production.products;
select max(list_price) from production.products


--2) products tablosundaki Ürünlerin toplam sayýsý, toplam fiyatý ve ortalama fiyat
SELECT COUNT(product_id) as totalCount, SUM(list_price) as totalPrice, AVG(list_price) as averagePrice from production.products

--3) Baldwin Bikes sipariþ alan 5 çalýþan
SELECT DISTINCT TOP(5) first_name, last_name from sales.staffs S
INNER JOIN sales.orders O on O.staff_id = S.staff_id 
INNER JOIN sales.stores St on St.store_id = O.store_id where ST.store_name = 'Baldwin Bikes' 

--4)Ad son harf-s ve soyad üçüncü harfi A olan müþteriler
SELECT first_name,last_name from sales.customers C where first_name like '%s' and last_name like '__a%'

--5)Model yýlý 2015 ve 2017 dahil olmak üzere bu yýllar arasýndaki ürünleri(products) sipariþ
--almýþ (order_items & orders) çalýþanlarý(customers) listeleyiniz. Ad ve soyad bilgilerini
--eþsiz olarak ekrana yazdýrýnýz
SELECT first_name, last_name from sales.staffs S
INNER JOIN sales.orders O on S.staff_id = O.staff_id
INNER JOIN sales.order_items OI on OI.order_id = O.order_id
INNER JOIN  production.products P on P.product_id = OI.product_id where P.model_year between 2015 and 2017

--6)'Rowlett Bikes' ve 'Baldwin Bikes' maðazalarýndan(stores) sipariþ(orders) alan 10 adet
--çalýþaný(staffs) listeleyiniz. Ad ve soyad bilgilerini ekrana listeleyiniz
SELECT DISTINCT TOP(10) first_name, last_name  from sales.staffs S
INNER JOIN sales.orders O on S.staff_id = O.staff_id 
INNER JOIN sales.stores St on St.store_id = O.store_id where store_name IN('Rowlett Bikes','Baldwin Bikes')
