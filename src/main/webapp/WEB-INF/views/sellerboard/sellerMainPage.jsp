

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
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




.redBack{
background-color:#EB3232;
}



.back-color-black{
    background-color:black;
}
.back-color-gray{
    background-color:gray;
    opacity : 0.5;
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
   
   function getCurrentWeekSellPrice(){
      const xhr = new XMLHttpRequest();
      
      xhr.onreadystatechange = function(){
         if(xhr.readyState == 4 && xhr.status==200){
            const response = JSON.parse(xhr.responseText);
            if(response.result == "success"){
            const ctx = document.getElementById('barChart');
            
            const groupNames =[]
            const groupPrices = [];
            var totalPrice = null;
            for (list of response.info) {
               groupNames.push(list.room_group_name);
               groupPrices.push(list.price);
               totalPrice += list.price;
              }   

            new Chart(ctx,
                  {
                     type : 'bar',
                     data : {
                        labels : groupNames,
                        datasets : [ {
                           label : '판매액/원',
                           data : groupPrices,
                           borderWidth : 1
                        } ]
                     },
                     options : {
                        responsive : false,
                        scales : {
                           y : {
                              beginAtZero : true
                           }
                        }
                     }
                  });
            
            const dctx = document.getElementById('doughChart');
            var myDoughnutChart = new Chart(dctx, {
               type : 'doughnut',
               data : {
                  labels : groupNames,
                  datasets : [ {
                     label : '판매액/원',
                     data : groupPrices,
                     borderWidth : 2
                  } ]
               },
               options : {
                  responsive : false,
                  plugins: {
                        legend: {
                          position: 'top',
                        },
                        title: {
                          display: true,
                          text: '총'+ totalPrice.toLocaleString() +'원',
                          font :    {size: 18}

                        }
                      }
               }
            });
         }else {
            const dashbox = document.getElementById("dashbox");
            dashbox.innerHTML ="";
            const col = document.createElement("div");
            col.classList.add("col","text-center","fs-1","fw-semibold","text-secondary","pb-5");
            col.innerText = "이번 주 판매정보가 없습니다.";
            dashbox.appendChild(col);
         }
         }
      }
      xhr.open("get","./getCurrentWeekSellPrice?hotel_id="+hotelId);
      xhr.send();
   }
   
   function getRoomPercent(){
      const xhr = new XMLHttpRequest();
      const horiBox =document.getElementById("horiBox");
      horiBox.innerHTML = "";
      const canvas = document.createElement("canvas");
      canvas.id="horiChart";
      canvas.style.width ="400px";
      canvas.style.height ="300px";
      horiBox.appendChild(canvas);
      
      
      xhr.onreadystatechange = function(){
         if(xhr.readyState == 4 && xhr.status == 200){
            const response = JSON.parse(xhr.responseText);
            
            const groupNames = [];
            const percents = [];
            for (list of response.info) {
               groupNames.push(list.roomGroupDto.room_group_name);
               percents.push(list.per);
              }   
            
            const ctx = document.getElementById('horiChart');

            var myBarChart = new Chart(ctx,
                  {
                     type : 'bar',
                     data : {
                        labels : groupNames,
                        datasets : [ {
                           label : '점유율/%',
                           data : percents,
                           borderWidth : 1
                        } ]
                     },
                     options : {
                        responsive : false,
                        indexAxis : 'y',
                        scales: {
                              x: {
                                min: 0,
                                max: 100,
                              }
                            }
                        
                     }
                  });

         }
      }
      xhr.open("get","./getRoomPercent?hotel_id="+hotelId);
      xhr.send();
   }

   
function getTodayCheckInOut(){
   const xhr = new XMLHttpRequest();
   const checkIn = document.getElementById("checkIn");
   const checkOut = document.getElementById("checkOut");
   const checkInBox = document.getElementById("checkInBox");
   const checkOutBox = document.getElementById("checkOutBox");
   checkInBox.innerHTML = "";
   checkOutBox.innerHTML = "";
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         checkInNumber = 0;
         if(response.inresult == "insuccess"){
            for(list of response.info.checkIn){
               checkInNumber +=1;
               const row = document.createElement("div");
               row.classList.add("row","border-bottom");
               checkInBox.appendChild(row);
               
               const col1 = document.createElement("div");
               col1.classList.add("col","text-center","fs-6","pb-2","pt-2");
               row.appendChild(col1);
               
               const namerow = document.createElement("div");
               namerow.classList.add("row");
               col1.appendChild(namerow);
               
               const namecol = document.createElement("div");
               namecol.classList.add("col","small");
               namecol.innerText = list.userName;
               namerow.appendChild(namecol);
            
               const phonerow = document.createElement("div");
               phonerow.classList.add("row");
               col1.appendChild(phonerow);
               
               const phonecol = document.createElement("div");
               phonecol.classList.add("col","small","text-secondary");
               phonecol.innerText = list.phoneNumber;
               phonerow.appendChild(phonecol);
               
               const col3 = document.createElement("div");
               col3.classList.add("col","text-center","small","fw-semibold","pb-2","pt-3");
               col3.innerText = list.roomGroupName;
               row.appendChild(col3);
               
               const col4 = document.createElement("div");
               col4.classList.add("col","text-center","fs-6","fw-semibold","text-secondary","pb-2","pt-3");
               col4.innerText = list.fixedNumber;
               row.appendChild(col4);
               
               const col5 = document.createElement("div");
               col5.classList.add("col","text-center","fs-6","fw-semibold","pb-2","pt-3");
               if(list.status =="예약"){
                  const check = document.createElement("input");
                  check.type = "checkbox";
                  check.id = "checkbox"+list.id;
                  check.setAttribute("onchange","getRoom("+list.id+")")
                  col5.appendChild(check)
               }else{
                  
                  col5.classList.add("text-primary");
                  col5.innerText = list.status;
               }
               row.appendChild(col5);
            }
         }else{
            const row01 = document.createElement("div");
            row01.classList.add("row","mt-5","mb-5");
            checkInBox.appendChild(row01);
         
            
            const row0 = document.createElement("div");
            row0.classList.add("row","mt-5","mb-5");
            checkInBox.appendChild(row0);
         
            const row = document.createElement("div");
            row.classList.add("row","mt-5");
            checkInBox.appendChild(row);
            
            const col1 = document.createElement("div");
            col1.classList.add("col","text-center","fs-5","mt-5","text-secondary","fw-semibold");
            col1.innerText = "오늘 입실 정보가 없습니다."
            row.appendChild(col1);
         }

         checkIn.innerText = "("+checkInNumber+")";
         checkOutNumber = 0;
         
         if(response.outresult == "outsuccess"){
            for(list of response.info.checkOut){
               checkOutNumber +=1;
               const row = document.createElement("div");
               row.classList.add("row","border-bottom");
               checkOutBox.appendChild(row);
               
               const col1 = document.createElement("div");
               col1.classList.add("col","text-center","fs-6","pb-2","pt-2");
               row.appendChild(col1);
               
               const namerow = document.createElement("div");
               namerow.classList.add("row");
               col1.appendChild(namerow);
               
               const namecol = document.createElement("div");
               namecol.classList.add("col","small");
               namecol.innerText = list.userName;
               namerow.appendChild(namecol);
            
               const phonerow = document.createElement("div");
               phonerow.classList.add("row");
               col1.appendChild(phonerow);
               
               const phonecol = document.createElement("div");
               phonecol.classList.add("col","small","text-secondary");
               phonecol.innerText = list.phoneNumber;
               phonerow.appendChild(phonecol);
               
               const col3 = document.createElement("div");
               col3.classList.add("col","text-center","small","fw-semibold","pb-2","pt-3");
               col3.innerText = list.roomGroupName;
               row.appendChild(col3);
               
               const col4 = document.createElement("div");
               col4.classList.add("col","text-center","fs-6","fw-semibold","text-secondary","pb-2","pt-3");
               col4.innerText = list.fixedNumber;
               row.appendChild(col4);
               
               const col5 = document.createElement("div");
               col5.classList.add("col","text-center","fs-6","fw-semibold","pb-2","pt-3");
               if(list.status =="입실"){
                  const check = document.createElement("input");
                  check.type = "checkbox";
                  check.setAttribute("onchange","checkInOutProcess("+list.id+")")
                  col5.appendChild(check)
               }else{
                  
                  col5.classList.add("text-danger");
                  col5.innerText = list.status;
               }
               row.appendChild(col5);
            }
         }else{
            const row01 = document.createElement("div");
            row01.classList.add("row","mt-5","mb-5");
            checkOutBox.appendChild(row01);
         
            
            const row0 = document.createElement("div");
            row0.classList.add("row","mt-5","mb-5");
            checkOutBox.appendChild(row0);
         
            const row = document.createElement("div");
            row.classList.add("row","mt-5");
            checkOutBox.appendChild(row);
            
            const col1 = document.createElement("div");
            col1.classList.add("col","text-center","fs-5","mt-5","text-secondary","fw-semibold");
            col1.innerText = "오늘 퇴실 정보가 없습니다."
            row.appendChild(col1);
         }
         
         checkOut.innerText = "("+checkOutNumber+")";
      }
   }
   xhr.open("get","./getTodayCheckInOut?hotel_id="+hotelId);
   xhr.send();
}

