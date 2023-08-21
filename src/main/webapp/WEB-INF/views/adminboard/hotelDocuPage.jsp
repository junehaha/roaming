<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<head>
<style>
        .pagination {
            justify-content: center;
        }
 </style>

<meta charset="UTF-8">
<title>신청 관리</title>
<script>
function getDocuModal(link) {
   const modal = bootstrap.Modal.getOrCreateInstance("#docuModal"+link)
   modal.show();
}

function getUpdateRefuseModal(id) {
   const modal = bootstrap.Modal.getOrCreateInstance("#updateRefuseModal")
   const hiddenId = document.getElementById("hiddenId")
   hiddenId.value = id;
   modal.show();
}
</script>
</head>
<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col">
           
         </div>
      </div>
      <div class="row">
         <div class="col-2 scroll-container bg-secondary bg-opacity-10 fw-semibold" style="background-color: #dfe5ed;">

            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">관리자 

</div>
            </div>
            <div class="row mt-4">
            <div class="col-2"></div>
            <div class="col  pb-0">
               <c:choose>
                  <c:when test="${!empty sessionAdmin}">
                     <a href="../admin/adminLogoutProcess" style="text-decoration: none; color: inherit;">
                        <i class="bi bi-power fs-4" style="color: gray;"></i>
                        <span class="ps-3 text-gray-soft adminSideNavText pt-0" >로그아웃</span>
                     </a>
                  </c:when>
                  <c:otherwise>
                     <a href="../admin/adminLoginPage" style="text-decoration: none; color: inherit;">
                        <i class="bi bi-power fs-4" style="color: black;"></i>
                        <span class="ps-3 text-gray-soft adminSideNavText pt-0"  >로그인</span>
                     </a>
                  </c:otherwise>
               </c:choose>
            </div>
         </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="./adminDashBoardPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">대시보드</span>
                  </a>
               </div>
            </div>

            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">판매자 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                <a href="./sellerNoticePage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-clipboard fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">공지사항</span>
                </a>
               </div>
            </div>
             <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
               <a href="./hotelDocuPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-check-circle fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0 text-primary">신청 관리</span>
               </a>
               </div>
            </div>
            
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">쿠폰 및 상품 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
               <a href="./manageCouponPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-ticket fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0 ">쿠폰 관리</span>
               </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
               <a href="./manageItemPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-bag fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">상품 관리</span>
               </a>
               </div>
               
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">짐 관리</div>
            </div>
            
            </div>
               <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="../adminboard/adminZimPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-truck fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">짐 배송 관리</span>
                  </a>
               </div>
            </div>
            
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">고객게시판 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                 <a href="../admincsboard/adminCsNoticePage" style="text-decoration: none; color: inherit;">
                    <i class="bi bi-clipboard fs-4 text-secondary pt-5"></i>
                    <span class="ps-3 text-gray-soft adminSideNavText pt-0">공지사항</span>
                 </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="../admincsboard/adminFaqPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">자주묻는 질문</span>
                    </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="../admincsboard/adminQaBoardProgressPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">문의게시판</span>
                  </a>
               </div>
            </div>
         </div>
