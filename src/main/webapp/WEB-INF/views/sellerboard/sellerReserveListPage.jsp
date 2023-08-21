

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>



<style>
.modal.right .modal-dialog {
  margin-left: auto;
  margin-right: 0;
  margin-top : 0;
  float: right;
  width : 400px;
   height: auto;
  max-height: 100vh; /* 모달의 최대 높이 제한 해제 */
 
}
.choiceDay{
   background-color: #5ABEFF;
   border-radius : 50%;
}

#dropBox {
  background: none;
  border: none;
  color: inherit;
  cursor: pointer;
  text-decoration: none;
}
.scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 611px; /* 스크롤 영역의 높이 설정 */
}

.scroll-container:hover {
  overflow: auto; /* 마우스 호버 시 스크롤 보이기 */
}

/* 수직 스크롤 바 스타일 */
.scroll-container::-webkit-scrollbar {
  width: 4px;
}

.scroll-container::-webkit-scrollbar-track {
  background-color: #f1f1f1;
}

.scroll-container::-webkit-scrollbar-thumb {
  background-color: #888;
  border-radius: 4px;
}

.scroll-container::-webkit-scrollbar-thumb:hover {
  background-color: #555;
}


.info-scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 936px; /* 스크롤 영역의 높이 설정 */
}

.info-scroll-container:hover {
  overflow: auto; /* 마우스 호버 시 스크롤 보이기 */
}

/* 수직 스크롤 바 스타일 */
.info-scroll-container::-webkit-scrollbar {
  width: 4px;
}

.info-scroll-container::-webkit-scrollbar-track {
  background-color: #f1f1f1;
}

.info-scroll-container::-webkit-scrollbar-thumb {
  background-color: #888;
  border-radius: 4px;
}

.info-scroll-container::-webkit-scrollbar-thumb:hover {
  background-color: #555;
}









.back-color-sun{
    background-color:#58ACFA;
}
.back-color-rain{
    background-color:#506EA5;
}
.back-color-cloud{
    background-color:#B4B4DC;
}
.weather-icon{
   font-size: 600%;
}

#myLink {
  color: white; /* 기본 색상 */
}

#myLink:hover {
  color: white; /* hover할 때 변경될 색상 */
}

