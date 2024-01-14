-- select 문
-- sql 문법 구조
-- select 열 이름 from 테이블 이름 where 조건식 group by 열 이름 having 조건식, order by 열이름 limit 몇개까지 출력될지
-- select 문을 같이 배울 예정 from where 데이터을 찾는 정도를 배울 예정

-- select 열 이름만 가지고 오는 문법 -> 얘만 사용하면 열이름 속성의 튜플값만 가지고 옴
select * from member;
select mem_id, mem_name from member;

select mem_name, mem_id, phone1 from member; -- 열 자체의 값의순서를 바꿀 수 있음
select * from market_db.member;

-- where 조건 절에 들어갈 문법 학습
-- select 열이름 from 테이블 이름 where 조건식
select * from member where mem_name = '에이핑크';

select mem_id, addr from member where mem_name = '에이핑크';

-- addr 기준으로 조건식을 걸면
select mem_id, addr from member where addr = '전남';

-- where 조건에서 연산자를 사용하자 : 관계연산자, 논리연산자
-- 관계연산자는 대소비교의 개념으로 >, <, >=, <=, = 등이 있다.
-- 키가 165이상인 경우의 데이터만 추출하는 것
-- 문자열은 '' 따옴표로 넣어야 된다. 숫자는 그냥 적어도 된다

select * from member where height >= 165;

-- 여러 연산자를 같이 섞어서 해보기
-- 논리연산자 and, or 조건 등이 있다.
-- and 조건을 이용하자
-- 키가 165이상이고, 멤버수가 6명이상인 경우 
-- and 둘 다 참인 값

select * from member where height >= 165 and mem_number >= 6;

-- or 조건

select * from member where height >= 165 or mem_number >= 6;

-- in 조건문 조건식에서 여러 값이 있을 때 그 값이 있는지 없는지
select * from member where addr in ('서울', '경기');

-- like 문법
-- 문자열의 일부 검색해서 내가 원하는 문자열이 있는 값을 출력한다.
-- 신제품_abc_ddf 신제품이라는 값만 출력을 해서 보고싶다 라고 하면 like 문을 이용해서 신제품을 적고 출력
-- like '원하는 값%' 그 뒤는 어떤 값이어도 괜찮다.
select * from member where mem_name like '마%';
select * from member where mem_name like '%무';

select * from member where mem_name like '__무';

select * from member where mem_name like '__핑크';

-- 연습
select * from buy;
select mem_id, prod_name from buy where group_name = '디지털';
select * from buy where amount >= 5;
select * from buy where price >= 100;

select * from buy where amount >= 5 and price >= 100;
select * from buy where amount >= 5 or price >= 100;