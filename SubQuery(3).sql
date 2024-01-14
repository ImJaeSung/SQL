select * from buy;

# 내가 원하는 컬럼을 가지고 온다
select num
	, mem_id 
from buy;

# 내가 원하는 컬럼에서 조건을 걸어 원하는 값을 가지고 온다
select * from buy
where price > 200;

# 원하는 조건을 여러개 추가
select * from buy
where price > 80
and amount > 2;

select * from buy
where price > 50
and amount > 2
and group_name = '디지털';

select * from buy
where price > 50
or amount > 2
or group_name = '디지털';

select num from buy
where price > 50
or amount > 2
or group_name = '디지털';

## groupby 이용하여 집계함수 사용하기
## sum, avgm min, max, count, count(distinct) : unique count (중복 값 제거)
## 집계함수라는 것은 groupby 하게 되면 -> 결과값은 집계함수 값으로 나온다.
## 기존 테이블과 달라진다. (중요!)

# groupby를 사용해야 집계함수를 이용할 수 있다.
-- select mem_id, sum(price) from buy; # error
select mem_id, 
	sum(price) 
from buy
group by mem_id;

## 여러 개 추가하자
# groupby를 통해 기준 컬럼을 정하고 -> 해당 컬럼으로 다른 컬럼들의 집계함수를 만든다!
select mem_id
	, sum(price)
	, sum(amount) 
from buy
group by mem_id;

select mem_id
	, max(price)
    , min(amount) 
from buy
group by mem_id;

select mem_id
	, avg(price)
	, avg(amount) 
from buy
group by mem_id;

select mem_id
	, sum(price)
    , sum(amount)
    , count(mem_id)
    , count(distinct(mem_id)) 
from buy
group by mem_id;

# groupby 2개 이상 해보기
select mem_id
	, prod_name
    , sum(price)
    , sum(amount) 
from buy
group by mem_id, prod_name;

select mem_id
	, prod_name
    , sum(price)
    , sum(amount) 
from buy
group by prod_name, mem_id;

## 변수 추가해서 진행
select mem_id as '회원아이디' # as를 써서 컬럼명 변경
	, sum(price*amount) '총 구매금액' # as를 쓰지 않고도 바로 컬럼명을 변경할 수 있다.
from buy
group by mem_id;

# groupyby를 하지 않아도 테이블 전체에 대한 집계함수를 원하는 경우
select sum(price) from buy;
select avg(amount) from buy;

## count 중복이랑 중복되지 않은 것 
select count(*) from buy; # count는 null 값을 제외하고 카운트한다.
select count(group_name) from buy;
select count(distinct(group_name)) from buy;

# groupby를 통해서 조건을 또 걸 수 있다.(having)
-- select mem_id
-- 	, sum(price*amount) as '총 구매액'
-- from buy
-- group by mem_id
-- where sum(price*amount) > 1000; ## error

## 총 구매금액이 1,000을 넘는 사람
## groupby는 where절이 아니라 having절을 사용해야 한다.
## grouby의 조건은 having절과 함께 사용

select mem_id
	, sum(price*amount) as '총 구매액'
from buy
group by mem_id
having sum(price*amount) > 1000;

select mem_id
	, sum(price*amount) as '총 구매액'
from buy
group by mem_id
having sum(price*amount) > 1000
order by sum(price*amount) desc; # desc 내림차순 asc 오름차순

## 새로 지정한 변수이름으로 조건을 걸 수 있다.
select mem_id
	, sum(price*amount) as total
from buy
group by mem_id
having total > 1000
order by total desc;

