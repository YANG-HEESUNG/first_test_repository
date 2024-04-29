ALTER SESSION SET WORKAREA_SIZE_POLICY = MANUAL;
ALTER SESSION SET SORT_AREA_SIZE = 2000000000;

drop table yoon.t_�ֹ�14;

create table yoon.t_�ֹ�14 AS
SELECT A.����ȣ, �ֹ��ݾ�, �ֹ������ڵ�, B.�ֹ�����
     , 'ASDFFDSAASDFFDSAASDFFDSAASDFFDSAASDFFDSA' C1
     , 'ASDFFDSAASDFFDSAASDFFDSAASDFFDSAASDFFDSA' C2
     , 'ASDFFDSAASDFFDSAASDFFDSAASDFFDSAASDFFDSA' C3
     , 'ASDFFDSAASDFFDSAASDFFDSAASDFFDSAASDFFDSA' C4
     , 'ASDFFDSAASDFFDSAASDFFDSAASDFFDSAASDFFDSA' C5
     , 'ASDFFDSAASDFFDSAASDFFDSAASDFFDSAASDFFDSA' C6
FROM   (select  'C' || lpad(trim(to_char(rownum)), 4, '0')             ����ȣ
              , round(dbms_random.value(10000, 100000))                �ֹ��ݾ�
              , lpad(to_char(round(dbms_random.value(1, 5))), 2, '0') �ֹ������ڵ�
        from dual connect by level <= 1000
        ) A,
       (SELECT  TO_CHAR(TO_DATE('20190901', 'YYYYMMDD') - ROWNUM, 'YYYYMMDD') �ֹ�����
        FROM DUAL CONNECT BY LEVEL <= 100
       ) B,
       (SELECT ROWNUM R_NUM 
        FROM   DUAL
        CONNECT BY LEVEL <= 100
       )
ORDER BY DBMS_RANDOM.RANDOM();

create public synonym t_�ֹ�14 for yoon.t_�ֹ�14;

CREATE INDEX YOON.IX_t_�ֹ�14_01 ON YOON.t_�ֹ�14(�ֹ������ڵ�, �ֹ�����, �ֹ��ݾ�);

EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 't_�ֹ�14');

ALTER SESSION SET WORKAREA_SIZE_POLICY = AUTO;