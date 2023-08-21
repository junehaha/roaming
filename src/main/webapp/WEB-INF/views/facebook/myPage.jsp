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
	
	function getMyProfileInfo() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const map = response.map
				const count = response.count
				const follow = response.follow;
				const follower = response.follower;
				
				document.getElementById("getMyProfileInfo").innerHTML = ""
					
				const row1 = document.createElement("div")
				row1.classList.add("row", "mt-5", "col-login")
				
				
				const col1 = document.createElement("div")
	            col1.classList.add("col-1")
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
	            }
	            if(map.userDto.profile_img != null) {
	                const img = document.createElement("img")
	                img.classList.add("img-fluid", "img-size")
	                img.style.width = "140px"
	                img.style.height = "140px"
	                img.src = "/uploadFiles/" + map.userDto.profile_img
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
	            col4.innerText = map.userDto.user_id
	            row2.appendChild(col4)

	            const col5 = document.createElement("div")
	            col5.classList.add("col-2")

	            const link = document.createElement("a")
	            link.classList.add("btn", "btn-secondary", "opacity-75", "btn-sm", "small")
	            link.href = "./myPageChange"
	            link.innerText = "프로필편집"
	            col5.appendChild(link)
	            row2.appendChild(col5)

	            const col6 = document.createElement("div")
	            col6.classList.add("col-3")
	            
	            const link11 = document.createElement("a")
	            link11.classList.add("btn", "btn-secondary", "opacity-75", "btn-sm")
	            link11.innerText = "보관된 스토리 보기"
	            col6.appendChild(link11)
	            row2.appendChild(col6)
	           
	            const col66 = document.createElement("div")
	            col66.classList.add("col", "fs-4")
	            
	            const icon66 = document.createElement("i")
	            icon66.classList.add("bi", "bi-gear-wide", "pb-3")
	            col66.appendChild(icon66)
	            row2.appendChild(col66)
	            
	            const col77 = document.createElement("div")
	            col77.classList.add("col")
	            row2.appendChild(col77)
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
	            col10.innerText = map.userDto.user_name
	            row4.appendChild(col10)
	            col3.appendChild(row4)
	            row1.appendChild(col3)

	            document.getElementById("getMyProfileInfo").appendChild(row1)
			}
		}
		xhr.open("get", "./getMyPageInfo")
		xhr.send()
	}
			
	function reloadBoard() {
		const boardText = document.getElementById("boardText");
	    boardText.style.fontWeight = "bold";
	    boardText.style.borderTop = "2px solid black"; // 원하는 색상으로 변경 가능
	    boardText.style.marginTop = "-10px";
	    boardText.style.paddingTop = "8px"
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				const boardBox = document.getElementById("getBoardList")
				boardBox.innerHTML = ""
					const listBox = document.getElementById("getBoardList")
					listBox.innerHTML = ""
					const boardText1 = document.getElementById("boardText1");
				    boardText1.style.fontWeight = "normal";
				    boardText1.style.borderTop = "none";
				    boardText1.style.marginTop = "0";
				    boardText1.style.paddingTop = "0";
				    const boardText2 = document.getElementById("boardText2")
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
		xhr.open("get", "./getBoardList")
		xhr.send()
	}
	function reloadSave() {
		const boardText1 = document.getElementById("boardText1");
	    boardText1.style.fontWeight = "bold";
	    boardText1.style.borderTop = "2px solid black"; // 원하는 색상으로 변경 가능
	    boardText1.style.marginTop = "-10px";
	    boardText1.style.paddingTop = "8px"
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				const listBox = document.getElementById("getBoardList")
				listBox.innerHTML = ""
				const boardText = document.getElementById("boardText");
			    boardText.style.fontWeight = "normal";
			    boardText.style.borderTop = "none";
			    boardText.style.marginTop = "0";
			    boardText.style.paddingTop = "0";
			    const boardText2 = document.getElementById("boardText2");
			    boardText2.style.fontWeight = "normal";
			    boardText2.style.borderTop = "none";
			    boardText2.style.marginTop = "0";
			    boardText2.style.paddingTop = "0";
				
			    const row = document.createElement("div")
			    row.classList.add("row", "mt-2")
			    
			    const coll = document.createElement("div")
			    coll.classList.add("col")
			    
			    const roww = document.createElement("div")
			    roww.classList.add("row")
			   
			    const col = document.createElement("div")
			    col.classList.add("col", "small", "text-start", "opacity-50", "text-sm")
			    col.innerText = "저장한 내용은 회원님만 볼 수 있습니다."
			    roww.appendChild(col)
			    const col1 = document.createElement("div")
			    col1.classList.add("col", "text-end", "text-primary", "small")
			    col1.innerText = "+ 새 컬렉션"
			    col1.style.cursor = "pointer"
			    col1.setAttribute("onclick", "saveCategoryPlus()")
			    roww.appendChild(col1)
			    coll.appendChild(roww)
			    //if 조건문으로 저장소 카테고리가 여러개면 퍼이치로 반복문
			    const row1 = document.createElement("div");
				row.classList.add("row", "mt-3");
				
				// 정사각형을 만들어서 square 클래스를 추가합니다.
				const square = document.createElement("div");
				square.classList.add("col", "mt-3", "square", "opacity-25");
				row1.appendChild(square);
				coll.appendChild(row1)
				row.appendChild(coll)
			    document.getElementById("getBoardList").appendChild(row)
			}
		}
		xhr.open("get", "./saveFiles")
		xhr.send()
	}
	function saveCategoryPlus() {
		/* <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
	    Link with href
	  </a> */
		const bsCollapse = new bootstrap.Collapse("#collapseExample");
	    bsCollapse.toggle();
	}
	function reloadTags() {
		const listBox = document.getElementById("getBoardList")
		listBox.innerHTML = ""
		const boardText = document.getElementById("boardText");
	    boardText.style.fontWeight = "normal";
	    boardText.style.borderTop = "none";
	    boardText.style.marginTop = "0";
	    boardText.style.paddingTop = "0";
	    const boardText1 = document.getElementById("boardText1");
	    boardText1.style.fontWeight = "normal";
	    boardText1.style.borderTop = "none";
	    boardText1.style.marginTop = "0";
	    boardText1.style.paddingTop = "0";
	    const boardText2 = document.getElementById("boardText2");
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
	    img.src = "../resources/img/tagss.png"
	    img.style.width = "360px"
	    img.style.height = "180px"
	    col.appendChild(img)
	    row.appendChild(col)
	    document.getElementById("getBoardList").appendChild(row)
	}
	window.addEventListener("DOMContentLoaded", function() {
		getSessionId()
		getMyProfileInfo()
		reloadBoard()
	})
