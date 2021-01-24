
SELECT a.id, a.name, b.ID ,b.name FROM dongne1 a LEFT OUTER JOIN DONGNE2 b ON a.ID = b.DONGNE1_ID ORDER BY a.id, b.id;

CREATE OR REPLACE VIEW dongne_view AS
SELECT a.id AS d1id , a.name AS d1name, b.name AS d2name, b.id AS d2id FROM dongne1 a 
LEFT OUTER JOIN DONGNE2 b ON a.ID = b.DONGNE1_ID ORDER BY a.id, b.id;

SELECT id, name FROM DONGNE1;
SELECT id, dongne1_id, name FROM DONGNE2 WHERE DONGNE1_ID = 1;

SELECT d1id, d1name, d2name, d2id FROM dongne_view;
DROP SEQUENCE dongne1_seq;
DROP SEQUENCE dongne2_seq;


CREATE SEQUENCE dongne1_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1;

CREATE SEQUENCE dongne2_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1;

INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '서울특별시'); --1
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '부산광역시'); --2
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '대구광역시'); --3
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '인천광역시'); --4
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '광주광역시'); --5
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '대전광역시'); --6
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '울산광역시'); --7
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '세종특별자치시'); --8
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '경기도'); --9
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '강원도'); --10
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '충청북도'); --11
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '충청남도'); --12
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '전라북도'); --13
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '전라남도'); --14
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '경상북도'); --15
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '경상남도'); --16
INSERT INTO DONGNE1 VALUES (dongne1_seq.nextval, '제주특별자치도'); --17

SELECT * FROM dongne1;

--서울특별시 
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '종로구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '중구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '용산구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '성동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '광진구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '동대문구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '중랑구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '성북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '강북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '도봉구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '노원구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '은평구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '서대문구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '마포구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '영천구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '강서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '구로구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '금천구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '영등포구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '동작구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '관악구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '서초구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '강남구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '송파구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 1, '강동구');

--부산광역시
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '중구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '영도구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '부산진구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '동래구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '남구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '해운대구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '사하구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '금정구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '강서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '연제구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '수영구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '사상구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 2, '기장군');

--대구광역시
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '중구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '남구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '수성구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '달서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 3, '달성군');

--인천광역시
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '중구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '미추홀구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '연수구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '남동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '부평구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '계양구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '강화군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 4, '옹진군');

--광주광역시
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 5, '동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 5, '서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 5, '남구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 5, '북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 5, '광산구');

--대전광역시
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 6, '동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 6, '중구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 6, '서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 6, '유성구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 6, '대덕구');

--울산광역시
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 7, '중구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 7, '남구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 7, '동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 7, '북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 7, '울주군');

--세종특별자치시 
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '가람동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '고운동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '금남면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '나성동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '다정동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '대평동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '도담동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '반곡동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '보람동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '부강면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '새롬동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '소담동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '소정면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '아름동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '어진동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '연기면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '연동면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '연서면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '장군면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '전동면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '전의면');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '조치원읍');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '종촌동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '한솔동');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 8, '해밀동');

--경기도 
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '수원시 권선구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '수원시 장안구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '수원시 영통구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '수원시 팔달구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '성남시 분당구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '성남시 수정구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '성남시 중원구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '고양시 덕양구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '고양시 일산동구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '고양시 일산서구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '용인시 기흥구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '용인시 수지구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '용인시 처인구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '부천시 소사구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '부천시 원미구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '부천시 오정구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '안산시 단원구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '안산시 상록구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '안양시 동안구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '안양시 만안구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '남양주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '화성시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '평택시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '의정부시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '시흥시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '파주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '광명시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '김포시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '군포시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '광주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '이천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '양주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '오산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '구리시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '안성시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '포천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '의왕시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '하남시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '여주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '양평군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '동두천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '과천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '가평군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 9, '연천군');

--강원도 10
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '춘천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '원주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '강릉시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '동해시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '태백시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '속초시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '삼척시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '홍천군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '횡성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '영월군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '평창군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '정선군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '철원군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '화천군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '양구군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '인제군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '고성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 10, '양양군');

-- 충북11
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '청주시 상당구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '청주시 서원구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '청주시 청원구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '청주시 흥덕구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '충주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '제천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '보은군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '옥천군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '영동군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '진천군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '괴산군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '음성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '단양군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 11, '중평군');

-- 충남12
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '천안시 동남구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '천안시 서북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '공주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '보령시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '아산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '서산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '논산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '계룡시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '당진시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '금산군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '부여군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '서천군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '청양군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '홍성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '예산군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 12, '태안군');

--전북 13
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '전주시 덕진구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '전주시 완산구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '군산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '익산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '정읍시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '남원시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '김제시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '완주군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '진안군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '무주군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '장수군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '임실군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '순창군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '고창군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 13, '부안군');

--전남 14 
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '목포시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '여수시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '순천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '나주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '광양시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '담양군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '곡성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '구례군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '고흥군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '보성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '화순군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '장흥군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '강진군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '해남군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '영암군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '무안군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '함평군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '영광군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '장성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '완도군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '진도군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 14, '신안군');


-- 15 경북
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '포항시 남구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '포항시 북구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '경주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '김천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '안동시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '구미시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '영주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '영천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '상주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '문경시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '경산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '군위군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '의성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '청송군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '영양군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '영덕군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '청도군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '고령군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '성주군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '칠곡군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '예천군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '봉화군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '울진군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 15, '울릉군');

--16 경남 
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '창원시 마산합포구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '창원시 마산회원구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '창원시 성산구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '창원시 의창구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '창원시 진해구');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '진주시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '통영시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '사천시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '김해시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '밀양시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '거제시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '양산시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '의령군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '함안군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '창녕군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '고성군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '남해군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '하동군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '산청군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '함양군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '거창군');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 16, '합천군');

--17 제주
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 17, '서귀포시');
INSERT INTO dongne2 VALUES (dongne2_seq.nextval, 17, '제주시');
