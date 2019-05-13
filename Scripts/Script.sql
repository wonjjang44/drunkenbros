SELECT * FROM ALCOHOL

INSERT INTO alcohol (alcohol_id, subcategory_id, name, DEGREE, detail, filename)
values(seq_alcohol.nextval, 1, 'Test10', 10, 'TestDetail10', 'portfolio-1.jpg')

SELECT * FROM TOPCATEGORY

INSERT INTO TOPCATEGORY(TOPCATEGORY_id, NAME)
VALUES(seq_topcategory.nextval, 'TestTop')

SELECT * FROM SUBCATEGORY

INSERT INTO SUBCATEGORY(SUBCATEGORY_id, TOPCATEGORY_ID, name)
values(seq_subcategory.nextval, 1, 'TestSub')

SELECT * FROM MEMBER

select member_id, id, pass, name, birth, email, phonenum, regdate, auth_id from MEMBER
order by member_id desc



select auth_id, des from auth where auth_id=1 order by auth_id desc

SELECT * FROM AUTH

SELECT * FROM MEMBER

SELECT * FROM ALCOHOL

SELECT * FROM REVIEW

DELETE FROM member

INSERT INTO auth(auth_id, des)
values(seq_auth.nextval, '醚包府磊')

INSERT INTO auth(auth_id, des)
values(seq_auth.nextval, '何包府磊(雀盔包府, 荤捞飘包府)')

INSERT INTO auth(auth_id, des)
values(seq_auth.nextval, '何包府磊(荤捞飘包府)')

INSERT INTO auth(auth_id, des)
values(seq_auth.nextval, '老馆雀盔')
