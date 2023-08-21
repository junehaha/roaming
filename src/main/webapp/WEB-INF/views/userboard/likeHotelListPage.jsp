<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>마이 페이지</title>
<style>
	    .card-image {
            width: 80px;
            height: 80px;
            overflow: hidden;
            border-radius: 50%;
            border: 1px solid rgba(0, 0, 0, 0.125);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px; 
            margin-left: 70px;
        }
        .card-image img {
        width: 100%;
        height: 100%;
    	}
        
        .card-body {
            text-align: center;
        }

</style>
<script>
//현재 날짜 생성
var current = new Date();
// 내일
var next = new Date(current);
next.setDate(current.getDate() + 1);

// 월 이름 배열
var month = [
  "01", "02", "03", "04", "05", "06",
  "07", "08", "09", "10", "11", "12"
];

// 요일 이름 배열
var day = [
  "일", "월", "화", "수", "목", "금", "토"
];

//월 이름 배열
var month = [
  "01", "02", "03", "04", "05", "06",
  "07", "08", "09", "10", "11", "12"
];

// 요일 이름 배열
var day = [
  "일", "월", "화", "수", "목", "금", "토"
];

// 월, 일, 요일 추출
var currentMonth = month[current.getMonth()];
var currentDay = current.getDate().toString().padStart(2, '0');
var currentDayOfWeek = day[current.getDay()];
var currentYear = current.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
//내일
var nexttMonth = month[next.getMonth()];
var nextDay = next.getDate().toString().padStart(2, '0');
var nextDayOfWeek = day[next.getDay()];
var nextYear = next.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

// 변환된 값 출력
var startDay = currentYear + "/" + currentMonth + "/" + currentDay + "/(" + currentDayOfWeek + ")";
var endDay = nextYear + "/" + nexttMonth + "/" + nextDay + "/(" + nextDayOfWeek + ")";

var weekDays = [current.getDay()];


