select * from customers;

-- 주문 테이블을 통해서 join과 함께 다른 컬럼을 계산해보기
select * from orders; # 주문번호, 주문날짜, 요청, 배송날짜, 배송상태
select * from orderdetails; # 가격, 수량, 상품코드

select * from orders
	where status != 'Shipped';

## 수량 * 단가 = 총매출액
select * from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber;
    
select o.orderNumber
	, (od.quantityOrdered*od.priceEach)
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber;

select o.orderNumber
	, (od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    where status = 'Shipped'; # 배송이 다 된 상태의 매출(환붍x)
    
# 검증 : 전체 매출액 = 배송완료 매출액 + 기타 상태 매출액
select sum(bb.total_sales) from (select o.orderNumber
	, (od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    where status = 'Shipped') bb;  # 배송완료 매출액

select sum(bb.total_sales) from (select o.orderNumber
	, (od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    where status != 'Shipped') bb; # 기타상태 매출액
    
select sum(bb.total_sales) from (select o.orderNumber
	, (od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber) bb; # 전체 매출액
    
## groupby를 통해서 요약 값을 확인해보자
## 전체 매출액을 orderdate에 따라서 확인해보자
select o.orderDate
	, sum(od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    group by o.orderdate
    order by 1;

## 월별로 매출을 뽑고 싶다.
select substring(o.orderDate, 1, 7)
	, sum(od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    group by substring(o.orderdate, 1, 7)
    order by 1;

## 연도별 매출 뽑기
select substring(o.orderDate, 1, 4)
	, sum(od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    group by substring(o.orderdate, 1, 4)
    order by 1;
    
## 검증 : 누락된 데이터가 없는지 (연도별로 묶은것이 실제 전체 sum 과 맞는지 데이터 값 비교 진행)
select sum(bb.total_sales) from (select substring(o.orderDate, 1, 4)
	, sum(od.quantityOrdered*od.priceEach) as total_sales
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    group by substring(o.orderdate, 1, 4)
    order by 1) bb; # 9604190.67
    
## 주문과 고객의 관계를 이용해서 데이터 살펴보기!
select * from orders;

# 전체 순 주문자수 구하기
# 실제 주문한 사람이 중복값이 있는지 체크하기
select count(customerNumber)
	, customerNumber
    from orders
    group by customerNumber
    having count(customerNumber)>1;

# 중복을 제거한 순 주문자의 수
select count(distinct customerNumber) from orders; # 98 
select count(customerNumber) from orders; # 326

# 월별 구매자수, 주문건수를 비교하기
# 자수, 건수 -> 집계로 수를 계산
select substr(orderDate, 1, 7) mm 
	, count(orderNumber) as od
	, count(customerNumber) as cus
	from orders
    group by mm
    order by 1;

select substr(orderDate, 1, 7) mm 
	, count(distinct orderNumber) as od  # 한 사람이 여러 번 주문할 수 있기 때문에 중복제거해서 보는 것이 정확
	, count(distinct customerNumber) as cus
	from orders
    group by mm
    order by 1; 
    
## 고객 한 명당 얼마나 금액을 지불하는지에 대한 ANV 값 계산
# 한 사람의 고객이 주문당 얼마나 많은 비용을 지불하는가?
# 전체 주문액 / 실 주문자수 나누면 amv 값 계산 가능
select substring(o.orderDate, 1, 7)
	, sum(od.quantityOrdered*od.priceEach) as total_sales
    , sum(od.quantityOrdered*od.priceEach) / count(distinct o.customerNumber) as amv
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    group by substring(o.orderDate, 1, 7);
    
select max(bb.amv) from(select substring(o.orderDate, 1, 7)
	, sum(od.quantityOrdered*od.priceEach) as total_sales
    , sum(od.quantityOrdered*od.priceEach) / count(distinct o.customerNumber) as amv
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    group by substring(o.orderDate, 1, 7)) bb; # 45313.167143

select bb.mm
	, bb.amv
    from(select substring(o.orderDate, 1, 7) as mm
	, sum(od.quantityOrdered*od.priceEach) as total_sales
    , sum(od.quantityOrdered*od.priceEach) / count(distinct o.customerNumber) as amv
		from orders as o
		left outer join orderdetails as od
		on o.orderNumber = od.orderNumber
		group by substring(o.orderDate, 1, 7)) bb
    where bb.amv = (select max(bb_inner.amv)
					from(select sum(od.quantityOrdered*od.priceEach) / count(distinct o.customerNumber) as amv
						from orders as o
                        left outer join orderdetails as od
                        on o.orderNumber = od.orderNumber
                        group by substring(o.orderDate, 1, 7)) bb_inner);

## 주문 수로 나누면 1주문당 매출 금액이 나올 수 있다.

## customer 정보를 추가로 확인하고 싶다!
select * from customers;

## 주문한 사람의 사는 나라가 어디인지를 같이 확인해보자
select o.orderDate
	, o.orderNumber
	, od.quantityOrdered*od.priceEach as total_sales
    , o.customerNumber
    , c.country
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    left outer join customers as c
    on o.customerNumber = c.customerNumber;
    
## 국가별로 매출을 sum 해서 가장 높은 매출을 가지고 있는 나라를 어디인가?
select bb.coun 
	, sum(bb.total_sales)
	from(select o.orderDate as od
	, o.orderNumber as orn
	, od.quantityOrdered*od.priceEach as total_sales
    , o.customerNumber as cun
    , c.country as coun
    from orders as o
	left outer join orderdetails as od
    on o.orderNumber = od.orderNumber
    left outer join customers as c
    on o.customerNumber = c.customerNumber) bb
    group by bb.coun
    order by 2 desc;