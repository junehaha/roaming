<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script>
	const feedId = new URLSearchParams(location.search).get("id");
	let mySessionId = null;
	function getSessionId() {
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				if(response.result == "success") {
					mySessionId = response.id;
				}
			}
		}
		xhr.open("get", "../user/getMyId", false);
		xhr.send();
	}
	function refreshTotalLikeCount() {
		const totalLikeCountBox = document.getElementById("totalLikeCount")
		totalLikeCountBox.innerHTML = ""
				
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				totalLikeCountBox.innerText = response.count
			}
		}
		xhr.open("get", "../facebook/getTotalLikeCount?feedId=" + feedId);
		xhr.send();
	}
	function refreshTotalHateCount() {
		const totalHateCountBox = document.getElementById("totalChatingCount")
		totalHateCountBox.innerHTML = ""
		
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				totalHateCountBox.innerText = response.chatingCount
			}
		}
		xhr.open("get", "../facebook/getTotalLikeCount?feedId=" + feedId);
		xhr.send();
	}
	function toggleLike() {
		if(mySessionId == null) {
			if(confirm("로그인을 해야 이용 가능..")) {
				location.href="../user/loginPage";
			}
			return
		}
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				refreshTotalLikeCount()
				/* refreshTotalHateCount() */
				refreshMyHeart()	
			}
		}
		xhr.open("get", "../facebook/toggleLike?feed_id=" + feedId)
		xhr.send()
	}
	function toggleHate() {
		if(mySessionId == null) {
			if(confirm("로그인을 해야 이용 가능..")) {
				location.href="../user/loginPage"
			}
			return
		}
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				/* refreshTotalHateCount() */
				refreshTotalLikeCount()
				refreshMyHate()	
			}
		}
		xhr.open("get", "../facebook/toggleHate?feed_id=" + feedId)
		xhr.send()
	}
	function refreshMyHeart() {
		if(mySessionId == null) return;
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				const heartBox = document.getElementById("heartBox")
				const hateBox = document.getElementById("hateBox")
				
				if(response.isLike) {
					heartBox.classList.remove("bi-bi-emoji-heart-eyes")
					heartBox.classList.add("bi-emoji-heart-eyes-fill", "text-danger")
					hateBox.classList.remove("bi-emoji-angry")
					hateBox.classList.remove("bi-emoji-angry-fill", "text-danger")
					hateBox.classList.add("bi-emoji-angry")
				} else {
					heartBox.classList.remove("bi-emoji-heart-eyes-fill", "text-danger")
					heartBox.classList.add("bi-emoji-heart-eyes")
					hateBox.classList.remove("bi-emoji-angry")
					hateBox.classList.remove("bi-emoji-angry-fill", "text-danger")
					hateBox.classList.add("bi-emoji-angry")
				}
			}
		}
		xhr.open("get", "../facebook/isLiked?feed_id=" + feedId)
		xhr.send()
	}
 	function refreshMyHate() {
		if(mySessionId == null) return;
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				const heartBox = document.getElementById("heartBox")
				const hateBox = document.getElementById("hateBox")

			    if(response.isHate) {
					heartBox.classList.remove("bi-emoji-heart-eyes")
					heartBox.classList.remove("bi-emoji-heart-eyes-fill", "text-danger")
					heartBox.classList.add("bi-emoji-heart-eyes")
					hateBox.classList.remove("bi-emoji-angry")
					hateBox.classList.remove("bi-emoji-angry-fill")
					hateBox.classList.add("bi-emoji-angry-fill", "text-danger")
				} else {
					heartBox.classList.remove("bi-emoji-heart-eyes-fill", "text-danger")
					heartBox.classList.add("bi-emoji-heart-eyes")
					hateBox.classList.remove("bi-emoji-angry")
					hateBox.classList.remove("bi-emoji-angry-fill", "text-danger")
					hateBox.classList.add("bi-emoji-angry")
				}	
			}
		}
		xhr.open("get", "../facebook/isHated?feed_id=" + feedId)
		xhr.send()
		
	}
	function showHidePostButton() {
		const commentTextBox = document.getElementById("commentTextBox")
		const postButton = document.getElementById("postButton")
		if(commentTextBox.value.trim() !== "") {
			postButton.style.display = "inline-block"
		} else {
			postButton.style.display = "none"
		}
	}
	function registerComment() {
		if(!mySessionId) {
			return;
		}
		const commentTextBox = document.getElementById("commentTextBox")
		const commentTextValue = commentTextBox.value;
		const commentTextValueBr = commentTextValue.replace(/\n/g, "<br>")
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				commentTextBox.value = ""
				reloadCommentList()
				showHidePostButton()
			}
		}
		xhr.open("post", "../facebook/registerComment")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("feed_id=" + feedId + "&feed_comment=" + encodeURIComponent(commentTextValue))
	}
	function reloadCommentList() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				document.getElementById("commentListBox").innerHTML = ""
				
				for(data of response.feedCommentDto) {
					const row1 = document.createElement("div")
					row1.classList.add("row", "mt-1")
					row1.classList.add("commentOuter")
					row1.setAttribute("id", data.feedCommentDto.id)
					
					const colImg = document.createElement("div")
					colImg.classList.add("col-1", "text-end")
					const img = document.createElement("img")
					img.classList.add("img-fluid")
					img.style.width = "30px"
					img.style.height = "30px"
					img.style.borderRadius = "50%"
					img.src = "/uploadFiles/" + data.userDto.profile_img
					colImg.appendChild(img)
					row1.appendChild(colImg)
					
					const colNickname = document.createElement("div")
					colNickname.classList.add("col-1", "p-0", "pt-1", "fw-semibold")
					colNickname.classList.add("bg-white")
					colNickname.innerText = data.userDto.user_name
					row1.appendChild(colNickname)
					
					const colCommentBox = document.createElement("div")
					colCommentBox.classList.add("commentBox")
					colCommentBox.classList.add("col", "pt-1", "small")
					colCommentBox.classList.add("bg-white")
					colCommentBox.innerText = data.feedCommentDto.feed_comment
					row1.appendChild(colCommentBox)
					
					
					if(mySessionId != null && data.feedCommentDto.user_comment_id == mySessionId) {
						
						const colUpdate = document.createElement("div")
						colUpdate.classList.add("col-2", "small", "text-end", "pt-1")
						colUpdate.setAttribute("onclick", "changeInputForUpdateComment(this)")
						const icon1 = document.createElement("i")
						icon1.classList.add("bi", "bi-pencil")
						colUpdate.appendChild(icon1)
						row1.appendChild(colUpdate)
						
						const colDelete = document.createElement("div")
						colDelete.classList.add("col-2")
						colDelete.setAttribute("onclick", "deleteComment(" + data.feedCommentDto.id + ")")
						const icon2 = document.createElement("i")
						icon2.classList.add("bi", "bi-x")
						colDelete.appendChild(icon2)
						row1.appendChild(colDelete)
					} else {
						const coll = document.createElement("div")
						coll.classList.add("col-4")
						row1.appendChild(coll)
					}
					
					document.getElementById("commentListBox").appendChild(row1)
				}
			}
		}
		xhr.open("get", "../facebook/getCommentList?feedId=" + feedId)
		xhr.send()
	}
	function deleteComment(id) {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				reloadCommentList()
			}
		}
		xhr.open("get", "../facebook/deleteComment?id=" + id)
		xhr.send()
	}
	function changeInputForUpdateComment(targetElement) {
		
		const commentOuter = targetElement.closest(".commentOuter");
		const commentBox = commentOuter.querySelector(".commentBox")
		const tempValue = commentBox.innerText
		commentBox.innerHTML = ""
		
		const inputTextComment = document.createElement("input")
		inputTextComment.type = "text"
		inputTextComment.classList.add("commentInputBox")
		inputTextComment.value = tempValue
		commentBox.appendChild(inputTextComment)
		
		const inputButtonUpdate = document.createElement("button")
		inputButtonUpdate.setAttribute("onclick", "updateComment(this)")
		const icon = document.createElement("i")
		icon.classList.add("bi", "bi-pencil")
		inputButtonUpdate.appendChild(icon)
		commentBox.appendChild(inputButtonUpdate)
		
		targetElement.innerText = "수정 취소"
		targetElement.setAttribute("onclick", "cancelUpdate(this)")
		
	}
	function cancelUpdate(targetElement) {
		console.log("---")
	}
	function updateComment(targetElement) {
		console.log("hey: ", targetElement)
		/* const commentOuter = targetElement.closest(".commentOuter"); */
		const commentOuter = targetElement.closest(".commentOuter")
		const id = commentOuter.getAttribute("id")
		const commentText = document.querySelector(".commentInputBox").value
		
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				reloadCommentList()
			}
		}
		xhr.open("post", "./updateComment")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("id=" + id + "&feed_comment=" + commentText)
	}
	
	function anotherFeedList() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				const row = document.createElement("div")
				row.classList.add("row", "m-0", "p-0")
				
				response.list.forEach(function(map) {
					const col = document.createElement("div")
					col.classList.add("col", "m-0", "p-0")
					
					const div = document.createElement("div")
					div.classList.add("image-wrapper", "p-0", "pb-1")
					const link = document.createElement("a")
					link.classList.add("p-0")
					link.href = "./feedDetailPage?id=" + map.feedImageDto.feed_id
					const img = document.createElement("img")
					img.src = "/uploadFiles/" + map.feedImageDto.feed_image
					link.appendChild(img)
					const div1 = document.createElement("div")
					div1.classList.add("overlay")
					const icon = document.createElement("i")
					icon.classList.add("bi", "bi-heart-fill", "fs-5", "pe-3")
					icon.innerText = map.count
					div1.appendChild(icon)
					const icon1 = document.createElement("i")
					icon1.classList.add("bi", "bi-chat-fill", "fs-5")
					icon1.innerText = map.chatCount
					div1.appendChild(icon1)
					link.appendChild(div1)
					div.appendChild(link)
					col.appendChild(div)
					row.appendChild(col)
				})
				document.getElementById("anotherFeedList").appendChild(row)
			}
		}
		xhr.open("get", "./feedDetailList")
		xhr.send()
	}
	window.addEventListener("DOMContentLoaded", function() {
		getSessionId();
		refreshTotalLikeCount()
		refreshTotalHateCount()
		refreshMyHeart()
		refreshMyHate()
		reloadCommentList()
		anotherFeedList()
		setInterval(reloadCommentList, 30000);
	});