function getFavoriteHotelList(){
	const xhr = new XMLHttpRequest();
	const listBox = document.getElementById("hotelBox");

	listBox.innerHTML = "";
		
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			if(response.result == "success"){
				
					for(list of response.list){
						const row = document.createElement("div");
						row.classList.add("row");
						row.classList.add("mt-3");
						row.classList.add("border-bottom");
						
						const imgdiv = document.createElement("div");
						imgdiv.classList.add("col-4","p-0");
						
						const action = document.createElement("a");
						action.href = "./hotelInfoPage?id="+list.hotelDto.id+"&startDate="+startDay+"&endDate="+endDay+"&people="+2+"&days="+weekDays;
						action.style.textDecoration = "none";
						const img = document.createElement("img");
						img.src = "/uploadFiles/" + list.hotelDto.hotel_img;
						img.style.width = "300px";
						img.style.borderRadius = "10px";
						img.style.height = "200px";
						action.appendChild(row);
						imgdiv.appendChild(img);
						
						const col = document.createElement("div");
						col.classList.add("col");
						
						
						const namediv = document.createElement("div");
						namediv.classList.add("row");
						namediv.classList.add("mt-0");
						namediv.classList.add("fs-5");
						namediv.classList.add("fw-semibold");
						
						const namebox = document.createElement("div");
						namebox.classList.add("col");
						namebox.classList.add("text-start");
						namebox.innerText = list.hotelDto.hotel_name;
						namebox.style.color = "black";
						namediv.appendChild(namebox);
				
						const infodiv = document.createElement("div");
						infodiv.classList.add("row");
						infodiv.classList.add("mt-1");
						infodiv.classList.add("mb-1");
						
						const infobox = document.createElement("div");
						infobox.classList.add("col");
						infobox.classList.add("text-start","text-secondary");

						
						const textNode = document.createTextNode(list.category.category + " · " + list.hotelDto.hotel_loc);
						infobox.appendChild(textNode);
						
						infodiv.appendChild(infobox);
						
						const infodiv2 = document.createElement("div");
						infodiv2.classList.add("row");
						infodiv2.classList.add("mt-1");
						infodiv2.classList.add("mb-5");
						
						const infobox2 = document.createElement("div");
						infobox2.classList.add("col");
						infobox2.classList.add("text-start");
						infobox2.style.color = "black"
						const starBox =document.createElement("i");
						starBox.classList.add("bi","bi-star-fill","text-primary")
						infobox2.appendChild(starBox);
						
						const textNode2 = document.createTextNode(" "+list.star);
						infobox2.appendChild(textNode2);
						
						const rtextNode = document.createTextNode("(" + list.review + ")");

						infobox2.appendChild(rtextNode);
						
						infodiv2.appendChild(infobox2);
						
						const pricediv = document.createElement("div");
						pricediv.classList.add("row");
						pricediv.classList.add("mt-5");
						
						
						const badgediv = document.createElement("div");
						badgediv.classList.add("col","mt-4","pt-3");
						
						const badge1 = document.createElement("span");
						badge1.classList.add("badge","text-white");
						badge1.style.backgroundColor ="#54BD54";
					
						
						badge1.innerText = "무료취소";
						badgediv.appendChild(badge1)
						

						pricediv.appendChild(badgediv);
						if(list.oriPrice > list.changePrice){
						const badge3 = document.createElement("span");
						badge3.classList.add("badge","text-bg-danger","ms-2");
						badge3.innerText = "초특가";
						badgediv.appendChild(badge3)
						}
						
						const pricebox = document.createElement("div");
						pricebox.classList.add("col","text-end");
						pricediv.appendChild(pricebox);

						const priceInRow = document.createElement("div");
						priceInRow.classList.add("row");
						pricebox.appendChild(priceInRow)
						const priceInCol = document.createElement("div");
						priceInCol.classList.add("col","mt-2");
						priceInRow.appendChild(priceInCol)
						
							const salePrice = document.createElement("p");
							salePrice.classList.add("text-decoration-line-through","opacity-50","mb-0","text-black");
							salePrice.innerText = list.oriPrice.toLocaleString() +"원";
							
	 						if(list.oriPrice <= list.changePrice){
	 							salePrice.classList.add("text-white");
							 }
						
							priceInCol.appendChild(salePrice)
						
							
						
						
						
						const priceInRow2 = document.createElement("div");
						priceInRow2.classList.add("row");
						pricebox.appendChild(priceInRow2)
						
						const priceInCol2 = document.createElement("div");
						priceInCol2.classList.add("col","fs-5","fw-semibold");
						priceInRow2.appendChild(priceInCol2)
						if(list.oriPrice > list.changePrice){
							const salePerSpan = document.createElement("span");				
							salePerSpan.classList.add("text-danger")
							priceInCol2.appendChild(salePerSpan);
							const discountRate = Math.round((list.oriPrice - list.changePrice) / list.oriPrice * 100) + "%";
							salePerSpan.innerText = discountRate;
						}	
						const price = list.changePrice;
						const formattedPrice = new Intl.NumberFormat('ko-KR').format(price);
						const priceSpan = document.createElement("span");				
						priceSpan.classList.add("ms-1")
						priceSpan.innerText = formattedPrice +"원";
						priceSpan.style.color = "black";

						
						const parkSpan = document.createElement("span");
						parkSpan.classList.add("opacity-50")
						parkSpan.style.color = "black";
						parkSpan.innerText = " 1박 "
						parkSpan.style.fontSize = "15px"
						priceInCol2.appendChild(priceSpan);
						priceInCol2.appendChild(parkSpan);
						
						
						const priceInRow3 = document.createElement("div");
						priceInRow3.classList.add("row");
						pricebox.appendChild(priceInRow3)
						
						const priceInCol3 = document.createElement("div");
						priceInCol3.classList.add("col","fw-semibold","opacity-50","small");
						priceInCol3.style.color = "black";

						priceInCol3.innerText = "세금 포함 가격"
						priceInRow3.appendChild(priceInCol3)
						
						row.appendChild(imgdiv);
						col.appendChild(namediv);
						col.appendChild(infodiv);
						col.appendChild(infodiv2);
						col.appendChild(pricediv);
						row.appendChild(col);
						
						hotelBox.appendChild(action);
						
						
				}
				}else if(response.result == "fail"){
					const div = document.createElement("div");
					div.classList.add("row")
					div.classList.add("mt-5","mb-5")
					const col = document.createElement("div");
					col.classList.add("col");
					col.classList.add("text-center");
					col.classList.add("fw-semibold");
					col.classList.add("fs-4");
					col.innerText = "관심있는 숙소가 없습니다.";
					div.appendChild(col);
					listBox.appendChild(div);
					
				}
		}
	}
	xhr.open("get","./getFavoriteHotelList?user_id="+userId+"&weekDays="+weekDays+"&startDate="+startDay);
	xhr.send();
	
}
let userId= null;

