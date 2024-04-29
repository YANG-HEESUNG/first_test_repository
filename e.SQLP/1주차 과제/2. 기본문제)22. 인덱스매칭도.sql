/*
PRIMARY KEY : CUST_NO
�ε���      : CUST_CD + FLAG + DIV

T_CUST22  200����
  - CUST_CD   2000�� ����(001 ~ 200),  �ڵ�� �Ǽ��� ��  1���� 
  - DIV       100�� ����(001 ~ 100),  �ڵ�� �Ǽ��� ��  2����
  - FLAG      100��  ����,    �ڵ�� �Ǽ��� �� 20����

-----------------------------------------------------------------------------------------------
| Id  | Operation                   | Name           | Starts | A-Rows |   A-Time   | Buffers |
-----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                |      1 |    125 |00:00:00.01 |     470 |
|   1 |  TABLE ACCESS BY INDEX ROWID| T_CUST22       |      1 |    125 |00:00:00.01 |     470 |
|*  2 |   INDEX RANGE SCAN          | IX_T_CUST22_01 |      1 |    125 |00:00:00.01 |     345 |
-----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("CUST_CD">='190' AND "FLAG"='160' AND "CUST_CD"<='200')
       filter(("FLAG"='160' AND INTERNAL_FUNCTION("DIV")))
 
  
�Ʒ� SQL�� ���� Ʃ�� �Ͻÿ�(�ε��� �� SQL���� ����)
*/

SELECT *
FROM T_CUST22 
WHERE  CUST_CD BETWEEN '190' AND '200' 
AND   DIV IN ('30', '40', '50', '60', '20')
AND   FLAG = '160'
;
