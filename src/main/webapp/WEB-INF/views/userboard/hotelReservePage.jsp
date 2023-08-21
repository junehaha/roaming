<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#paymentInfo {
  position: fixed;
  top: 100px;
  right: 250px;
  transition: top 0.3s ease;
}
</style>
<script>

function handleCheckboxChange(checkbox,name,price) { // 체크박스 핸들러
     if (checkbox.checked) {
       addPlusOption(name,price);
     } else {
       removeOption(name);
     }
}


function addPlusOption(name,price){   // 옵션추가
   const buyInfoBox = document.getElementById("buyInfoBox");
   const row = document.createElement("div");
   row.id = name;
   row.classList.add("row"); // name넣어서 식별되게
   buyInfoBox.appendChild(row);
   
   const nameCol = document.createElement("div");
   nameCol.classList.add("col","small","text-secondary");
   nameCol.innerText = name;
   row.appendChild(nameCol);
   
   const priceCol = document.createElement("div");
   priceCol.classList.add("col","small","text-secondary","text-end","buyPrice");
   priceCol.innerText = price.toLocaleString() + "원";
   row.appendChild(priceCol);
   totalPrice();
}
function removeOption(name){ // 옵션제거
   const row = document.getElementById(name);
   row.remove();
   totalPrice();
}

let finalprice = parseInt(new URLSearchParams(location.search).get("firstPrice"));
function priceSetting(){
   const oriPriceBox = document.getElementById("oriPriceBox");
   const buyOriPriceBox = document.getElementById("buyOriPrice");
   const totalPrice = document.getElementById("totalPrice");
   oriPriceBox.innerText = finalprice.toLocaleString() +"원";
   buyOriPriceBox.innerText = finalprice.toLocaleString() +"원";
   totalPrice.innerText = finalprice.toLocaleString()+"원";
}

function totalPrice(){
   finalprice = 0

   const totalPrice = document.getElementById("totalPrice");
   const totalPriceButton = document.getElementById("totalPriceButton");
   const buyPrices = document.getElementsByClassName("buyPrice");
   var price = 0;
   for(var i=0; i<buyPrices.length; i++){
      const str = buyPrices[i].innerText;
      price += parseFloat(str.replace(/[^0-9.-]/g, ""));
   }
   finalprice += price;
   
   totalPrice.innerText = price.toLocaleString() + "원";
   totalPriceButton.innerText = price.toLocaleString() + "원";
   
}

function kakaoReady(){
   const xhr = new XMLHttpRequest();
   const startDate = '${startDate}';
   const endDate = '${endDate}';
   
   const cid = "TC0ONETIME";
   const partner_order_id = ${info.roomGroupDto.id};
   const partner_user_id = ${sessionUser.id};
   const item_name = '${info.roomGroupDto.room_group_name}';
   const quantity = 1;
   const total_amount= finalprice;
   const tax_free_amount=finalprice;
   const approval_url= 'http://172.30.1.80:8181/roaming/userboard/reserveSuccessPage';
   const cancel_url = "http://172.30.1.80:8181/roaming/userboard/reserveCancelPage?hotel_id="+${info.roomGroupDto.hotel_id};
   const fail_url = 'http://172.30.1.80:8181/roaming/userboard/reserveFailPage?hotel_id='+${info.roomGroupDto.hotel_id};
   
   const coupon = document.getElementById("coupon")
   const couponId = coupon.value;
   const checkBoxes = document.getElementsByClassName("checkBox");
   const option_id = [];
   
   for (var i = 0; i < checkBoxes.length; i++) {
       if (checkBoxes[i].checked) {
          option_id.push(checkBoxes[i].value);
       }
   }
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response = JSON.parse(xhr.responseText);
         const dataObject = {
               tid : response.tid,
               partner_order_id:partner_order_id,
               partner_user_id:partner_user_id,
               startDate : '${startDate}',
               endDate : '${endDate}',
               option_id : option_id.join(',')
         };         
         
         console.log(dataObject);
         goToServer(dataObject);
         goToPage(response.next_redirect_pc_url);
         if(couponId != 0){
            useCouponProcess();
         }
         const usePointValue = parseInt(usePointNumber)
         if(usePointValue != 0){
            usePointProcess();
         }
      }
   }
   
   xhr.open("post","https://kapi.kakao.com/v1/payment/ready");
   xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded;charset=utf-8");
   xhr.setRequestHeader("Authorization","KakaoAK 90fac6acb3ba81cf44b6673ca5a2ec06");
   xhr.send("cid="+cid+"&partner_order_id="+partner_order_id+"&partner_user_id="+partner_user_id+"&item_name="+item_name+"&quantity="+quantity+"&total_amount="+total_amount+"&tax_free_amount="+tax_free_amount+"&approval_url="+approval_url+"&cancel_url="+cancel_url+"&fail_url="+fail_url+"&item_code="+couponId);
}

