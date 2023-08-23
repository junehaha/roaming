# Roaming


<div align="center"><img width="400"  alt="originalLogo" src="https://github.com/junehaha/roaming/assets/131428230/734bedd4-5dd8-4731-a063-59da0bd3ef58"></div>


## 🖥️ 프로젝트 소개
### 1️⃣ 사이트 소개

로밍은 같이 여행을 떠날  동행을 구하고 
커뮤니티도 활성화 되어있고 숙소예약도 가능하며 
자체 포인트로 상품을 구매 할 수 있고 
사이트 자체 서비스인 짐 배달 서비스를 
이용 할 수 있는 여행 플랫폼 입니다.

### 2️⃣ 타겟 사용자

여행을 좋아하고 새로운 인연을 찾고자 하는 모든 사람

### 3️⃣ 사이트 주요 기능

- 유저 / 파트너 로그인 회원가입
- 동행 : 함께 여행을 떠날 동행자를 구할 수 있다.
- 숙소 예약 : 사이트에 등록된 숙소를 예약 할 수 있다.
- 커뮤니티 : 사이트 이용자들의 여행관련 SNS
- 포인트 샵 : 사이트 이용 시 획득 할 수 있는 포인트로 기프티콘을 구입을 할 수 있다.
- 짐 배달 서비스 : 신청한 위치로 짐을 배달 할 수 있는 서비스
- 파트너 : 숙소 등록부터 관리 / 통계 서비스를 이용 할 수 있는 파트너
- 관리자 : 사이트 게시물, 판매자, 짐 배달 서비스, 쿠폰 및 상품을 관리 하는 관리자

<br>

### 🕰️ 개발 기간
* 2023.06 ~ 2023.08 (2개월)
<br>

### 🧑‍🤝‍🧑 맴버구성/역할
<img width="1337" alt="image" src="https://github.com/junehaha/roaming/assets/131428230/112f67a7-ab2d-4d6b-9ced-f04c661cf336">
<br> 


### ⚙️ 개발 환경
- `Java, JavaScript, JSP`
- **Java Version** : JDK 11
- **IDE** : Eclipse(STS 3.9.18)
- **Framework** : Spring Framework 5.0.7
- **Database** :Oracle 11g XE
<br>

### 📋 ERD / 프로젝트 구조
#### ERD 
  <img width="1280" alt="image" src="https://github.com/junehaha/roaming/assets/131428230/17046d38-36e9-4ccf-ac2b-843687d82825">  
<br> 


<details>
<summary>동행 ERD</summary> 
<img src="https://github.com/junehaha/roaming/assets/131428230/330eeec8-355e-4394-bd9e-e1ecc580f690">
</details>

<details>
<summary>숙소 / 파트너 ERD</summary>
<img src="https://github.com/junehaha/roaming/assets/131428230/e7730ef7-1914-48db-8b60-2fa97044730d">
</details>

<details>
<summary>포인트 샵 / 쿠폰 ERD</summary>
<img src="https://github.com/junehaha/roaming/assets/131428230/4390031b-621d-4807-9d40-8fb5f15962a4">
</details>

<details>
<summary>커뮤니티 ERD</summary>
<img src="https://github.com/junehaha/roaming/assets/131428230/2ae32e65-c97e-4fc4-b33d-3867cc85ad64">
</details>

<details>
<summary>고객센터 / 관리자 / 짐 서비스 ERD</summary>
<img src="https://github.com/junehaha/roaming/assets/131428230/114fef2e-2d99-4ca9-882f-39d45bc8c96d">
</details>
<br> 



#### 기능별 구조화 

<details>
<summary>유저</summary>
<img src="https://github.com/junehaha/roaming/assets/131428230/a52d5dc9-0e2e-439c-9497-4aa19e38d51d">
</details>

<details>
<summary>판매자(파트너)</summary>
<img src="https://github.com/junehaha/roaming/assets/131428230/d7dc2e7e-320b-49a3-9b4a-c7276fd8c289">
</details>

<details>
<summary>관리자</summary>
<img src="https://github.com/junehaha/roaming/assets/131428230/c90d45e6-e1bd-4fe2-8d8b-b43eade51b5c">
</details>
<br> 


## 📌 주요 기능
### 👥 로밍 유저
#### Main(User) - <a href="https://github.com/junehaha/roaming/wiki/Main-(User)" >상세보기 - WIKI 이동</a>
- Main Page
- 로그인 / 회원가입
- My Page
#### 동행 - <a href="https://github.com/junehaha/roaming/wiki/%EB%8F%99%ED%96%89" >상세보기 - WIKI 이동</a>
- 동행 메인 페이지
- 동행 상세 보기
- 동행 생성 / 신청
- 동행 대화
#### 숙소 - <a href="https://github.com/junehaha/roaming/wiki/%EC%88%99%EC%86%8C-%EC%98%88%EC%95%BD" >상세보기 - WIKI 이동</a>
- 숙소 메인 페이지
- 숙소 상세 보기
- 숙소 예약 / 결제

#### 커뮤니티 - <a href="https://github.com/junehaha/roaming/wiki/%EC%BB%A4%EB%AE%A4%EB%8B%88%ED%8B%B0" >상세보기 - WIKI 이동</a>
- 커뮤니티 홈
- 커뮤니티 게시물 작성 / 상세
- 프로필 / 메시지

#### 쿠폰 발급 / 포인트 샵 - <a href="https://github.com/junehaha/roaming/wiki/%EC%BF%A0%ED%8F%B0---%ED%8F%AC%EC%9D%B8%ED%8A%B8-%EC%83%B5" >상세보기 - WIKI 이동</a>
- 쿠폰 목록 페이지 / 발급
- 포인트 샵 홈
- 상품 상세 보기
- 상품 구매
#### 짐 배달 서비스 - <a href="https://github.com/junehaha/roaming/wiki/%EC%A7%90-%EC%84%9C%EB%B9%84%EC%8A%A4" >상세보기 - WIKI 이동</a> 
- 짐 서비스 홈
- 짐 서비스 신청 / 결제

#### 고객센터 - <a href="https://github.com/junehaha/roaming/wiki/%EA%B3%A0%EA%B0%9D%EC%84%BC%ED%84%B0" >상세보기 - WIKI 이동</a> 
- 공지사항 / 자주하는 질문
- 묻고 답하기
- 문의글 보기 / 쓰기

---- 
###  🏨 로밍 파트너
#### 파트너 - <a href="https://github.com/junehaha/roaming/wiki/%ED%8C%8C%ED%8A%B8%EB%84%88" >상세보기 - WIKI 이동</a> 
- 파트너 로그인 / 가입
- 숙소 등록
- 숙소 관리 / 통계
----
###  🛠 로밍 관리자
#### 관리자 - <a href="https://github.com/junehaha/roaming/wiki/%EA%B4%80%EB%A6%AC%EC%9E%90" >상세보기 - WIKI 이동</a> 
- 관리자 대시보드
- 판매자(파트너) 관리
- 쿠폰 / 포인트 샵 관리
- 고객센터 관리
- 신고 관리