<!--           <div class="col-1 bg-secondary bg-opacity-10"></div>
 -->         <div class="col px-5">
         <div class="row mt-5 px-4">
            <div class="col fw-semibold fs-3">
               <i class="bi bi-check-circle me-2"></i>신청 관리   
            </div>
         </div>
         <div class="row mt-4 px-4">
            <div class="col">
               <div class="card border-2">
                  <div class="row fw-semibold text-center mx-0 mt-0 fs-5 bg-secondary bg-opacity-10">
                     <div class="col border-end border-2 py-2">번호</div>
                     <div class="col border-end border-2 py-2">카테고리</div>
                     <div class="col border-end border-2 py-2">숙소사진</div>
                     <div class="col border-end border-2 py-2">숙소명</div>
                     <div class="col border-end border-2 py-2">숙소위치</div>
                     <div class="col border-end border-2 py-2">숙소번호</div>
                     <div class="col ps-3 border-end border-2 py-2">서류</div>
                     <div class="col border-end border-2 py-2">등록일</div>
                     <div class="col  py-2">승인/거절</div>
                  </div>
                  <c:forEach items="${list}" var="map">
                     <c:if test="${map.docu_status ne '승인완료' && map.docu_status ne '승인거절'}">
                  
                  <div class="row text-center mx-0 my-0 border-top border-2 py-2">
                     <div class="col fw-semibold pt-4 fs-6">${map.id}</div>
                     <div class="col  pt-4">${map.category}</div>
                     <div class="col"><img src="/uploadFiles/${map.hotel_img}" style="width:80px; height:80px;"></div>
                     <div class="col fw-semibold pt-4 fs-6">${map.hotel_name}</div>
                     <div class="col  small pt-3">${map.hotel_loc}</div>
                     <div class="col pt-4 fs-6">${map.hotel_tel}</div>
                     <div class="col mt-4">
                      <a class="btn btn-outline-dark me-2 btn-sm" onclick="getDocuModal('${map.docu_link}')">제출서류</a>
                     </div>
                     <div class="col pt-4 "><fmt:formatDate value="${map.reg_date}" pattern="yy.MM.dd"/></div>
                            <div class="col mt-4">
                        <a href="./updateSellerAuthorityAcceptProcess?id=${map.id}" class="btn btn-dark me-2 btn-sm" role="button">승인</a>
                                    <a class="btn btn-danger me-2 btn-sm" style="border-radius: 5px;" onclick="getUpdateRefuseModal(${map.id})">거절</a>
                             </div>                  
                            </div>
                  
                  
                  
                  <div class="modal fade" id="docuModal${map.docu_link}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header border-white">
                                <h1 class="modal-title fs-3" id="staticBackdropLabel">${map.hotel_name}</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                <div class="form-floating mb-3"> 
                                  <img src="/uploadFiles/${map.docu_link}" style="max-width:100%; max-height:100%;" id="modalImage">
                                </div>
                              </div>
                            </div>
                          </div>
                     </div>
                  </c:if>
                  </c:forEach>
                  
               </div>
            </div>
         </div>

<div class="row mt-3 px-4"><!-- 임시 페이징 버튼 동작x -->
            <div class="col-2"></div>
            <div class="col-8 text-center">
               <nav aria-label="Page navigation example">
                  <ul class="pagination pagination-sm justify-content-center">
                     <c:choose>
                        <c:when test="${startPage <= 1}">
                           <li class="page-item disabled"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-left"></i></a></li>
                        </c:when>
                        <c:otherwise>
                           <li class="page-item"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-left"></i></a></li>
                        </c:otherwise>
                     </c:choose>
                     
                     <c:forEach begin="${startPage}" end="${endPage}" var="index">
                        <c:choose>
                           <c:when test="${index == currentPage}">
                              <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>                        
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     
                     <c:choose>
                        <c:when test="${endPage >= totalPage }">
                           <li class="page-item disabled"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-right"></i></a></li>
                        </c:when>
                        <c:otherwise>
                           <li class="page-item"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-right"></i></a></li>
                        </c:otherwise>
                     </c:choose>
                  </ul>
               </nav>
            </div>
            
         </div>

      </div>
         </div>
      </div>
      
      <!-- 거절 모달 -->
<form action="./updateSellerAuthorityRefuseProcess" method="post" enctype="multipart/form-data">
<div class="modal fade" id="updateRefuseModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-3" id="staticBackdropLabel">거절사유</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input type="hidden" name="id" id="hiddenId" >
        <div class="form-floating mb-3"> 
             <div class="row mb-3">
              <div class="col-auto d-flex align-items-center">              
                  <label for="floatingInput" class="form-label fs-5 mb-0">내용</label>
              </div>
              <div class="col">
                  <input type="text" name="docu_return" class="form-control form-control-lg" id="floatingInput" maxlength="10" style="width: 300px; " value="${data.couponDto.coupon_name}">
              </div>
            </div>
         </div>
      </div>
      <div class="modal-footer">
          <button class="btn btn-outline-primary">전송</button>
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>  
</form>    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"></script>    
</body>
</html>