#myLink:active {
  color: white; /* active될 때 변경될 색상 */
}
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
   const hotelId = new URLSearchParams(location.search).get("id");
   
   
    
   var current = new Date();
   var dayValue = "";
   
   
   function getSearchDay(date){
      const dateBox = document.getElementById("dateBox")
      
      
      if(date == 1){
         current.setDate(current.getDate() + 1);
      }else if(date == -1){
         current.setDate(current.getDate() - 1);
      }else if(date != 0){
         console.log(date);
         console.log(date.value);
         const inputDate = date.value
         if(date >100){
            current.setDate(date-100);
            current.setMonth(current.getMonth()+1);
         }else if(date < 0){
            current.setDate(date*-1);
            current.setMonth(current.getMonth()-1);
         }else
            current.setDate(date);
      }
      getCalander()
      const dates = document.getElementsByClassName("date");
      const target = document.getElementById(current.getDate());
      for(date of dates){
         date.classList.remove("choiceDay");
      }
      target.classList.add("choiceDay");
      var month = [
        "01", "02", "03", "04", "05", "06",
        "07", "08", "09", "10", "11", "12"
      ];
      var day = [
        "일", "월", "화", "수", "목", "금", "토"
      ];

      var currentMonth = month[current.getMonth()];
      var currentDay = current.getDate().toString().padStart(2, '0');
      var currentDayOfWeek = day[current.getDay()];
      var currentYear = current.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
      
      var currentday = currentYear + "/" + currentMonth + "/" + currentDay + "/(" + currentDayOfWeek + ")";

      dayValue = currentday

      dateBox.innerText = dayValue;
      getReserveList(dayValue)
   }
      
   function getCalander(){
      const viewYear = current.getFullYear();
      const viewMonth = current.getMonth();
      //현재 년/월 넣기
      const yearmonth = document.getElementById("year-month")
      yearmonth.innerText = `\${viewYear}년 \${viewMonth + 1}월`;
      //지난달 마지막날 , 이번 달 마지막날
      const prevLast = new Date(viewYear, viewMonth,0); // get month는 0부터시작 day는 1부터시작
      const thisLast = new Date(viewYear, viewMonth+1,0);
      
      const PLDate = prevLast.getDate(); // 지난달 마지막날
      const PLDay = prevLast.getDay(); // 지난달 마지막 요일
      
      const TLDate = thisLast.getDate(); // 이번달 마지막날 
      const TLDay = thisLast.getDay(); // 이번달 마지막 요일
      
      //const thisDates = [...Array(TLDate + 1).keys()].slice(1) 에서 인덱스는 0부터 시작하므로 
      //TLDate에 +1 해주어 요소 하나가 추가된 배열을 만들고, slice(1) 을 이용해 1일부터 마지막날까지의 배열로 만든다.
      const prevDates = [];
      const thisDates = [...Array(TLDate + 1).keys()].slice(1);
      const nextDates = [];
      
      if(PLDay != 6){ // 지난달 마지막 요일이 토요일이 아니면(요일 시작이 일요일부터니까) 지난달 날짜들을 넣어준다
         for(var i=0; i< PLDay+1; i++){
            prevDates.unshift(PLDate -i); //지난달 날짜
         }
      }
      for(var i=1; i<7-TLDay; i++){
         nextDates.push(i) // 다음달 날짜 넣어줌 ex) TLday가 5면 금요일이 이번달 마지막이니까, 1일 넣어주기.
      }
      const dates = prevDates.concat(thisDates,nextDates); //concat으로 지난달 이번달 다음달 배열을 합쳐준다.
      
      //화면에 넣어주기
      const firstDateIndex= dates.indexOf(1); // 이번달 1일 인덱스 찾기
      const lastDateIndex = dates.lastIndexOf(TLDate); // 이번달 막날이 인덱스 찾기
      //indexOf(1): dates 배열에서 숫자 1이 처음으로 등장하는 인덱스를 찾습니다. 이는 이번 달의 1일의 인덱스를 반환합니다.
      //lastIndexOf(TLDate): dates 배열에서 TLDate 변수에 저장된 값(이번 달의 막날)이 마지막으로 등장하는 인덱스를 찾습니다. 이는 이번 달의 막날의 인덱스를 반환합니다.
      const dateBox = document.getElementById("dates");
      dateBox.innerHTML ="";
      dates.forEach((date,i) => { //date는  배열 요소의 값 i는 인덱스
         if(i >=firstDateIndex && i < lastDateIndex+1){
            const col = document.createElement("div");
            col.classList.add("d-inline","text-center","fs-5");
            col.style.width = "50px";
            dateBox.appendChild(col);
            
            const span = document.createElement("div");
            span.classList.add("this","date");
            span.innerText = date;
            span.id = date;
            span.setAttribute("onclick","getSearchDay("+date+")")
            col.appendChild(span);
            if(i%7==0){
               span.classList.add("text-danger");
            }
         }else{
            const col = document.createElement("div");
            col.classList.add("d-inline","text-center","fs-5");
            dateBox.appendChild(col);
            col.style.width = "50px"
            const span = document.createElement("div");
            if(i>=lastDateIndex+1){
               span.setAttribute("onclick","getSearchDay("+(date+100)+")")
            }else{
               span.setAttribute("onclick","getSearchDay("+(-date)+")")
            }
            span.classList.add("text-secondary","date");
            span.style.opacity="0.3";
            span.innerText = date;
            col.appendChild(span);
            if(i%7==0){
               span.classList.add("text-danger");
               span.classList.remove("text-secondary");
            }
         }
      })
      const today = new Date();
      
      if(viewMonth == today.getMonth() && viewYear == today.getFullYear()){
         for(date of document.getElementsByClassName("this")){
            if(date.innerText == today.getDate()){
               date.classList.add("choiceDay");
               break;
            }
         }
      }
      
   }
   
   function prevMonth(){
      current.setMonth(current.getMonth()-1);
      getCalander();
   }
   
   function nextMonth(){
      current.setMonth(current.getMonth()+1);
      getCalander();
   }
   
   function goToday(){
      current = new Date();
      getSearchDay(0)
      getCalander();
   }
   
   function getReserveList(reserveDay){
      const xhr =new XMLHttpRequest();
      const reserveListBox =document.getElementById("reserveListBox")
      reserveListBox.innerHTML ="";
      xhr.onreadystatechange = function(){
         if(xhr.readyState==4 && xhr.status==200){
            const response = JSON.parse(xhr.responseText);
            if(response.result == "success"){
               for(reserve of response.info){
                  const row1 = document.createElement("div");
                  row1.classList.add("row","border-bottom");
                  reserveListBox.appendChild(row1);
                  
                  const col1 = document.createElement("div");
                  col1.classList.add("col","text-center","fs-5","pt-3","pb-3");
                  row1.appendChild(col1);
                  
                  const col1Button = document.createElement("button");
                  col1Button.classList.add("btn","text-white","btn-primary");
                  col1Button.type = "button";
                  col1Button.setAttribute("onclick","getTimeLineDetail("+reserve.id+")")
                  col1Button.style.borderRadius ="25%";
                  col1.appendChild(col1Button);
                  
                  const col1Icon = document.createElement("i");
                  col1Icon.classList.add("bi","bi-search","fs-5");
                  col1Button.appendChild(col1Icon);
                  
                  const col2 = document.createElement("div");
                  col2.classList.add("col","text-center","fs-5","pt-4","pb-3","fw-semibold");
                  col2.innerText = reserve.roomGroupName;
                  row1.appendChild(col2);
                  
                  const col3 = document.createElement("div");
                  col3.classList.add("col","text-center","fs-5","pt-3","pb-2");
                  row1.appendChild(col3);
                  
                  const namerow = document.createElement("div");
                  namerow.classList.add("row");
                  col3.appendChild(namerow);
                  
                  const namecol = document.createElement("div");
                  namecol.classList.add("col","small");
                  namecol.innerText = reserve.userName;
                  namerow.appendChild(namecol);
               
                  const phonerow = document.createElement("div");
                  phonerow.classList.add("row");
                  col3.appendChild(phonerow);
                  
                  const phonecol = document.createElement("div");
                  phonecol.classList.add("col","small","text-secondary");
                  phonecol.innerText = reserve.phoneNumber;
                  phonerow.appendChild(phonecol);
                  
                  const col4 = document.createElement("div");
                  col4.classList.add("col","text-center","fs-5","pt-4","pb-3");
                  col4.innerText = reserve.fixedNumber + "인";
                  row1.appendChild(col4);
                  
                  const col5 = document.createElement("div");
                  col5.classList.add("col","text-center","fs-5","pt-3","pb-2");
                  row1.appendChild(col5);
                  
                  
                  
                  for(options of reserve.optionList){
                     const optionrow = document.createElement("div");
                     optionrow.classList.add("row");
                     col5.appendChild(optionrow);
                     const optioncol = document.createElement("div");
                     optioncol.classList.add("col","small");
                     optioncol.innerText = options.options
                     optionrow.appendChild(optioncol);
                  }
                  const col6 = document.createElement("div");
                  col6.classList.add("col","text-center","fs-5","pt-4","pb-3");
                  col6.innerText = reserve.finalPrice.toLocaleString()+"원";
                  row1.appendChild(col6);
                  
                  
                  const startday = new Date(reserve.startDate);
                  const endday = new Date(reserve.endDate);
                  
                  var monthNames = [
                       "01", "02", "03", "04", "05", "06",
                       "07", "08", "09", "10", "11", "12"
                     ];

                  var dayNames = [
                       "일", "월", "화", "수", "목", "금", "토"
                     ];
                  
                  var smonth = monthNames[startday.getMonth()];
                  var sday = startday.getDate().toString().padStart(2, '0');
                  var sdayOfWeek = dayNames[startday.getDay()];
                  var syear = startday.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

                  var emonth = monthNames[endday.getMonth()];
                  var eday =  endday.getDate().toString().padStart(2, '0');
                  var edayOfWeek = dayNames[endday.getDay()];
                  var eyear = endday.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

                  var start = syear + "/" + smonth + "/" + sday + "/(" + sdayOfWeek + ")";
                  var end = eyear + "/" + emonth + "/" + eday + "/(" + edayOfWeek + ")";
                  
                  
                  
                  const col7 = document.createElement("div");
                  col7.classList.add("col","text-center","fs-5","pt-2","pb-3");
                  row1.appendChild(col7);
                  
                  const startrow = document.createElement("div");
                  startrow.classList.add("row");
                  col7.appendChild(startrow);
                  
                  const startcol = document.createElement("div");
                  startcol.classList.add("col","small");
                  startcol.innerText = start;
                  startrow.appendChild(startcol);
               
                  const endrow = document.createElement("div");
                  endrow.classList.add("row");
                  col7.appendChild(endrow);
                  
                  const endcol = document.createElement("div");
                  endcol.classList.add("col","small");
                  endcol.innerText = "- "+end;
                  endrow.appendChild(endcol);
                  
                  const col8 = document.createElement("div");
                  col8.classList.add("col","text-center","fs-5","pt-4","pb-3","fw-semibold");
                  
                  col8.innerText = reserve.status;
                  if(reserve.status == "예약"){
                     col8.classList.add("text-dark");
                     
                  }else if(reserve.status =="입실"){
                     col8.classList.add("text-primary");
                  }else if(reserve.status =="취소"){
                     col8.classList.add("text-secondary");
                  }else 
                     col8.classList.add("text-danger");
                  
                  row1.appendChild(col8);
                  
               }
               
               
            }else{
               const failrow =document.createElement("div");
               failrow.classList.add("row","mt-3","mt-3");
               reserveListBox.appendChild(failrow);
               
               const failcol = document.createElement("div");
               failcol.classList.add("col","text-center","fs-3","fw-semibold");
               failcol.innerText = "예약내역이 없습니다."
               failrow.appendChild(failcol);
            }
         }
      }
      xhr.open("get","./getReserveList?hotel_id="+hotelId+"&date="+reserveDay);
      xhr.send();
   }

   function getTimeLineDetail(id) {
       // info.event.id 는  예약아이디
        const modal = bootstrap.Modal.getOrCreateInstance("#infoModal");
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
                 statusBox.classList.remove("text-warning","text-secondary","text-danger");
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
        xhr.open("get","./getTimeLineDetail?reserve_id="+id);
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
      getSearchDay(0)
      getCalander()
      domainLink()
   });
