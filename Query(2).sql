select * from member;
select * from buy;

-- select 사용하는 서브쿼리 학습
-- select 문을 가지고 하나의 요구조건을 만들어서 내가 원하는 데이터 추출 가능
-- 쿼리의 성능이나 시간, 효율적인 쿼리를 짜는 것도 중요함
-- 쿼리가 효율적이지 못하면 작업 자체가 안될수도 있음
-- 서브쿼리나 조인 등 작동원리를 잘 이해해야 효율적인 쿼리를 작성 가능

-- 내가 원하는 데이터를 추출하는데 원하는 요구조건이 있다.
-- 내가 원하는 요구조건 등을 모두 검색하게 만들면 비효율이 발생할 수 있다.
-- ex) 하나씩 인덱스를 다 찾아봐서 그 인덱스 중에 값을 비교해서 출력
-- 데이터가 100만개 라고하면 100만개를 다 봐서 내가 원하는 요구 조건이랑 맞으면 select로  가지고 온다.
-- 일단 내가 원하는 테이블만 미리 만들어서 쿼리문에 알려주면 전체를 다 볼 필요없음
-- 1차적으로 내가 원하는 테이블 내에서만 검색해서 찾자!
-- 비유: 운동장에서 실핀 하나 찾아줘 -> 운동장에서 축구골대 주변에서 실핀 찾아줘

-- 서브쿼리 만들기
select * from member;

-- 에이핑크에서 키가 164이상인 멤버 추출
select mem_id, mem_name, height from member where mem_name = '에이핑크' and height >= 164;

-- 에이핑크 멤버의 키보다 더 큰 멤버만 추출
select mem_id, mem_name, height from member where height > (select height from member where mem_name = '에이핑크');

-- where 조건 안에서 select : 내가 원하는 테이블들만 가지고와서 비교하여 출력
-- 서브쿼리의 경우 조인과 함께 사용
-- 내가 원하는 테이블들을 결합해서 작동하는데, 테이블 전체를 가지고오면 무거워짐
-- 서브쿼리 형태로 내가 원하는 테이블 형태로 정리해서 1차로 같이 조인하거나
-- where 조건 비교 등을 하면 더 효율적인 쿼리를 작성 가능

-- 소녀시대: 서울 addr, 소녀시대와 같은 addr인 멤버의 아이디와 네임을 출력해보자
select mem_id, mem_name, addr from member where addr = (select addr from member where mem_name = '소녀시대');

-- 소녀시대의 phone1와 동일한 멤버 아이디와 이름을 서브쿼리를 출력해보자
select mem_id, mem_name, phone1, phone2 from member where phone1 = (select phone1 from member where mem_name = '소녀시대');

-- 서브쿼리가 만약 두 개의 테이블 구조로 이루어져 있다면?
select mem_id, mem_name, phone1 from member where phone1 = (select phone1 from member where mem_name = '소녀시대');

-- select의 여러가지 문법
-- select
-- from
-- where
-- group by
-- having
-- order by
-- limit

-- 위의 순서대로 query 순서를 지켜야함!

-- order by : 정렬 
-- 내림차순 또는 오름차순으로 정렬하고, 정렬에 대한 기준이 1개인가 2개인가도 정할 수 있음
-- 날짜 순으로 데이터를 정렬
select * from member order by debut_date;

-- 디폴트가 오름차순
-- 오름차순 ASC 내림차순 DESC
select * from member order by debut_date DESC;

-- 구문 에러가 나는 경우
select * from member where addr = "서울" order by debut_date;
select * from member order by debut_date where addr = "서울";
-- where 절 앞에 order by 사용하면 문법 에러 발생

-- 내림차순, 오름차순 2개 이상으로 지정
select * from member where addr = '서울' order by debut_date DESC, height ASC;
-- 두 개 이상의 컬럼을 조건 기준으로 만들 때, 두 개를 나누어서 사용하기

select * from member where addr = '서울' order by height ASC, debut_date DESC;
-- 앞 뒤 순서에 따라 먼저 쓴 컬럼이 기준이 된다.

-- limit : 출력 개수 제한
-- limit 시작, 개수
-- ex) limit 1, 3 : 1번부터 시작해서 3개 출력
select * from member limit 1, 3;

select mem_id, mem_name
from member
where addr = '서울'
order by debut_date DESC
limit 1;

-- distinct : 중복제거
-- 속성 값의 중복을 제거하는 경우

-- addr 중복제거하기
select distinct addr from member;

-- 중복 제거 옆에 다른 속성 붙으면 어떻게 될까?
select distinct addr, debut_date from member;
select distinct addr, phone1 from member;

-- 만약 옆에 붙은 새로운 속성으로 인해 유니크한 값이 되면, 첫번째 속성에 대해서는 중복 제거가 유지되지 않음
-- 추가한 속성도 중복이라면 중복이 제거되어서 출력

-- group by절
-- 그룹을 묶어 내가 원하는 데이터에서 어떤 그룹을 만들어서 해당 그룹의 통계치를 보려함
-- 통계치 : sum, avg, min, max, count, count(distinct)
-- 요약 통계치만 데이터를 보여주고 싶은 경우 
-- 테이블이 여러가지로 나누어져 있으면 미리 group by로 만들어서 테이블을 만들고
-- 해당 테이블에서 다른 테이블과 조인해서 작업 가능

select * from buy;

-- 어떤 컬럼을 기준으로 묶어서 요약을 볼 것인가? : mem_id
select mem_id, sum(amount) from buy group by mem_id;
select mem_id, sum(amount), AVG(price) from buy group by mem_id;

-- 통계치로 묶지 않은 속성이 들어간다면? 에러
select mem_id, sum(amount), AVG(price), prod_name from buy group by mem_id;

-- group by로 묶을 경우는 수치형 데이터를 기준으로 요약통계치를 낼 수 있는 경우가 대부분
select mem_id, sum(amount), AVG(price), count(prod_name) from buy group by mem_id;

-- 통계치 문법을 사용하지 않고, 그냥 컬럼만 사용? 에러
select mem_id, amount, price, prod_name from buy group by mem_id;

-- group by를 사용하지 않고 min, max 사용 가능
select max(debut_date) from member;
select min(debut_date) from member;

-- 그냥 count 사용하면 중복 포함
select count(addr) from member; -- 중복 포함된 카운팅
select count(distinct addr) from member; -- 중복 제거된 카운팅

-- 컬럼끼리 곱해서 새로운 컬럼을 만들 수도 있음
select (price*amount) from buy;

-- group by로도 표현 가능
select mem_id, sum(price*amount) from buy group by mem_id;