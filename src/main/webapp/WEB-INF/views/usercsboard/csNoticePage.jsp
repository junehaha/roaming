<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous"><title>qa_board</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<style>
.scroll {
		overflow: auto;
		height: 700px;
		}

 .list:hover {
 background-color: rgb(240, 240, 240);
 	}

</style>
<body>
<jsp:include page="../common/topNavi.jsp"/>
	<div class="container">
		<div class="row mt-5">
			<div class="col-2">
				<div class = "row">
					<div class = "col mx-4 border border-black text-center">
						<div class = "row py-3">
							<div class="col fs-4">고객센터</div>
						</div>
						<div class="row list py-2" style="background-color: rgb(240, 240, 240);">
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./csNoticePage">공지사항</a>
							</div>
						</div>
						<div class="row list py-2">
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./faqPage">자주하는 질문</a>
							</div>
						</div>
						<div class="row list mb-3 py-2">
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./qaBoardPage">묻고 답하기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-8 scroll">
				
				<div class="row mb-2 border-bottom border-black border-2">
					<div class="col ">
						<h3>공지사항</h3>
					</div>
				</div>
				
				<div class="row mt-3">
					<div class="col">
						<table class="table table-hover text-center">
							<thead >
								<tr>
									<th scope="col" width="60">번호</th>
									<th scope="col" width="620">제목</th>
									<th scope="col" width="120">작성일</th>
									<th scope="col" width="80">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${noticeList}" var="noticeLists">
								<tr>
									<td>${noticeLists.csNoticeDto.id }</td>
									<td class="text-start ps-4">
										<a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover" href="./readCsNoticePage?id=${noticeLists.csNoticeDto.id}">
										${noticeLists.csNoticeDto.notice_title}
										</a>
									</td>
									<td><fmt:formatDate value="${noticeLists.csNoticeDto.reg_date}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
									<td>${noticeLists.csNoticeDto.notice_read_count}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
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
				                            <li class="page-item disabled"><a
				                                    class="page-link bg-white border-white text-dark fw-semibold" href="./manageCouponPage?page=${index}">1</a></li>
				                        </c:when>
				                        <c:otherwise>
				                            <li class="page-item disabled"><a class="page-link bg-white border-white text-dark" href="./manageCouponPage?page=${index}">1</a></li>
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
				
				<div class="row">
				    <div class="col-2"></div>
				    <div class="col-2 pe-0">
				        <select name="searchType" class="form-select">
				            <option value="qa_title">제목</option>
				            <option value="qa_content">내용</option>
				        </select>
				    </div>
				    <div class="col-5 text-center ps-1">
				        <input type="text" name="searchWord" class="form-control" placeholder="검색할 내용을 입력하세요">
				    </div>
				    <div class="col-1 text-start ps-0">
				        <button class="btn btn-dark fw-semibold" style="border-radius: 0px;">
				            검색
				        </button>
				    </div>
				    <div class="col-2"></div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</html>