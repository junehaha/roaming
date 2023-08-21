
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.colorinfoyellow{
   background-color:#f2c064;
}
.colorinfoblue{
   background-color: #1c50d8;
}
.colorinfored{
   background-color: red;
}
.offcanvas-body{
   overflow :hidden;

}

</style>
<link href='../resources/fullcalendar/main.css' rel='stylesheet' />
 <script src='../resources/fullcalendar/main.js'></script>
 <link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous">
<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' rel='stylesheet'>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
   const hotelId = new URLSearchParams(location.search).get("id");
   
function getTimeLine(){
   const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status ==200){
         const response= JSON.parse(xhr.responseText);
         var calendarEl = document.getElementById('calendar');
         var getEvents = [];
            for(reserve of response.timeLine){
              if (reserve.status == "예약") {
                 reserve.color = '#f2c064';
              }else if(reserve.status == "입실"){
                 reserve.color = '#1c50d8';
              }else if(reserve.status == "취소"){
                 reserve.color = '#969696';
              }else{
                 reserve.color = 'red';
              }
             getEvents.push(reserve);
          }
            console.log(getEvents);
          var calendar = new FullCalendar.Calendar(calendarEl, {
             eventClick:  function(info) {
                console.log(info.event.id)
               getTimeLineDetail(info) 
             },
               // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
               themeSystem: 'bootstrap5',
               headerToolbar: {
                   left: 'prev,next',
                   center: 'title',
                   right: 'today dayGridMonth,dayGridWeek,dayGridDay'
               },
               selectable: true,
               selectMirror: true,

               navLinks: true, // can click day/week names to navigate views

               dayMaxEvents: true, // allow "more" link when too many events
               // 이벤트 객체 필드 document : https://fullcalendar.io/docs/event-object
               events: getEvents
               ,
               height:800,
               buttonText: {
                  prev : '이전 달',
                  next : '다음 달',
                   today: 'Today', 
                   month: '월', 
                   week: '주',
                   day: '일' 
                 },
               titleFormat: function (date) {
                   year = date.date.year;
                   month = date.date.month + 1;

                   return year + "년 " + month + "월";
                 }
          });
         
           calendar.render();
      }
   }
    xhr.open("get","./getTimeLine?hotel_id="+hotelId);
    xhr.send();
}   

