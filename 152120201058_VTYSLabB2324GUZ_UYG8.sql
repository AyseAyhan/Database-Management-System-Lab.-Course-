--Soru 1: Bir müþteri silindiðinde bu müþteriye ait tüm sipariþlerin otomatik olarak silinmesini 
--saðlayan tetikleyici kodunu yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL sorgularýný 
--yazýnýz.

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

-- sipariþ eklemek için
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id)
VALUES (1, 1, '2016-01-01', '2017-01-05', 1, 1);

-- Müþteriyi silmek için
DELETE FROM sales.customers WHERE customer_id = 1;

-- Müþterinin sipariþini kontrol etmek 
SELECT * FROM sales.orders;


-- Soru 2: Bir sipariþ kalemi eklenirken ilgili ürünün stok miktarýnýn otomatik olarak azaltýlmasýný 
-- saðlayarak sipariþ iþlemi gerçekleþtiðinde stok seviyelerini gerçek zamanlý olarak güncelleyen 
-- tetikleyici kodunu yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL sorgularýný yazýnýz.
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
-- Sipariþ kalemi eklemek 
INSERT INTO sales.order_items (order_id, product_id, quantity, list_price, discount)
VALUES (1, 1, 2, 50.00, 0.05);

-- Stok seviye kontrol 
SELECT * FROM production.stocks;





--Soru 3: Bir ürün silindiðinde bu ürüne ait stok bilgilerinin de otomatik olarak silinmesini 
--saðlayan tetikleyici kodunu yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL sorgularýný 
--yazýnýz
CREATE TRIGGER trg_delete_product2
ON production.products
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM production.stocks
    WHERE product_id IN (SELECT product_id FROM deleted);
END;

--test SQL sorgularý-3
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES ('ProductA', 1, 1, 2016, 100.00);

-- Ürünü silmek 
DELETE FROM production.products WHERE product_id = 1;

-- Stok bilgilerini kontrol etmek 
SELECT * FROM production.stocks;




--Soru 4: Yeni bir ürün eklediðinizde tüm maðazalarda stok kaydý oluþturan tetikleyici kodunu 
--yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL sorgularýný yazýnýz.
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

-- Test SQL Sorgularý - 4.
-- Ürün eklemek için
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES ('ProductB', 2, 2, 2017, 75.00);

-- Stok kayýtlarýný kontrol etmek
SELECT * FROM production.stocks;





--Soru 5: Bir kategori silindiðinde, silinen kategoriye ait ürünlerin kategori bilgilerini NULL 
--olarak güncelleyen tetikleyici kodunu yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL 
--sorgularýný yazýnýz.
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

-- Ürün eklemek 
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES ('ProductC', 3, 3, 2016, 120.00);

-- Kategoriyi silmek
DELETE FROM production.categories WHERE category_id = 3;

-- Ürün bilgilerini kontrol etmek 
SELECT * FROM production.products;



















































------------

--Soru 1: Bir müþteri silindiðinde bu müþteriye ait tüm sipariþlerin otomatik olarak silinmesini
--saðlayan tetikleyici kodunu yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL sorgularýný
--yazýnýz.
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
-- Önce müþteri ve sipariþ ekle
INSERT INTO sales.customers (first_name, last_name, email) VALUES ('Herman', 'Hesse', 'hermann@gmail.com');
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id) VALUES (SCOPE_IDENTITY(), 1, GETDATE(), GETDATE(), 1, 1);

-- Tetikleyiciyi test etmek için müþteriyi sil
DELETE FROM sales.customers WHERE customer_id = SCOPE_IDENTITY();

-- Sipariþin silinip silinmediðini kontrol etmek
SELECT * FROM sales.orders;






--Soru 4: Yeni bir ürün eklediðinizde tüm maðazalarda stok kaydý oluþturan tetikleyici kodunu
--yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL sorgularýný yazýnýz. 

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




--Soru 5: Bir kategori silindiðinde, silinen kategoriye ait ürünlerin kategori bilgilerini NULL
--olarak güncelleyen tetikleyici kodunu yazýnýz (20p). Ýlgili tetikleyici kodunu test eden SQL
--sorgularýný yazýnýz.
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


-- Önce bir kategori ve ürün ekle
INSERT INTO production.categories (category_name) VALUES ('Electronics');
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('Laptop', 1, SCOPE_IDENTITY(), 2023, 1000.00);

-- kategori silme
DELETE FROM production.categories WHERE category_id = SCOPE_IDENTITY();

-- güncellenme var mý kontrol etme
SELECT * FROM production.products;