function getRoom(id){
   const modal = bootstrap.Modal.getOrCreateInstance("#roomModal");
   const xhr = new XMLHttpRequest();
   const checkBox =document.getElementById("checkbox"+id)
   checkBox.checked = false;
   const roomListBox = document.getElementById("roomListBox")
   const getRoomButton =document.getElementById("getRoomButton")
   getRoomButton.setAttribute("onclick","checkInOutProcess("+id+")");
   roomListBox.innerHTML = "";
   xhr.onreadystatechange = function(){
      if(xhr.readyState==4&&xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         if(response.result == "success"){
            for(room of response.list){
               const row = document.createElement("div");
               row.classList.add("row","mt-2");
               roomListBox.appendChild(row);
               
               const col = document.createElement("div");
               col.classList.add("col","fw-semibold","text-center");
               
               const span1 = document.createElement("span");
               span1.innerText = room.room_number + "호"
               col.appendChild(span1);
               
               const span2 = document.createElement("span");
               span2.classList.add("pb-1","ms-2")
               
               const button = document.createElement("button")
               button.type ="button";
               button.classList.add("btn","btn-outline-primary","btn-sm","ms-1","mb-1","roomButton")
               button.setAttribute("onclick","getRoomNumber("+room.id+")")
               button.id="button"+room.id;
               button.innerText = "배정";
               span2.appendChild(button);
               col.appendChild(span2);
               
               row.appendChild(col);
            }
         }else if(response.result =="fail"){
            const row = document.createElement("div");
            row.classList.add("row","mt-2");
            roomListBox.appendChild(row);
            
            const col = document.createElement("div");
            col.classList.add("col","fw-semibold");
            col.innerText = "이게 나오면 안됨 예약쿼리 잘못된거임"
            row.appendChild(col);
         }
      
         modal.show();
         
      }
   }
      xhr.open("get","./getEmptyRoom?id="+id);
      xhr.send();
}
   
