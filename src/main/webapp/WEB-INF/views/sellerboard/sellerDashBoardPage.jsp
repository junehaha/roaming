

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 222px; /* 스크롤 영역의 높이 설정 */
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



.dashText{
   font-size: 1rem;
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
   
   var current = new Date();
   var dayValue = null;
   
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
   function getSearchDay(date){
      console.log(date)
      const dateBox = document.getElementById("dateBox")
      const monthBoxes = document.getElementsByClassName("monthBox");
      if(date == 1){
         current.setMonth(current.getMonth() + 1);
      }else if(date == -1){
         current.setMonth(current.getMonth() - 1);
      }
         
      
      var month = [
        "01", "02", "03", "04", "05", "06",
        "07", "08", "09", "10", "11", "12"
      ];
      var day = [
        "일", "월", "화", "수", "목", "금", "토"
      ];

      var currentMonth = month[current.getMonth()];
      var currentYear = current.getFullYear(); 
      
      var currentday = currentYear + "년 " + currentMonth + "월";

      dayValue = current.getMonth()+1;
      for(monthBox of monthBoxes){
         monthBox.innerText = dayValue;
      }   
      dateBox.innerText = currentday;
      
      getTotalReserve()
      getChartOfMonth()
      getGraphOfMonth()
}
   
function getTotalReserve(){
   const xhr = new XMLHttpRequest();
   const reserveCountbox =document.getElementById("reserveCountbox");
   const reservePricebox =document.getElementById("reservePricebox");
   
   const creserveCountbox =document.getElementById("creserveCountbox");
   const creservePricebox =document.getElementById("creservePricebox");
   xhr.onreadystatechange = function(){
      if(xhr.readyState==4 && xhr.status ==200){
         const response = JSON.parse(xhr.responseText);
         reserveCountbox.innerText = response.reserveInfo.id;
         reservePricebox.innerText = response.reserveInfo.room_group_id.toLocaleString() +"원";
         
         creserveCountbox.innerText = response.creserveInfo.id;
         creservePricebox.innerText = response.creserveInfo.room_group_id.toLocaleString() +"원";
         
      }
   }
   xhr.open("get","./getTotalReserve?hotel_id="+hotelId+"&month="+dayValue);
   xhr.send();
}



function getChartOfMonth(){
   const xhr = new XMLHttpRequest();
   const roomReserveTable= document.getElementById("roomReserveTable")
   roomReserveTable.innerHTML ="";
   const roomChartBox =document.getElementById("roomChartBox");
   roomChartBox.innerHTML ="";
   const canvas = document.createElement("canvas");
   canvas.id = "doughChart";
   canvas.style.width = "330px";
   canvas.style.height = "330px";
   roomChartBox.appendChild(canvas);
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         if(response.result == "success"){
         const groupNames =[]
         const groupPrices = [];
         var totalPrice = null;
         
         const listLength = response.roomReserve.length;
         
         response.roomReserve.forEach(function(list,index){
            groupNames.push(list.room_group_name);
            groupPrices.push(list.price);
            totalPrice += list.price;
            const tr = document.createElement("tr");
            roomReserveTable.appendChild(tr);
            
            
            const th = document.createElement("th");
            th.setAttribute("scope","row");
            th.innerText = index+1;
            tr.appendChild(th);
            
            const td1 = document.createElement("td");
            td1.innerText = list.room_group_name;
            td1.classList.add("fw-semibold")
            tr.appendChild(td1);
                        
            const td2 = document.createElement("td");
            td2.innerText = list.id +"건";
            tr.appendChild(td2);
            
            const td3 = document.createElement("td");
            if(index==0 && list.price>0 ){
               td3.classList.add("text-primary")
            }
            td3.innerText = list.price.toLocaleString() + "원";
            tr.appendChild(td3);
            
             if(listLength < 5 && index == listLength-1){
                  for(var i =listLength+1; i<=5; i++){
                     const trplus = document.createElement("tr");
                     roomReserveTable.appendChild(trplus);
                     
                     const thplus = document.createElement("th");
                     thplus.setAttribute("scope","row");
                     thplus.innerText = i
                     trplus.appendChild(thplus);
                     
                     const tdplus1 = document.createElement("td");
                     tdplus1.innerText = "";
                     trplus.appendChild(tdplus1);
                     
                     const tdplus2 = document.createElement("td");
                     tdplus2.innerText = "";
                     trplus.appendChild(tdplus2);
                     
                     const tdplus3 = document.createElement("td");
                     tdplus3.innerText= "";
                     trplus.appendChild(tdplus3);
                  }
               }  
         })
         
         
         
         const dctx = document.getElementById('doughChart');
         var myDoughnutChart = new Chart(dctx, {
         
            type : 'doughnut',
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
   xhr.open("get","./getChartOfMonth?hotel_id="+hotelId+"&month="+dayValue);
   xhr.send();
}


function getGraphOfMonth(){
   
   const getBarGraph = document.getElementById("getBarGraph");
   getBarGraph.classList.remove("text-primary");
   
   const getGraphOfMonth = document.getElementById("getGraphOfMonth");
   getGraphOfMonth.classList.add("text-primary");
   
   const graphChartBox =document.getElementById("monthYearChartBox");
   graphChartBox.innerHTML ="";
   const canvas = document.createElement("canvas");
   canvas.id = "graphChart";
   canvas.style.width = "730px";
   canvas.style.height = "338px";
   graphChartBox.appendChild(canvas);
   
     const year = new Date().getFullYear();
     const startDate = new Date(year, dayValue-1, 1);
     const endDate = new Date(year, dayValue,0);
     var month = [
        "01", "02", "03", "04", "05", "06",
        "07", "08", "09", "10", "11", "12"
      ];
     
   // 월, 일, 요일 추출
     var startMonth = month[startDate.getMonth()];
     var startDay = startDate.getDate().toString().padStart(2, '0');
     var startYear = startDate.getFullYear();
     //내일
     var endMonth = month[endDate.getMonth()];
     var endDay = endDate.getDate().toString().padStart(2, '0');
     var endYear = endDate.getFullYear(); 

     // 변환된 값 출력
     var start = startYear + "-" + startMonth + "-" + startDay
     var end = endYear + "-" + endMonth + "-" + endDay
   
     var dateList = []
     for(var i=1; i<=endDate.getDate(); i++){
        const roofDate = new Date(year, dayValue-1, i);
        var newMonth = month[roofDate.getMonth()];
        var newDay = roofDate.getDate().toString().padStart(2, '0');
        var newYear = roofDate.getFullYear();
        var newDate = newYear + "-" + newMonth + "-" + newDay

        dateList.push(newDate);
     }     
     console.log(dateList)
   const xhr = new XMLHttpRequest();
   xhr.onreadystatechange = function(){
      if(xhr.readyState==4&&xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         var date = []; 
         var price = [];
         console.log(dateList.length)
         console.log(response)
         for(var i=0; i<dateList.length; i++){
            if(i+1 == new Date(response.reserveGraph[i].reserve_date).getDate()){
               date.push(new Date(response.reserveGraph[i].reserve_date).getDate()+"일");
            }else{
               date.push(i+1 +"일");
            }
            
            price.push(response.reserveGraph[i].final_price);
         }
         console.log(response.reserveGraph)
         
         const graph = document.getElementById("graphChart");
         var graphChart = new Chart(graph, {
              type: 'line',
              data: {
                labels: date,
                datasets: [{
                  label: '판매액/원',
                  data: price,
                  borderWidth: 1
                }]
              },
              options: {
                responsive: false,
                scales: {
                  x: {
                      stepSize: 5                 
                  },
                  y: {
                    
                         min: 0,
                         stepSize: 100000
                    
                  }
                }
              }
            });
      }
   }
   
   xhr.open("get","./getGraphOfMonth?hotel_id="+hotelId+"&dates="+dateList);
   xhr.send();
}

function getBarGraph(){
   const xhr =new XMLHttpRequest();
   const getBarGraph = document.getElementById("getBarGraph");
   getBarGraph.classList.add("text-primary");
   
   const getGraphOfMonth = document.getElementById("getGraphOfMonth");
   getGraphOfMonth.classList.remove("text-primary");
   
   
   const barChartBox =document.getElementById("monthYearChartBox");
   barChartBox.innerHTML ="";
   const canvas = document.createElement("canvas");
   canvas.id = "barChart";
   canvas.style.width = "730px";
   canvas.style.height = "338px";
   
   barChartBox.appendChild(canvas);
   xhr.onreadystatechange = function(){
      if(xhr.readyState==4&&xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         const ctx = document.getElementById('barChart');
         
         const monthPrices = [];
         var totalPrice = null;
         for (reserveBar of response.reserveBar) {
            monthPrices.push(reserveBar.final_price);
            totalPrice += reserveBar.final_price;
           }   

         new Chart(ctx,
               {
                  type : 'bar',
                  data : {
                     labels : [1,2,3,4,5,6,7,8,9,10,11,12],
                     datasets : [ {
                        label : '판매액/원',
                        data : monthPrices,
                        borderWidth : 1
                     } ]
                  },
                  options : {
                     responsive : false,
                     scales : {
                        y : {
                           beginAtZero : true
                        }
                     },
                     plugins: {
                           legend: {
                             position: 'top',
                           },
                           title: {
                             display: true,
                             text: '총'+ totalPrice.toLocaleString() +'원',
                             font :    {size: 30}

                           }
                         }
                  
                  }
               });
      }
   }
   xhr.open("get","./getBarGraph?hotel_id="+hotelId);
   xhr.send();
   
}
window.addEventListener("DOMContentLoaded", function() {
   getSearchDay(0)
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
                  <i class="bi bi-graph-up-arrow fs-4 text-info pt-5"></i><span
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
                  <i class="bi bi-graph-up-arrow pe-4"></i>대시보드
               </div>
            </div>
            <div class="row mt-3">
               <!-- 날짜, 숫자정보 -->
               <div class="col">
                  <div class="card">
                     <div class="card-body">
                        <div class="row mt-1">
                           <div class="col fs-4 fw-semibold">월별 통계</div>
                        </div>
                        <div class="row mt-3">
                           <div class="col text-center fw-semibold fs-3">
                             <span><i class="bi bi-chevron-left" style="cursor: pointer;" onclick="getSearchDay(-1)"></i></span>
                              <span id="dateBox"></span>
                            <span><i class="bi bi-chevron-right" style="cursor: pointer;" onclick="getSearchDay(1)"></i></span>
                           </div>
                        </div>
                        <div class="row m-4 border">
                           <div class="col">
                              <div class="row">
                                 <div class="col fs-5 fw-semibold text-secondary"><span class="monthBox"></span>월달 누적</div>
                              </div>
                              <div class="row">
                                 <div class="col text-center mt-1 mb-2">
                                    <div class="row">
                                       <div class="col fs-3 fw-bold text-primary" id="reserveCountbox"></div>
                                    </div>
                                    <div class="row mt-1 mb-1">
                                       <div class="col fw-semibold">
                                          예약건
                                       </div>
                                    </div>
                                 </div>
                                 <div class="col text-center mt-1 mb-2">
                                    <div class="row">
                                       <div class="col fs-3 fw-bold text-primary" id="reservePricebox"></div>
                                    </div>
                                    <div class="row mt-1 mb-1">
                                       <div class="col fw-semibold">
                                          판매금액
                                       </div>
                                    </div>
                                 </div>
                                 <div class="col text-center mt-1 mb-2">
                                    <div class="row">
                                       <div class="col fs-3 fw-bold text-danger" id="creserveCountbox">0건</div>
                                    </div>
                                    <div class="row mt-1 mb-1">
                                       <div class="col fw-semibold">
                                          취소건
                                       </div>
                                    </div>
                                 </div>
                                 <div class="col text-center mt-1 mb-2">
                                    <div class="row">
                                       <div class="col fs-3 fw-bold text-danger" id="creservePricebox">0원</div>
                                    </div>
                                    <div class="row mt-1 mb-1">
                                       <div class="col fw-semibold">
                                          취소금액
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
            <div class="row mt-3">
               <div class="col">
                  <div class="row">
                     <div class="col-6">
                        <div class="card">
                           <div class="card-body" id ="dashbox">
                              <div class="row  mt-1">
                                 <div class="col fs-5 fw-semibold">객실별 판매 상세</div>
                                 <div class="col small fw-semibold text-end"><span class="me-3 text-primary">판매금액</span><span class="me-3">예약건수</span></div>
                              </div>
                              <div class="row mt-3 mb-3">
                                 <div class="col me-0 pe-0" id="roomChartBox">
                                    <canvas id="doughChart" width="330" height="280"></canvas>
                                 </div>
                                 <div class="col mt-5">
                                    <div class="row mt-2">
                                       <div class="col dashText scroll-container">
                                          <table class="table table-bordered">
                                            <tbody id="roomReserveTable">
                                           
                                            </tbody>
                                          </table>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-6">
                        <div class="card">
                           <div class="card-body">
                              <div class="row  mt-1">
                                 <div class="col fs-5 fw-semibold">판매 그래프</div>
                                 <div class="col small fw-semibold text-end"><span class="me-3 text-primary" onclick="getGraphOfMonth()" id="getGraphOfMonth">이번 달</span><span class="me-3"  onclick="getBarGraph()" id="getBarGraph">올 해</span></div>
                              </div>
                           <div class="row mt-3 mb-2">
                                 <div class="col" id="monthYearChartBox">
                                    <canvas id="graphChart" width="730" height="308"></canvas>
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

      </div>
   
   <link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"></script>

</body>
</html>