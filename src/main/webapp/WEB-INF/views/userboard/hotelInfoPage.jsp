<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<style>
.body{
    font-family: 'Roboto', sans-serif;
    }
#paymentInfo {
  position: fixed;
  top: 150px;
  right: 0px;
  transition: top 0.3s ease;
}
  
.choiceDay{
	background-color: #5ABEFF;
	border-radius :14px 0px 0px 14px;
	color: white !important;
}
.choiceDay2 {
 border-radius :0px 14px 14px 0px;
  /* 원형 테두리 내부를 투명하게 만듭니다. */
  background-color: #5ABEFF;
  color: white !important;
}
	.custom-text-color {
    color: #58ACFA !important;
  }
  
  .image-hover {
    transition: filter 0.3s;
  }

  .image-hover:hover {
    filter: brightness(75%);
  }
 
.date-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 400px; /* 스크롤 영역의 높이 설정 */
}
.date-container:hover {
  overflow: auto; /* 마우스 호버 시 스크롤 보이기 */
}

/* 수직 스크롤 바 스타일 */
.date-container::-webkit-scrollbar {
  width: 0px;
}

.date-container::-webkit-scrollbar-track {
  background-color: #white;
}

.date-container::-webkit-scrollbar-thumb {
  background-color: #white;
  border-radius: 0px;
}

.date-container::-webkit-scrollbar-thumb:hover {
  background-color: #white;
}
.buttonColor {
    background-color: #46B8FF	 !important;
  }
 .review-star{
 color:	#226edf;  !important;
 }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script>
const hotelId = new URLSearchParams(location.search).get("id");    // url에 id= 여기 갖고온다.
/* var dayDifference = new URLSearchParams(location.search).get("dayDifference");
 */
 var days = new URLSearchParams(location.search).get("days");
var current = new Date();

let userId = null;
function returnAndLogin(){
	
	if(userId == null){
		alert("로그인시 이용 가능합니다.");
		 window.location.replace("../user/loginPage");
			return;
	}
}
function getUserId(){
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			if(response.result == "success"){
				userId = response.userId;
			}
		}
	}
	xhr.open("get","./getUserId",false);
	xhr.send();
}

function fadeText() {
    opacity -= stepOpacity;
    contentBox.style.color = `rgba(0, 0, 0, ${opacity})`;

    if (opacity > 0) {
      // 아직 흐려지는 단계가 남아있으면 재귀적으로 호출
      requestAnimationFrame(fadeText);
    } else {
      // 흐려지는 효과가 끝나면 100글자 이후의 텍스트를 가려줌
      contentBox.innerText = originalText.slice(0, maxLength);
    }
  }
  
