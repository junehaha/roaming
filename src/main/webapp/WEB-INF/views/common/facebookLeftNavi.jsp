<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <script>
	function getMyPhoto() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				const map = response.map.image
				
				const link = document.createElement("a")
				const img = document.createElement("img")
				img.classList.add("img-fluid", "profile-image")
				img.style.width = "30px"
				img.style.height = "30px"
				img.style.borderRadius = "50%"
				img.src = "/uploadFiles/" + map.profile_img

				
				link.appendChild(img)
				document.getElementById("navProfile").appendChild(link)
			}
		}
		xhr.open("get", "./naviPhoto")
		xhr.send()
	}
	function reelsMakes() {
		const modal = bootstrap.Modal.getOrCreateInstance("#reelsMake")
		modal.show();
	}
	function searchModal() {
		const modal = bootstrap.Modal.getOrCreateInstance("#searchModal")
		modal.show();
	}
	const navItems = document.querySelectorAll(".nav-item");
	
	navItems.forEach(function(navItem) {
		navItem.addEventListener("mouseover", function() {
			navItem.style.backgroundColor = "#f1f1f1"; /* 연한 회색 배경 색상 */
	});
	navItem.addEventListener("mouseout", function() {
		navItem.style.backgroundColor = ""; /* 기본 흰색 배경 색상 */
		});
	});
	function countCharacters() {
	      var textArea = document.getElementById("textInput");
	      var characterCount = document.getElementById("characterCount");
	      var currentLength = textArea.value.length;

	      // 최대 2000자 중에서 현재 글자 수 표시
	      
	      characterCount.textContent = currentLength + "/2000";
	    }
	var currentImageIndex = 0;
	var media;

	/* function handleDragOver(event) {
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
	
	*/
	function handleFileSelect(event) {
		  var fileList = event.target.files;
		  displayPreview(fileList);
		}

	function displayPreview(fileList) {
	  var previewContainer = document.getElementById("previewContainer");
	  
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
	       	previewElement.classList.add("image-fix")
	      } else if (file.type.startsWith("video/")) {
	        // 비디오 파일인 경우 video 요소를 생성합니다.
	        previewElement = document.createElement("video");
	        previewElement.style.width = "auto"; // 비디오의 너비를 조절합니다.
	        previewElement.style.height = "792px";
	        previewElement.style.objectFit = "contain"; // 비디오가 가운데로 정렬되도록 합니다.
	        previewElement.style.backgroundColor = "black";
	        previewElement.controls = true; // 컨트롤러 표시
	      } else {
	        // 이미지나 비디오가 아닌 파일은 무시합니다.
	        return;
	      }

	      previewElement.src = e.target.result;
	      previewContainer.insertBefore(previewElement, previewContainer.firstChild);
	     /*  previewContainer.appendChild(previewElement); */

	      media.push(previewElement); // 미디어 배열에 추가합니다.
	    };

	    reader.readAsDataURL(file);
	  }
