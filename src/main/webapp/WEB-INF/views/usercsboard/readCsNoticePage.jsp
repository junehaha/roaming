<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>readCsNoticePage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<style>
 .table{
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
	<div class="row mt-5 mb-5">
		<div class="col-2"></div>
		<div class="col-8">
				<div class="row mb-2">
					<div class="col">
						<h3><i class="bi bi-clipboard me-2"></i> 공지사항</h3>		
					</div>
				</div>
				
				<div class="row">
					<table class="table table-bordered">
						<tr>
							<td class="table-active text-center">글번호</td>
							<td>${nPageContent.CsNoticeDto.id }</td>
						</tr>
						<tr>
							<td class="table-active text-center">작성일</td>
							<td>
							<fmt:formatDate value="${nPageContent.CsNoticeDto.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
							</td>
						</tr>
						<tr>
							<td class="table-active text-center">제목</td>
							<td>${nPageContent.CsNoticeDto.notice_title }</td>
						</tr>
						<tr>
							<td class="table-active text-center" style="height : 120px; width : 150px; vertical-align: middle;">
								내용
							</td>
							<td style="height : 120px; width : 450px;">
								<c:if test="${nPageContent.CsNoticeDto.notice_content != null}">
									${nPageContent.CsNoticeDto.notice_content }
								</c:if>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="row d-flex flex-row-reverse">
					<div class="col-1">
						<a class="btn btn-secondary btn-sm form-control" href="./csNoticePage" role="button">목록</a>
					</div>
				</div>
			</div>
		<div class="col-2"></div>
	</div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>