function getHotelInfo(){
	const xhr = new XMLHttpRequest();
	const hotelNameBox = document.getElementById("hotelNameBox");
	const hotelCategoy = document.getElementById("hotelCategoy");
	const loc = document.getElementById("loc");
	const mainImageBox = document.getElementById("mainImageBox");
	
	const images = document.getElementsByClassName("roomimages");
	const imageGroup = document.getElementById("imageGroup");
	const totalImageCountBox = document.getElementById("totalImageCountBox");
	const totalImageCount = document.getElementById("totalImageCount");
	
	const categoryBox = document.getElementById("categoryBox");
	categoryBox.innerHTML ="";
	
	const contentBox = document.getElementById("contentBox")
	
	const modalContentBox = document.getElementById("modalContentBox");
	const opacity2box = document.getElementById("opacity2box")
	mainImageBox.setAttribute("onclick","getImageModal("+hotelId+",0)");
/* 	totalImageCount.setAttribute("onclick","getImageModal("+hotelId+",4)");
 */	
	const starValueBox = document.getElementById("starValueBox");
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4 &&  xhr.status==200){
			const response = JSON.parse(xhr.responseText);
/* 			modalContentBox.innerText = response.info.hotelDto.content;
 */			const originalText = response.info.hotelDto.content;
			const maxLength = 330; // 100글자 이상부터 점점 흐려지게 할 글자 수
			const visibleLength = originalText.length - maxLength;
			
			let oriText = '';
			let extracted2Text = '';
			
			 for(var i=0; i<originalText.length; i++){
				 if(i<=240){
					 oriText += originalText[i];
				 }
				 else if(i > 240 && i < 280){
					 extracted2Text += originalText[i];
				 }
				 
				 if(i == 280){
					 break;
				 }
			}
			 contentBox.innerText = oriText;
			 opacity2box.innerText = extracted2Text;
			 
			 /*   // 텍스트가 100글자 이상인 경우, 100글자 이후의 텍스트를 "..."으로 대체
			 if (visibleLength > 0) {
			    contentBox.innerText = originalText.slice(0, maxLength) + "...";
			  }  */
			 
			hotelNameBox.innerText = response.info.hotelDto.hotel_name;
			hotelCategoy.innerText = response.info.category.category;
			loc.innerText = " "+ response.info.hotelDto.hotel_loc;
			
			const starSpan = document.createElement("span");
			starSpan.classList.add("review-star","small","pe-1");
			
			//별점작업
			const starIconn = document.createElement("i");
			starIconn.classList.add("bi","bi-star");
			const starIconn1 = document.createElement("i");
			starIconn1.classList.add("bi","bi-star");
			const starIconn2 = document.createElement("i");
			starIconn2.classList.add("bi","bi-star");
			const starIconn3 = document.createElement("i");
			starIconn3.classList.add("bi","bi-star");
			const starIconn4 = document.createElement("i");
			starIconn4.classList.add("bi","bi-star");
			
			const halfStarr = document.createElement("i");
			halfStarr.classList.add("bi","bi-star-half");
			
			
			const fillStarr = document.createElement("i");
			fillStarr.classList.add("bi","bi-star-fill");
			const fillStarr1 = document.createElement("i");
			fillStarr1.classList.add("bi","bi-star-fill");
			const fillStarr2 = document.createElement("i");
			fillStarr2.classList.add("bi","bi-star-fill");
			const fillStarr3 = document.createElement("i");
			fillStarr3.classList.add("bi","bi-star-fill");
			const fillStarr4 = document.createElement("i");
			fillStarr4.classList.add("bi","bi-star-fill");
			
			if(response.info.star >= 0 && response.info.star < 1){
				starSpan.appendChild(starIconn);
				starSpan.appendChild(starIconn1);
				starSpan.appendChild(starIconn2);
				starSpan.appendChild(starIconn3);
				starSpan.appendChild(starIconn4);
			}else if(response.info.star >= 1 && response.info.star < 1.5){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(starIconn);
				starSpan.appendChild(starIconn1);
				starSpan.appendChild(starIconn2);
				starSpan.appendChild(starIconn3);
			}else if(response.info.star >= 1.5 && response.info.star < 2){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(halfStarr);
				starSpan.appendChild(starIconn);
				starSpan.appendChild(starIconn1);
				starSpan.appendChild(starIconn2);
			}else if(response.info.star >= 2 && response.info.star < 2.5){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(fillStarr1);
				starSpan.appendChild(starIconn);
				starSpan.appendChild(starIconn1);
				starSpan.appendChild(starIconn2);
			}else if(response.info.star >= 2.5 && response.info.star < 3){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(halfStarr);
				starSpan.appendChild(starIconn);
				starSpan.appendChild(starIconn1);
			}else if(response.info.star >= 3 && response.info.star < 3.5){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(fillStarr1);
				starSpan.appendChild(fillStarr2);
				starSpan.appendChild(starIconn);
				starSpan.appendChild(starIconn1);
			}else if(response.info.star >= 3.5 && response.info.star < 4){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(fillStarr1);
				starSpan.appendChild(fillStarr2);
				starSpan.appendChild(halfStarr);
				starSpan.appendChild(starIconn);
			}else if(response.info.star >= 4 && response.info.star < 4.5){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(fillStarr1);
				starSpan.appendChild(fillStarr2);
				starSpan.appendChild(fillStarr3);
				starSpan.appendChild(starIconn);
			}else if(response.info.star >= 4.5 && response.info.star < 5){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(fillStarr1);
				starSpan.appendChild(fillStarr2);
				starSpan.appendChild(fillStarr3);
				starSpan.appendChild(halfStarr);
			}else if(response.info.star == 5){
				starSpan.appendChild(fillStarr);
				starSpan.appendChild(fillStarr1);
				starSpan.appendChild(fillStarr2);
				starSpan.appendChild(fillStarr3);
				starSpan.appendChild(fillStarr4);
			}
			
			starValueBox.appendChild(starSpan);
			
			
			
			const reviewTotalStar = document.getElementById("reviewTotalStar")
			//별점작업
			const starIcon = document.createElement("i");
			starIcon.classList.add("bi","bi-star");
			const starIcon1 = document.createElement("i");
			starIcon1.classList.add("bi","bi-star");
			const starIcon2 = document.createElement("i");
			starIcon2.classList.add("bi","bi-star");
			const starIcon3 = document.createElement("i");
			starIcon3.classList.add("bi","bi-star");
			const starIcon4 = document.createElement("i");
			starIcon4.classList.add("bi","bi-star");
			
			const halfStar = document.createElement("i");
			halfStar.classList.add("bi","bi-star-half");
			
			
			const fillStar = document.createElement("i");
			fillStar.classList.add("bi","bi-star-fill");
			const fillStar1 = document.createElement("i");
			fillStar1.classList.add("bi","bi-star-fill");
			const fillStar2 = document.createElement("i");
			fillStar2.classList.add("bi","bi-star-fill");
			const fillStar3 = document.createElement("i");
			fillStar3.classList.add("bi","bi-star-fill");
			const fillStar4 = document.createElement("i");
			fillStar4.classList.add("bi","bi-star-fill");
			
			if(response.info.star >= 0 && response.info.star < 1){	
				reviewTotalStar.appendChild(starIcon);
				reviewTotalStar.appendChild(starIcon1);
				reviewTotalStar.appendChild(starIcon2);
				reviewTotalStar.appendChild(starIcon3);
				reviewTotalStar.appendChild(starIcon4);
				
			}else if(response.info.star >= 1 && response.info.star < 1.5){
				reviewTotalStar.appendChild(starIcon);
				reviewTotalStar.appendChild(starIcon1);
				reviewTotalStar.appendChild(starIcon2);
				reviewTotalStar.appendChild(starIcon3);
				reviewTotalStar.appendChild(starIcon4);
			}else if(response.info.star >= 1.5 && response.info.star < 2){	
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(halfStar);
				reviewTotalStar.appendChild(starIcon);
				reviewTotalStar.appendChild(starIcon1);
				reviewTotalStar.appendChild(starIcon2);
			}else if(response.info.star >= 2 && response.info.star < 2.5){
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(halfStar);
				reviewTotalStar.appendChild(starIcon);
				reviewTotalStar.appendChild(starIcon1);
				reviewTotalStar.appendChild(starIcon2);
			}else if(response.info.star >= 2.5 && response.info.star < 3){	
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(halfStar);
				reviewTotalStar.appendChild(starIcon);
				reviewTotalStar.appendChild(starIcon1);
			}else if(response.info.star >= 3 && response.info.star < 3.5){
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(fillStar1);
				reviewTotalStar.appendChild(fillStar2);
				reviewTotalStar.appendChild(starIcon);
				reviewTotalStar.appendChild(starIcon1);
			}else if(response.info.star >= 3.5 && response.info.star < 4){
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(fillStar1);
				reviewTotalStar.appendChild(fillStar2);
				reviewTotalStar.appendChild(halfStar);
				reviewTotalStar.appendChild(starIcon);
			}else if(response.info.star >= 4 && response.info.star < 4.5){
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(fillStar1);
				reviewTotalStar.appendChild(fillStar2);
				reviewTotalStar.appendChild(fillStar3);
				reviewTotalStar.appendChild(starIcon);
			}else if(response.info.star >= 4.5 && response.info.star < 5){
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(fillStar1);
				reviewTotalStar.appendChild(fillStar2);
				reviewTotalStar.appendChild(fillStar3);
				reviewTotalStar.appendChild(halfStar);
			}else if(response.info.star == 5){
				reviewTotalStar.appendChild(fillStar);
				reviewTotalStar.appendChild(fillStar1);
				reviewTotalStar.appendChild(fillStar2);
				reviewTotalStar.appendChild(fillStar3);
				reviewTotalStar.appendChild(fillStar4);
			}
			
			
			const starPointBox = document.createElement("span");
			const reviewStarCount = document.getElementById("reviewStarCount");
			reviewStarCount.innerText = response.info.star
			starPointBox.classList.add("small","fw-bold","ps-1");
			starPointBox.innerText = response.info.star
			starValueBox.appendChild(starPointBox);
			
			
			const reviewValueBox = document.createElement("span");
			reviewValueBox.classList.add("small","text-secondary","fw-bold");
			reviewValueBox.innerText = "("+response.info.review+")";
			starValueBox.appendChild(reviewValueBox);
			
			
			// 이미지작업
			mainImageBox.src = "/uploadFiles/"+response.info.hotelDto.hotel_img;
			
			var roomGroupDtoLength = response.info.roomGroupDto.length;
			var roomGroupImgDtoLength = response.info.roomGroupImgDto.length;

			for (var i = 0; i < Math.min(4, roomGroupDtoLength + roomGroupImgDtoLength); i++) {
			  if (i < roomGroupDtoLength) {
			    images[i].src = "/uploadFiles/" + response.info.roomGroupDto[i].room_group_img;
			  } else {
			    images[i].src = "/uploadFiles/" + response.info.roomGroupImgDto[i - roomGroupDtoLength].detail_img;
			  }
			  images[i].setAttribute("onclick", "getImageModal(" + hotelId+","+(i+1)+ ")");
			  if(i==3){
				 const imgBadge = document.getElementById("imgBadge");
				 imgBadge.setAttribute("onclick", "getImageModal(" + hotelId+","+(i+1)+ ")");
			  }
			}
			
/* 			if(roomGroupDtoLength+roomGroupImgDtoLength -4 > 0){
				totalImageCount.innerText = "+" +(roomGroupDtoLength + roomGroupImgDtoLength - 3);
			}else{
				totalImageCount.innerText = "0";
			} */
			//필터(커스텀카테고리,뷰)
			/* const filterInput =document.getElementById("filterInput");
			
			for(var i = 0; i<response.info.view.length-1; i++){
				const input = document.createElement("input");
				input.type= "radio";
				input.name= "view";
				input.value= response.info.view[i].id;
			
				
			  const label = document.createElement("label");
			  label.appendChild(input);
			  label.appendChild(document.createTextNode(response.info.view[i].room_view));
			
			  filterInput.appendChild(label);
			  
			
			} */
			
			  //카테고리 리스트
			  response.info.system.forEach(function(category){
				  console.log(1);
				  if(category.category == "바베큐장"){
					  const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")
					  const i = document.createElement("i");
					  i.classList.add("bi","bi-fire","fs-5","text-center");
					  span1.appendChild(i);
					  span2.innerText = "바베큐";			
					  col.appendChild(span1)
					  col.appendChild(span2)
					  
				  }else if(category.category == "노래방"){
					  const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-music-note-beamed","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "노래방";		
					  col.appendChild(span1)
					  col.appendChild(span2)
				  }else if(category.category == "레스토랑"){
					  const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-cup-straw","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "레스토랑";	
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "매점/편의점"){
			 		  const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-cart","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "매점/편의점";	
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "수영장"){
			 		  const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-water","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "수영장";	
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "피트니스"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-person","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "피트니스";
					  col.appendChild(span1)
					  col.appendChild(span2)

			 	 }else if(category.category == "객실내흡연"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-magic","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "흡연";	 
					  col.appendChild(span1)
					  col.appendChild(span2)
					
			 	 }else if(category.category == "금연"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-x-lg","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "금연";	 
					  col.appendChild(span1)
					  col.appendChild(span2)
					
					
			 	 }else if(category.category == "룸서비스"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-emoji-laughing","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "룸서비스";	 
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "무료주차"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-sign-no-parking","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "무료주차";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "바/라운지"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-trash2","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "바/라운지";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "반려동물 동반가능"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-android","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "반려동물";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "조식 서비스"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-cup-hot","fs-5");
					  
					  span1.appendChild(i);
					  span2.innerText = "조식";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "취사가능"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-check-lg","fs-5");
					  
					  span1.appendChild(i);
					  span2.innerText = "취사";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "WIFI "){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-wifi","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "WIFI";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "24시간 프론트"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-universal-access","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "24시프론트";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }else if(category.category == "루프탑"){
			 		 const col = document.createElement("div");
					  col.classList.add("mb-2","text-start","col-6");
					  categoryBox.appendChild(col);
					  
					 const span1 =document.createElement("span");
					 const span2 =document.createElement("span");
					 span2.classList.add("fw-semibold","ms-2")

					  const i = document.createElement("i"); 
					  i.classList.add("bi","bi-stars","fs-5","text-center");
					  
					  span1.appendChild(i);
					  span2.innerText = "루프탑";
					  col.appendChild(span1)
					  col.appendChild(span2)
			 	 }
			  })
				  
			  
				 
					  
			getMap()
		}
		
	}
	xhr.open("get","./getHotelInfo?id="+hotelId);
	xhr.send();
}



