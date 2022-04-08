-- 检索一列 默认排序
SELECT prod_name 
FROM Products; 

-- 检索多列
SELECT prod_id, prod_name, prod_price
FROM Products;

-- 检索所有列
SELECT *   -- wildcard 通配符
FROM Products;  

-- 检索 去重
SELECT DISTINCT vend_id
FROM Products;

-- 多列组合去重
SELECT DISTINCT vend_id, prod_price FROM Products;
SELECT vend_id, prod_price FROM Products;

--限制行数
SELECT TOP 5 prod_name    -- Microsoft SQL Server
FROM Products;


SELECT prod_name
FROM Products
FETCH FIRST 5 ROWS ONLY;  -- DB2,

SELECT prod_name
FROM Products
WHERE ROWNUM <=5;   -- Oracle

SELECT prod_name
FROM Products
LIMIT 5;  -- MySQL, MariaDB, PostgreSQL, or SQLite

SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5;  -- LIMIT 4 OFFSET 3 , enabling you to combine them as LIMIT 3,4 (they are reversed, so be careful)


-- 注释

SELECT prod_name -- this is a comment
FROM Products;

# This is a comment  -- A # at the start of a line makes the entire line a comment. 
SELECT prod_name
FROM Products;

/* SELECT prod_name, vend_id
FROM Products; */
SELECT prod_name
FROM Products;


# ------------------------------------ charpter 3 -----------------------------------------

-- 排序 一列
SELECT prod_name
FROM Products
ORDER BY prod_name;  -- clause ORDER BY


-- 多列排序
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price, prod_name;

-- 通过列位置排序
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY 2, 3;

-- 排序方向 倒序
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC;

-- 多列 倒序

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name;  -- DESC was specified for the prod_price column, but not for the prod_name column.
-- If you want to sort descending on multiple columns, be sure each column has its own DESC keyword.



# ------------------------------------ charpter 4  Filtering Data-----------------------------------------
-- matching one values

-- 过滤 where 子句
SELECT prod_name, prod_price
FROM Products
WHERE prod_price = 3.49;

=  -- Equality
<> -- Nonequality
!=  -- Nonequality
< -- Less than
<= -- Less than or equal to
!< -- Not less than
> -- Greater than
>= Greater than or equal to
!> -- Not greater than
BETWEEN -- Between two specified values
IS NULL -- Is a NULL value

-- less than
SELECT prod_name, prod_price
FROM Products
WHERE prod_price < 10;

-- less or equal
SELECT prod_name, prod_price
FROM Products
WHERE prod_price <= 10;

-- 不等于 no matches
SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DLL01';  -- quotes are used to delimit a string; not used to delimit values used with numeric columns

SELECT vend_id, prod_name
FROM Products
WHERE vend_id != 'DLL01';

-- 查询范围 Checking for a Range of Values
SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;  -- BETWEEN operator ;  AND keyword

-- 查询 null 值
SELECT prod_name
FROM Products
WHERE prod_price IS NULL;  -- IS NULL clause

SELECT cust_name
FROM Customers
WHERE cust_email IS NULL;


# ------------------------------------ Lesson 5. Advanced Data Filtering-----------------------------------------
-- matching more values
-- AND
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' AND prod_price <= 4;  -- AND clauses or as OR clauses. A special keyword used to join or change clauses within a WHERE clause. Also known as logical operators.

-- OR
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';


SELECT prod_name, prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
AND prod_price >= 10;  -- SQL (like most languages) processes AND operators before OR operators. 

-- IN  operator
SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN ('DLL01','BRS01')
ORDER BY prod_name;

-- NOT Operator
SELECT prod_name
FROM Products
WHERE NOT vend_id = 'DLL01'
ORDER BY prod_name;

SELECT prod_name
FROM Products
WHERE vend_id <> 'DLL01'
ORDER BY prod_name;


# ------------------------------------ Lesson 6. Using Wildcard Filtering -----------------------------------------

-- % percent sign
-- match any number of occurrences of any character; 
-- all products that start with the word Fish
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%';  -- The most frequently used wildcard is the percent sign ( % )

-- Wildcards can be used anywhere within the search pattern
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';

SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y';

--Not even the clause WHERE prod_name LIKE '%' will match a row with the value NULL as the product name

-- _  Underscore
--  the underscore matches just a single character. not supported by DB2

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__inch teddy bear';

--  [] Brackets
-- he use of [] to create sets is not supported by all DBMSs. Sets are supported in Microsoft SQL Server, but
-- are not supported in MySQL, Oracle, DB2, and SQLite
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[JM]%'  -- o find all contacts whose names begin with the letter J or the letter M
ORDER BY cust_contact;

-- ^ negate []
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[^JM]%'
ORDER BY cust_contact;

SELECT cust_contact
FROM Customers
WHERE NOT cust_contact LIKE '[JM]%'
ORDER BY cust_contact;


# ------------------------------------ Lesson 7. Creating Calculated Fields -----------------------------------------


-- 计算字段
-- 拼接字段   
-- 操作符 +  ||

SELECT vend_name + '(' + vend_country + ')'  -- sql server
FROM Vendors 
ORDER BY vend_name;


SELECT vend_name || '(' || vend_country || ')' -- DB2、Oracle、PostgreSQL 和 SQLite
FROM Vendors 
ORDER BY vend_name;

SELECT Concat(vend_name, ' (', vend_country, ')')   -- MySQL MariaDB
FROM Vendors 
ORDER BY vend_name;


-- TRIM() RTRIM() LTRIM()
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')' 
FROM Vendors 
ORDER BY vend_name;

SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')' 
FROM Vendors 
ORDER BY vend_name;

-- 别名 alias

SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'  
 AS vend_title 
FROM Vendors 
ORDER BY vend_name;

-- 算术计算
SELECT prod_id, quantity, item_price 
FROM OrderItems 
WHERE order_num = 20008;

SELECT prod_id, 
       quantity, 
       item_price, 
       quantity*item_price AS expanded_price 
FROM OrderItems 
WHERE order_num = 20008;


# ------------------------------------ Lesson 8. 使用函数处理数据 -----------------------------------------

-- 文本处理函数

SELECT vend_name, UPPER(vend_name) AS vend_name_upcase 
FROM Vendors 
ORDER BY vend_name;


FROM Customers 
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

SELECT order_num 
FROM Orders 
WHERE DATEPART(yy, order_date) = 2020;





# ------------------------------------ Lesson 9. 汇总数据 -----------------------------------------

SELECT AVG(prod_price) AS avg_price 
FROM Products;


SELECT COUNT(*) AS num_cust 
FROM Customers;

SELECT COUNT(cust_email) AS num_cust 
FROM Customers;


SELECT MAX(prod_price) AS max_price 
FROM Products;


SELECT MIN(prod_price) AS min_price 
FROM Products;

SELECT SUM(quantity) AS items_ordered 
FROM OrderItems 
WHERE order_num = 20005;

SELECT SUM(item_price*quantity) AS total_price 
FROM OrderItems 
WHERE order_num = 20005;

SELECT COUNT(*) AS num_items, 
       MIN(prod_price) AS price_min, 
       MAX(prod_price) AS price_max, 
       AVG(prod_price) AS price_avg 
FROM Products;




# ------------------------------------ Lesson 10 分组数据 -----------------------------------------


-- 分组
SELECT cust_id, COUNT(*) AS orders 
FROM Orders 
GROUP BY cust_id 
HAVING COUNT(*) >= 2;

-- 分组过滤
SELECT vend_id, COUNT(*) AS num_prods 
FROM Products 
WHERE prod_price >= 4 
GROUP BY vend_id 
HAVING COUNT(*) >= 2;

SELECT cust_id, COUNT(*) AS orders 
FROM Orders 
GROUP BY cust_id 
HAVING COUNT(*) >= 2;


SELECT order_num, COUNT(*) AS items 
FROM OrderItems 
GROUP BY order_num 
HAVING COUNT(*) >= 3;


SELECT order_num, COUNT(*) AS items 
FROM OrderItems 
GROUP BY order_num 
HAVING COUNT(*) >= 3 
ORDER BY items, order_num;




