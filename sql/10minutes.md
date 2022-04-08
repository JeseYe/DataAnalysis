#### SELECT 语句

接触一门新知识，理解它背后的逻辑，为什么是这样作是非常重要的， 理解了它之所以这么作之后，一切也变得简单明了了。

## Lesson 2  检索数据
SQL语句都是由一个或多个关键字构成的

SELECT 语句的用途是从一个或多个表中检索
信息。

关键字不能用作表或列的名字

使用 SELECT 检索表数据，必须至少给出两条信息——想选择什么，以及从什么地方选择

SELECT prod_name FROM Products;

列名写在 SELECT 关键字之后， FROM 关键字指出从哪个表中检索数据
多数 DBMS不需要在单条 SQL语句后加分号，但也有 DBMS可能必须在单条 SQL语句后加上分号

SELECT prod_id, prod_name, prod_price FROM Products;

SELECT * FROM Products;

使用 DISTINCT 关键字
SELECT DISTINCT vend_id FROM Products;

DISTINCT 关键字作用于所有的列，不仅仅是跟在其后的那一列。例
如，你指定 SELECT DISTINCT vend_id, prod_price ，除非指定的
两列完全相同，否则所有的行都会被检索出来

SELECT TOP 5 prod_name FROM Products;  --SQL Server和 Access--

SELECT prod_name FROM Products FETCH FIRST 5 ROWS ONLY; -- DB2

SELECT prod_name FROM Products WHERE ROWNUM <=5; -- Oracle

SELECT prod_name FROM Products LIMIT 5;  -- MySQL、MariaDB、PostgreSQL或者 SQLite


SELECT prod_name FROM Products LIMIT 5 OFFSET 5;
指定从哪儿开始以及检索的行数

MySQL和MariaDB支持简化版的 LIMIT 4 OFFSET 3 语句，即 LIMIT 3,4 。
使用这个语法，逗号之前的值对应 OFFSET ，逗号之后的值对应 LIMIT 

SELECT prod_name -- 注释使用 -- （两个连字符）嵌在行内。 -- 之后的文本就是注释
FROM Products;

\# 另一种形式的行内注释（虽然这种形式很少得到支持）
SELECT prod_name
FROM Products;

/* 多行注释，注释可以在脚本的任何位置停止和开始。 */
SELECT prod_name
FROM Products;

## Lesson 3 排序检索数据

##### 子句（clause）
SQL语句由子句构成，有些子句是必需的，有些则是可选的。一个子
句通常由一个关键字加上所提供的数据组成。子句的例子有我们在前
一课看到的 SELECT 语句的 FROM 子句。

排序用 SELECT 语句检索出的数据，可使用 ORDER BY 子句。
ORDER BY 子句取一个或多个列的名字，据此对输出进行排序。请看下面
的例子：
SELECT prod_name FROM Products ORDER BY prod_name;

指定一条 ORDER BY 子句时，应该保证它是 SELECT 语句中最后一
条子句。如果它不是最后的子句，将会出现错误消息

SELECT prod_id, prod_price, prod_name FROM Products ORDER BY prod_price, prod_name;

按相对列位置进行排
序
SELECT prod_id, prod_price, prod_name FROM Products ORDER BY 2, 3;

SELECT prod_id, prod_price, prod_name FROM Products ORDER BY prod_price DESC;

SELECT prod_id, prod_price, prod_name FROM Products ORDER BY prod_price DESC, prod_name;

如果想在多个列上进行降序排序，必须对每一列指定 DESC 关键字。

 DESC 是 DESCENDING 的缩写，这两个关键字都可以使用


 ### Lesson 4 过滤数据

SELECT prod_name, prod_price FROM Products WHERE prod_price = 3.49;
使用 WHERE 子句

搜索条件（search criteria），搜索条件也称为过滤条件（filter condition）。
让客户端应用（或开发语言）处理数据库的工作将会极大
地影响应用的性能，并且使所创建的应用完全不具备可伸缩性; 这种做法极其不妥

