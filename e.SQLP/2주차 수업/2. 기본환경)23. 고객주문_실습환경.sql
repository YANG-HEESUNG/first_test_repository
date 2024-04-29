DROP   TABLE YOON.T_��23;
CREATE TABLE YOON.T_��23
  (����ȣ      VARCHAR2(7),
   ����        VARCHAR2(50),
   �������ڵ�  VARCHAR2(3),
   C1            VARCHAR2(30),
   C2            VARCHAR2(30),
   C3            VARCHAR2(30),
   C4            VARCHAR2(30),
   C5            VARCHAR2(30),
   CONSTRAINT PK_T_��23 PRIMARY KEY (����ȣ)
  );

CREATE PUBLIC SYNONYM T_��23 FOR YOON.T_��23;

INSERT /*+ APPEND */ INTO T_��23
SELECT LPAD(TO_CHAR(ROWNUM), 7, '0')                                    ����ȣ
     , RPAD(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 65000))), 10, '0')       ����
     , LPAD(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 200))) || '0', 3, '0')   �������ڵ�
     , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                                     C1
     , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                                     C2
     , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                                     C3
     , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                                     C4
     , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                                     C5
FROM DUAL
CONNECT BY LEVEL <= 20000
ORDER BY DBMS_RANDOM.RANDOM();;

COMMIT;

DROP   TABLE YOON.T_DATE23;
CREATE TABLE YOON.T_DATE23 AS
SELECT TO_CHAR(TO_DATE('20170101', 'YYYYMMDD') + LEVEL, 'YYYYMMDD') WORK_DATE
FROM DUAL
CONNECT BY LEVEL <= 100
ORDER BY DBMS_RANDOM.RANDOM();

CREATE PUBLIC SYNONYM T_DATE23 FOR YOON.T_DATE23;

DROP TABLE  YOON.T_�ֹ�23 ;
CREATE TABLE YOON.T_�ֹ�23 AS
SELECT  'O' || LPAD(TO_CHAR(ROWNUM), 7, '0')                                    �ֹ���ȣ
      ,  C.����ȣ
      , 'P' || LPAD(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 200))) || '0', 3, '0')   ��ǰ�ڵ�
      ,  D.WORK_DATE                                                            �ֹ�����
      , ROUND(DBMS_RANDOM.VALUE(1, 3))                                          �ֹ�����        
FROM T_��23 C, T_DATE23 D
ORDER BY DBMS_RANDOM.RANDOM();;

CREATE PUBLIC SYNONYM T_�ֹ�23 FOR YOON.T_�ֹ�23;

ALTER TABLE YOON.T_�ֹ�23 
ADD CONSTRAINT PK_T_�ֹ�23 PRIMARY KEY(�ֹ���ȣ)
;

EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_��23');
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_�ֹ�23');
