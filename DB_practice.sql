DROP DATABASE IF EXISTS bda_table; -- 만약 market_db가 존재하면 우선 삭제한다.
CREATE DATABASE bda_table;

USE bda_table;
CREATE TABLE bda_student -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 회원번호(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  marjoring     TINYINT NOT NULL,  -- 전공여부
  addr	  		CHAR(2) NOT NULL -- 지역(경기,서울,경남 식으로 2글자만입력)
);
CREATE TABLE class -- 수업 테이블
(  class_id 	INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 수업id(PK)
   class_name 	CHAR(15) NOT NULL, --  수업이름
   semester     INT NOT NULL -- 기수
);

CREATE TABLE Benefits -- 우수학회원 혜택 테이블
(  benefit_id 	INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 혜택id(PK)
   benfit_details CHAR(10) NOT NULL -- 혜택 내용
);

CREATE TABLE festival -- 행사
(  festival_id 	INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 행사id(PK)
   festival_name CHAR(15) NOT NULL -- 행사이름
);

CREATE TABLE company -- 협력회사
(  company_id 	INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 회사id(PK)
   company_name CHAR(1benefits0) NOT NULL -- 회사이름
);

CREATE TABLE study_group -- 스터디그룹
(  group_id 	INT AUTO_INCREMENT NOT NULL PRIMARY KEY -- 그룹id(PK)
);

CREATE TABLE score -- 상벌점 테이블
(  score_id 	INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 상벌점id(PK)
   score_details CHAR(10), -- 상벌점 내용
   score INT -- 상벌점
);


INSERT INTO bda_student VALUES(1, '임재성', 1, '서울');  -- INSERT 문으로 데이터 채우기
INSERT INTO bda_student VALUES(2, '박재성', 1, '경기');
INSERT INTO bda_student VALUES(3, '오재성', 0, '경기');
INSERT INTO bda_student VALUES(4, '김재성', 1, '서울');

INSERT INTO class VALUES(42, 'SQL기초반', 7);
INSERT INTO class VALUES(30, '데이터분석기초반', 5);
INSERT INTO class VALUES(12, '데이터분석중급반', 3);
INSERT INTO class VALUES(44, 'R문법기초반', 7);

INSERT INTO Benefits VALUES(1, '자소서 첨삭');
INSERT INTO Benefits VALUES(2, '취업 연계 공모전');

INSERT INTO festival VALUES(1, 'BDA WAVE');
INSERT INTO festival VALUES(2, '공모전');
INSERT INTO festival VALUES(3, 'Job festival');

INSERT INTO company VALUES(1, '농심');
INSERT INTO company VALUES(2, '이지스퍼블리싱');
INSERT INTO company VALUES(3, 'CJ제일제당');


INSERT INTO score VALUES(1, '과제미제출', -1);
INSERT INTO score VALUES(2, '무단결석', -3);
INSERT INTO score VALUES(3, '블로그 수기 참여', 2);
INSERT INTO score VALUES(4, '설문조사 참여', 1);

INSERT INTO study_group VALUES(1, 'MAMAMOO');
INSERT INTO study_group VALUES(2, 'BLACKPINK');
INSERT INTO study_group VALUES(3, 'APINK');
INSERT INTO study_group VALUES(4, '혼공SQL');