function getImageModal(id,index){
	const modal = bootstrap.Modal.getOrCreateInstance("#getImageModal");
	const xhr = new XMLHttpRequest();
	const totalImageBox = document.getElementById("totalImageBox");
	totalImageBox.innerHTML = "";
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			var roomGroupDtoLength = response.info.roomGroupDto.length;
			var roomGroupImgDtoLength = response.info.roomGroupImgDto.length;
			
			const div = document.createElement("div");
	    	div.classList.add("carousel-item");
	    	if(index==0){
	    		div.classList.add("active");
	    	}
			const img = document.createElement("img");
	    	img.src = "/uploadFiles/" + response.info.hotelDto.hotel_img;
	    	img.classList.add("d-block","w-100");
	    	img.style.height= "450px";
	    	div.appendChild(img);
	    	totalImageBox.appendChild(div);
	    	
			for (var i = 0; i < (roomGroupDtoLength + roomGroupImgDtoLength); i++) {	 
				const div = document.createElement("div");
		    	div.classList.add("carousel-item");
		    	if(index == i+1){
		   			  div.classList.add("active");
		   		  }
				
				if (i < roomGroupDtoLength) {
					 const img = document.createElement("img");
			    	  img.src = "/uploadFiles/" + response.info.roomGroupDto[i].room_group_img;
			    	  img.classList.add("d-block","w-100");
					    img.style.height= "450px";
			    	  div.appendChild(img);
			    	  totalImageBox.appendChild(div);
			    	  } else {
			    		  const img = document.createElement("img");
				    	  img.src = "/uploadFiles/" + response.info.roomGroupImgDto[i - roomGroupDtoLength].detail_img;
				    	 
				    	  img.classList.add("d-block","w-100");
					    img.style.height= "450px";
				    	  div.appendChild(img);
				    	  totalImageBox.appendChild(div);
				    	  }   	 
		    	}
			modal.show();
		}
	}
	xhr.open("get","./getHotelInfo?id="+id);
	xhr.send();
}
// 날짜 collapse
function getDateCollapse(){
	const collapse = bootstrap.Collapse.getOrCreateInstance("#dateCollapse");
	
	collapse.show();
	
	
	
}

function hideDateCollapse(){
	const collapse = bootstrap.Collapse.getOrCreateInstance("#dateCollapse");
	const dayBox = document.getElementById("dayBox");

	const startDay = document.getElementById("startDay");
	const endDay = document.getElementById("endDay");

	const inputStart = new Date(startDay.value);
	const inputEnd = new Date(endDay.value);
	
/* 	const timeDiff = Math.abs(inputEnd.getTime() - inputStart.getTime());
	const diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
	dayDifference = diffDays; */

	var monthNames = [
	  "01", "02", "03", "04", "05", "06",
	  "07", "08", "09", "10", "11", "12"
	];

	var dayNames = [
	  "일", "월", "화", "수", "목", "금", "토"
	];

	var smonth = monthNames[inputStart.getMonth()];
	var sday = inputStart.getDate().toString().padStart(2, '0');
	var sdayOfWeek = dayNames[inputStart.getDay()];
	var syear = inputStart.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

	var emonth = monthNames[inputEnd.getMonth()];
	var eday =  inputEnd.getDate().toString().padStart(2, '0');
	var edayOfWeek = dayNames[inputEnd.getDay()];
	var eyear = inputEnd.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

	var start = syear + "/" + smonth + "/" + sday + "/(" + sdayOfWeek + ")";
	var end = eyear + "/" + emonth + "/" + eday + "/(" + edayOfWeek + ")";

	dayBox.innerText = start + " - " + end;
	
	collapse.hide();
}



// 인원collapse
function getPeopleCollapse(){
	const collapse = bootstrap.Collapse.getOrCreateInstance("#peopleCollapse");
	
	collapse.show();
	
	
	
}

function hidePeopleCollapse(){
	const collapse = bootstrap.Collapse.getOrCreateInstance("#peopleCollapse");
	const peopleInput = document.getElementById("peopleInput");
	const peopleBox = document.getElementById("peopleBox");
	peopleBox.innerText = peopleInput.value;
	collapse.hide();
}

//필터collapse
function getFilterCollapse(){
	const collapse = bootstrap.Collapse.getOrCreateInstance("#filterCollapse");
	
	collapse.show();
	
	
	
}

function hideFilterCollapse(){
	const collapse = bootstrap.Collapse.getOrCreateInstance("#filterCollapse");
	const filterBox = document.getElementById("filterBox");
	const filterInput = document.querySelector("input[name=view]:checked");
	const viewId = filterInput.value;
	if(viewId== 1){
		filterBox.innerText = "오션뷰";
	}else if(viewId==2){
		filterBox.innerText="시티뷰";
	}else if(viewId==3){
		filterBox.innerText ="포레스트뷰";
	}else{
		filterBox.innerText ="없음";
	}
	
	
	collapse.hide();
}
//그룹 갖고오기

// 변환된 값 출력
var startDay = '${startDate}'
var endDay = '${endDate}'

var fixedNumber = ${people};
var viewNumber = 0;

var weekDays = days;