</script>
</head>
<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col-2 bg-black text-white" style="height: 100vh;">
            <div class="row mt-5">
               <div class="col-3 mt-4 ps-4 pt-3">
                  <img src="/uploadFiles/${hotelInfo.hotelDto.hotel_img }"
                     style="width: 50px; height: 50px; border-radius: 50%;">
               </div>
               <div class="col-9">
                  <div class="row">
                     <div class="col fw-semibold fs-6 pt-3 ps-3 small text-secondary">
                        ${hotelInfo.category.category }</div>
                     <div class="col text-end small pe-3 fs-6 pt-2">
                        <a class="btn btn-dark btn-sm" href="./sellerHotelListPage">숙소변경</a>
                     </div>
                  </div>
                  <div class="row pt-0">
                     <div class="col fw-semibold fs-6 pt-2 ps-3">
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
                  <i class="bi bi-house fs-4 text-secondary pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">홈</span>
                     </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerReserveListPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-card-list fs-4 text-info pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">예약목록</span>
               </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerTimeLinePage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-calendar fs-4 text-secondary pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">타임라인</span>
                  </a>
               </div>
            </div>

            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerPriceSettingPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-wallet fs-4 text-secondary pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">날짜별 요금조정</span>
                  </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerHotelManagePage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-gear fs-4 text-secondary pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">방 관리</span>
                  </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerDashBoardPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">대시보드</span>
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
                     class="ps-3 text-white fs-5 pt-0">리뷰 관리</span>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">문의/요청</span>
               </div>
            </div>
         </div>
         <div class="col bg-secondary bg-opacity-10">
            <div class="row mt-4"></div>
               <div class="row ms-3 border-bottom pb-3">
                  <div class="col fw-bold fs-3">
                     <i class="bi bi-house pe-4"></i>예약목록
                  </div>
               </div>
               <div class="row mt-3">
                  <div class="col">
                           <div class="card">
                           <div class="card-body">
                               <div class="row mt-3">
                                   <div class="col-4 pt-2">
                                       <button type="button" class="btn border border-3 fw-semibold"><i class="bi bi-search fs-6 pe-2"></i><span>조건검색</span></button>
                                    </div>
                                    <div class="col fs-2 fw-semibold ms-5" style="cursor: pointer;">
                                       <span><i class="bi bi-chevron-left" onclick="getSearchDay(-1)"></i></span>
                                       <span id="dateBox" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside"></span>
                                            <ul class="dropdown-menu" aria-labelledby="dateBox" id="searchDropDown" style="border-radius:10%">
                                     <li><div class="dropdown-item" id="dropBox">
                                       <!-- <input type="date" onchange="getSearchDay(this)"> -->
                                       <div class="row">
                                          <div class="col text-center">
                                             <button class="btn fw-semibold fs-5 pb-3 pe-3" onclick='prevMonth()'>&lt;</button>
                                              <span class="fw-semibold fs-4" id="year-month">2023년 7월</span>
                                              <button class="btn fw-semibold fs-5 pb-3 ps-3" onclick='nextMonth()'>&gt;</button>
                                              <span class="btn btn-primary btn-sm text-white mb-2" onclick='goToday()'>Today</span>
                                          </div>
                                       </div>
                                       <div class="row mb-3 fs-5 fw-semibold">
                                          <div class="col text-danger" style="margin-left:12px;">일</div>
                                          <div class="col">월</div>
                                          <div class="col">화</div>
                                          <div class="col">수</div>
                                          <div class="col">목</div>
                                          <div class="col">금</div>
                                          <div class="col text-primary" style="margin-right:10px;">토</div>
                                       </div>
                                       <div class="row" id="dates" style ="width:350px; height:270px; margin:0px 0px 0px 0px;">
                                          
                                       </div>
                                    </div></li>
                                   </ul>
                                       <span><i class="bi bi-chevron-right" onclick="getSearchDay(1)"></i></span>
                                    </div>
                               </div>
                               <div class="row mt-4 bg-secondary bg-opacity-25">
                                   <div class="col text-center fs-5 pt-3  pb-3 fw-semibold">
                                       상세정보
                                    </div>
                                   <div class="col text-center fs-5 pt-3  pb-3 fw-semibold">
                                       객실명
                                    </div>
                                    <div class="col text-center fs-5  pt-3  pb-3 fw-semibold">
                                       예약자
                                    </div>
                                    <div class="col text-center fs-5 pt-3  pb-3 fw-semibold">
                                       객실인원
                                    </div>
                                    <div class="col text-center fs-5 pt-3  pb-3 fw-semibold">
                                       추가옵션
                                    </div>
                                    <div class="col text-center fs-5 pt-3  pb-3 fw-semibold">
                                       금액
                                    </div>
                                    <div class="col text-center fs-5 pt-3  pb-3 fw-semibold">
                                       체크인/체크아웃
                                    </div>
                                    <div class="col text-center fs-5 pt-3  pb-3 fw-semibold">
                                       상태
                                    </div>
                               </div>
                               <div class="row" >
                                  <div class="col" id="reserveListBox">
                                     
                                  </div>
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


<!-- 예약정보 모달 -->
<div class="modal right fade" id="infoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
</div>
</body>
</html>