WHERE 子句操作符

某些操作符是冗余的（如 < > 与 != 相同， !< 相当于 >= ）

SELECT prod_name, prod_price FROM Products WHERE prod_price < 10;

SELECT vend_id, prod_name FROM Products WHERE vend_id <> 'DLL01';

SELECT vend_id, prod_name FROM Products WHERE vend_id != 'DLL01';


##### 范围值检查

检查某个范围的值，可以使用 BETWEEN 操作符
其语法与其他 WHERE
子句的操作符稍有不同，因为它需要两个值，即范围的开始值和结束值

SELECT prod_name, prod_price FROM Products WHERE prod_price BETWEEN 5 AND 10;

#####  空值检查

SELECT prod_name FROM Products WHERE prod_price IS NULL;

### Lesson 5  高级数据过滤

第 4课介绍的所有 WHERE 子句在过滤数据时使用的都是单一的条件。为
了进行更强的过滤控制，SQL允许给出多个 WHERE 子句。这些子句有两
种使用方式，即以 AND 子句或 OR 子句的方式使用

##### 操作符（operator）

用来联结或改变 WHERE 子句中的子句的关键字，也称为逻辑操作符
（logical operator）。

SELECT prod_id, prod_price, prod_name FROM Products WHERE vend_id = 'DLL01' AND prod_price <= 4;

SELECT prod_name, prod_price FROM Products WHERE vend_id = 'DLL01' OR vend_id = ‘BRS01’;

SELECT prod_name, prod_price FROM Products WHERE vend_id = 'DLL01' OR vend_id = 'BRS01' AND prod_price >= 10;

SELECT prod_name, prod_price FROM Products WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') AND prod_price >= 10;

SELECT prod_name, prod_price FROM Products WHERE vend_id IN ( 'DLL01', 'BRS01' ) ORDER BY prod_name;

IN 操作符一般比一组 OR 操作符执行得更快（在上面这个合法选项很
少的例子中，你看不出性能差异）。
IN 的最大优点是可以包含其他 SELECT
语句，能够更动态地建立
WHERE 子句。第 11课会对此进行详细介绍。

SELECT prod_name FROM Products WHERE NOT vend_id = 'DLL01' ORDER BY prod_name;

上面的例子也可以使用 <> 操作符来完成，如下所示
SELECT prod_name FROM Products WHERE vend_id <> 'DLL01' ORDER BY prod_name;

### Lesson 6 用通配符进行过滤

不管是匹配一个值
还是多个值，检验大于还是小于已知值，或者检查某个范围的值，其共
同点是过滤中使用的值都是已知的。

##### 通配符（wildcard）
用来匹配值的一部分的特殊字符。

##### 搜索模式（search pattern）
由字面值、通配符或两者组合构成的搜索条件。

##### 谓词（predicate）
操作符何时不是操作符？答案是，它作为谓词时。从技术上说， LIKE
是谓词而不是操作符。虽然最终的结果是相同的，但应该对此术语有
所了解，以免在 SQL文献或手册中遇到此术语时不知所云。

###### 通配符搜索只能用于文本字段（字符串），非文本数据类型字段不能使用通配符搜索。

SELECT prod_id, prod_name FROM Products WHERE prod_name LIKE 'Fish%';
 % 表示任何字符出现任意次
数

SELECT prod_id, prod_name FROM Products WHERE prod_name LIKE '%bean bag%';

SELECT prod_name FROM Products WHERE prod_name LIKE 'F%y';

下划线（ _ ）。下划线只匹配
单个字符，而不是多个字符。

SELECT prod_id, prod_name FROM Products WHERE prod_name LIKE '__ inch teddy bear';

SELECT prod_id, prod_name FROM Products WHERE prod_name LIKE '% inch teddy bear';

方括号（ [] ）通配符用来指定一个字符集，它必须匹配指定位置（通配
符的位置）的一个字符。

