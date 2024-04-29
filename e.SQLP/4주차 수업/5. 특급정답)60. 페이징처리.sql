/*
1. �ε��� ���� �� SORT
  - �ε����� ���� �д� BLOCK ���� ����
  - SORT ��ü ȿ�� (�ε����� REG_DTM Į�� �߰� �ʿ�)
  - ���� ������ ORDER BY���� RNUM Ȱ�� �� ���ʿ��� ��Ʈ ����
    �ݵ�� ���� ����� ORDER BY ���� �����ؾ� ��.
2. STOP KEY�� �߻� ���Ѿ� �Ѵ�. => SORT Ʃ���� ����
  - stop key �߻��� �� "rownum" Į�� Ȱ��,  
    �Ʒ��� �������� ����ڰ� ���� Į�� rnum ����ϸ� �ȵ�.
3. PL/SQL�� �Ϲ� ��Į�󼭺������� ����
  - PL/SQL�� SQL�� ���࿣���� �޶� SQL ������ ��� �ߴ� �� 
    PL/SQL ���� �������� ���� �� �ٽ� SQL �������� ����
    => �̸� CONTEXT SWITCH�� �Ѵ�.
    �� ��Ȳ�� ����ӵ� ���ϸ� �ʷ��Ͽ�, SQL���� ��������� �Լ�
    ȣ���� Ư���� ��츦 �����ϰ�� ����� �����ؾ� �Ѵ�.
4. ��Į�� ��������
   - �ζ��κ� ������ �ƴ� ���� ��� ��� �������� ����
   - ���� �ζ��κ�� ĳ���� �ϴµ�, ���� ����ڰ� ���� ���� ����
     JOIN���� ó���ϴ� ���� �����ϸ�, �̶� OUTER JOIN �ʼ�
*/

DROP INDEX YOON.IX_T_BBM60_01 ;
CREATE INDEX YOON.IX_T_BBM60_01 ON YOON.T_BBM60(BBM_TYP, DEL_YN, REG_DTM);
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_BBM60');
ALTER SESSION SET STATISTICS_LEVEL=ALL;

SELECT /*+ ORDERED USE_NL(X) */
       Y.BBM_NO, Y.BBM_TITL, Y.BBM_CONT, 
       X.USRNM  REG_NM,
       REG_DTM, RNUM
FROM  (SELECT K.*, ROWNUM RNUM
       FROM (SELECT /*+ INDEX_DESC(A IX_T_BBM60_01) */
                    BBM_NO, BBM_TITL, BBM_CONT, REG_DTM, REG_NO
             FROM T_BBM60 A 
             WHERE BBM_TYP = 'NOR'
               AND DEL_YN  = 'N'
             ORDER BY REG_DTM DESC) K
       WHERE ROWNUM <= 20) Y,
       T_USR60 X 
WHERE Y.RNUM >= 11
 AND  X.USRNO(+) = Y.REG_NO
ORDER BY REG_DTM DESC;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));
/* 
-------------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name          | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |               |      1 |        |     10 |00:00:00.01 |      46 |
|   1 |  NESTED LOOPS OUTER               |               |      1 |     20 |     10 |00:00:00.01 |      46 |
|*  2 |   VIEW                            |               |      1 |     20 |     10 |00:00:00.01 |      24 |
|*  3 |    COUNT STOPKEY                  |               |      1 |        |     20 |00:00:00.01 |      24 |
|   4 |     VIEW                          |               |      1 |     20 |     20 |00:00:00.01 |      24 |
|   5 |      COUNT                        |               |      1 |        |     20 |00:00:00.01 |      24 |
|   6 |       TABLE ACCESS BY INDEX ROWID | T_BBM60       |      1 |     20 |     20 |00:00:00.01 |      24 |
|*  7 |        INDEX RANGE SCAN DESCENDING| IX_T_BBM60_01 |      1 |     20 |     20 |00:00:00.01 |       4 |
|   8 |   TABLE ACCESS BY INDEX ROWID     | T_USR60       |     10 |      1 |     10 |00:00:00.01 |      22 |
|*  9 |    INDEX UNIQUE SCAN              | PK_T_USR60    |     10 |      1 |     10 |00:00:00.01 |      12 |
-------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - filter("Y"."RNUM">=11)
   3 - filter(ROWNUM<=20)
   7 - access("BBM_TYP"='NOR' AND "DEL_YN"='N')
   9 - access("X"."USRNO"="Y"."REG_NO") 
   
AUTOTRACE ���
Statistics
----------------------------------------------------------
          1  recursive calls
          0  db block gets
         46  consistent gets
          0  physical reads
          0  redo size
       1136  bytes sent via SQL*Net to client
        420  bytes received via SQL*Net from client
          2  SQL*Net roundtrips to/from client
          0  sorts (memory)
          0  sorts (disk)
         10  rows processed
*/
