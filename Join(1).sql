## join
## inner join 내부 조인
select * from buy;
select * from member;

## 어떤 컬럼이 pk를 잡을 수 있는가? 조인될 조건은 무엇인가?
## mem_id
## 문법적으로 적용 시
## select <컬럼>
## from <조인할 첫 테이블>
## inner join <조인할 두 번째 테이블>
## on <조인될 조건>
## 추가 검색이나 정렬 등 where    

select *
from buy
inner join member
on buy.mem_id = member.mem_id;

## 내가 원하는 컬럼만 뽑기
select *
from buy
inner join member
on buy.mem_id = member.mem_id
where buy.mem_id = 'BLK';

# 겹치는 테이블 내에 컬럼은 에러를 발생한다 따라서 지정을 정확히 해야한다
select buy.mem_id, mem_number, addr, price # mem_id는 두 개 테이블에 존재하는데 어떤 놈을 가지고 와? 
from buy
inner join member
on buy.mem_id = 'BLK';

## 문법의 불문율 깔끔하게 정리하는 것
select b.mem_id
	, m.mem_number
    , m.addr
    , b.price
    from buy as b
		inner join member as m
        on b.mem_id = m.mem_id
	where b.mem_id = 'BLK';