function goToServer(data){
   const xhr = new XMLHttpRequest();
   
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response = JSON.parse(xhr.responseText);
      }
   }
   xhr.open("post","./goToServer");
   xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xhr.send("tid="+data.tid+"&partner_order_id="+data.partner_order_id+"&partner_user_id="+data.partner_user_id+"&startDate="+data.startDate+"&endDate="+data.endDate+"&option_id="+data.option_id);
}

function goToPage(url) {
     var width = 800;
     var height = 800;
     var left = (window.innerWidth - width) / 2;  // 창의 가로 위치를 가운데로 설정
     var top = (window.innerHeight - height) / 2;  // 창의 세로 위치를 가운데로 설정
     var options = 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top;
     window.open(url,'결제성공',options);   
   }
   
function navigateToOtherPage() {
     window.location.href = "./successReserveInfoPage"; // 다른 페이지로 이동
}
var couponId = 0;

function getCouponDisCount(){
   const xhr= new XMLHttpRequest();
   const selectedCouponId = document.getElementById("coupon").value;
   if(selectedCouponId == 0){
      const coupon = document.getElementById("usecoupon");
      coupon.remove();
      totalPrice();
      return;
   }
   const beforeCoupon = document.getElementById("usecoupon");
   if(beforeCoupon){
      beforeCoupon.remove();
      totalPrice();
   }
   couponId = parseInt(selectedCouponId)
   xhr.onreadystatechange = function(){
      if(xhr.readyState==4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         
         const row = document.createElement("div");
         row.classList.add("row");
         row.id= "usecoupon"
         buyInfoBox.appendChild(row);
         
         const nameCol = document.createElement("div");
         nameCol.classList.add("col","small","text-secondary");
         nameCol.innerText = "쿠폰 사용";
         row.appendChild(nameCol);
         
         const priceCol = document.createElement("div");
         priceCol.classList.add("col","small","text-secondary","text-end","buyPrice");
         var couponUsePrice = parseInt(new URLSearchParams(location.search).get("firstPrice")) * (response.disCount/100);
      
         console.log(couponUsePrice)
         priceCol.innerText = (couponUsePrice * -1).toLocaleString() + "원";
         row.appendChild(priceCol);
         totalPrice();
      }
   }
   xhr.open("get","./getCouptonInfo?id="+selectedCouponId);
   xhr.send();
}

function useCouponProcess(){
   const xhr= new XMLHttpRequest();
   xhr.onreadystatechange=function(){
      if(xhr.readyState==4&&xhr.status==200){
         const response= JSON.parse(xhr.responseText);
      }
   }
   xhr.open("get","./useCouponProcess?id="+couponId);
   xhr.send();
}

var usePointNumber = 0;

