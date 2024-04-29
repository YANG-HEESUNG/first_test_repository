/* 
������ SQL�� ���� Data�� �����ؼ� ���� �ʵ��� �����ϼ���.
�ʿ��� �ε����� ��� �����Ǿ��ٴ� ���� 
*/

����1)
SELECT ORDER_NO, ORDER_CD
    ,  ROUND(AVG(ORDER_AMT) OVER(PARTITION BY ORDER_CD)) ����ֹ��ݾ�
    ,  SUM(ORDER_AMT)       OVER(PARTITION BY ORDER_CD)  �ֹ��հ�ݾ�
FROM T_ORDER42
ORDER BY ORDER_CD, ORDER_NO
;

����2) -- ORDER BY �� ���� : ���ʿ��� ���� ����
SELECT ORDER_NO, ORDER_CD, ORDER_DT, ORDER_AMT
FROM (
    SELECT ORDER_NO, ORDER_CD, ORDER_DT, ORDER_AMT
        ,  ROW_NUMBER() OVER (PARTITION BY ORDER_CD ORDER BY ORDER_NO DESC) ORDER_ROW_NO
    FROM T_ORDER42 
    )
WHERE ORDER_ROW_NO = 1
;
