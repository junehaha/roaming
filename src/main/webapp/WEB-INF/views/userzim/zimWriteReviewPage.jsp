<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<title>zimWriteReviewPage</title>
<style>
	.scroll {
			overflow: auto;
			height: 700px;
		}
</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"/>

<div class="container-fluid">
    <div class="row mt-5">
        <div class="col-3"></div>
        <div class="col-6 scroll">
            <div class="row p-3 border-top border-secondary">
                <div class="col fs-3">짐 서비스 리뷰 쓰기</div>
            </div>
            <div class="row p-3 border-top border-secondary-subtle ">
                <div class="col-3"><img src="/uploadFiles/${signUp.zim_image_link}" alt="이미지가 없습니다." class="img-fluid" onerror="this.src='../resources/img/noimg.png'"></div>
                <div class="col-9">
                	<c:forEach items="${signCateList}" var="signCateList">
                    <div class="row mb-2 p-0 text-body-secondary" style="font-size:14px">
                        <div class="col">
                            <span>${signCateList.zimCategory.name}</span>
                            <span style="margin-left: 10px;">${signCateList.zim.zim_amount}개</span>
                        </div>
                    </div>
                    </c:forEach>	
                    <div class="row mt-3 text-body-secondary" style="font-size:14px">
                        <div class="col">
                            ${signUp.start_date.year}. ${signUp.start_date.monthValue}.
                            ${signUp.start_date.dayOfMonth}.
                            ${signUp.start_date.hour}:<c:choose><c:when test="${signUp.start_date.minute eq '0'}">00</c:when><c:otherwise>${signUp.start_date.minute}</c:otherwise></c:choose>
                            픽업
                        </div>
                    </div>	
                    <div class="row mt-2 text-body-secondary" style="font-size:14px">
                        <div class="col">
                            ${signUp.arrive_date.year}. ${signUp.arrive_date.monthValue}.
                            ${signUp.arrive_date.dayOfMonth}.
                            ${signUp.arrive_date.hour}:<c:choose><c:when test="${signUp.arrive_date.minute eq '0'}">00</c:when><c:otherwise>${signUp.arrive_date.minute}</c:otherwise></c:choose>
                            도착
                        </div>
                    </div>	
                </div>
            </div>
            
            <form action="./zimReviewProcess" method="post">
            <input type="hidden" name="zim_signup_id" value="${signUp.id}">
            <div class="row mb-3 py-3 border-top border-secondary border-opacity-50">
                <div class="col-3">
                    <label for="start_address" class="form-label">별점주기</label>
                </div>
                <div class="col-9">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="zim_star" id="inlineRadio1" value="1">
                        <label class="form-check-label" for="inlineRadio1"><i class="bi bi-star-fill text-warning"></i></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="zim_star" id="inlineRadio2" value="2">
                        <label class="form-check-label" for="inlineRadio2"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="zim_star" id="inlineRadio3" value="3">
                        <label class="form-check-label" for="inlineRadio3"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="zim_star" id="inlineRadio4" value="4">
                        <label class="form-check-label" for="inlineRadio4"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning" ></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="zim_star" id="inlineRadio5" value="5">
                        <label class="form-check-label" for="inlineRadio5"><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></label>
                    </div>
                </div>
            </div>
            <div class="row mb-1">
                <div class="col-3">
                    <label for="reviewTitle" class="form-label">제목</label>
                </div>
                <div class="col-9">
                    <div class="input-group mb-2">
                        <input type="text" class="form-control" placeholder="리뷰제목을 써주세요" id="reviewTitle" name="zim_review_title">
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-3">
                    <label for="reviewContent" class="form-label">상세내용</label>
                </div>
                <div class="col-9">
                    <div class="form-floating">
                        <textarea class="form-control" placeholder="서비스에 대한 평가를 남겨주세요" id="reviewContent" name="zim_review_content" style="height: 100px"></textarea>
                        <label for="reviewContent">서비스에 대한 평가를 남겨주세요</label>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-4"></div>
                <div class="col-2 d-flex justify-content-center"><a class="btn" href="./zimMainPage" role="button" style="background-color: #46B8FF !important; color : white;">홈으로</a></div>
                <div class="col-2 d-flex justify-content-center"><button class="btn" style="background-color: #46B8FF !important; color : white;">리뷰제출</button></div>
            	<div class="col-4"></div>
            </div>
            </form>
        </div>
        <div class="col-3"></div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>