ALTER SESSION SET WORKAREA_SIZE_POLICY = MANUAL;
ALTER SESSION SET SORT_AREA_SIZE = 2000000000;

DROP TABLE YOON.T_IN_LIST;
CREATE TABLE YOON.T_IN_LIST
   (  C1    VARCHAR2(7)
    , C2    VARCHAR2(5)
    , C3    VARCHAR2(5)
    , C4    VARCHAR2(5)
    , C5    VARCHAR2(50)
    , C6    VARCHAR2(50)
    , C7    VARCHAR2(50)
    , C8    VARCHAR2(50)
    , C9    VARCHAR2(50)
    , C10    VARCHAR2(50)
    , CONSTRAINT PK_T_IN_LIST PRIMARY KEY( C1 )
    );
    
CREATE PUBLIC SYNONYM T_IN_LIST FOR YOON.T_IN_LIST;

INSERT /*+ APPEND */ INTO T_IN_LIST
SELECT  LPAD(TO_CHAR(ROWNUM), 7, '0') C1
      , LPAD(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 1000))), 5, '0') C2
      , LPAD(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 100))), 5, '0')  C3
      , LPAD(TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 100))), 5, '0')  C4
      , '12345678901234567890123456789012345678901234567890'  C5
      , '12345678901234567890123456789012345678901234567890'  C6
      , '12345678901234567890123456789012345678901234567890'  C7
      , '12345678901234567890123456789012345678901234567890'  C8
      , '12345678901234567890123456789012345678901234567890'  C9
      , '12345678901234567890123456789012345678901234567890'  C10
FROM DUAL
CONNECT BY LEVEL <= 1000000
ORDER BY DBMS_RANDOM.RANDOM()
;

COMMIT;

CREATE INDEX YOON.IX_T_IN_LIST_01  ON YOON.T_IN_LIST(C2, C4,  C3);

EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_IN_LIST');

ALTER SESSION SET WORKAREA_SIZE_POLICY = AUTO;