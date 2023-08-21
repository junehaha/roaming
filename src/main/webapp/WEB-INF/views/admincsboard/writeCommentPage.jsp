<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>writeCommentPage</title>
<style>
 .table{
    border-radius: 4px; 
    overflow: hidden;
  }
</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"/>
	<div class="container">
		<div class="row my-5">
			<div class="col-2"></div>
			<div class="col-8">
					<div class="row mb-2">
						<div class="col">
							<h3><i class="bi bi-book me-2"></i> 문의글 읽기</h3>
						</div>
					</div>
					<div class="row">
						<table class="table table-bordered">
							<tr>
								<td class="table-active text-center">글번호</td>
								<td>${qaContent.qaBoard.id }</td>
							</tr>
							<tr>
							<td class="table-active text-center">작성일</td>
							<td>
							<fmt:formatDate value="${qaContent.qaBoard.qa_reg_date}" pattern="yyyy-MM-dd"/>
							</td>
							</tr>
							<tr>
								<td class="table-active text-center"><label for="qa_title">제목</label></td>
								<td>${qaContent.qaBoard.qa_title }</td>
							</tr>
							<tr>
								<td class="table-active text-center">작성자</td>
								<td>${qaContent.user.user_name }</td>
							</tr>
							
							<tr>
								<td class="table-active text-center"><label for="qa_category_id">구분</label></td>
								<td>
									${qaContent.category.qa_category_name }
								</td>
							</tr>
							<tr>
								<td class="table-active text-center" style="height : 120px; width : 150px; vertical-align: middle;">
									<label for="qa_content">내용</label>
								</td>
								<td style="height : 120px; width : 450px;">
									<c:forEach items="${qaContent.images}" var="image">
										<img src="/uploadRoamingFiles/${image.image_link}" class="img-fluid"><br>
									</c:forEach>
									
									<c:if test="${qaContent.qaBoard.qa_content != null}">
										${qaContent.qaBoard.qa_content }
									</c:if>
								</td>
							</tr>
						</table>
					</div>
					<div class="row mt-5 mb-2">
						<div class="col">
							<h3><i class="bi bi-clipboard-check me-2"></i> 문의글 답하기</h3>
						</div>
					</div>
					<form action="./writeCommentProcess" method="post">
					<div class="row">
						<table class="table table-bordered">
						
							<tr>					
								<td class="table-active text-center"><label for="qa_category_id">구분</label></td>
								<td>
									${qaContent.category.qa_category_name }
								</td>
							</tr>
							<tr> 
								<td class="table-active text-center">답변자</td>
								<td>${sessionAdmin.admin_id}</td>
							</tr>
							<tr>
								<td class="table-active text-center" style="height : 150px; width : 150px; vertical-align: middle;">
									<label for="qa_content">내용</label>
								</td>
								<td style="height : 200px; width : 450px;">
									<input type="hidden" name="id" value="${qaContent.qaBoard.id }">
									<textarea class="form-control" placeholder="답변내용을 입력해주세요" name="qa_comment_content" style="height : 100%;"></textarea>
								</td>
							</tr>
						
						</table>
					</div>
					<div class="row d-flex flex-row-reverse">
						<div class="col-2">
							<button class="btn btn-sm form-control" style="background-color: #46B8FF !important; color :white;">답변하기</button>
						</div>
						<div class="col-1">
							<a class="btn btn-danger btn-sm form-control" role="button" href="../usercsboard/readQaBoardPage?id=${qaContent.qaBoard.id}">취소</a>
						</div>
					</div>
					</form>
				</div>
				
			<div class="col-2"></div>
		</div>
	</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>