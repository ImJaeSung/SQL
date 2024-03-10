select * from customers;
select * from products;
select * from employees;
select * from productlines;
select * from orders;

-- Q1. 오더 테이블 중 커스터 넘버가 121, 145, 278, 363 인 사람들의 오더번호와 오더날짜, status?
select orderNumber
	, orderDate
    , status
    from orders
	where customerNumber in (121, 145, 278, 363);
    
-- Q2. Q1의 고객의 customerName, Phone, country, creditLimit은?
select customerName, phone, country, creditLimit from orders o
	left outer join customers c
    on c.customerNumber = o.customerNumber
    where o.customerNumber in (121, 145, 278, 363);

-- Q3. Q2의 고객들의 product_code 는?
select * from orderdetails;

select o.customerNumber, od.productCode from orders o
	left outer join customers c
    on c.customerNumber = o.customerNumber
    left outer join orderdetails od
    on o.orderNumber = od.orderNumber
    where o.customerNumber in (121, 145, 278, 363);

-- Q4. product name Ford 상품들의 구매한 고객들 평균 creditLimit은 어떻게 될까?
select * from orders; # customerNumber(o+c), orderNumber(o+od)
select * from orderdetails; # productCode(od+p), orderNumber(o+od)
select * from customers; # customerNumber(o+c), creditLimit
select * from products; # productName, productCode(od+p)

select distinct(c.customerNumber), c.creditLimit from customers c
	left outer join orders o
    on c.customerNumber = o.customerNumber
	left outer join orderdetails od
    on o.orderNumber = od.orderNumber
    left outer join products p
    on od.productCode = p.productCode
    where p.productName like '%Ford%';
    
select avg(credit.creditLimit) acl from (
	select distinct(c.customerNumber), c.creditLimit from customers c
		left outer join orders o
		on c.customerNumber = o.customerNumber
		left outer join orderdetails od
		on o.orderNumber = od.orderNumber
		left outer join products p
		on od.productCode = p.productCode
		where p.productName like '%Ford%'
	) as credit;
    
-- Q5. 주문이 shipped (order status shipped 이 아닌 사람들)의 country 카운팅?
select * from customers;
select * from orders; # status

select c.country, count(c.country) from customers c
	left outer join orders o
    on c.customerNumber = o.customerNumber
    where status != 'Shipped'
    group by c.country;