let roomNumber = 0;

function getRoomNumber(id){
   roomNumber = id;
   const buttons = document.getElementsByClassName("roomButton");
   for(button of buttons){
      button.classList.remove("active")
   }
   const active = document.getElementById("button"+id);
   active.classList.add("active");
}
   
   

function checkInOutProcess(id){
   const xhr = new XMLHttpRequest();
   const modal = bootstrap.Modal.getOrCreateInstance("#roomModal");
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response= JSON.parse(xhr.responseText);
         getTodayCheckInOut()
         modal.hide();
         getRoomPercent();
      }
   }
   xhr.open("get","./checkInOutProcess?id="+id+"&room_id="+roomNumber+"&reserve_id="+id);
   xhr.send();
}

function getGeoCoder(){
   const xhr =new XMLHttpRequest();
   const query = '${hotelInfo.hotelDto.hotel_loc}'
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         const doc = response.documents
         console.log(doc)
         
         var xValue = Math.floor(doc[0].x);
         var yValue = Math.floor(doc[0].y);
         getWeather(yValue,xValue)
      }
   }
   xhr.open("get","https://dapi.kakao.com/v2/local/search/address.json?query="+query);
   xhr.setRequestHeader("Content-type","application/json;charset=UTF-8");
   xhr.setRequestHeader("Authorization","KakaoAK 9c133e8e0ca99f4e08b962a90d53f8a4");
   xhr.send();
}