# ------------------------------------ Lesson 11. 使用子查询 -----------------------------------------


SELECT cust_id 
FROM Orders 
WHERE order_num IN (SELECT order_num 
                    FROM OrderItems 
                    WHERE prod_id = 'RGAN01');


SELECT cust_name, cust_contact 
FROM Customers 
WHERE cust_id IN (SELECT cust_id 
                  FROM Orders 
                  WHERE order_num IN (SELECT order_num 
                                      FROM OrderItems 
                                      WHERE prod_id = 'RGAN01'));


SELECT cust_name,  
       cust_state, 
       (SELECT COUNT(*)  
        FROM Orders  
        WHERE Orders.cust_id = Customers.cust_id) AS orders 
FROM Customers  
ORDER BY cust_name;



# ------------------------------------ Lesson 12. 联结表 -----------------------------------------

-- 联结是利用 SQL 的SELECT能执行的最重要的操作


-- 创建联结非常简单，指定要联结的所有表以及关联它们的方式即可

SELECT vend_name, prod_name, prod_price 
FROM Vendors, Products 
WHERE Vendors.vend_id = Products.vend_id;

-- 内联结 等值联结 

SELECT vend_name, prod_name, prod_price 
FROM Vendors 
INNER JOIN Products ON Vendors.vend_id = Products.vend_id;  -- 联结条件用特定的ON子句而不是WHERE子句给出


SELECT prod_name, vend_name, prod_price, quantity 
FROM OrderItems, Products, Vendors 
WHERE Products.vend_id = Vendors.vend_id 
 AND OrderItems.prod_id = Products.prod_id 
 AND order_num = 20007;








# ------------------------------------ Lesson 13. 创建高级联结 -----------------------------------------

--表别名

SELECT cust_name, cust_contact 
FROM Customers AS C, Orders AS O, OrderItems AS OI 
WHERE C.cust_id = O.cust_id 
 AND OI.order_num = O.order_num 
 AND prod_id = 'RGAN01';

--  表别名只用于WHERE子句。其实它不仅能用于WHERE子句，还可以用于SELECT的列表、ORDER BY子句以及其他语句部分。

-- 表别名只在查询执行中使用。与列别名不一样，表别名不返回到客户端。



SELECT cust_id, cust_name, cust_contact 
FROM Customers 
WHERE cust_name = (SELECT cust_name 
                   FROM Customers 
                   WHERE cust_contact = 'Jim Jones');

SELECT c1.cust_id, c1.cust_name, c1.cust_contact 
FROM Customers AS c1, Customers AS c2 
WHERE c1.cust_name = c2.cust_name 
 AND c2.cust_contact = 'Jim Jones';


SELECT C.*, O.order_num, O.order_date, 
       OI.prod_id, OI.quantity, OI.item_price 
FROM Customers AS C, Orders AS O, 
     OrderItems AS OI 
WHERE C.cust_id = O.cust_id 
 AND OI.order_num = O.order_num 
 AND prod_id = 'RGAN01';


SELECT C.*, O.order_num, O.order_date, 
       OI.prod_id, OI.quantity, OI.item_price 
FROM Customers AS C, Orders AS O, 
     OrderItems AS OI 
WHERE C.cust_id = O.cust_id 
 AND OI.order_num = O.order_num 
 AND prod_id = 'RGAN01';


-- 联结包含了那些在相关表中没有关联行的行。这种联结称为外联结。


SELECT Customers.cust_id, Orders.order_num 
FROM Customers 
 INNER JOIN Orders ON Customers.cust_id = Orders.cust_id;

 SELECT Customers.cust_id, Orders.order_num 
FROM Customers 
 LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

 SELECT Customers.cust_id, Orders.order_num 
FROM Customers 
 RIGHT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;


SELECT Customers.cust_id, Orders.order_num 
FROM Customers 
 FULL OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;


SELECT Customers.cust_id, 
       COUNT(Orders.order_num) AS num_ord 
FROM Customers 
 INNER JOIN Orders ON Customers.cust_id = Orders.cust_id 
GROUP BY Customers.cust_id;

SELECT Customers.cust_id, 
       COUNT(Orders.order_num) AS num_ord 
