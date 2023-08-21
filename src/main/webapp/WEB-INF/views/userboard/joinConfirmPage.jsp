<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>마이 페이지</title>
<script>
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
</script>
<style>
body {
    font-family: 'Roboto', sans-serif;
}

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
        max-width: 100%;
        max-height: 100%;
    	}
        
        .card-body {
            text-align: center;
        }

</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>
	  <div class="container-fluid">
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
                            <img src="/uploadFiles/${myPage.userDto.profile_img}" class="card-img-top" onclick="profileModal(${myPage.userDto.id});">
                           </div>
                           <div class="card-body">
                             <p class="card-text">${myPage.userDto.user_name}</p>
                           <a href="./myPage?id=${sessionUser.id}" style="text-decoration: none;">
							 <span class="card-text"><i class="bi bi-house"></i></span>
						   </a>
                           </div>
                         </div>
                         <div class="card" style="width: 14rem; margin-top: 20px;">
                           <div class="card-point">
                              <p class="card-text" style="font-size: 14px; margin-top: 10px; margin-left: 10px;">내 포인트 : <span style="float: right; color: #0078ff; margin-right: 10px;">${myPage.myPoint} P</span></p>
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
                           <a href="./joinConfirmPage" style="text-decoration: none;"><p style="font-size: 15px; color: #0078ff;">동행 신청 목록</p></a>
                           <a href="./pastPartyListPage" style="text-decoration: none;"><p style="font-size: 15px; color: gray;">지난 동행</p></a>
                        </div> 
                        <div class="row mt-4">
                           <h5>숙소</h5>
                           <p style="font-size: 15px; color: gray;">현재 예약 내역</p>
                           <p style="font-size: 15px; color: gray;">지난 예역 내역</p>
                           <p style="font-size: 15px; color: gray;">내가 찜한 숙소</p>
                        </div>
                        <div class="row mt-4">
                           <h5>커뮤니티</h5>
                           <p style="font-size: 15px; color: gray;">피드 & 릴스</p>
                        </div>
                        <div class="row mt-4">
                           <h5>짐 서비스</h5>
                           <p style="font-size: 15px; color: gray;">배송 상태 조회</p>
                        </div>
                        <div class="row mt-4">
                           <h5>고객센터</h5>
                           <p style="font-size: 15px; color: gray;">1:1 문의내역</p>
                        </div>
                         
                     </div>                         
                     <div class="col-9">
                  <div class="row card-context"> 
                     <div class="card" style="width: 100rem; height: 68rem;">
						<div class="row mt-3">
                                <div class="col text-center">
                                    <h4>동행 신청 목록</h4>
                                </div>
                            </div>
							
							<c:forEach items="${list}" var="item">
                            <div class="for">
                                <div class="row mt-3">
                                    <div class="col" style="padding-left: 25px;">
                                    	<fmt:formatDate value="${item.joinConfirmDto.reg_date}" pattern="yy.MM.dd HH:mm" var="Date"/>
                                        <span style="color: gray; font-size: 15px;">${Date}</span>
                                    </div>
                                </div>
                                <div class="row mt-1 mb-3" style="padding-left: 25px; padding-right: 100px;">
                                    <div class="col border" style="height: 210px; border-radius: 7px;">
                                        <div class="row mt-3">
                                            <div class="col-4" style="padding-left: 16px; ">
                                                <div class="border text-center" style="width: 70px; border-radius: 7px; font-size: 14px;">대기중</div>
                                            </div>
                                            <div class="col-6">
                                                <a style="display: flex; justify-content: end; font-size: 14px; text-decoration: none; " href="../post/postDetailPage?id=${item.joinConfirmDto.post_id}">동행 상세 보기 ></a>
                                            </div>
                                            <div class="col-2"></div>
                                        </div>
                                        <div class="row mt-2" >
                                            <div class="col-4 p-0 ps-3 pt-2">
                                                <img src="/uploadFiles/${item.joinConfirmDto.confirm_image}" alt="" style="width: 240px; height: 135px; border-radius: 7px;">
                                            </div>
                                            <div class="col-6" >
                                                <div class="row" style="margin-top: 7px;">
                                                    <div class="col-1 p-0">
                                                        <img src="/uploadFiles/${item.userDto.profile_img}" alt="image" style="width: 40px; height: 40px; border-radius: 50%;" onclick="profileModal(${item.userDto.id});">
                                                    </div>
                                                    <div class="col" style="display: flex; align-items: center;">
                                                    	<span class="ms-1" >${item.userDto.user_name}</span>
                                                    </div>
                                                </div>
                                                <div class="row mt-1">
                                                    <div class="col p-0">
                                                        <p style="margin: 0 5px; font-size: 16px;">${item.joinConfirmDto.welcome_ment}</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-2 text-end mt-2">
                                                <div class="row mt-2">
                                                    <div class="col d-grid ps-4">
                                                        <a class="btn btn-outline-primary" href="../post/updateJoinConfirmProcess?id=${item.joinConfirmDto.id}&post_id=${item.joinConfirmDto.post_id}&user_id=${item.joinConfirmDto.user_id}&status=y">수락</a>
                                                    </div>
                                                </div>
                                                <div class="row mt-2">
                                                    <div class="col d-grid ps-4">
                                                        <a class="btn btn-outline-danger" href="../post/updateJoinConfirmProcess?id=${item.joinConfirmDto.id}&post_id=${item.joinConfirmDto.post_id}&user_id=${item.joinConfirmDto.user_id}&status=n">거절</a>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                            
                     </div>
                     </div>
                  </div>
               </div>
                  </div>
               </div>
               
		<!-- 프로필 모달 -->
		<div class="modal fade" id="profileModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" style="width: 400px; height: 500px;">
					<div class="modal-header" style="height: 30px;">
						<h1 class="modal-title fs-5 content-center" id="exampleModalLabel">프로필</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" style="overflow-y: auto; padding: 15px;">
						<div class="row">
							<div class="col-2 p-0 m-0"
								style="margin-left: 10px; justify-content: center;">
								<img id="profileContainer" alt=""
									style="width: 70px; height: 70px; border-radius: 50%; margin-left: 10px;">
							</div>
							<div class="col ms-3" style="margin-top: 11px;">
				                  <p class="m-0 mb-1" style="font-size: 15px;" id="nameContainer">닉네임</p>
				                  <span id="ageBox" style="font-size: 15px; color: #008FF6;">20대 ·</span>
				                  <span id="genderBox" style="font-size: 15px; color: #008FF6;">남자</span>
			                </div>
						</div>
						<div class="row mt-2">
							<div class="col">
								<span>매너온도</span> <i class="bi bi-info-lg"></i>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-12" style="position: relative;">
								<small
									style="position: absolute; left: 30%; bottom: 27px; color: gray;">첫
									온도 36.5</small>
								<div class="text-end mb-1 me-1">
									<b style="color: #36ad37;" id="temperatureContainer">36.5℃</b> <span id="imoBox">😄</span>
								</div>
								<i class="bi bi-caret-down-fill"
									style="position: absolute; left: 35.8%; bottom: 10px;"></i>
								<div class="progress" role="progressbar"
									aria-label="Basic example" aria-valuenow="0" aria-valuemin="0"
									aria-valuemax="100" style="height: 12px;">
									<div id="tempContainer" class="progress-bar"
										style="width: 36.5%; background-color: #36ad37;"></div>
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col border-top border-bottom pt-3 pb-3">
								<span id="countContainer">받은거래 후기 4</span>
							</div>
						</div>
						<div id="forContainer"></div>
						
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