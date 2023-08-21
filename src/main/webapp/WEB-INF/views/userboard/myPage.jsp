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
<script>

		
		function getMyTemperature() {
			   const xhr = new XMLHttpRequest();
			   xhr.onreadystatechange = function () {
			      if(xhr.readyState == 4 && xhr.status == 200) {
			         const response = JSON.parse(xhr.responseText);
			         const temp = response.temperature;
			         const myTemperatureContainer = document.getElementById("myTemperatureContainer")
			         myTemperatureContainer.innerText = temp.score + "℃";
			         const myImoBox = document.getElementById("myImoBox")
			         if(temp.score <= 30) {
			        	 myImoBox.innerText =	"😱"
					}else if(temp.score <= 34) {
						myImoBox.innerText =	"😭"
					}else if(temp.score <= 36.5) {
						myImoBox.innerText =	"😄"
					}else if(temp.score >= 40) {
						myImoBox.innerText =	"😍"
					}else if(temp.score >= 60) {
						myImoBox.innerText =	"😎"
					}
			         const myTempScoreBox = document.getElementById("myTempScoreBox")
			         myTempScoreBox.style.width = temp.score + "%";
			   }
			}
			
			xhr.open("get", "../post/getMyTemperature");
			xhr.send();      
		}
		
		
		
		
		

		/* profileModal */
		function profileModal(userId) {
				const forContainer = document.getElementById("forContainer");
			    forContainer.innerHTML = "";
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
					const userDto = response.userDto;
					const temp = response.temperature;
					const birthday = response.birthday;
					
					const forContainer = document.getElementById("forContainer");
					const countContainer = document.getElementById("countContainer");
					countContainer.innerText = "받은 후기 " + response.count;
					const profileContainer = document.getElementById("profileContainer");
					profileContainer.src = "/uploadFiles/" + userDto.profile_img 
					
					const tempContainer = document.getElementById("tempContainer");
					tempContainer.style.width = temp.score + "%"
					const nameContainer = document.getElementById("nameContainer");
					nameContainer.innerText = userDto.user_name;
					const ageBox = document.getElementById("ageBox");
					ageBox.innerText = birthday + " · ";
					const genderBox = document.getElementById("genderBox");
					if(userDto.gender == "M") {
						genderBox.innerText = "남자"
					}else {
						genderBox.innerText = "여자"
					}
					
					
					const temperatureContainer = document.getElementById("temperatureContainer");
					temperatureContainer.innerText = temp.score + "℃";
					
					const imoBox = document.getElementById("imoBox");
					if(temp.score <= 30) {
						imoBox.innerText =	"😱"
					}else if(temp.score <= 34) {
						imoBox.innerText =	"😭"
					}else if(temp.score <= 36.5) {
						imoBox.innerText =	"😄"
					}else if(temp.score >= 40) {
						imoBox.innerText =	"😍"
					}else if(temp.score >= 60) {
						imoBox.innerText =	"😎"
					}
					
					if (response.list == null || response.list.length === 0) {
						const forDiv = document.createElement("div");
							forDiv.classList.add("for")
							const row1 = document.createElement("div");
							row1.classList.add("row", "mt-3", "border-bottom")
							const row1_col1 = document.createElement("div");
							row1_col1.classList.add("col", "d-flex", "align-items-center", "justify-content-center")
							const row1_col1_label = document.createElement("label");
							row1_col1_label.style.color = "rgb(154, 154, 154)"
							row1_col1_label.style.textAlign = "center"
							const row1_col1_label_i = document.createElement("i");
							row1_col1_label_i.classList.add("bi", "bi-chat-dots-fill")
							row1_col1_label_i.style.fontSize = "35px"
							const row1_col1_label_p = document.createElement("p");
							row1_col1_label_p.style.marginBottom = "25px"
							row1_col1_label_p.innerText = "동행 후기 내역이 없습니다."
							
							row1_col1_label.appendChild(row1_col1_label_i)
							row1_col1_label.appendChild(row1_col1_label_p)
							row1_col1.appendChild(row1_col1_label)
							row1.appendChild(row1_col1)
							forDiv.appendChild(row1)
							forContainer.appendChild(forDiv)
		
					}else {
					response.list.forEach(function(list){
						
						const forDiv = document.createElement("div");
						forDiv.classList.add("for")
						
						const row1 = document.createElement("div");
						row1.classList.add("row", "mt-3")
						const row1_col1 = document.createElement("div");
						row1_col1.classList.add("col-2", "d-flex", "align-items-center", "justify-content-center")
						const row1_col1_img = document.createElement("img");
						row1_col1_img.src = "/uploadFiles/" + list.sendDto.profile_img;
						row1_col1_img.onclick = () => {
							profileModal(list.sendDto.id)
						}
						row1_col1_img.style.width = "40px" 
						row1_col1_img.style.height = "40px"
						row1_col1_img.style.borderRadius = "50%"
						row1_col1.appendChild(row1_col1_img)
						row1.appendChild(row1_col1)
						
						const row1_col2 = document.createElement("div");
						row1_col2.classList.add("col")
						const row1_col2_row1 = document.createElement("div");
						row1_col2_row1.classList.add("row")
						const row1_col2_row1_col = document.createElement("div");
						row1_col2_row1_col.classList.add("col", "p-0", "mt-1")
						const row1_col2_row1_col_span = document.createElement("span");
						row1_col2_row1_col_span.innerText = list.sendDto.user_name;
						row1_col2_row1_col.appendChild(row1_col2_row1_col_span)
						row1_col2_row1.appendChild(row1_col2_row1_col)
						row1_col2.appendChild(row1_col2_row1)
		
						const row1_col2_row2 = document.createElement("div");
						row1_col2_row2.classList.add("row")
						const row1_col2_row2_col = document.createElement("div");
						row1_col2_row2_col.classList.add("col", "p-0")
						const row1_col2_row2_col_span = document.createElement("span");
						
						const inputDate = new Date(list.sendDto.reg_date);
					   var monthNames = [
					     "01", "02", "03", "04", "05", "06",
					     "07", "08", "09", "10", "11", "12"
					   ];
		
					   var dayNames = [
					     "일", "월", "화", "수", "목", "금", "토"
					   ];
		
					   var smonth = monthNames[inputDate.getMonth()]; // 월
					   var sday = inputDate.getDate().toString().padStart(2, '0'); // 일
					   var sdayOfWeek = dayNames[inputDate.getDay()]; // 요일
					   var syear = inputDate.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
		
					   var shour = inputDate.getHours().toString().padStart(2, '0'); // 시간
					   var sminute = inputDate.getMinutes().toString().padStart(2, '0'); // 분
		
					   var regDate = syear + "." + smonth + "." + sday + " " + shour + ":" + sminute; 
						row1_col2_row2_col_span.innerText = regDate;
						row1_col2_row2_col.appendChild(row1_col2_row2_col_span)
						row1_col2_row2.appendChild(row1_col2_row2_col)
						row1_col2.appendChild(row1_col2_row2)
						row1.appendChild(row1_col2)
						
						const row2 = document.createElement("div");
						row2.classList.add("row", "border-bottom")
						const row2_col = document.createElement("div");
						row2_col.classList.add("col")
						row2_col.style.marginLeft = "53px";
						const row2_col_p = document.createElement("p");
						row2_col_p.innerText = list.postReviewDto.content;
						
						row2_col.appendChild(row2_col_p)
						row2.appendChild(row2_col)
						forDiv.appendChild(row1)
						forDiv.appendChild(row2)
						forContainer.appendChild(forDiv)
					});
				}
					
				
				const modal = bootstrap.Modal.getOrCreateInstance("#profileModal")
					modal.show();
					console.log("모달오픈")
				
			    	}         
			   }
				xhr.open("get", "../post/getProfileModal?userId=" + userId);
				xhr.send();   
			}
		
