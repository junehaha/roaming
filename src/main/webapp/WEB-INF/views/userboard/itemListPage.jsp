<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>상품리스트</title>
<style>
body {
    font-family: 'Roboto', sans-serif;
  }
 .col img {
            width: 50px;
            height: 50px;
        }
        
</style>
<script>


	function addThousandsSeparator(number) { // 숫자에 콤마붙이는 기능
	  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
										col.classList.add("col", "mb-5");
										
										const card = document.createElement("div");
										card.classList.add("card", "h-100", "border-0");
										
										const link = document.createElement("a");
										link.href = "./itemDetailPage?id=" + itemId; 

										card.addEventListener("click", function() {
										  link.click(); 
										});

										card.appendChild(link);
									
										
										const img = document.createElement("img"); // 이미지
										img.classList.add("card-img-top");
										img.src = "/uploadFiles/" + map.itemDto.item_thumbnail;
										img.style.width = "248px";
										img.style.height = "200px";
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
										itemLikeCount.innerText = "찜 " + map.itemLikeCount; 
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
										
										
										
										
/* 										const cardFooter = document.createElement("div");
										cardFooter.classList.add("card-footer", "p-0", "border-top-0", "bg-transparent");
										card.appendChild(cardFooter);

										const link = document.createElement("a");
										link.href = "./itemDetailPage?id=" + map.itemDto.id;
										link.classList.add("btn", "btn-outline-gray", "w-100", "btn-lg", "text-center"); // Added "w-100" class for full width, "btn-lg" class for larger size, and "text-center" class for center alignment
										link.innerText = "상품보기";
										cardFooter.appendChild(link);
 */
									
									
									col.appendChild(card);
									
									
									itemList.appendChild(col);
		            			});
		        					
			} 

		
		
		
        /* <c:forEach items="${itemList}" var="map" >
        <div class="col mb-5">
            <div class="card h-100">  
                <img class="card-img-top" src="/uploadFiles/${map.itemDto.item_thumbnail}" style="width:245px; height:200px;"/>
                 <div class="card-body p-4 d-flex flex-column justify-content-between">
                    <div class="text-center">
                        <h5 class="fw-bolder">${map.itemDto.item_name}</h5>
                        <span>${map.itemDto.item_price}P</span>
                    </div>
                </div>
                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                    <div class="text-center">
                    	<a class="btn btn-outline-dark mt-auto" href="./itemDetailPage?id=${map.itemDto.id}">상품보기</a>
                    </div>
                </div>
            </div>
        </div>
        </c:forEach> */

		
		}
		// get 방식
		xhr.open("get", "./getItemList?categoryId=" + categoryV); // controller에있는 그대로
		xhr.send();

		

	}

		window.addEventListener("DOMContentLoaded", function(){
			 getUserId()
			 itemList(0)
			 
		});


	
