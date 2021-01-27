
CREATE OR REPLACE VIEW member_view AS
SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, m.GRADE, g.NAME AS grade_name, a.name AS dongne1 , b.name AS dongne2, 
m.profile_pic, m.profile_text, m.regdate, m.ZIPCODE, m.ADDRESS1, m.ADDRESS2, m.USE_YN FROM MEMBER m 
LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID
LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id 
LEFT OUTER JOIN grade g ON m.GRADE = g.CODE;


CREATE OR REPLACE VIEW dongne_view AS
SELECT a.id AS D1ID, a.name AS D1NAME, b.name AS D2NAME , b.id AS D2ID FROM DONGNE1 a 
LEFT OUTER JOIN DONGNE2 b ON a.ID = b.DONGNE1_ID; 
