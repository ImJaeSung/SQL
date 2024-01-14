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
