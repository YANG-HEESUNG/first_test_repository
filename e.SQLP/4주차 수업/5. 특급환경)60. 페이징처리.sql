ALTER SESSION SET WORKAREA_SIZE_POLICY = MANUAL;
ALTER SESSION SET SORT_AREA_SIZE = 2000000000;

DROP TABLE  YOON.T_BBM60;
CREATE TABLE YOON.T_BBM60
 (
    BBM_NO       NUMBER                         NOT NULL,
    HI_BBM_NO    NUMBER         DEFAULT 0       NOT NULL,
    BBM_TYP      VARCHAR2(3)                            ,  -- 'KOR'
    BBM_TITL     VARCHAR2(200)                  NOT NULL,
    BBM_CONT     VARCHAR2(4000)                 NOT NULL,
    BBM_HIT      NUMBER         DEFAULT 0       NOT NULL,
    DEL_YN       VARCHAR2(1)    DEFAULT 'N'     NOT NULL, -- 'N'
    REG_NO       VARCHAR2(10)                   NOT NULL,
    REG_DTM      DATE           DEFAULT SYSDATE NOT NULL,
    MDF_NO       VARCHAR2(7)                            ,
    MDF_DTM      DATE                                   ,
    CONSTRAINT PK_T_BBM60 PRIMARY KEY (BBM_NO)
 ) NOLOGGING;

DROP TABLE YOON.T_USR60;
CREATE TABLE YOON.T_USR60
  (
    USRNO VARCHAR2(10),
    USRNM VARCHAR2(20),
    CONSTRAINT PK_T_USR60 PRIMARY KEY(USRNO)
  )NOLOGGING;

CREATE PUBLIC SYNONYM T_BBM60     FOR YOON.T_BBM60;
CREATE PUBLIC SYNONYM T_USR60     FOR YOON.T_USR60;
CREATE PUBLIC SYNONYM FN_GETREGNM FOR YOON.FN_GETREGNM;

INSERT /*+ APPEND */ INTO T_USR60 
SELECT 'U' || LPAD(TO_CHAR(ROWNUM), 9, '0')      USERNO,
       TO_CHAR(ROWNUM)                           USERNM
FROM DUAL 
CONNECT BY LEVEL <= 10000
ORDER BY DBMS_RANDOM.RANDOM()
;

COMMIT;


INSERT /*+ APPEND */ INTO T_BBM60
SELECT BBM_NO, HI_BBM_NO, BBM_TYPE, BBM_TITL, BBM_CONT, BBM_HIT,
       CASE WHEN BBM_TYPE = 'NOR' AND MOD(ROWNUM, 5) = 0 THEN 'N' ELSE 'Y' END DEL_YN,
       REG_NO, REG_DTM, MDF_NO, MDF_DTM
FROM (
        SELECT ROWNUM                                           BBM_NO            ,
               ROWNUM                                           HI_BBM_NO         ,
               CASE WHEN TRUNC(DBMS_RANDOM.VALUE(1, 5000)) = 1 THEN 'NOR' 
                    ELSE TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1,999))) 
               END                                              BBM_TYPE          ,
               'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                     BBM_TITL          ,
               'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                     BBM_CONT          ,
               0                                                BBM_HIT           ,
               A.USRNO                                          REG_NO            ,
               SYSDATE + TRUNC(DBMS_RANDOM.VALUE(1, 1000))      REG_DTM           ,
               '1234567'                                        MDF_NO            ,
               SYSDATE + TRUNC(DBMS_RANDOM.VALUE(1, 1000))      MDF_DTM
        FROM (SELECT USRNO FROM T_USR60) A,
             (SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= 100)
     )
ORDER BY DBMS_RANDOM.RANDOM()
;

COMMIT;


EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_BBM60');
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_USR60');

-- ORANGE�� �̿��ؼ� ������ ��� �Ʒ� ������ PL/SQL â�� �̿��ϼ���.
CREATE OR REPLACE FUNCTION YOON.FN_GETREGNM ( V_ID IN T_USR60.USRNO%TYPE) 
RETURN T_USR60.USRNM%TYPE IS RESULT T_USR60.USRNM%TYPE;
BEGIN
    SELECT A.USRNM  INTO RESULT
    FROM T_USR60 A
    WHERE A.USRNO = V_ID;
    
    RETURN(RESULT);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN RESULT := '';
    RETURN(RESULT);
    
    WHEN OTHERS THEN RETURN(NULL);
END FN_GETREGNM;
/

ALTER SESSION SET WORKAREA_SIZE_POLICY = AUTO;