function getGroupList(){
	const xhr = new XMLHttpRequest();
	const groupListBox = document.getElementById("groupListBox");
	groupListBox.innerHTML ="";
	var minPrice = 0;
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			if(response.result == "success"){
			for(list of response.group){
				const card1 = document.createElement("div");
		        card1.classList.add("card", "mt-3","shadow","border-white");
				card1.style.borderRadius = "15px";
		        const card1row = document.createElement("div");
		        card1row.classList.add("row", "mt-3", "mb-3");
		        card1.appendChild(card1row);

		        const imgcol = document.createElement("div");
		        imgcol.classList.add("col-3", "ms-3");
		        card1row.appendChild(imgcol);

		        const img = document.createElement("img");
		        img.src ="/uploadFiles/"+ list.roomGroupDto.room_group_img;
		        /* img.classList.add("img-fluid"); */
		        img.style.width ="230px";
		        img.style.height ="180px";
		        img.style.borderRadius = "15px";
		        imgcol.appendChild(img);

		        const contentCol = document.createElement("div");
		        contentCol.classList.add("col");
		        card1row.appendChild(contentCol);

		        const cardBody = document.createElement("div");
		        cardBody.classList.add("row");
		        contentCol.appendChild(cardBody);
				
		        const cardCol1 = document.createElement("div");
		        cardCol1.classList.add("col-8","ps-4")
		        cardBody.appendChild(cardCol1);
		        
		        const cardRow1 = document.createElement("div");
		        cardRow1.classList.add("row");
		        cardCol1.appendChild(cardRow1);
		        
		        const cardRowCol = document.createElement("div");
		        cardRowCol.classList.add("col")
		        cardRow1.appendChild(cardRowCol);
		        
		        
		        const roomRow = document.createElement("div");
		        roomRow.classList.add("row");
		        cardRowCol.appendChild(roomRow);

		        const roomCol = document.createElement("div");
		        roomCol.classList.add("col", "fw-semibold", "fs-5");
		        roomCol.textContent = list.roomGroupDto.room_group_name;
		        roomRow.appendChild(roomCol);

		        
		        const capacityRow = document.createElement("div");
		        capacityRow.classList.add("row","mt-2");
		        cardRowCol.appendChild(capacityRow);

		        const capacityCol = document.createElement("div");
		        capacityCol.classList.add("col", "small");

		        const capacityIcon = document.createElement("i");
		        capacityIcon.classList.add("bi", "bi-person", "text-primary");

		        const capacityText = document.createElement("span");
		        capacityText.textContent = list.roomGroupDto.fixed_number +"인";
				
		        capacityCol.appendChild(capacityIcon);
		        capacityCol.appendChild(capacityText);
		        capacityRow.appendChild(capacityCol);
				
		        const innerRow1 = document.createElement("div");
				innerRow1.classList.add("row","mt-2");
				cardRowCol.appendChild(innerRow1);

				const innerCol1 = document.createElement("div");
				innerCol1.classList.add("col", "fw-semibold", "fs-6");
				
				const textColors = ["text-primary", "text-secondary", "text-info","text-warning","text-danger"]; 
				for(var i = 0; i < list.customCategory.length; i++){
					var cusSpan = document.createElement("span");
					cusSpan.classList.add("small",textColors[i % textColors.length],"me-2","fw-semibold");
					cusSpan.innerText = list.customCategory[i].category_name;
					innerCol1.appendChild(cusSpan);
				}

				if(list.view.id == 1){
					var viewSpan = document.createElement("span");
					viewSpan.classList.add("small","text-info","me-2","fw-semibold");
					viewSpan.innerText = list.view.room_view;
					innerCol1.appendChild(viewSpan);
				}else if(list.view.id==2){
					var viewSpan = document.createElement("span");
					viewSpan.classList.add("small","text-warning","me-2","fw-semibold");
					viewSpan.innerText = list.view.room_view;
					innerCol1.appendChild(viewSpan);
				}else if(list.view.id==3){
					var viewSpan = document.createElement("span");
					viewSpan.classList.add("small","text-success","me-2","fw-semibold");
					viewSpan.innerText = list.view.room_view;
					innerCol1.appendChild(viewSpan);
				}
				
				innerRow1.appendChild(innerCol1);
		        
				const badgeRow = document.createElement("div");
				badgeRow.classList.add("row","mt-2");
				cardRowCol.appendChild(badgeRow);
				
				const badgediv = document.createElement("div");
				badgeRow.appendChild(badgediv);
				
				const badge1 = document.createElement("span");
				badge1.classList.add("badge","text-white");
				badge1.style.backgroundColor ="#1b84c5";
		
				badge1.innerText = "무료취소";
				badgediv.appendChild(badge1)
				

				if(list.oriPrice > list.changePrice){
				const badge3 = document.createElement("span");
				badge3.classList.add("badge","text-bg-danger","ms-2");
				badge3.innerText = "초특가";
				badgediv.appendChild(badge3)
				}
				
				const detailRow = document.createElement("div");
				detailRow.classList.add("row","mt-2");
				cardRowCol.appendChild(detailRow);
				
				const detailCol = document.createElement("div");
				detailCol.classList.add("col", "text-secondary","small","fw-semibold");
				detailCol.setAttribute("onclick","getGroupImage("+list.roomGroupDto.id+")");
				detailCol.textContent = "객실 사진 더보기";
				detailRow.appendChild(detailCol);
				
				
				const cardCol2 = document.createElement("div");
				cardCol2.classList.add("col-4","text-end")
		        cardBody.appendChild(cardCol2);
		        
		        const cardRow2 = document.createElement("div");
		        cardRow2.classList.add("row","mt-1");
		        cardCol2.appendChild(cardRow2);
		        
		        const cardRowCol2 = document.createElement("div");
		        cardRowCol2.classList.add("col")
		        cardRow2.appendChild(cardRowCol2);
				
				const reserveButtonRow = document.createElement("div");
				reserveButtonRow.classList.add("row","mt-5");
		        
				const reserveButtonCol = document.createElement("div");
				reserveButtonCol.classList.add("col")
		        reserveButtonRow.appendChild(reserveButtonCol);
				
				const reserveButton = document.createElement("a");
				reserveButton.type = "button";
				reserveButton.classList.add("btn","btn-dark","fw-semibold");
				reserveButton.innerText = "예약하기";
				if(userId == null){
					reserveButton.setAttribute("onclick","returnAndLogin()")
				}else{
					reserveButton.href = "./hotelReservePage?groupId="+list.roomGroupDto.id+"&startDate="+startDate+"&endDate="+endDate+"&firstPrice="+list.finalPrice;

				}
				reserveButton.style.borderRadius = "10px";
				reserveButton.style. fontSize = "17px";
				reserveButton.style.borderRadius = "10px";
				reserveButton.style.padding= "7px 15px";
				reserveButton.style.border="0";
				reserveButtonCol.appendChild(reserveButton);
				
	
				const priceInRow = document.createElement("div");
				priceInRow.classList.add("row","mt-1");
				cardRowCol2.appendChild(priceInRow)
				
				const priceInCol = document.createElement("div");
				priceInCol.classList.add("col");
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
				cardRowCol2.appendChild(priceInRow2)
				
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
				if(minPrice == 0){
					minPrice = list.changePrice
				}else{
					if(minPrice > list.changePrice){
						minPrice = list.changePrice
					}
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
				cardRowCol2.appendChild(priceInRow3)
				
				const priceInCol3 = document.createElement("div");
				priceInCol3.classList.add("col","fw-semibold","opacity-50","small");
				priceInCol3.style.color = "black";

				priceInCol3.innerText = "세금 포함 가격"
				priceInRow3.appendChild(priceInCol3)
								cardRowCol2.appendChild(reserveButtonRow);

				
		        groupListBox.appendChild(card1);
			    
			/* 	const card2 = document.createElement("div");
				card2.classList.add("card","shadow","border-white");

				const row2 = document.createElement("div");
				row2.classList.add("row", "mt-2");
				card2.appendChild(row2);

				const col2 = document.createElement("div");
				col2.classList.add("col", "ms-3");
				row2.appendChild(col2);

				const cardBody2 = document.createElement("div");
				cardBody2.classList.add("card-body");
				col2.appendChild(cardBody2);

				

			

				const innerRow2 = document.createElement("div");
				innerRow2.classList.add("row", "mt-3");
				cardBody2.appendChild(innerRow2);

				const innerCol3 = document.createElement("div");
				innerCol3.classList.add("col");
				innerRow2.appendChild(innerCol3);
				const priceSpan = document.createElement("span");
				priceSpan.classList.add("fw-semibold","fs-5"); */
/* 				const listPrice = list.roomGroupDto.price * dayDifference;
			priceSpan.innerText = listPrice.toLocaleString(); */	
				
		/* 		innerCol3.appendChild(priceSpan);

				const smallSpan = document.createElement("span");
				smallSpan.classList.add("small");
				smallSpan.innerText = " 원";
				innerCol3.appendChild(smallSpan);

				const innerCol4 = document.createElement("div");
				innerCol4.classList.add("col", "text-end");
				innerRow2.appendChild(innerCol4); */
				
/* 				//입력된 날짜
				 const dayBox = document.getElementById("dayBox");
				const date = dayBox.innerText;
				const [startDate,endDate] = date.split("-"); */
				/* 
				const reservationButton = document.createElement("a");
				reservationButton.classList.add("btn", "btn-outline-primary", "fs-6", "fw-semibold", "custom-text-color");
				reservationButton.style.setProperty("--bs-btn-padding-y", ".5rem");
				reservationButton.style.setProperty("--bs-btn-padding-x", "1.4rem");
				reservationButton.style.setProperty("--bs-btn-font-size", ".75rem");
				reservationButton.style.height = "3rem";
				reservationButton.textContent = "예약";
				innerCol4.appendChild(reservationButton); 

				groupListBox.appendChild(card2); */

			}
			const stickyPriceBox = document.getElementById("stickyPriceBox");
			stickyPriceBox.innerText = minPrice.toLocaleString() +"원~"
			}else if(response.result == "fail"){
				const fail = document.createElement("div");
				fail.classList.add("col","text-center","mt-5","mb-5","fs-2","fw-semibold");
				fail.innerText = "예약 가능한 숙소가 없습니다.";
				groupListBox.appendChild(fail)
			}
		}
	}
	xhr.open("get","./getGroupList?startDay="+startDay+"&endDay="+endDay+"&hotel_id="+hotelId+"&fixed_number="+fixedNumber+"&view_id="+viewNumber+"&days="+weekDays);
	xhr.send();
}
function groupSearch(){
	const dayFilterBox = document.getElementById("dayBox");
	const peopleFilterBox = document.getElementById("peopleBox");
	const viewFilterBox  = document.getElementById("filterBox");
	
	const filterDate = dayFilterBox.innerText;
	const [filterStart,filterEnd] = filterDate.split("-");
	
	startDay = filterStart; 
	endDay = filterEnd;
	fixedNumber = peopleFilterBox.innerText;
	
	if(viewFilterBox.innerText != '필터'){
		if(viewFilterBox.innerText == '오션뷰'){
			viewNumber = 1;
		}else if(viewFilterBox.innerText == '시티뷰'){
			viewNumber = 2;
		}else if(viewFilterBox.innerText == '포레스트뷰'){
			viewNumber = 3;
		}
	}
	
	getGroupList();
	
}


