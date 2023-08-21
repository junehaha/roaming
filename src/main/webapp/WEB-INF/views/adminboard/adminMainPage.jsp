<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<head>
<style>


</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous">
<meta charset="UTF-8">
<title>adminMainPage</title>
<script>
   
</script>
</head>
<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col">
           
         </div>
      </div>
      <div class="row">
         <div class="col-2" style="background-color: black;">
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">관리자 페이지</div>
            </div>
            <div class="row mt-4">
			   <div class="col-2"></div>
			   <div class="col fw-semibold pb-0">
			      <c:choose>
			         <c:when test="${!empty sessionAdmin}">
			            <a href="../admin/adminLogoutProcess" style="text-decoration: none; color: inherit;">
			               <i class="bi bi-power" style="color: white;"></i>
			               <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">로그아웃</span>
			            </a>
			         </c:when>
			         <c:otherwise>
			            <a href="../admin/adminLoginPage" style="text-decoration: none; color: inherit;">
			               <i class="bi bi-power" style="color: white;"></i>
			               <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;" >로그인</span>
			            </a>
			         </c:otherwise>
			      </c:choose>
			   </div>
			</div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./adminMainPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-house fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: skyblue;">홈</span>
                  </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./adminDashBoardPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">대시보드</span>
                  </a>
               </div>
            </div>
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5" >판매자 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
               <a href="./sellerNoticePage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-clipboard fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">공지사항</span>
               </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
               <a href="./hotelDocuPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-check-circle fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">신청 관리</span>
               </a>
               </div>
            </div>
            
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">쿠폰 및 상품 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
               <a href="./manageCouponPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-ticket fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">쿠폰 관리</span>
               </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
               <a href="./manageItemPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-bag fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">상품 관리</span>
               </a>
               </div>
               
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">짐 관리</div>
            </div>
            
            </div>
               <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
                  <a href="./adminZimPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-truck fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">짐 배송 관리</span>
                  </a>
               </div>
            </div>
            
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">고객게시판 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
                  <i class="bi bi-clipboard fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">공지사항</span>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
                  <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">자주묻는 질문</span>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col fw-semibold pb-0">
                  <a href="../admincsboard/adminQaBoardProgressPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft fs-6 pt-0" style="color: white;">문의게시판</span>
                  </a>
               </div>
            </div>
             
         </div>
         
         <div class="col-8 bg-secondary bg-opacity-10 info-scroll-container">
      
         </div>
         <div class="col-2 bg-secondary bg-opacity-10 info-scroll-container">
         </div>
      </div>

   </div>
</body>
</html>