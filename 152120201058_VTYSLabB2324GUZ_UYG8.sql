--Soru 1: Bir m��teri silindi�inde bu m��teriye ait t�m sipari�lerin otomatik olarak silinmesini 
--sa�layan tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n� 
--yaz�n�z.

CREATE TRIGGER trgDeleteCustomer2
ON sales.customers
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM sales.orders
    WHERE customer_id IN (SELECT customer_id FROM deleted);
END;

INSERT INTO sales.customers (first_name, last_name, email) VALUES ('Albert', 'Camus', 'albert@gmail.com');

-- sipari� eklemek i�in
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id)
VALUES (1, 1, '2016-01-01', '2017-01-05', 1, 1);

-- M��teriyi silmek i�in
DELETE FROM sales.customers WHERE customer_id = 1;

-- M��terinin sipari�ini kontrol etmek 
SELECT * FROM sales.orders;


-- Soru 2: Bir sipari� kalemi eklenirken ilgili �r�n�n stok miktar�n�n otomatik olarak azalt�lmas�n� 
-- sa�layarak sipari� i�lemi ger�ekle�ti�inde stok seviyelerini ger�ek zamanl� olarak g�ncelleyen 
-- tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n� yaz�n�z.
CREATE TRIGGER trg_insert_orderItem2
ON sales.order_items
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE production.stocks
    SET quantity = production.stocks.quantity - i.quantity
    FROM inserted i
    WHERE production.stocks.store_id = 1 AND production.stocks.product_id = i.product_id;
END;

-- test sql Sorgular - 2
-- Sipari� kalemi eklemek 
INSERT INTO sales.order_items (order_id, product_id, quantity, list_price, discount)
VALUES (1, 1, 2, 50.00, 0.05);

-- Stok seviye kontrol 
SELECT * FROM production.stocks;





--Soru 3: Bir �r�n silindi�inde bu �r�ne ait stok bilgilerinin de otomatik olarak silinmesini 
--sa�layan tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n� 
--yaz�n�z
CREATE TRIGGER trg_delete_product2
ON production.products
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM production.stocks
    WHERE product_id IN (SELECT product_id FROM deleted);
END;

--test SQL sorgular�-3
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES ('ProductA', 1, 1, 2016, 100.00);

-- �r�n� silmek 
DELETE FROM production.products WHERE product_id = 1;

-- Stok bilgilerini kontrol etmek 
SELECT * FROM production.stocks;




--Soru 4: Yeni bir �r�n ekledi�inizde t�m ma�azalarda stok kayd� olu�turan tetikleyici kodunu 
--yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n� yaz�n�z.
CREATE TRIGGER trg_insert_product2
ON production.products
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO production.stocks (store_id, product_id, quantity)
    SELECT s.store_id, i.product_id, 0
    FROM inserted i
    CROSS JOIN sales.stores s;
END;

-- Test SQL Sorgular� - 4.
-- �r�n eklemek i�in
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES ('ProductB', 2, 2, 2017, 75.00);

-- Stok kay�tlar�n� kontrol etmek
SELECT * FROM production.stocks;





--Soru 5: Bir kategori silindi�inde, silinen kategoriye ait �r�nlerin kategori bilgilerini NULL 
--olarak g�ncelleyen tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL 
--sorgular�n� yaz�n�z.
CREATE TRIGGER trg_delete_category2
ON production.categories
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE production.products
    SET category_id = NULL
    WHERE category_id IN (SELECT category_id FROM deleted);
END;

-- test sql - soru 5
-- Kategori eklemek 
INSERT INTO production.categories (category_name) VALUES ('Electronics');

-- �r�n eklemek 
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES ('ProductC', 3, 3, 2016, 120.00);

-- Kategoriyi silmek
DELETE FROM production.categories WHERE category_id = 3;

-- �r�n bilgilerini kontrol etmek 
SELECT * FROM production.products;



















































------------

--Soru 1: Bir m��teri silindi�inde bu m��teriye ait t�m sipari�lerin otomatik olarak silinmesini
--sa�layan tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n�
--yaz�n�z.
CREATE TRIGGER trg_DeleteCustomerOrders
ON sales.customers
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM sales.orders
    WHERE customer_id IN (SELECT customer_id FROM deleted);
END;

--test 1
-- �nce m��teri ve sipari� ekle
INSERT INTO sales.customers (first_name, last_name, email) VALUES ('Herman', 'Hesse', 'hermann@gmail.com');
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id) VALUES (SCOPE_IDENTITY(), 1, GETDATE(), GETDATE(), 1, 1);

-- Tetikleyiciyi test etmek i�in m��teriyi sil
DELETE FROM sales.customers WHERE customer_id = SCOPE_IDENTITY();

-- Sipari�in silinip silinmedi�ini kontrol etmek
SELECT * FROM sales.orders;






--Soru 4: Yeni bir �r�n ekledi�inizde t�m ma�azalarda stok kayd� olu�turan tetikleyici kodunu
--yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n� yaz�n�z. 

CREATE TRIGGER trg_4
ON production.products
AFTER INSERT
AS
BEGIN
    INSERT INTO production.stocks (store_id, product_id, quantity)
    SELECT store_id, inserted.product_id, 0
    FROM sales.stores, inserted;
END;


--test
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('New Product', 1, 2, 2018, 500);

SELECT * FROM production.stocks WHERE product_id = (SELECT MAX(product_id) FROM production.products);




--Soru 5: Bir kategori silindi�inde, silinen kategoriye ait �r�nlerin kategori bilgilerini NULL
--olarak g�ncelleyen tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL
--sorgular�n� yaz�n�z.
CREATE TRIGGER trg_UpdateProductCategoryOnCategoryDelete
ON production.categories
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE production.products
    SET category_id = NULL
    FROM production.products p
    JOIN deleted d ON p.category_id = d.category_id;
END;


-- �nce bir kategori ve �r�n ekle
INSERT INTO production.categories (category_name) VALUES ('Electronics');
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('Laptop', 1, SCOPE_IDENTITY(), 2023, 1000.00);

-- kategori silme
DELETE FROM production.categories WHERE category_id = SCOPE_IDENTITY();

-- g�ncellenme var m� kontrol etme
SELECT * FROM production.products;