//그룹이미지 모달
function getGroupImage(groupId){
	const modal = bootstrap.Modal.getOrCreateInstance("#groupImageModal")
	const groupImageBox = document.getElementById("groupImageBox");
	const xhr = new XMLHttpRequest();
	groupImageBox.innerHTML ="";
	xhr.onreadystatechange = function(){
		if(xhr.readyState ==4 && xhr.status ==200){
			const response = JSON.parse(xhr.responseText);
			for(var i =0; i<response.images.length; i++){
				const div = document.createElement("div");
		    	div.classList.add("carousel-item");
		    	if(i==0){
		    		div.classList.add("active");
		    	}
		    	const img = document.createElement("img");
		    	img.src = "/uploadFiles/" + response.images[i].detail_img;
		    	  img.classList.add("d-block","w-100");
			    img.style.height= "450px";
		    	div.appendChild(img);
		    	groupImageBox.appendChild(div);
		    	

			}
			modal.show();
		}
	}
	xhr.open("get","./getGroupImage?room_group_id="+groupId);
	xhr.send();
}

function getLocation(){
	const modal = bootstrap.Modal.getOrCreateInstance("#locationModal");
	modal.show();	
}

function getReviewList(){
	const reviewBox =document.getElementById("reviewBox");
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			if(response.result == "success"){
				for(list of response.review){
					const row1 = document.createElement("div");
					row1.classList.add("row","mt-4","border-bottom","pb-4");
					reviewBox.appendChild(row1);
					
					const col9 = document.createElement("div");
					col9.classList.add("col-9");
					row1.appendChild(col9);
					
					const row2 = document.createElement("div");
					row2.classList.add("row");
					col9.appendChild(row2);
					
					const namecol = document.createElement("div");
					namecol.classList.add("col");
					
					const starspan = document.createElement("span");
					starspan.classList.add("review-star");
					
					const namespan = document.createElement("span");
					namespan.classList.add("fw-semibold","ms-2");
					
					namecol.appendChild(starspan)
					namecol.appendChild(namespan)
					
					var star = "";
					for(var index =0; index<list.reviewDto.star; index++){
						star += '★';
					}
					var cName = "";
					for(var i =0; i<list.userDto.user_name.length; i++){
						if(i == 1){
							cName += "*";
						}else{
							cName += list.userDto.user_name[i];
						}
					}
					namespan.innerText = cName;
					
					starspan.innerText =star
					
					
					row2.appendChild(namecol);
					
					const row3 = document.createElement("div");
					row3.classList.add("row");
					col9.appendChild(row3);
					
					const dateRoomCol = document.createElement("div");
					dateRoomCol.classList.add("col");
					row3.appendChild(dateRoomCol)
					
					const datecol = document.createElement("span");
					datecol.classList.add("small","text-secondary","pe-2");
					const regdate = new Date(list.reviewDto.review_date);
					var monthNames = [
						  "01", "02", "03", "04", "05", "06",
						  "07", "08", "09", "10", "11", "12"
						];

					var dayNames = [
						  "일", "월", "화", "수", "목", "금", "토"
						];
					var month = monthNames[regdate.getMonth()];
					var day = regdate.getDate().toString().padStart(2, '0');
					var year = regdate.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
					var date = year + "/" + month + "/" + day;
					
					datecol.innerText = date;
					dateRoomCol.appendChild(datecol);
					
					const groupcol = document.createElement("span");
					groupcol.classList.add("small","text-secondary","ps-2","border-start");
					groupcol.innerText = list.roomGroupDto.room_group_name;
					dateRoomCol.appendChild(groupcol);
					
					const row4 = document.createElement("div");
					row4.classList.add("row","mt-2");
					col9.appendChild(row4);
					
					const contentcol = document.createElement("div");
					contentcol.classList.add("col-9");
					contentcol.innerText = list.reviewDto.content;
					row4.appendChild(contentcol);
					
					const imgcol = document.createElement("div");
					imgcol.classList.add("col");
					row1.appendChild(imgcol);
					
					const img =document.createElement("img");
					img.src = "/uploadFiles/"+list.roomGroupDto.room_group_img;
					img.classList.add("img-fluid");
					
					imgcol.appendChild(img);
				}
				
				const starCounts = [
					  document.getElementById("starCount1"),
					  document.getElementById("starCount2"),
					  document.getElementById("starCount3"),
					  document.getElementById("starCount4"),
					  document.getElementById("starCount5")
					];

					const starPros = [
					  document.getElementById("start1Pro"),
					  document.getElementById("start2Pro"),
					  document.getElementById("start3Pro"),
					  document.getElementById("start4Pro"),
					  document.getElementById("start5Pro")
					];

					for (let s = 0; s < 5; s++) {
					  starCounts[s].innerText = response.starCount[s] +"명";
					  starPros[s].style.width = response.starCount[s];
					}
			}else{
				console.log("eㅚ내")
				const img1= document.getElementById("img1Box")
				const img2= document.getElementById("img2Box")
				img1.innerHTML ="";
				img2.innerHTML ="";
				const faildiv = document.createElement("div");
				faildiv.classList.add("row","mt-5");
				
				const failcol = document.createElement("div");
				
				failcol.classList.add("col","text-center","fs-2","fw-semibold","text-secondary");
				failcol.innerText = "작성된 리뷰가 없습니다.";
				faildiv.appendChild(failcol);
				
				reviewBox.appendChild(faildiv);
				
				const starCounts = [
					  document.getElementById("starCount1"),
					  document.getElementById("starCount2"),
					  document.getElementById("starCount3"),
					  document.getElementById("starCount4"),
					  document.getElementById("starCount5")
					];

					const starPros = [
					  document.getElementById("start1Pro"),
					  document.getElementById("start2Pro"),
					  document.getElementById("start3Pro"),
					  document.getElementById("start4Pro"),
					  document.getElementById("start5Pro")
					];

					for (let s = 0; s < 5; s++) {
					  starCounts[s].innerText = response.starCount[s] +"명";
					  starPros[s].style.width = response.starCount[s];
					}
			}
			
		}
	}
	xhr.open("get","./getReviewList?hotel_id="+hotelId);
	xhr.send();
}

function getMyUseLike(){
	const xhr = new XMLHttpRequest();
	const likeheart = document.getElementById("likeheart");
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			if(response.useCount == 1){
				likeheart.classList.add("bi-star-fill");
				likeheart.classList.remove("bi-star");
			}else if(response.useCount ==0){
				likeheart.classList.add("bi-star");
				likeheart.classList.remove("bi-star-fill");
			}
			
		}
	}
	xhr.open("get","./getMyUseLike?user_id="+userId+"&hotel_id="+hotelId,false);
	xhr.send();
}

function toggleLike(){
	 returnAndLogin()
	const xhr = new XMLHttpRequest();
	const likeheart = document.getElementById("likeheart");
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			getMyUseLike();
		}
	}
	xhr.open("get","./toggleLike?user_id="+userId+"&hotel_id="+hotelId);
	xhr.send();
}