/* 
	  showMedia(currentImageIndex); // 현재 미디어 표시 */
	}
	
	function uploadFormData() {
	    const formData = new FormData();
/* 	    const img1 = document.getElementById("dropArea"); */
		const img = document.getElementById("fileInput");
		for(let i = 0; i<img.files.length; i++) {
			if(img.files[i].type.startsWith("image/")) {
			    const title = document.getElementById("getTitle").value;
			    const content = document.getElementById("getContent").value;
			    const location = document.getElementById("getLocation").value;
				const imgs = img.files
			    formData.append("feed_title", title);
			    formData.append("feed_content", content);
			    formData.append("location", location);
		        // img1에 선택된 이미지가 있다면 배열에 추가합니다.
		        for (let i = 0; i < imgs.length; i++) {
		    	    formData.append("feedImageFiles", imgs[i]);
		        }
			} else {
				uploadReelsData()
				return
			}
			
		}
	    const xhr = new XMLHttpRequest();
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            const response = JSON.parse(xhr.responseText);
	            const modal = bootstrap.Modal.getOrCreateInstance("#reelsMake")
	    		modal.hide();
	            getMyProfileInfo()
	    		reloadBoard()
	    		anotherFeedList()
	    		widow.location.href="facebook/facebookMain";
	        }
	    };
	    xhr.open("post", "./uploadFeed");
	    xhr.send(formData);
	}
	function uploadReelsData() {
		const formData = new FormData();
		const img = document.getElementById("fileInput");
		const contents = document.getElementById("getContent").value;
		formData.append("reels_content", contents)
		formData.append("reelsFile", img.files[0])
		
		const xhr = new XMLHttpRequest();
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            const response = JSON.parse(xhr.responseText);
	            const modal = bootstrap.Modal.getOrCreateInstance("#reelsMake")
	    		modal.hide();
	            getMyProfileInfo()
	    		reloadBoard()
	    		anotherFeedList()
	        }
	    };
	    xhr.open("post", "./uploadReels");
	    xhr.send(formData);
	}
	function searchEvery() {
		const modal = bootstrap.Modal.getOrCreateInstance("#searchModal")
		modal.show()
	}
	function inputSearch() {
	    const xhr = new XMLHttpRequest()
	    const searchUser = document.getElementById("searchUser")
	    const searchUserValue = searchUser.value

	    xhr.onreadystatechange = function() {
	        if(xhr.readyState == 4 && xhr.status == 200) {
	            const response = JSON.parse(xhr.responseText)

	            const searchUserList = document.getElementById("searchUserList")
	            searchUserList.innerHTML = ""
				
				response.list.forEach(function(map) {
					const row = document.createElement("div")
					row.classList.add("row")
					
					const col = document.createElement("div")
					col.classList.add("col")
					
					const row1 = document.createElement("div")
					row1.classList.add("row", "mt-1")
					const col1 = document.createElement("div")
					col1.classList.add("col", "text-end")
					const link = document.createElement("a")
					link.href = "./myPageUser?userId=" + map.userDto.id
					const img = document.createElement("img")
					img.classList.add("img-fluid")
					img.style.width = "50px"
					img.style.height = "50px"
					img.style.borderRadius = "50%"
					img.src = "/uploadFiles/" + map.userDto.profile_img
					link.appendChild(img)
					col1.appendChild(link)
					row1.appendChild(col1)
					col.appendChild(row1)
					row.appendChild(col)
					
					const col2 = document.createElement("div")
					col2.classList.add("col-9")
					const row2 = document.createElement("div")
					row2.classList.add("row")
					const col3 = document.createElement("div")
					col3.classList.add("col", "text-start")
					const link1 = document.createElement("a")
					link1.href = "./myPageUser?userId=" + map.userDto.id
					link1.innerText = map.userDto.user_id
					link1.style.textDecoration = "none"
					link1.style.color = "black"
					col3.appendChild(link1)
					row2.appendChild(col3)
					col2.appendChild(row2)
					
					const row3 = document.createElement("div")
					row3.classList.add("row")
					const col4 = document.createElement("div")
					col4.classList.add("col", "text-start")
					col4.innerText = map.userDto.user_name
					row3.appendChild(col4)
					col2.appendChild(row3)
					row.appendChild(col2)
					
					document.getElementById("searchUserList").appendChild(row)
				})
			}
		}
		xhr.open("get", "./searchUser?search=" + encodeURIComponent(searchUserValue))
		xhr.send()
	}
	
	function alertFollow() {
		const modal = bootstrap.Modal.getOrCreateInstance("#alertModal")
		modal.show();
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const alertList = document.getElementById("alertList")
				alertList.innerHTML = ""
				response.list.forEach(function(map) {
					const row = document.createElement("div")
					row.classList.add("row")
					
					const col = document.createElement("div")
					col.classList.add("col-3")
					const link = document.createElement("a")
					link.href = "../facebook/myUserPage?userId=" + map.userDto.id
					const img = document.createElement("img")
					img.classList.add("img-fluid")
					img.style.width = "50px"
					img.style.height = "50px"
					img.style.borderRadius = "50%"
					img.src = "/uploadFiles/" + map.userDto.profile_img
					link.appendChild(img)
					col.appendChild(link)
					row.appendChild(col)
					const col1 = document.createElement("div")
					col1.classList.add("col", "small")
					col1.innerText = map.userDto.user_name + "님이 회원님을 팔로우하기 시작했습니다."
					row.appendChild(col1)
					const col2 = document.createElement("div")
					col2.classList.add("col-3")
					const button = document.createElement("button")
					button.classList.add("btn", "btn-secondary", "btn-sm")
					button.innerText = "팔로잉"
					col2.appendChild(button)
					row.appendChild(col2)
					document.getElementById("alertList").appendChild(row)
				})
			}
		}
		xhr.open("get", "./alertFollow")
		xhr.send()
	}

	function deleteAlert() {
		const alertList = document.getElementById("alertList")
		alertList.innerHTML = ""
	}
	window.addEventListener("DOMContentLoaded", function() {
		getMyPhoto()
		const modalElement = document.getElementById('reelsMake');
	    document.body.appendChild(modalElement);
	    const modalElement1 = document.getElementById('searchModal');
	    document.body.appendChild(modalElement1);
	})
