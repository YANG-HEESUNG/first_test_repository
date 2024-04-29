/* SQL 수정   
    :주문지역의 BETWEEN 조건을 IN 조건으로 수정하여
     수평적 스캔의 선택도를 100%로 조정
     즉,  인덱스 매칭도를 정확하게 맞춤  */

SELECT  고객번호, 주문금액, 주문지역코드, 주문일자, C1, C2, C3
FROM    T_주문14  A 
WHERE   주문금액    BETWEEN 80000 AND 81000
 AND    주문지역코드     IN ('01', '02', '03')
 AND    주문일자          = '20190710'
;
/*
-------------------------------------------------------------------------------------------------------
| Id  | Operation                    | Name         | Starts | A-Rows |   A-Time   | Buffers | Reads  |
-------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |              |      1 |    100 |00:00:00.01 |     109 |     97 |
|   1 |  INLIST ITERATOR             |              |      1 |    100 |00:00:00.01 |     109 |     97 |
|   2 |   TABLE ACCESS BY INDEX ROWID| T_주문14     |      3 |    100 |00:00:00.01 |     109 |     97 |
|*  3 |    INDEX RANGE SCAN          | IX_T_주문14_0|      3 |    100 |00:00:00.01 |       9 |      1 |
-------------------------------------------------------------------------------------------------------
3 - access((("주문지역코드"='01' OR "주문지역코드"='02' OR "주문지역코드"='03')) AND "주문일자"='20190713' AND 
           "주문금액">=80000 AND "주문금액"<=81000)
*/
 
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'IOSTATS LAST -ROWS'));