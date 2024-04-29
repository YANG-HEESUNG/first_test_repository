/*  ���̺� 
       - ��� (��10����), �μ�(100��)

    INDEX 
       - ���PK : EMP_NO   
       - �μ�PK : DEPT_CODE

�Ʒ� SQL�� Ʃ�� �ϼ���. (�ε��� �� SQL ���� ����)

  ���� 1) E.DIV_CODE='01'�� ��� : 10������ �����ϸ�, D.LOC='01'�� ����� 30������ 
          �����ϰ�  Ʃ�� �ϼ���.
  ���� 2) E.DIV_CODE='01'�� ��� : 100������ �����ϸ�, D.LOC='01'�� ����� 3������
          �����ϰ� Ʃ�� �ϼ���.

*/
SELECT  /*+ ORDERED USE_NL(D) */
        E.EMP_NO,  E.EMP_NAME,  E.DIV_CODE,  
        D.DEPT_CODE,  D.DEPT_NAME,  D.LOC
FROM  T_EMP  E,  T_DEPT  D
WHERE E.DIV_CODE    = '01'
 AND  D.DEPT_CODE   = E.DEPT_CODE
 AND  D.LOC         = '01';

/*
--------------------------------------------------------------------
| Id  | Operation                    | Name      |A-Rows | Buffers |
--------------------------------------------------------------------
|   0 | SELECT STATEMENT             |           |     1 |     965 |
|   1 |  NESTED LOOPS                |           |     1 |     965 |
|   2 |   NESTED LOOPS               |           |    10 |     955 |
|*  3 |    TABLE ACCESS FULL         | T_EMP     |    10 |     950 |
|*  4 |    INDEX UNIQUE SCAN         | PK_T_DEPT |    10 |       5 |
|*  5 |   TABLE ACCESS BY INDEX ROWID| T_DEPT    |     1 |      10 |
--------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - filter("E"."DIV_CODE"='01')
   4 - access("D"."DEPT_CODE"="E"."DEPT_CODE")
   5 - filter("D"."LOC"='01')
*/