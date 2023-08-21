<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
 <script>
 const postId = new URLSearchParams(location.search).get("id");
 const selectCategory = new URLSearchParams(location.search).get("category");
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
 		
 		
 
 
 		let mySessionId = null;
 		function getSession() {
 		   const xhr = new XMLHttpRequest();
 		   xhr.onreadystatechange = function () {
 		      if(xhr.readyState == 4 && xhr.status == 200) {
 		         const response = JSON.parse(xhr.responseText);
 		      if(response.result == "success") {
 		         mySessionId = response.id;
 		      }         
 		   }
 		}
 		
 		xhr.open("get", "./getMyId");
 		xhr.send();      
 	}
 		
 		function statusViewOver(post_id) {
 			const goingLabelContainer = document.getElementById("goingLabelContainer" + post_id);
 			goingLabelContainer.style.backgroundColor = "rgb(0, 143, 246)";
 			const goingIContainer = document.getElementById("goingIContainer" + post_id);
 			goingIContainer.style.color = "white";
 			const goingSpanContainer = document.getElementById("goingSpanContainer" + post_id);
 			goingSpanContainer.style.color = "white";
 			
 			const imgUpContentBox = document.getElementById("imgUpContentBox" + post_id);
 			const statusBox = document.getElementById("statusBox" + post_id);
 			statusBox.innerHTML = "";
 			const viewBox = document.getElementById("viewBox" + post_id);
 			viewBox.innerHTML = "";
 			const chatBox = document.getElementById("chatBox" + post_id);
 			chatBox.innerHTML = "";
 			const heartBox = document.getElementById("heartBox" + post_id);
 			heartBox.innerHTML = "";
 			const xhr = new XMLHttpRequest();
  			xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					const hit = response.postDto.hit;
					const likeCount = response.like_total;
					console.log("좋아요 개수 : " + likeCount)
					const person_count = response.postDto.person_count;
					const startDate = response.postDto.day_start;
					const endDate = response.postDto.day_end;
					const nDate = response.nowDate;
					
					const inputDate = new Date(startDate);
						 var monthNames = [
						     "01", "02", "03", "04", "05", "06",
						     "07", "08", "09", "10", "11", "12"
						   ];
						var syear = inputDate.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
						var smonth = monthNames[inputDate.getMonth()]; // 월
						var sday = inputDate.getDate().toString().padStart(2, '0'); // 일
						var sDate = syear + "." + smonth + "." + sday;
					
						const inputDate2 = new Date(endDate);
						var eyear = inputDate2.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
						var emonth = monthNames[inputDate2.getMonth()]; // 월
						var eday = inputDate2.getDate().toString().padStart(2, '0'); // 일
						var eDate = eyear + "." + emonth + "." + eday;	
					
					const comment_total = response.comment_total;
					const joinCount = response.joinCount;
					
					if(comment_total == null) {
						chatBox.innerText = 0;	
					}else {
						chatBox.innerText = comment_total;
					}
					
					if(likeCount == null) {
						heartBox.innerText = 0;
					}else {
						heartBox.innerText = likeCount;	
					}
					
					/* 시작 현재 */
					viewBox.innerText = hit;
					
  		       	if(person_count > joinCount && sDate > nDate) {
  		       	statusBox.innerText = "모집중 · " + (person_count - joinCount) + "명"
  		      
  		       	}else if(person_count == joinCount && sDate > nDate) {
  		       		statusBox.innerText = "모집완료";
  		      
  		      
  		       	}else if(sDate <= nDate && nDate <= eDate) {
		       		statusBox.innerText = "여행중";
  		       	}else {
  		       	statusBox.innerText = "여행완료";	
  		       	} 
  		      	
  		        if(imgUpContentBox.style.visibility === "hidden") {
  		    		imgUpContentBox.style.visibility = "visible";
  		       	}
  		         
  		    	}
  	 		}
  	 		xhr.open("get", "./getStatusList?post_id=" + post_id);
  	 		xhr.send();      
  	 	}
 		
 		function statusViewOut(post_id) {
 			const goingLabelContainer = document.getElementById("goingLabelContainer" + post_id);
 			goingLabelContainer.style.backgroundColor = "white";
 			const goingIContainer = document.getElementById("goingIContainer" + post_id);
 			goingIContainer.style.color = "#00A3FF";
 			const goingSpanContainer = document.getElementById("goingSpanContainer" + post_id);
 			goingSpanContainer.style.color = "#008FF6";
 			const zoom_img = document.getElementById("zoom_img" + post_id);
 			 
 			
 			const imgUpContentBox = document.getElementById("imgUpContentBox" + post_id);
 			if(imgUpContentBox.style.visibility === "visible") {
		    		imgUpContentBox.style.visibility = "hidden";
		    }
 		}
 
 		function topButtonColor(num) {
 			const one = document.getElementById("one")
 			const two = document.getElementById("two")
 			const three = document.getElementById("three")
 			
 			if(selectCategory === "최신 순") {
 				one.classList.remove("topBtnColorUnclick");
 				one.classList.add("topBtnColorOnclick");
 				two.classList.remove("topBtnColorOnclick");
 				two.classList.add("topBtnColorUnclick");
 				three.classList.remove("topBtnColorOnclick");
 				three.classList.add("topBtnColorUnclick");
 			}else if(selectCategory === "인기 순") {
 				two.classList.remove("topBtnColorUnclick");
 				two.classList.add("topBtnColorOnclick");
 				one.classList.remove("topBtnColorOnclick");
 				one.classList.add("topBtnColorUnclick");
 				three.classList.remove("topBtnColorOnclick");
 				three.classList.add("topBtnColorUnclick");
 			}else if(selectCategory === "댓글 순") {
 				three.classList.remove("topBtnColorUnclick");
 				three.classList.add("topBtnColorOnclick");
 				one.classList.remove("topBtnColorOnclick");
 				one.classList.add("topBtnColorUnclick");
 				two.classList.remove("topBtnColorOnclick");
 				two.classList.add("topBtnColorUnclick");
 			}
 			
 			
 		}
 
 
 
 
