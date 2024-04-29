DROP TABLE YOON.T_MANUF53;
CREATE TABLE YOON.T_MANUF53
    (  M_CODE   VARCHAR2(2)
     , M_NM     VARCHAR2(50)
     , CONSTRAINT PK_T_MANUF53 PRIMARY KEY (M_CODE)
     )
;

CREATE PUBLIC SYNONYM T_MANUF53 FOR YOON.T_MANUF53;

INSERT /*+ APPEND */ INTO T_MANUF53
SELECT LPAD(TO_CHAR(ROWNUM), 2, '0')  M_CODE
     , LPAD(TO_CHAR(ROWNUM), 50, '0') M_NM
FROM DUAL  CONNECT BY LEVEL <= 50
ORDER BY DBMS_RANDOM.RANDOM();

COMMIT;

DROP TABLE YOON.T_PRODUCT53;
CREATE TABLE YOON.T_PRODUCT53
     (  PROD_ID     VARCHAR2(5)
      , PROD_NM     VARCHAR2(50)
      , M_CODE      VARCHAR2(2)
      , CONSTRAINT PK_T_PRODUCT53 PRIMARY KEY(PROD_ID)
      )
;

CREATE PUBLIC SYNONYM T_PRODUCT53 FOR YOON.T_PRODUCT53;

INSERT /*+ APPEND */ INTO T_PRODUCT53
SELECT LPAD(TO_CHAR(ROWNUM),  5, '0') PROD_ID
     , LPAD(TO_CHAR(ROWNUM), 50, '0') PROD_NM
     , LPAD(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 50))), 2, '0') M_CODE
FROM DUAL  CONNECT BY LEVEL <= 10000
ORDER BY DBMS_RANDOM.RANDOM();

COMMIT;

DROP TABLE YOON.T_ORDER53;
CREATE TABLE YOON.T_ORDER53
  (  ORDER_NO   VARCHAR2(8)
   , ORDER_DT   VARCHAR2(8)
   , PROD_ID    VARCHAR2(50)
   , CONSTRAINT PK_T_ORDER53 PRIMARY KEY(ORDER_NO)
  )
;

CREATE PUBLIC SYNONYM T_ORDER53 FOR YOON.T_ORDER53;

INSERT /*+ APPEND */ INTO T_ORDER53
SELECT LPAD(TO_CHAR(ROWNUM),  8, '0') ORDER_NO, ORDER_DT, PROD_ID     
FROM  (SELECT PROD_ID, ROWNUM P_NUM 
            , CASE WHEN ROWNUM > 200 THEN TO_CHAR(TO_DATE('20081231') - (ROWNUM - 200), 'YYYYMMDD')
                                     ELSE TO_CHAR(TO_DATE('20081231') + ROWNUM, 'YYYYMMDD')
              END ORDER_DT
       FROM T_PRODUCT53) A, 
      (SELECT ROWNUM FROM DUAL CONNECT BY LEVEL <= 1000) B
ORDER BY DBMS_RANDOM.RANDOM()
;

COMMIT;

SELECT COUNT(*) FROM T_MANUF53;
SELECT COUNT(*) FROM T_PRODUCT53;
SELECT COUNT(*) FROM T_ORDER53;

EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_MANUF53');
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_PRODUCT53');
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_ORDER53');