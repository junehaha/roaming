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
	let receive = null
	function messageInfo() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const sessionUser = response.sessionValue
				const userInfor = document.getElementById("userInfo")
				userInfor.innerHTML = ""
				
				response.list.forEach(function(data) {
					const row = document.createElement("div")
					row.classList.add("row")
					row.setAttribute("onclick", "reloadChatRoom("+data.userDto.id+")")

					
					
					const col = document.createElement("div")
					col.classList.add("col-1")
					const img = document.createElement("img")
					img.classList.add("img-fluid", "mt-1")
					img.style.width = "70px"
					img.style.height = "50px"
					img.style.borderRadius = "50%"
					img.src = "/uploadFiles/" + data.userDto.profile_img
					
					row.appendChild(img)
					row.appendChild(col)
					
					const col1 = document.createElement("div")
					col1.classList.add("col")
					
					const row1 = document.createElement("div")
					row1.classList.add("row")
					const col2 = document.createElement("div")
					col2.classList.add("col", "text-start")
					col2.innerText = data.userDto.user_name
					row1.appendChild(col2)
					col1.appendChild(row1)
					
					const row2 = document.createElement("div")
					row2.classList.add("row")
					const col3 = document.createElement("div")
					col3.classList.add("col")
					col3.innerText = "최근 내용"
					row2.appendChild(col3)
					col1.appendChild(row2)
					
					row.appendChild(col1)
					document.getElementById("userInfo").appendChild(row)
				})
			}
		}
		xhr.open("get", "./messageUserInfo")
		xhr.send()
	}
	function reloadChatRoom(receiveId) {
		const reloadChat = document.getElementById("chatingRoom");
		const chatRow = document.getElementById("chatRow")
		 
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const user = response.user.userDto
				
				updateChatCount(receiveId)
				
				reloadChat.innerHTML = ""
				receive = receiveId
				const row = document.createElement("div")
				row.classList.add("row", "mt-5", "me-0")
				
				const col = document.createElement("div")
				col.classList.add("col-1", "m-0")
				const link = document.createElement("a")
				link.href = "./myPageUser?userId=" + receive
				const img = document.createElement("img")
				img.classList.add("img-fluid")
				img.style.borderRadius = "50%"
				img.style.width = "50px"
				img.style.height = "40px"
				img.src = "/uploadFiles/" + user.profile_img
				link.appendChild(img)
				col.appendChild(link)
				row.appendChild(col)
				
				const coll = document.createElement("div")
				coll.classList.add("col-2", "text-start", "fs-4")
				coll.innerText = user.user_id
				row.appendChild(coll)
				
				const coll2 = document.createElement("div")
				coll2.classList.add("col")
				row.appendChild(coll2)
				
				const coll3 = document.createElement("div")
				coll3.classList.add("col-1", "text-end")
				const icon1 = document.createElement("i")
				icon1.classList.add("bi", "bi-x-lg", "fw-bold")
				icon1.onclick = chatDefault
				/* icon1.setAttribute("onclick", "chatDefault()") */
				coll3.appendChild(icon1)
				row.appendChild(coll3)
				
				
				document.getElementById("chatingRoom").appendChild(row)	
				
				response.list.forEach(function(map) {
					const row1 = document.createElement("div")
					row1.classList.add("row")
					
					const col1 = document.createElement("div")
					col1.classList.add("col", "mt-2")
					if (map.send_id == mySessionId) {
					  const row11 = document.createElement("div")
					  row11.classList.add("row", "mt-1")
					  const col11 = document.createElement("div")
					  col11.classList.add("col", "text-end");
					const span11 = document.createElement("span")
					span11.classList.add("blue-text")
					span11.innerText = map.content
					  col11.appendChild(span11)
					  row11.appendChild(col11)
					  col1.appendChild(row11)
					} else {
						const row11 = document.createElement("div")
						  row11.classList.add("row", "mt-1")
						  const col11 = document.createElement("div")
						  col11.classList.add("col", "text-start");
						const span11 = document.createElement("span")
						span11.classList.add("gray-text")
						span11.innerText = map.content
						  col11.appendChild(span11)
						  row11.appendChild(col11)
						  col1.appendChild(row11)
					}
					
					row1.appendChild(col1)
					reloadChat.appendChild(row1)
				})
				const crow = document.createElement("div")
				crow.classList.add("row", "chatInput")
				
				const ccol = document.createElement("div")
				ccol.classList.add("col")
				const textarea = document.createElement("textarea")
				textarea.setAttribute("id", "chatingTextBox")
				textarea.classList.add("form-control", "custom-textarea")
				textarea.setAttribute("placeholder", "메세지를 입력하세요..")
				
				textarea.addEventListener("keyup", function(event) {
				  // Shift + Enter 키가 눌렸을 때는 개행을 추가하고, 메시지 전송을 하지 않습니다.
				  if (event.key === "Enter" && event.shiftKey) {
				    return;
				  }
				
				  // Enter 키만 눌렸을 때 메시지를 전송합니다.
				  if (event.key === "Enter") {
				    event.preventDefault(); // Enter 키의 기본 동작(개행) 방지
				
				    const textBox = document.getElementById("chatingTextBox");
				    const textValue = textBox.value.trim();
				
				    // 메시지가 공백이 아닐 경우에만 메시지를 전송합니다.
				    if(textValue !== "") {
				      registerChat(textValue)
				      textBox.value = ""
				    }
				  }
				});

				
				ccol.appendChild(textarea)
				crow.appendChild(ccol)
				
				document.getElementById("chatRow").appendChild(crow)
			}
		}
		xhr.open("get", "./reloadChating?receiveId=" + receiveId)
		xhr.send()
	}

	/* function registerChat(textValue) {
		
		
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				reloadChatRoom(receive)
			}
		}
		xhr.open("post", "./registerChating")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("send_id=" + mySessionId + "&receive_id=" + receive + "&content=" + textValue)
	}  */
	function registerChat(textValue) {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				// 새로운 채팅 메시지를 화면에 바로 추가합니다.
				const reloadChat = document.getElementById("chatingRoom");
				
				// 채팅 메시지를 담을 row 생성
				const row = document.createElement("div")
				row.classList.add("row")
				
				// 메시지 본문을 담을 col 생성
				const col = document.createElement("div")
				col.classList.add("col", "mt-2")
				
				// 메시지 본문을 담을 row와 col 생성
				const row11 = document.createElement("div")
				row11.classList.add("row")
				const col11 = document.createElement("div")
				
				// 메시지 본문을 담은 span 생성
				const span = document.createElement("span")
				
				// 메시지가 보낸 사람이 현재 사용자인 경우
				if (mySessionId == mySessionId) { // map.send_id를 mySessionId로 대체했습니다.
					col11.classList.add("col", "text-end", "mt-1")
					span.classList.add("blue-text")
				} else {
					col11.classList.add("col", "text-start", "mt-1")
					span.classList.add("gray-text")
				}
				
				span.innerText = textValue
				
				col11.appendChild(span)
				row11.appendChild(col11)
				col.appendChild(row11)
				row.appendChild(col)
				reloadChat.appendChild(row)
			}
		}
		xhr.open("post", "./registerChating")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("send_id=" + mySessionId + "&receive_id=" + receive + "&content=" + textValue)
	}


	function updateChatCount(receiveId) {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				
			}
		}
		xhr.open("get", "./updateChatCount?receiveId=" + receiveId)
		xhr.send()
	}
	function chatDefault() {
		const chatingRoom = document.getElementById("chatingRoom");
		chatingRoom.innerHTML = ""
		const chatRow = document.getElementById("chatRow")
		chatRow.innerHTML = ""
	}
	window.addEventListener("DOMContentLoaded", function() {
		getSessionId()
		messageInfo()	
	})
