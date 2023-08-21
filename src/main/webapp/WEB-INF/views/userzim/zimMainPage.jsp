<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<title>zimMainPage</title>
<style>
   a {
      color: inherit;
      text-decoration: none;
   }
   .custom-col {
      flex: 0 0 33.333333%;
      max-width: 33.333333%;
   }
</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"/>

<div class="container-fluid">
    
    <div class="row mt-5 fs-2 fw-semibold text-center">
       <div class="col">짐 서비스를 소개합니다</div>
    </div>

   
    
    <div class="row mb-5">
       <div class="col-2"></div>
       <div class="col-8">
         <img src="/roaming/resources/img/zimMainBot.png" class="img-fluid">
      </div>
      <div class="col-2"></div>
    </div>
    
    
    <div class="row mb-5">
        <div class="col-2"></div>
        <div class="col-8">

         <div class="row mt-4 mb-5">
            <div class="col">
               
               <div class="row fs-2 fw-semibold text-center">
                  <div class="col">여행가방 걱정 끝</div>
               </div>
               <div class="row mt-3 fs-6 text-center">
                  <div class="col">여행할때, 집에서 숙소까지 캐리어를 운송해드립니다.</div>
               </div>
               <div class="row mt-2 fs-6 text-center">
                  <div class="col">무거운 캐리어는 맡기고 진정한 자유여행을 즐겨보세요!</div>
               </div>
             <div class="row mt-5">
                <div class="col-4 custom-col text-center">
                    <a href="../userzim/zimSignFirstPage">
                        <div class="row mx-2 fs-1">
                            <div class="col"><img src="../resources/img/zimIcon1.png" style="border-radius: 30px; height:148px"></div>
                        </div>
                        <div class="row mt-2 mx-2 fs-4">
                            <div class="col fw-semibold">STEP <span style="color: #50bcdf">01</span></div>
                        </div>
                        <div class="row mt-4 mx-2 fs-6">
                            <div class="col">홈페이지를 통해</div>
                        </div>
                        <div class="row mx-2 fs-5 fw-semibold">
                            <div class="col">간단하게 예약하세요!</div>
                        </div>
                    </a>
                </div>
            
                <div class="col-4 custom-col text-center border-start border-end border-info-subtle">
                    <a href="../userzim/zimSignFirstPage">
                        <div class="row mx-2 fs-1">
                            <div class="col"><img src="../resources/img/zimIcon2.png" style="border-radius: 30px; height:148px"></div>
                        </div>
                        <div class="row mt-2 mx-2 fs-4">
                            <div class="col fw-semibold">STEP <span style="color : #50bcdf">02</span></div>
                        </div>
                        <div class="row mt-4 mx-2 fs-6">
                            <div class="col">원하는 시간, 장소에서</div>
                        </div>
                        <div class="row mx-2 fs-5 fw-semibold">
                            <div class="col">맡기세요!</div>
                        </div>
                    </a>
                </div>
            
                <div class="col-4 custom-col text-center">
                    <a href="../userzim/zimSignFirstPage">
                        <div class="row mx-2 fs-1">
                            <div class="col"><img src="../resources/img/zimIcon3.png" style="border-radius: 30px; height:148px"></div>
                        </div>
                        <div class="row mt-2 mx-2 fs-4">
                            <div class="col fw-semibold">STEP <span style="color : #50bcdf">03</span></div>
                        </div>
                        <div class="row mt-4 mx-2 fs-6">
                            <div class="col">원하는 시간, 장소에서</div>
                        </div>
                        <div class="row mx-2 fs-5 fw-semibold">
                            <div class="col">찾으세요!</div>
                        </div>
                    </a>
                </div>
             </div>
            </div>
         </div>

       </div>
       <div class="col-2"></div>
      </div>


                 
    <div class="row mt-3 mb-5">
      <div class="col-1"></div>
      <div class="col-10">
         <div class="row mb-4 fs-1 text-center fw-semibold text-info-subtle">
            <div class="col">로밍 <span style="color: #46B8FF">짐서비스</span></div>
         </div>
         <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                   <div class="row fs-1 text-center">
                      <div class="col">
                     <c:if test="${avgStar >= 0 && avgStar < 1}"><small><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${avgStar  >= 1 && avgStar < 1.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning" ></i></small></c:if>
                     <c:if test="${avgStar  >= 1.5 && avgStar < 2}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${avgStar >= 2 && avgStar < 2.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
                     <c:if test="${avgStar  >= 2.5 && avgStar < 3}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${avgStar >= 3 && avgStar < 3.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
                     <c:if test="${avgStar >=3.5 && avgStar < 4}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${avgStar >= 4 && avgStar < 4.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
                     <c:if test="${avgStar >= 4.5 && avgStar < 5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i></small></c:if><c:if test="${avgStar >= 5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></small></c:if>
                  </div>
               </div>
                           
                 <div class="row my-4 text-center">
                    <div class="col">
                       <h3><strong>평균 평점 : <fmt:formatNumber value="${avgStar}"  pattern="0.0"></fmt:formatNumber>/5</strong></h3>
                    </div>
                 </div>
                           
                 <div class="row text-center">
                  
                 </div>
                           
               <div class="row mt-5">
                  <c:forEach items="${EightReview}" var="reviews">
                     <div class="col-lg-6">
                        <div class="mb-3">
                           <div class="card shadow-sm bg-body rounded card-gray flex-grow-1">
                              <div class="card-body px-4 py-4">
                                 <div class="row">
                                    <div class="col-lg-4 text-start">
                                       <div class="row fs-5 fw-bold">
                                          <div class="col">
                                             <strong>${reviews.userDto.user_name}</strong>
                                          </div>
                                       </div>
                                       <div class="row pb-1 small">
                                          <div class="col">
                                             <fmt:formatDate value="${reviews.review.review_reg_date }" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                                          </div>
                                       </div>
                                       <div class="row">
                                          <div class="col">
                                             <c:if test="${reviews.review.zim_star >= 0 && reviews.review.zim_star < 1}"><small><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${reviews.review.zim_star  >= 1 && reviews.review.zim_star < 1.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning" ></i></small></c:if>
                                                <c:if test="${reviews.review.zim_star  >= 1.5 && reviews.review.zim_star < 2}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${reviews.review.zim_star >= 2 && reviews.review.zim_star < 2.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
                                                <c:if test="${reviews.review.zim_star  >= 2.5 && reviews.review.zim_star < 3}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${reviews.review.zim_star >= 3 && reviews.review.zim_star < 3.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
                                                <c:if test="${reviews.review.zim_star >=3.5 && reviews.review.zim_star < 4}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if><c:if test="${reviews.review.zim_star >= 4 && reviews.review.zim_star < 4.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
                                                <c:if test="${reviews.review.zim_star >= 4.5 && reviews.review.zim_star < 5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i></small></c:if><c:if test="${reviews.review.zim_star >= 5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></small></c:if>                                             
                                          </div>
                                       </div>
                                       <div class="row">
                                          <div class="col-6 col-lg-12 pt-1 small">짐 ${reviews.zimAmount}개 배송</div>
                                       </div>
                                    </div>
                                    <div class="col-lg-8 text-start">
                                       <div class="row">
                                          <div class="col fs-6 fw-bold">${reviews.review.zim_review_title}</div>
                                       </div>
                                       <div class="row mt-2">
                                          <div class="col">
                                             ${reviews.review.zim_review_content}
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </c:forEach>
               </div>
            </div>
            <div class="col-2"></div>
         </div>
      </div>
      <div class="col-1"></div>
      </div>
                 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>