window.addEventListener("DOMContentLoaded", function(){
   getSession();
   topButtonColor(selectCategory)

   
   
});

 
 
 </script>
 
 
 <style>
	 body {
	     padding: 0px;
	     margin: 0px;
	     font-family: 'Roboto', sans-serif;
	 }
	
	 .forEach-area {
    width: 294px;
    height: 315px;
    box-shadow: rgba(25, 25, 25, 0.2) 0px 6px 10px;
    border-radius: 14px;
    cursor: pointer;
    float: left;
    margin-left: auto;
    margin-right: auto;
	}
	
	.forEach-area:nth-child(4n-3) {
	    margin-left: 0px;
	    
	    
	}
	
	.forEach-area:nth-child(4n) {
	    
	    margin-right: 0px;
	    
	}
	
	.topBtnColorOnclick {
		background-color: rgb(37, 37, 37);
		color: white;
		border-radius: 10px;
		padding: 5px 10px;
	}
	.topBtnColorUnclick {
		background-color: rgb(248, 248, 248);;
		color: black;
		border-radius: 10px;
		padding: 5px 10px;	
		border: none;	
	}
	
	#partySerach:hover {
		background-color: rgb(37, 37, 37);
		color: white;
		border-radius: 10px;
		padding: 5px 10px;
	}

 </style>
 <script>
 
 </script>
