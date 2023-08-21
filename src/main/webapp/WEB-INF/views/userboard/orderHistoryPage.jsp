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
<title>주문 내역 조회</title>
<script>
function getWriteReviewModal(id) {
   const modal = bootstrap.Modal.getOrCreateInstance("#writeReviewModal")
   const hiddenId = document.getElementById("hiddenId")
   hiddenId.value = id;
   modal.show();
}
</script>
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
                           <a href="./orderHistoryPage" style="font-size: 15px; color: #0078ff; text-decoration: none;">
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
                     <div class="col-sm-9 text-left">
                  <div class="row card-context"> 
                     <div class="card" style="width: 100rem; ">
                      <div class="row mb-3" style="margin-top : 20px; margin-left : 10px;">
                        <div class="col-3 fs-3 fw-semibold">
                        주문 내역 조회
                        </div>
                        <div class="col pt-3 ps-0 text-start">
                            포인트샵 주문내역을 조회합니다
                        </div>
                    </div>
             <table class="table" style="margin-top : 20px;">
                <thead>
                    <tr style="text-align:center;">
                       <th scope="col">번호</th>
                        <th scope="col">이미지</th>
                        <th scope="col">상품명</th>
                        <th scope="col">수량</th>
                        <th scope="col">가격</th>
                        <th scope="col">상태</th>
                        <th scope="col">결제일</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                     <c:forEach items="${orderHistoryList}" var="map" >
                        <tr style="text-align:center;">
                           <th scope="row" style="vertical-align: middle;">${map.itemBuyDto.id}</th>
                              <td>
                          <a href="./itemDetailPage?id=${map.itemDto.id}">
                            <img src="/uploadFiles/${map.itemDto.item_thumbnail}" style="width:50px; height:50px;" />
                        </a>
                       </td>
                              <td style="vertical-align: middle;">${map.itemDto.item_name}</td>
                              <td style="vertical-align: middle;">${map.itemBuyDto.count}</td>
                              <td style="vertical-align: middle;">
                          <fmt:formatNumber value="${map.itemBuyDto.count * map.itemDto.item_price}" pattern="#,###" var="formattedPrice" />
                                   ${formattedPrice} P
                       </td>
                              <td style="vertical-align: middle;">${map.itemBuyDto.progress}</td>
                              <td style="vertical-align: middle;"><fmt:formatDate value="${map.itemBuyDto.reg_date}" pattern="yy.MM.dd"/></td>
                              <td style="vertical-align: middle;">
                      <div class="d-flex align-items-center">
                         <div>
                             <c:choose>
                                 <c:when test="${map.itemBuyDto.progress eq '리뷰작성완료'}">
                                    <!--  <button class="btn btn-outline-primary me-2 btn-sm" disabled>리뷰작성하기</button> -->
                                 </c:when>
                                 <c:otherwise>
                                 <a class="btn me-2 btn-sm" style="background-color: #46B8FF; color: #FFFFFF;" onclick="getWriteReviewModal(${map.itemBuyDto.id})">리뷰 작성</a>
                                    
                                 </c:otherwise>
                             </c:choose>
                         </div>
                     </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                  <div class="row mt-3 px-4">
            <div class="col-2"></div>
            <div class="col-8 text-center">
               <nav aria-label="Page navigation example">
                  <ul class="pagination pagination-sm justify-content-center">       
                     
                        <c:choose>
                                <c:when test="${startPage <= 1}">
                                   <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                   <li class="page-item">
                                      <a  class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                                    </li>
                                </c:otherwise>
                             </c:choose>
                             
                              <c:forEach begin="${startPage}" end="${endPage}" var="index">
                                    <c:choose>   
                                       <c:when test="${index == currentPage }">
                                          <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="./manageCouponPage?page=${index}">1</a></li>
                                       </c:when>
                                       <c:otherwise>
                                          <li class="page-item"><a class="page-link bg-white border-white text-dark fw-semibold" href="./manageCouponPage?page=${index}">1</a></li>
                                       </c:otherwise>
                                    </c:choose>
                              </c:forEach>
                              <c:choose>
                                 <c:when test="${endPage >= totalPage}">                                 
                                     <li class="page-item disabled">
                                      <a class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
                                   </li>
                                 </c:when>
                                 <c:otherwise>
                                     <li class="page-item">
                                      <a class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
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
                  </div>
               </div>
               
         <div class="col-2"></div>
      </div>
      </div>
      <br>
      
<!-- 리뷰작성 모달 -->
<form action="./insertItemReviewProcess" method="post">
<div class="modal fade" id="writeReviewModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-3" id="staticBackdropLabel">리뷰 작성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input type="hidden" name="item_buy_id" id="hiddenId" >
              <div class="form-check form-check-inline">
                 <input class="form-check-input" type="radio" name="star" id="inlineRadio1" value="1">
                 <label class="form-check-label" for="inlineRadio1"><i class="bi bi-star-fill text-warning"></i></label>
              </div>
              <div class="form-check form-check-inline">
                 <input class="form-check-input" type="radio" name="star" id="inlineRadio2" value="2">
                 <label class="form-check-label" for="inlineRadio2"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
              </div>
              <div class="form-check form-check-inline">
                 <input class="form-check-input" type="radio" name="star" id="inlineRadio3" value="3">
                 <label class="form-check-label" for="inlineRadio3"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
              </div>
              <div class="form-check form-check-inline">
                 <input class="form-check-input" type="radio" name="star" id="inlineRadio4" value="4">
                 <label class="form-check-label" for="inlineRadio4"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning" ></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
              </div>
              <div class="form-check form-check-inline">
                 <input class="form-check-input" type="radio" name="star" id="inlineRadio5" value="5">
                 <label class="form-check-label" for="inlineRadio5"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
              </div>
             <div class="row justify-content-left" style ="margin-top : 20px; margin-left : 20px;">
        <div class="form-floating">
            <textarea class="form-control" placeholder="서비스에 대한 평가를 남겨주세요" id="context" name="context" style="width: 400px; height: 100px"></textarea>
            <label for="reviewContent">상품에 대한 리뷰를 남겨주세요</label>
        </div>
         </div>
      </div>
      <div class="modal-footer">
          <button class="btn me-2 btn-sm" style="background-color: #46B8FF; color: #FFFFFF;">등록</button>
        <button type="button" class="btn btn-danger me-2 btn-sm" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
</form>
      
      
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>