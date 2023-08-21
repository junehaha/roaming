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
	let mySessionId = null
	function getSessionId() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				if(response.result == "success") {
					mySessionId = response.id
				}
			}
		}
		xhr.open("get", "../user/getMyId", false)
		xhr.send()
	}
	
	function reloadReelsList() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const reelsContainer = document.getElementById("reelsForMoon")
		        reelsContainer.innerHTML = ""
				
				response.list.forEach(function(map) {
					reelsId = map.reelsDto.id
					const row = document.createElement("div")
					row.classList.add("row")
					
					const col = document.createElement("div")
					col.classList.add("col")
					
					const row1 = document.createElement("div")
					row1.classList.add("row", "mt-3")
					
					const col1 = document.createElement("div")
					col1.classList.add("col-2")
					const link = document.createElement("a")
					link.href = "./myPageUser?userId=" + map.userDto.id
					const img = document.createElement("img")
					img.classList.add("img-fluid")
					img.src = "/uploadFiles/" + map.userDto.profile_img
					img.style.width = "40px"
					img.style.height = "40px"
					img.style.borderRadius = "50%"
					link.appendChild(img)
					col1.appendChild(link)
					row1.appendChild(col1)
					
					const col2 = document.createElement("div")
					col2.classList.add("col-3", "text-start", "pt-2", "ps-0")
					const link1 = document.createElement("a")
					link1.style.position = "relative"
					link1.style.left = "-30px"
					link1.classList.add("text-start", "fs-6")
					link1.style.textDecoration = "none"
					link1.style.color = "black"
					link1.href = "./myPageUser?userId=" + map.userDto.id
					link1.innerText = map.userDto.user_id
					const span = document.createElement("span")
					span.classList.add("opacity-50")
					span.innerText = "  •  " + map.datef
					link1.appendChild(span)
					col2.appendChild(link1)
					row1.appendChild(col2)
					
					const col3 = document.createElement("div")
					col3.classList.add("col", "mt-2", "small", "text-end", "pt-1")
					col3.innerText = "팔로우"
					row1.appendChild(col3)
					col.appendChild(row1)
					
					const row2 = document.createElement("div")
					row2.classList.add("row")
					
					const col4 = document.createElement("div")
					col4.classList.add("col","mt-2")
					const video = document.createElement("video")
					video.classList.add("img-fluid")
					video.src = "/uploadFiles/" + map.reelsDto.reels_video
					video.controls = false
					
					video.addEventListener("click", function(event) {
						if (video.paused) {
					        video.play()
					    } else {
					        video.pause()
					    }
					})
					
				    col4.appendChild(video)
				    row2.appendChild(col4)
				    col.appendChild(row2)
				    
				    const row3 = document.createElement("div")
				    row3.classList.add("row")

				    const col5 = document.createElement("div")
				    col5.classList.add("col")
				    const span1 = document.createElement("span")
				    span1.style.cursor = "pointer"
				    const icon1 = document.createElement("i")
				    icon1.classList.add("bi", "bi-heart", "fs-4", "p-0")
				    icon1.id = "heartReels" + reelsId
				    icon1.setAttribute("onclick", "toggleReelsLike("+reelsId+")")
				    span1.appendChild(icon1)
				    col5.appendChild(span1)
				    const span2 = document.createElement("span")
				    span2.style.position = "relative"
				    span2.style.right = "-20px"
				    span2.style.top = "-2px"
				    span2.setAttribute("onclick", "reelsCommentModal("+reelsId+")")
				    span2.style.cursor = "pointer"
				    const icon2 = document.createElement("i")
				    icon2.classList.add("bi", "bi-chat", "fs-4")
				    span2.appendChild(icon2)
				    col5.appendChild(span2)
				    const span3 = document.createElement("span")
				    span3.style.position = "relative"
				    span3.style.right = "-40px"
				    span3.style.top = "-1px"
				    span3.style.cursor = "pointer"
				    const icon3 = document.createElement("i")
				    icon3.classList.add("bi", "bi-send", "fs-4")
				    span3.appendChild(icon3)
				    col5.appendChild(span3)
				    const span4 = document.createElement("span")
				    span4.style.position = "relative"
				    span4.style.right = "-450px"
				    span4.style.top = "-1px"
				    span4.style.cursor = "pointer"
				    const icon4 = document.createElement("i")
				    icon4.classList.add("bi", "bi-bookmark", "fs-4")
				    span4.appendChild(icon4)
				    col5.appendChild(span4)
				    
				    row3.appendChild(col5)
				    col.appendChild(row3)
				    
				    const row4 = document.createElement("div")
				    row4.classList.add("row")
				    
				    const coll1 = document.createElement("div")
				    coll1.classList.add("col", "small")
				    coll1.id = "totalReelsCount" + reelsId
				    coll1.innerText = "좋아요 " + map.reelsCount + "개"
				    row4.appendChild(coll1)
				    col.appendChild(row4)
				    
				    const row55 = document.createElement("div")
				    row55.classList.add("row")
				    
				    const col55 = document.createElement("div");
					col55.classList.add("col-2", "small", "fw-bold", "text-center");
					const link55 = document.createElement("a")
					link55.style.textDecoration = "none"
					link55.style.color = "black"
					link55.innerText = map.userDto.user_name
					link55.href = "./myPageUser?userId=" + map.userDto.id
					col55.appendChild(link55)
					row55.appendChild(col55)
							
					const col66 = document.createElement("div")
					col66.classList.add("col", "small", "text-start")
					const contentContainer = document.createElement("div");
					contentContainer.classList.add("content-container");
					const summaryText = ""
					const fullText = map.reelsDto.reels_content;
					const summaryTextSpan = document.createElement("span");
					summaryTextSpan.classList.add("summary-text");
					summaryTextSpan.innerText = summaryText;
					const fullTextSpan = summaryTextSpan.cloneNode(false); // 요소 복제
					fullTextSpan.classList.remove("summary-text");
					fullTextSpan.classList.add("full-text");
					fullTextSpan.innerText = fullText;
					const showMoreBtn = document.createElement("a");
					showMoreBtn.classList.add("show-more", "opacity-50");
					showMoreBtn.style.textDecoration = "none"
					showMoreBtn.style.color = "black"
					showMoreBtn.innerText = "더보기";
					showMoreBtn.style.cursor = "pointer"
					// 내용 초기 숨김
					fullTextSpan.style.display = "none";
					contentContainer.appendChild(summaryTextSpan);
					contentContainer.appendChild(fullTextSpan);
					contentContainer.appendChild(showMoreBtn);
					
					col66.appendChild(contentContainer);
					row55.appendChild(col66);
					col.appendChild(row55);
					// 버튼 클릭 시 내용 보여주기
					showMoreBtn.addEventListener("click", function() {
					    fullTextSpan.style.display = "inline";
					    showMoreBtn.style.display = "none";
					});
					
					const row777 = document.createElement("div")
					row777.classList.add("row")
					const col777 = document.createElement("div")
					col777.classList.add("col-4", "small", "opacity-50")
					col777.innerText = "댓글  " + map.reelsCommentCount + "개 모두 보기"
					col777.setAttribute("onclick", "reelsCommentModal("+reelsId+")")
					col777.style.cursor = "pointer"
					
					row777.appendChild(col777)
					const col7777 = document.createElement("div")
					col7777.classList.add("col")
					row777.appendChild(col7777)
					col.appendChild(row777)

					map.reelsCommentDto.forEach(function(data) {
						
						const row555 = document.createElement("div")
						row555.classList.add("row")
						const col555 = document.createElement("div")
						col555.classList.add("col")
						const span555 = document.createElement("span")
						const link555 = document.createElement("a")
						link555.style.textDecoration = "none"
						link555.style.fontWeight = "bold"
						link555.style.color = "black"
						link555.href = "./myPageUser?userId=" + map.userDto.id
						link555.innerText = map.userDto.user_id
						span555.appendChild(link555)
						col555.appendChild(span555)
						const span666 = document.createElement("span")
						span666.classList.add("ml-1")
						span666.innerText = data.reels_comment
						span666.style.position = "relative"
						span666.style.left = "15px"
						col555.appendChild(span666)
						row555.appendChild(col555)
						col.appendChild(row555)
						
					})
					
				    const row5 = document.createElement("div")
				    row5.classList.add("row")
				    row5.style.borderBottom = "1px solid rgba(128, 128, 128, 0.3)"
				    const coll2 = document.createElement("div")
				    coll2.classList.add("col")
				    
				    
				    const textBox = document.createElement("textarea")
				    textBox.classList.add("form-control-plain", "my-1", "small")
				    textBox.id = "reelsTextBox" + reelsId
					textBox.placeholder = "댓글 달기..."
					coll2.appendChild(textBox)
				    row5.appendChild(coll2)
				    const coll22 = document.createElement("div")
				    coll22.classList.add("col-2", "small", "opacity-50", "text-end")
				    coll22.innerText = "게시"
				    coll22.style.cursor = "pointer"
				    coll22.style.color = "blue"
				    coll22.setAttribute("onclick", "registerReelsComment("+reelsId+")")
				    row5.appendChild(coll22)
				    
				    col.appendChild(row5)
				    
				    row.appendChild(col)
				    reelsContainer.appendChild(row)
				    
				    refreshReelsHeart(reelsId)
				    /*
					
					// Textarea에서 Enter 칠 때도 전송되기(단, shirt+enter 안되게)
					function keyUpEvent(e) {
					    if (e.key === "Enter" && !e.shiftKey) {
					    	insertContent(requestId2, receiverId2);
					    }
					}
					*/

				})
			}
		}
		xhr.open("get", "./getReelsList")
		xhr.send()
 	}
	
	function reelsCommentModal(reelsId) {
		const modal = bootstrap.Modal.getOrCreateInstance("#commentModal")
		modal.show();
		
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const modalBodyList = document.getElementById("modalBodyList")
				modalBodyList.innerHTML = ""
				
				response.list.forEach(function(map) {
					const row = document.createElement("div")
					row.classList.add("row")
					
					const col = document.createElement("div")
					col.classList.add("col-2")
					const link = document.createElement("a")
					link.href = "./myPageUser?userId=" + map.userDto.id
					const img = document.createElement("img")
					img.classList.add("img-fluid")
					img.src = "/uploadFiles/" + map.userDto.profile_img
					img.style.width = "30px"
					img.style.height = "30px"
					img.style.borderRadius = "50%"
					link.appendChild(img)
					col.appendChild(link)
					row.appendChild(col)
					
					const col1 = document.createElement("div")
					col1.classList.add("col")
					const row1 = document.createElement("div")
					row1.classList.add("row")
					const col2 = document.createElement("div")
					col2.classList.add("col")
					col2.innerText = map.userDto.user_id
					row1.appendChild(col2)
					col1.appendChild(row1)
					const row2 = document.createElement("div")
					row2.classList.add("row")
					const col3 = document.createElement("div")
					col3.classList.add("col")
					col3.innerText = map.reelsCommentDto.reels_comment
					row2.appendChild(col3)
					col1.appendChild(row2)
					const row3 = document.createElement("div")
					row3.classList.add("row")
					const col4 = document.createElement("div")
					col4.classList.add("col", "small")
					const span = document.createElement("span")
					span.classList.add("small", "opacity-50")
					span.innerText = "댓글 달기"
					span.style.cursor = "pointer"
					col4.appendChild(span)
					row3.appendChild(col4)
					col1.appendChild(row3)
					row.appendChild(col1)
					
					const col5 = document.createElement("div")
					col5.classList.add("col-1")
					row.appendChild(col5)
					
					document.getElementById("modalBodyList").appendChild(row)
				})
				const textarea = document.getElementById("commentModalTextBox");
			    textarea.addEventListener("keydown", function(event) {
			        if (event.key === "Enter" && !event.shiftKey) {
			            keyDownEvent(event);
			        }
			    });
			    function keyDownEvent(event) {
			    	registerModalComment(reelsId)
			    }
			}
		}
		xhr.open("post", "./reeslsCommentModal")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("reels_id=" + reelsId)
	}
	function registerModalComment(reelsId) {
		if(!mySessionId) {
			return
		}
		const reelsModalBox = document.getElementById("commentModalTextBox")
		const reelsModalValue = reelsModalBox.value
		const reelsModalValueBr = reelsModalValue.replace(/\n/g, "<br>")
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				reelsModalBox.value = ""
				reelsCommentModal(reelsId)
				
			}
		}
		xhr.open("post", "./registerReelsModalComment")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("reels_id=" + reelsId + "&reels_comment=" + encodeURIComponent(reelsModalValue))
		
	}
	function registerReelsComment(reelsId) {
		if(!mySessionId) {
			return
		}
		const reelsTextBox = document.getElementById("reelsTextBox" + reelsId)
		const reelsTextValue = reelsTextBox.value
		const reelsTextValueBr = reelsTextValue.replace(/\n/g, "<br>")
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				reelsTextBox.value = ""
				reloadReelsList()
				
			}
		}
		xhr.open("post", "./registerReelsComment")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("reels_id=" + reelsId + "&reels_comment=" + encodeURIComponent(reelsTextValue))
	}
	function toggleReelsLike(reelsId) {
		if(mySessionId == null) {
			location.href = "../user/loginPage"
			return
		}
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				refreshTotalReelsCount(reelsId)
				refreshReelsHeart(reelsId)
			}
		}
		xhr.open("get", "./toggleReelsLike?reels_id=" + reelsId)
		xhr.send()
	}
	function refreshReelsHeart(reelsId) {
		console.log(reelsId)
		if(mySessionId == null) return
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const heartReels = document.getElementById("heartReels" + reelsId)
				
				
				if(response.isReelsLike) {
					heartReels.classList.remove("bi", "bi-heart", "fs-4", "p-0")
					heartReels.classList.add("bi", "bi-heart-fill", "fs-4", "p-0")
				} else {
					heartReels.classList.remove("bi", "bi-heart-fill", "fs-4", "p-0")
					heartReels.classList.add("bi", "bi-heart", "fs-4", "p-0")
				}
			}
		}
		
		xhr.open("get", "./isReelsLike?reels_id=" + reelsId)
		xhr.send()
	}
	function refreshTotalReelsCount(reelsId) {
		console.log(reelsId)
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const totalReelsCountBox = document.getElementById("totalReelsCount" + reelsId)
				totalReelsCountBox.innerHTML = ""
				totalReelsCountBox.innerText = "좋아요 " + response.reelsCount + "개"
			}
		}
		xhr.open("get", "./getTotalReelsCount?reels_id=" + reelsId)
		xhr.send()
	}
	window.addEventListener("DOMContentLoaded", function() {
		getSessionId()
		reloadReelsList()
		
		const modalElement = document.getElementById("commentModal");

       
        window.addEventListener("click", function(event) {
            
            if (event.target === modalElement) {
               
                const modal = bootstrap.Modal.getInstance(modalElement);
                if (modal) {
                    modal.hide();
                }
            }
        });
	});
