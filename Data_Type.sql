## SQL의 다양한 문법을 배우기!
## 자료형
## 정수, 문자, 실수, 날짜, 자료형 변환, 변수 등
## 자료형은 필수적으로 꼭 알고 있어야 한다.
## 자료형 내에도 다양한 범위와 형식이 있다.
## 데이터가 적재되고 쌓이는 값들을 데이터 형식으로 잘 지정해서 효율적으로 지정해야한다.

## 정수형 int 바이트 수 숫자 범위들
## Tinyint 1 범위 : -3자리수 +3자리수 
## smallint 2 범위 : -5자리수 +5자리수 
## int 4 범위 : -억단위 +억단위
## bigint 8 범위 : +-조, 경단위

create table bda_sql6(
	tinyint_col tinyint,
    small_col smallint,
    int_col int,
    bigint_col bigint);

select * from bda_sql6;

insert into bda_sql6 values (123, 12345, 12345678, 1234567891011);

## 범위를 넘어가는 경우 
-- insert into bda_sql6 values (12345, 12345, 12345678, 1234567891011); # error

## 0부터 시작하게 지정
create table bda_sql7(
	tinyint_col tinyint unsigned); -- 0부터 시작한다 라는 조건은 unsigned
    
select * from bda_sql7;

insert into bda_sql7 values(123);

## 문자형 
## 데이터 형식
## char(개수) 바이트 수 1~255
## varchar(개수) 바이트 수 1~16383

## char(3) 3개 글자 고정길이 문자 
## char(10) 10개는 확보가 되고 그 안에서 2개 오건 3개가 들어오건 나머지는 낭비하면서 데이터를 쌓는다.
## varchar(10) 10개 글자 가변형 
## 만약 varchar(10) 데이터가 3개 들어오거나 4개 들어오면 해당 길이만큼만 사용한다.

create table bda_sql10(
	mem_id varchar(10));

select * from bda_sql10;

insert into bda_sql10 values('안녕하세요');

## 대량의 리뷰 데이터 타입 등은
## Text Text, longText

## Blob 형식 동영상 등
## Blob, LongBlob

## 실수형
## Float 바이트 수 4, 소수점 아래 7자리까지 표현
## Double 바이트 수 8, 소수점 아래 15자리까지 표현

## 날짜형
## Date 날짜만 저장, YYYY-MM-DD
## Time 시간만 저장, HH:MM:SS 형식 사용
## Datetime YYYY-MM-DD HH:MM:SS

## 변수를 만들기
## set @변수이름 = 변수의 값;
## select @변수이름;
set @limit_amount = 3;
select @limit_amount;

select *from buy
where amount > @limit_amount;  # 만든 변수 직접 사용 가능

select *from buy
where amount > 3;

## 자료형 변환
## 직접 변환하는 명식적 변환, 자연스럽게 변환되는 암시적 변환
## 함수 이용해서 변환
select sum(price) from buy;

## 문자열로 바꿔야 한다.
## cast 함수, convert 함수를 이용
## 사용하는 방법은 바꿀 컬럼을 감싸서 문법을 적는다.

select cast(sum(price) as char(10)) as '문자로 바뀐 값' from buy;

select convert(sum(price), char(10)) as '문자로 바꾼값' from buy;

select cast(prod_name as float) from buy;
select cast(mem_id as float) from buy;

## 기본적으로 데이터 형식에 맞는 자료형으로 꼭 변환을 해야한다.
## 숫자나 문자의 구분은 확실하게
## 회원번호 20201234는 문자인가 숫자인가?

## datetime
select cast('2024/01/14' as date);
select cast('2024@01@14' as date);
select cast('2024-01-14' as date);
select cast('2024%01%14' as date);

select num
	, concat(cast(price as char), 'X', cast(amount as char), '=') as '가격 x 수량'
    , price*amount '구매액'
    from buy;
