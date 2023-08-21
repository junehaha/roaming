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

function getReserveList(number){ // 1이면 예정 2면 이전
   const xhr = new XMLHttpRequest();
   const listBox = document.getElementById("listBox");
   
   listBox.innerHTML = "";

   xhr.onreadystatechange = function(){
      if(xhr.readyState==4 && xhr.status ==200){
         const response = JSON.parse(xhr.responseText);
         if(response.result == "success"){
            for(list of response.list){
               const row1 = document.createElement("div");
               row1.classList.add("row","mt-4","border-bottom","pb-2");
               listBox.appendChild(row1);
               
               const imgcol = document.createElement("div");
               imgcol.classList.add("col-2","pe-0");
               row1.appendChild(imgcol);
               
               const imgLink = document.createElement("a");
               imgLink.href = "./hotelInfoPage?id="+list.hotelDto.id+"&startDate="+startDay+"&endDate="+endDay+"&people="+2+"&days="+weekDays;
                     
               const img = document.createElement("img");
               img.src = "/uploadFiles/" +list.roomGroupDto.room_group_img;
               img.style.width= "130px";
               img.style.height= "130px";
               imgLink.appendChild(img);
               
               imgcol.appendChild(imgLink);
               
               const infocol = document.createElement("div");
               infocol.classList.add("col","ps-0");
               row1.appendChild(infocol);
               
               const namerow = document.createElement("div");
               namerow.classList.add('row');
               infocol.appendChild(namerow);
               
               const namecol = document.createElement("div");
               namecol.classList.add("col","fw-semibold","fs-6");
               namecol.innerText = list.hotelDto.hotel_name + "("+list.roomGroupDto.room_group_name+")";
               namerow.appendChild(namecol);
               if(number==2 && list.reviewCount == 0){
                  const reviewCol = document.createElement("div");
                  reviewCol.classList.add("col","text-end");
                  reviewCol.style.marginBottom = "-10px";
                  namerow.appendChild(reviewCol);
                  
                  const reviewButton = document.createElement("button");
                  reviewButton.classList.add("btn","btn-light","text-dark","small");
                  reviewButton.innerText = "리뷰작성";
                  reviewButton.setAttribute("onclick","reviewModal("+list.reserveDto.id+")")
                  reviewCol.appendChild(reviewButton);
               }
               const reserveRow = document.createElement("div");
               reserveRow.classList.add("row");
               infocol.appendChild(reserveRow);
               
               const reserveCol = document.createElement("div");
               reserveCol.classList.add("col","text-secondary","fs-6");
               
               const startday = new Date(list.reserveDto.start_date);
               const endday = new Date(list.reserveDto.end_date);
               
               var monthNames = [
                    "01", "02", "03", "04", "05", "06",
                    "07", "08", "09", "10", "11", "12"
                  ];

               var dayNames = [
                    "일", "월", "화", "수", "목", "금", "토"
                  ];
               
               var smonth = monthNames[startday.getMonth()];
               var sday = startday.getDate().toString().padStart(2, '0');
               var sdayOfWeek = dayNames[startday.getDay()];
               var syear = startday.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

               var emonth = monthNames[endday.getMonth()];
               var eday =  endday.getDate().toString().padStart(2, '0');
               var edayOfWeek = dayNames[endday.getDay()];
               var eyear = endday.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

               var start = syear + "/" + smonth + "/" + sday + "/(" + sdayOfWeek + ")";
               var end = eyear + "/" + emonth + "/" + eday + "/(" + edayOfWeek + ")";
               
               reserveCol.innerText = start + " 15시 00분 ~ " + end + " 11시 00분";
               reserveRow.appendChild(reserveCol);
               
               const optionHeader = document.createElement("div");
               optionHeader.classList.add("row","mt-1");
               infocol.appendChild(optionHeader);
               
               if(list.plusList.length != 0){
                  const optionHeadercol = document.createElement("div");
                  optionHeadercol.classList.add("col","fw-semibold","small","text-primary");
                  optionHeader.appendChild(optionHeadercol);
                  optionHeadercol.innerText = "추가옵션"
                  const optionRow = document.createElement("div");
                  optionRow.classList.add("row");
                  infocol.appendChild(optionRow);
                  const optionCol = document.createElement("div");
                  optionCol.classList.add("col-9","small");
                  optionRow.appendChild(optionCol)
                  for(option of list.plusList){
                  
                     const optionSpan =document.createElement("span");
                     optionSpan.classList.add("me-2");
                     optionSpan.style.fontSize = "12px";
                     const price = option.price;
                     optionSpan.innerText = option.plus_option + "("+price.toLocaleString()+")";
                     optionCol.appendChild(optionSpan);
                  }
                  
               }else{
                  const optionHeadercol = document.createElement("div");
                  optionHeadercol.classList.add("col","fw-semibold","small","text-white");
                  optionHeader.appendChild(optionHeadercol);
                  optionHeadercol.innerText = "추가옵션"
                  const optionRow = document.createElement("div");
                  optionRow.classList.add("row");
                  infocol.appendChild(optionRow);
                  const optionCol = document.createElement("div");
                  optionCol.classList.add("col-9","small");
                  optionRow.appendChild(optionCol)
                  
                  
                  const optionSpan =document.createElement("span");
                  optionSpan.classList.add("me-2","text-white");
                  optionSpan.style.fontSize = "12px";
                  optionSpan.innerText ="없음"
                  optionCol.appendChild(optionSpan);
                  
               }
               
               const priceRow = document.createElement("div");
               priceRow.classList.add("row","mt-2","pb-2");
               infocol.appendChild(priceRow);
               
               const priceTextCol = document.createElement("div");
               priceTextCol.classList.add("col","fw-semibold");
               if(list.reserveDto.status == "취소"){
                  priceTextCol.innerText = "결제 취소";
                  priceTextCol.classList.add("col","fw-semibold","text-danger");
               }else{
                  priceTextCol.innerText = "결제 금액";
               }
               priceTextCol.style.fontSize = "18px";
               priceRow.appendChild(priceTextCol);
               
               const priceCol = document.createElement("div");
               priceCol.classList.add("col","text-end","fw-semibold");
               const fprice = list.reserveDto.final_price;
               priceCol.innerText = fprice.toLocaleString() +"원";
               priceCol.style.fontSize = "18px";
               priceRow.appendChild(priceCol);
               
            }
         }else{
            const row = document.createElement("div");
            row.classList.add("row","mt-5","mb-5");
            listBox.appendChild(row);
            
            const col =document.createElement("div");
            col.classList.add("col","text-center","mt-5","mb-5","text-secondary","fs-2");
            row.appendChild(col);
            col.innerText = "예약 내역이 없습니다.";
         }
      }
   }
   xhr.open("get","./getReserveList?filter="+number);
   xhr.send();
}
function reviewModal(reserveId){
   const modal = bootstrap.Modal.getOrCreateInstance("#reviewModal");
   const writeButton= document.getElementById("writeButton");
   writeButton.setAttribute("onclick","writeReviewProcess("+reserveId+")");
   const starBox = document.getElementById("starBox");
   starBox.innerHTML="";
   for(var i=1; i<6; i++){
      const itag = document.createElement("i");
      itag.classList.add("bi","bi-star","fs-1");
      itag.setAttribute("onmouseover","getStarCount("+i+")");
      itag.id ="star"+i;
      starBox.appendChild(itag);
   }
   
   
   
   modal.show();
}

