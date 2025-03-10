# 📚 중고 교재 및 학용품 거래 플랫폼

## 🏫 프로젝트 개요
새 학기가 시작될 때마다 학생들은 교재와 학용품을 구매해야 합니다. 하지만 새 제품을 구매하는 비용이 부담스러울 수 있습니다. 이를 해결하기 위해 **중고 교재 및 학용품을 거래할 수 있는 온라인 플랫폼**을 개발하였습니다.

이 프로젝트는 사용자들이 중고 교재 및 학용품을 쉽게 판매하고 구매할 수 있도록 지원하며, 직관적인 UI와 원활한 거래 프로세스를 제공합니다.

---

## 🛠 개발 환경
- **프론트엔드**: JavaScript, jQuery, HTML, CSS
- **백엔드**: Java, JSP
- **데이터베이스**: MySQL
- **개발 도구**: Eclipse, HeidiSQL, GitHub

---

## ✨ 주요 기능
✔ **사용자 회원가입 및 로그인**
   - 사용자 정보 수정 및 관리
   
✔ **상품 등록 및 관리**
   - 판매자가 교재 및 학용품을 등록할 수 있음
   - 등록된 상품 정보 수정 및 삭제 가능
   
✔ **상품 검색 및 필터링**
   - 키워드 검색 기능 제공

✔ **실시간 채팅 기능**
   - 구매자와 판매자가 1:1 실시간 채팅으로 거래를 가능
   - 채팅 내역 저장을 통해 거래 내용을 확인 가능
   
✔ **댓글 기능**
   - 댓글을 통해 구매자는 관심 있는 상품에 대해 소통 기능 제공
   - 거래 완료 후, 구매자와 판매자가 서로 후기를 남길 수 있음

✔ **찜하기 및 관심 목록**
   - 관심 있는 상품을 찜하고 쉽게 접근할 수 있는 기능 제공

---

## 📷 프로젝트 관련 자료
![image](https://github.com/HONG0805/kangnamMarket/assets/112541200/05759b39-67d7-4d17-825d-2708459c6420)


## ✔**로그인 및 메인홈**

![image](https://github.com/user-attachments/assets/af64c07d-b26c-4967-bb63-0b121c9b987f)
![image](https://github.com/user-attachments/assets/15672640-335d-459f-84cb-a8c47d171a49)


## ✔**게시물 및 게시물 작성**

![image](https://github.com/user-attachments/assets/e5808055-4c38-4c55-829c-941120224be3)
![image](https://github.com/user-attachments/assets/4f75a344-0bae-4fe7-94af-8c2de41c7c9c)


## ✔**마이페이지 및 채팅**

![image](https://github.com/user-attachments/assets/4c14f189-fa1e-49cc-92d5-fbc64b5ac2e0)
![image](https://github.com/user-attachments/assets/48c95dc7-afad-4df1-bf5f-29daf4bc295d)


## ✔**검색 및 페이징**

![image](https://github.com/user-attachments/assets/ceccb953-af36-4e19-a672-d492ce06e21b)
![image](https://github.com/user-attachments/assets/367e1bab-7135-4fd9-82cb-b7db2ce7c2d9)


---

## 🗄 데이터베이스 구조(ERD)
<details><summary><strong>erDiagram</strong>(보기)</summary>
   
    USER ||--o{ BBS : "등록"
    USER {
        VARCHAR(255) userID PK
        VARCHAR(255) userPassword
        VARCHAR(100) userEmail
        VARCHAR(100) userName
    }
    
    BBS {
        INT(10) bbsID PK
        VARCHAR(100) bbsTitle
        VARCHAR(255) userID FK
        TIMESTAMP bbsDate
        MEDIUMTEXT bbsContent
        INT(10) bbsAvailable
        INT(10) cost
    }
    
    BBS ||--o{ REPLY : "댓글"
    BBS ||--o{ JJIM : "찜"
    BBS ||--o{ CHATROOM : "채팅방"
    
    REPLY {
        INT(10) replyID PK
        INT(10) bbsID FK
        TEXT replyContent
        VARCHAR(50) userID
        INT(10) replyAvailable
        DATETIME replyDate
    }
    
    JJIM {
        INT(10) bbsID PK,FK
        VARCHAR(255) userID PK,FK
    }
    
    CHATROOM ||--o{ MESSAGE : "메시지"
    USER }o--o{ CHATROOM : "참여"
    
    CHATROOM {
        INT(10) roomID PK
        INT(10) bbsID FK
        VARCHAR(255) user_1_id FK
        VARCHAR(255) user_2_id FK
        DATETIME created_at
    }
    
    MESSAGE {
        INT(10) messageID PK
        INT(10) roomID FK
        VARCHAR(255) userID FK
        TEXT message
        DATETIME created_at
    }
</details>

## 🔗 관계형 모델 특징
✅**N:M 관계**
- JJIM 테이블을 통해 사용자-게시물 찜 관계 구현
- CHATROOM을 통해 1:1 채팅 관리

✅**계층적 구조**
- 게시물(BBS) → 댓글(REPLY)
- 채팅방(CHATROOM) → 메시지(MESSAGE)

✅**참조 무결성**
- 모든 FK에 ON DELETE/UPDATE 제약 조건 적용
- CASCADE 대신 NO ACTION으로 데이터 보호

## 💡 개발 목표 및 기대 효과
- **합리적인 가격**으로 교재 및 학용품을 거래할 수 있도록 지원
- **학생 중심의 편리한 UI/UX 제공**
- **효율적인 중고 거래 시스템 구축**으로 불필요한 낭비 감소
- **안전한 거래 환경 제공**
- **실시간 소통 강화**로 채팅 기능을 통해 구매자와 판매자 간 즉각적인 의사소통 가능

📢 해당 프로젝트는 지속적으로 업데이트될 예정입니다. 피드백이나 제안 사항이 있다면 언제든지 공유해주세요! 😊







