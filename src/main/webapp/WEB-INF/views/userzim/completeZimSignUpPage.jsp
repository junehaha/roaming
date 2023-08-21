<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>completeZimSignUpPage</title>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"/>

<div class="container-fluid">
	<div class="row my-5">
		<div class="col-3"></div>
		<div class="col-6 my-5">
			<div class="row">
               <div class="col">
                  <div class="card shadow-sm mb-4">
                     <div class="card-body p-0">
                        <div class="row px-3 mt-4 text-center">
                           <div class="col fs-3 fw-semibold">
								고객님 결제가 완료되었습니다.
                           </div>
                        </div>
                        <div class="row px-3 my-4 text-center">
                           <div class="col fw-lighter">
								신청번호 : <fmt:formatDate value="${signUpDto.zim_reg_date }" pattern="yyyyMMdd"></fmt:formatDate>${signUpDto.id}
                           </div>
                        </div>
						<div class="row px-3">
                           <div class="col text-center">
								결제가 성공적으로 <span style="color:blue">완료</span>되었습니다.
                           </div>
                        </div>
						<div class="row mt-2 px-3">
                           <div class="col text-center">
								기타 궁금하신 사항은 고객센터로 문의주시면 성심껏 답변드리겠습니다. 
                           </div>
                        </div>
						<div class="row mt-2 mb-4 px-3">
                           <div class="col text-center">
								신청하신 정보는 마이페이지-배송신청내역에서 확인가능합니다.
                           </div>
                        </div>                        
                     </div>
                  </div>
               </div>
            </div>	
			
			<div class="row">
				<div class="col-3"></div>
				<div class="col-3 d-flex justify-content-center"><a href="./zimMainPage" role="button" class="btn" style="background-color: #46B8FF !important; color : white;">메인으로</a></div>
				<div class="col-3 d-flex justify-content-center"><a href="../userboard/userZimInfoPage" role="button" class="btn" style="background-color: #46B8FF !important; color : white;">마이페이지로</a></div>
				<div class="col-3"></div>
			</div>
		</div>
		<div class="col-3"></div>
	</div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>