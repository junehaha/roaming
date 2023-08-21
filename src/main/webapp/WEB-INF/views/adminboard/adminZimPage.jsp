<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<head>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<meta charset="UTF-8">
<title>adminZimPage</title>

<style>
</style>

</head>
<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col-2 scroll-container bg-secondary bg-opacity-10 fw-semibold" style="background-color: #dfe5ed;">

            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">관리자 </div>
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
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">신청 관리</span>
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
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">쿠폰 관리</span>
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
            </div> 
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">짐 관리</div>
            </div>
            
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="../adminboard/adminZimPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-truck fs-4 text-secondary pt-5"></i>
                     <span class="text-primary ps-3 text-gray-soft adminSideNavText pt-0">짐 배송 관리</span>
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

            <div class="row mt-5">
                <div class="col-1"></div>
                <div class="col text-secondary fw-bold fs-5">신고 관리</div>
             </div>

             <div class="row mt-4">
                <div class="col-2"></div>
                <div class="col  pb-0">
                   <a href="../adminboard/adminReportPage" style="text-decoration: none; color: inherit;">
                      <i class="bi bi-truck fs-4 text-secondary pt-5"></i>
                      <span class="ps-3 text-gray-soft adminSideNavText pt-0">신고관리</span>
                   </a>
                </div>
             </div>
         </div>
             

         <div class="col px-5">
            <div class="row mt-5 px-4">
                <div class="col">
                    <h3><i class="bi bi-truck me-2"></i> 짐 배송 관리</h3>(주문자정보 클릭시 상세보기)				
                </div>
            </div>
            <div class="row mt-4 px-4">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-header text-center">
                            <div class="row fw-semibold">
                                <div class="col-1">번호</div>
                                <div class="col-2">신청일</div>
                                <div class="col-2">배송시간</div>
                                <div class="col-2">배송장소</div>
                                <div class="col-2">주문자정보</div>
                                <div class="col-2">진행상태</div>
                                <div class="col-1"></div>
                            </div>
                        </div>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${list}" var="lists">
                                <li class="list-group-item">
                                <form action="./updateZimProgress" method="post" >
                                    <input type="hidden" name="id" value="${lists.signUpDto.id }">
                                    <div class="row d-flex text-center align-items-center">
                                        <div class="col-1 py-3 fw-semibold">
                                            <div class="col">${lists.signUpDto.id }</div>
                                        </div>
                                        <div class="col-2"><fmt:formatDate value="${lists.signUpDto.zim_reg_date}" pattern="yyyy-MM-dd"/></div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col ">${lists.signUpDto.start_date.year}-<c:if test="${lists.signUpDto.start_date.monthValue < 10}">0</c:if>${lists.signUpDto.start_date.monthValue}-<c:if test="${lists.signUpDto.start_date.dayOfMonth < 10}">0</c:if>${lists.signUpDto.start_date.dayOfMonth} 
                                                                <c:if test="${lists.signUpDto.start_date.hour < 10}">0</c:if>${lists.signUpDto.start_date.hour}:<c:if test="${lists.signUpDto.start_date.minute < 10}">0</c:if>${lists.signUpDto.start_date.minute} 픽업</div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col ">${lists.signUpDto.arrive_date.year}-<c:if test="${lists.signUpDto.arrive_date.monthValue < 10}">0</c:if>${lists.signUpDto.arrive_date.monthValue}-<c:if test="${lists.signUpDto.arrive_date.dayOfMonth < 10}">0</c:if>${lists.signUpDto.arrive_date.dayOfMonth} 
                                                                <c:if test="${lists.signUpDto.arrive_date.hour < 10}">0</c:if>${lists.signUpDto.arrive_date.hour}:<c:if test="${lists.signUpDto.arrive_date.minute < 10}">0</c:if>${lists.signUpDto.arrive_date.minute} 도착</div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col text-truncate">${lists.signUpDto.start_address} 에서</div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col text-truncate">${lists.signUpDto.arrive_address} 까지</div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <a href="../userzim/zimDetailInfoPage?signUpId=${lists.signUpDto.id}" class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover">
                                                <div class="row">
                                                    <div class="col">${lists.userDto.user_name}</div>
                                                </div>
                                                <div class="row mt-1">
                                                    <div class="col">${lists.userDto.phone_number}</div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">
                                                    <select class="form-select" name="zim_progress">
                                                        <option selected>${lists.signUpDto.zim_progress}</option>
                                                        <c:if test="${lists.signUpDto.zim_progress eq '배송준비중'}">
                                                            <option value="배송중">배송중</option>
                                                            <option value="배송완료">배송완료</option>
                                                        </c:if>
                                                        <c:if test="${lists.signUpDto.zim_progress eq '배송중'}">
                                                            <option value="배송완료">배송완료</option>
                                                        </c:if>
                                                        <c:if test="${lists.signUpDto.zim_progress eq '배송완료'}">
                                                        </c:if>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-1">
                                            <c:choose>
                                                <c:when test="${lists.signUpDto.zim_progress eq '배송완료'}">
                                                </c:when>
                                                <c:otherwise>
                                                    <input class="btn btn-dark" type="submit" value="변경">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </form>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            
			<div class="row mt-3 px-4">
			    <div class="col-2"></div>
			    <div class="col-8 text-center">
			        <nav aria-label="Page navigation example">
			            <ul class="pagination pagination-sm justify-content-center">
			
			                <c:choose>
			                    <c:when test="${startPage <= 1}">
			                        <li class="page-item disabled">
			                            <a class="page-link border-white bg-white text-dark"
			                                href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
			                        </li>
			                    </c:when>
			                    <c:otherwise>
			                        <li class="page-item disabled">
			                            <a class="page-link border-white bg-white text-dark"
			                                href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
			                        </li>
			                    </c:otherwise>
			                </c:choose>
			
			                <c:forEach begin="${startPage}" end="${endPage}" var="index">
			                    <c:choose>
			                        <c:when test="${index == currentPage }">
			                            <li class="page-item acitve"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>
			                        </c:when>
			                        <c:otherwise>
			                            <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>
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
			                        <li class="page-item disabled">
			                            <a class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
			                        </li>
			                    </c:otherwise>
			                </c:choose>
			
			            </ul>
			        </nav>
			    </div>
			</div> 			
            
            
            <div class="row mt-5 px-4">
                <div class="col">
                    <h3><i class="bi bi-clipboard me-2"></i> 변경 이력</h3>					
                </div>
            </div>
            
            <div class="row mt-4 px-4 ">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-header text-center fw-semibold">
                            <div class="row">
                                <div class="col-2">신청번호</div>
                                <div class="col-2">변경일</div>
                                <div class="col-2">주문자정보</div>
                                <div class="col-2">관리자ID</div>
                                <div class="col-4">변경사항</div>
                            </div>
                        </div>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${changeList}" var="changeLists">
                                <li class="list-group-item">
                                    <div class="row d-flex text-center align-items-center">
                                        <div class="col-2 fw-semibold">
                                            <div class="row"><div class="col">${changeLists.signUpDto.id }</div></div>
                                        </div>
                                        <div class="col-2"><fmt:formatDate value="${changeLists.zimManageList.delivery_reg_date}" pattern="yyyy-MM-dd HH:mm"/></div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">${changeLists.userDto.user_name}</div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col">${changeLists.userDto.phone_number}</div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">${changeLists.adminDto.admin_id}</div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="row">
                                                <div class="col">
                                                    ${changeLists.zimManageList.zim_prog_before} <i class="bi bi-arrow-right"></i>
                                                    ${changeLists.zimManageList.zim_prog_after}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            
				<div class="row mt-3 px-4">
				    <div class="col-2"></div>
				    <div class="col-8 text-center">
				        <nav aria-label="Page navigation example">
				            <ul class="pagination pagination-sm justify-content-center">
				
				                <c:choose>
				                    <c:when test="${startPage <= 1}">
				                        <li class="page-item disabled">
				                            <a class="page-link border-white bg-white text-dark"
				                                href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
				                        </li>
				                    </c:when>
				                    <c:otherwise>
				                        <li class="page-item disabled">
				                            <a class="page-link border-white bg-white text-dark"
				                                href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
				                        </li>
				                    </c:otherwise>
				                </c:choose>
				
				                <c:forEach begin="${startPage}" end="${endPage}" var="index">
				                    <c:choose>
				                        <c:when test="${index == currentPage }">
				                            <li class="page-item acitve"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>
				                        </c:when>
				                        <c:otherwise>
				                            <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>
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
				                        <li class="page-item disabled">
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

</body>
</html>