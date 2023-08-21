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
	   /*  #previewContainer {
  position: relative;
  width: 100%;
  overflow: hidden;
}

#previewContainer img {
  display: none;
  max-width: 100%;
  height: auto;
}

#previewContainer.active img {
  display: block;
}

#prevButton,
#nextButton {
  position: absolute;
  top: 50%;
  left: 55%;
  transform: translateY(-50%);
  width: 40px;
  height: 40px;
  background-color: rgba(0, 0, 0, 0.3);
  color: #fff;
  font-size: 24px;
  text-align: center;
  line-height: 40px;
  cursor: pointer;
}

#prevButton {
  right: 45%;
}

#nextButton {
  right: 10px;
}
#previewContainer img {
  max-width: 200px; /* 원하는 가로 크기 */
  max-height: 200px; /* 원하는 세로 크기 */
} 
*/
#dropArea {
  border: 2px dashed #ccc;
  padding: 20px;
  text-align: center;
}

#dropArea.active {
  border-color: #000;
}

#previewContainer {
  position: relative;
  width: 100%;
  overflow: hidden;
}

#previewContainer img {
  display: none;
  max-width: 100%;
  height: auto;
}

#previewContainer.active img {
  display: block;
}

#prevButton,
#nextButton {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 40px;
  height: 40px;
  background-color: rgba(0, 0, 0, 0.5);
  color: #fff;
  font-size: 24px;
  text-align: center;
  line-height: 40px;
  cursor: pointer;
}

#prevButton {
  left: 10px;
}

#nextButton {
  right: 10px;
}
    </style>
    <script>
    	function imageText() {
    		const xhr = new XMLHttpRequest()
    		xhr.onreadystatechange = function() {
    			if(xhr.readyState == 4 && xhr.status == 200) {
    				const response = JSON.parese(xhr.responseText)
    				
    					  
    			}
    		}
    		xhr.open("post", "./face")
    		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    		xhr.send()
    	}
    </script>
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
					        <a class="nav-link text-dark fs-6 col-feed" href="./makeFeedPage"><i class="bi bi-file-plus-fill fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;피드 만들기</a>
					      </li>
					      <li class="nav-item">
					        <a class="nav-link text-dark fs-6" href="./makeReelsPage"><i class="bi bi-file-plus fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;릴스 만들기</a>
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
									<div class="col fw-bold fs-4 text-center">피드 만들기</div>
								</div>
								<form action="./feedRegisterComplete" method="post" enctype="multipart/form-data">
								<div class="row">
									<div class="col-7" id="dropArea" ondragover="handleDragOver(event)" ondragenter="handleDragEnter(event)" ondragleave="handleDragLeave(event)" ondrop="handleDrop(event)">
										<p id="previewContainer">파일을 여기에 드래그하세요.</p>
									</div>
									<div class="col-5">
										<div class="row">
											<div class="col">사진</div>
											<div class="col">이름</div>
										</div>
										<div class="row">
											<div class="col">피드나 릴스 제목</div>
										</div>
										<div class="row">
											<div class="col">내용</div>
										</div>
										<div class="row">
											<div class="col">이모지</div>
											<div class="col">빈칸</div>
											<div class="col">글자 개수</div>
										</div>
										<div class="row">
											<div class="col">위치</div>
											<div class="col">위치 아이콘</div>
										</div>
										<div class="row">
											<div class="col">고급 설정 콜렙스로 선택 두개 댓글 달기 가능불가능 게시판 좋아요 막기</div>
										</div>
										<div class="row"></div>
									</div>
								</div>
								
								
								
								
								<div class="row mt-1">
									<div class="col">
										<input type="text" name="feed_title" class="form-control" placeholder="피드 제목">
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<textarea name="feed_content" class="form-control" placeholder="피드 내용"></textarea>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<input type="text" name="location" class="form-control" placeholder="위치">
									</div>
								</div>
								<div class="row mt-1">
									<div class="col text-center">
									
									<div id="dropArea" ondragover="handleDragOver(event)" ondragenter="handleDragEnter(event)" ondragleave="handleDragLeave(event)" ondrop="handleDrop(event)">
  <p id="previewContainer">파일을 여기에 드래그하세요.</p>
</div>

<script>
var currentImageIndex = 0;
var media;

function handleDragOver(event) {
  event.preventDefault();
}

function handleDragEnter(event) {
  var dropArea = document.getElementById("dropArea");
  dropArea.classList.add("active");
}

function handleDragLeave(event) {
  var dropArea = document.getElementById("dropArea");
  dropArea.classList.remove("active");
}

function handleDrop(event) {
  event.preventDefault();
  var fileList = event.dataTransfer.files;
  displayPreview(fileList);
}