</script>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>
    <div class="container-fluid">    
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
            <div class="row" style="justify-content:center; margin-top:3%;">
  <div class="col-6 ">
    <!-- Right Carousel (carouselExampleDark2) -->
    <div id="carouselExampleDark2" class="carousel carousel-dark slide" data-bs-ride="carousel" style="margin-top: 2%;">
      <!-- Carousel Indicators -->
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleDark2" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleDark2" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleDark2" data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>
      <!-- Carousel Inner Content -->
      <div class="carousel-inner">
       <div class="carousel-item active" data-bs-interval="10000">
          <img src="../resources/img/포인트샵배너1.jpeg" class="d-block w-100 img-fluid" style="max-width:800px; max-height:430px; margin: auto;">
        </div>
        <div class="carousel-item active" data-bs-interval="10000">
          <img src="../resources/img/포인트샵배너2.jpeg" class="d-block w-100 img-fluid" style="max-width:800px; max-height:430px; margin: auto;">
        </div>
        <div class="carousel-item" data-bs-interval="2000">
          <img src="../resources/img/포인트샵배너3.jpeg" class="d-block w-100 img-fluid" style="max-width:800px; max-height:430px; margin: auto;">
        </div>
      </div>
      <!-- Carousel Controls -->
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark2" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark2" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </div>

  <div class="col-6 ">
    <!-- Left Carousel (carouselExampleDark) -->
    <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel" style="margin-top: 2%;">
      <!-- Carousel Indicators -->
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>
      <!-- Carousel Inner Content -->
      <div class="carousel-inner">
        <div class="carousel-item active" data-bs-interval="10000">
          <img src="../resources/img/포인트샵배너4.jpeg" class="d-block w-100 img-fluid" style="max-width:800px; max-height:430px; margin: auto;">
        </div>
        <div class="carousel-item" data-bs-interval="2000">
          <img src="../resources/img/포인트샵배너5.jpeg" class="d-block w-100 img-fluid" style="max-width:800px; max-height:430px; margin: auto;">
        </div>
         <div class="carousel-item active" data-bs-interval="10000">
          <img src="../resources/img/포인트샵배너6.jpeg" class="d-block w-100 img-fluid" style="max-width:800px; max-height:430px; margin: auto;">
        </div>
      </div>
      <!-- Carousel Controls -->
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </div>
</div>


            
                  
                  
                  <section class="py-5">
                    <div class="container px-4 px-lg-5 mt-3">
                    <hr>
                    <div class="row pt-3" style="margin-left: 5%;">
                    <div class="col text-start">
                        <div class="card" style="width: 30%; border: none;">
                            <img src="../resources/img/전체.png" style="display: block; margin: 0 auto; " onclick="itemList(0)">
                            <div class="row">
                            <div class="col">
                            <span class="d-block" style="text-align: center;" >전체</span>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="col text-start">
                        <div class="card" style="width: 30%; border: none;">
                        <img src="../resources/img/뷰티.png" style="display: block; margin: 0 auto;" onclick="itemList(1)">
                        <div class="row">
                         <div class="col">
                        <span class="d-block" style="text-align: center;">뷰티</span>
                        </div>
                        </div>
                    </div>
                    </div>
                    <div class="col text-start">
                        <div class="card" style="width: 30%; border: none;">
                        <img src="../resources/img/디지털.png" style="display: block; margin: 0 auto;" onclick="itemList(2)">
                        <div class="row">
                         <div class="col">
                        <span class="d-block" style="text-align: center; font-size:15px; padding-top: 2px;" >디지털</span>
                        </div>
                        </div>
                        </div>
                    </div>
                    <div class="col text-start">
                        <div class="card" style="width: 30%; border: none;">
                        <img src="../resources/img/식품.png" style="display: block; margin: 0 auto;" onclick="itemList(3)">
                        <div class="row">
                         <div class="col">
                        <span class="d-block" style="text-align: center;" >식품</span>
                        </div>
                        </div>
                        </div>
                    </div>
                    <div class="col text-start">
                        <div class="card" style="width: 30%; border: none;">
                        <img src="../resources/img/티켓.png" style="display: block; margin: 0 auto;" onclick="itemList(4)">
                        <div class="row">
                         <div class="col">
                        <span class="d-block" style="text-align: center; font-size:15px;" >상품권</span>
                        </div>
                        </div>
                        </div>
                    </div>
                    <div class="col text-start">
                        <div class="card" style="width: 30%; border: none;">
                        <img src="../resources/img/레고.png" style="display: block; margin: 0 auto; margin-top:1px;" onclick="itemList(5)">
                        <div class="row">
                         <div class="col">
                        <span class="d-block" style="text-align: center; margin-top:2px" >취미</span>
                        </div>
                       	</div>
                        </div>
                    </div>
                </div>
                   <%--  <div class="col">
					  <select onchange="itemList();" name="category_id" class="form-control form-control-lg text-center" id="category" style="width: 130px;">
					    <c:forEach items="${category}" var="category">
					      <option  value="${category.id}">
					        ${category.category}
					      </option>
					    </c:forEach>
					  </select>
					</div> --%>
					<div class="col" style="margin-top: 3%;"></div>
					<hr>
					<div class="col" style="margin-top: 5%;">
                        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center" id="itemList">
                            <%-- <c:forEach items="${itemList}" var="map" >
                            <div class="col mb-5">
                                <div class="card h-100">
                                    <!-- Product image-->
                                    <img class="card-img-top" src="/uploadFiles/${map.itemDto.item_thumbnail}" style="width:245px; height:200px;"/>
                                    <!-- Product details-->
                                     <div class="card-body p-4 d-flex flex-column justify-content-between">
                                        <div class="text-center">
                                            <!-- Product name-->
                                            <h5 class="fw-bolder">${map.itemDto.item_name}</h5>
                                            <!-- Product price-->
                                            ${map.itemDto.item_price}P
                                        </div>
                                    </div>
                                    <!-- Product actions-->
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                        <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="./itemDetailPage?id=${map.itemDto.id}">상품보기</a></div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach> --%>
                        </div>
                        </div>
                    </div>
                  </section>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>