function usePoint(){
   const pointInput = document.getElementById("pointInput");
   if(pointInput.value > ${point.myPoint}){
      alert("포인트 한도 내에서 사용해주세요.")
      if (${point.myPoint} > parseInt(new URLSearchParams(location.search).get("firstPrice")) / 10) {
        var maxPointPrice = parseInt(new URLSearchParams(location.search).get("firstPrice")) / 10;
        pointInput.value =  parseInt(maxPointPrice);
      } else {
        var maxPointPrice = ${point.myPoint};
        pointInput.value =  parseInt(maxPointPrice);
      }
      usePoint()
      return;
   }
   
   if(pointInput.value > parseInt(new URLSearchParams(location.search).get("firstPrice")) / 10){
      alert("포인트 한도 내에서 사용해주세요.")
      if (${point.myPoint} > parseInt(new URLSearchParams(location.search).get("firstPrice")) / 10) {
           var maxPointPrice = parseInt(new URLSearchParams(location.search).get("firstPrice")) / 10;
           pointInput.value =  parseInt(maxPointPrice);
         } else {
           var maxPointPrice = ${point.myPoint};
           pointInput.value =  parseInt(maxPointPrice);
         }
         usePoint()
         return;
      
   }
   const pointRow =document.getElementById("point");
   if(pointRow){
      pointRow.remove();
   }
   if(pointRow){
      if(pointInput.value == 0){
         pointRow.remove();
      }      
   }
   const row = document.createElement("div");
   row.classList.add("row");
   row.id= "point"
   buyInfoBox.appendChild(row);
   
   const nameCol = document.createElement("div");
   nameCol.classList.add("col","small","text-secondary");
   nameCol.innerText = "포인트";
   row.appendChild(nameCol);
   
   const priceCol = document.createElement("div");
   priceCol.classList.add("col","small","text-secondary","text-end","buyPrice");
   priceCol.innerText = (pointInput.value * -1).toLocaleString() + "원";
   row.appendChild(priceCol);
   usePointNumber = pointInput.value
   totalPrice();
   
}
function maxPoint(){
   const pointRow =document.getElementById("point");
   if(pointRow){
      pointRow.remove();
   }
   
   const row = document.createElement("div");
   row.classList.add("row");
   row.id= "point"
   buyInfoBox.appendChild(row);
   
   const nameCol = document.createElement("div");
   nameCol.classList.add("col","small","text-secondary");
   nameCol.innerText = "포인트";
   row.appendChild(nameCol);
   
   const priceCol = document.createElement("div");
   priceCol.classList.add("col","small","text-secondary","text-end","buyPrice");
   if (${point.myPoint} > parseInt(new URLSearchParams(location.search).get("firstPrice")) / 10) {
        var maxPointPrice = parseInt(new URLSearchParams(location.search).get("firstPrice")) / 10;
      } else {
        var maxPointPrice = ${point.myPoint};
      }

      const pointInput = document.getElementById("pointInput");
      pointInput.value =  parseInt(maxPointPrice);

      // 소수점 이하를 버리고 정수 부분만 얻기 위해 parseInt() 사용
      const integerPart = parseInt(maxPointPrice);

      // 세 자릿수마다 쉼표를 사용하여 표시하기 위해 toLocaleString() 사용
      priceCol.innerText = (integerPart * -1).toLocaleString() + "원";
   row.appendChild(priceCol);
   usePointNumber = pointInput.value
   totalPrice();
}
function usePointProcess(){
   const usePointValue = parseInt(usePointNumber)
   const xhr=  new XMLHttpRequest();
   xhr.onreadystatechange=function(){          
      if(xhr.readyState==4 && xhr.status ==200){
         const response =JSON.parse(xhr.responseText);
      }
   }
   xhr.open("get","./usePointProcess?usePoint="+usePointValue);
   xhr.send();
   
}
window.addEventListener("DOMContentLoaded",function(){
    priceSetting()
});
</script>
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
         <jsp:include page="../common/topNavi.jsp"></jsp:include>

