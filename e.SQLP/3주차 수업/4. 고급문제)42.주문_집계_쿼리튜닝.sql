/* 
������ SQL�� ���� Data�� �����ؼ� ���� �ʵ��� �����ϼ���.
�ʿ��� �ε����� ��� �����Ǿ��ٴ� ���� 
T_ORDER42�� Primary key : ORDER_NO
*/

--����1)
SELECT  B.ORDER_NO, B.ORDER_CD, 
        ROUND(A.ORDER_AMT_AVG) ����ֹ��ݾ�, A.ORDER_AMT_SUM �ֹ��հ�ݾ�
FROM  (SELECT ORDER_CD
            , AVG(ORDER_AMT) ORDER_AMT_AVG
            , SUM(ORDER_AMT) ORDER_AMT_SUM
       FROM T_ORDER42
       GROUP BY ORDER_CD
      )A,  T_ORDER42 B
WHERE B.ORDER_CD = A.ORDER_CD
ORDER BY ORDER_CD, ORDER_NO
;

--����2)
SELECT B.ORDER_NO, B.ORDER_CD, B.ORDER_DT, B.ORDER_AMT, B.ORDER_QTY
FROM (SELECT MAX(ORDER_NO) ORDER_NO
      FROM T_ORDER42
      GROUP BY ORDER_CD
    ) A, T_ORDER42 B
WHERE B.ORDER_NO = A.ORDER_NO
ORDER BY ORDER_CD, ORDER_NO
;
