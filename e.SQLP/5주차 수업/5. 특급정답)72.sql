ALTER SESSION SET STATISTICS_LEVEL=ALL;
--------- ���� ��
SELECT X.ī���ȣ
FROM   (SELECT   C.ī���ȣ, ROWNUM RNUM
        FROM     �ֹ�_72     A
               , �ֹ��̷�_72 B
               , �����̷�_72 C
        WHERE    A.ȸ����ȣ     = 'C13991'
         AND     A.�ֹ������ڵ� = '12'
         AND     B.�ֹ���ȣ     = A.�ֹ���ȣ
         AND     C.�ֹ��̷¹�ȣ = B.�ֹ��̷¹�ȣ
        ORDER BY C.�������� DESC
       ) X 
WHERE  RNUM = 1;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'IOSTATS LAST'));

/*
PLAN_TABLE_OUTPUT
------------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name         | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |              |      1 |        |      1 |00:00:00.01 |      87 |
|*  1 |  VIEW                             |              |      1 |      8 |      1 |00:00:00.01 |      87 |
|   2 |   SORT ORDER BY                   |              |      1 |      8 |     20 |00:00:00.01 |      87 |
|   3 |    COUNT                          |              |      1 |        |     20 |00:00:00.01 |      87 |
|   4 |     NESTED LOOPS                  |              |      1 |        |     20 |00:00:00.01 |      87 |
|   5 |      NESTED LOOPS                 |              |      1 |      8 |     20 |00:00:00.01 |      67 |
|   6 |       NESTED LOOPS                |              |      1 |      4 |     10 |00:00:00.01 |      44 |
|*  7 |        TABLE ACCESS BY INDEX ROWID| �ֹ�_72      |      1 |      2 |      5 |00:00:00.01 |      22 |
|*  8 |         INDEX RANGE SCAN          | IX01_�ֹ�_72 |      1 |     20 |     19 |00:00:00.01 |       3 |
|   9 |        TABLE ACCESS BY INDEX ROWID| �ֹ��̷�_72  |      5 |      2 |     10 |00:00:00.01 |      22 |
|* 10 |         INDEX RANGE SCAN          | IX01_�ֹ��̷�|      5 |      2 |     10 |00:00:00.01 |      12 |
|* 11 |       INDEX RANGE SCAN            | IX01_�����̷�|     10 |      2 |     20 |00:00:00.01 |      23 |
|  12 |      TABLE ACCESS BY INDEX ROWID  | �����̷�_72  |     20 |      2 |     20 |00:00:00.01 |      20 |
------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("RNUM"=1)
   7 - filter("A"."�ֹ������ڵ�"='12')
   8 - access("A"."ȸ����ȣ"='C13991')
  10 - access("B"."�ֹ���ȣ"="A"."�ֹ���ȣ")
  11 - access("C"."�ֹ��̷¹�ȣ"="B"."�ֹ��̷¹�ȣ")
 
*/

/* 
��� 
  1. �ε��� ���� 
     - IX01_�ֹ�_72     : ȸ����ȣ     => ȸ����ȣ, �ֹ������ڵ�
     - IX01_�����̷�_72 : �ֹ��̷¹�ȣ => �ֹ��̷¹�ȣ, ��������
  
  2. SQL ����
     - ��Ÿ������ ��Ʈ Ȱ��
     - ������ ROWNUM�� ORDER BY�� ���� ������ SQL�� �Ǿ� �־�
       �䱸���װ� �ٸ� ��°��� ���´�.
       ���� �Ʒ��� ���� �ζ��κ信�� SORT�� �ϰ�, ���� ����������
       ROWNUM <= 1 �̷��� SQL ���� �ʿ�
       ��, �������� ���õ� SQL�� �ٸ� ������� ���´�.
       �������� ���õ� SQL�� ����
       
*/
DROP    INDEX IX01_�ֹ�_72;
CREATE  INDEX IX01_�ֹ�_72     ON �ֹ�_72(ȸ����ȣ, �ֹ������ڵ�);

DROP    INDEX IX01_�����̷�_72 ;
CREATE  INDEX IX01_�����̷�_72 ON �����̷�_72(�ֹ��̷¹�ȣ, ��������);

EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', '�ֹ�_72');
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', '�����̷�_72');

SELECT X.ī���ȣ
FROM   (SELECT   /*+ ORDERED USE_NL(B) USE_NL(C) 
                     INDEX(A IX01_�ֹ�_72) INDEX(B IX01_�ֹ��̷�_71)
                     INDEX_DESC(C IX01_�����̷�_72) */
                 C.ī���ȣ
        FROM     �ֹ�_72     A
               , �ֹ��̷�_72 B
               , �����̷�_72 C
        WHERE    A.ȸ����ȣ     = 'C13991'
         AND     A.�ֹ������ڵ� = '12'
         AND     B.�ֹ���ȣ     = A.�ֹ���ȣ
         AND     C.�ֹ��̷¹�ȣ = B.�ֹ��̷¹�ȣ
        ORDER BY C.�������� DESC
       ) X 
WHERE  ROWNUM = 1;
/*
---------------------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name         | Starts | E-Rows | A-Rows |   A-Time   | Buffers | Reads  |
---------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |              |      1 |        |      1 |00:00:00.01 |      33 |      3 |
|*  1 |  COUNT STOPKEY                    |              |      1 |        |      1 |00:00:00.01 |      33 |      3 |
|   2 |   VIEW                            |              |      1 |      9 |      1 |00:00:00.01 |      33 |      3 |
|*  3 |    SORT ORDER BY STOPKEY          |              |      1 |      9 |      1 |00:00:00.01 |      33 |      3 |
|   4 |     NESTED LOOPS                  |              |      1 |        |      8 |00:00:00.01 |      33 |      3 |
|   5 |      NESTED LOOPS                 |              |      1 |      9 |      8 |00:00:00.01 |      25 |      3 |
|   6 |       NESTED LOOPS                |              |      1 |      4 |      4 |00:00:00.01 |      15 |      2 |
|   7 |        TABLE ACCESS BY INDEX ROWID| �ֹ�_72      |      1 |      2 |      2 |00:00:00.01 |       5 |      2 |
|*  8 |         INDEX RANGE SCAN          | IX01_�ֹ�_72 |      1 |      2 |      2 |00:00:00.01 |       3 |      2 |
|   9 |        TABLE ACCESS BY INDEX ROWID| �ֹ��̷�_72  |      2 |      2 |      4 |00:00:00.01 |      10 |      0 |
|* 10 |         INDEX RANGE SCAN          | IX01_�ֹ��̷�|      2 |      2 |      4 |00:00:00.01 |       6 |      0 |
|* 11 |       INDEX RANGE SCAN DESCENDING | IX01_�����̷�|      4 |      2 |      8 |00:00:00.01 |      10 |      1 |
|  12 |      TABLE ACCESS BY INDEX ROWID  | �����̷�_72  |      8 |      2 |      8 |00:00:00.01 |       8 |      0 |
---------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(ROWNUM=1)
   3 - filter(ROWNUM=1)
   8 - access("A"."ȸ����ȣ"='C13991' AND "A"."�ֹ������ڵ�"='12')
  10 - access("B"."�ֹ���ȣ"="A"."�ֹ���ȣ")
  11 - access("C"."�ֹ��̷¹�ȣ"="B"."�ֹ��̷¹�ȣ")
 
 
*/