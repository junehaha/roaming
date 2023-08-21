<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>구매 완료</title>
<style>
body {
    font-family: 'Roboto', sans-serif;
  }
</style>
<script>
	function addThousandsSeparator(number) { // 숫자에 콤마붙이는 기능
	  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	function getModal() { // 모달
	    const modal = bootstrap.Modal.getOrCreateInstance("#buyModal");
	    const modalPrice = document.getElementById("modalPrice");
	    const modalQuantityValue = document.getElementById("modalQuantityValue"); 
	
	    const priceBox = document.getElementById("priceBox");
	    const inputQuantity = document.getElementById("inputQuantity");
	
	    modalPrice.innerText = priceBox.innerText;
	    modalQuantityValue.innerText = inputQuantity.value; 
	    document.getElementById("modalQuantity").value = inputQuantity.value;
	
	    modal.show();
	}

	
	
	function getprice(num){ // 총 결제 금액
		const priceBox = document.getElementById("priceBox");
		priceBox.innerText = num * ${itemDetail.itemDto.item_price}
		
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
	
	
</script>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>
	  <div class="container-fluid">
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                <div class="row">
                    <div class="col-12" style="text-align: right; margin-top: 5%; ">
                        <span class="mt-5"  style="color: gray;">01 주문 하기 ></span>
                        <span class="mt-5" >  02 주문 완료</span>
                    
                </div>
                <div class="row" style="margin-top: 3%; text-align: center;">
                    <h1 style="font-weight: bold;">주문이 완료되었습니다.</h1>
                </div>
                <div class="col-6" style="margin-top: 5%;">
                    <div class="row">
                        <div class="col">
                            <h4 style="margin-bottom: 30px; font-weight: bold;">주문상품정보 / 1개 상품</h4>
                            <hr style="border: 1px solid  black;">
                        </div>
                        <div class="row">
					    <div class="col">
					        <h5 style="margin-top: 20px; color: gray;">${itemBuyComplete.itemCategoryDto.category}</h5>
					    </div>
					    
					    <div class="row">
					        <div class="col">
					            <div style="display: flex; float:left; margin-bottom: 10px; ">
					                <span style="font-size: 1.5rem; font-weight: bold; margin-top: 10px;">${itemBuyComplete.itemDto.item_name}</span>
					            </div>
					             
					        </div>
					        <div class="row">
					            <div class="col">
					                <span class="fw-semibold mt-3 text" id="priceBox" style="font-size: 2em;  color: rgb(255, 72, 0);">
					                    <fmt:formatNumber value="${finalPrice}" pattern="#,###" var="formattedPrice" />
					                    ${formattedPrice} 
					                     <span class="fw-normal text-secondary ms-0" style="font-size: 0.7em; margin-left: 1px;">P</span>
					                </span>
					            </div>
					            <div class="row">
					             <span class="fw-semibold mt-3 text" style="color: gray; margin-top: 20px; margin-bottom: 20px; font-size: 1.2rem;">
								    수량 ${itemBuyComplete.itemBuyDto.count}
								</span>
					            </div>
					            <div class="col-3">
					    <img src="/uploadFiles/${itemBuyComplete.itemDto.item_thumbnail}" style="height: 200px; width: 200px;">
					    </div>
					        </div>
					      
					    </div>
					    
					</div>
                    </div>
                    </div> 
                    <div class="col-6" style="margin-top: 5%;">
                        <h4 style="margin-bottom: 30px; font-weight: bold;">결제정보</h4>
                        <hr style="border: 1px solid  black;">
                        <div class="col" style="margin-top: 7%;">
                            <h5 style="margin-top: 20px;">주문자명
                                <span style="margin-left: 10%;">${itemBuyComplete.userDto.user_name}</span>
                            </h5>
                        </div>
                        <hr style="margin-top: 40px;">
                        <div class="col">
                            <h5 style="margin-top: 6%;">주소
                                <span style="margin-left: 15%;">${itemBuyComplete.userAddressDto.address}</span>
                            </h5>
                        </div>
                        <hr style="margin-top: 40px;">
                        <div class="col">
                            <h5 style="margin-top: 6%;">결제방법
                                <span style="margin-left: 10%;">포인트</span>
                            </h5>
                        </div>
                        <hr style="margin-top: 40px;">
                        <div class="col">
                            <h5 style="margin-top: 6%;">주문상태
                                <span style="margin-left: 10%;">결제완료</span>
                            </h5>
                        </div>
                    </div>
                    </div>
                    <div class="row" style="margin-bottom:3%;">
                        <div class="col" style="margin-top: 5%; text-align: center;">
                        <a href="./orderHistoryPage" class="btn btn-lg mt-3 w-25 text-white fw-semibold" style="background-color: black; margin-right: 10%; border-radius: 0;">주문 목록 조회하기</a>
						<a href="./itemListPage" class="btn btn-lg mt-3 w-25 text-white fw-semibold" style="background-color: black; border-radius: 0;">상품 리스트 페이지로 이동</a>
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