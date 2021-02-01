-- 1.
ALTER TABLE JOONGO_SALE DROP COLUMN sale_state;

-- 2.
ALTER TABLE JOONGO_SALE ADD sale_state varchar2(30) DEFAULT '판매중';