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
<style>
tr.best {
    background-color: greenyellow !important;
}
</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"/>
	<div class="container">
		<div class="row mt-5">
			<div class="col-2">
				<!-- 왼쪽 사이드바 -->
				<div class = "row">
					<div class = "col mx-4 border border-black text-center">
						<div class = "row py-3">
							<div class="col fs-4">고객센터</div>
						</div>
						<div class="row list py-2">
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./csNoticePage">공지사항</a>
							</div>
						</div>
						<div class="row list py-2" >
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./faqPage">자주하는 질문</a>
							</div>
						</div>
						<div class="row list mb-3 py-2" style="background-color: rgb(240, 240, 240);">
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./qaBoardPage">묻고 답하기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-8">
				
				<div class="row mb-2 border-bottom border-black border-2">
					<div class="col text-start">
						<h3>묻고 답하기</h3>
					</div>
				</div>		
				
				<div class="row">
					<div class="col">
						<table class="table table-hover">
							<thead class="text-center">
								<tr>
									<th scope="col" width="60">번호</th>
									<th scope="col" width="100">구분</th>
									<th scope="col" width="360">제목</th>
									<th scope="col" width="80">작성자</th>
									<th scope="col" width="120">작성일</th>
									<th scope="col" width="80">조회수</th>
									<th scope="col" width="80">추천수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${bestFive}" var="bestFive" varStatus="loop">
									<c:if test="${loop.index <2 }">
										<tr class="table-light">
											<th class="text-center"><div class="col text-danger">Best</div></th>
											<td class="text-center">${bestFive.category.qa_category_name}</td>
											<td>
												<a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover" href="./readQaBoardPage?id=${bestFive.best.id}">
													${bestFive.best.qa_title}
													<c:if test="${bestFive.isRecent < 2}"><span style="font-size : 11px; color:red;">N</span></c:if>
												</a>
											</td>
											<td class="text-center">${bestFive.user.user_name}</td>
											<td class="text-center"><fmt:formatDate value="${bestFive.best.qa_reg_date}" pattern="yyyy-MM-dd"/></td>
											<td class="text-center">${bestFive.best.qa_read_count}</td>
											<td class="text-center">${bestFive.best.qa_recommend_count}</td>
										</tr>
									</c:if>
								</c:forEach>
								<c:forEach items="${qaList}" var="qaList">
								<tr>
									<th class="text-center">${qaList.qaBoard.id }</th>
									<td class="text-center">${qaList.category.qa_category_name}</td>
										<c:choose>
											
											<c:when test="${qaList.qaBoard.qa_secret == 'Y' && sessionUser.id != qaList.user.id}">
												<td>
													<i class="bi bi-lock-fill"></i>
													${qaList.qaBoard.qa_title}
														<c:if test="${qaList.isRecent < 2}"><span style="font-size : 11px; color:red;">N</span></c:if>
														<c:if test="${qaList.qaBoard.qa_comment_content != null}"><span style="font-size : 11px">[답변완료]</span></c:if>
												</td>
											</c:when>
											
											<c:when test="${qaList.qaBoard.qa_secret == 'Y' && sessionUser.id == qaList.user.id}">
												<td>
													<a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover" href="./readQaBoardPage?id=${qaList.qaBoard.id}">
													<i class="bi bi-lock-fill"></i>
													${qaList.qaBoard.qa_title}
														<c:if test="${qaList.isRecent < 2}"><span style="font-size : 11px; color:red;">N</span></c:if>
														<c:if test="${qaList.qaBoard.qa_comment_content != null}"><span style="font-size : 11px">[답변완료]</span></c:if>
													</a>
												</td>
											</c:when>											
																				
											<c:otherwise>
												<td>
													<a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover" href="./readQaBoardPage?id=${qaList.qaBoard.id}">
													${qaList.qaBoard.qa_title}
														<c:if test="${qaList.isRecent < 2}"><span style="font-size : 11px; color:red;">N</span></c:if>
														<c:if test="${qaList.qaBoard.qa_comment_content != null}"><span style="font-size : 11px">[답변완료]</span></c:if>
													</a>
												</td>
											</c:otherwise>
										</c:choose>
									<td class="text-center">${qaList.user.user_name}</td>
									<td class="text-center"><fmt:formatDate value="${qaList.qaBoard.qa_reg_date}" pattern="yyyy-MM-dd"/></td>
									<td class="text-center">${qaList.qaBoard.qa_read_count}</td>
									<td class="text-center">${qaList.qaBoard.qa_recommend_count}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row"><!-- 버튼 -->
					<div class="col-2"></div>
					<div class="col-8 text-center">
						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<c:choose>
									<c:when test="${startPage <= 1}">
										<li class="page-item disabled"><a class="page-link border-white bg-white text-dark" href="./qaBoardPage?page=${startPage-1}${searchQueryString}"><i class="bi bi-chevron-left"></i></a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link border-white bg-white text-dark" href="./qaBoardPage?page=${startPage-1}${searchQueryString}"><i class="bi bi-chevron-left"></i></a></li>
									</c:otherwise>
								</c:choose>
								
								<c:forEach begin="${startPage}" end="${endPage}" var="index">
									<c:choose>
										<c:when test="${index == currentPage}">
											<li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="./qaBoardPage?page=${index}${searchQueryString}">${index}</a></li>								
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link bg-white border-white text-dark" href="./qaBoardPage?page=${index}${searchQueryString}">${index}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
								<c:choose>
									<c:when test="${endPage >= totalPage }">
										<li class="page-item disabled"><a class="page-link border-white bg-white text-dark" href="./qaBoardPage?page=${endPage+1}${searchQueryString}"><i class="bi bi-chevron-right"></i></a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link border-white bg-white text-dark" href="./qaBoardPage?page=${endPage+1}${searchQueryString}"><i class="bi bi-chevron-right"></i></a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
					</div>
					<div class="col-2">
						<div>
							<c:if test="${!empty sessionUser}">
								<a href="./writeQaBoardPage" class="btn form-control btn-sm" role="button" style="background-color: #46B8FF !important; color : white;">글쓰기</a>
							</c:if>
						</div>
					</div>
				</div>
				
				<form action="./qaBoardPage" method="get">
				<div class="row mb-5">
					<div class="col-2"></div>
		            <div class="col-2 pe-0">
		               <select name="searchType" class="form-select">
		                  <option value="qa_title">제목</option>
		                  <option value="qa_content">내용</option>
		                  <option value="user_name">글쓴이</option>
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
				</form>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</html>