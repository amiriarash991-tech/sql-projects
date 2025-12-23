CREATE VIEW LowStockProducts AS        ------------------view for Table
SELECT ProductID, ProductName, unitsinstock
FROM Products
WHERE unitsinstock < 100;
 go

  
Create View Largeorders As 
select orderid,customerid,orderdate,totalamount
from orders
where totalamount > 500;
go
 
 ----------Inner join

 select customers.customername,orders.orderid,products.productname,orderdetails.quantity,
 products.price,
 (orderdetails.quantity * products.price) as totalprice
 from customers
 inner join orders on customers.customerid = orders.customerid
 inner join orderdetails on orders.orderid = orderdetails.orderid
inner join  products on orderdetails.productid = products.productid
order by orders.orderdate desc;


use onlinestore
go

 

select products.productid,products.productname  
from products
right join orderdetails
on products.productid = orderdetails.orderdetailsid

select * from customers,products,orderdetails



select customers.customername,orders.orderid
from customers
left join orders
on customers.customerid = orders.customerid


select customers.customername,orders.orderid,products.productid,orderdetails.quantity
from customers
inner join orders
on customers.customerid = orders.orderid
inner join orderdetails 
on orders.orderid = orderdetails.orderid
inner join products
on orderdetails.productid = products.productid


SELECT 
    Products.ProductName,
    SUM(OrderDetails.Quantity) AS TotalQuantity
FROM Products
INNER JOIN OrderDetails
    ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName
HAVING SUM(OrderDetails.Quantity) > 6;



--------subquerys

select customername 
from customers
where customerid in(
select customerid from orders
group by customerid 
Having count(orderid) < 2
)

 select productname 
 from products
 where productid in (
 select productid from orderdetails
 group by productid
 having sum(quantity) > 3
 );
 

  select productname,price
 from products
where price > (
select avg(price)
from products
);

SELECT ProductName, UnitsInStock
FROM Products
WHERE UnitsInStock > (
    SELECT MAX(Quantity)
    FROM OrderDetails
);


select productname,price 
from products
where  price > (select avg(price) from  products
where  price < 20
);

------not exists
select  productname
from products
where not exists(
select 1 
from orderdetails
where orderdetails.productid = products.productid
);

 -------ALL
 select productname,price
 from products
 where price > ALL(
 select price 
 from products
 where price < 400
 );
 -----------------------
SELECT CustomerName
FROM Customers c
WHERE CustomerID IN (
    SELECT o.CustomerID
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE od.ProductID IN (
        SELECT ProductID
        FROM Products
        WHERE Price < (SELECT MAX(Price) FROM Products)
    )
);

select productname
from products
where productid in(
select  orderdetails.productid
from orders
join orderdetails on orders.orderid = orderdetails.orderid
group by orderdetails.productid,orders.customerid
having count(*) < 2
);
 
----------------function table
create function dbo.Getcustomerorders(@customerid int)
returns table 
as 
return 
(
   select orderid,orderdate,totalamount
   from orders
   where  customerid = @customerid
);

select * from dbo.getcustomerorders(1)