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
<title>쿠폰 리스트</title>
<style>
body {
    font-family: 'Roboto', sans-serif;
  }
        .card-body {
            display: flex;
            flex-direction: column;
            align-items: left;
            text-align: left;
        }
        .card {
            border: 1px solid rgba(0, 0, 0, 0.125); 
            width: 300px; 
        }
        .coupon-image {
            width: 80px;
            height: 80px;
            overflow: hidden;
            border-radius: 50%;
            border: 1px solid rgba(0, 0, 0, 0.125);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px; 
        }
        .coupon-button {
            font-size: 14px; 
            white-space: nowrap; 
        }
        .coupon-date {
            margin-top: -6px; 
        }
        .coupon-quantity {
            margin-top: 6px; 
        }
        .coupon-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px; 
        }
    </style>	
</head>
<body>
 <jsp:include page="../common/topNavi.jsp"></jsp:include>
    <div class="container-fluid">
        <div class="row mb-5 mt-5"> 
            <div class="col-2"></div>
            <div class="col-8">
                <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
                      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
                      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="3" aria-label="Slide 4"></button>
                      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="4" aria-label="Slide 5"></button>
                    </div>
                    <div class="carousel-inner">
                      <div class="carousel-item active" data-bs-interval="10000">
                        <img src="../resources/img/쿠폰배너1.png" class="d-block w-100" style="margin: auto;">
                      </div>
                      <div class="carousel-item" data-bs-interval="2000">
                        <img src="../resources/img/쿠폰배너2.jpeg" class="d-block w-100" style="margin: auto;">
                      </div>
                      <div class="carousel-item" data-bs-interval="2000">
                        <img src="../resources/img/쿠폰배너3.jpeg" class="d-block w-100" style="margin: auto;">
                      </div>
                      <div class="carousel-item" data-bs-interval="2000">
                        <img src="../resources/img/쿠폰배너4.jpeg" class="d-block w-100" style="margin: auto;">
                      </div>
                      <div class="carousel-item" data-bs-interval="2000">
                        <img src="../resources/img/쿠폰배너5.jpeg" class="d-block w-100" style="margin: auto;">
                      </div>
                    </div>
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
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
          
                <div class="coupon-container" style="margin-left : 10px;">
                    <c:forEach items="${couponList}" var="map" varStatus="status">
                		<form action="./couponListProcess" method="post">
                            <div class="card mb-4">
                                <div class="row">
                                    <div class="col-md-7">
                                        <div class="card-body">
                                            <h5 class="card-title" style="font-weight: bold;">${map.couponDto.coupon_name}</h5>
                                            <p class="card-text coupon-date" style="color: red;">
                                                <small class="text">~ <fmt:formatDate value="${map.couponDto.coupon_issue_end}" pattern="yy.MM.dd"/></small>
                                            </p>
                                            <small class="card-text coupon-quantity" style="color: gray;">수량 ${map.quantity}</small>								    
                                            <p class="card-text" style="color: #0078ff; font-size: 30px;">${map.couponDto.coupon_discount}%</p>
                                        </div>
                                    </div>
                                    <div class="col-md-3 ml-4 mt-4">
                                        <div class="coupon-image">
                                            <img src="/uploadFiles/${map.couponDto.coupon_image}" class="img-fluid" style="width: 100%; height: 100%;">
                                        </div>
                                        <input type="hidden" name="user_id" value="${sessionUser.id}"/>
                                        <input type="hidden" name="coupon_id" value="${map.couponDto.id}"/>
                                        <div class="coupon-button d-flex justify-content-start ms-auto">
                                            <c:choose>
                                                <c:when test="${map.duplicate == 0}"> 
                                                    <input type="submit" class="btn btn-outline-primary"  value="발급받기"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="submit" class="btn btn-outline-primary" disabled value="발급완료" />
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div> 
                            </div>
                        </form>    
                    </c:forEach>
                </div>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
