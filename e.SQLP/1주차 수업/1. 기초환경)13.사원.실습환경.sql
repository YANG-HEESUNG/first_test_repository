-- DBMS Sort ���� �޸� Ȯ���� ���� ��ũ��Ʈ
ALTER SESSION SET WORKAREA_SIZE_POLICY = MANUAL;
ALTER SESSION SET SORT_AREA_SIZE = 2000000000;

-- ���� ���� �� �ش� ���̺��� ���⿡ �������� ���� ����
drop table yoon.t_emp23;

-- DB ���� yoon�� ���̺��� �����, �ٸ� ������ ������ yoon ��� �ٸ� ���� ��� ����
create table yoon.t_emp23 AS
select  lpad(trim(to_char(rownum)), 8, '0') emp_no
      , '12345678901234567890123456789012345678901234567890' emp_name
      , lpad(to_char(round(dbms_random.value(1, 99))), 2, '0') dept_code
      , lpad(to_char(round(dbms_random.value(2, 999))), 3, '0') div_code
from dual connect by level <= 9999999;

COMMIT;

-- from ���� ��Ű����(������)�� ���� �ʰ� ���̺� ��Ī������ ��ȸ �����ϵ��� ����� ���
-- �ٸ� ������ ������� ��� for ������ "yoon" ��� �ٸ� ������ �Է��ϸ� ����
create public synonym t_emp23 for yoon.t_emp23;

UPDATE T_EMP23
SET DIV_CODE = '001'
WHERE EMP_NO <= '00000010';

COMMIT;

-- �ٸ� ������ ���̺��� ������� ���� on ������ yoon ��� �ٸ� ���� �Է�
CREATE INDEX YOON.IX_T_EMP23 ON YOON.T_EMP23(DEPT_CODE);

-- �ٸ� ������ ���̺��� ������� ���� ù ��° �Ķ���Ϳ� YOON ��� �ٸ� ���� �Է�
EXECUTE DBMS_STATS.GATHER_TABLE_STATS('YOON', 'T_EMP23');

-- DBMS Sort ���� �޸� Ȯ���� �ߴ� �� ���󺹱�
ALTER SESSION SET WORKAREA_SIZE_POLICY = AUTO;