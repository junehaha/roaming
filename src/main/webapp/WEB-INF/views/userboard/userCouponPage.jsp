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
<title>유저 쿠폰함</title>
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
                     <p>상품 찜 리스트</p>    
                     </a>
                     <a href="./userPointPage" style="font-size: 15px; color: gray; text-decoration: none;">
                     <p>포인트</p>    
                     </a>
                        </div>
                        <div class="row mt-4">
                           <h5>쿠폰</h5>
                           <a href="./userCouponPage" style="text-decoration: none;">
                         <span style="font-size: 15px; color: #0078ff;">내 쿠폰함</span>
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
                     <div class="col-sm-9 text-left">
                  <div class="row card-context"> 
                     <div class="card" style="width: 100rem; ">
                      <div class="row mb-3" style="margin-top : 20px; margin-left : 10px;">
                        <div class="col-3 fs-3 fw-semibold">
                        사용가능 쿠폰
                        </div>
                        <div class="col pt-3 ps-0 text-start">
                            사용가능한 쿠폰을 조회합니다
                        </div>
                    </div>
                    <table class="table" style="margin-top : 20px;">
                        <thead>
                            <tr style="text-align:center;">
                                <th scope="col">번호</th>
                                <th scope="col">이미지</th>
                                <th scope="col">쿠폰명</th>
                                <th scope="col">쿠폰내용</th>
                                <th scope="col">할인율(%)</th>
                                <th scope="col">배포 기간</th>
                                <th scope="col">사용 기간</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${userCouponList}" var="map">
                                 <tr style="text-align:center;">
                                    <th scope="row" style="vertical-align: middle;">${map.couponDto.id}</th>
                                    <td><img src="/uploadFiles/${map.couponDto.coupon_image}" style="width:50px; height:50px;"></td>
                                    <td style="vertical-align: middle;">${map.couponDto.coupon_name}</td>
                                    <td style="vertical-align: middle;">${map.couponDto.coupon_context}</td>
                                    <td style="vertical-align: middle;">${map.couponDto.coupon_discount}</td>
                                    <td style="vertical-align: middle;"><fmt:formatDate value="${map.couponDto.coupon_startdate}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${map.couponDto.coupon_enddate }" pattern="yy.MM.dd"/></td>
                                    <td style="vertical-align: middle;"><fmt:formatDate value="${map.couponDto.coupon_issue_start}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${map.couponDto.coupon_issue_end }" pattern="yy.MM.dd"/></td> 
                                    <td>
                                    </td>
                                </tr>
                             </c:forEach>
                            </tbody>
                        </table>
                        <nav aria-label="...">
                              <ul class="pagination pagination-sm justify-content-center">       
                     
                        <c:choose>
                                <c:when test="${startPage <= 1}">
                                   <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./userCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                   <li class="page-item">
                                      <a  class="page-link border-white bg-white text-dark" href="./userCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:otherwise>
                             </c:choose>
                             
                              <c:forEach begin="${startPage}" end="${endPage}" var="index">
                                    <c:choose>   
                                       <c:when test="${index == currentPage }">
                                          <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="./userCouponPage?page=${index}">${index}</a></li>
                                       </c:when>
                                       <c:otherwise>
                                          <li class="page-item"><a class="page-link bg-white border-white text-dark" href="./userCouponPage?page=${index}">${index}</a></li>
                                       </c:otherwise>
                                    </c:choose>
                              </c:forEach>
                              <c:choose>
                                 <c:when test="${endPage >= totalPage}">                                 
                                     <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./userCouponPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
                                   </li>
                                 </c:when>
                                 <c:otherwise>
                                     <li class="page-item">
                                      <a class="page-link border-white bg-white text-dark" href="./userCouponPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
                                   </li>
                                 </c:otherwise>
                              </c:choose>
                     
                  </ul>

                          </nav>
                        <div class="row mt-5 mb-3" style="margin-top : 20px; margin-left : 10px;">
                            <div class="col-3 fs-3 fw-semibold">
                            사용완료 쿠폰
                        </div>
                        <div class="col pt-3 ps-0 text-start">
                            사용완료, 삭제된 쿠폰을 조회합니다
                        </div>
                        </div>
                         <table class="table" style="margin-top : 20px;">
                            <thead>
                             <tr style="text-align:center;">
                                <th scope="col">번호</th>
                                <th scope="col">이미지</th>
                                <th scope="col">쿠폰명</th>
                                <th scope="col">쿠폰내용</th>
                                <th scope="col">할인율(%)</th>
                                <th scope="col">수량</th>
                                <th scope="col">배포 기간</th>
                                <th scope="col">사용 기간</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${notExistUserCouponList}" var="map">
                                 <tr style="text-align:center;">
                                   <th scope="row" style="vertical-align: middle;">${map.couponDto.id}</th>
                                   <td><img src="/uploadFiles/${map.couponDto.coupon_image}" style="width:50px; height:50px;"></td>
                                    <td style="vertical-align: middle;">${map.couponDto.coupon_name}</td>
                                    <td style="vertical-align: middle;">${map.couponDto.coupon_context}</td>
                                    <td style="vertical-align: middle;">${map.couponDto.coupon_discount}</td>
                                    <td style="vertical-align: middle;">${map.couponDto.coupon_count}</td>
                                    <td style="vertical-align: middle;"><fmt:formatDate value="${map.couponDto.coupon_startdate}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${map.couponDto.coupon_enddate }" pattern="yy.MM.dd"/></td>
                                    <td style="vertical-align: middle;"><fmt:formatDate value="${map.couponDto.coupon_issue_start}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${map.couponDto.coupon_issue_end }" pattern="yy.MM.dd"/></td>
                                </tr>
                             </c:forEach>
                            </tbody>
                            </table>
                            <nav aria-label="...">
                                
                                  <ul class="pagination pagination-sm justify-content-center">       
                     
                              <c:choose>
                                <c:when test="${startPages <= 1}">
                                   <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./userCouponPage?page=${startPages-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                   <li class="page-item">
                                      <a  class="page-link border-white bg-white text-dark" href="./userCouponPage?page=${startPages-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:otherwise>
                             </c:choose>
                             
                              <c:forEach begin="${startPages}" end="${endPages}" var="indexs">
                                    <c:choose>   
                                       <c:when test="${indexs == currentPages }">
                                          <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold"  href="./userCouponPage?pageNum=${indexs}">${indexs}</a></li>
                                       </c:when>
                                       <c:otherwise>
                                          <li class="page-item"><a class="page-link bg-white border-white text-dark" href="./userCouponPage?pageNum=${indexs}">${indexs}</a></li>
                                       </c:otherwise>
                                    </c:choose>
                              </c:forEach>
                              <c:choose>
                                   <c:when test="${endPages >= totalPages}">
                                     <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./userCouponPage?pageNum=${endPages + 1}"><i class="bi bi-chevron-right"></i></a>
                                   </li>
                                 </c:when>
                                 <c:otherwise>
                                     <li class="page-item">
                                      <a class="page-link border-white bg-white text-dark" href="./userCouponPage?pageNum=${endPages + 1}"><i class="bi bi-chevron-right"></i></a>
                                   </li>
                                 </c:otherwise>
                              </c:choose>
                     
                  </ul>
                                
                              </nav>
                     </div>
                     </div>
                  </div>
               </div>
                  </div>
               </div>
               
         <div class="col-2"></div>
      </div>
      </div>
      <br>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>