function getTimeLineDetail(info) {
    // info.event.id 는  예약아이디
     const modal = bootstrap.Offcanvas.getOrCreateInstance("#offcanvasRight");
     const modalBody = document.getElementById("modalBody");
     const xhr = new XMLHttpRequest();
     
     const userNameBox = document.getElementById("userName");
     const phoneNumberBox = document.getElementById("phoneNumber");
     const statusBox = document.getElementById("status");
     const tidBox = document.getElementById("tid");
     const reserveDateBox = document.getElementById("reserveDate");
     const room_groupBox = document.getElementById("room_group");
     const fixedBox = document.getElementById("fixed");
     const startDateBox = document.getElementById("startDate");
     const endDateBox = document.getElementById("endDate");
     const plusOptionBox = document.getElementById("plusOption");
     const finalPriceBox = document.getElementById("finalPrice");
     xhr.onreadystatechange = function(){
        if(xhr.readyState == 4 && xhr.status==200){
           const response = JSON.parse(xhr.responseText);
           const resDate = new Date(response.timeLineDetail.reserveDate);
           const res = resDate.toISOString().split('T')[0];
           
           const startDate = new Date(response.timeLineDetail.startDate);
           const start = startDate.toISOString().split('T')[0];
           
           const endDate = new Date(response.timeLineDetail.endDate);
           const end = endDate.toISOString().split('T')[0];
           
           
           userNameBox.innerText = response.timeLineDetail.userName;
           phoneNumberBox.innerText = response.timeLineDetail.phoneNumber;
           if(response.timeLineDetail.status == "예약"){
              statusBox.classList.add("text-warning");
              statusBox.classList.remove("text-danger","text-primary","text-secondary");
              statusBox.innerText = response.timeLineDetail.status;
           }else if(response.timeLineDetail.status == "퇴실"){
              statusBox.classList.add("text-danger");
              statusBox.classList.remove("text-warning","text-primary","text-secondary");
              statusBox.innerText = response.timeLineDetail.status;
           }else if(response.timeLineDetail.status == "취소"){
              statusBox.classList.add("text-secondary");
              statusBox.classList.remove("text-warning","text-primary","text-danger");
              statusBox.innerText = response.timeLineDetail.status;
           }else{
              statusBox.classList.add("text-primary");
              statusBox.classList.remove("text-warning","text-danger","text-secondary");
              statusBox.innerText = response.timeLineDetail.status;
           }
           tidBox.innerText = response.timeLineDetail.tid;
           reserveDateBox.innerText = res;
           if(response.timeLineDetail.roomNumber != 0){
              room_groupBox.classList.remove()
            room_groupBox.innerText = response.timeLineDetail.roomGroupName    + "("+response.timeLineDetail.roomNumber+")";
           }else
           room_groupBox.innerText = response.timeLineDetail.roomGroupName;
           fixedBox.innerText = response.timeLineDetail.fixedNumber +"인";
           startDateBox.innerText = start;
           endDateBox.innerText = end;
           var optionNumber =0;
           plusOption.innerText = optionNumber  +"개";
           if(response.timeLineDetail.optionList != null){
              for(option of response.timeLineDetail.optionList){
                 optionNumber += 1;
              }
              if(optionNumber >= 1){ 
                 const span = document.createElement("span");
                 span.classList.add("dropup","dropup-center");
                 const button =document.createElement("button");
                 button.classList.add("btn","btn-light","dropdown-toggle")
                 button.setAttribute("data-bs-toggle","dropdown");
                 button.setAttribute("aria-expanded","false");
                 button.innerText = '펼치기';
                 span.appendChild(button);
                 
                 const ul = document.createElement("ul");
                 ul.classList.add("dropdown-menu");
                 span.appendChild(ul);
                 for(option of response.timeLineDetail.optionList){
                    const li = document.createElement("li");
                    li.classList.add("dropdown-item");
                    li.innerText = option.options;
                    ul.appendChild(li);
                 }
                 plusOption.innerText = optionNumber +"개";
                 plusOption.appendChild(span);
              }
           }
           finalPriceBox.innerText = response.timeLineDetail.finalPrice.toLocaleString() +"원";
           
           
           modal.show();
        }
     }
     xhr.open("get","./getTimeLineDetail?reserve_id="+info.event.id);
     xhr.send();           
}
function domainLink(){
   //현재 날짜 생성
   var currentLink = new Date();
   // 내일
   var nextLink = new Date(currentLink);
   nextLink.setDate(currentLink.getDate() + 1);

   // 월 이름 배열
   var month = [
     "01", "02", "03", "04", "05", "06",
     "07", "08", "09", "10", "11", "12"
   ];

   // 요일 이름 배열
   var day = [
     "일", "월", "화", "수", "목", "금", "토"
   ];

   // 월, 일, 요일 추출
   var currentLinkMonth = month[currentLink.getMonth()];
   var currentLinkDay = currentLink.getDate().toString().padStart(2, '0');
   var currentLinkDayOfWeek = day[currentLink.getDay()];
   var currentLinkYear = currentLink.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
   //내일
   var nextLinkMonth = month[nextLink.getMonth()];
   var nextLinkDay = nextLink.getDate().toString().padStart(2, '0');
   var nextLinkDayOfWeek = day[nextLink.getDay()];
   var nextLinkYear = nextLink.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

   // 변환된 값 출력
   var startDay = currentLinkYear + "/" + currentLinkMonth + "/" + currentLinkDay + "/(" + currentLinkDayOfWeek + ")";
   var endDay = nextLinkYear + "/" + nextLinkMonth + "/" + nextLinkDay + "/(" + nextLinkDayOfWeek + ")";
   var dayDifference = 1;
   
   const domainLink = document.getElementById("domainLink");
   domainLink.href ="../userboard/hotelInfoPage?id="+hotelId+"&startDate="+startDay+"&endDate="+endDay+"&people="+2+"&dayDifference="+dayDifference;
}
   window.addEventListener("DOMContentLoaded", function() {
       getTimeLine()
       domainLink()
   });
