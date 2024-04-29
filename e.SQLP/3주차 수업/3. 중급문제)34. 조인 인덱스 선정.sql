/* �Ʒ��� SQL�� ���� �ε����� �����Ͻÿ�
T1 
  - ��ü 1õ����
  - T1.C5 = 'A'   100��
  
T2
  - ��ü 1���
  - T2.C2 = '10'  AND  T2.C3 = '123'  2,000
*/

--1)
SELECT  /*+ ORDERED  USE_NL(T2) */  *
FROM  T1_34 T1,  T2_34 T2
WHERE  T1.C5 = 'A'
 AND   T2.C1 = T1.C1
 AND   T2.C2 = '10'
 AND   T2.C3 = '123';
-- Nested Loop Join���� ����ȭ ��Ű����.

--2)
SELECT  /*+ ORDERED  USE_HASH(T2) */   *
FROM  T1_34 T1,  T2_34 T2
WHERE  T1.C5 = 'A'
 AND   T2.C1 = T1.C1
 AND   T2.C2 = '10'
 AND   T2.C3 = '123';

-- HASH JOIN���� ����ȭ ��Ű����.
     -- �ε��� ���氡��
     -- SQL ���� ����