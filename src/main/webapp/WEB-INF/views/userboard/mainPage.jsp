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
<title>MainPage</title>

<script>
	let mySessionId = null;
		function getSession() {
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
		      if(response.result == "success") {
		         mySessionId = response.userid;
		      }         
		   }
		}
		
		xhr.open("get", "./getUserId");
		xhr.send();      
	}

	/* 동행 */
	
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
	 		xhr.open("get", "../post/getStatusList?post_id=" + post_id);
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
	
	
	
	
	
	
	/* 동행 */



	/* 숙소예약 */
	
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
	
	 
	let categoryValue = '전체';
	let starValue = 0;   
	let checkedValues = []; 
	let orderByNumber = 1;
	
	let searchLoc = '';
	let searchStart = startDay;
	let searchEnd = endDay;
	let searchPeople = 2;
	
	var weekDays = [current.getDay()];
	
	function getHotelListByStar(){
		   const xhr = new XMLHttpRequest();
		   const hotelBox = document.getElementById("hotelBox");
		   
		   hotelBox.innerHTML ="";

		      
		   
		      
		   xhr.onreadystatechange = function(){
		      if(xhr.readyState == 4 && xhr.status == 200){
		         const response = JSON.parse(xhr.responseText);
		         if(response.result == "success"){
		            for(list of response.list){
		             
		       const action = document.createElement("a");
		        action.classList.add("hotelForEach", "mt-2")       
		       action.href = "./hotelInfoPage?id="+list.hotelDto.id+"&startDate="+searchStart+"&endDate="+searchEnd+"&people="+searchPeople+"&days="+weekDays;
				action.style.textDecoration = "none";
				action.style.width = "294px";
				
		   		hotelBox.appendChild(action)



		       const col1 = document.createElement("div");
		           col1.classList.add("col","shadow");
		           col1.style.width = "294px";
		           col1.style.height = "370px";
		           col1.style.borderRadius = "10px";
		         action.appendChild(col1)
		           const row1 = document.createElement("div");
		           row1.classList.add("row");
		           row1.style.width = "100%";
		           
		           col1.appendChild(row1);

		           const col2 = document.createElement("div");
		           col2.classList.add("col","p-0");
		           
		           row1.appendChild(col2);
		           const img = document.createElement("img");
		           img.src ="/uploadFiles/" + list.hotelDto.hotel_img;
		           img.style.width = "100%";
		           img.style.height = "200px";
		           img.style.borderRadius = "10px";
		           col2.appendChild(img);
		         
		           const row2= document.createElement("div");
		           row1.classList.add("row", "m-0");
		           col1.appendChild(row2);

		           const col3 =document.createElement("div");
		           col3.classList.add("col");
		           row2.appendChild(col3);

		           const namerow = document.createElement("div")
		           col3.appendChild(namerow);

		           const namecol = document.createElement("div");
		           namecol.classList.add("col", "fw-semibold", "mt-3");
		           namecol.style.paddingLeft = "14px"
		           namerow.appendChild(namecol);
		           namecol.style.fontSize = "18px"
		           namecol.innerText = list.hotelDto.hotel_name;

		           const locrow = document.createElement("div")
		           col3.appendChild(locrow);

		           const loccol = document.createElement("div");
		           loccol.classList.add("col","fw-semibold","text-secondary");
		           locrow.appendChild(loccol);
		           loccol.style.fontSize = "12px"
		           loccol.style.paddingLeft = "14px"
		           loccol.innerText = list.hotelDto.hotel_loc.substring(0, 2) +"·"+list.category.category;

		            const badgeRow = document.createElement("div")
		           col3.appendChild(badgeRow);

		           const badgecol = document.createElement("div");
		           badgecol.classList.add("col","pt-1");
		           badgecol.style.paddingLeft = "14px"
		           badgeRow.appendChild(badgecol);
		          
		           const badge1 = document.createElement("span");
		           badge1.classList.add("badge","text-white");
		           
		           badge1.style.backgroundColor ="rgb(84, 189, 84)";
		           badge1.innerText = "무료취소";
		           badgecol.appendChild(badge1);

		           if(list.oriPrice > list.changePrice){
		               const badge3 = document.createElement("span");
		               badge3.classList.add("badge","text-bg-danger","ms-2");
		               badge3.innerText = "초특가";
		               badgecol.appendChild(badge3)
		               }
		            /*  */
		            const saleRow = document.createElement("div");
		            col3.appendChild(saleRow);

		            const saleCol = document.createElement("div");
		            saleCol.classList.add("col","text-end");
		            saleRow.appendChild(saleCol);

		            const salePrice = document.createElement("p");
		                  salePrice.classList.add("text-decoration-line-through","opacity-50","mb-0","text-black", "mt-3");
		                  salePrice.style.paddingRight = "14px"
		                  salePrice.innerText = list.oriPrice.toLocaleString() +"원";
		                  
		                   if(list.oriPrice <= list.changePrice){
		                      salePrice.classList.add("text-white");
		                   }
		            saleCol.appendChild(salePrice);
		            
		            const priceRow = document.createElement("div");
		            col3.appendChild(priceRow);

		            const priceCol = document.createElement("div");
		            priceCol.classList.add("col","fs-5","fw-semibold","text-end", "ps-0", "pe-0");
		            priceRow.appendChild(priceCol);

		            if(list.oriPrice > list.changePrice){
		                  const salePerSpan = document.createElement("span");            
		                  salePerSpan.classList.add("text-danger")
		                  priceCol.appendChild(salePerSpan);
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
		            	parkSpan.style.paddingRight = "14px";
		               parkSpan.style.fontSize = "15px"
		               priceCol.appendChild(priceSpan);
		               priceCol.appendChild(parkSpan);
		               
		               }
		            }
		      }
		   }
		   xhr.open("get","./getHotelRandomListByStar?category="+categoryValue+"&star="+starValue+"&checkBoxValues="+checkedValues+"&orderByNumber="+orderByNumber+"&startDay="+searchStart+
		         "&endDay="+searchEnd+"&fixed_number="+searchPeople+"&loc="+searchLoc+"&weekDays="+weekDays);
		   xhr.send();
		}
	
	
	
	
	
	/* 숙소예약 */

	/* 쿠폰 */
	function addThousandsSeparator(number) { // 숫자에 콤마붙이는 기능
	  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function itemList(categoryV) { // 상품 리스트
		console.log("catId : " + categoryV)
		const xhr = new XMLHttpRequest();
	
		xhr.onreadystatechange = function () { 
			
						if(xhr.readyState == 4 && xhr.status == 200) { 
								const response = JSON.parse(xhr.responseText);	
								const itemList = document.getElementById("itemList");
								itemList.innerHTML = "";
												
									response.itemList.forEach(function(map){
										const itemId = map.itemDto.id;
										
										const col = document.createElement("div");
										col.classList.add("col-3", "mb-5", "itemForEach", "p-0");
										col.style.width = "294px"
										
										const card = document.createElement("div");
										card.classList.add("h-100");
										card.style.width = "294px"
										
										const link = document.createElement("a");
										link.href = "../userboard/itemDetailPage?id=" + itemId; 
										console.log("아이디 : " + itemId)
										card.addEventListener("click", function() {
										  link.click(); 
										});
	
										card.appendChild(link);
									
										
										const img = document.createElement("img"); // 이미지
										img.classList.add("card-img-top");
										img.src = "/uploadFiles/" + map.itemDto.item_thumbnail;
										img.style.width = "100%";
										img.style.height = "250px";
										img.style.borderRadius = "14px"
										card.appendChild(img);
										
										const cardBody = document.createElement("div");
										cardBody.classList.add("card-body", "p-1", "d-flex", "flex-column", "justify-content-between");
										card.appendChild(cardBody);
										
										const textCenter = document.createElement("div");
										textCenter.classList.add("text-left");
										cardBody.appendChild(textCenter);
										
										const itemName = document.createElement("h5"); // 상품명
										itemName.classList.add("mt-3", "mb-0");
										itemName.innerText = map.itemDto.item_name;
										textCenter.appendChild(itemName);
										
										const itemReviewCount = document.createElement("span"); // 리뷰수
										itemReviewCount.classList.add("text-muted");
										itemReviewCount.innerText = "리뷰 " + map.itemReviewCount;
										itemReviewCount.style.fontSize = "0.8em";
										textCenter.appendChild(itemReviewCount);
	
										const itemBuyCount = document.createElement("span"); // 구매수
										itemBuyCount.classList.add("ms-3", "text-muted");
										itemBuyCount.style.fontSize = "0.8em";									
										itemBuyCount.innerText = "구매 " + map.itemBuyCount; 
										textCenter.appendChild(itemBuyCount);  
										
										const itemLikeCount = document.createElement("span"); // 좋아요수
										itemLikeCount.classList.add("ms-3", "text-muted");
										itemLikeCount.style.fontSize = "0.8em";									
										itemLikeCount.innerText = "좋아요 " + map.itemLikeCount; 
										textCenter.appendChild(itemLikeCount);  
	
										
										const itemPrice = document.createElement("h5"); // 상품가격
										itemPrice.classList.add("fw-semibold", "mt-3", "text-danger");
										itemPrice.innerText = addThousandsSeparator(map.itemDto.item_price);
										textCenter.appendChild(itemPrice);
										
										const span22 = document.createElement("span");
										span22.innerText = "P";
										span22.classList.add("fw-normal", "text-secondary", "ms-0");
										span22.style.fontSize = "0.7em"
										span22.style.marginLeft = "1px";
	
										itemPrice.appendChild(span22);
												
									col.appendChild(card);
									itemList.appendChild(col);
		            			});	        					
			} 
	
		}
		// get 방식
		xhr.open("get", "./getItemRandomList?categoryId=" + categoryV); // controller에있는 그대로
		xhr.send();
	}
	/* 쿠폰 */

window.addEventListener("DOMContentLoaded", function(){
		getSession()
		 /* 쿠폰 */
		 itemList(0);
		 /* 쿠폰 */

		 /* 숙소예약 */
		 getHotelListByStar(0);
		 /* 숙소예약 */
});
</script>
<style>
	.col-main {
		border-left: 1px solid rgba(0, 0, 0, 0.3);	
	}
	.col-top {
		border-top: 1px solid black;
	}
	.col-sub {
		border-left: 1px solid gray;
	}
	.shadow-none {
    	border: none;
    }
 	.card1 {
    	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  	}
  	.bgbg {
  		background-color: rgba(128, 128, 128, 0.1);
  	}
  	
  	 body {
        padding: 0px;
        margin: 0px;
        font-family: 'Roboto', sans-serif;
    }
  	
  	
  	
  	/* 동행 */
  	   
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
  	
  	/* 동행 */
  	
  	/* 커뮤니티 */
  	
	/* .image-wrapper {
	width: 294px;
    height: 294px;
    position: relative;
    display: inline-block;
	}
	
	.image-wrapper img {
	    width: 294px;
	    height: 294px;
	    border-radius: 14px;
	}
	
	.image-wrapper .overlay {
	    position: absolute;
	    top: 0;
	    left: 0;
	    width: 294px;
	    height: 294px;
	    background-color: rgba(0, 0, 0, 0.2);
	    opacity: 1;
	    display: flex;
	    flex-direction: column;
	    justify-content: space-between;
	    align-items: flex-start;
	    padding: 20px;
	    color:white;
	    border-radius: 14px;
	}
	
	.image-wrapper .overlay i {
	    font-size: 24px;
	    order: -1;
	}
	
	.image-wrapper .overlay .feed-title-container {
	    display: flex;
	    flex-direction: column;
	    align-items: flex-start;
	} */
  	
  	.feedForEach {
  	 width: 294px;
     height: 294px;
  	 margin-left: auto;
  	 margin-right: auto;
  	}
  	.feedForEach:nth-child(4n-3) {
        margin-left: 0px;
    }

    .feedForEach:nth-child(4n) {
        margin-right: 0px;
    }
  	
  	/* 커뮤니티 */
  	
  	
  	
  	/* 포인트샵 */
  	.itemForEach {
        /* box-shadow: rgba(25, 25, 25, 0.2) 0px 6px 10px; */
        border-radius: 14px;
        cursor: pointer;
        float: left;
        margin-left: auto;
        margin-right: auto;
    }

    .itemForEach:nth-child(4n-3) {
        margin-left: 0px;
    }

    .itemForEach:nth-child(4n) {
        margin-right: 0px;
    }
    /* 포인트샵 */

    /* 공지사항 */
   /* 마우스 올렸을때 색깔변경 */
   td:hover {
     background-color: rgb(227, 227, 227);
   }
    /* 공지사항 */
    
    /* 호텔 */
    
    
    .hotelForEach {
        /* box-shadow: rgba(25, 25, 25, 0.2) 0px 6px 10px; */
        border-radius: 14px;
        cursor: pointer;
        float: left;
        margin-left: auto;
        margin-right: auto;
        padding: 0;
    }

    .hotelForEach:nth-child(4n-3) {
        margin-left: 0px;
    }

    .hotelForEach:nth-child(4n) {
        margin-right: 0px;
    }
    /* 호텔 */

    
  	
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
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
            	<div class="row  mt-4 mb-4">
            		<div class="col-3 p-0">
            			<img src="../resources/img/mainAdver1.png" style="width: 100%; height: 320px;">
            		</div>
            		
            		<div class="col ms-4 p-0">
            			<img src="../resources/img/mainAdver2.png" style="width: 100%; height: 320px;">
            		</div>
            	</div>
	            <!-- 동행찾기 -->
                <div class="row " style="margin-top: 50px;">
                    <div class="col">
                        <p style="font-size: 22px; display: inline;"><b>동행을 찾고 있어요</b></p>
                        <a style="margin: 0; margin-left: auto; padding-top: 8px; font-size: 16px; display: inline; float: right; color: #008FF6; text-decoration: none;" href="../post/postListPage">동행 더보기<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${postlist}" var="item" >
                     <div class="col-3 mt-2 forEach-area" style="padding-top: 12px; padding-bottom: 12px;">
                                    
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
                                          
                                          <label id="goingLabelContainer${item.postDto.id}" class="pt-1" for="image" style="width: max-content; background-color: white; border-radius: 12px; display: flex; justify-content: center; align-items: center; position: relative; top: 22px; left: -10px; padding-left: 5px; padding-right: 7px; ">
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
                          <a href="../post/postDetailPage?id=${item.postDto.id}" style="text-decoration: none; color: inherit;">
                          <div class="row">
                              <div class="col" style="padding-left: 0px; padding-right: 0px; height: 144px;" onmouseover="statusViewOver(${item.postDto.id});" onmouseout="statusViewOut(${item.postDto.id});">
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
			<!-- 동행찾기 -->
			
			
			<!-- 커뮤니티 -->
                <div class="row" style="margin-top: 50px;">
                    <div class="col mt-4">
                        <p style="font-size: 22px; display: inline;"><b>멤버들의 취향 피드 구경하기</b></p>
                        <a style="margin: 0; margin-left: auto; padding-top: 8px; font-size: 16px; display: inline; float: right; color: #008FF6; text-decoration: none;" href="../facebook/facebookMain">커뮤니티 더보기<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
                
                <div class="row mt-2">
   
					<c:forEach  var="map" items="${feedlist}" >
					  <div class="col-3 feedForEach p-0" style="position: relative;">
					  	<img src="/uploadFiles/${map.feedImageDto.feed_image}" alt="Feed Image" style="width: 100%; height: 100%; border-radius: 14px;"/>
					  	<i class="bi bi-heart fs-5" style="position: absolute; top: 10px; left: 10px; color: white;"><b>&nbsp;${map.count}</b></i>
					  	<p style="position: absolute; bottom: 20px; left: 10px; color: white;"><b>${map.feedDto.feed_title}</b></p>
					  	<input type="hidden" name="id" value="${map.feedDto.id}">
					  </div>
					</c:forEach>
				</div>
						
				<!-- 커뮤니티 -->
				
				
				<!-- 숙소예약 -->
                <div class="row" style="margin-top: 50px;">
                    <div class="col mt-4">
                        <p style="font-size: 22px; display: inline;"><b>나에게 딱 맞는 숙소찾기</b></p>
                        <a style="margin: 0; margin-left: auto; padding-top: 8px; font-size: 16px; display: inline; float: right; color: #008FF6; text-decoration: none;" href="../userboard/hotelPage">숙소예약 더보기<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
                <div class="row" id="hotelBox">
                   
                </div>
                <!-- 숙소예약 -->
                
                
				<!-- 포인트샵 -->                
                <div class="row" style="margin-top: 50px;">
                    <div class="col mt-4">
                        <p style="font-size: 22px; display: inline;"><b>사다 사 포인트샵</b></p>
                        <a style="margin: 0; margin-left: auto; padding-top: 8px; font-size: 16px; display: inline; float: right; color: #008FF6; text-decoration: none;" href="../userboard/itemListPage">포인트샵 더보기<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
                <div class="row mt-2" id="itemList"></div>
				<!-- 숙소예약 -->
				
				
				<!-- 짐서비스 -->
                <div class="row" style="margin-top: 50px;">
                    <div class="col">
                        <p style="font-size: 22px;"><b>짐서비스</b></p>
                    </div>
                </div>
                <div class="row">
                    <div class="col" style="width: 254px;">
                        <div class="row py-4" style="border-radius: 10px; ">
                            <div class="col">
                               <div class="row">
                                  <div class="col">
                                  
                                     <div class="row fs-2 fw-semibold text-center">
                                        <div class="col">여행가방 걱정 끝</div>
                                     </div>   
                                     <div class="row mt-3 fs-6 text-center">
                                        <div class="col">여행할때, 집에서 숙소까지 캐리어를 운송해드립니다.</div>
                                     </div>
                                     <div class="row mt-2 fs-6 text-center">
                                        <div class="col">무거운 캐리어는 맡기고 진정한 자유여행을 즐겨보세요!</div>
                                     </div>
                                  </div>
                               </div>
                               <div class="row mt-5"> 
                                  <div class="col-4 text-center">
                                  	<a href="../userzim/zimSignFirstPage" style="text-decoration: none; color: inherit;"  >
                                     <div class="row mx-2 fs-1">
                                        <div class="col"><i class="bi bi-pc-display-horizontal"></i></div>
                                     </div>
                                     <div class="row mt-2 mx-2 fs-4">
                                        <div class="col">STEP <span style="color : #50bcdf">01</span></div>
                                     </div>
                                     <div class="row mt-4 mx-2 fs-6"> 
                                        <div class="col">홈페이지를 통해</div>
                                     </div>
                                     <div class="row mx-2 fs-5 fw-semibold">
                                        <div class="col">간단하게 예약하세요!</div>
                                     </div>
                                     </a>
                                  </div>
                                  
                                  <div class="col-4 text-center border-start border-end border-info-subtle">
                                  	<a href="../userzim/zimSignFirstPage" style="text-decoration: none; color: inherit;"  >
                                     <div class="row mx-2 fs-1">
                                        <div class="col"><i class="bi bi-calendar-check"></i></div>
                                     </div>
                                     <div class="row mt-2 mx-2 fs-4">
                                        <div class="col">STEP <span style="color : #50bcdf">02</span></div>
                                     </div>
                                     <div class="row mt-4 mx-2 fs-6">
                                        <div class="col">원하는 시간, 장소에서</div>
                                     </div>
                                     <div class="row mx-2 fs-5 fw-semibold">
                                        <div class="col">맡기세요!</div>
                                     </div>
                                     </a>
                                  </div>
                                  
                                  <div class="col-4 text-center">
                                  <a href="../userzim/zimSignFirstPage" style="text-decoration: none; color: inherit;"  >
                                     <div class="row mx-2 fs-1">
                                        <div class="col"><i class="bi bi-bag-check"></i></div>
                                     </div>
                                     <div class="row mt-2 mx-2 fs-4">
                                        <div class="col">STEP <span style="color : #50bcdf">03</span></div>
                                     </div>
                                     <div class="row mt-4 mx-2 fs-6">
                                        <div class="col">원하는 시간, 장소에서</div>
                                     </div>
                                     <div class="row mx-2 fs-5 fw-semibold">
                                        <div class="col">찾으세요!</div>
                                     </div>
                                     </a>
                                  </div>
                               </div>
                               
                            </div>
                         </div>
                    </div>
                </div>
				<!-- 짐서비스 -->
				
				
				
				<!-- 주요혜택 -->
                <div class="row" style="margin-top: 80px;">
                    <div class="col">
                        <p style="font-size: 22px; margin-bottom: 0"><b>주요혜택</b></p>
                    </div>
                </div>
                <!-- 마진 제거 -->
                <div class="row mt-2" > 
                    <div class="col me-2" style="width: 254px; height: 340px; background-color: rgb(245, 245, 245); justify-content: center; display: flex; position: relative; border-radius: 10px;">
                        <div style="position: relative; background-color: white; width: 200px; height: 200px; border-radius: 50%; top: 40px; text-align: center; display: flex; align-items: center; justify-content: center;">
                            <img src="../resources/img/icon-customer.png" alt="" style="width: 60px; height: 60px;">
                        </div>
                        <div>
                            <p style="position: absolute; right: 50%; transform: translateX(50%); top: 82%; font-size: 20px;">서비스 혜택</p>
                        </div>
                    </div>

                    <div class="col ms-2 me-2" style="width: 254px; height: 340px; background-color: rgb(245, 245, 245); justify-content: center; display: flex; position: relative; border-radius: 10px;">
                        <div style="position: relative; background-color: white; width: 200px; height: 200px; border-radius: 50%; top: 40px; text-align: center; display: flex; align-items: center; justify-content: center;">
                            <img src="../resources/img/icon_credit_card.png" alt="" style="width: 60px; height: 60px;">
                        </div>
                        <div>
                            <p style="position: absolute; right: 50%; transform: translateX(50%); top: 82%; font-size: 20px;">무이자할부 안내</p>
                        </div>
                    </div>

                    <div class="col ms-2 me-2" style="width: 254px; height: 340px; background-color: rgb(245, 245, 245); justify-content: center; display: flex; position: relative; border-radius: 10px;">
                        <div style="position: relative; background-color: white; width: 200px; height: 200px; border-radius: 50%; top: 40px; text-align: center; display: flex; align-items: center; justify-content: center;">
                            <i class="bi bi-gift-fill" style="font-size: 45px;"></i>
                        </div>
                        <div>
                            <p style="position: absolute; right: 50%; transform: translateX(50%); top: 82%; font-size: 20px;">나의 혜택</p>
                        </div>
                    </div>

                    <div class="col  ms-2" style="width: 254px; height: 340px; background-color: rgb(245, 245, 245); justify-content: center; display: flex; position: relative; border-radius: 10px;">
                        <div style="position: relative; background-color: white; width: 200px; height: 200px; border-radius: 50%; top: 40px; text-align: center; display: flex; align-items: center; justify-content: center;">
                            <img src="../resources/img/icon_coupon.png" alt="" style="width: 60px; height: 60px;">
                        </div>
                        <div>
                            <p style="position: absolute; right: 50%; transform: translateX(50%); top: 82%; font-size: 20px;">쿠폰 다운로드</p>
                        </div>
                    </div>
                </div>
                
                
                <!-- 공지사항/ 자주하는 질문 -->
                <div class="row mb-3" >
                    <div class="col-6">
                       <div class="row py-3 border-bottom border-dark fs-5 fw-semibold text-start me-1">
                          <div class="col-11" style="margin-top: 50px;">
                             <a href="../usercsboard/csNoticePage" class="link-dark link-offset-2" style="text-decoration: none;">공지사항 <i class="bi bi-chevron-right"></i></a>
                          </div>
                       </div>
     
                       <c:forEach items="${csNoticeList}" var="csNotice">
                          <div class="row mt-1 py-2 border-bottom fs-6">
                             <div class="col-10">
                                <a class="link-dark link-offset-2 link-underline" style="text-decoration: none;" href="../usercsboard/readCsNoticePage?id=${csNotice.id}">
                                   ${csNotice.notice_title}
                                </a>
                             </div>
                             <div class="col-2 text-secondary"><fmt:formatDate value="${csNotice.reg_date}" pattern="yyyy.MM.dd"></fmt:formatDate></div>
                          </div>
                       </c:forEach>
                    </div>
     
                    <div class="col-6" style="margin-top: 50px;">
                       <div class="row py-3 fs-5 fw-semibold text-center">
                          <div class="col">
                             <a href="../usercsboard/faqPage" class="link-dark link-offset-2" style="text-decoration: none;">자주하는 질문 <i class="bi bi-chevron-right"></i></a>
                          </div>
                       </div>
                       <div class="row text-center">
                          <div class="col-2"></div>
                          <div class="col">
                             <div class="table-responsive">
                                <table class="table table-bordered">
                                   <tbody class="text-center">
                                      <tr>
                                         <td class="p-3" style="hover: background-color:gray;">
                                            <a href="../usercsboard/faqPage" class="link-dark link-offset-2" style="text-decoration: none;">동행찾기</a>
                                         </td>
                                         <td class="p-3">
                                            <a href="../usercsboard/faqPage" class="link-dark link-offset-2" style="text-decoration: none;">커뮤니티</a>
                                         </td>
                                      </tr>
                                      <tr>
                                         <td class="p-3">
                                            <a href="../usercsboard/faqPage" class="link-dark link-offset-2" style="text-decoration: none;">숙소예약</a>
                                         </td>
                                         <td class="p-3">
                                            <a href="../usercsboard/faqPage" class="link-dark link-offset-2" style="text-decoration: none;">포인트샵</a>
                                         </td>
                                      </tr>
                                      <tr>
                                         <td class="p-3">
                                            <a href="../usercsboard/faqPage" class="link-dark link-offset-2" style="text-decoration: none;">짐서비스</a>
                                         </td>
                                         <td class="p-3">
                                            <a href="../usercsboard/faqPage" class="link-dark link-offset-2" style="text-decoration: none;">회원</a>
                                         </td>
                                      </tr>
                                   </tbody>
                                </table>
                             </div>
                          </div>
                          <div class="col-2"></div>
                       </div>
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
	
	
	
	
<jsp:include page="../common/footer.jsp"></jsp:include>	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>