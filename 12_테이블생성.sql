
/*
- NUMBER(2) -> ������ 2�ڸ����� ������ �� �ִ� ������ Ÿ��.
- NUMBER(5, 2) -> ������, �Ǽ��θ� ��ģ �� �ڸ��� 5�ڸ�, �Ҽ��� 2�ڸ�
- NUMBER -> ��ȣ�� ������ �� (38, 0)���� �ڵ� �����˴ϴ�.
- VARCHAR2(byte) -> ��ȣ �ȿ� ���� ���ڿ��� �ִ� ���̸� ����. (4000byte����)
- CLOB -> ��뷮 �ؽ�Ʈ ������ Ÿ�� (�ִ� 4Gbyte)
- BLOB -> ������ ��뷮 ��ü (�̹���, ���� ���� �� ���)
- DATE -> BC 4712�� 1�� 1�� ~ AD 9999�� 12�� 31�ϱ��� ���� ����
- ��, ��, �� ���� ����.
*/


CREATE TABLE dept3 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14),
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

DESC dept3;
SELECT * FROM dept3;

-- NUMBER�� VARCHAR2 Ÿ���� ���̸� Ȯ��.
INSERT INTO dept3
VALUES (30, '�濵����', '���', sysdate, 2000000);

-- �÷� �߰�
ALTER TABLE dept3
ADD (dept_count NUMBER(3));

-- ���̸� ����
ALTER TABLE dept3
RENAME COLUMN dept_count TO emp_count;

-- �� �Ӽ� ����
-- ���� �����ϰ��� �ϴ� �÷��� �����Ͱ� �̹� �����Ѵٸ� �׿� �´� Ÿ������
-- ������ �ּž� �մϴ�. ���� �ʴ� Ÿ�����δ� ������ �Ұ����մϴ�.
ALTER TABLE dept3
MODIFY (dept_name VARCHAR2(2));

-- �� ����
ALTER TABLE dept3
DROP COLUMN dept_bonus;

SELECT * FROM dept4;

-- ���̺� �̸� ����
ALTER TABLE dept3
RENAME TO dept4;

-- ���̺� ���� (������ ���ܵΰ� ���� �����͸� ��� ����)
TRUNCATE TABLE dept4;

DROP TABLE dept4;

ROLLBACK;