FROM Customers 
 LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id 
GROUP BY Customers.cust_id;



# ------------------------------------ Lesson 14. 组合查询 -----------------------------------------

UNION

SELECT cust_name, cust_contact, cust_email 
FROM Customers 
WHERE cust_state IN ('IL','IN','MI') 
UNION 
SELECT cust_name, cust_contact, cust_email 
FROM Customers 
WHERE cust_name = 'Fun4All';


SELECT cust_name, cust_contact, cust_email  
FROM Customers  
WHERE cust_state IN ('IL','IN','MI')  
UNION ALL 
SELECT cust_name, cust_contact, cust_email  
FROM Customers  
WHERE cust_name = 'Fun4All';


SELECT cust_name, cust_contact, cust_email 
FROM Customers 
WHERE cust_state IN ('IL','IN','MI') 
UNION 
SELECT cust_name, cust_contact, cust_email 
FROM Customers 
WHERE cust_name = 'Fun4All' 
ORDER BY cust_name, cust_contact;



# ------------------------------------ Lesson 15. 插入数据 -----------------------------------------

-- 插入完整的行

INSERT INTO Customers 
VALUES(1000000006, 
       'Toy Land', 
       '123 Any Street', 
       'New York', 
       'NY', 
       '11111', 
       'USA', 
       NULL, 
       NULL);


INSERT INTO Customers(cust_id, 
                      cust_name, 
                      cust_address, 
                      cust_city, 
                      cust_state, 
                      cust_zip, 
                      cust_country, 
                      cust_contact, 
                      cust_email) 
VALUES(1000000006, 
       'Toy Land', 
       '123 Any Street', 
       'New York', 
       'NY', 
       '11111', 
       'USA', 
       NULL, 
       NULL);
    
INSERT INTO Customers(cust_id, 
                      cust_contact, 
                      cust_email, 
                      cust_name, 
                      cust_address, 
                      cust_city, 
                      cust_state, 
                      cust_zip) 
VALUES(1000000006, 
       NULL, 
       NULL, 
       'Toy Land', 
       '123 Any Street', 
       'New York', 
       'NY', 
       '11111');


INSERT INTO Customers(cust_id, 
                      cust_name, 
                      cust_address, 
                      cust_city, 
                      cust_state, 
                      cust_zip, 
                      cust_country) 
VALUES(1000000006, 
       'Toy Land', 
       '123 Any Street', 
       'New York', 
       'NY', 
       '11111', 
       'USA');


INSERT INTO Customers(cust_id, 
                      cust_contact, 
                      cust_email, 
                      cust_name, 
                      cust_address, 
                      cust_city, 
                      cust_state, 
                      cust_zip, 
                      cust_country) 
SELECT cust_id, 
       cust_contact, 
       cust_email,
       cust_name, 
       cust_address, 
       cust_city, 
       cust_state, 
       cust_zip, 
       cust_country 
FROM CustNew;


CREATE TABLE CustCopy AS SELECT * FROM Customers;


SELECT * INTO CustCopy FROM Customers;  -- sql server



# ------------------------------------ Lesson 16. 更新和删除数据 -----------------------------------------

UPDATE Customers 
SET cust_email = 'kim@thetoystore.com' 
WHERE cust_id = 1000000005;


UPDATE Customers 
SET cust_contact = 'Sam Roberts', 
    cust_email = 'sam@toyland.com' 
WHERE cust_id = 1000000006;

UPDATE Customers 
SET cust_email = NULL 
WHERE cust_id = 1000000005;


DELETE FROM Customers 
WHERE cust_id = 1000000006;

TRUNCATE TABLE



# ------------------------------------ Lesson 17. 创建和操纵表 -----------------------------------------

CREATE TABLE Products 
( 
    prod_id       CHAR(10)          NOT NULL, 
    vend_id       CHAR(10)          NOT NULL, 
    prod_name     CHAR(254)         NOT NULL, 
    prod_price    DECIMAL(8,2)      NOT NULL, 
    prod_desc     VARCHAR(1000)     NULL 
);