</script>
</head>
<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col-2 bg-black text-white" style="height: 100;">
            <div class="row mt-5">
               <div class="col-3 mt-4 ps-4 pt-3">
                  <img src="/uploadFiles/${hotelInfo.hotelDto.hotel_img }"
                     style="width: 50px; height: 50px; border-radius: 50%;">
               </div>
               <div class="col-9">
                  <div class="row">
                     <div class="col fw-semibold fs-6 pt-3 px-3 small text-secondary">
                        ${hotelInfo.category.category }</div>
                     <div class="col text-end small pe-3 fs-6 pt-2">
                        <a class="btn btn-dark btn-sm" href="./sellerHotelListPage">숙소변경</a>
                     </div>
                  </div>
                  <div class="row pt-0">
                     <div class="col fw-semibold fs-6 pt-2 px-3">
                        ${hotelInfo.hotelDto.hotel_name}</div>
                  </div>
               </div>
            </div>
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">숙소/예약관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerMainPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-house fs-4 pt-5 text-secondary"></i><span
                     class="px-3 text-white fs-5 pt-0">홈</span>
                     </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerReserveListPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-card-list fs-4 text-secondary pt-5"></i><span
                     class="px-3 text-white fs-5 pt-0">예약목록</span>
               </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerTimeLinePage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-calendar fs-4  text-info  pt-5"></i><span
                     class="px-3 text-white fs-5 pt-0">타임라인</span>
                  </a>
               </div>
            </div>

            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerPriceSettingPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-wallet fs-4 text-secondary pt-5"></i><span
                     class="px-3 text-white fs-5 pt-0">날짜별 요금조정</span>
                  </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerHotelManagePage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-gear fs-4 text-secondary pt-5"></i><span
                     class="px-3 text-white fs-5 pt-0">방 관리</span>
                  </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerDashBoardPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i><span
                     class="px-3 text-white fs-5 pt-0">대시보드</span>
                     </a>
               </div>
            </div>
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">홈페이지 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a  style="text-decoration: none" id="domainLink">
<i class="bi bi-signpost fs-4 text-secondary pt-5"></i><span
class="ps-3 text-white fs-5 pt-0">도메인 연결</span>
</a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <i class="bi bi-clipboard fs-4 text-secondary pt-5"></i><span
                     class="px-3 text-white fs-5 pt-0">리뷰 관리</span>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i><span
                     class="px-3 text-white fs-5 pt-0">문의/요청</span>
               </div>
            </div>
         </div>
         <div class="col bg-secondary bg-opacity-10 info-scroll-container">
            <div class="row mt-4"></div>
            <div class="row ms-3 border-bottom pb-3">
               <div class="col fw-bold fs-3">
                  <i class="bi bi-calendar pe-4"></i>타임라인
               </div>
            </div>
            <div class="row mt-3">
               <!-- 날짜, 숫자정보 -->
               <div class="col">
                  <div class="card">
                   <div class="card-title"><div class="row">
                      <div class="col ms-3 mt-2"> 
                         <span class="badge colorinfoblue">입실</span>
                        <span class="badge colorinfored">퇴실</span>
                        <span class="badge colorinfoyellow">예약</span>
                        <span class="badge" style="background-color:    #969696">취소</span>
                     </div>
                   </div>
                   <div class="row">
                      <div class="col small ms-3 pt-1 pb-0 fw-semibold">
                         <i class="bi bi-search"></i> 클릭 시 자세한 정보를 볼 수 있습니다.
                      </div>
                   </div>
                   </div>
                     <div class="card-body">
                        <div class="row">
                           <div class="col" id="calendar"></div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            </div>
         </div>

      </div>
   
   <link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"></script>






