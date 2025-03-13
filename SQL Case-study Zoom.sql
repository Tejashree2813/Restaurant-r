--Print the employees with the job title “Sales Rep”. 

select  firstName from employees where jobTitle ='Sales Rep'


--  Find the total number of employees from the 'employees’ table and alias it as "Total_Employees".
select count(*) as total_employees from employees 

-- How many customers belongs to Australia? also alias it as "Australia_Customers".
select count(*) as Australia_Customers
from customers
where country = 'Australia'


--  Print the quantity in stock for "Red Start Diecast" product vendors with product line is "Vintage Cars" from the table "products".

select quantityInStock from products where productLine ='Vintage Cars' and productVendor ='Red Start Diecast'


-- Count the total number of orders that has not been shipped yet in the "orders" table. 

select count(*) as total_orders from orders where status <> 'Shipped'


--  Count the entries in "orderdetails" table with "productCode" starts with S18 and "priceEach" greater than 150.

select count(*) as order_count from orders o join orderdetails o1 on o.orderNumber = o1.orderNumber join products p on p.productCode = o1.productCode
where o1.priceEach >150 and p.productCode like 'S18%'


-- What are the top three countries which have the maximum number of customers?

select count(*)as count_customers,country  from customers 
group by country
order by count_customers DESC


--   What is the average credit limit for Singapore from "customers" table?

select avg(creditLimit) as avg_credit from customers where city = 'Singapore'


--  What is the total amount to be paid by the customer named as “Euro+ Shopping Channel”?
-- You need to use the “customers” and “payments” tables to answer this question.

select sum(p.amount) as total_amount from payments p join customers c on p.customerNumber = c.customerNumber
where customerName ='Euro+ Shopping Channel'

-- Which month has recieved the maximum aggragated payments from the customers? 
select month(paymentDate),max(amount) as amount from payments
group by paymentDate
order by amount DESC



-- What is the aggregated value of the payment recieved from that month?

--120166.58 for march


--  What is the shipped date of the maximum quantity ordered for "1968 Ford Mustang" product name?


select shippedDate from orders  
where orderNumber = ( 
    select orderNumber 
from( 
select quantityOrdered, orderNumber from orderdetails  
where productCode = ( 
select productCode 
from products 
where productName = '1968 Ford Mustang' 
) 
) max_order_no 
where quantityOrdered = ( 
select max(quantityOrdered) 
from orderdetails  
where productCode = ( 
select productCode 
from products 
where productName = '1968 Ford Mustang' 
) 
) 
);

--  Inner join:  What is the average value of credit limit corresponds to the customers which have been contacted by 
--the employees with their office located in “Tokyo” city? 

select AVG(creditLimit) as avg_credit
from offices o join customers c on o.country = c.country
where o.office_city = 'Tokyo'

-- Outer Join: What is the name of the customer which has paid the lowest amount to the company. 

select c.customerName,amount from customers c right outer join  payments p
on c.customerNumber=p.customerNumber where p.amount =(select min(p.amount) as amount from payments p)

-- Outer Join: What is the city of the employee whose job title is "VP Marketing" ? 

select o.office_city from offices o
right outer join employees e on e.officeCode =o.officeCode
where e.jobTitle ='VP Marketing'

-- What is the name of the customer who belongs to ‘France’ and has the maximum creditLimit among the customers in France?

select customerName,max(creditLimit) as credit from customers where country ='France' 
group by customerName
order by credit DESC


-- What will be the remaining stock of the product code that equals ‘S18_1589’ if it is sent to all the customers who have demanded it?

select quantityInStock from products where productCode ='S18_1589'

select top 1 * from products

--  What is the average amount paid by the customer 'Mini Gifts Distributors Ltd.'?

select avg(p.amount) as amount from payments p join customers c on p.customerNumber = c.customerNumber
where customerName ='Mini Gifts Distributors Ltd.'



