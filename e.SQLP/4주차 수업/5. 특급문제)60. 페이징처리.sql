/*
����¡ ó�� SQL�� Ʃ���Ͻÿ�. (�ε��� ���� ����/���ʿ��� �ε����� ���������)
 1) T_USR60 (�����)
    - 1����
 2) T_BBM60 (�Խ���)
    - 100����
    - BBM_TYPE = 'KOR' AND DEL_YN = 'N' ���� 40��
    - ���� ����ڰ� �Խ��� ���� ���� ���ٴ� ����
*/
SELECT BBM_NO, BBM_TITL, BBM_CONT, REG_NM, REG_DTM
FROM  (SELECT BBM_NO, BBM_TITL, BBM_CONT, REG_NM, REG_DTM, ROWNUM RNUM
       FROM (SELECT BBM_NO, BBM_TITL, BBM_CONT, FN_GETREGNM(REG_NO) REG_NM, REG_DTM
             FROM T_BBM60
             WHERE BBM_TYP = 'NOR'
               AND DEL_YN  = 'N'
             ORDER BY REG_DTM DESC
            )
	   )	  
WHERE RNUM BETWEEN 11 AND 20
ORDER BY RNUM
;


/*
-- ���̺� ����
CREATE TABLE T_BBM60
 (
    BBM_NO       NUMBER                         NOT NULL,
    HI_BBM_NO    NUMBER         DEFAULT 0       NOT NULL,
    BBM_TYP      VARCHAR2(3)                            ,
    BBM_TITL     VARCHAR2(200)                  NOT NULL,
    BBM_CONT     VARCHAR2(4000)                 NOT NULL,
    BBM_HIT      NUMBER         DEFAULT 0       NOT NULL,
    DEL_YN       VARCHAR2(1)    DEFAULT 'N'     NOT NULL,
    REG_NO       VARCHAR2(7)                    NOT NULL,
    REG_DTM      DATE           DEFAULT SYSDATE NOT NULL,
    MDF_NO       VARCHAR2(7)                            ,
    MDF_DTM      DATE                                   ,
    CONSTRAINT PK_T_BBM60 PRIMARY KEY (BBM_NO)
 );

CREATE TABLE T_USR60
 (
    USRNO VARCHAR2(10),
    USRNM VARCHAR2(20),
    CONSTRAINT PK_T_USR60 PRIMARY KEY(USRNO)
 );


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
*/