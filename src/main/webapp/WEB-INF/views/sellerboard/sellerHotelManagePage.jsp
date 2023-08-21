

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>

.form-control-plain {
		    border: none;
		    outline: none;
		    box-shadow: none;
		    resize: none;
  			height: 25px !important;
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
.buttonColor {
    background-color: #46B8FF	 !important;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.5);
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


.back-color-black{
	 background-color:black;
}
.back-color-gray{
	 background-color:gray;
	 opacity : 0.5;
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

	const hotelId = new URLSearchParams(location.search).get("id");
	var groupId = null;
	
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
				span.id="badge"+group.id;
				span.setAttribute("onclick","getGroupRoom("+group.id+")")
				span.innerText = group.room_group_name;
				groupListBox.appendChild(span);
				
			})
		}
	}
	xhr.open("get","./getGroupList?hotel_id="+hotelId);
	xhr.send();
}


function getGroupRoom(id){
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
		
		}
	}
	xhr.open("get","./getGroupInfo?id="+id);
	xhr.send();
}

function getTimeLine(){
	const xhr = new XMLHttpRequest();
 	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status ==200){
			const response= JSON.parse(xhr.responseText);
			var calendarEl = document.getElementById('calendar');
			/* var getEvents = []; */
	         /* for(reserve of response.timeLine){
	 		    if (reserve.status == "예약") {
	 		    	reserve.color = 'orange';
	 		    }else if(reserve.status == "입실"){
	 		    	reserve.color = 'blue';
	 		    }else{
	 		    	reserve.color = 'red';
	 		    }
	 		   getEvents.push(reserve);
			 }
	         console.log(getEvents); */
			 var calendar = new FullCalendar.Calendar(calendarEl, {
				/*  eventClick:  function(info) {
					 console.log(info.event.id)
					getTimeLineDetail(info) 
				 }, */
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
/* 		         events: getEvents
		         , */
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
window.addEventListener("DOMContentLoaded", function() {
	getGroupList()
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
						<i class="bi bi-gear fs-4 text-info pt-5"></i><span
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
						<i class="bi bi-gear pe-4"></i>방 관리
					</div>
				</div>
				<div class="row mt-3">
					<!-- 날짜, 숫자정보 -->
					<div class="col">
						<div class="card">
							<div class="card-body">
								<div class="row mt-1 ms-1">
									<div class="col text-secondary">
										객실명
									</div>
								</div>
								<div class="row ms-1 mt-1">
									<div class="col  fs-3" id="groupListBox">
										
									</div>
								</div>
								<div class="row mt-5 ms-1">
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

</body>
</html>