DROP INDEX YOON.IX_T_��23 ;
DROP INDEX YOON.IX_T_�ֹ�23 ;

CREATE INDEX YOON.IX_T_��23 ON YOON.T_��23(�������ڵ�);
CREATE INDEX YOON.IX_T_�ֹ�23 ON YOON.T_�ֹ�23(����ȣ, ��ǰ�ڵ�, �ֹ�����);

EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_��23');
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_�ֹ�23');

ALTER SESSION SET STATISTICS_LEVEL=ALL;

SELECT /*+ ORDERED USE_NL(O) INDEX(C IX_T_��23) INDEX(D IX_T_�ֹ�23) */
       C.����ȣ, C.����, C.C1
     , O.�ֹ���ȣ, O.��ǰ�ڵ�, O.�ֹ�����, O.�ֹ�����
FROM T_��23 C, T_�ֹ�23 O
WHERE C.�������ڵ� = '920'
 AND  O.����ȣ     = C.����ȣ
 AND  O.�ֹ�����     BETWEEN '20170101' AND '20170131'
 AND  O.��ǰ�ڵ�     = 'P103';
 
 SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));
 
 /*                                                                                                                                                                                                                                                                                                        
--------------------------------------------------------------------------------------------------------------
| Id  | Operation                     | Name      | Starts | E-Rows | A-Rows |   A-Time   | Buffers | Reads  |
--------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |           |      1 |        |     13 |00:00:00.02 |     313 |     20 |
|   1 |  NESTED LOOPS                 |           |      1 |        |     13 |00:00:00.02 |     313 |     20 |
|   2 |   NESTED LOOPS                |           |      1 |    109 |     13 |00:00:00.02 |     300 |      7 |
|   3 |    TABLE ACCESS BY INDEX ROWID| T_��23  |      1 |    106 |    101 |00:00:00.01 |      94 |      0 |
|*  4 |     INDEX RANGE SCAN          | IX_T_��2|      1 |    106 |    101 |00:00:00.01 |       3 |      0 |
|*  5 |    INDEX RANGE SCAN           | IX_T_�ֹ�2|    101 |      1 |     13 |00:00:00.01 |     206 |      7 |
|   6 |   TABLE ACCESS BY INDEX ROWID | T_�ֹ�23  |     13 |      1 |     13 |00:00:00.01 |      13 |     13 |
--------------------------------------------------------------------------------------------------------------
Predicate Information (identified by operation id):                                                           
---------------------------------------------------                                                           
4 - access("C"."�������ڵ�"='920')                                                                          
5 - access("O"."����ȣ"="C"."����ȣ" AND "O"."��ǰ�ڵ�"='P103' AND "O"."�ֹ�����">='20170101' AND                                                                   
"O"."�ֹ�����"<='20170131')                                                                                                                                             
 */