<title>Insert title here</title>
</head>
<body>
 
 	<div class="container-fluid">
		<div class="row">
			<div class="col">
				<jsp:include page="../common/topNavi.jsp"></jsp:include>
			</div>
		</div>
	</div>
 
    <div class="container-fluid mt-3">
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                
                
                <form action="./postListPage" method="get">
                <div class="row">
                    <div class="col p-0">
                        <label for="" style="position: relative; ">
                            <svg width="16" height="16" viewBox="0 0 16 17" fill="none" xmlns="http://www.w3.org/2000/svg" style="position: absolute; top: 15px; left: 15px;"><path d="M7.45301 14.7689C11.0169 14.7689 13.906 11.7023 13.906 7.91942C13.906 4.13656 11.0169 1.06995 7.45301 1.06995C3.88911 1.06995 1 4.13656 1 7.91942C1 11.7023 3.88911 14.7689 7.45301 14.7689Z" stroke="#9A9A9A" stroke-miterlimit="10"></path><path d="M12.1982 12.9564L14.9999 15.9301" stroke="#9A9A9A" stroke-miterlimit="10" stroke-linecap="round"></path></svg>
                            <input type="text" name="searchValue" class="form-control" style="width: 294px; height: 44px; font-size: 14px;  border-radius: 14px; background-color: #f8f8f8; padding-left: 40px;" placeholder="어디로 여행가시나요?">
                        </label>
                        <input class="topBtnColorOnclick" name="category" type="submit" value="최신 순" style="margin-left: 80px;" id="one" onclick="topButtonColor(1);">
                        <input class="topBtnColorUnclick" name="category" type="submit" value="인기 순" style="margin-left: 20px;" id="two" onclick="topButtonColor(2);">
                        <input class="topBtnColorUnclick" name="category" type="submit" value="댓글 순" style="margin-left: 20px;" id="three" onclick="topButtonColor(3);">
                        <c:if test="${!empty sessionUser}">
                        	<a id="partySerach" class="topBtnColorUnclick " style="float: right; text-decoration: none; padding-top: 7px; padding-bottom: 7px; display: flex; justify-content: center; align-items: center; margin-top: 3px;" href="../post/registerPage">동행찾기</a>	
                        </c:if>
                    </div>
                </div>
                </form>
                
	                
               			<div class="row">
               				<c:forEach items="${list }" var="item" >
                                <div class="col-3 mt-4 forEach-area" style="padding-top: 12px; padding-bottom: 12px;">
                                    
                                    <div class="row" style="height: 52px; font-size: 14px;">
                                        <div class="col">
                                            <div class="row" style="display: flex; justify-content: center;"  onclick="profileModal(${item.userDto.id});">
                                                <div class="col-2">
                                                	<c:choose>
                                                		<c:when test="${item.userDto.profile_img.startsWith('http')}">
                                                			<img src="${item.userDto.profile_img}" alt="image" style="width: 40px; height: 40px; border-radius: 50%;">
                                                		</c:when>
                                                		<c:otherwise>
                                                			<img src="/uploadFiles/${item.userDto.profile_img}" alt="image" style="width: 40px; height: 40px; border-radius: 50%;">		
                                                		</c:otherwise>
                                                	</c:choose>
                                                    
                                                    <label id="goingLabelContainer${item.postDto.id}" for="image" style="width: max-content; background-color: white; border-radius: 12px; display: flex; justify-content: center; align-items: center; position: relative; top: 22px; left: -10px; padding-left: 5px; padding-right: 7px;">
                                                        <i id="goingIContainer${item.postDto.id}" class="bi bi-geo-alt-fill me-1" style="color: #00A3FF; font-size: 20px; "></i>
                                                        <span id="goingSpanContainer${item.postDto.id}" style="font-size: 15px; color:#008FF6">${item.postDto.going}</span>
                                                    </label>
                                                
                                                </div>
                                                <div class="col-9">
                                                    <div class="row">
                                                        <div class="col" style="padding-left: 35px; padding-right: 0px;">
                                                            <span class="m-0">${item.userDto.user_name}</span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col" style="padding-left: 35px;  padding-right: 0px; color: #008FF6;">
                                                            <span>${item.birthday} ·</span> 
                                                          	<c:choose>
                                                          		<c:when test="${item.userDto.gender  == 'M'}">
                                                          			<span>남자</span>		
                                                          		</c:when>
                                                          		<c:otherwise>
                                                          			<span>여자</span>
                                                          		</c:otherwise>
                                                          	</c:choose>
                                                            
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <div >
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="row">
                                                <div class="col" style="color: #9A9A9A;">
                                                    <i class="bi bi-briefcase-fill me-1"></i>
                                                    <span>여행기간</span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col" style="color: #00CE7C; padding-left: 10px;">
                                                    <span>${item.days}일 ·</span>
                                                    
                                                    <fmt:formatDate value="${item.postDto.day_start}" pattern="MM/dd" var="formatStart"/>
					                    			<fmt:formatDate value="${item.postDto.day_end}" pattern="MM/dd" var="formatEnd"/>
                                                    <span>${formatStart} - ${formatEnd}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <a href="./postDetailPage?id=${item.postDto.id}" style="text-decoration: none; color: inherit;">
                                    <div class="row">
                                        <div class="col" style="padding-left: 0px; padding-right: 0px; height: 144px; overflow: hidden;" onmouseover="statusViewOver(${item.postDto.id});" onmouseout="statusViewOut(${item.postDto.id});">
                                            <img src="/uploadFiles/${item.postImageDto[0].post_image}" alt="" style="width: 100%; height: 144px; border-radius: 14px; ">
                                            <div id="imgUpContentBox${item.postDto.id}" class="d-flex justify-content-between px-2" style="background-color: rgba(25, 25, 25, 0.7); position: relative; bottom: 25px; width: 100%; height: 25px; border-radius: 0 0 14px 14px; visibility: hidden;">
                                            	<span id="statusBox${item.postDto.id}" style="color: white;">모집중 · 3명</span>
                                           		 <p style="color: white;">
                                           		<label style="color: white;">
                                            		<i class="bi bi-eye-fill"></i>
                                            		<span id="viewBox${item.postDto.id}">100</span>
                                            	</label>
                                           		<label style="color: white;">
                                            		<i class="bi bi-chat-dots-fill"></i>
                                            		<span id="chatBox${item.postDto.id}">1</span>
                                            	</label>
                                           		<label style="color: white;">
                                            		<i class="bi bi-heart-fill"></i>
                                            		<span id="heartBox${item.postDto.id}">22</span>
                                            	</label>
                                            	</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col" style="padding-left: 7px; padding-right: 7px;">
											<p style="margin: 0px; font-size: 18px;">${item.postDto.title}</p>
											<p style="margin: 0px; word-wrap: break-word">${item.postDto.content}</p>
                                        </div>
                                    </div>
                                    </a>
                                </div>
                        	</c:forEach>    
                        </div>

						<div class="row mt-5">
							<div class="col">
								<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center">
										<c:choose>
											<c:when test="${startPage <= 1}">
												<li class="page-item disabled"><a class="page-link" href="./postListPage?page=${startPage-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>		
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="./postListPage?page=${startPage-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
											</c:otherwise>
										</c:choose>
										
										<c:forEach begin="${startPage}" end="${endPage}" var="index">
											<c:choose>
												<c:when test="${index == currentPage}">
													<li class="page-item"><a class="page-link active" href="./postListPage?page=${index}">${index}</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item"><a class="page-link" href="./postListPage?page=${index}">${index}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<c:choose>
											<c:when test="${endPage >= totalPage}">
												<li class="page-item disabled"><a class="page-link" href="./postListPage?page=${endPage+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>		
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="./postListPage?page=${endPage+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
											</c:otherwise>
										</c:choose>
									</ul>
								</nav>	
							</div>
						</div>
						











			</div>
            <div class="col-2"></div>
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





<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>