</script>
<title>mainPage</title>
    <style>
        .fixed-left-navbar {
            position: fixed;
            top: 0;
            left: 330px;
            height: 100vh;
            width: 330px;
            background-color: white;
            border-right: 1px solid rgba(128, 128, 128, 0.3);
            border-left: 1px solid rgba(128, 128, 128, 0.3);
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
		.img-size {
    		border-radius: 50%;
    	}
    	.overlay-container {
    		position: absolute;
    		transform: translate(0, 90px);
    		top: 0;
    		left: 5;
    		padding: 10px;
    		background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0));
    		color: white;
    	}
    	.name-overlay {
    		font-weight: bold;
    		font-size: 13px;
    		margin-bottom: 5px;
    	}
    	.content-overlay {
    		font-weight: bold;
    		font-size: 13px;
    	}
    	.my-icon {
		  font-weight: bold;
		}
    	.form-control-plain {
		    border: none;
		    outline: none;
		    box-shadow: none;
		    resize: none;
  			height: 25px !important;
		}
		.modal-body {
		width: 100%;
        height: 100%;
    	}
    	.modal-content {
    	width: 100%;
        height: 100%;
        border: none;
        border-radius: 0;
    	}
    	
    	.modal-dialog {
    		position: absolute;
	        top: 20%;
	        left: 24%;
	        transform: translate(-50%, -50%);
    		width: 340px;
	        height: 800px;
	        min-width: 340px;
	        min-height: 800px;
    		box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    	}
    	
		.custom-textarea {
			width: 250px;
			height: 30px; /* 원하는 높이로 설정 */
	        max-width: 100%;
        	max-height: 100%;
        	border: none;
	        resize: none; /* (선택사항) 텍스트 에어리어의 크기 조절 비활성화 */
	    }
	    .scroll-container {
		  overflow: hidden; /* 스크롤 숨김 */
		  height: 700px; /* 스크롤 영역의 높이 설정 */
		}
		
		.scroll-container:hover {
		  overflow: auto; /* 마우스 호버 시 스크롤 보이기 */
		}
		
		/* 수직 스크롤 바 스타일 */
		.scroll-container::-webkit-scrollbar {
		  width: 4px;
		}
		
		.scroll-container::-webkit-scrollbar-track {
		  background-color: #f1f1f1;
		}
		
		.scroll-container::-webkit-scrollbar-thumb {
		  background-color: #888;
		  border-radius: 4px;
		}
		
		.scroll-container::-webkit-scrollbar-thumb:hover {
		  background-color: #555;
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
					<div class="col-5"></div>
					<div class="col">
						<div class="row" id="reelsForMoon"></div>
					</div>
					<div class="col"></div>
				</div>
			</div>
		</div>
	<div class="modal fade" id="commentModal" data-bs-backdrop="false" data-bs-keyboard="true" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header p-3">
	                <h2 class="modal-title fs-4" id="staticBackdropLabel">댓글</h2>
	            </div>
	            <div class="modal-body scroll-container">
	                <div class="row" id="modalBodyList">
	                	<div class="col"></div>
	                	<div class="col">
	                		<div class="row">
	                			<div class="col"></div>
	                		</div>
	                		<div class="row">
	                			<div class="col"></div>
	                		</div>
	                		<div class="row">
	                			<div class="col"></div>
	                		</div>
	                	</div>
	                	<div class="col-1"></div>
	                </div>
	            </div>
	            <div class="modal-footer p-2">
	               <div class="row">
	               		<div class="col">
	               			<textarea id="commentModalTextBox" class="form-control custom-textarea" placeholder="댓글 입력..."></textarea>
	               		</div>
	               </div>
	            </div>
	        </div>
	    </div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>