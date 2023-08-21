<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-YRLavGFsbRvOt1HiU3wz8M7rmSQ3ZjOxO9q2lBfo6koz6CePuC1/ErZuxMbyGxO4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
<head>

<meta charset="UTF-8">
<title>adminReportPage</title>

<style>
    .custom-tooltip-container {
       position: relative;
       cursor: pointer;
    }
 
    .custom-tooltip-content {
       position: absolute;
       top: 100%;
       left: 50%;
       transform: translateX(-50%);
       display: none;
       z-index: 999;
       width: 200px; 
       padding: 10px;
       background-color: #808080;
       color: #fff;
       border-radius: 8px;
       font-size: 14px;
    }
 
    .custom-tooltip-container:hover .custom-tooltip-content {
       display: block;
    }
    
   </style>
 <title>adminReportPage</title>
 <script>
 $(function () {
    $('[data-bs-toggle="tooltip"]').tooltip();
 });
 </script>
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

            <div class="row mt-5">
                <div class="col-1"></div>
                <div class="col text-secondary fw-bold fs-5">신고 관리</div>
             </div>

             <div class="row mt-4">
                <div class="col-2"></div>
                <div class="col  pb-0">
                   <a href="../adminboard/adminReportPage" style="text-decoration: none; color: inherit;">
                      <i class="bi bi-truck fs-4 text-secondary pt-5"></i>
                      <span class="ps-3 text-primary adminSideNavText pt-0">신고관리</span>
                   </a>
                </div>
             </div>
         </div>
             

         <div class="col px-5">
            <div class="row mt-5 px-4">
                <div class="col">
                    <h3><i class="bi bi-clipboard me-2"></i> 신고 관리</h3>		
                </div>
            </div>
            <div class="row mt-4 px-4">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-header text-center">
                            <div class="row">
                                <div class="col-1">번호</div>
                                <div class="col-2">게시물번호</div>
                                <div class="col-3">제목</div>
                                <div class="col-2">신고이미지</div>
                                <div class="col-1">신고자</div>
                                <div class="col-2">신고일</div>
                                <div class="col-1"></div>
                            </div>
                        </div>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${reportList}" var="reportList">
                                <li class="list-group-item">
                                <form action="./adminDeleteReportProcess" method="post" >
                                    <input type="hidden" name="id" value="${reportList.reportDto.post_id }">
                                    <div class="row text-center">
                                        <div class="col-1">
                                            <div class="row">
                                                <div class="col">
                                                    ${reportList.reportDto.id }
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">
                                                    ${reportList.reportDto.post_id }
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="row">
                                                <div class="col">
                                                    <div class="custom-tooltip-container">
                                                        ${reportList.reportDto.title}
                                                        <div class="custom-tooltip-content">
                                                           ${reportList.reportDto.content}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-2">	
                                            <div class="row">
                                                <div class="col">
                                                    <button type="button" class="btn btn-dark btn-sm" style="font-size:12px;" data-bs-toggle="modal" data-bs-target="#imageModal${reportList.reportDto.id}">
                                                        이미지보기
                                                    </button>
                                                </div>
                                            </div>
                                            <!-- 모달창 -->
                                            <div class="modal fade" id="imageModal${reportList.reportDto.id }" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-secondary bg-opacity-10">
                                                            <h5 class="modal-title" id="ModalLabel">신고이미지</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <img src="/uploadFiles/${reportList.reportDto.image}" alt="신고 이미지" class="img-fluid">
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-1">
                                            <div class="row">
                                                <div class="col">
                                                    ${reportList.userDto.user_name}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="row">
                                                <div class="col">
                                                    <fmt:formatDate value="${reportList.reportDto.reg_date}" pattern="yyyy-MM-dd"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-1">
                                            <div class="row">
                                                <div class="col m-0">
                                                    <button type="submit" class="btn btn-danger btn-sm" style="font-size:12px;" onclick="alert('삭제되었습니다')">해당글삭제</button>
                                                </div>
                                            </div>
                                        </div>											
                                    </div>
                                </form>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>


            <div class="row mt-3 px-4"><!-- 가짜 버튼 -->
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
                <div class="col-2">
                </div>
            </div>
            
            <form action="#" method="get">
			<div class="row">
			    <div class="col-3"></div>
			    <div class="col-1 pe-0">
			        <select name="searchType" class="form-select">
			            <option value="qa_title">제목</option>
			            <option value="qa_content">내용</option>
			        </select>
			    </div>
			    <div class="col-4 text-center ps-1">
			        <input type="text" name="searchWord" class="form-control" placeholder="검색할 내용을 입력하세요">
			    </div>
			    <div class="col-1 text-start ps-0">
			        <button class="btn btn-dark fw-semibold" style="border-radius: 0px;">
			            검색
			        </button>
			    </div>
			    <div class="col-3"></div>
			</div>
            </form>


        </div>
    </div>
</div>

</body>
</html>