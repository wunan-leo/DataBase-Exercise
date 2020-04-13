CREATE TABLE student
(
 snum CHAR(4) NOT NULL PRIMARY KEY
              CHECK(snum LIKE 's[0-9][0-9][0-9]'),
 sname VARCHAR(20),
 sex CHAR(2) CHECK(sex IN('��','Ů')),
 dept VARCHAR(30),
 birthday DATE,
 telephone CHAR(12) CHECK(isnumeric(left(telephone,3))=1   
             and  isnumeric(right(telephone,8))=1)
)

CREATE TABLE course
(
 cnum CHAR(4) NOT NULL PRIMARY KEY
              CHECK(cnum LIKE 'c[0-9][0-9][0-9]'),
 cname VARCHAR(30),
 credits SMALLINT CHECK(credits BETWEEN 0 AND 8),
 descr VARCHAR(40),
 dept VARCHAR(30),
 textbook VARCHAR(40)
)

 CREATE TABLE sections
 (
  secnum CHAR(5) PRIMARY KEY
                 CHECK(secnum LIKE'[0-9][0-9][0-9][0-9][0-9]'),
  cnum CHAR(4) NOT NULL FOREIGN KEY REFERENCES.course,
  pnum CHAR(4) CHECK(pnum LIKE 'p___')
 )

CREATE TABLE sc
(
 snum CHAR(4) NOT NULL FOREIGN KEY REFERENCES.student,
 secnum CHAR(5) NOT NULL FOREIGN KEY REFERENCES.sections,
 score INT CHECK(score BETWEEN 0 AND 100)
 )

 INSERT INTO student
 VALUES('s007','�Ŷ���','��','���й滮','1994-8-2','050-77777777'),
       ('s008','����','Ů','���й滮','1995-5-23','070-88888888')

 INSERT INTO course
 VALUES('c132','��ý�弼��',3,'��ѡ��','�����ϵ','����ý�弼����Ӧ�á�,�廪��ѧ������'),
       ('c135','VB�������',3,'��ѡ��','�����ϵ','��VB.NET������ơ�,�ߵȽ���������')

 INSERT INTO sections
 VALUES('13201','c132','p007'),
       ('13501','c135','p007')

 INSERT INTO sc
 VALUES('s008','12001',90),
       ('s008','12601',93)