</script>
 <style>
		/* 슬라이더 스타일 */
.slider {
  overflow: hidden; /* 넘치는 이미지 숨김 */
  width: 100%;
}
.slider-container {
  display: flex; /* 슬라이드들을 가로로 정렬 */
  transition: transform 0.3s ease-in-out; /* 슬라이드 전환 애니메이션 */
}
.slide {
  flex: 0 0 100%; /* 슬라이드 너비를 100%로 설정 */
}

/* 슬라이드 컨트롤 스타일 (옵션) */
.prev, .next {
  cursor: pointer;
}
 		.profile-image {
			float: left;
			margin-right: 10px; /* 오른쪽 여백 설정 */
		}
        .fixed-left-navbar {
            position: fixed;
            top: 0;
            left: 290px;
            height: 100vh;
            width: 330px;
            background-color: white;
            border-right: 1px solid rgba(128, 128, 128, 0.3);
            border-left: 1px solid rgba(128, 128, 128, 0.3);
            z-index: 0;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
        .bold-icon {
            text-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
        }
        .dropdown-menu1 {
            transform: translateY(calc(550px));
        }

		.col-feed {
			border-bottom: 2px solid rgba(128, 128, 128, 1.0);
		}
		.nav-item:hover {
    		background-color: #f1f1f1; /* 연한 회색 배경 색상 */
    		border-radius: 5px;
     		font-weight: bold;
  		}
  		.#reelsMake {
  			z-index: 9999;
  		}
  		
  		.modal-body-search {
		width: 100%;
        height: 100%;
    	}
    	.modal-content-search {
    	width: 100%;
        height: 100%;
        border: none;
        border-radius: 0 5px 5px 0;
    	}
    	
    	.modal-dialog-search {
    		position: absolute;
    		border-radius: 0 5px 5px 0;
	        top: -2%;
	        left: 32%;
	        transform: translate(-50%, -50%);
    		width: 400px;
	        height: 1190px;
    		border: 1px solid rgba(0, 0, 0, 0.1);
    	}
    	.modal-body-alert {
		width: 100%;
        height: 100%;
    	}
    	.modal-content-alert {
    	width: 100%;
        height: 100%;
        border: none;
        border-radius: 0 5px 5px 0;
    	}

    	.modal-dialog-alert {
    		z-index: 999999;
    		position: absolute;
    		border-radius: 0 5px 5px 0;
	        top: -2%;
	        left: 32%;
	        transform: translate(-50%, -50%);
    		width: 400px;
	        height: 1190px;
    		border: 1px solid rgba(0, 0, 0, 0.1);
    	}
    	.modal-body-make {
		width: 100%;
        height: 100%;

    	}
    	.modal-content-make {
    	width: 100%;
        height: 100%;
        border: none;
        border-radius: 0;
    	}
    	.modal-dialog-make {
    		position: absolute;
	        top: 15%;
	        left: 20%;
	        transform: translate(-50%, -50%);
    		width: 1150px;
	        height: 833px;
	        min-width: 1150px;
	        min-height: 833px;
    		border: 1px solid rgba(0, 0, 0, 0.2);
    	}
    	
    	.image-fix {
    		width: 810px;
    		height: 790px;
    	}
    	.modal-ss {
    	margin-right: 10px;
       margin-left: 10px;
    	}
		
		.form-control:focus {
    box-shadow: none; /* 포커스를 받았을 때의 테두리를 없애는 스타일 */
  }
  		.icon11 {
    /* 아이콘 스타일 */
    position: absolute; /* 아이콘을 오버레이 시킵니다. */
    right: 10px; /* 아이콘을 오른쪽으로 10px 만큼 이동시킵니다. */
    top: 50%; /* 아이콘을 세로 중앙으로 위치시킵니다. */
    transform: translateY(-50%); /* 아이콘의 세로 위치를 정확히 중앙으로 조정합니다. */
    pointer-events: none; /* 아이콘은 클릭 이벤트를 받지 않도록 설정합니다. */
  }
   .form-switch .form-check-input {
    height: 26px; /* 높이를 원하는 크기로 설정합니다. */
    width: 46px; /* 너비를 원하는 크기로 설정합니다. */
    
  }