function displayPreview(fileList) {
  var previewContainer = document.getElementById("previewContainer");
  previewContainer.innerHTML = ""; // 이전에 표시된 미리보기 요소를 제거합니다.
  currentImageIndex = 0; // 현재 미디어 인덱스를 초기화합니다.

  media = []; // 미디어 배열을 초기화합니다.
  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewElement;
      if (file.type.startsWith("image/")) {
        // 이미지 파일인 경우 img 요소를 생성합니다.
        previewElement = document.createElement("img");
      } else if (file.type.startsWith("video/")) {
        // 비디오 파일인 경우 video 요소를 생성합니다.
        previewElement = document.createElement("video");
        previewElement.controls = true; // 컨트롤러 표시
      } else {
        // 이미지나 비디오가 아닌 파일은 무시합니다.
        return;
      }

      previewElement.src = e.target.result;
      previewContainer.appendChild(previewElement);

      media.push(previewElement); // 미디어 배열에 추가합니다.
    };

    reader.readAsDataURL(file);
  }

  var textContainer = document.getElementById("textContainer");
  if (fileList.length > 0) {
    // 파일이 선택된 경우, 선택한 파일 이름을 표시합니다.
    textContainer.innerHTML = fileList[0].name;
  } else {
    // 파일이 선택되지 않은 경우, 원하는 글을 표시합니다.
    textContainer.innerHTML = "내가 원하는 글";
  }

  showMedia(currentImageIndex); // 현재 미디어 표시
}

function showMedia(index) {
  if (index < 0 || index >= media.length) {
    return; // 인덱스가 범위를 벗어나면 종료합니다.
  }

  // 모든 미디어를 비활성화합니다.
  for (var i = 0; i < media.length; i++) {
    media[i].style.display = "none";
  }

  media[index].style.display = "block"; // 현재 미디어를 표시합니다.
}

function prevMedia() {
  currentImageIndex--;
  if (currentImageIndex < 0) {
    currentImageIndex = media.length - 1; // 처음 미디어로 돌아갑니다.
  }
  showMedia(currentImageIndex);
}

function nextMedia() {
  currentImageIndex++;
  if (currentImageIndex >= media.length) {
    currentImageIndex = 0; // 마지막 미디어에서 다음 미디어로 넘어갑니다.
  }
  showMedia(currentImageIndex);
}
</script>

<div id="textContainer">내가 원하는 글</div>

<div id="prevButton" onclick="prevMedia()">&lt;</div>
<div id="nextButton" onclick="nextMedia()">&gt;</div>
									
									<!-- <div id="dropArea" ondragover="handleDragOver(event)" ondragenter="handleDragEnter(event)" ondragleave="handleDragLeave(event)" ondrop="handleDrop(event)">
  <p>파일을 여기에 드래그하세요.</p>
</div>

<script>
var currentImageIndex = 0;
var images;

function handleDragOver(event) {
  event.preventDefault();
}

function handleDragEnter(event) {
  var dropArea = document.getElementById("dropArea");
  dropArea.classList.add("active");
}

function handleDragLeave(event) {
  var dropArea = document.getElementById("dropArea");
  dropArea.classList.remove("active");
}

function handleDrop(event) {
  event.preventDefault();
  var fileList = event.dataTransfer.files;
  displayPreview(fileList);
}

function displayPreview(fileList) {
  var previewContainer = document.getElementById("previewContainer");
  previewContainer.innerHTML = ""; // 이전에 표시된 미리보기 이미지를 제거합니다.
  currentImageIndex = 0; // 현재 이미지 인덱스를 초기화합니다.

  images = []; // 이미지 배열을 초기화합니다.
  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewImage = document.createElement("img");
      previewImage.src = e.target.result;
      previewContainer.appendChild(previewImage);

      images.push(previewImage); // 이미지 배열에 추가합니다.
    };

    reader.readAsDataURL(file);
  }

  var textContainer = document.getElementById("textContainer");
  if (fileList.length > 0) {
    // 파일이 선택된 경우, 선택한 파일 이름을 표시합니다.
    textContainer.innerHTML = fileList[0].name;
  } else {
    // 파일이 선택되지 않은 경우, 원하는 글을 표시합니다.
    textContainer.innerHTML = "내가 원하는 글";
  }

  showImage(currentImageIndex); // 현재 이미지 표시
}

function showImage(index) {
  if (index < 0 || index >= images.length) {
    return; // 인덱스가 범위를 벗어나면 종료합니다.
  }

  // 모든 이미지를 비활성화합니다.
  for (var i = 0; i < images.length; i++) {
    images[i].style.display = "none";
  }

  images[index].style.display = "block"; // 현재 이미지를 표시합니다.
}

function prevImage() {
  currentImageIndex--;
  if (currentImageIndex < 0) {
    currentImageIndex = images.length - 1; // 처음 이미지로 돌아갑니다.
  }
  showImage(currentImageIndex);
}

function nextImage() {
  currentImageIndex++;
  if (currentImageIndex >= images.length) {
    currentImageIndex = 0; // 마지막 이미지에서 다음 이미지로 넘어갑니다.
  }
  showImage(currentImageIndex);
}
</script>