let starCount = 1;

function getStarCount(count){
   const star1 = document.getElementById("star1");
   const star2 = document.getElementById("star2");
   const star3 = document.getElementById("star3");
   const star4 = document.getElementById("star4");
   const star5 = document.getElementById("star5");
   
   starCount = count;
   
   if(count == 1){
      star1.classList.remove("bi-star");
      star1.classList.add("bi-star-fill");
      
      star2.classList.remove("bi-star-fill");
      star2.classList.add("bi-star");
      
      star3.classList.remove("bi-star-fill");
      star3.classList.add("bi-star");
      
      star4.classList.remove("bi-star-fill");
      star4.classList.add("bi-star");
      
      star5.classList.remove("bi-star-fill");
      star5.classList.add("bi-star");
   }else if(count == 2){
      star1.classList.remove("bi-star");
      star1.classList.add("bi-star-fill");
      
      star2.classList.remove("bi-star");
      star2.classList.add("bi-star-fill");
      
      star3.classList.remove("bi-star-fill");
      star3.classList.add("bi-star");
      
      star4.classList.remove("bi-star-fill");
      star4.classList.add("bi-star");
      
      star5.classList.remove("bi-star-fill");
      star5.classList.add("bi-star");
   }else if(count == 3){
      star1.classList.remove("bi-star");
      star1.classList.add("bi-star-fill");
      
      star2.classList.remove("bi-star");
      star2.classList.add("bi-star-fill");
      
      star3.classList.remove("bi-star");
      star3.classList.add("bi-star-fill");
      
      star4.classList.remove("bi-star-fill");
      star4.classList.add("bi-star");
      
      star5.classList.remove("bi-star-fill");
      star5.classList.add("bi-star");
   }else if(count==4){
      star1.classList.remove("bi-star");
      star1.classList.add("bi-star-fill");
      
      star2.classList.remove("bi-star");
      star2.classList.add("bi-star-fill");
      
      star3.classList.remove("bi-star");
      star3.classList.add("bi-star-fill");
      
      star4.classList.remove("bi-star");
      star4.classList.add("bi-star-fill");
      
      star5.classList.remove("bi-star-fill");
      star5.classList.add("bi-star");
   }else{
      star1.classList.remove("bi-star");
      star1.classList.add("bi-star-fill");
      
      star2.classList.remove("bi-star");
      star2.classList.add("bi-star-fill");
      
      star3.classList.remove("bi-star");
      star3.classList.add("bi-star-fill");
      
      star4.classList.remove("bi-star");
      star4.classList.add("bi-star-fill");
      
      star5.classList.remove("bi-star");
      star5.classList.add("bi-star-fill");
   }
   
}

