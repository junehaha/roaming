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

		.col-feed {
			border-bottom: 2px solid rgba(128, 128, 128, 1.0);
		}
		
.image-wrapper {
    position: relative;
    display: inline-block;
}

.image-wrapper img {
    width: 315px;
    height: 290px;
}

.image-wrapper .overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 315px;
    height: 290px;
    background-color: rgba(0, 0, 0, 0.2);
    opacity: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: flex-center;
    padding: 20px;
    color:white;
}

.image-wrapper .overlay i {
    font-size: 24px;
    order: -1;
}

.image-wrapper .overlay .feed-title-container {
    display: flex;
    flex-direction: column;
    align-items: flex-center;
}

		
.feed-title {
  position: absolute;
  bottom: 10px;
  width: 315px;
  left: 50%;
  transform: translateX(-50%);
  color: white;
  font-size: 16px;
}
.toptop {
	top: 150px;
}
    </style>
</head>
<body>
	
	<div class="container-fluid ">
		<div class="row">
			<div class="col-3 fixed-left-navbar">
				<jsp:include page="../common/facebookLeftNavi.jsp"></jsp:include>
			</div>
			<div class="col">
				<!-- <div class="row col-bg col-main">
					<div class="col"></div>
					<div class="col-6">
						<div class="row mt-5">
							<div class="col fw-bold fs-5 text-center"><i class="bi bi-instagram"></i> 피드</div>
						</div>
						<div class="row mt-4">
							<div class="col fw-bold fs-2 text-center">비슷한 관심사</div>
						</div>
						<div class="row">
							<div class="col fw-bold fs-2 text-center">여행자 피드 구독하기</div>
						</div>
						<div class="row mt-4">
							<div class="col fs-6 text-center">나와 비슷한 멤버를 찾아 팔로우하면</div>
						</div>
						<div class="row">
							<div class="col fs-6 text-center">언제 어디서나 더 가깝게 연결될 수 있어요.</div>
						</div>
						<div class="row mt-5"></div>
						<div class="row mt-5">
							<div class="col"></div>
							<div class="col fs-5 text-center col-feed"><a href="./feedMain" style="text-decoration: none; opacity: 0.7;" class="text-dark">최신 피드</a></div>
							<div class="col fs-5 text-center"><a href="./feedMainPu" style="text-decoration: none; opacity: 0.7;" class="text-dark">인기 피드</a></div>
							<div class="col"></div>
						</div>
					</div>
					<div class="col-2"></div>
				</div> -->
				<div class="row mt-3">
					<div class="col"></div>
					<div class="col-6 p-0 ">
						<%-- <div class="row m-0 p-0">
						<c:forEach  var="map" items="${list}" varStatus="status">
						  <div class="col m-0 p-0">
							    <div class="row m-0">
							      <div class="col image-wrapper p-0 pb-1">
							        <a class="p-0" href="./feedDetailPage?id=${map.feedDto.id}">
							          <img src="/uploadFiles/${map.feedImageDto.feed_image}" alt="Feed Image" />
							          <div class="overlay">
							            <i class="bi bi-heart-fill fs-5">&nbsp;${map.count}</i>
							          	${map.userDto.feed_title}
								        <div class="feed-title">${map.feedDto.feed_title}</div>
							          </div>
							        </a>
							        <input type="hidden" name="id" value="${map.feedDto.id}">
							      </div>
							    </div>
							  </div>
						</c:forEach>
						</div> --%>
						<div class="row m-0 p-0">
						<c:forEach  var="map" items="${list}" varStatus="status">
						  <div class="col m-0 p-0">
							    <div class="row m-0">
							      <div class="col image-wrapper p-0 pb-1">
							        <a class="p-0" href="./feedDetailPage?id=${map.feedDto.id}">
							          <img src="/uploadFiles/${map.feedImageDto.feed_image}" alt="Feed Image" />
							          <div class="overlay">
							            <i class="bi bi-heart fs-5">&nbsp;${map.count}</i>
							          	${map.userDto.feed_title}
								        <div class="feed-title">${map.feedDto.feed_title}</div>
							          </div>
							        </a>
							        <input type="hidden" name="id" value="${map.feedDto.id}">
							      </div>
							    </div>
							  </div>
						</c:forEach>
						</div>
						<div class="row mt-5"></div>
						<div class="row my-5">
							<div class="col"></div>
							<div class="col-10"><img class="img-fluid" src="/roaming/resources/img/footer.png"></div>
							<div class="col"></div>
						</div>
					</div>
					<div class="col-2"></div>
				</div>
				
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>