function getWeather(x,y){
   const xhr = new XMLHttpRequest();
   
   var currentDate = new Date(); //날짜생성
   
   var currentTime = new Date(); // 시간생성
   var hours = currentTime.getHours();
   var minutes = currentTime.getMinutes();
   var formattedTime;

   if ((hours === 2 && minutes >= 10) || (hours > 2 && hours < 5) || (hours === 5 && minutes <= 9)) {
     formattedTime = "0200";
   } else if ((hours === 5 && minutes >= 10) || (hours > 5 && hours < 8) || (hours === 8 && minutes <= 9)) {
     formattedTime = "0500";
   } else if ((hours === 8 && minutes >= 10) || (hours > 8 && hours < 11) || (hours === 11 && minutes <= 9)) {
     formattedTime = "0800";
   } else if ((hours === 11 && minutes >= 10) || (hours > 11 && hours < 14) || (hours === 14 && minutes <= 9)) {
     formattedTime = "1100";
   } else if ((hours === 14 && minutes >= 10) || (hours > 14 && hours < 17) || (hours === 17 && minutes <= 9)) {
     formattedTime = "1400";
   } else if ((hours === 17 && minutes >= 10) || (hours > 17 && hours < 20) || (hours === 20 && minutes <= 9)) {
     formattedTime = "1700";
   } else if ((hours === 20 && minutes >= 10) || (hours > 20 && hours < 23) || (hours === 23 && minutes <= 9)) {
     formattedTime = "2000";
   } else {
     currentDate.setDate(currentDate.getDate() - 1); 
     formattedTime = "2300";
   }

   var year = currentDate.getFullYear();
   var month = String(currentDate.getMonth() + 1).padStart(2, "0");
   var day = String(currentDate.getDate()).padStart(2, "0");
   var formattedDate = year + month + day;
   
   
   
   const serviceKey = 'UgAwy20eOElfNDB50jZS40hGZuQ75CRo7LJgeZEC%2FwWN4tl5LpnQYTBCD4J0A3Be7DwpARfFkEmGGMButaHNtQ%3D%3D';
   const numOfRows = 30;
   const pageNo = 1;
   const dataType = 'JSON';
   const base_date = formattedDate;
   const base_time = formattedTime;
   const nx = x;
   const ny = y;
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         
         const searchRain = response.response.body.items.item.find(item => item.category == 'PTY'); // 비오는지 미리 확인
         const rain = searchRain.fcstValue;
         console.log(rain)
         const itemList = response.response.body.items;
         console.log(itemList)
         
         const popBox = document.getElementById("popBox");
         const rehBox = document.getElementById("rehBox");
         const skyBox = document.getElementById("skyBox");
         const tmpBox = document.getElementById("tmpBox");
         const weatherBack = document.getElementById("weatherBack");
         const weatherIcon = document.getElementById("weatherIcon");
         for(item of itemList.item){
            if(item.category == 'POP'){
               popBox.innerText = "강수확률: " +item.fcstValue + "%";
            }else if(item.category=='REH'){
               rehBox.innerText = "습도: "+item.fcstValue + "%";
            }else if(item.category == 'SKY'){
               if(item.fcstValue == 1){
                  skyBox.innerText = "맑음";
                  weatherBack.classList.remove("back-color-rain","back-color-cloud");
                  weatherBack.classList.add("back-color-sun");
                  weatherIcon.classList.add("bi-sun-fill","text-warning");
                  weatherIcon.classList.remove("bi-clouds-fill","text-secondary","text-dark","bi-cloud-drizzle-fill");
                  
               }else if(item.fcstValue == 2){
                  skyBox.innerText = "구름많음";
                  weatherBack.classList.remove("back-color-rain","back-color-sun");
                  weatherBack.classList.add("back-color-cloud");
                  weatherIcon.classList.add("bi-clouds-fill","text-secondary");
                  weatherIcon.classList.remove("bi-sun-fill","text-warning","text-dark","bi-cloud-drizzle-fill");
               }else{
                  skyBox.innerText = "흐림";
                  weatherBack.classList.remove("back-color-sun","back-color-cloud");
                  weatherBack.classList.add("back-color-rain");
                  if(rain==1 || rain==4){
                     weatherIcon.classList.add("bi-cloud-drizzle-fill","text-dark");
                     weatherIcon.classList.remove("bi-sun-fill","text-warning","text-secondary","bi-clouds-fill");
                  }else{
                     weatherIcon.classList.add("bi-clouds-fill","text-dark");
                     weatherIcon.classList.remove("bi-sun-fill","text-warning","text-secondary","bi-cloud-drizzle-fill");
                  }
               }
            }else if(item.category == 'TMP'){
               console.log(item.fcstValue)
               tmpBox.innerText = item.fcstValue +"˚";
            }
         }
         

      }
   }
   xhr.open("get","http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey="+serviceKey+"&numOfRows="+numOfRows+"&pageNo="+pageNo+
         "&dataType="+dataType+"&base_date="+base_date+"&base_time="+base_time+"&nx="+nx+"&ny="+ny);
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