</script>
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
        .col-bg {
			background-color: rgba(0, 128, 0, 0.1);
			border-bottom: 1px solid rgba(128, 128, 128, 0.3);
		}
		.col-feed {
			border-bottom: 2px solid rgba(128, 128, 128, 1.0);
		}
		.custom-size {
		 	width: 700px; /* 원하는 가로 크기 */
		}
		.col-word {
			 max-width: 100%;
  			overflow-wrap: break-word;
		}
		.col-photo {
			border-radius: 50%;
		}
		.form-control-plain {
		    border: none;
		    outline: none;
		    box-shadow: none;
		    resize: none;
  			height: 25px !important;
		}
		.no-margin {
		    margin: 0;
		}
		.custom-collapse {
   			transform: translateY(-170%);
   			z-index: 1;
  		}
  		.image-wrapper {
    position: relative;
    display: inline-block;
  }

  .image-wrapper img {
    width: 260px;
    height: 240px;
  }

  .image-wrapper .overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 260px;
    height: 240px;
    background-color: rgba(0, 0, 0, 0.4); /* 검정색 블러 효과를 위한 배경색 */
    opacity: 0;
    transition: opacity 0.3s;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .image-wrapper .overlay:hover {
    opacity: 1;
  }

  .image-wrapper .overlay i {
    font-size: 24px;
    color: white;
  }
  .carousel-inner img {
    width: 830px;
    height: 630px;
    object-fit: cover; /* 이미지 비율을 유지하면서 지정한 크기에 맞게 자르거나 확대합니다. */
  }
    </style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-3 fixed-left-navbar">
				<jsp:include page="../common/facebookLeftNavi.jsp"></jsp:include>
				</div>
			</div>
			<div class="col">
				<div class="row">
					<div class="col-4"></div>
					<div class="col">
						<div class="row">
							<div class="col-1"></div>
							<div class="col">
								<div class="row mt-4">
									<div class="col fw-bold fs-5">상세 피드</div>
								</div>
								<div class="row mt-3">
									<div class="col-3">
										<div class="row">
											<div class="col text-end">
												<c:if test="${map.feedDto.user_id != sessionUser.id}">
												<a href="./myPageUser?userId=${map.feedDto.user_id}">
												<img class="img-fluid col-photo text-center" style="width: 60px; height: 60px;" src="/uploadFiles/${map.userDto.profile_img}"/>
												</a>
												</c:if>
												<c:if test="${map.feedDto.user_id == sessionUser.id}">
												<a href="./myPage">
												<img class="img-fluid col-photo text-center" style="width: 60px; height: 60px;" src="/uploadFiles/${map.userDto.profile_img}"/>
												</a>
												</c:if>
											</div>
											<div class="col">
												<div class="row">
													<div class="col fw-bold fs-5"><a href="./myPageUser?userId=${map.feedDto.user_id}" style="text-decoration: none;" class="text-dark">${map.userDto.user_name}</a></div>
												</div>
												<div class="row">
													<div class="col small" style="opacity: 0.5;">${string}</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-9"></div>
								</div>
								<div class="row mt-2">
									<div class="col">
										<div class="row">
											<div class="col">
												<div id="carouselExampleIndicators" class="carousel slide">
												  <div class="carousel-indicators">
												     <c:forEach var="image" items="${mapt}" varStatus="status">
												      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" ${status.first ? 'class="active"' : ''} aria-label="Slide ${status.index + 1}"></button>
												    </c:forEach>
												  </div>
												  <div class="carousel-inner">
												    <c:forEach var="image" items="${mapt}" varStatus="status">
												      <div class="carousel-item ${status.first ? 'active' : ''}">
												        <img src="/uploadFiles/${image.feedImageDto.feed_image}" class="d-block w-100" alt="Slide ${status.index + 1}">
												      </div>
												    </c:forEach>
												  </div>
												  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
												    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
												    <span class="visually-hidden">Previous</span>
												  </button>
												  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
												    <span class="carousel-control-next-icon" aria-hidden="true"></span>
												    <span class="visually-hidden">Next</span>
												  </button>
												</div>
											</div>
										</div>
										
									</div>
								</div>
								<div class="row mt-3">
									<div class="col fs-6 col-word">${map.feedDto.feed_content}</div>
								</div>
								<div class="row">
									
									<div class="col">
										<div class="row">
										<div class="col-4">
											<p class="no-margin">
												<button class="btn btn-whtie mb-1" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
													<img class="img-fluid" style="width: 25px; height: 20px;" src="/roaming/resources/img/heartt.png">&nbsp;<span class="small fw-bold" id="totalLikeCount"></span><!-- 싫어요 <span class="badge text-bg-secondary" id="totalHateCount"></span> -->
												</button>
												<img class="img-fluid" style="width: 25px; height: 20px;" src="/roaming/resources/img/chatt.png">&nbsp;<span class="small fw-bold mt-1" id="totalChatingCount"></span>
											</p>
											<div class="collapse custom-collapse" id="collapseExample">
											  <div class="card border-0">
											  	<div style="display: flex;">
											    <i id="heartBox" onclick="toggleLike()" class="bi bi-emoji-heart-eyes fs-3"></i>
											    <i id="hateBox" onclick="toggleHate()" class="bi bi-emoji-angry fs-3 px-2"></i>
											  	</div>
											  </div>
											</div>
										</div>
										<div class="col" style="position: relative; right: 100px;">
											<textarea id="commentTextBox" class="form-control-plain form-control shadow-sm" aria-label="댓글 달기..." placeholder="댓글 달기..."></textarea>
											<input onclick="registerComment()" class="btn btn-white btn-sm text-primary opacity-75" type="button" value="댓글 작성" style="position: absolute; top: 5px; right: 15px;">
										</div>
										</div>
									
									<div class="row mt-3">
										<div id="commentListBox" class="col">
											<div class="row commentOuter">
												<div class="col"></div>
												<div class="col-1 bg-white">닉네임</div>
												<div class="commentBox col bg-white">내용</div>
												<div class="col bg-white"><i class="bi bi-x"></i></div>
												<!-- <div class="col bg-white">수정</div> -->
											</div>
										</div>
									</div>
									<!-- <div class="row">
										<div class="col-10">
											<textarea id="commentTextBox" class="form-control-plain" aria-label="댓글 달기..." placeholder="댓글 달기..."></textarea>
										</div>
										<div class="col d-grid">
											<input onclick="registerComment()" class="btn btn-white btn-sm" type="button" value="댓글 작성">
										</div>
									</div> -->
									</div>
									
								</div>
							</div>
							<div class="col-1"></div>
						</div>
						
						<div class="row">
							<div class="col">
								<div class="row border my-5">
									<div class="col"></div>
								</div>
								
								<div class="row my-2">
									<div class="col text-start opacity-75">게시물 더보기</div>
								</div>
								<div class="row" id="anotherFeedList"></div>
							</div>
							
						</div>
						<div class="row mt-5"></div>
						<div class="row my-5">
							
							<div class="col"><img class="img-fluid" src="/roaming/resources/img/footer.png"></div>
							
						</div>
					</div>
					<div class="col-3"></div>
				</div>
			</div>
		</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>