window.addEventListener("DOMContentLoaded", function(){
	getMyTemperature()
});		
		
</script>

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
                        		<c:when test="${fn:startsWith(myPage.userDto.profile_img, 'h')}">
                            		<img src="${myPage.userDto.profile_img}" class="card-img-top">
                        		</c:when>
                        		<c:otherwise>
                            		<img src="/uploadFiles/${myPage.userDto.profile_img}" class="card-img-top">
                        		</c:otherwise>
                        	</c:choose>
                           </div>
                           <div class="card-body">
                             <p class="card-text">${myPage.userDto.user_name}</p>
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
                           <a href="./partyListPage" style="text-decoration: none;"><p style="font-size: 15px; color: gray;">동행 현황</p></a>
                           <a href="./joinConfirmPage" style="text-decoration: none;"><p style="font-size: 15px; color: gray;">동행 신청 목록</p></a>
                           <a href="./pastPartyListPage" style="text-decoration: none;"><p style="font-size: 15px; color: gray;">지난 동행</p></a>
                        </div> 
                        <div class="row mt-4">
                           <h5>숙소</h5>
                            <a href="./hotelCurrentReservePage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>예약 내역</p>    
						   </a>
                           <a href="./hotelBeforeReservePage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>지난 예약</p>    
						   </a>
                            <a href="./likeHotelListPage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>찜한 숙소</p>    
						   </a>
                        </div>
                        <div class="row mt-4">
                           <h5>짐 서비스</h5>
                           <a href="../userboard/userZimInfoPage" style="text-decoration: none;">
                                 <span style="font-size: 15px; color: gray;">배송 상태 조회</span>
                           </a>
                        </div>
                        <div class="row mt-4">
                           <h5>고객센터</h5>
                           <a href="../usercsboard/oneOnOneQaPage" style="text-decoration: none;">
                                 <span style="font-size: 15px; color: gray;">1:1 문의내역</span>
                             </a>
                        </div>       
                     </div>  
                     <div class="col-9">
                  <div class="row card-context"> 
                     <div class="card" style="width: 100rem; height: auto;">
                        <div class="card-image" style="margin-left: 413px; ">
                        	<c:choose>
                        		<c:when test="${fn:startsWith(myPage.userDto.profile_img, 'h')}">
                        			 <img src="${myPage.userDto.profile_img}" class="card-img-top">
                        		</c:when>
                        		<c:otherwise>
                        			 <img src="/uploadFiles/${myPage.userDto.profile_img}" class="card-img-top">
                        		</c:otherwise>
                        	</c:choose>
                     
                        </div>
                            <div class="card-body">
                              <p class="card-text">${myPage.userDto.user_name}
								<a href="../user/updateUserInfoPage?id=${sessionUser.id}">
								  <i class="bi bi-pencil-square" style="color: black;"></i>
								</a>
                              </p>
                              
                               <div class="row mt-2" style="justify-content: center;">
                <div class="col-12" style="position: relative; width: 500px;">
                    <small style="position: absolute; left: 30%; bottom: 27px; color: gray;">첫 온도 36.5</small>
                    <div class="text-end mb-1 me-1">
                      <b style="color: #36ad37;" id="myTemperatureContainer">39.1℃</b>
                      <span id="myImoBox">😄</span>
                    </div>
                    <i class="bi bi-caret-down-fill" style="position: absolute; left: 35.8%; bottom: 10px;"></i>
                    <div class="progress" role="progressbar" aria-label="Basic example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="height: 12px;">
                        <div class="progress-bar" id="myTempScoreBox" style="width: 36.5%; background-color: #36ad37;"></div>
                    </div>
                </div>
            </div>
                              

                              <div class="row mt-5" style="margin-left: 10px;">
                                <h6 style="text-align: left;">이름 <span style="float: right; color: gray;">${myPage.userDto.user_name}</span></h6>
                             </div>
                       		  <div class="row mt-5" style="margin-left: 10px;">
                                <h6 style="text-align: left;">성별 <span style="float: right; color: gray;">${myPage.userDto.gender}</span></h6>
                             </div>
                             <div class="row mt-5" style="margin-left: 10px;">
                                <h6 style="text-align: left;">생년월일 <span style="float: right; color: gray;"> <fmt:formatDate value="${myPage.userDto.birth}" pattern="yy.MM.dd"/></span></h6>
                             </div>
                             <div class="row mt-5" style="margin-left: 10px;">
                                <h6 style="text-align: left;">이메일 <span style="float: right; color: gray;">${myPage.userDto.email}</span></h6>
                             </div>    
                             <div class="row mt-5" style="margin-left: 10px;">
                                <h6 style="text-align: left;">연락처 <span style="float: right; color: gray; ">${myPage.userDto.phone_number}</span></h6>
                             </div>     
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