CREATE TABLE Orders 
( 
    order_num      INTEGER      NOT NULL, 
    order_date     DATETIME     NOT NULL, 
    cust_id        CHAR(10)     NOT NULL 
);


CREATE TABLE Vendors 
( 
    vend_id          CHAR(10)     NOT NULL, 
    vend_name        CHAR(50)     NOT NULL, 
    vend_address     CHAR(50)     , 
    vend_city        CHAR(50)     , 
    vend_state       CHAR(5)      , 
    vend_zip         CHAR(10)     , 
    vend_country     CHAR(50) 
);


CREATE TABLE OrderItems 
( 
    order_num      INTEGER          NOT NULL, 
    order_item     INTEGER          NOT NULL, 
    prod_id        CHAR(10)         NOT NULL, 
    quantity       INTEGER          NOT NULL      DEFAULT 1, 
    item_price     DECIMAL(8,2)     NOT NULL 
);



-- 更新表

ALTER TABLE Vendors 
ADD vend_phone CHAR(20);

ALTER TABLE Vendors 
DROP COLUMN vend_phone;


-- 删除表

DROP TABLE CustCopy;



-- 重命名



# ------------------------------------ Lesson 18. 使用视图 -----------------------------------------


CREATE VIEW ProductCustomers AS 
SELECT cust_name, cust_contact, prod_id 
FROM Customers, Orders, OrderItems 
WHERE Customers.cust_id = Orders.cust_id 
 AND OrderItems.order_num = Orders.order_num;


SELECT cust_name, cust_contact 
FROM ProductCustomers 
WHERE prod_id = 'RGAN01';

CREATE VIEW VendorLocations AS 
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')' 
       AS vend_title
FROM Vendors;


CREATE VIEW OrderItemsExpanded AS 
SELECT order_num, 
       prod_id, 
       quantity, 
       item_price, 
       quantity*item_price AS expanded_price 
FROM OrderItems




# ------------------------------------ Lesson 19. 使用存储过程 -----------------------------------------

-- 通过把处理封装在一个易用的单元中，可以简化复杂的操作（如前面例子所述）