function writeReviewProcess(reserveId){
   const modal = bootstrap.Modal.getOrCreateInstance("#reviewModal");
   
   const contentInput = document.getElementById("content");
   const fileInput = document.getElementById("file");
   
   const content = contentInput.value;
   const file = fileInput.files[0];
   
   const xhr = new XMLHttpRequest();
   var formData = new FormData();
   formData.append("file",file);
   formData.append("content",content);
   formData.append("reserve_id",reserveId);
   formData.append("star",starCount);
   xhr.open("post","./writeReviewProcess");
   xhr.onreadystatechange =  function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response = JSON.parse(xhr.responseText);
         modal.hide();
         getReserveList(2);
         
      }
   }

   xhr.send(formData)
}
window.addEventListener("DOMContentLoaded",function(){
   getUserId();
   getReserveList(2);
   
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
                           <a href="./hotelBeforeReservePage" style="font-size: 15px; color: #0078ff; text-decoration: none;">
                     <p>지난 예약</p>    
                     </a>
                            <a href="./likeHotelListPage" style="font-size: 15px; color: gray; text-decoration: none;">
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
                            <div class="col" id="listBox">
                           
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
      
      <!-- 리뷰 모달 -->
<div class="modal fade modal-lg" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">리뷰</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="row mt-2">
             <div class="col-2"></div>
             <div class="col">
                <div class="row">
                   <div class="col text-center" id="starBox">
                      <i class="bi bi-star fs-1" onclick="getStarCount(1)" id="star1"></i><i class="bi bi-star fs-1" onclick="getStarCount(2)"  id="star2"></i><i class="bi bi-star fs-1" onclick="getStarCount(3)"  id="star3"></i><i class="bi bi-star fs-1" onclick="getStarCount(4)"  id="star4"></i><i class="bi bi-star fs-1" onclick="getStarCount(5)"  id="star5"></i>
                   </div>
                </div>
                <div class="row">
                   <div class="col">
                    <textarea class="form-control"  rows="6" placeholder="리뷰를 작성해주세요" id="content"></textarea>
                   </div>
                </div>
                <div class="row mt-3">
                   <div class="col">리뷰사진</div>
                </div>
                <div class="row mt-1">
                   <div class="col">
                       <input type="file" class="form-control" id="file">
                   </div>
                </div>
             </div>
             <div class="col-2"></div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="writeButton">작성</button>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>