create database onlinestore
go

use onlinestore
go


create table roles(
roleid int identity(1,1) primary key,
rolename nvarchar(50) not null
)


create table users(
useid int not null identity(1,1) primary key,
username nvarchar(50) not null unique,
password nvarchar(100) not null,
role nvarchar(30) not null
);
go



 
create table customers(
customerid int not null identity(1,1),
customername nvarchar(50),
Email nvarchar(100),
address nvarchar(100),
phone nvarchar(50)
 
constraint pk_customer primary key(customerid),
constraint uq_email unique(email)
);
go

create table categories(
categoryid int not null identity(1,1),
categoryname nvarchar(50) not null,
Description nvarchar(100),

constraint pk_category primary key(categoryid)
);
go

create table products(
productid int not null identity(1,1),
productname nvarchar(50),
Description nvarchar(100),
price decimal(10,2) not null,
unitsinstock int not null,
categoryid int not null,

constraint pk_product primary key(productid),
constraint fk_category foreign key  (categoryid) references categories(categoryid)
);
go


create table orders(
orderid int not null identity(1,1) primary key,
customerid int,
orderdate datetime not null,
shipaddress nvarchar(50),
totalamount money not null,

constraint fk_customer foreign key (customerid) references customers(customerid)
);
go


 create table OrderDetails(
 orderdetailsid int not null identity(1,1) primary key,
 orderid int not null,
 productid int not null,
 Quantity int not null,
 Unitprice decimal(10,2) not null,

 constraint fk_order foreign key (orderid) references orders(orderid),
 constraint fk_product foreign key(productid) references products(productid)
 );
 go

CREATE TABLE payment(
    paymentid INT IDENTITY(1,1) PRIMARY KEY,
    orderid INT NOT NULL,
    paymentType NVARCHAR(50),
    paymentDate DATETIME,
    Amount DECIMAL(10,2),

    CONSTRAINT fk_order_payment FOREIGN KEY(orderid)
        REFERENCES orders(orderid)
);
GO

----roles
INSERT Into roles(rolename)
values
('admin'),
('customer'),
('user'),
('manager'),
('staff');
go


--users
insert into users(username,password,role)
values
('admin', 'admin123','admin'),
('arash','arashpass','customer'),
('sara','sarapass','customer'),
('staff1','staffpass','staff')
;
go





insert into customers (customername,email,address,phone)
values
('Arash Amiri','amiriarash991@gmil.com','karaj,Iran','09031292938'),
('Sara Mohammadi','sara.mohammadi@example.com','vanak,Tehran,Iran','+989132345678'),
('Reza Hosseini','reza.hosswini@example.com','shahryar,Tehran,Iran','+983456789'),
('Neda karimi','neda.karimi@example.com','shahrak gharb,Tehran,Iran','+989114567890'),
('Ali Rahimi','ali.rahimi@example.com','poonak,Tehran,Iran','+989105678901')
  
 

INSERT INTO categories (categoryname, Description)
VALUES
('Electronics', 'Mobile phones, laptops, and gadgets'),
('Clothing', 'Men and women clothing items'),
('Books', 'Fiction, non-fiction, educational books'),
('Home & Kitchen', 'Appliances and kitchenware'),
('Sports', 'Sports equipment and clothing');

insert into products(productname,Description,price,unitsinstock,categoryid)
values
 ('iPhone 15', 'Latest Apple smartphone', 1200.00, 50, 1),
('Samsung Galaxy S23', 'Flagship Samsung phone', 1000.00, 40, 1),
('MacBook Pro 16"', 'Apple laptop with M2 chip', 2500.00, 20, 1),
('Nike Air Max', 'Men''s running shoes', 150.00, 100, 2),
('Adidas T-shirt', 'Cotton sports t-shirt', 35.00, 200, 2),
('The Alchemist', 'Novel by Paulo Coelho', 15.00, 150, 3),
('Atomic Habits', 'Self-help book by James Clear', 20.00, 120, 3),
('Blender', 'Kitchen appliance for smoothies', 80.00, 60, 4),
('Non-stick Frying Pan', 'Cookware for easy cooking', 45.00, 70, 4),
('Yoga Mat', 'Eco-friendly yoga mat', 30.00, 90, 5),
('Football', 'Standard size football', 25.00, 60, 5);





-- Orders
INSERT INTO orders (customerid, orderdate, shipaddress, totalamount)
VALUES
(1, '2025-12-01', 'Ferdows, Karaj, Iran', 1450.00),
(2, '2025-12-02', 'Shahrak Gharb, Tehran, Iran', 155.00),
(3, '2025-12-03', 'Vanak, Tehran, Iran', 2520.00),
(4, '2025-12-04', 'Shahr-e Rey, Tehran, Iran', 35.00),
(5, '2025-12-05', 'Ferdows, Karaj, Iran', 55.00);


-- OrderDetails
INSERT INTO OrderDetails (orderid, productid, Quantity, Unitprice)
VALUES
(1, 1, 1, 1200.00), -- iPhone 15
(1, 4, 1, 150.00),  -- Nike Air Max
(1, 6, 2, 15.00),   -- The Alchemist
(2, 5, 4, 35.00),   -- Adidas T-shirt
(3, 3, 1, 2500.00), -- MacBook Pro
(3, 10, 1, 30.00),  -- Yoga Mat
(4, 6, 1, 15.00),   -- The Alchemist
(5, 11, 2, 25.00);  -- Football


 
INSERT INTO payment (orderid, paymentType, paymentDate, Amount)
VALUES
(1, 'Credit Card', '2025-12-01', 1450.00),
(2, 'Cash on Delivery', '2025-12-02', 155.00),
(3, 'Credit Card', '2025-12-03', 2520.00),
(4, 'Online Payment', '2025-12-04', 35.00),
(5, 'Credit Card', '2025-12-05', 55.00)

----------------------
use onlinestore
go

Alter Table orders 
Add orderstatus nvarchar(20) default 'pending';


Alter Table payment
add paymentstatus nvarchar(20) default 'pending';


create unique index IX_unique_email on customers(email)

create unique index IX_unique_username on users(username)

alter table users
add roleid int

Alter table users
Add constraint  fk_users_role foreign key(roleid) references roles(roleid)










 









 
