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