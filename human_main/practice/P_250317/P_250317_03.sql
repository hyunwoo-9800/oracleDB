-- 상품관리 
CREATE TABLE EC_PRODUCT (
    PRODUCT_CODE VARCHAR2(10) NOT NULL PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(20) NOT NULL,
    STANDARD     VARCHAR2(20),
    UNIT         VARCHAR2(10),
    UNIT_PRICE   NUMBER(7) NOT NULL,
    LEFT_QTY     NUMBER(5) NOT NULL,
    COMPANY      VARCHAR2(20),
    LMAGENAME    VARCHAR2(20),
    INFO         VARCHAR2(20),
    DEFTAIL_INFO VARCHAR2(255)
);

-- 회원관리
CREATE TABLE EC_MEMBER (
    USER_ID   VARCHAR2(10) NOT NULL PRIMARY KEY,
    PASSWD    VARCHAR2(10) NOT NULL,
    NAME      VARCHAR2(10),
    REGIST_NO VARCHAR2(14),
    EMAIL     VARCHAR2(20),
    TELEPHONE VARCHAR2(13) NOT NULL,
    ADDRESS   VARCHAR2(40),
    BUYCASH   NUMBER(9) DEFAULT 0,
    TIMESTAMP DATE DEFAULT SYSDATE
);


ALTER TABLE EC_MEMBER ADD CONSTRAINT EC_MEMBER_REGIST_NO UNIQUE(REGIST_NO);

--장바구니
CREATE TABLE EC_BASKET (
    ORDER_NO     VARCHAR2(10) NOT NULL PRIMARY KEY,
    ORDER_ID     VARCHAR2(10) NOT NULL,
    PRODUCT_CODE VARCHAR2(10) NOT NULL,
    ORDER_QTY    NUMBER(3) NOT NULL,
    ORDER_DATE   DATE DEFAULT SYSDATE,
    CONSTRAINT EC_BASKET_FK1 FOREIGN KEY ( ORDER_ID )
        REFERENCES EC_MEMBER ( USER_ID ),
    CONSTRAINT EEC_BASKET_FK2 FOREIGN KEY ( PRODUCT_CODE )
        REFERENCES EC_PRODUCT ( PRODUCT_CODE )
);

-- 주문처리
CREATE TABLE EC_ORDER (
    ORDER_NO     VARCHAR2(10) NOT NULL PRIMARY KEY,
    ORDER_ID     VARCHAR2(10) NOT NULL,
    PRODUCT_CODE VARCHAR2(10) NOT NULL,
    ORDER_QTY    NUMBER(3) NOT NULL,
    CSEL         VARCHAR2(10),
    CMONEY       NUMBER(9),
    CDATE        DATE,
    MDATE        DATE,
    GUBUN        VARCHAR2(10)
);

--자유 게시판
CREATE TABLE BOARD (
    B_ID      NUMBER(5) NOT NULL PRIMARY KEY,
    B_NAME    VARCHAR2(20) NOT NULL,
    B_PWD     VARCHAR2(20) NOT NULL,
    B_EMAIL   VARCHAR2(20) NOT NULL,
    B_TITLE   VARCHAR2(80) NOT NULL,
    B_CONTENT VARCHAR2(2000) NOT NULL,
    B_DATE    DATE DEFAULT SYSDATE,
    B_HIT     NUMBER(5) DEFAULT 0,
    B_IP      VARCHAR2(15)
);

-- 자유 게시판 수정

-- 위의 테이블에서 답변형 게시판에 필요한 컬럼을 Board 테이블에 추가해 주세요
ALTER TABLE BOARD ADD B_REF NUMBER(5) DEFAULT 0;

ALTER TABLE BOARD ADD B_STEP NUMBER(5) DEFAULT 0;

ALTER TABLE BOARD ADD B_ORDER NUMBER(5) DEFAULT 0;

-- Board 테이블의 제목(B_Title)의 컬럼 길이를 100자로 늘려주세요
ALTER TABLE BOARD MODIFY (
    B_TITLE VARCHAR2(100)
);

-- Board 테이블의 비밀번호(B_Pwd) 칼럼을 NULL 로 수정하시오
ALTER TABLE BOARD MODIFY (
    B_PWD NULL
);

-- Board 테이블의 동일 게시물번호(B_Step) 컬럼명을 B_Level 로 변경해 주세요 
ALTER TABLE BOARD RENAME COLUMN B_STEP TO B_LEVEL;

-- Board 테이블의 IP주소(B_Ip) 컬럼을 삭제해 주세요
ALTER TABLE BOARD DROP COLUMN B_IP;

-- 회원관리(EC_Member) 테이블의 회원 Id(UserId) 컬럼에 영소문자(a부터 z까지) 로 제한해 주세요.
ALTER TABLE EC_MEMBER ADD (
    CONSTRAINT MEMBER_CK CHECK ( USER_ID BETWEEN 'a' AND 'z' )
);

INSERT INTO EC_MEMBER (
    USER_ID,
    PASSWD,
    NAME,
    REGIST_NO,
    TELEPHONE
) VALUES ( 'srlee',
           '1234',
           '이소라',
           '821001-2000000',
           '010-1234-1234' );

INSERT INTO EC_MEMBER (
    USER_ID,
    PASSWD,
    NAME,
    REGIST_NO,
    TELEPHONE
) VALUES ( '20park',
           '1234',
           '박연수',
           '810604-2100000',
           '010-2345-2345' );

INSERT INTO EC_MEMBER (
    USER_ID,
    PASSWD,
    NAME,
    REGIST_NO,
    TELEPHONE
) VALUES ( 'z',
           '1234',
           'jjj',
           '810604-2100000',
           '010-2345-2345' );

SELECT
    *
FROM
    EC_MEMBER;

-- 주문처리(EC_Order) 테이블의 기본 키를 삭제해 주세요
ALTER TABLE EC_ORDER DROP PRIMARY KEY;

-- Board 테이블의 B_Email 컬럼에 유일성(unique) 제약조건을 추가해 주세요
CREATE UNIQUE INDEX "EMAIL_UK" ON
    BOARD (
        B_EMAIL
    );

-- Board 테이블을 Free_Board 테이블명으로 변경해 주세요
ALTER TABLE BOARD RENAME TO FREE_BOARD;

-- 장바구니(EC_Basket) 테이블을 삭제해 주세요
DROP TABLE EC_BASKET;