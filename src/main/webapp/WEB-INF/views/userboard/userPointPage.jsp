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
<title>포인트</title>
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
        .pagination li.page-item {
    background-color: white;
    border: none;
}

/* 페이지 번호를 검은색으로 설정 */
.pagination li.page-item a.page-link {
    color: black;
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
                           <a href="./userPointPage" style="font-size: 15px; color: #0078ff; text-decoration: none;">
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
                  <div class="row card-context"> 
                    <div class="card" style="width: auto; height: auto;">
                     <div class="row">
                     <div class="col">
                        <h4 class="mt-4">포인트 현황</h4>
                        <hr style="border: 1px solid black; font-weight: bold;" />
                     </div>
                     <table class="table" style="text-align: center;">
                        <thead>
                            <tr>
                                <th scope="col">현재 포인트</th>
                                <th scope="col">적립 포인트</th>
                                <th scope="col">사용한 포인트</th>
                                <th scope="col">소멸된 포인트</th>
                            </tr>
                        </thead>
                            <tbody>
                                <tr>
                                    <td scope="row"><fmt:formatNumber value="${myPage.myPoint}" pattern="#,###" var="formattedPrice" />
                                   ${formattedPrice} P</td>
                                    <td><fmt:formatNumber value="${userPoint.saveMyPoint}" pattern="#,###" var="formattedPrice" />
                                   ${formattedPrice} P</td>
                                    <td><fmt:formatNumber value="${userPoint.useMyPoint}" pattern="#,###" var="formattedPrice" />
                                   ${formattedPrice} P</td>
                                    <td>0</td>
                                </tr>
                            </tbody>
                     </table> 
                        <ul style="margin-left: 20px;">
                           <li style="color: gray;">포인트는 부여된 해로부터 5년 이내에 사용하셔야 합니다.</li>
                           <li style="color: gray; margin-top: 10px;">특정 이벤트 당첨 포인트는 이벤트 기한내에서만 사용이 가능하고 미사용 포인트는 소멸됩니다.</li>
                        </ul>
                        <div class="col">
                           <h4 class="mt-5">포인트 적립 및 사용</h4>
                           <span style="font-size: 0.8em;">포인트 적립 및 사용하신 내역입니다.</span>
                           <hr style="border: 1px solid black; font-weight: bold;" />
                        </div>
                        <table class="table" style="text-align: center;">
                           <thead>
                               <tr>
                                   <th scope="col">적용/예상일자</th>
                                   <th scope="col">적용상태</th>
                                   <th scope="col">적용내역</th>
                                   <th scope="col">포인트</th>
                                   <th scope="col">관련번호</th>
                               </tr>
                           </thead>
                               <tbody>
                               <c:forEach items="${userPointList}" var="map" >
                                   <tr>
                                       <td scope="row"><fmt:formatDate value="${map.pointDto.reg_date}" pattern="yy.MM.dd"/></td>
                                       <td>${map.pointDto.status}</td>
                                       <td>${map.pointDto.context}</td>
                                       <td><fmt:formatNumber value="${map.pointDto.point}" pattern="#,###" var="formattedPrice" />
                                   ${formattedPrice} P</td>
                                       <td>${map.pointDto.id}</td>
                                   </tr>
                                   </c:forEach>
                               </tbody>
                        </table>
                        <nav aria-label="...">
                             <ul class="pagination pagination-sm justify-content-center">       
                     
                        <c:choose>
                                <c:when test="${startPage <= 1}">
                                   <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./userPointPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                   <li class="page-item">
                                      <a  class="page-link border-white bg-white text-dark" href="./userPointPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:otherwise>
                             </c:choose>
                             
                              <c:forEach begin="${startPage}" end="${endPage}" var="index">
                                    <c:choose>   
                                       <c:when test="${index == currentPage }">
                                          <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="./userPointPage?page=${index}">${index}</a></li>
                                       </c:when>
                                       <c:otherwise>
                                          <li class="page-item"><a class="page-link bg-white border-white text-dark" href="./userPointPage?page=${index}">${index}</a></li>
                                       </c:otherwise>
                                    </c:choose>
                              </c:forEach>
                              <c:choose>
                                 <c:when test="${endPage >= totalPage}">                                 
                                     <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./userPointPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
                                   </li>
                                 </c:when>
                                 <c:otherwise>
                                     <li class="page-item">
                                      <a class="page-link border-white bg-white text-dark" href="./userPointPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
                                   </li>
                                 </c:otherwise>
                              </c:choose>
                     
                  </ul>

                          </nav>
                        <h6 style="margin-top: 30px;">포인트 사용기준 및 사용기한</h6>
                        <ul style="margin-left: 20px; margin-top: 10px;">
                           <li style="color: gray;">포인트는 부여된 해로부터 5년 이내에 사용하셔야 합니다.</li>
                           <li style="color: gray; margin-top: 10px;">특정 이벤트 당첨 포인트는 이벤트 기한내에서만 사용이 가능하고 미사용 적립금은 소멸됩니다.</li>
                           <li style="color: gray; margin-top: 10px;">포인트는 부여 된 순서로 사용 되며 해당 기간 내에 사용하지 않으실 경우, 잔여 포인트는 1년 단위로 매해 12월 31일 자동 소멸 됩니다.</li>
                        </ul>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>