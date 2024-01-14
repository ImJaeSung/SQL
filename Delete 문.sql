select * from bda_sql2;
select * from bda_sql3;

## delete 삭제하기
delete from bda_sql2;

## 지우는 것도 추가적으로 조건을 걸어서 지울 수 있다.
## 테이블 전체가 아니라 홍길동만 지운다

delete from bda_sql3
where mem_name = '홍길동';

## 이름이 정길동 지우는데 23세인 친구만 지워라
select * from bda_sql3
where mem_name like '%길동'
and age = '23';

delete from bda_sql3
where mem_name like '%길동'
and age = '23';

## 정길동만 날라감
select * from bda_sql3;