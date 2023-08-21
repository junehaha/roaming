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
<title>상품 상세 페이지</title>
<style>
#inputQuantity {
    width: 3rem; /* 너비를 4rem으로 설정 */
    max-width: 3rem; /* 최대 너비도 4rem으로 설정 */
    border-radius: 0; /* 모서리를 각지게 설정 */
}


	body {
    font-family: 'Roboto', sans-serif;
  }
  .btn {
    border-radius: 0; /* 모서리를 각지게 설정 */
}
  
  .custom-card {
    margin-bottom: 0.5rem;
  }
  .custom-modal-lg .modal-dialog {
        max-width: 1300px; /* Adjust the max-width value as needed */
        margin: 30px auto; /* Adjust the margin value as needed */
  }
  .session-image {
           width: 200px;
           height: 200px;
           overflow: hidden;
          
           border: 1px solid rgba(0, 0, 0, 0.125);
           display: flex;
           justify-content: center;
           align-items: center;
           margin-top: 20px; 
           margin-left: 70px;
   }
   
   .card-body {
       text-align: center;
   }  
</style>
<script>

	const itemId = new URLSearchParams(location.search).get("id");
	
	let userId = null;
	
	function getUserId(){ 
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				
					userId = response.userId;

			}
		}
		xhr.open("get","./getUserId", false);
		xhr.send();
	}
	
	
	var couponId = 0;

	function getCouponDisCount(){
	   const xhr= new XMLHttpRequest();
	   const selectedCouponId = document.getElementById("coupon").value;
	   if(selectedCouponId == 0){
	         const couponPrice = document.getElementById("couponPrice")
			couponPrice.innerText = "-"
				const oriPrice =document.getElementById("modalPrice");
	         oriPrice.innerText = finalPrice.toLocaleString()
	      return;
	   }
	   couponId = parseInt(selectedCouponId)
	   xhr.onreadystatechange = function(){
	      if(xhr.readyState==4 && xhr.status==200){
	         const response = JSON.parse(xhr.responseText);
	         const couponPrice = document.getElementById("couponPrice")
	         const couponUsePrice= (finalPrice * (response.disCount/100))
	         console.log(response.disCount)
	         console.log(finalPrice)
	         console.log(couponUsePrice)
	     	 couponPrice.innerText = (couponUsePrice * -1).toLocaleString() + "P";
	         getModalPrice();
	      }
	   }
	   xhr.open("get","./getCouptonInfo?id="+selectedCouponId);
	   xhr.send();
	}
	
	
	
	function refreshTotalLikeCount() {
		const xhr = new XMLHttpRequest();	
		
		xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				// js 작업공간
				const totalLikeCountBox = document.getElementById("totalLikeCount");
				totalLikeCountBox.innerText = response.count;
			}
		}
		
		
		
		//get
		xhr.open("get", "./getTotalLikeCount?itemId=" + itemId);
		xhr.send();
	}
		
	function itemToggleLike(){
		if(userId == null) {
			if(confirm("로그인을 하셔야 이용하실 수 있습니다. 로그인 하시겠습니까?")){
				location.href = "../user/loginPage";			
			}
			
			return;
		}
		
		const xhr = new XMLHttpRequest();	
		
		xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				// js 작업공간
				/* refreshTotalLikeCount(); */
				refreshMyHeart();
			}
		}
		
		//get
		xhr.open("get", "./itemToggleLike?item_id=" + itemId);
		xhr.send();
		
	}
	
	function refreshMyHeart(){
			
			if(userId == null) return;
			
			
			const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 렌더링... 작업..
					const heartBox = document.getElementById("heartBox");
					console.log("userId : " + userId)
					if(response.data){
						console.log("1")
						heartBox.classList.remove("bi-heart");
						heartBox.classList.add("bi-heart-fill");
					}else{
						console.log("0")
						heartBox.classList.remove("bi-heart-fill");
						heartBox.classList.add("bi-heart");
					}
				}
			}
			
			//get
			xhr.open("get", "./isLiked?item_id=" + itemId,false);
			xhr.send();
	}
	
	window.addEventListener("DOMContentLoaded", function(){
		// 사실상 시작 시점
		getUserId();
		/* refreshTotalLikeCount(); */
		refreshMyHeart();
		getprice(1)


	});
	
	
	function getModal() { // 모달
	    const modal = bootstrap.Modal.getOrCreateInstance("#buyModal");
	    const modalPrice = document.getElementById("modalPrice");
	    const modalQuantityValue = document.getElementById("modalQuantityValue"); 
	
	    const priceBox = document.getElementById("priceBox");
	    const inputQuantity = document.getElementById("inputQuantity");
	
	    modalPrice.innerText = priceBox.innerText;
	    modalQuantityValue.innerText = inputQuantity.value; 
	    document.getElementById("modalQuantity").value = inputQuantity.value;
	
	  
	    const couponPrice = document.getElementById("couponPrice")
		couponPrice.innerText = "-"
	    modal.show();
	}

	
	var finalPrice = 0;
	
	function getprice(num){ // 총 결제 금액
		const priceBox = document.getElementById("priceBox");
		
		priceBox.innerText =(num * ${itemDetail.itemDto.item_price}).toLocaleString(); // toLocaleString사용하면 금액에 콤마붙임
		finalPrice = (num * ${itemDetail.itemDto.item_price})
	}	
	
	function getModalPrice(){
		const couponPrice = document.getElementById("couponPrice");
		
		const str = couponPrice.innerText
		const useCouponPrice = parseFloat(str.replace(/[^0-9.-]/g, ""));
		
		const oriPrice =document.getElementById("modalPrice");
		const str2 = oriPrice.innerText
		const originalPrice = parseFloat(str2.replace(/[^0-9.-]/g, ""));
		
		
		oriPrice.innerText =(finalPrice + useCouponPrice).toLocaleString(); // toLocaleString사용하면 금액에 콤마붙임

		
	}
	function quantityPlusMinus(num){ // +,- 버튼
		const inputQuantity = document.getElementById("inputQuantity");
		var value = inputQuantity.value;
		console.log(value)
		if(num >0){
			inputQuantity.value = parseInt(value) + 1;		
		}else{
			if(inputQuantity.value == 1){
				alert("최소 수량이 1개 이상이어야합니다.");
				return;
			}else{
				inputQuantity.value = parseInt(value) -1;		
			}
		}
		value = inputQuantity.value
		getprice(value)
		
	}
	function quantityInput(){ // 수량 입력
		const inputQuantity = document.getElementById("inputQuantity");
		const num = inputQuantity.value;	
		getprice(num)
	}
	
	function sample6_execDaumPostcode() { // 주소입력
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
	
	
</script>
</head>
<body>

<div class="container-fluid">
<jsp:include page="../common/topNavi.jsp"></jsp:include>
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                <div class="row">
                    <div class="col-12" style="margin-top: 1%;">
                        <h4 class="mt-5" style="font-size: 1.5em; color: gray;">${itemDetail.itemCategoryDto.category}</h4>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-5">
                        <div class="card" style="width: auto; border: none;">
                           <img src="/uploadFiles/${itemDetail.itemDto.item_thumbnail}" class="card-img-top">
                        </div>
                    </div>
                    <div class="col-7">
                        <div class="row">
								<div style="display: flex; justify-content: space-between; align-items: center;">
								    <h3 style="margin-left: 1%; font-weight: bold;">${itemDetail.itemDto.item_name}</h3>
								    
								</div>
                                <div class="col" style="margin-left: 1%;">
                                    <span style="color: gray;">리뷰 ${itemDetail.itemReviewCount}</span>
                                    <span style="margin-left: 10px; color: gray;">구매 ${itemDetail.itemBuyCount}</span>
                                    <span style="margin-left: 10px; color: gray;">찜 ${itemDetail.itemLikeCount}</span>
                                </div>
                                <h3 style="margin-top: 5%; margin-bottom: 5%; margin-left:1%; font-size: 2em; float: right; color: rgb(255, 72, 0);">
                                	<fmt:formatNumber value="${itemDetail.itemDto.item_price}" pattern="#,###" var="formattedPrice" />
                          			${formattedPrice} P
                          		</h3>
                                <div class="col">
                                    <div class="row" style="margin-left: 1px;">
                                    <span style="color: gray;">배송비
                                        <span style="margin-left: 50px;">해당 제품으로만 10000원 이상 구매시 무료배송 ( 미만시 배송비 3000원 발생 )
                                        </span>
                                    </span>
                                    <span style="color: gray; margin-top: 30px; margin-bottom: 20px;">남은수량
                                        <span style="margin-left: 5%">${itemDetail.quantity}
                                        </span>
                                    </span>
                                    </div>
                                </div>
                                <div class="row mt-5" style="margin-left: 1px;">
                                    <div class="d-flex">
                                        <span>
                                           <button type="button" class="btn btn-white border fw-semibold" onclick="quantityPlusMinus(-1)">-</button>
                                        </span>
                                        <input class="form-control text-left " id="inputQuantity" type="number" value="1"  oninput="quantityInput()" style="max-width: 4rem"  />
                                        <span>
                                           <button type="button" class="btn btn-white border fw-semibold" onclick="quantityPlusMinus(1)">+</button>
                                        </span>
                                    </div> 
                                </div>
                                <div class="row mt-4">
                                    <div class="col-6" style="margin-top: 3%; margin-left: 2%;">
                                        <h6 style="text-align: left;">총 결제금액</h6>
                                    </div>
                                    <div class="col-5" style="margin-left:6%;">
                                        <h5 class="fw-semibold mt-2 text" style="font-size: 2em; float: right; color: rgb(255, 72, 0);">
                                            <span id="priceBox"> <fmt:formatNumber value="${itemDetail.itemDto.item_price}" pattern="#,###" var="formattedPrice" />
				                          	${formattedPrice} 
				                          	</span>
                                            <span class="fw-normal text-secondary ms-0" style="font-size: 0.7em; margin-left: 1px;">P</span>
                                        </h5>
                                    </div>
                                </div>
                               <div class="col" style="display: flex; align-items: center; justify-content: space-between;">
								    <div class="btn btn-lg mt-3 w-50 text-dark border border-dark fw-semibold" onclick="itemToggleLike()" style="align-items: center; margin-top:3%; margin-left:2%; background-color: whtie; border-radius: 0;">
								        <i id="heartBox"  class="fs-5 bi bi-heart" style="color: rgba(220, 53, 69, 0.7); "></i>
								
								        <span id="totalLikeCount">상품 찜</span>
								    </div>
								    <a class="btn btn-lg mt-3 w-50 text-white fw-semibold" style="align-items: center; justify-content: flex-end; background-color: black; border-radius: 0; margin-left: 2%;" onclick="getModal()">구매하기</a>
								</div>


                    </div>
                </div>
                <div class="col" style="margin-top: 5%;"></div>
                <h3>연관 상품</h3>
                <hr style="margin-top: 1%;">
               
               
                <c:forEach items="${itemDetail.itemRelation}" var="map">
                <div class="card" style="display: flex; margin-left : 25px; width: 14rem; margin-bottom: 5%; margin-top: 2%; border: none;" onclick="location.href='./itemDetailPage?id=${map.id}'">                 
                    <img src="/uploadFiles/${map.item_thumbnail}" class="card-img-top">
                    <div class="text-left">
                        <h5 class="mt-3 mb-0">${map.item_name}</h5>
                        <h5 class="fw-semibold mt-3 text-danger">
                          ${map.item_price}
                          <span class="fw-normal text-secondary ms-0" style="font-size: 0.7em; margin-left: 1px;">P</span>
                        </h5>
                      </div>
                </div>
                </c:forEach>
             
                <h3>상품 정보</h3>
                <hr style="margin-top: 1%;">
                <div>
	                 <c:forEach items="${itemDetail.itemImageDto}" var="map">
	                <div style="display: flex; margin-top:1%; justify-content: center; margin-bottom: 4%;">
	                    <img src="/uploadFiles/${map.image}">
	                </div>
	                </c:forEach>
                </div>
                <h3>상품 리뷰</h3>
                 <hr style="margin-top: 1%;">
                <c:forEach items="${itemReview}" var="map">
                <div class="col" style="display: flex; justify-content: space-between; align-items: center; margin-top: 1%;">
                    <span>
                    	<c:choose>
					    <c:when test="${map.star eq 1}">
					        <div class="col fs-5">
					            <span style="float: right;">★</span>
					        </div>
					    </c:when>
					    <c:when test="${map.star eq 2}">
					        <div class="col fs-5">
					           <span style="float: right;">★★</span>
					        </div>
					    </c:when>
					    <c:when test="${map.star eq 3}">
					        <div class="col fs-5">
					           <span style="float: right;">★★★</span>
					        </div>
					    </c:when>
					    <c:when test="${map.star eq 4}">
					        <div class="col fs-5">
					           <span style="float: right;">★★★★</span>
					        </div>
					    </c:when>
					    <c:when test="${map.star eq 5}">
					        <div class="col fs-5">
					            <span style="float: right;">★★★★★</span>
					        </div>
					    </c:when>
					</c:choose>
                    </span> 
                    <span style="margin-left: 30px;">${map.user_name}</span>
                    <span class="date" style="margin-left: auto;"><fmt:formatDate value="${map.reg_date}" pattern="yy.MM.dd"/></span>
                </div>
                <span style="margin-top: 20px;">${map.context}</span>
                <hr style="margin-top: 10px; margin-bottom:20px;">  
                </c:forEach>
            </div>
            <div class="col-2"></div>
        </div>
        </div>
    </div>
       
       
		
		<!-- 모달 -->
		<form action="./insertItemBuyProcess" method="post">
		<div class="modal fade custom-modal-lg" id="buyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		 
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
           
            <div class="col">
                <div class="row">
                    <div class="col-12" style="text-align: right;">
                        <span class="mt-5">01 주문 하기</span>
                        <span class="mt-5" style="color: gray;"> > 02 주문 완료</span>
                    </div>
                <div class="row" style="margin-top: 2%; margin-left: 10px;">
                    <div class="col-6">
                        <hr>
                        <h5 style="margin-top: 20px; font-weight: bold;">배송정보</h5>
                        <div class="row mt-5">
                            <div class="col-2 d-flex align-items-center">
                                <label for="floatingInput" class="form-label fs-6 mb-0">수령인</label>
                            </div>
                            <div class="col">
                                <input type="text" name="user_name" value="${sessionUser.user_name}" placeholder="${sessionUser.user_name}" class="form-control form-control-lg" id="floatingInput" maxlength="10" style="width: 300px;" readonly>

                            	<input type="hidden" name="id" value="${itemBuy.itemDto.id}">
                            </div>
                        </div>
                        <div class="row mt-5">
                            <div class="col-2 d-flex align-items-center">
                                <label for="floatingInput" class="form-label fs-6 mb-0">주소</label>
                            </div>
                            <div class="col" style="display: flex;">
                                <input type="text" name="address" class="form-control form-control-lg" id="sample6_postcode" placeholder="우편번호" maxlength="10" style="width: 300px;">
                                <input type="button" onclick="sample6_execDaumPostcode()" class="btn btn-outline-dark ms-3" value="우편번호 찾기">
                            </div>
                            <div class="row mt-3" style="margin-left: 15%;">
                                <div class="col-10" style="display: flex;">
                                    <input type="text" name="address" class="form-control form-control-lg" id="sample6_address" placeholder="주소" maxlength="10" style="width: 430px;">
                                </div>
                            </div>
                            <div class="row mt-3" style="margin-left: 15%;">
                                <div class="col" style="display: flex;">
                                    <input type="text" class="form-control form-control-lg" id="sample6_detailAddress" placeholder="상세주소" maxlength="10" style="width: 430px;">
                                   <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
                                </div>
                            </div>
                        </div>
                         <div class="row mt-5">
                            <div class="col-2 d-flex align-items-center">
                                <label for="floatingInput" class="form-label fs-6 mb-0">쿠폰</label>
                            </div>
                            <div class="col" style="display: flex;">
                            
                           <select class="form-select form-control-lg " aria-label=".form-select-lg example" name="userCoupon_id" id="coupon" onchange="getCouponDisCount()">
			                 <option selected value="0">사용 가능 쿠폰 / ${useAbleCouponCount} 개</option>
			                 <c:forEach items="${couponList}" var="coupon">
			                       <option value="${coupon.id}">${coupon.coupon_name} / ${coupon.coupon_discount}%</option>
			                 </c:forEach>
			               </select>
                            </div>
                        </div>
                    </div>  
                    <div class="card" style="width: 35rem; margin-top: 15px; margin-left: 60px;">
                        <h5 style="margin-top: 20px; font-weight: bold;">주문상품 정보</h5>
                        <hr>
                        <div class="row">
                            <div class="col-12 col-md-4">
                                <img src="/uploadFiles/${itemDetail.itemDto.item_thumbnail}" class="card-img-top" style="width: 150px; height: 150px; margin-top: 10px;">
                            </div>
                            <div class="col-12 col-md-8">
                                <div class="card-body">
                                    <div class="mb-4" style="font-size: 1em; color: gray;">${itemDetail.itemCategoryDto.category}</div>
                                    <p class="card-text" style="font-size: 20px; font-weight: bold; ">${itemDetail.itemDto.item_name}</p>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row mt-3">
                            <h6 style="text-align: left;">수량 <span id="modalQuantityValue" style="float: right; color: rgb(255, 72, 0); "></span></h6>
                        	<input type="hidden" name="count" id="modalQuantity" value="">
                        </div>
                        <div class="row mt-3">
                            <h6 style="text-align: left;">쿠폰 사용 <span id="couponPrice" style="float: right; color: rgb(255, 72, 0); "></span></h6>
                        	<input type="hidden" name="count" id="modalQuantity" value="">
                        </div>
                        <div class="row mt-1">
                            <div class="col-6" style="margin-top: 30px;">
                                <h6 style="text-align: left;">총 결제금액</h6>
                            </div>
                            <div class="col-6">
                                <div style="display: flex; float:right; ">
								    <h5 class="fw-semibold mt-3 text" id="modalPrice" style="font-size: 2em; margin-right: 10px; color: rgb(255, 72, 0);">
								        <input type="hidden" id="modalPriceValue">    
								    </h5>
								    <span class="fw-normal text-secondary" style="font-size: 1.5em; margin-top : 20px;">P</span>
								</div>
                            </div>
                        </div>
                        <hr> 
                        <button class="btn text-white fw-semibold" style=" border-radius: 5px;   background-color: black; margin-bottom: 10px; margin-top: 10px;" type="submit">결제하기</button>
                    </div>  
                </div>
                </div>
                
            </div>
      
        </div>
		    </div>
		  </div>
		</div>
		</div>
		</form>
       
       
       
       
       
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>