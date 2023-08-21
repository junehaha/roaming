<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script>
	const postId = new URLSearchParams(location.search).get("id");

	let dayNumber = null;
	let tripDay = null;
	let todayDate = null;

	 const datas = {
			 days : []
	 }
	
	function xml() {
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 & xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
			
		}
	}
	
	xhr.open("get", "쿼리");
	xhr.send();
}
	

	
	
	function getDayList() {
		  const container_days = document.getElementById("container_days");
		  const xhr = new XMLHttpRequest();
		  xhr.onreadystatechange = function () {
		    if (xhr.readyState === 4 && xhr.status === 200) {
		      const response = JSON.parse(xhr.responseText);
		      
		      
		      const dayList = response.dayList;
		      dayNumber = dayList[0].id;
		      console.log("dayNumber = " + dayNumber);
		      
		      
		      for(const data of dayList) {
		        const div1 = document.createElement("div");
		        div1.classList.add("row");
		        const div2 = document.createElement("div");
		        div2.classList.add("col", "border-bottom", "text-center", "pt-1");
		        div2.style.height = "60px";
		        div2.id = data.id;
		        div2.onmouseover = () => {
		        	  div2.style.backgroundColor = "#d9e7fa";
		        };
		        div2.onmouseout = () => {
		        	  div2.style.backgroundColor = "";
		        };
		        div2.onclick = () => {
		        	dayNumber = data.id;
		        	tripDay = data.trip_day;
		        	todayDate = data.todayDate;
		        	console.log("onclick : " + dayNumber)
		        	onclickDay();
		        	const elements = document.getElementsByClassName("col border-bottom text-center pt-1");
		        	  for (const element of elements) {
		        	    if (element.id === div2.id) {
		        	    	element.classList.remove("unClick");
		        	    	element.classList.add("click");
		        	    } else {
		        	      	element.classList.remove("click");
		        	      	element.classList.add("unClick");
		        	    }
		        	  }
		        }		        
		        const div3 = document.createElement("div");
		        const span1 = document.createElement("span");
		        span1.textContent = "Day " + data.trip_day;
				const date = new Date(data.todayDate);
				
				var monthNames = [
			        "01", "02", "03", "04", "05", "06",
			        "07", "08", "09", "10", "11", "12"
			      ];

			      var dayNames = [
			        "일", "월", "화", "수", "목", "금", "토"
			      ];

			      var smonth = monthNames[date.getMonth()];
			      var sday = date.getDate().toString().padStart(2, '0');
			      var sdayOfWeek = dayNames[date.getDay()];
			      var syear = date.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

			      var dayB = smonth + "." + sday + "(" + sdayOfWeek + ")";
			      
			     
			      
		        const span2 = document.createElement("span");
		        span2.textContent = dayB;
		        
		        
		        div3.appendChild(span1);
		        div3.appendChild(document.createElement("br"));
		        div3.appendChild(span2);
		        div2.appendChild(div3);
		        div1.appendChild(div2);
		        container_days.appendChild(div1);
		        
		        const obj = {};
		        obj["day"] = data.id;
		        obj["schedule"] = [];
		        datas.days.push(obj);
		        
		      }
		      
		      tripDay = dayList[0].trip_day; 
		      todayDate = dayList[0].todayDate;
		      
		      onclickDay();
		      
		    }
		    
		    const firstDiv2 = document.getElementsByClassName("col border-bottom text-center pt-1")[0];
		    if(firstDiv2){
			    if(!firstDiv2.classList.contains("click") && !firstDiv2.classList.contains("unClick")) {
			    	firstDiv2.classList.add("click");
			    }
		    }
		    
		  }
		  
		  xhr.open("get", "./getDayList?postId=" + postId);
		  xhr.send();
		}
		


		function onclickDay() {
			console.log("온클릭")
			const todayDateAs = new Date(todayDate);
			   
			   var monthNames = [
			     "01", "02", "03", "04", "05", "06",
			     "07", "08", "09", "10", "11", "12"
			   ];

			   var dayNames = [
			     "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"
			   ];

			   var smonth = monthNames[todayDateAs.getMonth()];
			   var sday = todayDateAs.getDate().toString().padStart(2, '0');
			   var sdayOfWeek = dayNames[todayDateAs.getDay()];
			   var syear = todayDateAs.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기


			   var startDate = smonth + "." + sday + "(" + sdayOfWeek + ")";
			
			const viewBox = document.getElementById("viewBox");
			viewBox.style.backgroundColor = "#d9e7fa";
			const dayClickView = document.getElementById("dayClickView");
			dayClickView.innerText = "Day " + tripDay + " | " + startDate; 
			
			const days = datas.days.find(day => day.day === dayNumber);
			console.log("ddd" + days);
			const scheduleContainer = document.getElementById("scheduleContainer");
			scheduleContainer.innerHTML = "";
			
			days.schedule.forEach(function(list){
					console.log("되냐 ?");
					
					const row99 = document.createElement("div");
					row99.classList.add("row");
					const mainCol = document.createElement("div");
					mainCol.classList.add("col", "border-bottom");
					mainCol.style.height = "120px";
					const row1 = document.createElement("div");
					row1.classList.add("row");
					const col1 = document.createElement("div");
					col1.classList.add("col-10", "mt-1", "text-center");
					const span1 = document.createElement("span");
					span1.style.fontSize = "20px";
					span1.innerText = list.name;
					
					const col2 = document.createElement("div");
					col2.classList.add("col-2", "pr-3");
					const input2 = document.createElement("input");
					input2.type = "button";
					input2.id = "deleteButton";
					input2.onclick = () => {
						const index = days.schedule.indexOf(list);
						deleteSchedule(index, days);
					};
					input2.style.height = "10px";
					input2.style.width = "10px";
					
					col1.appendChild(span1);
					col2.appendChild(input2);
					row1.appendChild(col1);
					row1.appendChild(col2);
					
					const row2 = document.createElement("div");
					row2.classList.add("row", "mt-2");
					const col3 = document.createElement("div");
					col3.classList.add("col-auto", "ms-4");
					const label1 = document.createElement("label");
					label1.for = "timeInput";
					label1.innerText = "시간";
					col3.appendChild(label1);
					const col4 = document.createElement("div");
					col4.classList.add("col");
					const input3 = document.createElement("input");
					input3.id = "timeInput";
					input3.classList.add("form-control")
					input3.type = "time";
					input3.style.height = "28px";
					input3.style.width = "85%";
					if(list.timeInput) {
						input3.value = list.timeInput;
					}
					col3.appendChild(label1);
					col4.appendChild(input3);
					row2.appendChild(col3);
					row2.appendChild(col4);
					
					const row3 = document.createElement("div");
					row3.classList.add("row", "mt-2");
					const col5 = document.createElement("div");
					col5.classList.add("col-auto", "ms-4");
					const label2 = document.createElement("label");
					label2.for = "memoInput";
					label2.innerText = "메모";
					col5.appendChild(label2);
					const col6 = document.createElement("div");
					col6.classList.add("col");
					const input4 = document.createElement("input");
					input4.id = "memoInput";
					input4.classList.add("form-control");
					input4.type = "text";
					input4.placeholder = "메모를 작성해주세요.";
					input4.style.height = "28px";
					input4.style.width = "85%";
					if(list.memoInput) {
						input4.value = list.memoInput;
					}
					input4.onblur = () => {
						const index = days.schedule.indexOf(list);
						const time = input3.value;
						const memo = input4.value;
						updateSchedule(index, time, memo);
					}
					
					col5.appendChild(label2);
					col6.appendChild(input4);
					row3.appendChild(col5);
					row3.appendChild(col6);
					
					mainCol.appendChild(row1);
					mainCol.appendChild(row2);
					mainCol.appendChild(row3);
					
					row99.appendChild(mainCol);
					scheduleContainer.appendChild(row99);	
				});
						
				
	
			
		}

		function deleteSchedule(index, days) {
			
			console.log("해당 스케줄 인덱스 : " + index);
			days.schedule.splice(index, 1); // 스케줄 삭제
			
			onclickDay();
		}
		
		function updateSchedule(index, time, memo) {
			const day = datas.days.find((item) => item.day === dayNumber);
			if(!day) {
				return;
			}
			
			const schedule = day.schedule.find((item) => item.index === index);
			if(!schedule) {
				return;
			}
			
			schedule.timeInput = time;
			schedule.memoInput = memo;
		}

		function handleIconClick(name, address) {
			console.log("name = " + name);
			console.log("address = " + address);
			console.log("dayNumber = " + dayNumber);
			const target = datas.days.find(day => day.day === dayNumber);
			const newSchedule = {
				index : target.schedule.length, // index 값 추가
				name : name,
				address : address,
				timeInput : '',
				memoInput : '',
			}
			
			target.schedule.push(newSchedule);
			
			onclickDay();
		}

		
		function insertSchedule() {
			 for (const day of datas.days) {
				    if (day.schedule.length == 0) {
				      alert("각 일차마다 일정을 입력해주세요.");
				      return;				      
				    }
				  }
			
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 & xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					if(response.result === "success") {
						console.log("insert 성공");
						window.location.href= "./postPartyRoom?id=" +postId;
					}
				
			}
		}
		
		xhr.open("post", "./insertSchedule");
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.send(JSON.stringify(datas));
	}

		function cancelProcess() {
			console.log("실행")
			location.href= "./postDetailPage?id=" + postId;
		}
	
		
		function scheduleChange() {
			const day_start = document.getElementById("day_start").value;
			const day_end = document.getElementById("day_end").value;
			console.log("start : " + day_start)
			console.log("end : " + day_end)
			const formData = new FormData();
			formData.append("id", postId);
			formData.append("day_start", day_start);
			formData.append("day_end", day_end);
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 & xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					
					window.location.href= "./testPost?id=" +postId;
						
				}
			}
		
		xhr.open("post", "./scheduleChange");
		xhr.send(formData);
	}
		
	
	
	 
	 
	window.addEventListener("DOMContentLoaded", function() {
		  getDayList();
		});
	 
 </script>