</style>
	<div class="row">
		<div class="col mt-4 mx-2">
			<a class="navbar-brand" href="../userboard/mainPage">
	    		<img class="img-fluid" style="width:150px; height:50px;" src="/roaming/resources/img/originalLogo.png">
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
		        <a class="nav-link active text-dark fs-6" href="./facebookMain"><i class="bi bi-house-door fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;홈</a>
		      </li>
		      <li class="nav-item">
		         <a class="nav-link text-dark fs-6" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="bi bi-search fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색</a>
					<!-- Modal -->
					<div class="modal fade"  data-bs-backdrop="false" data-bs-keyboard="true" id="searchModal" tabindex="-1" aria-labelledby="searchModall" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-search">
					    <div class="modal-content modal-content-search">
					      <div class="modal-header border-0">
					        <h1 class="modal-title fs-5" id="searchModall">검색</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body modal-body-search">
					        <label style="position: relative;">
							<input type="text" id="searchUser" oninput="inputSearch()" class="form-control form-controll" style="width: 365px; height: 40px; padding-left: 40px;"  placeholder="검색해주세요..">
							<i style="position: absolute; left: 10px; bottom: 7px" class="bi bi-search"></i>
							</label>
							<div class="mt-3" id="searchUserList"></div>
					      </div>
					      
					    </div>
					  </div>
					</div>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-dark fs-6" href="./feedMain"><i class="bi bi-camera fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;피드</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-dark fs-6" href="./reelsMainPage"><i class="bi bi-collection-play fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;릴스</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-dark fs-6" href="./message"><i class="mr-3 bi bi-send fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;메세지</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-dark fs-6" onclick="alertFollow()"><i class="mr-3 bi bi-heart fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;알림</a>
		      	<div class="modal fade"  data-bs-backdrop="false" data-bs-keyboard="true" id="alertModal" tabindex="-1" aria-labelledby="alertModall" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-alert">
					    <div class="modal-content modal-content-alert">
					      <div class="modal-header border-0">
					        <h1 class="modal-title fs-5" id="alertModall">알림</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body modal-body-alert">
					        <div class="row">
					        	<div class="col" id="alertList">이번 주</div>
					        </div>
					        <div class="row">
					        	<div class="col">이전 활동</div>
					        </div>
					        <div class="row"></div>
					      </div>
					    </div>
					  </div>
					</div>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link text-dark fs-6" onclick="reelsMakes()"><i class="bi bi-file-plus fs-4 bold-icon"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;만들기</a>
		      </li>
		      <li class="nav-item">
		      	<a class="nav-link text-dark fs-6 my-2" href="./myPage" id="navProfile">&nbsp;&nbsp;&nbsp;프로필</a>
		      </li>
		      <li class="dropdown dropup dropdown-menu1">
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
<!-- Modal -->
<div class="modal fade" id="reelsMake"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-make">
    <div class="modal-content p-0 modal-content-make">
      <div class="p-0 py-2 px-3 modal-header modal-header-make">
      	<span class="text-center"></span>
        <span class="text-center text-semibold">새 게시물 만들기</span>
        <span class="text-center text-primary" onclick="uploadFormData()">올리기</span>
      </div>
      <div class="modal-body p-0 modal-body-make">
      <!-- <form action="./feedRegisterComplete" method="post" id="uploadForm"> -->
       	<div class="row ms-1">
			<div class="col p-0"><!--  name="feedImageFiles" id="dropArea" ondragover="handleDragOver(event)" ondragenter="handleDragEnter(event)" ondragleave="handleDragLeave(event)" ondrop="handleDrop(event)" multiple -->
				<div class="row" id="previewContainer">
					<div class="col">
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						
						
						<div class="row mt-5">
							<div class="col text-center" style="width: 300px; height: 300px;"><img class="img-fluid" style="width: 100%; height: 100%;" src="/roaming/resources/img/makeFeed.png"></div>
						</div>
						<div class="row">
							<div class="col text-center"><label for="fileInput" class="btn btn-primary btn-sm">컴퓨터에서 선택</label>
          					<input type="file" name="feedImageFiles" id="fileInput" style="display: none;" onchange="handleFileSelect(event)" multiple/></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-4">
				<div class="row mt-2">
					<div class="col-2"><img class="img-fluid" style="width: 50px; height: 45px; border-radius: 50%;" src="/uploadFiles/${sessionUser.profile_img}"></div>
					<div class="col text-start">
						<div class="row">
							<div class="col fw-semibold">${sessionUser.user_id}</div>
						</div>
						<div class="row">
							<div class="col small">${sessionUser.user_name}</div>
						</div>
					</div>
				</div>
				<div class="row mt-2">
					<div class="col pe-4"><input name="feed_title" id="getTitle" type="text" class="form-control border-0" placeholder="제목 입력"></div>
				</div>
				<div class="row"><!--oninput="countCharacters()"  -->
					<div class="col pe-4 my-1"><textarea name="feed_content" id="getContent" style="height: 300px;" class="form-control border-0" id="textInput" maxlength="2000"  placeholder="내용 입력"></textarea></div>
				</div>
				<div class="row">
					<div class="col ms-2"></div>
					<div class="col"></div>
					<div class="col small text-end me-3 opacity-75" id="characterCount">0/2000</div>
				</div>
				<div class="row border-bottom me-1">
					<div class="col pe-4"><input name="location" type="text" id="getLocation" class="form-control border-0" placeholder="위치 추가"></div>
				</div>
				<div class="row">
					<div class="col fw-semibold my-2">고급 설정</div>
				</div>
				<div class="row">
					<div class="col fs-6 mt-2">이 게시물의 좋아요 수 및 조회수 숨기기</div>
					<div class="col-2 me-4">
						<div class="form-check form-switch">
					  	<input class="form-check-input form-control form-controll me-1" type="checkbox" role="switch" id="flexSwitchCheckDefault">
					  	</div>
					</div>
				</div>
				<div class="row my-2">
					<div class="col pe-5"><img class="img-fluid" src="/roaming/resources/img/set11.png"></div>
				</div>
				<div class="row">
					<div class="col fs-6 mt-2">댓글 기능 해제</div>
					<div class="col-2 ms-6">
						<div class="form-check form-switch text-center ps-5">
					  	<input class="form-check-input form-control me-1" style="left: 5px;" type="checkbox" role="switch" id="flexSwitchCheckDefault">
					  	</div>
					</div>
					<div class="col-1"></div>
				</div>
				<div class="row my-2">
					<div class="col pe-5"><img class="img-fluid" src="/roaming/resources/img/set12.png"></div>
				</div>
				<div class="row"></div>
			</div>
		</div>
		<!-- </form> -->
      </div>
    </div>
  </div>
</div>