function getUserId(){
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			if(response.result =="success"){
				userId = response.userId;
			}
		}
	}
	xhr.open("get","./getUserId",false);
	xhr.send();
}
window.addEventListener("DOMContentLoaded",function(){
	getUserId()
	getFavoriteHotelList()
	
});
</script>
</head>
<body>
	  <div class="container-fluid">
	  <jsp:include page="../common/topNavi.jsp"></jsp:include>
      <div class="row">
         <div class="col-2"></div>
         <div class="col-8">
            <div class="row">
               <div class="col-12">
                  <h4 class="mt-5">프로필 관리</h4>
               </div>
                  <div class="row mt-4">
                     <div class="col-3">
                        <div class="card" style="width: 14rem;">
                           <div class="card-image">
                             <c:choose>
                        		<c:when test="${fn:startsWith(sessionUser.profile_img, 'h')}">
                            		<img src="${sessionUser.profile_img}" class="card-img-top">
                        		</c:when>
                        		<c:otherwise>
                            		<img src="/uploadFiles/${sessionUser.profile_img}" class="card-img-top">
                        		</c:otherwise>
                        	</c:choose>
                           </div>
                           <div class="card-body">
                             <p class="card-text">${sessionUser.user_name}</p>
                           <a href="./myPage?id=${sessionUser.id}" style="text-decoration: none;">
							 <span class="card-text"><i class="bi bi-house" style="color: black;"></i></span>
						   </a>
                           </div>
                         </div>
                         <div class="card" style="width: 14rem; margin-top: 20px;">
                           <div class="card-point">
                              <p class="card-text" style="font-size: 14px; margin-top: 10px; margin-left: 10px;">내 포인트 : <span style="float: right; color: #0078ff; margin-right: 10px;"><fmt:formatNumber value="${myPage.myPoint}" pattern="#,###" var="formattedPrice" />
                          			${formattedPrice} P</span></p>
                              <p class="card-text" style="font-size: 14px; margin-top: -10px; margin-bottom: 10px; margin-left: 10px;">내 쿠폰 : <span style="float: right; color: #0078ff; margin-right: 10px;">${myPage.myCouponCount} 장</span></p>
                          </div>
                         </div>
                         <div class="row mt-4">
                           <h5>포인트샵</h5>
                           <a href="./orderHistoryPage" style="font-size: 15px; color: gray; text-decoration: none;">
                           <p>주문 내역 조회</p>
						   </a>
                           <a href="./userItemLikePage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>좋아요 리스트</p>    
						   </a>
						   <a href="./userPointPage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>포인트</p>    
						   </a>
                        </div>
                        <div class="row mt-4">
                           <h5>쿠폰</h5>
                           <a href="./userCouponPage" style="text-decoration: none;">
							    <span style="font-size: 15px; color: gray;">내 쿠폰함</span>
							</a>
                        </div>
                        <div class="row mt-4">
                           <h5>동행</h5>
                           <p style="font-size: 15px; color: gray;">동행 현황</p>
                           <p style="font-size: 15px; color: gray;">동행 신청 목록</p>
                           <p style="font-size: 15px; color: gray;">지난 동행</p>
                        </div> 
                        <div class="row mt-4">
                           <h5>숙소</h5>
                         <a href="./hotelCurrentReservePage" style="font-size: 15px; color:gray; text-decoration: none;">
							<p>예약 내역</p>    
						   </a>
                           <a href="./hotelBeforeReservePage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>지난 예약</p>    
						   </a>
                            <a href="./likeHotelListPage" style="font-size: 15px; color: #0078ff; text-decoration: none;">
							<p>찜한 숙소</p>    
						   </a>
                        </div>
                        <div class="row mt-4">
                           <h5>짐 서비스</h5>
                           <p style="font-size: 15px; color: gray;">배송 신청 내역</p>
                        </div>
                        <div class="row mt-4">
                           <h5>고객센터</h5>
                           <p style="font-size: 15px; color: gray;">나의 문의 내역</p>
                        </div>         
                     </div>  
                     <div class="col-9">
                  <div class="row card-context"> 
                     <div class="card" style="width: 100rem; height: auto;">
                         <div class="col" id="hotelBox">
                        	
                        </div>
                        </div>
                     </div>
                  </div>
               </div>
                  </div>
               </div>
               
         <div class="col-2"></div>
      </div>
      </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>