-- �Ʒ� SQL�� Ʃ�� �� ���� �����ȹ�� ���� Ʃ���Ͻÿ�.
-- Ȯ���ϰ� ��Ƽ�������� ������ �� �ֵ��� SQL�� �����ϼ���.
-- �� �ε����� ������ �� �����ϴ�.
-- C2+C4�� �������� �ſ� ����.

CREATE INDEX YOON.IX_T_IN_LIST_01  ON YOON.T_IN_LIST(C2, C4, C3);

ALTER SESSION SET STATISTICS_LEVEL = ALL;

SELECT  *
FROM T_IN_LIST
WHERE C2 = '00050'
 AND  C3 IN ('00033', '00034', '00035', '00036', '00043', '00044', '00045', 
             '00046', '00053', '00054', '00055', '00056', '00063', '00064', 
             '00065', '00066', '00073', '00074', '00075', '00076', '00083', 
             '00084', '00085', '00086'
             )
 AND  C4 = '00054';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST - ROWS'));
/*
�ε���
CREATE INDEX YOON.IX_T_IN_LIST_01  ON YOON.T_IN_LIST(C2, C4, C3); 

Ʃ�� ��
PLAN_TABLE_OUTPUT
-------------------------------------------------------------------------
| Id  | Operation                    | Name            |A-Rows| Buffers |
-------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |                 |     3|      40 |
|   1 |  INLIST ITERATOR             |                 |     3|      40 |
|   2 |   TABLE ACCESS BY INDEX ROWID| T_IN_LIST       |     3|      40 |
|*  3 |    INDEX RANGE SCAN          | IX_T_IN_LIST_01 |     3|      37 |
-------------------------------------------------------------------------

Ʃ�� ��
PLAN_TABLE_OUTPUT
------------------------------------------------------------------------
| Id  | Operation                   | Name            |A-Rows| Buffers |
------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                 |     3|       7 |
|   1 |  TABLE ACCESS BY INDEX ROWID| T_IN_LIST       |     3|       7 |
|*  2 |   INDEX RANGE SCAN          | IX_T_IN_LIST_01 |     3|       4 |
------------------------------------------------------------------------
*/