</script>
<title>mainPage</title>
    <style>
        .fixed-left-navbar {
            position: fixed;
            top: 0;
            left: 290px;
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
		.fixed-left {
            height: 100vh;
            width: 660px;
            border-right: 1px solid rgba(128, 128, 128, 0.3);
        }
        .fixed-bottom {
	      position: fixed;
	      bottom: 0;
	      right: 0;
	      width: 60%;
	      padding: 20px;
	      background-color: white;
	      transform: translateX(calc(100% - 35%));
	      
	    }
	    .custom-textarea {
	      width: 500px;
		  height: 40px; /* 원하는 높이로 설정 */
		  border-radius: 20px; /* 양끝에 원하는 border-radius 설정 */
		  margin-bottom: 10px;
		}
		.blue-text {
			background-color: rgb(55, 151, 240);
		 	color: white;
  			padding: 8px;
  			
  			border-radius: 10px;
		}
		.gray-text {
			background-color: rgb(239, 239, 239);
		 	color: black;
  			padding: 8px;
  			
  			border-radius: 10px;
		}
		.chatInput {
		  position: fixed;
	      bottom: 10px;
	      left: 1050px;
      
		}
		.scroll {
		   overflow-y: 1100px;
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
							<div class="col-4" style="border-right: 1px solid rgba(128, 128, 128, 0.3); height: 100vh;">
								<div class="row mt-5">
									<div class="col fw-bold fs-3">아이디</div>
									<div class="col-3">
										<i class="bi bi-messenger fw-bold fs-3"></i>
									</div>
								</div>	
								<div class="row">
									<div class="col mt-5">메세지</div>
								</div>
								<div class="row" id="userInfo"></div>
							</div>
							<div class="col" id="chatingRoomMain" style="border-right: 1px solid rgba(128, 128, 128, 0.3); height: 100vh;">
								<div class="row" id="chatingRoom"></div>
								
								<div class="row chatInput" id="chatRow">
									<!-- <div class="col">
										 <textarea id="chatingTextBox" class="form-control custom-textarea" placeholder="메시지를 입력하세요"></textarea>
									</div>
									<div class="col-2">
										 <input onclick="registerChat()" class="btn btn-white btn-sm" type="button" value="전송">
									</div> -->
								</div>
								
							</div>
						</div>
					</div>
					<div class="col-2"></div>
				</div>
			</div>			
		</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>