<div id="textContainer">내가 원하는 글</div>
<div id="previewContainer"></div>
<div id="prevButton" onclick="prevImage()">&lt;</div>
<div id="nextButton" onclick="nextImage()">&gt;</div> -->
									<!-- <label for="fileUpload">
  <i class="fa fa-upload"></i> 파일 선택
</label>
<input name="feedImageFiles" type="file" id="fileUpload" multiple accept="image/*" style="display: none;" onchange="displayPreview(this)">

<script>
var currentImageIndex = 0;
var images;

function displayPreview(input) {
  var fileList = input.files;
  var previewContainer = document.getElementById("previewContainer");
  previewContainer.innerHTML = ""; // 이전에 표시된 미리보기 이미지를 제거합니다.
  currentImageIndex = 0; // 현재 이미지 인덱스를 초기화합니다.

  images = []; // 이미지 배열을 초기화합니다.
  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewImage = document.createElement("img");
      previewImage.src = e.target.result;
      previewContainer.appendChild(previewImage);

      images.push(previewImage); // 이미지 배열에 추가합니다.
    };

    reader.readAsDataURL(file);
  }

  var textContainer = document.getElementById("textContainer");
  if (fileList.length > 0) {
    // 파일이 선택된 경우, 선택한 파일 이름을 표시합니다.
    textContainer.innerHTML = fileList[0].name;
  } else {
    // 파일이 선택되지 않은 경우, 원하는 글을 표시합니다.
    textContainer.innerHTML = "내가 원하는 글";
  }

  showImage(currentImageIndex); // 현재 이미지 표시
}

function showImage(index) {
  if (index < 0 || index >= images.length) {
    return; // 인덱스가 범위를 벗어나면 종료합니다.
  }

  // 모든 이미지를 비활성화합니다.
  for (var i = 0; i < images.length; i++) {
    images[i].style.display = "none";
  }

  images[index].style.display = "block"; // 현재 이미지를 표시합니다.
}

function prevImage() {
  currentImageIndex--;
  if (currentImageIndex < 0) {
    currentImageIndex = images.length - 1; // 처음 이미지로 돌아갑니다.
  }
  showImage(currentImageIndex);
}

function nextImage() {
  currentImageIndex++;
  if (currentImageIndex >= images.length) {
    currentImageIndex = 0; // 마지막 이미지에서 다음 이미지로 넘어갑니다.
  }
  showImage(currentImageIndex);
}
</script>

<div id="textContainer">내가 원하는 글</div>
<div id="previewContainer"></div>
<div id="prevButton" onclick="prevImage()">&lt;</div>
<div id="nextButton" onclick="nextImage()">&gt;</div> -->
										<!-- <label for="fileUpload">
  <i class="fa fa-upload"></i> 파일 선택
</label>
<input name="feedImageFiles" type="file" id="fileUpload" multiple accept="image/*" style="display: none;" onchange="displayPreview(this)">

<script>
function displayPreview(input) {
  var fileList = input.files;
  var previewContainer = document.getElementById("previewContainer");
  previewContainer.innerHTML = ""; // 이전에 표시된 미리보기 이미지를 제거합니다.

  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewImage = document.createElement("img");
      previewImage.src = e.target.result;
      previewContainer.appendChild(previewImage);
    };

    reader.readAsDataURL(file);
  }

  var textContainer = document.getElementById("textContainer");
  if (fileList.length > 0) {
    // 파일이 선택된 경우, 선택한 파일 이름을 표시합니다.
    textContainer.innerHTML = fileList[0].name;
  } else {
    // 파일이 선택되지 않은 경우, 원하는 글을 표시합니다.
    textContainer.innerHTML = "내가 원하는 글";
  }
}
</script>

<div id="textContainer">내가 원하는 글</div>
<div id="previewContainer"></div> -->


<!-- <div id="textContainer">내가 원하는 글</div>

<div id="dropArea" ondragover="handleDragOver(event)" ondrop="handleDrop(event)">
  <p>파일을 여기에 드래그하세요.</p>
</div>

<script>
function handleDragOver(event) {
  event.preventDefault();
}

function handleDrop(event) {
  event.preventDefault();
  var fileList = event.dataTransfer.files;
  var textContainers = document.getElementById("textContainers");

  if (fileList.length > 0) {
    // 파일이 선택된 경우, 선택한 파일 이름을 표시합니다.
    textContainers.innerHTML = fileList[0].name;
    // 여기서 파일 업로드 로직을 추가할 수 있습니다.
  } else {
    // 파일이 선택되지 않은 경우, 원하는 글을 표시합니다.
    textContainers.innerHTML = "내가 원하는 글";
  }
}
</script>

<div id="textContaines">내가 원하는 글</div>
 -->
									</div>
								</div>
								<div class="row my-3">
									<div class="col d-grid">
										<button class="btn btn-dark btn-sm btn-block">피드 등록</button>
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