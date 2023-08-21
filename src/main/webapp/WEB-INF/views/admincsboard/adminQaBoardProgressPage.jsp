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
<title>adminQaBoardProgressPage</title>
<style>
	.buttonColor {
    background-color: #46B8FF    !important;
    color : white;
 	 }
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
                  <a href="../adminboard/adminDashBoardPage" style="text-decoration: none; color: inherit;">
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
                     <span class="ps-3 text-primary adminSideNavText pt-0">문의게시판</span>
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
                    <h3><i class="bi bi-question-circle me-2"></i> 처리중인 문의글</h3> 
                </div>
            </div>

            <div class="row mt-4 px-4">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-header text-center">
                            <div class="row fw-semibold">
                                <div class="col-1">번호</div>
                                <div class="col-2">구분</div>
                                <div class="col-3">제목</div>
                                <div class="col-2">작성자</div>
                                <div class="col-2">작성일</div>
                                <div class="col-2">조회수</div>
                            </div>
                        </div>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${qaProgressList}" var="qaProgressList">
                                <c:if test="${qaProgressList.qaProgress.qa_comment_content == null}">
                                <li class="list-group-item">
                                    <div class="row text-center">
                                        <div class="col-1 fw-semibold">
                                            <div class="col">${qaProgressList.qaProgress.id }</div>
                                        </div>
                                        <div class="col-2">${qaProgressList.category.qa_category_name}</div>
                                        <div class="col-3">
                                            <div class="row">
                                                <a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover text-truncate" href="../usercsboard/readQaBoardPage?id=${qaProgressList.qaProgress.id}">
                                                   ${qaProgressList.qaProgress.qa_title}
                                                   <c:if test="${qaProgressList.isRecent < 2}"><span style="font-size : 11px; color:red;">N</span></c:if>
                                                   <c:if test="${qaProgressList.qaProgress.qa_comment_content != null}"><span style="font-size : 11px">[답변완료]</span></c:if>
                                                </a>												
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">${qaProgressList.user.user_name}</div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col"><fmt:formatDate value="${qaProgressList.qaProgress.qa_reg_date}" pattern="yyyy-MM-dd"/></div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">${qaProgressList.qaProgress.qa_read_count}</div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col"></div>
                <div class="col-6">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <c:choose>
                                <c:when test="${startPage <=1}">
                                    <li class="page-item disabled"><a class="page-link" href="./adminQaBoardProgressPage?page=${startPage-1}">이전</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="./adminQaBoardProgressPage?page=${startPage-1}">이전</a></li>
                                </c:otherwise>
                            </c:choose>
                            
                            <c:forEach begin="${startPage }" end="${endPage }" var="index">
                                <c:choose>
                                    <c:when test="${index == currentPage}">
                                        <li class="page-item active"><a class="page-link" href="./adminQaBoardProgressPage?page=${index }">${index }</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="./adminQaBoardProgressPage?page=${index }">${index }</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:choose>
                                <c:when test="${endPage >= totalPage}">
                                    <li class="page-item disabled"><a class="page-link" href="./adminQaBoardProgressPage?page=${endPage+1}">다음</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="./adminQaBoardProgressPage?page=${endPage+1}">다음</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </nav>
                </div>
                <div class="col"></div>
            </div>
            
            
            
            <div class="row mt-5 px-4">
                <div class="col-4">
                    <h3><i class="bi bi-question-circle me-2"></i> 답변완료한 문의글</h3> 
                </div>
            </div>

            <div class="row mt-4 px-4">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-header text-center">
                            <div class="row fw-semibold">
                                <div class="col-1">번호</div>
                                <div class="col-2">구분</div>
                                <div class="col-3">제목</div>
                                <div class="col-2">작성자</div>
                                <div class="col-2">작성일</div>
                                <div class="col-2">조회수</div>
                            </div>
                        </div>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${qaCompleteList}" var="qaCompleteList">
                                <c:if test="${qaCompleteList.qaComplete.qa_comment_content != null}">
                                <li class="list-group-item">
                                    <div class="row text-center">
                                        <div class="col-1 fw-semibold">
                                            <div class="col">${qaCompleteList.qaComplete.id }</div>
                                        </div>
                                        <div class="col-2">${qaCompleteList.category.qa_category_name}</div>
                                        <div class="col-3">
                                            <div class="row">
                                                <a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover text-truncate" href="../usercsboard/readQaBoardPage?id=${qaCompleteList.qaComplete.id}">
                                                   ${qaCompleteList.qaComplete.qa_title}
                                                   <c:if test="${qaCompleteList.isRecent < 2}"><span style="font-size : 11px; color:red;">N</span></c:if>
                                                   <c:if test="${qaCompleteList.qaComplete.qa_comment_content != null}"><span style="font-size : 11px">[답변완료]</span></c:if>
                                                </a>												
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">${qaCompleteList.user.user_name}</div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col"><fmt:formatDate value="${qaCompleteList.qaComplete.qa_reg_date}" pattern="yyyy-MM-dd"/></div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">${qaCompleteList.qaComplete.qa_read_count}</div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col"></div>
                <div class="col-6">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <c:choose>
                                <c:when test="${startPage <=1}">
                                    <li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="#">이전</a></li>
                                </c:otherwise>
                            </c:choose>
                            
                            <c:set var="currentPage" value="1" />
                            <c:forEach begin="1" end="1" var="index">
                                <c:choose>
                                    <c:when test="${index == currentPage}">
                                        <li class="page-item active"><a class="page-link" href="#">${index }</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="#">${index }</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:choose>
                                <c:when test="${endPage >= totalPage}">
                                    <li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="#">다음</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </nav>
                </div>
                <div class="col"></div>
                
            </div>


        </div>
    </div>
</div>

</body>
</html>