<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
  <div class="offcanvas-body p-0"  id="modalBody">
    <div class="row mb-3 border-bottom px-3 pt-3 pb-3">
           <div class="col fs-4 pt-4 fw-semibold">예약상세</div>
           <div class="col text-end fs-3 text-secondary pt-3
           "  data-bs-dismiss="offcanvas" aria-label="Close"><i class="bi bi-x fs-2"></i></div>
        </div>
             <div class="row mt-5 px-3">
                <div class="col pt-1 text-secondary">예약자</div>
                <div class="col fs-5 fw-semibold text-end" id="userName">황준하</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">연락처</div>
                <div class="col fs-5 fw-semibold text-end" id="phoneNumber">01030757022</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">상태</div>
                <div class="col fs-5 fw-semibold text-end text-warning" id="status">예약완료</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">결제수단</div>
                <div class="col fs-5 fw-semibold text-end">카카오페이</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">예약번호</div>
                <div class="col fs-5 fw-semibold text-end" id="tid">15153515</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">예약일</div>
                <div class="col fs-5  text-end" id="reserveDate">23/07/10</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col-2 pt-1 text-secondary">객실</div>
                <div class="col fs-5 fw-semibold text-end" id="room_group"></div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">인원</div>
                <div class="col fs-5 fw-semibold text-end text-primary" id="fixed">2인</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">입실일</div>
                <div class="col fs-5 fw-semibold text-end" id="startDate">23/07/12</div>
             </div>
             <div class="row mt-4 border-bottom pb-5 px-3">
                <div class="col pt-1 text-secondary">퇴실일</div>
                <div class="col fs-5 fw-semibold text-end" id="endDate">23/07/14</div>
             </div>
             <div class="row mt-4 px-3">
                <div class="col pt-1 text-secondary">추가옵션</div>
                <div class="col fs-6 fw-semibold text-end" id="plusOption">3개 펼치기</div>
             </div>
             <div class="row mt-4  px-3">
                <div class="col pt-1 fs-4 fw-semibold">총 금액</div>
                <div class="col fs-3 fw-semibold text-end text-primary" id="finalPrice">75,000원</div>
             </div>
  </div>
</div>

<!-- 예약정보 모달 -->
<!-- <div class="modal right fade" id="infoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog  modal-dialog-right">
    <div class="modal-content">
 
      <div class="modal-body" id="modalBody">
         <div class="row mb-3 border-bottom">
           <div class="col fs-4 pt-1 fw-semibold">예약상세</div>
           <div class="col text-end fs-3 text-secondary pb-3" data-bs-dismiss="modal" aria-label="Close">X</div>
        </div>
             <div class="row mt-5">
                <div class="col pt-1 text-secondary">예약자</div>
                <div class="col fs-5 fw-semibold text-end" id="userName">황준하</div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">연락처</div>
                <div class="col fs-5 fw-semibold text-end" id="phoneNumber">01030757022</div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">상태</div>
                <div class="col fs-5 fw-semibold text-end text-warning" id="status">예약완료</div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">결제수단</div>
                <div class="col fs-5 fw-semibold text-end">카카오페이</div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">예약번호</div>
                <div class="col fs-5 fw-semibold text-end" id="tid">15153515</div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">예약일</div>
                <div class="col fs-5  text-end" id="reserveDate">23/07/10</div>
             </div>
             <div class="row mt-4">
                <div class="col-2 pt-1 text-secondary">객실</div>
                <div class="col fs-5 fw-semibold text-end" id="room_group"></div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">인원</div>
                <div class="col fs-5 fw-semibold text-end text-primary" id="fixed">2인</div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">입실일</div>
                <div class="col fs-5 fw-semibold text-end" id="startDate">23/07/12</div>
             </div>
             <div class="row mt-4 border-bottom pb-5">
                <div class="col pt-1 text-secondary">퇴실일</div>
                <div class="col fs-5 fw-semibold text-end" id="endDate">23/07/14</div>
             </div>
             <div class="row mt-4">
                <div class="col pt-1 text-secondary">추가옵션</div>
                <div class="col fs-6 fw-semibold text-end" id="plusOption">3개 펼치기</div>
             </div>
             <div class="row mt-4 mb-4">
                <div class="col pt-1 fs-4 fw-semibold">총 금액</div>
                <div class="col fs-3 fw-semibold text-end text-primary" id="finalPrice">75,000원</div>
             </div>                        
      </div>
      <div class="modal-footer p-0 m-0">
        <div  class="bg-primary bg-opacity-75 py-3 fs-4 text-white text-center m-0 w-100" data-bs-dismiss="modal">닫기</div>    
      </div>
    </div>
  </div>
</div> -->
</body>
</html>