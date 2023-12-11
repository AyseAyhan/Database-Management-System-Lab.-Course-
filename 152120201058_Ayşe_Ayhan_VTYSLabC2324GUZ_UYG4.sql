use BikeStores

--1) �r�nlerin max ve min fiyat�
Select min(list_price) from production.products;
select max(list_price) from production.products


--2) products tablosundaki �r�nlerin toplam say�s�, toplam fiyat� ve ortalama fiyat
SELECT COUNT(product_id) as totalCount, SUM(list_price) as totalPrice, AVG(list_price) as averagePrice from production.products

--3) Baldwin Bikes sipari� alan 5 �al��an
SELECT DISTINCT TOP(5) first_name, last_name from sales.staffs S
INNER JOIN sales.orders O on O.staff_id = S.staff_id 
INNER JOIN sales.stores St on St.store_id = O.store_id where ST.store_name = 'Baldwin Bikes' 

--4)Ad son harf-s ve soyad ���nc� harfi A olan m��teriler
SELECT first_name,last_name from sales.customers C where first_name like '%s' and last_name like '__a%'

--5)Model y�l� 2015 ve 2017 dahil olmak �zere bu y�llar aras�ndaki �r�nleri(products) sipari�
--alm�� (order_items & orders) �al��anlar�(customers) listeleyiniz. Ad ve soyad bilgilerini
--e�siz olarak ekrana yazd�r�n�z
SELECT first_name, last_name from sales.staffs S
INNER JOIN sales.orders O on S.staff_id = O.staff_id
INNER JOIN sales.order_items OI on OI.order_id = O.order_id
INNER JOIN  production.products P on P.product_id = OI.product_id where P.model_year between 2015 and 2017

--6)'Rowlett Bikes' ve 'Baldwin Bikes' ma�azalar�ndan(stores) sipari�(orders) alan 10 adet
--�al��an�(staffs) listeleyiniz. Ad ve soyad bilgilerini ekrana listeleyiniz
SELECT DISTINCT TOP(10) first_name, last_name  from sales.staffs S
INNER JOIN sales.orders O on S.staff_id = O.staff_id 
INNER JOIN sales.stores St on St.store_id = O.store_id where store_name IN('Rowlett Bikes','Baldwin�Bikes')
