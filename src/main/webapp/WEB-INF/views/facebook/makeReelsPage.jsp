<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<title>mainPage</title>
   <style>
  .centered-link {
    display: flex;
    align-items: center;
  }
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row mt-2">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
					<!-- <div class="col">
						<img src="../resources/img/mainL.png" style="width: 180px; height: 50px;">
					</div> -->
					<div class="col"></div>
					<div class="col-1 small">
						<c:if test="${empty sessionUser}">
							<a href="../user/loginPage">로그인</a>
						</c:if>
						<c:if test="${!empty sessionUser}">
							${sessionUser.user_name}&nbsp;님 
						</c:if>
					</div>
					<div class="col-1 small">
						<c:if test="${empty sessionUser}">
							<a href="../user/userRegisterPage">회원가입</a>
						</c:if>
						<c:if test="${!empty sessionUser}">
							<a href="../user/logoutProcess" style="color: black; text-decoration: none;">로그아웃</a>
						</c:if>
					</div>
					<div class="col-1 small">
						<c:if test="${empty sessionUser}">
							<a href="../user/loginPage">마이페이지</a>
						</c:if>
						<c:if test="${!empty sessionUser}">
							<a href="#" style="color: black; text-decoration: none;">마이페이지</a>
						</c:if>
					</div>
					<div class="col-1 small">고객센터</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row mt-5 border-bottom">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
					<div class="col">
						<img src="../resources/img/logom.png" style="width: 160px; height: 40px;">
					</div>
					<div class="col"></div>
					<div class="col-1 fs-5 fw-bold centered-link">
						<a href="#" style="text-decoration: none; color: black;">숙소 예약</a>
					</div>
					<div class="col-1 fs-5 fw-bold centered-link">
						<a href="#" style="text-decoration: none; color: black;">피드&릴스</a>
					</div>
					<div class="col-1 fs-5 fw-bold centered-link">
						<a href="#" style="text-decoration: none; color: black;">파티 찾기</a>
					</div>
					<div class="col-1 fs-5 fw-bold centered-link">
						<a href="#" style="text-decoration: none; color: black;">짐 서비스</a>
					</div>
					<div class="col-1 fs-5 fw-bold centered-link">
						<a href="#" style="text-decoration: none; color: black;">포인트 샵</a>
					</div>
					<div class="col-1 fs-5 fw-bold centered-link">
						<i class="bi bi-list"></i>
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row mt-5">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
					<div class="col fs-5 fw-bold">호텔 예약!!</div>
				</div>
				<div class="row">
					<div class="col">
						<img class="img-fluid" src="/roaming/resources/img/hotel2.png">
					</div>
				</div>
				<div class="row">
					<div class="col s-5 fw-bold">릴스&피드!!</div>
				</div>
				<div class="row">
					<div class="col">
						<img class="img-fluid" src="/roaming/resources/img/feed2.png">
					</div>
				</div>
				<div class="row">
					<div class="col s-5 fw-bold">파티 찾기!!</div>
				</div>
				<div class="row">
					<div class="col">
						<img class="img-fluid" src="/roaming/resources/img/party2.png">
					</div>
				</div>
				
				<div class="row">
					<div class="col">
						<img class="img-fluid" src="/roaming/resources/img/center1.png">
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>mainPage</title>
    <style>
        .fixed-left-navbar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 330px;
            background-color: white;
            border-right: 1px solid rgba(128, 128, 128, 0.3);
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
        .bold-icon {
            text-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
        }
        .dropdown-menu1 {
            transform: translateY(calc(580px));
        }
        .col-bg {
			background-color: rgba(0, 128, 0, 0.1);
			border-bottom: 1px solid rgba(128, 128, 128, 0.3);
		}
		.col-feed {
			border-bottom: 2px solid rgba(128, 128, 128, 1.0);
		}
		.custom-border {
		border: 1px solid rgba(128, 128, 128, 0.5);
  		/* border-radius: 15px; */
		}
		.col-login {
			border-bottom: 1px solid gray;
		}
		.gray-line {
	        position: relative;
	    }
	
	    .gray-line::before {
	        content: "";
	        position: absolute;
	        top: 50%;
	        left: 0;
	        transform: translateY(-50%);
	        width: 100%;
	        height: 1px;
	        background-color: rgba(128, 128, 128, 0.5);
	    }
    </style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-3 fixed-left-navbar">
				<div class="row">
					<div class="col mt-5 mx-2">
						<a class="navbar-brand" href="../userboard/mainPage">
				    		<img class="img-fluid" style="width:130px; height:30px;" src="/roaming/resources/img/logo223.png">
				    	</a>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col left-navbar">
					    <ul class="nav flex-column">
					      <!-- <li class="nav-item">
					        <a class="nav-link active" href="#"><img class="img-fluid" src="/facebook/resources/img/"></a>
					      </li> -->
					      <li class="nav-item">
					        <a class="nav-link active text-dark" href="./facebookMain"><i class="bi bi-house-door fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;홈</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="#"><i class="bi bi-search fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;검색</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="./feedMain"><i class="bi bi-compass fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;피드</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="./reelsMainPage"><i class="bi bi-file-earmark-slides fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;릴스</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="#"><i class="mr-3 bi bi-send fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;메세지</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="#"><i class="mr-3 bi bi-heart fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;알림</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="./makeFeedPage"><i class="bi bi-file-plus fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;피드 만들기</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6 fs-6 col-feed" href="./makeReelsPage"><i class="bi bi-file-plus-fill fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;릴스 만들기</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="./myPage">프로필</a>
					      </li>
					      <li class="nav-item dropdown dropup dropdown-menu1">
				          <a class="nav-link dropdown-toggle fw-bold fs-5 text-dark" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				          <c:if test="${!empty sessionUser}">
				          	${sessionUser.user_name}님
				          </c:if>
				          <c:if test="${empty sessionUser}">
				          	로그인
				          </c:if>
				          </a>
				          <ul class="dropdown-menu">
				            <li><hr class="dropdown-divider"></li>
				            <c:choose>
				            	<c:when test="${!empty sessionUser}">
				            		<li><a class="dropdown-item fw-bold fs-6" href="../user/logoutProcess">로그아웃</a></li>
				            		<li><a class="dropdown-item fw-bold fs-6" href="../userboard/myPage">마이페이지</a></li>
				           			<li><a class="dropdown-item fw-bold fs-6" href="#">장바구니</a></li>
				            	</c:when>
				            	<c:otherwise>
				            		<li><a class="dropdown-item fw-bold fs-6" href="../user/loginPage">로그인</a></li>
				            	</c:otherwise>
				            </c:choose>
				          </ul>
				        </li>
					    </ul>
				</div>
				</div>
			</div>
			<div class="col">
				<div class="row mt-5">
					<div class="col">
						<img class="img-fluid" src="/roaming/resources/img/whitebg.png">
					</div>
				</div>
				<div class="row mt-5">
					<div class="col">
						<img class="img-fluid" src="/roaming/resources/img/whitebg.png">
					</div>
				</div>
				<div class="row mt-5">
					<div class="col-5"></div>
					<div class="col">
						<div class="row custom-border">
							<div class="col-1"></div>
							<div class="col">
								<div class="row mt-3">
									<div class="col fw-bold fs-4 text-center">릴스 만들기</div>
								</div>
							<form action="./reelsRegisterComplete" method="post" enctype="multipart/form-data">
								<div class="row my-3">
									<div class="col">
										<textarea name="reels_content" class="form-control" placeholder="릴스 내용"></textarea>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<label class="custom-file-label" for="fileUpload" id="fileLabel">동영상 등록</label>
										<input name="reelsFile" type="file" class="form-control" id="fileUpload" multiple>
									</div>
								</div>
								<div class="row my-3">
									<div class="col d-grid">
										<button class="btn btn-dark btn-sm btn-block">릴스 등록</button>
									</div>
								</div>
							</form>
							</div>
							<div class="col-1"></div>
						</div>
					</div>
					<div class="col-4"></div>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
 --%>