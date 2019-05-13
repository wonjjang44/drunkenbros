-------------DB 구축-------------

===============================================
	----Create User----
===============================================

create user drunken identified by 1234;

grant create table, create session, create user, create sequence,resource,connect to drunken;


===============================================
	----Create Sequences----
===============================================

create sequence seq_topcategory
increment by 1
start with 1;

create sequence seq_subcategory
increment by 1
start with 1;

create sequence seq_alcohol
increment by 1
start with 1;

create sequence seq_auth
increment by 1
start with 1;

create sequence seq_member
increment by 1
start with 1;

create sequence seq_review
increment by 1
start with 1;

create sequence seq_comment
increment by 1
start with 1;

-----------------------------------------------
		추	가 Start
-----------------------------------------------

create sequence seq_alcoholimage
increment by 1
start with 1;

create sequence seq_board
increment by 1
start with 1;

create sequence seq_comments
increment by 1
start with 1;

create sequence seq_tag
increment by 1
start with 1;

-----------------------------------------------
		추	가 End
-----------------------------------------------

===============================================
	----Create Tables----
===============================================

create table topcategory(
topcategory_id number primary key
, name varchar2(20)
);

create table subcategory(
subcategory_id number primary key,
topcategory_id number,
name varchar2(40),
constraint fk_topsub foreign key(topcategory_id)
references topcategory(topcategory_id)
);

-----------------------------------------------
		변	경
-----------------------------------------------

create table alcohol(
alcohol_id number primary key,
subcategory_id number,
name varchar2(50),
degree number,
detail clob,
hit number default 0,
constraint fk_subalcohol foreign key(subcategory_id)
references subcategory(subcategory_id)
);


-----------------------------------------------
		추	가
-----------------------------------------------

create table alcoholimage(
alcoholimage_id number primary key,
alcohol_id number,
filename varchar2(50)
);

create table auth(
auth_id number primary key,
des varchar2(100)
);

create table member(
member_id number primary key,
id varchar2(20),
pass varchar2(30),
name varchar2(20),
birth varchar2(20),
email varchar2(30),
phonenum varchar2(30),
regdate date,
auth_id number,
constraint fk_authmember foreign key(auth_id)
references auth(auth_id)
);

create table review(
review_id number primary key,
alcohol_id number,
member_id number,
title varchar2(50),
detail clob,
score number,
regdate date,
hit number default 0,
constraint fk_reviewalc foreign key(alcohol_id)
references alcohol(alcohol_id),
constraint fk_reviewmem foreign key(member_id)
references member(member_id)
);

create table reply(
reply_id number primary key,
review_id number,
member_id number,
detail varchar2(200),
regdate date,
constraint fk_replyreview foreign key(review_id)
references review(review_id),
constraint fk_replymember foreign key(member_id)
references member(member_id)
);

-----------------------------------------------
	게시판 관련 DB 추가
-----------------------------------------------

create table board(
board_id number primary key,
tag_id number,
member_id number,
title varchar2(100),
content clob,
regdate date,
hit number default 0,
constraint fk_board foreign key(tag_id)
references tag(tag_id),
constraint fk_boardmember foreign key(member_id)
references member(member_id)
);

create table comments(
comments_id number primary key,
board_id number,
member_id number,
msg varchar2(300),
cregdate date,
constraint fk_comments foreign key(board_id)
references board(board_id),
constraint fk_commentsmember foreign key(member_id)
references member(member_id)
);


create table tag(
tag_id number primary key,
tag_name varchar2(15)
);

===============================================
	----Insert----
===============================================

INSERT INTO AUTH(auth_id, des)
values(seq_auth.nextval, '총관리자')

INSERT INTO AUTH(auth_id, des)
values(seq_auth.nextval, '부관리자(회원관리,사이트관리)')

INSERT INTO AUTH(auth_id, des)
values(seq_auth.nextval, '부관리자(사이트관리)')

INSERT INTO AUTH(auth_id, des)
values(seq_auth.nextval, '일반회원')

ALTER TABLE MEMBER MODIFY (pass varchar2(100)) 

SELECT * FROM member

SELECT * FROM ALCOHOL

insert into member (member_id, id, pass, name, birth, email, phonenum, regdate, auth_id)
values (seq_member.nextval, 'insertTest', 123123, 'test', 2019-05-05, 'asdf', '111-1111-1111', sysdate, 4)

UPDATE MEMBER SET auth_id=1 WHERE id='master'