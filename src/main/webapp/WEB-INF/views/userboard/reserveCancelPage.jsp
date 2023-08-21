<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script>
function closePopup() {
	  window.close(); 
}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>			<jsp:include page="../common/topNavi.jsp"></jsp:include>

<div class="container-fluid">

	<div class="row mt-5 mb-5">
		<div class="col text-center fs-1 fw-semibold">
			결제를 취소하였습니다.
		</div>
	</div>
	<div class="row mt-5">
		<div class="col-4"></div>
		<div class="col text-center">
			<button type="button" class="btn btn-outline-dark" onclick="closePopup()">창닫기</button></div>

		<div class="col-4"></div>
	</div>
</div>




<jsp:include page="../common/footer.jsp"></jsp:include>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>