并不是所有 DBMS都支持用来创建集合
的 [] 。只有微软的 Access 和 SQL Server 支持集合。为确定你使用的
DBMS是否支持集合，请参阅相应的文档。

FROM Customers WHERE cust_contact LIKE '[JM]%' ORDER BY cust_contact;
找出所有名字以 J 或 M 起头的联系人

可以用前缀字符 ^ ^ （脱字号）来否定

SELECT cust_contact FROM Customers WHERE cust_contact LIKE '[ ^JM]%' ORDER BY cust_contact;

SELECT cust_contact FROM Customers WHERE NOT cust_contact LIKE '[JM]%' ORDER BY cust_contact;

### Lesson 7  创建计算字段

计算字段并不实际存在于数据库表中。计算字段是运行时在 SELECT 语句内
创建的

#### 字段（field）
基本上与列（column）的意思相同，经常互换使用，不过数据库列一
般称为列，而术语字段通常与计算字段一起使用。

##### 拼接字段

SELECT vend_name + ' (' + vend_country + ')' FROM Vendors ORDER BY vend_name;     -- Access和 SQL Server

SELECT vend_name || ' (' || vend_country || ')' FROM Vendors ORDER BY vend_name;   -- DB2、Oracle、PostgreSQL、SQLite和
Open Office Base

SELECT Concat(vend_name, ' (', vend_country, ')') FROM Vendors ORDER BY vend_name;   -- MySQL或 MariaDB

SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')' FROM Vendors ORDER BY vend_name;

SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
FROM Vendors
ORDER BY vend_name;


大多数 DBMS都支持 RTRIM() （正如刚才所见，它去掉字符串右边的
空格）、 LTRIM() （去掉字符串左边的空格）以及 TRIM() （去掉字符
串左右两边的空格）。

##### 使用别名  alias

SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
AS vend_title
FROM Vendors
ORDER BY vend_name;


SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
AS vend_title
FROM Vendors
ORDER BY vend_name;

SELECT Concat(vend_name, ' (', vend_country, ')')
AS vend_title
FROM Vendors
ORDER BY vend_name;

别名还有其他用途。常见的用途包括在实际的表列名包含不合法的字
符（如空格）时重新命名它，在原来的名字含混或容易误解时扩充它。

别名的名字既可以是一个单词，也可以是一个字符串。如果是后者，
字符串应该括在引号中。虽然这种做法是合法的，但不建议这么去做。
多单词的名字可读性高，不过会给客户端应用带来各种问题。因此，
别名最常见的使用是将多个单词的列名重命名为一个单词的名字。

别名有时也称为导出列（derived column），不管怎么叫，它们所代表
的是相同的东西。

#### 执行算术计算

SELECT prod_id, quantity, item_price
FROM OrderItems
WHERE order_num = 20008;

SELECT prod_id,
quantity,
item_price,
quantity*item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;

SELECT 语句为测试、检验函数和计算提供了很好的方法。虽然 SELECT
通常用于从表中检索数据，但是省略了 FROM 子句后就是简单地访问和
处理表达式，例如 SELECT 3 * 2; 将返回 6， SELECT Trim(' abc ');
将返回 abc ， SELECT Now(); 使用 Now() 函数返回当前日期和时间。
现在你明白了，可以根据需要使用 SELECT 语句进行检验。

## Lesson 8 使用函数处理数据

SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM Vendors
ORDER BY vend_name;

LEFT() （或使用子字符串函数） 返回字符串左边的字符
LENGTH() （也使用 DATALENGTH() 或 LEN() ） 返回字符串的长度
LOWER() （Access使用 LCASE() ） 将字符串转换为小写
LTRIM() 去掉字符串左边的空格
RIGHT() （或使用子字符串函数） 返回字符串右边的字符
RTRIM() 去掉字符串右边的空格
SOUNDEX() 返回字符串的SOUNDEX值
UPPER() （Access使用 UCASE() ） 将字符串转换为大写

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_contact = 'Michael Green';

SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

Microsoft Access 和 PostgreSQL 不支持 SOUNDEX()

SELECT order_num
FROM Orders
WHERE DATEPART(yy, order_date) = 2012;

SELECT order_num
FROM Orders
WHERE DATEPART('yyyy', order_date) = 2012;

SELECT order_num
FROM Orders
WHERE DATE_PART('year', order_date) = 2012;  -- PostgreSQL

SELECT order_num
FROM Orders
WHERE to_number(to_char(order_date, 'YYYY')) = 2012;  -- Oracle

完成相同工作的另一方法是使用 BETWEEN 操作符：

SELECT order_num
FROM Orders
WHERE order_date BETWEEN to_date('01-01-2012')
AND to_date('12-31-2012');


SELECT order_num
FROM Orders
WHERE YEAR(order_date) = 2012;  -- mysql

SQLite中有个小技巧：
SELECT order_num
FROM Orders
WHERE strftime('%Y', order_date) = '2012';


## Lesson 9 汇总数据

SELECT AVG(prod_price) AS avg_price
FROM Products;

SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

利用 COUNT(*) 对所有行计数
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

SUM() 函数忽略列值为 NULL 的行。

SELECT AVG(DISTINCT prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

对所有行执行计算，指定 ALL 参数或不指定参数（因为 ALL 是默认行
为）。
只包含不同的值，指定 DISTINCT 参数

如果指定列名，则 DISTINCT 只能用于 COUNT() 。 DISTINCT 不能用
于 COUNT(*) 。类似地， DISTINCT 必须使用列名，不能用于计算或表
达式。

SELECT COUNT(*) AS num_items,
MIN(prod_price) AS price_min,
MAX(prod_price) AS price_max,
AVG(prod_price) AS price_avg
FROM Products;

## Lesson 10 分组数据

两个新 SELECT 语句子句： GROUP BY 子句和 HAVING 子句。

目前为止的所有计算都是在表的所有数据或匹配特定的 WHERE 子句的数
据上进行的。比如下面的例子

SELECT COUNT(*) AS num_prods
FROM Products
WHERE vend_id = 'DLL01';

分组可以将数据分为多个逻辑组，
对每个组进行聚集计算。


分组是使用 SELECT 语句的 GROUP BY 子句建立的

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id;

WHERE 过滤指定的是行而不是分组。事实
上， WHERE 没有分组的概念。
那么，不使用 WHERE 使用什么呢？SQL 为此提供了另一个子句，就是
HAVING 子句。 HAVING 非常类似于 WHERE 。事实上，目前为止所学过的
所有类型的 WHERE 子句都可以用 HAVING 来替代。唯一的差别是， WHERE
过滤行，而 HAVING 过滤分组。

SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;

里有另一种理解方法， WHERE 在数据分组前进行过滤， HAVING 在数
据分组后进行过滤。这是一个重要的区别， WHERE 排除的行不包括在
分组中。这可能会改变计算值，从而影响 HAVING 子句中基于这些值
过滤掉的分组。

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2;

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id
HAVING COUNT(*) >= 2;

应该提供明确的 ORDER BY 子句，即使其效果等同于 GROUP BY 子句

一般在使用 GROUP BY 子句时，应该也给出 ORDER BY 子句。这是保
证数据正确排序的唯一方法。千万不要仅依赖 GROUP BY 排序数据。

SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3;

SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;

## Lesson 11 使用子查询

迄今为止所看到的所有 SELECT 语句都
是简单查询，即从单个数据库表中检索数据的单条语句。

任何 SQL语句都是查询。但此术语一般指 SELECT 语句。

QL还允许创建子查询（subquery），即嵌套在其他查询中的查询


列出订购物品 RGAN01 的所有顾客:

SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';


SELECT cust_id
FROM Orders
WHERE order_num IN (20007,20008);

SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01');

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN ('1000000004','1000000005');

FROM Customers
WHERE cust_id IN (
    SELECT cust_id
    FROM Orders
    WHERE order_num IN (
        SELECT order_num
        FROM OrderItems
        WHERE prod_id = 'RGAN01')
    );

---

SELECT COUNT(*) AS orders
FROM Orders
WHERE cust_id = '1000000001';

SELECT cust_name,
cust_state,
(SELECT COUNT(*)
FROM Orders
WHERE Orders.cust_id = Customers.cust_id) AS orders
FROM Customers
ORDER BY cust_name;

## Lesson 12  联结表

SQL最强大的功能之一就是能在数据查询的执行中联结（join）表。联结
是利用 SQL的 SELECT 能执行的最重要的操作，很好地理解联结及其语
法是学习 SQL的极为重要的部分。

相同的数据出现多次决不是一件好事，这是关系数据库设计的
基础。关系表的设计就是要把信息分解成多个表，一类数据一个表。各
表通过某些共同的值互相关联（所以才叫关系数据库）

关系数据库的可伸缩性远比非关系数据库要好

##### 可伸缩（scale）

能够适应不断增加的工作量而不失败。设计良好的数据库或应用程序
称为可伸缩性好（scale well）。

联结是一种机制，用来在一条 SELECT 语句
中关联表，因此称为联结。使用特殊的语法，可以联结多个表返回一组
输出，联结在运行时关联表中正确的行

联结不是物理实体。换句话说，它在实际的数据库表
中并不存在。DBMS会根据需要建立联结，它在查询执行期间一直存在

引用完
整性表示 DBMS强制实施数据完整性规则

SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;

SELECT vend_name, prod_name, prod_price
FROM Vendors, Products;  -- 笛卡尔积

要保证所有联结都有 WHERE 子句，否则 DBMS将返回比想要的数据多
得多的数据。同理，要保证 WHERE 子句的正确性。不正确的过滤条件
会导致 DBMS返回不正确的数据。

有时，返回笛卡儿积的联结，也称叉联结（cross join）。

##### 内联结

目前为止使用的联结称为等值联结（equijoin），它基于两个表之间的相
等测试。这种联结也称为内联结（inner join）。其实，可以对这种联结使
用稍微不同的语法，明确指定联结的类型。下面的 SELECT 语句返回与
前面例子完全相同的数据：

SELECT vend_name, prod_name, prod_price
FROM Vendors INNER JOIN Products
ON Vendors.vend_id = Products.vend_id;

使用这种语法时，联结条件用特定的 ON 子句而不是 WHERE 子句给出。传递
给 ON 的实际条件与传递给 WHERE 的相同

ANSI SQL 规范首选 INNER JOIN 语法，之前使用的是简单的等值语
法。其实，SQL语言纯正论者是用鄙视的眼光看待简单语法的。这就
是说，DBMS 的确支持简单格式和标准格式，我建议你要理解这两种
格式，具体使用就看你用哪个更顺手了

SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id = Vendors.vend_id
AND OrderItems.prod_id = Products.prod_id
AND order_num = 20007;

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01'));

SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND OrderItems.order_num = Orders.order_num
AND prod_id = 'RGAN01';


## Lesson 13 创建高级联结


SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
AS vend_title
FROM Vendors
ORDER BY vend_name;

SQL 除了可以对列名和计算字段使用别名，还允许给表名起别名

SELECT cust_name, cust_contact
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
AND OI.order_num = O.order_num
AND prod_id = 'RGAN01';


迄今为止，我们使用的只是内联结或等值联结的简单联结。现在来看三种
其他联结：自联结（self-join）、自然联结（natural join）和外联结（outer join）。

SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (SELECT cust_name
FROM Customers
WHERE cust_contact = 'Jim Jones');

SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name = c2.cust_name
AND c2.cust_contact = 'Jim Jones';

自联结通常作为外部语句，用来替代从相同表中检索数据的使用子查
询语句。虽然最终的结果是相同的，但许多 DBMS处理联结远比处理
子查询快得多。应该试一下两种方法，以确定哪一种的性能更好

标准的联结（前一课中介绍的内联结）返回所有数据，相同的列
甚至多次出现。自然联结排除多次出现，使每一列只返回一次。
怎样完成这项工作呢？答案是，系统不完成这项工作，由你自己完成它。
自然联结要求你只能选择那些唯一的列，一般通过对一个表使用通配符
（ SELECT * ），而对其他表的列使用明确的子集来完成。下面举一个例子

SELECT C.*, O.order_num, O.order_date,
OI.prod_id, OI.quantity, OI.item_price
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
AND OI.order_num = O.order_num
AND prod_id = 'RGAN01';

事实上，我们迄今为止建立的每个内联结都是自然联结，很可能永远都
不会用到不是自然联结的内联结

许多联结将一个表中的行与另一个表中的行相关联，但有时候需要包含
没有关联行的那些行。

联结包含了那些在相关表中没有关联行的行。这种联结
称为外联结。

SELECT Customers.cust_id, Orders.order_num
FROM Customers INNER JOIN Orders
ON Customers.cust_id = Orders.cust_id;

SELECT Customers.cust_id, Orders.order_num
FROM Customers LEFT OUTER JOIN Orders
ON Customers.cust_id = Orders.cust_id;

SELECT Customers.cust_id, Orders.order_num
FROM Customers RIGHT OUTER JOIN Orders
ON Orders.cust_id = Customers.cust_id;

还存在另一种外联结，就是全外联结（full outer join），它检索两个表中
的所有行并关联那些可以关联的行

SELECT Customers.cust_id, Orders.order_num
FROM Orders FULL OUTER JOIN Customers
ON Orders.cust_id = Customers.cust_id;

###### 使用带聚集函数的联结
SELECT Customers.cust_id,
COUNT(Orders.order_num) AS num_ord
FROM Customers INNER JOIN Orders
ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

SELECT Customers.cust_id,
COUNT(Orders.order_num) AS num_ord
FROM Customers LEFT OUTER JOIN Orders
ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

### Lesson 14 课 组合查询

SQL也允许执行多个查询（多条 SELECT 语句），并将结果作为一
个查询结果集返回。这些组合查询通常称为并（union）或复合查询
（compound query）

任何具有多个
WHERE 子句的 SELECT 语句都可以作为一个组合查询

SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI');

SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';

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
OR cust_name = 'Fun4All';

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


### Lesson 15 插入数据

INSERT INTO Customers
VALUES('1000000006',
'Toy Land',
'123 Any Street',
'New York',
'NY',
'11111',
'USA',
NULL,
NULL);

这种语法很简单，但并不安全，应该尽量避免使用。上面的 SQL语
句高度依赖于表中列的定义次序，还依赖于其容易获得的次序信息

INSERT INTO Customers(cust_id,
cust_name,
cust_address,
cust_city,
cust_state,
cust_zip,
cust_country,
cust_contact,
cust_email)
VALUES('1000000006',
'Toy Land',
'123 Any Street',
'New York',
'NY',
'11111',
'USA',
NULL,
NULL);

不要使用没有明确给出列的 INSERT 语句。给出列能使 SQL代码继续
发挥作用，即使表结构发生了变化。

INSERT INTO Customers(cust_id,
cust_name,
cust_address,
cust_city,
cust_state,
cust_zip,
cust_country)
VALUES('1000000006',
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

SELECT *
INTO CustCopy
FROM Customers;

MariaDB、MySQL、Oracle、PostgreSQL和 SQLite

CREATE TABLE CustCopy AS
SELECT * FROM Customers;

## 16 课 更新和删除数据

UPDATE Customers
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = '1000000005';

UPDATE Customers
SET cust_contact = 'Sam Roberts',
cust_email = 'sam@toyland.com'
WHERE cust_id = '1000000006';

UPDATE Customers
SET cust_email = NULL
WHERE cust_id = '1000000005';

##### 删除数据

DELETE FROM Customers
WHERE cust_id = '1000000006';

如果想从表中删除所有行，不要使用 DELETE 。可使用 TRUNCATE TABLE
语句，它完成相同的工作，而速度更快（因为不记录数据的变动）。

### Lesson 17 创建和操纵表

CREATE TABLE Products
(
prod_id CHAR(10) NOT NULL,
vend_id CHAR(10) NOT NULL,
prod_name CHAR(254) NOT NULL,
prod_price DECIMAL(8,2) NOT NULL,
prod_desc VARCHAR(1000) NULL
);

CREATE TABLE Orders
(
order_num INTEGER NOT NULL,
order_date DATETIME NOT NULL,
cust_id CHAR(10) NOT NULL
);

CREATE TABLE Vendors
(
vend_id CHAR(10) NOT NULL,
vend_name CHAR(50) NOT NULL,
vend_address CHAR(50) ,
vend_city CHAR(50) ,
vend_state CHAR(5) ,
vend_zip CHAR(10) ,
vend_country CHAR(50)
);

CREATE TABLE OrderItems
(
order_num INTEGER NOT NULL,
order_item INTEGER NOT NULL,
prod_id CHAR(10) NOT NULL,
quantity INTEGER NOT NULL DEFAULT 1,
item_price DECIMAL(8,2) NOT NULL
);

ALTER TABLE Vendors
ADD vend_phone CHAR(20);

ALTER TABLE Vendors
DROP COLUMN vend_phone;

DROP TABLE CustCopy;

### Lesson 18 使用视图

视图是虚拟的表。与包含数据的表不一样，视图只包含使用时动态检索
数据的查询。

SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND OrderItems.order_num = Orders.order_num
AND prod_id = 'RGAN01';

，假如可以把整个查询包装成一个名为 ProductCustomers 的虚拟
表，则可以如下轻松地检索出相同的数据：

SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';

与 CREATE TABLE 一样， CREATE VIEW 只能用于创建不存在的视图

删除视图，可以使用 DROP 语句，其语法为 DROP VIEW viewname; 。
覆盖（或更新）视图，必须先删除它，然后再重新创建。

CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND OrderItems.order_num = Orders.order_num;

SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
AS vend_title
FROM Vendors
ORDER BY vend_name;

SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
AS vend_title
FROM Vendors
ORDER BY vend_name;

CREATE VIEW VendorLocations AS
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
AS vend_title
FROM Vendors;

CREATE VIEW VendorLocations AS
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
AS vend_title
FROM Vendors;

SELECT *
FROM VendorLocations;

CREATE VIEW CustomerEMailList AS
SELECT cust_id, cust_name, cust_email
FROM Customers
WHERE cust_email IS NOT NULL;

SELECT *
FROM CustomerEMailList;

SELECT prod_id,
quantity,
item_price,
quantity*item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;

CREATE VIEW OrderItemsExpanded AS
SELECT order_num,
prod_id,
quantity,
item_price,
quantity*item_price AS expanded_price
FROM OrderItems;

SELECT *
FROM OrderItemsExpanded
WHERE order_num = 20008;

### Lesson 19 使用存储过程

EXECUTE AddNewProduct( 'JTS01',
'Stuffed Eiffel Tower',
6.49,
'Plush stuffed toy with the text La
➥Tour Eiffel in red white and blue' );

##### 创建存储过程

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

这个存储过程有一个名为 ListCount 的参数。此参数从存储过程返回一
个值而不是传递一个值给存储过程。关键字 OUT 用来指示这种行为。
Oracle支持 IN （传递值给存储过程）、 OUT （从存储过程返回值，如这里）、
INOUT （既传递值给存储过程也从存储过程传回值）类型的参数。存储
过程的代码括在 BEGIN 和 END 语句中，这里执行一条简单的 SELECT 语
句，它检索具有邮件地址的顾客。然后用检索出的行数设置 ListCount
（要传递的输出参数）。

var ReturnValue NUMBER
EXEC MailingListCount(:ReturnValue);
SELECT ReturnValue;

CREATE PROCEDURE MailingListCount
AS
DECLARE @cnt INTEGER
SELECT @cnt = COUNT(*)
FROM Customers
WHERE NOT cust_email IS NULL;
RETURN @cnt;

SQL Server例子可以像下面这样：
DECLARE @ReturnValue INT
EXECUTE @ReturnValue=MailingListCount;
SELECT @ReturnValue;

CREATE PROCEDURE NewOrder @cust_id CHAR(10)
AS
-- Declare variable for order number
DECLARE @order_num INTEGER
-- Get current highest order number
SELECT @order_num=MAX(order_num)
FROM Orders
-- Determine next order number
SELECT @order_num=@order_num+1
-- Insert new order
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(@order_num, GETDATE(), @cust_id)
-- Return order number
RETURN @order_num;

CREATE PROCEDURE NewOrder @cust_id CHAR(10)
AS
-- Insert new order
INSERT INTO Orders(cust_id)
VALUES(@cust_id)
-- Return order number
SELECT order_num = @@IDENTITY;


### Lesson 20  管理事务处理

使用事务处理（transaction processing），通过确保成批的 SQL 操作要么
完全执行，要么完全不执行，来维护数据库的完整性。

DELETE FROM Orders;
ROLLBACK;


BEGIN TRANSACTION
DELETE OrderItems WHERE order_num = 12345
DELETE Orders WHERE order_num = 12345
COMMIT TRANSACTION

SET TRANSACTION
DELETE OrderItems WHERE order_num = 12345;
DELETE Orders WHERE order_num = 12345;
COMMIT;

SAVEPOINT delete1;

SAVE TRANSACTION delete1;

ROLLBACK TRANSACTION delete1;

ROLLBACK TO delete1;

BEGIN TRANSACTION
INSERT INTO Customers(cust_id, cust_name)
VALUES('1000000010', 'Toys Emporium');
SAVE TRANSACTION StartOrder;
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20100,'2001/12/1','1000000010');

IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder;
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity,
➥item_price)
VALUES(20100, 1, 'BR01', 100, 5.49);
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder;
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity,
➥item_price)
VALUES(20100, 2, 'BR03', 100, 10.99);
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder;
COMMIT TRANSACTION