//그룹 가격 변동
var groupId = null;
const dayPriceObj = {
      groups : [],
      hotel_id : hotelId
   };

function getGroupList(){
   const xhr = new XMLHttpRequest();
   const groupListBox = document.getElementById("groupListBox")
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response =JSON.parse(xhr.responseText);
         response.groupList.forEach(function(group,index){         
            
            const span = document.createElement("span");
            if(index == 0){
               groupId = group.id;
               span.classList.add("badge","back-color-black","me-1","groupBadge");
            }else{
               span.classList.add("badge","back-color-gray","me-1","groupBadge");
            }
            span.setAttribute("onclick","getGroupDayPrice("+group.id+")");
            span.id="badge"+group.id;
            span.innerText = group.room_group_name;
            groupListBox.appendChild(span);
            
         })
         getDayPriceList()
         getGroupDayPrice(groupId);
      }
   }
   xhr.open("get","./getGroupList?hotel_id="+hotelId);
   xhr.send();
}


function getGroupDayPrice(id){
   const groupBadge = document.getElementsByClassName("groupBadge");
   for(badge of groupBadge){
      badge.classList.remove("back-color-black","back-color-gray");
      badge.classList.add("back-color-gray");
   }
   const target = document.getElementById("badge"+id);
   target.classList.add("back-color-black")
   target.classList.remove("back-color-gray")
   groupId = id;
   
   
   
   const xhr = new XMLHttpRequest();
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         for(var i=0; i<7; i++){
            const groupObj = dayPriceObj.groups.find(groups => groups.group == groupId);
            const daysObj = groupObj.days.find(days => days.day == i);
            const percent = daysObj.change_price;            
            
         }
         
         const groupObj = dayPriceObj.groups.find(groups => groups.group == groupId);
         groupObj.days.forEach(function(day){
            const pricePerBox = document.getElementById("day"+day.day+"per");
            if(day.change_price > 0){
               pricePerBox.classList.add("text-primary")
            }else if(day.change_price < 0){
               pricePerBox.classList.add("text-danger")
            }
            pricePerBox.innerText = day.change_price +"%";
         })
      
      }
   }
   xhr.open("get","./getGroupInfo?id="+id);
   xhr.send();
}


function getDayPriceList(){
   const xhr = new XMLHttpRequest();
   
   xhr.onreadystatechange = function(){
      if(xhr.readyState ==4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         if(response.result == "success"){
            const groupList = response.groupList;
            const dayPriceList = response.dayPriceList;
            groupList.forEach(function(group){
               //객체 배열안에 객실 리스트 넣기
               const groupObj = {};
               groupObj["group"] = group.id;
               groupObj["days"] = [];
               
               dayPriceList.forEach(function(dayPrice){
                  if(dayPrice.room_group_id == group.id){
                     const day = {
                           day : dayPrice.day,
                           change_price : dayPrice.change_price
                     }
                     groupObj.days.push(day);
                  }
                  
               })
               dayPriceObj.groups.push(groupObj)
               
               
            })
         }else{
            const groupList = response.groupList;
            groupList.forEach(function(group){
               //객체 배열안에 객실 리스트 넣기
               const groupObj = {};
               groupObj["group"] = group.id;
               groupObj["days"] = [];
               for(var i=0; i<7; i++){
                  const day = {
                     day : i,
                     change_price : 0
                  }
                  groupObj.days.push(day);
               }
               dayPriceObj.groups.push(groupObj);
            })
         }
            
      }
   }
   xhr.open("get","./getDayPriceList?hotel_id="+hotelId,false);
   xhr.send();
}