<style>
	::placeholder {
 		 font-size: 12px;
	}
</style>
    <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}

.click {
	background: #d9e7fa;
}

.unClick {
	background: white;	
}
</style>
</head>
<body>
	 <div class="container-fluid">
		<div class="row">
			<div class="col">
				<jsp:include page="../common/topNavi.jsp"></jsp:include>
			</div>
		</div>
	</div>


    <div class="container-fluid">
        <div class="row" style="height: calc(100vh - 120px);">
            <!-- 첫번째 -->
            <div class="col-1 border-left border-top border-bottom">
                <div class="row">
                    <div class="col border-bottom text-center pt-3" style="height: 60px;">
                        <span>일정</span>
                    </div>
                </div>
                <!-- for -->
                <div id="container_days"></div>
                
                <!-- <div id="container_days" class="row">
                    <div class="col border-bottom text-center pt-1" style="height: 60px;">
                        <div>
                            <span>Day 1</span>
                        </div>
                        <div>
                            <small>06.11 (화요일)</small>
                        </div>
                    </div>
                </div> -->
                <!-- /for -->
            </div>





            <!-- 두번째 -->
            <div class="col-2 border p-0">
                <div id="day_info_container">
                    <div id="viewBox" class="col border-bottom text-center pt-3" style="height: 60px;">
                        <span id="dayClickView">Day1&nbsp|&nbsp06.11(화요일)</span>
                    </div>
                </div>
                <!-- for -->
                <div id="scheduleContainer">
                	<div class="row">
                    <!-- <div class="col border-bottom" style="height: 120px;">
                        <div class="row">
                            <div class="col-10 mt-1 text-center">
                                <span style="font-size: 20px;">노량진 컵밥</span>
                            </div>
                            <div class="col-2 pr-3">
                                <input type="button" style="height: 10px; width: 10px;">
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-auto ms-4">
                                <label for="timeInput">시간</label>
                            </div>
                            <div class="col">
                                <input id="timeInput" class="form-control" type="time" style="height: 28px; width: 85%;">
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-auto ms-4">
                                <label for="memoInput">메모</label>
                            </div>
                            <div class="col">
                                <input id="memoInput" class="form-control" type="text" placeholder="메모를 작성해주세요." style="height: 28px; width: 85%;">
                            </div>
                        </div>
                    </div> -->
                    
                    
                    
                    </div>
                </div>
                <!-- /for -->
            </div>

            <!-- 세번째 -->
        <div class="col map_wrap border-bottom" style="height: 100%;">
		    <div class="border-bottom border-top border-right" id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
		
		    <div id="menu_wrap" class="border-top border-bottom border-right" style="background: white; margin: 0 0 0 0; width: 300px;">
		        <div class="option pt-2" style="height: 51px;">
		            <div>
		                <form onsubmit="searchPlaces(); return false;">
		                    <div style="position: relative; display: flex; justify-content: center; align-items: center;">
		                    <input type="text" value="이태원 맛집" id="keyword" size="15" style="height: 35px; width: 210px; padding-left: 10px;" class="form-control "> 
		                    <button type="submit" class="btn btn-primary ms-2 me-1 pe-3 ps-3 pt-1" style="position: absolute; top: 5px; right: 50px">검색</button>
		                    </div>
		                </form>
		            </div>
		        </div>
		        <hr>
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>
		    </div>
		</div>
         </div>
     </div>
		
		<div style="position: absolute; top: 60px; right: 10px;">
			
				<a class="btn btn-outline-primary me-3 dropdown" data-bs-toggle="dropdown" aria-expanded="false">일정변경</a>
					
					<div class="dropdown-menu mt-3 p-0" style="width: 300px;">
				        <form class="px-4 py-3">
				          <div class="mb-3">
				            <label for="day_start" class="form-label">시작일</label>
				            <input type="date" class="form-control" id="day_start">
				          </div>
				          <div class="mb-3">
				            <label for="day_end" class="form-label">종료일</label>
				            <input type="date" class="form-control" id="day_end">
				          </div>
				          	<input class="d-grid btn btn-outline-primary" style="margin-left: auto;" type="button" value="일정변경" onclick="scheduleChange();">
				        </form>
				    </div>   
			
			<a class="btn btn-outline-secondary me-3" onclick="cancelProcess();">취  소</a>
			<a class="btn btn-outline-success me-3" onclick="insertSchedule();">저  장</a>
		</div>
          
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6bb230f942595875a71c9910b889e653&libraries=services"></script>
<script>
/* function indexText() {
	const insertBtn = document.getElementById("insertBtn");
    insertBtn.click = () => {
    	console.log("클릭 실행 인덱스 : " + index);
    	console.log("클릭 실행 플레이스 : " + places);
    }
	
} */



// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' + 
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';
                

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
      				'<i onclick="handleIconClick(\''+places.place_name+'\', \''+places.road_address_name+'\')" class="bi bi-star-fill" style="font-size: 20px; position: absolute; top: 30px; right: 20px;">' + '</i>' +
                '</div>';    

    el.innerHTML = itemStr;
    el.className = 'item';

    
    
    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 
window.addEventListener('DOMContentLoaded', function() {
	  // menu_wrap 요소가 로드된 후에 실행될 코드
	  var menuEl = document.getElementById('menu_wrap');
	  menuEl.scrollTop = 0;
	});

</script>
      





    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>
