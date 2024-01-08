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

# insert, delete, create table
## create table 예를 들어 buy 테이블을 가지고 학습 중 -> create table buy : 같은 테이블을 하나 더 만든다.
## insert 란? buy 테이블에 들어가 있는 값을 우리도 넣는다.

## 테이블 하나 만들기!
create table bda_sql (mem_id int, mem_name char(5), age int);
select * from bda_sql;

## insert 문으로 값을 넣기
insert into bda_sql values(1, '홍길동', 20);
select * from bda_sql;
-- insert into bda_sql values(2, '박길동'); # error 매치가 안되니 매치를 해서 값을 추가해야 한다.

##매치를 통해 두 개의 값만 넣어보자!
insert into bda_sql(mem_id, mem_name) values(2, '박길동');

## auto_increment
## 특정 열을 추가할 때 자동으로 index를 만들어서 추가해 주는 것!
## mem_id 가 숫자형으로 1, 2, 3, 4 증가하는데 계속 insert 사용해야 하는데
## insert auto_increment 사용하면 자동으로 다음 번에는 3이면 -> 4가 값에 입력된다.alter
create table bda_sql2(
	mem_id int auto_increment primary key,
    mem_name char(5),
    age int);
select * from bda_sql2;

insert into bda_sql2 values(null, '홍길동', 20);
insert into bda_sql2 values(null, '박길동', 21);
insert into bda_sql2 values(null, '정길동', 23);
select * from bda_sql2;    

## insert 할 때 mem_id를 1000부터 시작하고 싶다.
alter table bda_sql2 auto_increment = 1000; # auto_increment 값을 바꿀 때 사용하는 문법
insert into bda_sql2 values(null, '이길동', 25);
select * from bda_sql2;

## insert 문을 이용해서 하나씩 데이터의 값을 넣었다.
## 기존 테이블의 값을 이용해서 바로 새로운 테이블을 만들 수 있다.
## insert로 값을 계속 넣었는데, 이번에는 다른 테이블에 있는 값을 넣기
create table bda_sql3(
	mem_id int auto_increment primary key,
    mem_name char(5),
    age int);
select * from bda_sql3;

insert into bda_sql3 select mem_id, mem_name, age from bda_sql2;
select * from bda_sql3;

# 후 처리후 현재 테이블에 값을 넣는 것도 가능
select mem_id, mem_name, age from bda_sql2;
select mem_name, avg(age) from bda_sql2
group by mem_name;