function getSeasonEvent(){
   const xhr = new XMLHttpRequest();
   const seasonListBox = document.getElementById("seasonListBox");
   seasonListBox.innerHTML= "";
   xhr.onreadystatechange = function(){
      if(xhr.readyState ==4 && xhr.status ==200){
         const response = JSON.parse(xhr.responseText);
         let index = 0;
         for (const season of response.seasonPriceList){
            if(index == 4){
               break;
            }
             index++;
            const col1= document.createElement("div");
            col1.classList.add("col-3");
            seasonListBox.appendChild(col1);
            
            const namerow= document.createElement("div");
            namerow.classList.add("row");
            col1.appendChild(namerow);
            
            const namecol= document.createElement("div");
            namecol.classList.add("col","fw-semibold");
            namecol.innerText=season.fluctName;
            namerow.appendChild(namecol);
            
            const perrow= document.createElement("div");
            perrow.classList.add("row");
            col1.appendChild(perrow);
            const percol= document.createElement("div");
            percol.classList.add("col","fw-semibold");
            if(season.changePrice > 0){
               percol.classList.add("text-primary");
            }else{
               percol.classList.add("text-danger");
            }
            percol.innerText=season.changePrice+"%";
            perrow.appendChild(percol);
            
            
            const daterow= document.createElement("div");
            daterow.classList.add("row");
            col1.appendChild(daterow);

            const datecol= document.createElement("div");
            datecol.classList.add("col","fw-semibold","text-secondary");
            const date1 = new Date(season.startDate);
            const year1 = date1.getFullYear().toString().substr(2);
            const month1 = (date1.getMonth() + 1).toString().padStart(2, '0');
            const day1 = date1.getDate().toString().padStart(2, '0');
            const formattedDate1 = year1+"."+month1+"."+day1;
            const date2 = new Date(season.endDate);
            const year2 = date2.getFullYear().toString().substr(2);
            const month2 = (date2.getMonth() + 1).toString().padStart(2, '0');
            const day2 = date2.getDate().toString().padStart(2, '0');
            const formattedDate2 =year2+"."+month2+"."+day2;
         
            
            datecol.innerText= formattedDate1 +"-"+formattedDate2
            daterow.appendChild(datecol);
            
         }
         
      }
   }
   xhr.open("get","./getSeasonPriceList?hotel_id="+hotelId);
   xhr.send();
}
   window.addEventListener("DOMContentLoaded", function() {
      getCurrentWeekSellPrice();
      getRoomPercent();
      getTodayCheckInOut();
      getGeoCoder();
      domainLink()
      
      getGroupList()
      getSeasonEvent()
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
                  <i class="bi bi-house fs-4 text-info pt-5"></i><span
                     class="ps-3 text-white fs-5 pt-0">홈</span>
                     </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-1"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./sellerReserveListPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
                  <i class="bi bi-card-list fs-4 text-secondary pt-5"></i><span
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
         <div class="col bg-secondary bg-opacity-10 info-scroll-container">
            <div class="row mt-4"></div>
            <div class="row ms-3 border-bottom pb-3">
               <div class="col fw-bold fs-3">
                  <i class="bi bi-house pe-4"></i>홈
               </div>
            </div>
            <div class="row mt-3">
               <!-- 날짜, 숫자정보 -->
               <div class="col">
                  <div class="card">
                     <div class="card-body">
                        <div class="row mt-1">
                           <div class="col fs-3 fw-semibold">통계</div>
                        </div>
                        <div class="row mt-5" id="dashbox">
                           <div class="col-4">
                              <div class="row">
                                 <div class="col">
                                    <canvas id="barChart" width="400" height="300"></canvas>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-9 small fw-semibold  text-center pt-3 ps-5">이번 주 객실별
                                    판매 그래프</div>
                              </div>
                           </div>
                           <div class="col-4">
                              <div class="row">
                                 <div class="col" id="horiBox">
                                    <canvas id="horiChart" width="400" height="300"></canvas>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-9 small fw-semibold text-center pt-3 ps-5">객실
                                    점유율</div>
                              </div>
                           </div>
                           <div class="col-4">
                              <div class="row">
                                 <div class="col">
                                    <canvas id="doughChart" width="450" height="300"></canvas>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-9 small  fw-semibold text-center pt-3 ms-5">이번 주 총/객실별
                                    판매액</div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="row mt-3">
               <div class="col-8">
                  <div class="row">
                     <div class="col-6">
                        <div class="card">
                           <div class="card-body scroll-container">
                              <div class="row mt-2">
                                 <div class="col fs-5 fw-semibold">오늘 입실 <span id="checkIn">(0)</span></div>
                              </div>
                              <div class="row mt-3 bg-secondary bg-opacity-25 pb-3 pt-3">
                                 <div class="col text-center fs-6 fw-bold">예약자</div>
                                 <div class="col text-center fs-6 fw-bold ">객실명</div>
                                 <div class="col text-center fs-6 fw-bold ">객실인원</div>
                                 <div class="col text-center fs-6 fw-bold ">체크인</div>
                              </div>
                              <div class="row">
                                 <div class="col"  id="checkInBox">
                                 
                                 </div>
                              </div>
                     
                              
                           </div>
                        </div>
                     </div>
                     <div class="col-6">
                        <div class="card">
                           <div class="card-body scroll-container">
                              <div class="row mt-2">
                                 <div class="col fs-5 fw-semibold">오늘 퇴실 <span id="checkOut">(17)</span></div>
                              </div>
                              <div class="row mt-3 bg-secondary bg-opacity-25 pb-3 pt-3">
                                 <div class="col text-center fs-6 fw-bold">예약자</div>
                                 <div class="col text-center fs-6 fw-bold ">객실명</div>
                                 <div class="col text-center fs-6 fw-bold ">객실인원</div>
                                 <div class="col text-center fs-6 fw-bold ">체크아웃</div>
                              </div>
                              <div class="row">
                                 <div class="col"  id="checkOutBox">
                                 
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>                  
                  </div>
                  <div class="row mt-3">
                     <div class="col">
                        <div class="card">
                          <div class="card-body">
                            <div class="row mt-2">
                               <div class="col fs-5 fw-semibold">메뉴얼</div>
                            </div>
                            <div class="row mt-2  pb-1 pt-4 border-bottom">
                               <div class="col  small fw-semibold text-start">1.시작하기</div>
                            </div>
                            <div class="row mt-2  pb-1 pt-1 border-bottom">
                               <div class="col  small fw-semibold text-start">2.설정</div>
                            </div>
                            <div class="row mt-2  pb-1 pt-1 border-bottom">
                               <div class="col  small fw-semibold text-start">3.그룹</div>
                            </div>
                            <div class="row mt-2  pb-1 pt-1 border-bottom">
                               <div class="col  small fw-semibold text-start">4.객실(룸)</div>
                            </div>
                            <div class="row mt-2  pb-1 pt-1 border-bottom">
                               <div class="col  small fw-semibold text-start">5.기본요금</div>
                            </div>
                             <div class="row mt-2  pb-1 pt-1 border-bottom">
                               <div class="col  small fw-semibold text-start">6.가격변동</div>
                            </div>
                          </div>
                        </div>
                     </div>

                     <div class="col-8">
                        <div class="card">
                          <div class="card-body">
                            <div class="row mt-2">
                               <div class="col fs-5 fw-semibold">요일별 요금</div>
                               <div class="col  fw-semibold text-end small"><a style="text-decoration: none;" class="text-dark" href="./sellerPriceSettingPage?id=${hotelInfo.hotelDto.id}">자세히</a></div>
                            </div>
                            <div class="row mt-1">
                               <div class="col" id="groupListBox">
                                  
                               </div>
                            </div>
                            <div class="row mt-3 border-bottom pb-1 fw-semibold text-center" style="font-size: 18px">
                               <div class="col">월</div>
                               <div class="col">화</div>
                               <div class="col">수</div>
                               <div class="col">목</div>
                               <div class="col text-danger">금</div>
                               <div class="col text-danger">토</div>
                               <div class="col" style="color:blue">일</div>
                            </div>
                            <div class="row mt-2 text-center ps-1">
                               <div class="col" id="day1per"></div>
                               <div class="col" id="day2per"></div>
                               <div class="col" id="day3per"></div>
                               <div class="col" id="day4per"></div>
                               <div class="col" id="day5per"></div>
                               <div class="col" id="day6per"></div>
                               <div class="col" id="day0per"></div>
                            </div>
                             <div class="row mt-4">
                               <div class="col-9">
                                 <span class="fs-5 fw-semibold">시즌별 요금</span>
                                 <span class="text-secondary small">상세정보는 날짜별 요금조정 페이지에서 확인하세요.</span>
                              </div>
                              <div class="col-auto text-end small ps-0 pt-2">
                                 <span class="text-primary"><i class="bi bi-circle-fill"></i></span>
                                 <span class="fw-semibold">인상</span>
                              </div>   
                              <div class="col-auto text-end small pt-2">
                                 <span style="color: #EB3232"><i class="bi bi-circle-fill"></i></span>
                                 <span class="fw-semibold">인하</span>
                              </div>                            
                            </div>
                            <div class="row mt-3 small text-center" style="height:65px;" id="seasonListBox">
                               <div class="col-3">
                                 <div class="row">
                                    <div class="col fw-semibold fw-semibold">
                                       인상상
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col text-primary fw-semibold">
                                       50%
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col text-secondary fw-semibold">
                                       23/07/23-23/07/29
                                    </div>
                                 </div>
                              </div>   
                              <div class="col-3">
                                 <div class="row">
                                    <div class="col fw-semibold fw-semibold">
                                       인상상
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col text-primary fw-semibold">
                                       50%
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col text-secondary fw-semibold">
                                       23/07/23-23/07/29
                                    </div>
                                 </div>
                              </div>    
    
                              <div class="col-3">
                                 <div class="row">
                                    <div class="col fw-semibold fw-semibold">
                                       인상상
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col text-primary fw-semibold">
                                       50%
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col text-secondary fw-semibold">
                                       23/07/23-23/07/29
                                    </div>
                                 </div>
                              </div>                           
                            </div>
                          </div>
                        </div>
                     </div>
                  </div>
               </div>
            
               
               <div class="col">
                  <div class="row">
                     <div class="col">
                           <div class="card">
                                <div class="card-body back-color" id="weatherBack">
                                  <div class="row mt-2">
                                        <div class="col">
                                           <div class="row">
                                              <div class="col text-center text-white">${hotelInfo.hotelDto.hotel_loc}</div>
                                           </div>
                                           <div class="row">
                                              <div class="col text-center fs-3 text-white">
                                                 현재
                                              </div>
                                           </div>
                                           <div class="row">
                                              <div class="col text-center"><i class="bi bi-sun-fill text-warning weather-icon" id="weatherIcon"></i></div>
                                           </div>
                                           <div class="row mt-1">
                                              <div class="col text-center text-white fs-5" id="tmpBox"></div>
                                           </div>
                                           <div class="row mt-1">
                                              <div class="col text-center text-white fs-5" id="rehBox"></div>
                                           </div>
                                           <div class="row mt-1">
                                              <div class="col text-center text-white fs-5" id="skyBox"></div>
                                           </div>
                                           <div class="row mt-1">
                                              <div class="col text-center text-white fs-5" id="popBox"></div>
                                           </div>
                                        </div>                            
                                  </div>
                                </div>
                              </div>
                              </div>
                           </div>
                           
                           <div class="row mt-4">
                              <div class="col">
                                 <div class="card">
                                      <div class="card-body">
                                        <div class="row mb-2">
                                           <div class="col fs-5 fw-semibold">공지사항</div>
                                           <div class="col fs-5 fw-semibold text-end"><button type="button" class="btn btn-light fs-4 pt-0 mt-0">+</button></div>
                                        </div>
                                        <div class="row mt-2  pb-3 pt-3 border-bottom">
                                           <div class="col text-center fs-6 fw-semibold text-start">파트너 숙소 등록시 유의사항</div>
                                           <div class="col-4 text-center fs-6 fw-semibold text-end">2023.07.30(금)</div>
                                        </div>
                                        <div class="row mt-2  pb-3 pt-3 border-bottom">
                                           <div class="col text-center fs-6 fw-semibold text-start">파트너 등록 후 주의사항</div>
                                           <div class="col-4 text-center fs-6 fw-semibold text-end">2023.07.24(금)</div>
                                        </div>
                                        <div class="row mt-2  pb-3 pt-3 border-bottom">
                                           <div class="col text-center fs-6 fw-semibold text-start">결제시스템 점검 안내</div>
                                           <div class="col-4 text-center fs-6 fw-semibold text-end">2023.07.20(금)</div>
                                        </div>
                                        <div class="row mt-2  pb-3 pt-3 border-bottom">
                                           <div class="col text-center fs-6 fw-semibold text-start">파트너 수칙 안내</div>
                                           <div class="col-4 text-center fs-6 fw-semibold text-end">2023.07.19(금)</div>
                                        </div>
                                        <div class="row mt-2  pb-3 pt-3 border-bottom">
                                           <div class="col text-center fs-6 fw-semibold text-start">결제시스템 점검 안내</div>
                                           <div class="col-4 text-center fs-6 fw-semibold text-end">2023.07.18(수)</div>
                                        </div>
                                          <div class="row mt-2  pb-3 pt-3 border-bottom">
                                     <div class="col text-center fs-6 fw-semibold text-start">로밍 고객센터 점검 안내</div>
                                     <div class="col-4 text-center fs-6 fw-semibold text-end">2023.07.08(수)</div>
                                     </div>
                                       <div class="row mt-2  pb-3 pt-3 border-bottom">
                                     <div class="col text-center fs-6 fw-semibold text-start">대시보드 참고사항</div>
                                     <div class="col-4 text-center fs-6 fw-semibold text-end">2023.06.28(수)</div>
                                     </div>
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


<div class="modal modal-sm" tabindex="-1" id="roomModal" data-bs-backdrop="false">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">방 배정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row">
           <div class="col" id="roomListBox">
              
           </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="getRoomButton">입실</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>