EXECUTE AddNewProduct('JTS01',  
                      'Stuffed Eiffel Tower',  
                      6.49, 
                      'Plush stuffed toy with  
➥the text La Tour Eiffel in red white and blue');



CREATE PROCEDURE MailingListCount ( 
  ListCount OUT INTEGER 
)
IS 
v_rows INTEGER; 
BEGIN 
    SELECT COUNT(*) INTO v_rows 
    FROM Customers 
    WHERE NOT cust_email IS NULL; 
    ListCount := v_rows; 
END;

CREATE PROCEDURE MailingListCount 
AS 
DECLARE @cnt INTEGER 
SELECT @cnt = COUNT(*) 
FROM Customers 
WHERE NOT cust_email IS NULL; 
RETURN @cnt;


CREATE PROCEDURE NewOrder @cust_id CHAR(10) 
AS 
-- 为订单号声明一个变量 
DECLARE @order_num INTEGER 
-- 获取当前最大订单号 
SELECT @order_num=MAX(order_num) 
FROM Orders 
-- 决定下一个订单号 
SELECT @order_num=@order_num+1 
-- 插入新订单 
INSERT INTO Orders(order_num, order_date, cust_id) 
VALUES(@order_num, GETDATE(), @cust_id) 
-- 返回订单号 
RETURN @order_num;

CREATE PROCEDURE NewOrder @cust_id CHAR(10) 
AS 
-- 插入新订单 
INSERT INTO Orders(cust_id) 
VALUES(@cust_id) 
-- 返回订单号 
SELECT order_num = @@IDENTITY;

# ------------------------------------ Lesson 8. 管理事务处理 -----------------------------------------

BEGIN TRANSACTION 
DELETE OrderItems WHERE order_num = 12345 
DELETE Orders WHERE order_num = 12345 
COMMIT TRANSACTION


SAVEPOINT delete1;

ROLLBACK TRANSACTION delete1;

ROLLBACK TO delete1;


BEGIN TRANSACTION 
INSERT INTO Customers(cust_id, cust_name) 
VALUES(1000000010, 'Toys Emporium'); 
SAVE TRANSACTION StartOrder; 
INSERT INTO Orders(order_num, order_date, cust_id) 
VALUES(20100,'2001/12/1',1000000010);
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder; 
INSERT INTO OrderItems(order_num, order_item,  
➥prod_id, quantity, item_price) 
VALUES(20100, 1, 'BR01', 100, 5.49); 
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder; 
INSERT INTO OrderItems(order_num, order_item,  
➥prod_id, quantity, item_price) 
VALUES(20100, 2, 'BR03', 100, 10.99); 
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder; 
COMMIT TRANSACTION





# ------------------------------------ Lesson 21. 使用游标 -----------------------------------------

/*
需要在检索出来的行中前进或后退一行或多行，这就是游标的用
途所在。游标（cursor）是一个存储在 DBMS 服务器上的数据库查询，
它不是一条SELECT语句，而是被该语句检索出来的结果集
*/


DECLARE CustCursor CURSOR 
FOR 
SELECT * FROM Customers 
WHERE cust_email IS NULL;


DECLARE CURSOR CustCursor 
IS 
SELECT * FROM Customers 
WHERE cust_email IS NULL;


OPEN CURSOR CustCursor


DECLARE TYPE CustCursor IS REF CURSOR 
    RETURN Customers%ROWTYPE; 
DECLARE CustRecord Customers%ROWTYPE 
BEGIN 
    OPEN CustCursor; 
    FETCH CustCursor INTO CustRecord; 
    CLOSE CustCursor; 
END;


DECLARE TYPE CustCursor IS REF CURSOR 
    RETURN Customers%ROWTYPE; 
DECLARE CustRecord Customers%ROWTYPE 
BEGIN 
    OPEN CustCursor; 
    LOOP 
    FETCH CustCursor INTO CustRecord; 
    EXIT WHEN CustCursor%NOTFOUND; 
       ... 
    END LOOP; 
    CLOSE CustCursor; 
END;

CLOSE CustCursor



# ------------------------------------ Lesson 22. 高级 SQL 特性 -----------------------------------------

-- 约束、索引和触发器


-- 主键

CREATE TABLE Vendors  
( 
    vend_id         CHAR(10)       NOT NULL PRIMARY KEY,  
    vend_name       CHAR(50)       NOT NULL, 
    vend_address    CHAR(50)       NULL, 
    vend_city       CHAR(50)       NULL, 
    vend_state      CHAR(5)        NULL, 
    vend_zip        CHAR(10)       NULL, 
    vend_country    CHAR(50)       NULL 
);


ALTER TABLE Vendors  
ADD CONSTRAINT PRIMARY KEY (vend_id);


-- 外键



CREATE TABLE Orders 
( 
    order_num    INTEGER    NOT NULL PRIMARY KEY, 
    order_date   DATETIME   NOT NULL, 
    cust_id      CHAR(10)   NOT NULL REFERENCES Customers(cust_id) 
);


ALTER TABLE Orders 
ADD CONSTRAINT 
FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);


-- 唯一约束

UNIQUE


-- 检查约束
CREATE TABLE OrderItems 
( 
    order_num     INTEGER     NOT NULL, 
    order_item    INTEGER     NOT NULL, 
    prod_id       CHAR(10)    NOT NULL, 
    quantity      INTEGER     NOT NULL CHECK (quantity > 0), 
    item_price    MONEY       NOT NULL 
);


ADD CONSTRAINT CHECK (gender LIKE '[MF]');


-- 索引

CREATE INDEX prod_name_ind    -- 索引必须唯一命名。这里的索引名prod_name_ind在关键字CREATE INDEX之后定义。
ON Products (prod_name);



-- 触发器

CREATE TRIGGER customer_state 
ON Customers 
FOR INSERT, UPDATE 
AS 
UPDATE Customers 
SET cust_state = Upper(cust_state) 
WHERE Customers.cust_id = inserted.cust_id;


CREATE TRIGGER customer_state 
AFTER INSERT OR UPDATE 
FOR EACH ROW 
BEGIN 
UPDATE Customers 
SET cust_state = Upper(cust_state) 
WHERE Customers.cust_id = :OLD.cust_id 
END;