</script>
<title>mainPage</title>
    <style>
    	.board-photo {
    		width: 285px;
    		height: 270px;
    		padding: 2px;
    	}
    	.square {
        width: 270px; /* 정사각형의 너비 */
        height: 270px; /* 정사각형의 높이 */
        border: 1px solid black; /* 보더 스타일과 색상 */
        background: linear-gradient(white, black); /* 흰색에서 검정으로 그라데이션 */
        
    }
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
						 <div class="row mt-5" id="getMyProfileInfo">
							<%-- <div class="col-1"></div>
							<div class="col-3 mb-5">
								<c:if test="${map.userDto.profile_img == null}">
									<img class="img-fluid img-size" style="width: 140px; height: 140px;" src="/roaming/resources/img/oirgin.png">
								</c:if>
								<c:if test="${map.userDto.profile_img != null}">
									<img class="img-fluid img-size" style="width: 130px; height: 130px;" src="/uploadFiles/${map.userDto.profile_img}">
								</c:if>
							</div>
							<div class="col">
								<div class="row">
									<div class="col-2 fw-bold fs-5">${map.userDto.user_id}</div>
									<div class="col-3"><a href="./myPageChange" class="btn btn-dark btn-sm">프로필 편집</a></div>
									<div class="col"></div>
								</div>
								<div class="row mt-3">
									<div class="col-3">게시물&nbsp;&nbsp;&nbsp;${count}</div>
									<div class="col-3">팔로워</div>
									<div class="col-3">팔로우</div>
									<div class="col-3"></div>
								</div>
								<div class="row mt-3 fw-bold small">
									<div class="col">${map.userDto.user_name}</div>
								</div>
							</div> --%>
						</div>
						<div class="row mt-2">
							<div class="col"></div>
							<div class="col-1 small text-center opacity-75" onclick="reloadBoard()" id="boardText"><i class="bi bi-grid-3x3"></i> 게시물</div>
							<div class="col-1"></div>
							<div class="col-1 small text-center opacity-75" onclick="reloadSave()" id="boardText1"><i class="bi bi-bookmark"></i> 저장됨</div>
							<div class="col-1"></div>
							<div class="col-1 small text-center" onclick="reloadTags()" id="boardText2"><i class="bi bi-camera"></i> 태그됨</div>
							<div class="col"></div>
						</div>
						<div class="row">
							<div class="col-1"></div>
							<div class="col">
								<div class="row" id="getBoardList"></div>
							</div>
							<div class="col-1"></div>
						</div>
						<div class="row mt-5">
							<div class="col"></div>
							<div class="col">
								<div class="collapse" id="collapseExample">
								<div class="row my-2">
									<div class="col text-end fs-6 fw-bold">새 컬렉션</div>
									<div class="col-5 text-end">
										<button type="button" class="btn-close" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-label="Close"></button>
									</div>
								</div>
								  <div class="card card-body border-0 border-top border-bottom">
								    <input type="text" placeholder="컬렉션 이름">
								  </div>
								  <div class="row my-1">
								  	<div class="col text-center fs-6 fw-semibold small opacity-75 text-primary" style="cursor: pointer;">다음</div>
								  </div>
								</div>
							</div>
							<div class="col"></div>
						</div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5"></div>
						<div class="row mt-5">
							<div class="col"></div>
							<div class="col-10"><img class="img-fluid" src="/roaming/resources/img/footer.png"></div>
							<div class="col"></div>
						</div>
					</div>
					<div class="col"></div>
				</div>
			</div>
		</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