function getCalander(){
	dates=[];
	const dateBox = document.getElementById("dates");
	dateBox.innerHTML ="";
	const forYear = new Date;
	
	for(var p=0; p<7; p++){
		const viewYear = forYear.getFullYear();
		const viewMonth = forYear.getMonth();
		const forMonth = forYear.setMonth(forYear.getMonth()+1)

		console.log(viewMonth);
		//현재 년/월 넣기
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
	
	
			const yearMonthBox  = document.createElement("div");
	yearMonthBox.classList.add("col-12","text-start","fw-semibold","mt-2","mb-2");

	
	yearMonthBox.innerText = viewYear + "년" +(viewMonth+1)+"월"
	dateBox.appendChild(yearMonthBox);
	dates.forEach((date,i) => { //date는  배열 요소의 값 i는 인덱스
		if(viewMonth == current.getMonth() && date< current.getDate() && i < lastDateIndex){
			const col = document.createElement("div");
			col.classList.add("d-inline","text-center","fs-5","px-0");
			col.style.width = "64px";
			col.style.height = "64px";
			dateBox.appendChild(col);
			
			const span = document.createElement("div");
			span.classList.add("text-secondary","date");
			span.style.opacity ="0.2"; 
			span.innerText = date;
			col.appendChild(span);
		}else if(i >=firstDateIndex && i < lastDateIndex+1){


			const col = document.createElement("div");
			col.classList.add("d-inline","text-center","fs-5","px-0");
			col.style.width = "64px";
			col.style.height = "64px";
			dateBox.appendChild(col);
			
			const span = document.createElement("div");
			span.classList.add("this","date");
			span.innerText = date;
			span.id = parseInt(viewYear +""+(viewMonth+1).toString().padStart(2, '0')+ "" +  date.toString().padStart(2, '0'),10);
			span.setAttribute("onclick","getClickDates1("+parseInt(viewYear +""+(viewMonth+1).toString().padStart(2, '0')+ "" + date.toString().padStart(2, '0'),10)+")")
			col.appendChild(span);
			if(p == 6){
				lastDate =  parseInt(viewYear +""+(viewMonth+1).toString().padStart(2, '0')+ "" +  date.toString().padStart(2, '0'),10);
			}
		}else{
			const col = document.createElement("div");
			col.classList.add("d-inline","text-center","fs-5","px-0");
			dateBox.appendChild(col);
			col.style.width = "64px"
		}
	})
	const today = new Date();
	
	if(viewMonth == today.getMonth() && viewYear == today.getFullYear()){
		for(date of document.getElementsByClassName("this")){
			if(date.innerText == today.getDate()){
				date.classList.add("fw-semibold","text-primary");
			}
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
	getCalander();
}
var lastDate = 0;

var dates = [];
dates.length = 2;

var beforeDates =[]
beforeDates.length = 2;

function getClickDates1(num){
	dates=[];
	const button = document.getElementById("dateButton");
	button.setAttribute("disabled","");
	const date = document.getElementsByClassName("date");
	for(d of date){
		d.classList.remove("choiceDay2");
		d.classList.remove("choiceDay");
		d.classList.remove("bg-secondary","bg-opacity-25");
	}
	 const target = document.getElementById(num);

	dates[0] = num;
	getClickDates2(num);
	target.classList.add("choiceDay");
}
function resetDates() {
	/*   const dates = document.getElementsByClassName("date");
	  for (const date of dates) {
	    date.classList.remove("choiceDay");
	    date.classList.remove("bg-secondary", "bg-opacity-50");
	    date.removeAttribute("onmouseover");
	  } */
	  getCalander()
}
	
function getClickDates2(num){
	 for(var i=num+1; i<=lastDate; i++){
		 const target = document.getElementById(i);
		 if(target){
			 target.setAttribute("onmouseover","mouseover(this)");
		 } 
	 }
}
function mouseover(target){
	const date = document.getElementsByClassName("date");
	for(d of date){
		d.classList.remove("choiceDay2");
		d.classList.remove("choiceDay");
		d.classList.remove("bg-secondary","bg-opacity-25");
		d.removeAttribute("onclick")
	}
	const day1 = document.getElementById(dates[0]);
	day1.classList.add("choiceDay")
	for(var i=dates[0]+1; i<target.id; i++){
		const target2 = document.getElementById(i);
		if(target2){
			target2.classList.add("bg-secondary","bg-opacity-25");
			
		}
		
	}
	for(var i=dates[0]+1; i<=target.id; i++){
		const target2 = document.getElementById(i);
		if(target2){
			target2.setAttribute("onclick","getClickDates3(this)")
			
		}
		
	}
	target.classList.add("choiceDay2")
}

function getClickDates3(target){
	dates[1] = parseInt(target.id,10);
	target.classList.remove("choiceDay1")
	target.classList.add("choiceDay2")
		const date = document.getElementsByClassName("date");

	for(d of date){
		d.removeAttribute("onmouseover")
		d.setAttribute("onclick","getClickDates1("+d.id+")")
	}
	if(dates.length ==2){
		const button = document.getElementById("dateButton");
		button.removeAttribute("disabled")
	}

}
function getDateButton(){
	const dayBox = document.getElementById("checkInput");
	
	const inputStart = new Date(dates[0].toString().replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3'));
	const inputEnd = new Date(dates[1].toString().replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3'));
	getAllWeekdays(inputStart, inputEnd)
	
	var monthNames = [
	  "01", "02", "03", "04", "05", "06",
	  "07", "08", "09", "10", "11", "12"
	];

	var dayNames = [
	  "일", "월", "화", "수", "목", "금", "토"
	];

	var smonth = monthNames[inputStart.getMonth()];
	var sday = inputStart.getDate().toString().padStart(2, '0');
	var sdayOfWeek = dayNames[inputStart.getDay()];
	var syear = inputStart.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

	var emonth = monthNames[inputEnd.getMonth()];
	var eday =  inputEnd.getDate().toString().padStart(2, '0');
	var edayOfWeek = dayNames[inputEnd.getDay()];
	var eyear = inputEnd.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

	var start = syear + "/" + smonth + "/" + sday + "/(" + sdayOfWeek + ")";
	var end = eyear + "/" + emonth + "/" + eday + "/(" + edayOfWeek + ")";
	
	startDate = start;
	endDate =end;
	dayBox.innerText = start + " - " + end;
	
	beforeDates = dates 
	const modal = bootstrap.Modal.getOrCreateInstance("#dateModal");
	  modal.hide();
	  getGroupList();
} 
var weekDays =days;
var startDate = '${startDate}'
var endDate = '${endDate}'
function getAllWeekdays(start, end) {
	  const result = [];
	  weekDays = [];
	  const current = new Date(start);
	  while (current < end) {
	    const day = current.getDay();
	    result.push(day);
	    current.setDate(current.getDate() + 1);
	  }

	  weekDays = result;
}


function getDateModal(){
	const modal = bootstrap.Modal.getOrCreateInstance("#dateModal");
	getCalander()
	modal.show();
}

function getMap(){
	const name =document.getElementById("hotelNameBox").innerText
	const loc =document.getElementById("loc").innerText
	console.log(name)
	console.log(loc)
	var mapContainer = document.getElementById('maap'), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  

	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	//주소로 좌표를 검색합니다
	geocoder.addressSearch(loc, function(result, status) {

	// 정상적으로 검색이 완료됐으면 
	 if (status === kakao.maps.services.Status.OK) {

	    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: coords
	    });

	    // 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content: '<div style="width:150px;text-align:center;padding:6px 0;">'+name+'</div>'
	    });
	    infowindow.open(map, marker);

	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map.setCenter(coords);
	} 
	});  
}

function getHotelContentModal(){
	const hotelContentModal = bootstrap.Modal.getOrCreateInstance("#hotelContentModal");
	hotelContentModal.show();
}

function scrollToSection() {
	  // 특정 위치로 스크롤하는 코드
	  const targetSection = document.getElementById('groupListTop'); // 특정 섹션의 ID
	  const y = targetSection.getBoundingClientRect().top + window.pageYOffset;

	  // 스크롤 이동
	  window.scrollTo({ top: y, behavior: 'smooth' });
}
window.addEventListener("DOMContentLoaded",function(){
	getUserId();
	getHotelInfo();
	getGroupList();
	getReviewList();
	getMyUseLike();
	getMap();
	
});
</script>

</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>

<div class="container-fluid">

	<div class="row mt-5">
		<div class="col-3"></div>
		<div class="col">
			<div class="row">
				<div class="col fs-2 fw-bold" id="hotelNameBox"> <!-- 호텔명 -->
					
				</div>
			<!-- 	<div class="col text-end"> 위치보기버튼
					<button type="button" class="btn btn-outline-secondary btn-lg text-secondary fw-semibold fs-6" onclick="getLocation()"><i class="bi bi-map text-primary"></i>&nbsp;위치보기</button>	
				</div> -->
				<div class="col text-end">
				<i class="bi bi-star  fs-3 btn" id="likeheart" onclick="toggleLike()" style="color: #399ad7;"></i>	
				</div>
			</div>
			<div class="row">
				<div class="col text-secondary pb-0 pt-0" id="hotelCategoy"> <!-- 호텔분류 -->
					
				</div>

			</div>
			<div class="row mt-0 pb-3 border-bottom">
				<div class="col" id="starValueBox"> <!-- 별점 -->
 
				</div>
				
			</div>
			<div class="row  py-2 border-bottom">
				<div class="col"><!-- 주소 -->
					<i class="bi bi-geo-alt"></i><span id="loc"></span>
				</div>
				<div class="col text-end text-secondary">
					체크인 - 15:00~ / 체크아웃 - 11:00
				</div>
			</div>
			<div class="row mt-5">
				<div class="col px-0"> <!-- 사진 -->
					<div class="card border-white" style="width: 57rem;">
						<img  class="image-hover" id="mainImageBox" style="height:510px; width:945px; border-radius:15px 15px 0px 0px;">
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:3px;">
				<div class="col px-0">
					<div class="card-group" id="imageGroup">
					  <div class="card border-white">
						<img  class="image-hover roomimages" style="height:150px; width:232px; border-radius:0px 0px 0px 15px;" >
					  </div>
					  <div class="card border-white">
						<img  class="image-hover roomimages"style="height:150px; width:232px;" >
					  </div>
					  <div class="card border-white">
						<img class="image-hover roomimages" style="height:150px; width:232px;">
					  </div>
					  <div class="card border-white" style="position: relative;">
						<img class="image-hover roomimages" style="height:150px; width:232px; border-radius:0px 0px 15px 0px;">
						  <span id="imgBadge" class="badge" style="position: absolute; bottom: 13px; right: 13px; font-size: 14px; background-color: white; color: black; padding: 10px 20px; border-radius: 15px;">사진 모두 보기</span>
					  </div>
<!-- 					  <div class="card  border-white text-bg-secondary" id="totalImageCountBox">
						<div class="card-body text-center fs-1 pt-4  image-hover" id="totalImageCount" style="border-radius:15px;">
							<img class="image-hover roomimages" style="height:150px; width:227px; border-radius:15px;">
						</div>
					  </div> -->
					</div>
				</div>
			</div>
			<%-- <div class="card mt-3"> <!-- 검색 -->
			  <div class="card-body p-2">
			    <div class="row">
			      <div class="col-4 d-grid pe-1">
			        <button type="button" class="btn btn-outline-secondary dropdown-toggle text-start text-dark fw-semibold" onclick="getDateCollapse()">
			          <i class="bi bi-calendar text-primary"></i>&nbsp; <span id="dayBox">${startDate } - ${endDate }</span>
			        </button>
			      </div>
			      <div class="col-3 d-grid ps-0 pe-1">
			        <button type="button" class="btn btn-outline-secondary dropdown-toggle text-start text-dark fw-semibold" onclick="getPeopleCollapse()">
			          <i class="bi bi-person text-primary"></i>&nbsp; <span id="peopleBox">${people}</span>명
			        </button>
			      </div>
			      <div class="col-3 d-grid ps-0 pe-1">
			        <button type="button" class="btn btn-outline-secondary dropdown-toggle text-start text-dark" onclick="getFilterCollapse()">
			        	<span id="filterBox">필터</span>
			        </button>
			      </div>
			      <div class="col-2 ps-0 d-grid">
			        <button type="button" class="btn btn-outline-primary fs-6 fw-semibold custom-text-color" style="--bs-btn-padding-y: .5rem; --bs-btn-padding-x: 1.4rem; --bs-btn-font-size: .75rem; height: 3.5rem;" onclick="groupSearch()">
			          검색
			        </button>
			      </div>
			    </div>
			    <div class="row">
			    	<div class="col">
			    		<div class="collapse" id="dateCollapse">
						  <div class="row">
						  	<div class="col">
						  		<input type="date" id="startDay">부터
						  		<input type="date" id="endDay">
						  		<button type="button" class="btn btn-outline-primary" onclick="hideDateCollapse()">적용</button>
						  	</div>
						  </div>
						</div>
			    	</div>
			    </div>
			    <div class="row">
			    	<div class="col">
			    		<div class="collapse" id="peopleCollapse">
						  <div class="row">
						  	<div class="col  text-center">
						  		<input type="number" min="1" value="1" class="text-end" id="peopleInput"><span>명</span>
						  		<button type="button" class="btn btn-outline-primary" onclick="hidePeopleCollapse()">적용</button>
						  	</div>
						  </div>
						</div>
			    	</div>
			    </div>
			    <div class="row">
			    	<div class="col">
			    		<div class="collapse" id="filterCollapse">
						  <div class="row">
						  	<div class="col text-end">
						  		<span id="filterInput"></span>
						  		<button type="button" class="btn btn-outline-primary" onclick="hideFilterCollapse()">적용</button>
						  	</div>
						  </div>
						</div>
			    	</div>
			    </div>
			  </div>
			</div> --%>
			<div class="row mt-5" id="groupListTop">
				<div class="col-2 fw-semibold" style="font-size:18px;">객실 선택</div>
				<div class="col text-end pt-2 pe-0 fw-semibold" id="checkInput">${startDate } - ${endDate }</div>
				<div class="col-auto text-end ps-3"><button type="button" class="btn btn-outline-dark" style="border-radius:10px;" onclick="getDateModal()">일정 변경</button></div>
			</div>

			<div class="row mt-2" id="groupListBox">
				
				
				
			</div>
		
		
		
		
		</div>
		<div class="col-3">
			<div class="row ms-5 me-5"   id="paymentInfo">
				<div class="col">
					<div class="card">
					  <div class="card-body">
					   	<div class="row">
					   		<div class="col-10">
					   			<span class="fw-semibold">1박</span>
					   			<span class="fs-4 fw-semibold" id="stickyPriceBox">70,000원~</span>
							</div>
							<div class="col text-end fs-5"><i class="bi bi-share"></i></div>
					   	</div>
					   	<div class="row mt-3">
					   		<div class="col d-grid">
					   			<button type="button" class="btn buttonColor text-white  fw-semibold" onclick="scrollToSection()">객실 선택하기</button>
					   		</div>
					   	</div>
					  </div>
					</div>
					<img src="../resources/img/hotelInfoCan4.jpg">
				</div>
			</div>
		</div>
	</div>
	<div class="row mt-5 pt-4 border-top">
		<div class="col-3"></div>
		<div class="col-3 mt-3">
			<div class="row">
				<div class="col fw-semibold " style="font-size:18px;">편의 시설</div>
			</div>
			<div class="row mt-3" id="categoryBox">
			</div>
		</div>
		<div class="col-3 mt-3">
			<div class="row">
				<div class="col fw-semibold " style="font-size:18px;">숙소 위치</div>
			</div>
			<div class="row mt-3">
				<div class="col"  style="border-radius:10px;">
					<div id="maap" style="width:460px;height:250px;"></div>
				</div>
			</div>
		</div>
		<div class="col-3"></div>
	</div>
	<div class="row mt-5  border-bottom pb-5">
		<div class="col-3"></div>
		<div class="col">
			<div class="row mt-5">
				<div class="col-6">
					<div class="row">
						<div class="col fw-semibold"  style="font-size:18px;">
							숙소 정보
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-10">
							<div class="row">
								<div class="col fw-normal" id="contentBox" style="font-size:14px;"></div>
							</div>
							<div class="row">
								<div class="col" id="opacity2box" style="opacity: 0.4;"></div>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<button type="button" onclick="getHotelContentModal()" class="btn btn-outline-dark text-dark fw-semibold" style="border-radius:15px; font-size:14px;">더보기</button>
						</div>
					</div>
				</div>
				<div class="col-6">
					<div class="row">
						<div class="col fw-semibold"  style="font-size:18px;">
						보건 & 안전
						</div>
					</div>
					<div class="row mt-3">
						<div class="col fw-normal" style="font-size:14px;">
							청결 및 안전<br>
							* 계절에 따라 운영되는 수영장은 4월 ~ 10월에 오픈합니다.
							* 수영장 이용 시간은 정오 ~ 20:00입니다.
							* 마사지 서비스 및 스파 트리트먼트의 경우 사전 예약이 필요합니다. 예약 확인 메일에 나와 있는 연락처 정보로 도착 전에 호텔에 연락하여 예약하실 수 있습니다.
							* 만 2 세 이하 어린이 1명은 부모나 보호자와 같은 객실에서 침구를 추가하지 않고 이용할 경우 무료로 숙박할 수 있습니다.
							<br>
							청소 & 소독<br>
							숙박 시설에서 현재 강화된 청소 조치 시행 안 함
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-3"></div>
	 </div>
	 <div class="row mt-5">
	 	<div class="col-3"></div>
	 	<div class="col  fw-semibold"  style="font-size:18px;">이용자 후기</div>
	 	<div class="col-3"></div>
	 </div>
	  <div class="row mt-2">
	 	<div class="col-3"></div>
	 	<div class="col ms-3" style="background-color:  rgb(248, 249, 250)">
			<div class="row">
				<div class="col-4 text-center ms-5">
					<div class="row">
						<div class="col fw-semibold fs-1 pt-4" id="reviewStarCount">
								
						</div>
					</div>
					<div class="row">
						<div class="col review-star pt-1 pb-4" id="reviewTotalStar">
							
						</div>
					</div>
				</div>
				<div class="col-1 my-4 border-end">
					
				</div>
				<div  class="col-1"></div>
				<div class="col small text-secondary py-4 ">
					<div class="row">
						<div class="col-3 pe-1 text-end" style="font-size:13px;">★★★★★</div>
						<div class="col" style="padding-top: 10px;">
							<div class="progress" style="height: 5px;">
							  <div id="start5Pro" class="progress-bar bg-secondary" role="progressbar" aria-label="Example 1px high" style="width: 0%;" aria-valuenow="7" aria-valuemin="0" aria-valuemax="20"></div>
							</div>
						</div>
						<div class="col-3" id="starCount5">0명</div>
					</div>
					<div class="row">
						<div class="col-3 pe-1 text-end" style="font-size:13px;">★★★★</div>
						<div class="col" style="padding-top: 10px;">
							<div class="progress" style="height: 5px;">
							  <div id="start4Pro" class="progress-bar bg-secondary" role="progressbar" aria-label="Example 1px high" style="width: 0%;" aria-valuenow="2" aria-valuemin="0" aria-valuemax="20"></div>
							</div>
						</div>
						<div class="col-3" id="starCount4">0명</div>
					</div>
					<div class="row">
						<div class="col-3 pe-1 text-end" style="font-size:13px;">★★★</div>
						<div class="col" style="padding-top: 10px;">
							<div class="progress" style="height: 5px;">
							  <div id="start3Pro" class="progress-bar bg-secondary" role="progressbar" aria-label="Example 1px high" style="width:0%;" aria-valuenow="3" aria-valuemin="0" aria-valuemax="20"></div>
							</div>
						</div>
						<div class="col-3" id="starCount3">0명</div>
					</div>
					<div class="row">
						<div class="col-3 pe-1 text-end" style="font-size:13px;">★★</div>
						<div class="col" style="padding-top: 10px;">
							<div class="progress" style="height: 5px;">
							  <div  id="start2Pro" class="progress-bar bg-secondary" role="progressbar" aria-label="Example 1px high" style="width:0%;" aria-valuenow="4" aria-valuemin="0" aria-valuemax="20"></div>
							</div>
						</div>
						<div class="col-3" id="starCount2">0명</div>
					</div>
					<div class="row">
						<div class="col-3 pe-1 text-end" style="font-size:13px;">★</div>
						<div class="col" style="padding-top: 10px;">
							<div class="progress" style="height: 5px;">
							  <div  id="start1Pro" class="progress-bar bg-secondary" role="progressbar" aria-label="Example 1px high" style="width: 0%;" aria-valuenow="5" aria-valuemin="0" aria-valuemax="20"></div>
							</div>
						</div>
						<div class="col-3" id="starCount1">0명</div>
					</div>
				</div>
			</div>
		</div>
	 	<div class="col-3"></div>
	 </div>
	  <div class="row mt-2">
	 	<div class="col-3"></div>
	 	<div class="col" id="img1Box">
			<img src="../resources/img/reviewCan.jpg" style="width:950px;">
		</div>
	 	<div class="col-3"></div>
	 </div>
	 <div class="row mt-2">
	 	<div class="col-3"></div>
	 	<div class="col">
			<div class="row">
				<div class="col" id="reviewBox">
	 				
	 				
				</div>
			</div>
		</div>
	 	<div class="col-3">
	 	</div>
	 </div>
	 <div class="row mt-5 mb-5">
	 <div class="col-3">
	 	</div>
	 	<div class="col-6 px-0" id="img2Box">
	 		<img src="../resources/img/hotelInfoCan3.jpg" class="img-fluid">
	 	 </div>
	 	 <div class="col-3">
	 	</div>
	 </div>
	 
</div>


<!-- 사진 모달 -->
<div class="modal fade modal-lg" id="getImageModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content bg-dark">
      <div class="modal-body p-0">
       	<div id="groupCarousel" class="carousel slide">
       	<div class="row">
		  <div class="carousel-inner" id="totalImageBox">
		  </div>
		</div>

		  <button class="carousel-control-prev" type="button" data-bs-target="#groupCarousel" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#groupCarousel" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
		

      </div>
    </div>
  </div>
</div> 



<!-- 그룹사진 모달 -->
<div class="modal fade modal-lg" id="groupImageModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content bg-dark">
      <div class="modal-body p-0">
       	<div id="carouselExample" class="carousel slide">
       	<div class="row">
		  <div class="carousel-inner" id="groupImageBox">
		  </div>
		</div>

		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
		

      </div>
    </div>
  </div>
</div> 


<!-- 날짜모달 -->
<div class="modal" tabindex="-1" id="dateModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content"    style="border-radius: 15px;">
      <div class="modal-header">
        <h5 class="modal-title fw-semibold">일정 변경</h5>
        <i class="bi bi-x fs-4" data-bs-dismiss="modal" aria-label="Close"></i>
      </div>
      <div class="modal-body">
        <div class="row mb-3 fw-semibold border-bottom pb-2 text-center">
														<div class="col text-danger" style="margin-left:12px;">일</div>
														<div class="col">월</div>
														<div class="col">화</div>
														<div class="col">수</div>
														<div class="col">목</div>
														<div class="col">금</div>
														<div class="col text-primary" style="margin-right:26px;">토</div>
													</div>
													<div class="row date-container" id="dates" style ="width:450px; height:480px; margin:0px 0px 0px 0px;">
														
													</div>
													<div class="row border-top pt-2">
														<div class="col-7 ps-5 fw-semibold pt-3"  onclick="resetDates()" style="font-size:18px;">
															<i class="bi bi-arrow-counterclockwise"></i>초기화
														</div>
														<div class="col pt-1"><button id="dateButton" type="button" disabled class="btn btn-dark btn-lg" style="border-radius:20px" onclick="getDateButton()">일정 적용</button></div>
														<div class="col-1"></div>
													</div>
      </div>
    </div>
  </div>
</div>

<!-- 숙소정보모달 -->
<div class="modal" tabindex="-1" id="hotelContentModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius: 15px;">
      <div class="modal-header border-white">
        <h5 class="modal-title fw-semibold">숙소 정보</h5>
        <i class="bi bi-x fs-4" data-bs-dismiss="modal" aria-label="Close"></i>
      </div>
      <div class="modal-body">
			<div class="row date-container" id="modalContentBox"  style ="width:450px; height:480px; margin:0px 0px 0px 0px;">
			<img src="../resources/img/hotelContent2.jpg">
				
			</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8a1d90f3a65f2e8f2e4e69aac5b93be&libraries=services"></script> 
<script>


</script>
<jsp:include page="../common/footer.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>