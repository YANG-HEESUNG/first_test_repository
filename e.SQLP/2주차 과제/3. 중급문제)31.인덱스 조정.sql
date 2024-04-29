--�Ʒ��� SQL�� �����Ͽ� ���� �����ȹ�̴�.
SELECT  /*+ ORDERED USE_NL(P) USE_NL(O) */
       P.PROD_NM, P.PROD_ID, O.ORDER_QTY
FROM   T_MANUF M, T_PRODUCT P,  T_ORDER O
WHERE  M.M_CODE BETWEEN 'M00001' AND 'M00100'
 AND   P.M_CODE  = M.M_CODE
 AND   O.PROD_ID = P.PROD_ID
 AND   O.ORDER_DT = '20160412'
 AND   O.ORDER_QTY > 9000;

/* Index ����
PK_T_MANUF    : T_MANUF  (M_CODE)
PK_T_PRODUCT  : T_PRODUCT(PROD_ID)
PK_T_ORDER    : T_ORDER(CUST_ID, PROD_ID, PROD_DT)

CREATE INDEX YOON.IX_T_PRODUCT_01  ON YOON.T_PRODUCT (M_CODE);
CREATE INDEX YOON.IX_T_ORDER_01    ON YOON.T_ORDER  (PROD_ID, ORDER_QTY, ORDER_DT);
-----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name          | Starts | A-Rows |   A-Time   | Buffers 
-----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |               |      1 |     32 |00:00:23.70 |   30265 
|   1 |  NESTED LOOPS                 |               |      1 |     32 |00:00:23.70 |   30265 
|   2 |   NESTED LOOPS                |               |      1 |  10000 |00:00:23.61 |   10224 
|*  3 |    INDEX RANGE SCAN           | PK_T_MANUF    |      1 |    100 |00:00:00.01 |       3 
|   4 |    TABLE ACCESS BY INDEX ROWID| T_PRODUCT     |    100 |  10000 |00:00:23.60 |   10221 
|*  5 |     INDEX RANGE SCAN          | IX_T_PROD_01  |    100 |  10000 |00:00:00.01 |     235 
|*  6 |   INDEX RANGE SCAN            | IX_T_ORDER_01 |  10000 |     32 |00:00:00.09 |   20041 
-----------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
����) �Ʒ��� SQL ���� ������� �ε��� ������ �����Ͽ� Ʃ���� ����� �����ȹ�̴�.
� ������ ����Ǿ��°�?   �׸��� �Ʒ��� ���� �����ȹ�� ���� �� �ֵ��� ��Ʈ�� �����Ͻÿ�.
-----------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
| Id  | Operation          | Name            | Starts | A-Rows |   A-Time   | Buffers |
---------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |                 |      1 |     32 |00:00:00.09 |   20318 |
|   1 |  NESTED LOOPS      |                 |      1 |     32 |00:00:00.09 |   20318 |
|   2 |   NESTED LOOPS     |                 |      1 |  10000 |00:00:00.01 |     314 |
|*  3 |    INDEX RANGE SCAN| PK_T_MANUF      |      1 |    100 |00:00:00.01 |       3 |
|*  4 |    INDEX RANGE SCAN| IX_T_PRODUCT_02 |    100 |  10000 |00:00:00.01 |     311 |
|*  5 |   INDEX RANGE SCAN | IX_T_ORDER_02   |  10000 |     32 |00:00:00.08 |   20004 |
---------------------------------------------------------------------------------------

*/