### Lesson 21 使用游标

游标（cursor）是一个存储在 DBMS 服务器上的数据库查询，
它不是一条 SELECT 语句，而是被该语句检索出来的结果集。在存储了
游标之后，应用程序可以根据需要滚动或浏览其中的数据

 DB2、MariaDB、MySQL和 SQL Server版本。
DECLARE CustCursor CURSOR
FOR
SELECT * FROM Customers
WHERE cust_email IS NULL

Oracle和 PostgreSQL版本：
DECLARE CURSOR CustCursor
IS
SELECT * FROM Customers
WHERE cust_email IS NULL

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


DECLARE @cust_id CHAR(10),
@cust_name CHAR(50),
@cust_address CHAR(50),
@cust_city CHAR(50),
@cust_state CHAR(5),
@cust_zip CHAR(10),
@cust_country CHAR(50),
@cust_contact CHAR(50),
@cust_email CHAR(255)
OPEN CustCursor
FETCH NEXT FROM CustCursor
INTO @cust_id, @cust_name, @cust_address,
@cust_city, @cust_state, @cust_zip,
@cust_country, @cust_contact, @cust_email
WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM CustCursor
INTO @cust_id, @cust_name, @cust_address,
@cust_city, @cust_state, @cust_zip,
@cust_country, @cust_contact, @cust_email
END
CLOSE CustCursor


CLOSE CustCursor

CLOSE CustCursor
DEALLOCATE CURSOR CustCursor

### Lesson 22 高级 SQL 特性




