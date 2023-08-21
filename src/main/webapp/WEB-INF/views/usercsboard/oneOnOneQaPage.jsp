<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>oneOnOneQaPage</title>
    <style>
        .card-image {
            width: 80px;
            height: 80px;
            overflow: hidden;
            border-radius: 50%;
            border: 1px solid rgba(0, 0, 0, 0.125);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            margin-left: 70px;
        }

        .card-image img {
            max-width: 100%;
            max-height: 100%;
        }

        .card-body {
            text-align: center;
        }

        .table th,
        .table td {
            height: 50px;
            vertical-align: middle;
        }

        .table thead {
            border-top: 1px solid black;
        }
    </style>
</head>

<body>
    <jsp:include page="../common/topNavi.jsp"></jsp:include>
    <div class="container-fluid">
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                <div class="row">
                    <div class="col-12">
                        <h4 class="mt-5">프로필 관리</h4>
                    </div>
                    <div class="col">
                        <div class="row mt-4">

                            <div class="col-3">
                                <div class="card" style="width: 14rem;">
                                    <div class="card-image">
                                        <img src="/uploadFiles/${myPage.userDto.profile_img}"
                                            class="card-img-top">
                                    </div>
                                    <div class="card-body">
                                        <p class="card-text">${myPage.userDto.user_name}</p>
                                        <a href="./myPage?id=${sessionUser.id}"
                                            style="text-decoration: none;">
                                            <span class="card-text"><i class="bi bi-house"></i></span>
                                        </a>
                                    </div>
                                </div>
                                <div class="card" style="width: 14rem; margin-top: 20px;">
                                    <div class="card-point">
                                        <p class="card-text"
                                            style="font-size: 14px; margin-top: 10px; margin-left: 10px;">내
                                            포인트 :
                                            <span
                                                style="float: right; color: #0078ff; margin-right: 10px;">${myPage.myPoint}</span>
                                        </p>
                                        <p class="card-text"
                                            style="font-size: 14px; margin-top: -10px; margin-bottom: 10px; margin-left: 10px;">
                                            내 쿠폰 : <span
                                                style="float: right; color: #0078ff; margin-right: 10px;">${myPage.myCouponCount}</span>
                                        </p>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <h5>포인트샵</h5>
                                    <a href="./orderHistoryPage" style="text-decoration: none;">
                                        <span style="font-size: 15px; color: gray;">주문 내역 조회</span>
                                    </a>
                                </div>
                                <div class="row mt-4">
                                    <h5>쿠폰</h5>
                                    <a href="./userCouponPage" style="text-decoration: none;">
                                        <span style="font-size: 15px; color: gray;">내 쿠폰함</span>
                                    </a>
                                </div>
                                <div class="row mt-4">
                                    <h5>동행</h5>
                                    <p style="font-size: 15px; color: gray;">파티 현황</p>
                                    <p style="font-size: 15px; color: gray;">파티 신청 목록</p>
                                </div>
                                <div class="row mt-4">
                                    <h5>숙소</h5>
                                    <p style="font-size: 15px; color: gray;">현재 예약 내역</p>
                                    <p style="font-size: 15px; color: gray;">지난 예역 내역</p>
                                    <p style="font-size: 15px; color: gray;">내가 찜한 숙소</p>
                                </div>

	                            <div class="row mt-4">
	                                <h5>짐 서비스</h5>
	                                <a href="../userboard/userZimInfoPage" style="text-decoration: none;">
	                                    <span style="font-size: 15px; color: gray;">배송 신청 내역</span>
	                                </a>
	                            </div>
	                            <div class="row mt-4">
	                                <h5>고객센터</h5>
	                                <a href="../usercsboard/oneOnOneQaPage" style="text-decoration: none;">
	                                    <span style="font-size: 15px; color: #0078ff;">나의 문의 내역</span>
	                                </a>
	                            </div>
                            </div>


                            <div class="col-9">
                                <div class="row card-context">
                                    <div class="card" style="width: 100rem; height: 35rem;">
                                        <div class="row">
                                            <div class="col">
                                                <div class="row mb-4">
                                                    <div class="col mt-2 fs-4">나의 문의내역 </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col fs-6">총 (${myQaCount}건) </div>
                                                </div>

                                                <div class="row mt-3">
                                                    <div class="col">

                                                        <table class="table text-center">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col" class="col-1 bg-info bg-opacity-25">번호</th>
                                                                    <th scope="col" class="col-7 bg-info bg-opacity-25">제목</th>
                                                                    <th scope="col" class="col-2 bg-info bg-opacity-25">작성일</th>
                                                                    <th scope="col" class="col-2 bg-info bg-opacity-25">처리상태</th>
                                                                </tr>
                                                            </thead>

                                                            <tbody>
                                                                <c:forEach items="${qaBoardDto }"
                                                                    var="myQa">
                                                                    <tr>
                                                                        <th scope="row">${myQa.id }</th>
                                                                        <td class="text-start px-4">
                                                                            <a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover" href="./readQaBoardPage?id=${myQa.id}" style="text-decoration: none">
                                                                                ${myQa.qa_title }
                                                                            </a>
                                                                        </td>
                                                                        <td>
                                                                            <fmt:formatDate value="${myQa.qa_reg_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
                                                                        </td>
                                                                        <td>
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${empty myQa.qa_comment_content}">
                                                                                    <i
                                                                                        class="bi bi-check-circle-fill text-danger"></i>
                                                                                </c:when>
                                                                                <c:otherwise><i
                                                                                        class="bi bi-check-circle-fill text-success"></i>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-2"></div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>