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
	const userId = new URLSearchParams(location.search).get("userId")
	
	var mySessionId = null
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
	
	function reloadMyBoard() {
		const boardText = document.getElementById("reloadList");
	    boardText.style.fontWeight = "bold";
	    boardText.style.borderTop = "2px solid black"; // 원하는 색상으로 변경 가능
	    boardText.style.marginTop = "-10px";
	    boardText.style.paddingTop = "8px"
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const boardBox = document.getElementById("getBoardList")
				boardBox.innerHTML = ""
				
				const boardText1 = document.getElementById("reloadList1");
			    boardText1.style.fontWeight = "normal";
			    boardText1.style.borderTop = "none";
			    boardText1.style.marginTop = "0";
			    boardText1.style.paddingTop = "0";
			    const boardText2 = document.getElementById("reloadList2")
			    boardText2.style.fontWeight = "normal";
			    boardText2.style.borderTop = "none";
			    boardText2.style.marginTop = "0";
			    boardText2.style.paddingTop = "0";
				
				response.list.forEach(function(map) {
					const col1 = document.createElement("div")
					col1.classList.add("col-4", "p-0")
					
					const img = document.createElement("img")
					img.classList.add("img-fluid", "board-photo")
					img.src="/uploadFiles/" + map.feedImageDto.feed_image
					
					const link = document.createElement("a")
					link.href = "./feedDetailPage?id=" + map.feedImageDto.feed_id
					link.appendChild(img)
					
					col1.appendChild(link)
					boardBox.appendChild(col1)
				})
			}
		}
		xhr.open("get", "./getMyBoardList?userId=" + userId)
		xhr.send()
	}
	function reloadReels() {
		const boardText1 = document.getElementById("reloadList1");
	    boardText1.style.fontWeight = "bold";
	    boardText1.style.borderTop = "2px solid black"; // 원하는 색상으로 변경 가능
	    boardText1.style.marginTop = "-10px";
	    boardText1.style.paddingTop = "8px"
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const boardBox = document.getElementById("getBoardList")
				boardBox.innerHTML = ""
				
				const boardText = document.getElementById("reloadList");
			    boardText.style.fontWeight = "normal";
			    boardText.style.borderTop = "none";
			    boardText.style.marginTop = "0";
			    boardText.style.paddingTop = "0";
			    const boardText2 = document.getElementById("reloadList2");
			    boardText2.style.fontWeight = "normal";
			    boardText2.style.borderTop = "none";
			    boardText2.style.marginTop = "0";
			    boardText2.style.paddingTop = "0";
				
			    const container = document.createElement("div");
			    container.id = "getBoardList";

			    let row; // Declare the 'row' variable outside the loop

			    response.list.forEach(function (map, index) {
			      // Check if the current index is a multiple of 4 to create a new row
			      if (index % 4 === 0) {
			        row = document.createElement("div"); // Initialize 'row' when needed
			        row.classList.add("row");
			        container.appendChild(row);
			      }

			      const col = document.createElement("div");
			      col.classList.add("col", "p-0", "m-0");
			      const video = document.createElement("video");
			      video.classList.add("img-fluid");
			      video.style.width = "198px";
			      video.style.height = "370px";
			      video.src = "/uploadFiles/" + map.reelsDto.reels_video;
			      col.appendChild(video);
			      row.appendChild(col);

			      // Add a mouseover event listener to show the controls when the mouse hovers over the video
			      video.addEventListener("mouseover", function () {
			        video.controls = true;
			      });

			      // Add a mouseout event listener to hide the controls when the mouse leaves the video
			      video.addEventListener("mouseout", function () {
			        video.controls = false;
			      });

			    });

			    // Get the div with the ID "getBoardList"
			    const getBoardListDiv = document.getElementById("getBoardList");
			    getBoardListDiv.appendChild(container);


			}
		}
		xhr.open("get", "./getMyReels?userId=" + userId)
		xhr.send()
	}
		function reloadTag() {
			const listBox = document.getElementById("getBoardList")
			listBox.innerHTML = ""
			const boardText = document.getElementById("reloadList");
		    boardText.style.fontWeight = "normal";
		    boardText.style.borderTop = "none";
		    boardText.style.marginTop = "0";
		    boardText.style.paddingTop = "0";
		    const boardText1 = document.getElementById("reloadList1");
		    boardText1.style.fontWeight = "normal";
		    boardText1.style.borderTop = "none";
		    boardText1.style.marginTop = "0";
		    boardText1.style.paddingTop = "0";
		    const boardText2 = document.getElementById("reloadList2");
		    boardText2.style.fontWeight = "bold";
		    boardText2.style.borderTop = "2px solid black"; // 원하는 색상으로 변경 가능
		    boardText2.style.marginTop = "-10px";
		    boardText2.style.paddingTop = "8px"
		    
		    const row = document.createElement("div")
		    row.classList.add("row", "mt-5")
		    
		    const col = document.createElement("div")
		    col.classList.add("col", "text-center")
		    
		    const img = document.createElement("img")
		    img.classList.add("img-fluid")
		    img.src = "../resources/img/tagsss.png"
		    img.style.width = "180px"
		    img.style.height = "140px"
		    col.appendChild(img)
		    row.appendChild(col)
		    document.getElementById("getBoardList").appendChild(row)
		}
	const param = '${sessionUser.id}'
	function registerFollow() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				getUserProfileInfo()
			}
		}
		xhr.open("post", "./followProcess")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("send_id=" + param + "&receive_id=" + userId)
	}
	function deleteFollow() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				getUserProfileInfo()
			}
		}
		xhr.open("post", "./deleteFollowUser")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("send_id=" + param + "&receive_id=" + userId)
	}
	function getUserProfileInfo() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const map = response.map
				const count = response.count
				const follow = response.follow
				const follower = response.follower
				const followCount = response.followCount
				
				
				document.getElementById("getUserProfile").innerHTML = ""
				const row1 = document.createElement("div")
				row1.classList.add("row", "mt-5", "col-login")
				
				const col1 = document.createElement("div")
				col1.classList.add('col-1')
				row1.appendChild(col1)
				
				const col2 = document.createElement("div")
				col2.classList.add("col-3", "mb-5")
				if(map.userDto.profile_img == null) {
					const img = document.createElement("img")
					img.classList.add("img-fluid", "img-size")
					img.style.width = "140px"
					img.style.height = "140px"
					img.src = "/roaming/resources/img/oirgin.png"
					col2.appendChild(img)
				}else if(map.userDto.profile_img != null && map.userDto.profile_img.startsWith('20')) {
					const img = document.createElement("img")
					img.classList.add("img-fluid", "img-size")
					img.style.width = "140px"
					img.style.height = "140px"
					img.src = "/uploadFiles/" + map.userDto.profile_img
					col2.appendChild(img)
				}else if(map.userDto.profile_img != null && map.userDto.profile_img.startsWith('http')) {
					const img = document.createElement("img")
					img.classList.add("img-fluid", "img-size")
					img.style.width = "140px"
					img.style.height = "140px"
					img.src = map.userDto.profile_img
					col2.appendChild(img)
				}
				
				row1.appendChild(col2)
				
				const col3 = document.createElement("div")
				col3.classList.add("col")
				row1.appendChild(col3)
				
				const row2 = document.createElement("div")
				row2.classList.add("row")
				
				const col4 = document.createElement("div")
				col4.classList.add("col-2", "fw-bold", "fs-5")
				col4.innerText = map.userDto.user_name
				row2.appendChild(col4)
				
				const col44 = document.createElement("div")
				col44.classList.add("col-3", "text-center")
				col44.innerHTML = ""
				if(response.babo === 0) {
					const link22 = document.createElement("button")
					link22.classList.add("btn", "btn-primary", "btn-sm")
					link22.innerText ="팔로우"
					link22.setAttribute("onclick", "registerFollow()")
					col44.appendChild(link22)
				} else {
					const link111 = document.createElement("button")
					link111.classList.add("btn", "btn-secondary", "btn-sm")
					link111.innerText = "팔로잉"
					link111.setAttribute("onclick", "deleteFollow()")
					col44.appendChild(link111)
				}
				row2.appendChild(col44)
				
				const col5 = document.createElement("div")
				col5.classList.add("col-3", "text-center")
				
				const link = document.createElement("a")
				link.classList.add("btn", "btn-secondary", "btn-sm")
				link.href = "./message"
				link.innerText = "메세지 보내기"
				col5.appendChild(link)
				row2.appendChild(col5)
				
				const col6 = document.createElement("div")
				col6.classList.add("col")
				row2.appendChild(col6)
				col3.appendChild(row2)
				
				const row3 = document.createElement("div")
				row3.classList.add("row", "mt-3")
				
				const col7 = document.createElement("div")
				col7.classList.add("col-3")
				col7.innerText = "게시물" + count
				row3.appendChild(col7)
				
				const col8 = document.createElement("div")
				col8.classList.add("col-3")
				col8.innerText = "팔로워" + follower
				row3.appendChild(col8)
				
				const col88 = document.createElement("div")
				col88.classList.add("col-3")
				col88.innerText = "팔로우" + follow
				row3.appendChild(col88)
				
				const col9 = document.createElement("div")
				col9.classList.add("col")
				row3.appendChild(col9)
				col3.appendChild(row3)
				
				const row4 = document.createElement("div")
				row4.classList.add("row", "mt-3", "fw-bold", "small")
				
				const col10 = document.createElement("div")
				col10.classList.add("col")
				col10.innerText = map.userDto.user_id
				row4.appendChild(col10)
				col3.appendChild(row4)
				row1.appendChild(col3)
				
				document.getElementById("getUserProfile").appendChild(row1)
			}
		}
		xhr.open("get", "./getUserProfile?userId=" + userId)
		xhr.send()
	}
	window.addEventListener("DOMContentLoaded", function() {
		getSessionId()
		reloadMyBoard()
		getUserProfileInfo()
	})
</script>
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
			border-bottom: 1px solid rgba(128, 128, 128, 0.3);
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
	    .img-size {
    		border-radius: 50%;
    	}
    	.board-photo {
    		width: 285px;
    		height: 270px;
    		padding: 2px;
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
					<div class="col-6">
						<div class="row mt-5" id="getUserProfile">
							
						</div>
						<div class="row mt-2">
							<div class="col"></div>
							<div class="col-1 small text-center" onclick="reloadMyBoard()" id="reloadList"><i class="bi bi-image"></i> 피드</div>
							<div class="col-1"></div>
							<div class="col-1 small text-center" onclick="reloadReels()" id="reloadList1"><i class="bi bi-play-btn"></i> 릴스</div>
							<div class="col-1"></div>
							<div class="col-1 small text-center" onclick="reloadTag()" id="reloadList2"><i class="bi bi-camera"></i> 태그됨</div>
							<div class="col"></div>
						</div>
						<div class="row">
							<div class="col-1"></div>
							<div class="col">
									<div class="row" id="getBoardList"></div>
							</div>
							<div class="col-1"></div>
						</div>
					</div>
					<div class="col"></div>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
