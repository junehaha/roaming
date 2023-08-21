<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>updateQaBoardPage</title>
<style>
 .table{
 	vertical-align: middle;
    border-radius: 4px; 
    overflow: hidden;
  }
  .table td{
  	padding : 12px 16px;
  }
</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"/>
	<div class="container">
		<div class="row my-5">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row mb-2 fs-4">
					<div class="col"><i class="bi bi-pencil me-2"></i> 문의글 수정하기</div>
				</div>
				<form action="./updateQaBoardProcess" method="post" enctype="multipart/form-data" >
					<div class="row mt-2">
						<table class="table table-bordered">
							<tr>
								<td class="table-active text-center">글번호</td>
								<td>${qaContent.qaBoard.id }<input type="hidden" value="${qaContent.qaBoard.id }" name="id"></td>
							</tr>
							<tr>
								<td class="table-active text-center"><label for="qa_title">제목</label></td>
								<td><input type="text" class="form-control" value="${qaContent.qaBoard.qa_title}" id="qa_title" name="qa_title"></td>
							</tr>
							<tr>
								<td class="table-active text-center">작성자</td>
								<td>
									${qaContent.user.user_name }
								</td>
							</tr>
							<tr>
								<td class="table-active text-center">비밀글여부</td>
								<td>
									<label for="qa_secret"><input type="radio" id="qa_secret" name="qa_secret"  value="N" checked>공개</label>
									<label for="qa_secret"><input type="radio" id="qa_secret" name="qa_secret"  value="Y">비공개</label>
								</td>
							</tr>
							<tr>
								<td class="table-active text-center"><label for="qa_category_id">분류</label></td>
								<td>
									<select id="qa_category_id" name="qa_category_id">
										<option value="1" >숙소예약</option>
										<option value="2" >커뮤니티</option>
										<option value="3" >동행찾기</option>
										<option value="4" >포인트샵</option>
										<option value="5" >짐서비스</option>
										<option value="6" >기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="table-active text-center">
									<label for="qa_content">내용</label>
								</td>
								<td>
									<textarea class="form-control" id="qa_content" name="qa_content" style="height: 100px">${qaContent.qaBoard.qa_content}</textarea>
								</td>
							</tr>
							<tr>
								<td class="table-active text-center"><label for="image_link">첨부이미지</label></td>
								<td>
									<input type="file" name="image_link" id="image_link" multiple accept="image/*" class="form-control">
								</td>
							</tr>							
						</table>
					</div>
					
					<div class="row d-flex flex-row-reverse">
						<div class="col-1">
							<button class="btn btn-sm form-control" style="background-color: #46B8FF !important; color : white;">수정</button>
						</div>
						<div class="col-1">
							<a class="btn btn-danger btn-sm form-control" href="./qaBoardPage" role="button">취소</a>
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