<div class="container-fluid">

   <div class="row mt-5">
      <div class="col-2"></div>
      <div class="col-5">
         <div class="row">
            <div class="col fw-semibold fs-2">
               예약하기
            </div>
         </div>
         <div class="row mt-5 border-bottom pb-3">
            <div class="col fw-semibold fs-4">
               상품정보
            </div>
         </div>
         <div class="row mt-4"><!-- 호텔명 , 사진, 예약날짜 -->
            <div class="col-2 pe-0"><!-- 호텔사진 -->
               <img src="/uploadFiles/${info.roomGroupDto.room_group_img}"  width=100px; height=100px; >
            </div>
            <div class="col  ps-0">
               <div class="row"> <!--호텔명 -->
                  <div class="col fw-semibold fs-6">
                     ${info.roomGroupDto.room_group_name}
                  </div>
               </div>
               <div class="row"><!-- 예약날짜 -->
                  <div class="col text-secondary fs-6">
                      ${startDate} 15시 00분부터 ~ ${endDate} 11시 00분까지, 1박
                  </div>
               </div>
            </div>
         </div>
         <div class="row mt-3 border-bottom pb-3"><!--추옵 전 금액 알려줌 -->
            <div class="col text-secondary fs-6"> 
                상품 금액
            </div>
            <div class="col text-end fw-semibold fs-5" id="oriPriceBox">
               
            </div>
         </div>
         <div class="row mt-5"> <!-- 추옵 -->
            <div class="col fw-semibold fs-5">추가옵션</div>
         </div>
         <div class="row mt-1 border-bottom pb-4">
            <div class="col">
            <c:forEach items="${info.plusOption}" var="plusOption">
               <div class="row mt-1">
                  <div class="col">
                     <input type="checkbox" class="checkBox" onchange="handleCheckboxChange(this,'${plusOption.plus_option}',${plusOption.price})" value="${plusOption.id}" name="option_id"> ${plusOption.plus_option} +<fmt:formatNumber value="${plusOption.price}" pattern="#,###" var="formattedPrice" />
                          ${formattedPrice}원
                  </div>
               </div>
             </c:forEach>
            </div>
         </div>
         <div class="row mt-4"> <!-- 쿠폰 포인트-->
            <div class="col fw-semibold fs-5">
               쿠폰 / 포인트 할인
            </div>
         </div>
         <div class="row mt-3"> <!-- 쿠폰-->
            <div class="col fw-semibold fs-6">
               쿠폰 할인
            </div>
         </div>
         <div class="row mt-2">
            <div class="col-5">
               <select class="form-select form-select-lg mb-3 fs-6" aria-label=".form-select-lg example"  id="coupon" onchange="getCouponDisCount()">
                 <option selected value="0">사용 가능 쿠폰 ${useAbleCouponCount}개</option>
                 <c:forEach items="${couponList}" var="coupon">
                       <option value="${coupon.id}">${coupon.coupon_name} / ${coupon.coupon_discount}%</option>
                 </c:forEach>
               </select>
            </div>
         </div>
         <div class="row mt-3 border-bottom pb-4"> <!-- 포인트 -->
            <div class="col">
               <div class="row">
                  <div class="col fw-semibold fs-6">
                     내 포인트  <span class="text-danger"> <fmt:formatNumber value="${point.myPoint}" pattern="#,###" var="formattedPrice" />
                          ${formattedPrice}원</span>
                          <span class="text-secondary ms-2 small">최대 숙소 금액의 10% 사용가능</span>
                  </div>
               </div>
               <div class="row">
                  <div class="col-5">
                     <input type="number" class="form-control text-end" onchange="usePoint()" placeholder="0원"  aria-describedby="basic-addon1" id="pointInput">
                  </div>
                  <div class="col-2 ps-0">
                     <button type="button" class="btn btn-outline-secondary" onclick="maxPoint()">최대 사용</button>
                  </div>
               </div>
            </div>
         </div>
         <div class="row mt-5"> <!-- 예약자 -->
            <div class="col  fw-semibold fs-5">
               예약자 정보
            </div>
         </div>
         <div class="row mt-3 border-bottom pb-4">
            <div class="col-5">
            <div class="card">
              <div class="card-body">
                   <div class="row">
                      <div class="col fw-semibold small">
                         ${sessionUser.user_name}
                      </div>
                   </div>
                   <div class="row">
                      <div class="col small">
                         ${sessionUser.email}
                      </div>
                   </div>
                   <div class="row">
                      <div class="col small">
                         ${sessionUser.phone_number}
                      </div>
                   </div>
              </div>
            </div>
            </div>
         </div>
         <div class="row mt-5"> <!-- 결제수단 -->
            <div class="col fw-semibold fs-5">
               결제수단
            </div>
         </div>
         <div class="row mt-4 mb-5">
            <div class="col">
               <div class="row">
                  <div class="col form-check">
                       <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
                       <label class="form-check-label" for="flexRadioDefault2">
                         카카오페이
                       </label>
                       <img src="../resources/img/kakaopay.jpg">
                  </div>
               </div>
               <div class="row mt-1">
                  <div class="col form-check">
                      <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
                       <label class="form-check-label" for="flexRadioDefault1">
                         토스페이
                       </label>
                       <img src="../resources/img/toss.jpg">
                  </div>
               </div>
                  <div class="row  mt-1">
                  <div class="col form-check">
                       <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" >
                       <label class="form-check-label" for="flexRadioDefault2">
                         네이버페이
                       </label>
                       <img src="../resources/img/naverpay.jpg">
                  </div>
               </div>
                  <div class="row  mt-1 mb-5">
                  <div class="col form-check">
                       <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" >
                       <label class="form-check-label" for="flexRadioDefault2">
                         페이코
                       </label>
                       <img src="../resources/img/payco.jpg">
                  </div>
               </div>
            </div>

         </div>
      </div>
      <div class="col-3  ps-4 mt-5" id="paymentInfo"><!-- 결제정보 -->
         <div class="card">
           <div class="card-body">
             <div class="row ms-1  me-1 mt-2 border-bottom pb-2">
               <div class="col fw-semibold fs-5">
                  결제정보
               </div>
            </div>
            <div class="row mt-3 ms-1  me-1 border-bottom pb-2">
               <div class="col" id="buyInfoBox">
                  <div class="row">
                     <div class="col small text-secondary">
                        주문금액
                     </div>
                     <div class="col small text-secondary text-end buyPrice" id="buyOriPrice">
                        
                     </div>
                  </div>
               </div>
               
            </div>
            <div class="row mt-3 ms-1  me-1">
               <div class="col text-primary fw-semibold pt-2">
                  총 결제금액
               </div>
               <div class="col text-primary fs-3 text-end fw-semibold">
                  <span class="text-primary fs-3 text-end fw-semibold" id="totalPrice">
                               </span>
               </div>
            </div>
            <div class="row mt-3 ms-1  me-1">
               <div class="col d-grid">
                  <button class="btn btn-primary small" onclick="kakaoReady()"><span class="small" id="totalPriceButton">
                              </span> 결제하기</button>
               </div>
            </div>
           </div>
         </div>
      </div>
      <div class="col-2"></div>
      
   </div>

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
</div>



<jsp:include page="../common/footer.jsp"></jsp:include>


<script>
const paymentInfo = document.getElementById('paymentInfo');
const paymentInfoOffsetTop = paymentInfo.offsetTop;
let previousScrollPosition = window.pageYOffset;
let isScrollingUp = false;

window.addEventListener('scroll', function() {
  const currentScrollPosition = window.pageYOffset;

  if (currentScrollPosition > paymentInfoOffsetTop) {
    if (currentScrollPosition > previousScrollPosition) {
      isScrollingUp = false;
    } else {
      isScrollingUp = true;
    }

    if (isScrollingUp) {
      paymentInfo.style.top = '100px';
    } else {
      paymentInfo.style.top = (currentScrollPosition - paymentInfoOffsetTop) + 'px';
    }
  } else {
    paymentInfo.style.top = '100px';
  }

  previousScrollPosition = currentScrollPosition;
});


</script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>