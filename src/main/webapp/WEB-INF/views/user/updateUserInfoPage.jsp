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
        max-width: 100%;
        max-height: 100%;
    	}
        
        .card-body {
            text-align: center;
        }

</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>
	  <div class="container-fluid">
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
                            <img src="/uploadFiles/${myPage.userDto.profile_img}" class="card-img-top">
                           </div>
                           <div class="card-body">
                             <p class="card-text">${myPage.userDto.user_name}</p>
                           <a href="../userboard/myPage?id=${sessionUser.id}" style="text-decoration: none;">
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
                           <a href="../userboard/orderHistoryPage" style="font-size: 15px; color: gray; text-decoration: none;">
                           <p>주문 내역 조회</p>
						   </a>
                           <a href="../userboard/userItemLikePage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>좋아요 리스트</p>    
						   </a>
						   <a href="../userboard/userPointPage" style="font-size: 15px; color: gray; text-decoration: none;">
							<p>포인트</p>    
						   </a>
                        </div>
                        <div class="row mt-4">
                           <h5>쿠폰</h5>
                           <a href="../userboard/userCouponPage?id=${sessionUser.id}" style="text-decoration: none;">
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
                           <p style="font-size: 15px; color: gray;">현재 예약 내역</p>
                           <p style="font-size: 15px; color: gray;">지난 예역 내역</p>
                           <p style="font-size: 15px; color: gray;">내가 찜한 숙소</p>
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
                     <form action="./updateUserInfoProcess" method="post" enctype="multipart/form-data">
                     <input type="hidden" name="id" value="${myPage.userDto.id}">
                 	<div class="row card-context"> 
                     <div class="card" style="width: 100rem; height: 35rem;">
                        <div class="row" style="margin-top : 20px; margin-left : 10px;">
                           <div class="col fs-3 fw-semibold" style="text-align: center;">
                           회원 정보 수정
                           </div>
                       </div>
                            <div class="card-body">
                              <div class="row mt-5" style="margin-left: 10px;">
                                 <div class="col-2 text-start pe-0 pt-2">
                                    비밀번호 
                                 </div>
                                 <div class="col text-start">
                                    <input type="text" name="user_pw" class="form-control form-control" id="floatingInput" maxlength="20" style="width: 300px;">
                                 </div>
                              </div>
                              <div class="row mt-5" style="margin-left: 10px;">
                                 <div class="col-2 text-start pe-0 pt-2">
                                    프로필 사진
                                 </div>
                                 <div class="col text-start">
                                    <input type="file" name=profile_image class="form-control form-control" id="floatingInput" maxlength="20" style="width: 300px;" value="${myPage.userDto.profile_img }">
                                 </div>
                              </div>
                              <div class="row mt-5" style="margin-left: 10px;">
                                 <div class="col-2 text-start pe-0 pt-2">
                                    번호 
                                 </div>
                                 <div class="col text-start">
                                    <input type="text" name="phone_number" class="form-control form-control" id="floatingInput" maxlength="30" style="width: 300px;" value="${myPage.userDto.phone_number }">
                                 </div>
                              </div>
                              <div class="row mt-5" style="margin-left: 10px;">
                                 <div class="col-2 text-start pe-0 pt-2">
                                    이메일 
                                 </div>
                                 <div class="col text-start">
                                    <input type="text" name="email" class="form-control form-control" id="floatingInput" maxlength="30" style="width: 300px;" value="${myPage.userDto.email }">
                                 </div>
                              </div>
                           </div>
                           <div class="col" style="text-align: center;"> 
                              <button class="btn btn-outline-primary" style="margin-right: 5px;">저장</button>
                              <a class="btn btn-secondary" href='../userboard/myPage?id=${sessionUser.id}'>취소</a>
                           </div> 
                     </div>
                  </div>
                  </form>
                  </div>
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