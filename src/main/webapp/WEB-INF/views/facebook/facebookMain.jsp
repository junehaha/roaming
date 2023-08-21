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
				} else {
					location.href = "../user/loginPage"
				}
			}
		}
		xhr.open("get", "../user/getMyId", false)
		xhr.send()
	}
	/* function dropdownFollow(userId) {
		const div = document.createElement("div")
		div.classList.add("dropdown")
		
		const ul = document.createElement("ul")
		ul.classList.add("dropdown-menu")
		const li = document.createElement("li")
		const link = document.createElement("a")
		link.classList.add("dropdown-item")
		link.href = "./feedDetailPage?id=" + userId
		li.appendChild(link)
		const li1 = document.createElement("li")
		const link1 = document.createElement("a")
		link1.classList.add("dropdown-item")
		link1.href = "./reelsMainPage"
		li1.appendChild(link1)
		const li2 = document.createElement("li")
		const link2 = document.createElement("a")
		link2.classList.add("dropdown-item")
		link2.href = "./message"
		li2.appendChild(link2)
		const li3 = document.createElement("li")
		const link3 = document.createElement("a")
		link3.classList.add("dropdown-item")
		link3.href = "#"
		li3.appendChild(link3)
		const li4 = document.createElement("li")
		const link4 = document.createElement("a")
		link4.classList.add("dropdown-item")
		link4.href = "#"
		div.appendChild(ul)
	} */
	function reloadFollowList() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const followHomeList = document.getElementById("followHomeList")
				followHomeList.innerHTML = ""
					
				response.list.forEach(function(map) {
					const row = document.createElement("div")
					row.classList.add("row", "mt-2")
					row.style.cursor = "pointer"
					
					const col = document.createElement("div")
					col.classList.add("col-2")
					if(mySessionId == null) {
						followHomeList.innerHTML = ""
					} else {
						const link1 = document.createElement("a")
						link1.href = "./myPageUser?userId=" + map.userDto.id
						const img = document.createElement("img")
						img.src = "/uploadFiles/" + map.userDto.profile_img
						img.setAttribute("onmouseenter", "profileModal()")
						img.style.width = "30px"
						img.style.height = "30px"
						img.style.borderRadius = "50%"
						link1.appendChild(img)
						col.appendChild(link1)
					}
					row.appendChild(col)
					if(mySessionId == null) {
						followHomeList.innerHTML = ""
					} else {
						const col1 = document.createElement("div")
						col1.classList.add("col")
						const link11 = document.createElement("a")
						link11.href = "./myPageUser?userId=" + map.userDto.id
						link11.innerText = map.userDto.user_name
						link11.style.textDecoration = "none"
						link11.style.color = "black"
						col1.appendChild(link11)
						row.appendChild(col1)
					}
					document.getElementById("followHomeList").appendChild(row)
				})
			}
		}
		xhr.open("get", "./facebookMainUserList")
		xhr.send()
	}
	function refreshRandom() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				const randomHomeList = document.getElementById("randomHomeList")
				randomHomeList.innerHTML = ""
				reloadRandomList()
			}
		}
		xhr.open("get", "./randomUsers")
		xhr.send()
	}
	function reloadRandomList() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				const randomHomeList = document.getElementById("randomHomeList")
				randomHomeList.innerHTML = ""
				
				response.list.forEach(function(map) {
					
					const row = document.createElement("div")
					row.classList.add("row", "mt-2")
					
					const col = document.createElement("div")
					col.classList.add("col-2")
					if(mySessionId == null) {
						randomHomeList.innerHTML = ""
					} else {
						const link11 = document.createElement("a")
						link11.href = "./myPageUser?userId=" + map.userDto.id
						const img = document.createElement("img")
						if(map.userDto.profile_img.startsWith('20')) {
							img.src = "/uploadFiles/" + map.userDto.profile_img	
						}else {
							img.src = map.userDto.profile_img
						}
						
						img.style.width = "35px"
						img.style.height = "35px"
						img.style.borderRadius = "50%"
						link11.appendChild(img)
						col.appendChild(link11)
					}
					row.appendChild(col)
					if(mySessionId == null) {
						randomHomeList.innerHTML = ""
					} else {
						const col1 = document.createElement("div")
						col1.classList.add("col")
						col1.innerText = map.userDto.user_name
						row.appendChild(col1)
						const col2 = document.createElement("div")
						col2.classList.add("col", "text-end", "text-primary", "small")
						col2.innerText = "팔로우"
						col2.style.cursor = "pointer"
						col2.setAttribute("onclick", "followInsert(" + map.userDto.id + ")")
						row.appendChild(col2)
					}
					
					document.getElementById("randomHomeList").appendChild(row)
				})
			}
		}
		xhr.open("get", "./randomUsers")
		xhr.send()
	}
	const param = '${sessionUser.id}'
	function followInsert(userId) {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				reloadRandomList()
			}
		}
		xhr.open("post", "./followProcess")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("send_id=" + param + "&receive_id=" +userId)
	}
	function deleteFollow(userId) {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				reloadRandomList()
			}
		}
		xhr.open("post", "./deleteFollowUser")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("send_id=" + param + "&receive_id=" + userId)
	}
	function storyList() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const storyMainInfo = document.getElementById("storyMainInfo")
				storyMainInfo.innerHTML = ""
				
				const row = document.createElement("div")
				row.classList.add("row", "scrollrow", "mt-1", "my-3")
				row.style.cursor = "pointer"
				
				response.list.forEach(function(map) {
					const col = document.createElement("div")
					col.classList.add("col", "p-0", "text-center")
					
					const img = document.createElement("img")
					img.classList.add("img-fluid", "story-img")
					img.src = "/uploadFiles/" + map.userDto.profile_img
					img.setAttribute("onclick", "storyModal(" + map.userDto.id + ")")
					img.style.width = "70px"
					img.style.height = "70px"
					
					img.style.borderRadius = "50%"
					
					col.appendChild(img)
					row.appendChild(col)
				})
				document.getElementById("storyMainInfo").appendChild(row)
			}
		}
		xhr.open("get", "./storyMain")
		xhr.send()
	}
	let modal;

/* 	function profileModal() {
	    modal = new bootstrap.Modal(document.getElementById("followModal"));
	    modal.show()
	} */

	function storyModal(userId) {
		const modal = bootstrap.Modal.getOrCreateInstance("#storyModal")
		modal.show()
		
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const map = response.map.unionDto
				
				const storyModalFor = document.getElementById("storyModalFor")
				storyModalFor.innerHTML = ""
				const div1 = document.createElement("div")
				div1.classList.add("modal-content")
				
				const div2 = document.createElement("div")
				div2.classList.add("modal-header", "p-3")
				
				const h2 = document.createElement("h2")
				h2.classList.add("modal-title", "fs-4")
				h2.setAttribute("id", "staticBackdropLabel")
				div2.appendChild(h2)
				const button = document.createElement("button")
				button.setAttribute("type", "button")
				button.classList.add("btn-close")
				button.setAttribute("data-bs-dismiss", "modal")
				button.setAttribute("aria-label", "Close")
				div2.appendChild(button)
				div1.appendChild(div2)
				
				const div3 = document.createElement("div")
				div3.classList.add("modal-body", "p-0", "m-0")
				const row4 = document.createElement("div")
				row4.classList.add("row", "justify-content-center")
				row4.setAttribute("id", "modalBodyList")
				const col4 = document.createElement("div")
				col4.classList.add("col")
				if(map.type == 'feed') {
						const img11 = document.createElement("img")
						img11.src = "/uploadFiles/" + map.image
						
						img11.classList.add("img-fluid")
						col4.appendChild(img11)
					} else {
						const video = document.createElement("video")
						video.classList.add("img-fluid")
						video.src = "/uploadFiles/" + map.video
						
						video.controls = true
						col4.appendChild(video)
					}
				row4.appendChild(col4)
				div3.appendChild(row4)
				div1.appendChild(div3)
				document.getElementById("storyModalFor").appendChild(div1)
			}
		}
		xhr.open("get", "./storyModal?id=" + userId)
		xhr.send()
	}
	function adjustVideoSize(video) {
	    const colHeight = 600;
	    const ratio = colHeight / video.videoHeight;
	    video.width = video.videoWidth * ratio;
	    video.height = colHeight;
	  }
	function infomationModal(id) {
		const modal = bootstrap.Modal.getOrCreateInstance("#informationModal")
		modal.show();
	}
	function informationModal2(id) {
		const modal = bootstrap.Modal.getOrCreateInstance("#informationModal2")
		modal.show();
	}
	function unionLists() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				

				const unionList = document.getElementById("unionLists")
				unionList.innerHTML = "" 
				
				const roww = document.createElement("div")
				roww.classList.add("row", "border-top", "border-bottom", "py-5")
				const coll = document.createElement("div")
				coll.classList.add("col", "text-center")
				const imgg = document.createElement("img")
				imgg.classList.add("img-fluid")
				imgg.style.width = "300px"
				imgg.style.height = "150px"
				imgg.src = "/roaming/resources/img/checkstory.png"
				coll.appendChild(imgg)
				roww.appendChild(coll)
				document.getElementById("checkStory").appendChild(roww)
				
				response.list.forEach(function(map) {
					reelsId = map.unionDto.reels_id
					feedId = map.unionDto.feed_id
					
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
					col2.classList.add("col-4", "text-start", "pt-2", "ps-0")
					const link1 = document.createElement("a")
					link1.style.position = "relative"
					link1.style.left = "-30px"
					link1.classList.add("text-start", "fs-6")
					link1.style.textDecoration = "none"
					link1.style.color = "black"
					link1.href = "./myPageUser?userId=" + map.userDto.id
					link1.innerText = map.userDto.user_id
					
					
					const span = document.createElement("span")
					span.classList.add("opacity-50", "small","text-start")
					span.style.fontSize = "14px"
					span.innerText = "  •  " + map.unionDto.reg_date
					link1.appendChild(span)
					
					const col3 = document.createElement("span")
					col3.classList.add("small", "text-start", "text-primary", "pt-1")
					col3.innerText = " • 팔로우"
					col3.style.cursor = "pointer"
					link1.appendChild(col3)
					col2.appendChild(link1)
					row1.appendChild(col2)
					
					
					
					const col333 = document.createElement("div")
					col333.classList.add("col", "text-end", "pt-3")
					const icon333 = document.createElement("i")
					icon333.classList.add("bi", "bi-three-dots")
					icon333.style.cursor = "pointer"
					
					if(map.unionDto.type == 'feed') {
						icon333.setAttribute("onclick", "infomationModal("+feedId+")")
					} else {
						icon333.setAttribute("onclick", "infomationModal("+reelsId+")")
					}
					
					col333.appendChild(icon333)
					row1.appendChild(col333)
					col.appendChild(row1)
					
					const row2 = document.createElement("div")
					row2.classList.add("row")
					
					
					
					if(map.unionDto.type == 'feed') {
						const col4 = document.createElement("div")
						col4.classList.add("col","mt-2","union-img")
						const img11 = document.createElement("img")
						img11.src = "/uploadFiles/" + map.unionDto.image
						
						img11.classList.add("img-fluid")
						col4.appendChild(img11)
						row2.appendChild(col4)
					} else {
						const col4 = document.createElement("div")
						col4.classList.add("col","mt-2","union-video")
						const video = document.createElement("video")
						video.classList.add("img-fluid")
						video.src = "/uploadFiles/" + map.unionDto.video
						
						video.controls = true
						col4.appendChild(video)
						row2.appendChild(col4)
						video.addEventListener("loadedmetadata", function () {
					      adjustVideoSize(video);
					    });
						video.addEventListener("click", function(event) {
						if (video.paused) {
					        video.play()
					    } else {
					        video.pause()
					    }
					})
					}
					
				   
				    col.appendChild(row2)
				    
				    const row3 = document.createElement("div")
				    row3.classList.add("row", "mt-2")
				    
				    const col5 = document.createElement("div")
				    col5.classList.add("col")
				    const span1 = document.createElement("span")
				    span1.style.cursor = "pointer"
				    const icon1 = document.createElement("i")
				    icon1.classList.add("bi", "bi-heart", "fs-4", "p-0")
				    if(map.unionDto.type == 'feed') {
				    	icon1.id = "heartFeed" + feedId
				    	icon1.setAttribute("onclick", "toggleFeedLike("+feedId+")")
				    	span1.appendChild(icon1)
				    } else {
					    icon1.id = "heartReels" + reelsId
					    icon1.setAttribute("onclick", "toggleReelsLike("+reelsId+")")
					    span1.appendChild(icon1)				    	
				    }
				    col5.appendChild(span1)
				    const span2 = document.createElement("span")
				    span2.style.position = "relative"
				    span2.style.right = "-20px"
				    span2.style.top = "-2px"
			    	if(map.unionDto.type == 'feed') {
			    		span2.setAttribute("onclick", "feedCommentModal("+feedId+")")
					    span2.style.cursor = "pointer"
				    } else {
				    	span2.setAttribute("onclick", "reelsCommentModal("+reelsId+")")
					    span2.style.cursor = "pointer"				    	
				    }
				    
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
				    span4.style.right = "-390px"
				    span4.style.top = "-1px"
				    span4.style.cursor = "pointer"
				    const icon4 = document.createElement("i")
				    icon4.classList.add("bi", "bi-bookmark", "fs-4")
				    
				    
				    if(map.unionDto.type == 'feed') {
				    	icon4.id = "bookmark" + feedId
				    	icon4.setAttribute("onclick", "bookmarkChange("+feedId+")")
				    } else {
				    	icon4.id = "bookmark" + reelsId
				    	icon4.setAttribute("onclick", "bookmarkChange("+reelsId+")")    	
				    }
				    span4.appendChild(icon4)
				    col5.appendChild(span4)
				    
				    row3.appendChild(col5)
				    col.appendChild(row3)
				    
				    const row4 = document.createElement("div")
				    row4.classList.add("row")
				    //여기서 부터 다시 확인
				    const coll1 = document.createElement("div")
				    coll1.classList.add("col", "small")
				    if(map.unionDto.type == 'feed') {
				    	coll1.id = "totalFeedCount" + feedId
					    coll1.innerText = "좋아요 " + map.feedCount + "개"
					    row4.appendChild(coll1)
				    } else {
				    	coll1.id = "totalReelsCount" + reelsId
					    coll1.innerText = "좋아요 " + map.reelsCount + "개"
					    row4.appendChild(coll1)				    	
				    }
				    
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
				    const fullText = map.unionDto.content;				    	
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
					if(map.unionDto.type == 'feed') {
						col777.innerText = "댓글  " + map.feedCommentCount + "개 모두 보기"
						col777.setAttribute("onclick", "feedCommentModal("+feedId+")")
						col777.style.cursor = "pointer"
						row777.appendChild(col777)
				    } else {
				    	col777.innerText = "댓글  " + map.reelsCommentCount + "개 모두 보기"
						col777.setAttribute("onclick", "reelsCommentModal("+reelsId+")")
						col777.style.cursor = "pointer"
						row777.appendChild(col777)				    	
				    }
					
					const col7777 = document.createElement("div")
					col7777.classList.add("col")
					row777.appendChild(col7777)
					col.appendChild(row777)

					/* map.reelsCommentDto.forEach(function(data) {
						
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
						if(map.unionDto.type == 'feed') {
							span666.innerText = data.feed_comment
					    } else {
					    	span666.innerText = data.reels_comment				    	
					    }
						
						span666.style.position = "relative"
						span666.style.left = "15px"
						col555.appendChild(span666)
						row555.appendChild(col555)
						col.appendChild(row555)
						
					}) */
					
				    const row5 = document.createElement("div")
				    row5.classList.add("row")
				    row5.style.borderBottom = "1px solid rgba(128, 128, 128, 0.3)"
				    const coll2 = document.createElement("div")
				    coll2.classList.add("col")
				    
				    
				    const textBox = document.createElement("textarea")
				    textBox.classList.add("form-control-plain", "my-1", "small", "custom-textarea")
				    if(map.unionDto.type == 'feed') {
				    	textBox.id = "feedTextBox" + feedId
						textBox.placeholder = "댓글 달기..."
				    } else {
				    	textBox.id = "reelsTextBox" + reelsId
						textBox.placeholder = "댓글 달기..."				    	
				    }
				    
					coll2.appendChild(textBox)
				    row5.appendChild(coll2)
				    const coll22 = document.createElement("div")
				    coll22.classList.add("col-2", "small", "opacity-50", "text-end")
				    coll22.innerText = "게시"
				    coll22.style.cursor = "pointer"
				    coll22.style.color = "blue"
			    	if(map.unionDto.type == 'feed') {
			    		coll22.setAttribute("onclick", "registerFeedComment("+feedId+")")
					    row5.appendChild(coll22)
				    } else {
				    	coll22.setAttribute("onclick", "registerReelsComment("+reelsId+")")
					    row5.appendChild(coll22)				    	
				    }
				    
				    col.appendChild(row5)
				    row.appendChild(col)
				    /* unionList.appendChild(row) */
				   if(map.unionDto.type == 'feed') {
				    	unionList.appendChild(row)
					    refreshFeedHeart(feedId)
					    refreshTotalFeedCount(feedId)
				    } else {
				    	unionList.appendChild(row)
					    refreshReelsHeart(reelsId)
					    refreshTotalReelsCount(reelsId)
				    }
				    
				})
			}
		}
		xhr.open("get", "./mainUnionList")
		xhr.send()
	}
	function bookmarkChange(feedId) {
		  const book = document.getElementById("bookmark" + feedId)
		  
		  if (book.classList.contains("bi-bookmark")) {
		    book.classList.remove("bi-bookmark")
		    book.classList.add("bi-bookmark-fill")
		  } else if (book.classList.contains("bi-bookmark-fill")) {
		    book.classList.remove("bi-bookmark-fill")
		    book.classList.add("bi-bookmark")
		  }
		}
	function reelsCommentModal(reelsId) {
		const modal = bootstrap.Modal.getOrCreateInstance("#reelsCommentModal")
		modal.show();
		/* 
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
		xhr.send("reels_id=" + reelsId) */
	}
	
	function feedCommentModal(feedId) {
		const modal = bootstrap.Modal.getOrCreateInstance("#feedCommentModal")
		modal.show();
		 
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				
				const feedCommentPhoto = document.getElementById("feedCommentPhoto")
				feedCommentPhoto.innerHTML = ""
				
				const img = document.createElement("img")
				img.classList.add("img-fluid")
				img.style.width = "auto"
				img.style.height = "1000px"
				img.src = "/uploadFiles/" + response.map.feedPhoto.feed_image
				
				document.getElementById("feedCommentPhoto").appendChild(img)
					
				const feedModalUser = document.getElementById("feedModalUser")
				feedModalUser.innerHTML = ""
				
				const img1 = document.createElement("img")
				img1.classList.add("img-fluid")
				img1.style.width = "40px"
				img1.style.height = "40px"
				img1.style.borderRadius = "50%"
				img1.src = "/uploadFiles/" + response.map.userDto.profile_img
				
				document.getElementById("feedModalUser").appendChild(img1)
				
				const feedModalUserName = document.getElementById("feedModalUserName")
				feedModalUserName.innerHTML = ""
				
				const col1 = document.createElement("div")
				col1.classList.add("col", "text-start", "pt-2")
				col1.innerText = response.map.userDto.user_name
				
				document.getElementById("feedModalUserName").appendChild(col1)
				
				const feedModalUserDot = document.getElementById("feedModalUserDot")
				feedModalUserDot.innerHTML = ""
				
				const col2 = document.createElement("div")
				col2.classList.add("col", "pt-2", "text-end")
				col2.style.cursor = "pointer"
				const icon2 = document.createElement("i")
				icon2.classList.add("bi", "bi-three-dots")
				icon2.setAttribute("onclick", "informationModal2("+response.map.feedPhoto.feed_id+")")
				col2.appendChild(icon2)
				document.getElementById("feedModalUserDot").appendChild(col2)
				
				
				const modalBodyList = document.getElementById("modalBodyListC")
				modalBodyList.innerHTML = ""
				
				response.list.forEach(function(map) {
					const roww = document.createElement("div")
					roww.classList.add("row")
					const coll = document.createElement("div")
					coll.classList.add("col-2", "text-center")
					const linkk = document.createElement("a")
					linkk.href = "./myPageUser?userId=" + map.userDto.id
					const imgg = document.createElement("img")
					imgg.classList.add("img-fluid")
					imgg.style.width = "35px"
					imgg.style.height = "35px"
					imgg.style.borderRadius = "50%"
					imgg.src = "/uploadFiles/" + map.userDto.profile_img
					linkk.appendChild(imgg)
					coll.appendChild(linkk)
					roww.appendChild(coll)
					
					const colll = document.createElement("div")
					colll.classList.add("col")
					
					const roww1 = document.createElement("div")
					roww1.classList.add("row")
					const coll1 = document.createElement("div")
					coll1.classList.add("col")
					coll1.innerText = map.feedCommentDto.feed_comment
					roww1.appendChild(coll1)
					colll.appendChild(roww1)
					
					const roww2 = document.createElement("div")
					roww2.classList.add("row")
					coll3 = document.createElement("div")
					coll3.classList.add("col", "opacity-50")
					coll3.style.fontSize = "12px"
					coll3.innerText = "좋아요 0개   댓글달기"
					roww2.appendChild(coll3)
					colll.appendChild(roww2)
					roww.appendChild(colll)
					
					const coll2 = document.createElement("div")
					coll2.classList.add("col-1", "fs-6", "small")
					const iconn = document.createElement("i")
					iconn.classList.add("bi", "bi-heart")
					coll2.appendChild(iconn)
					roww.appendChild(coll2)
					
					document.getElementById("modalBodyListC").appendChild(roww)
					/* const row = document.createElement("div")
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
					col3.innerText = map.feedCommentDto.feed_comment
					row2.appendChild(col3)
					col1.appendChild(row2)
					const row3 = document.createElement("div")
					row3.classList.add("row")
					const col4 = document.createElement("div")
					col4.classList.add("col", "small")
					
					row3.appendChild(col4)
					col1.appendChild(row3)
					row.appendChild(col1)
					
					const col5 = document.createElement("div")
					col5.classList.add("col-1")
					row.appendChild(col5)
					
					document.getElementById("modalBodyList").appendChild(row) */
				})
				const feedCommentModalLieks = document.getElementById("feedCommentModalLieks")
				feedCommentModalLieks.innerHTML = ""
				
				const rowww = document.createElement("div")
				rowww.classList.add("row")
				const colw = document.createElement("div")
				colw.classList.add("col")
				
				const rowww1 = document.createElement("div")
				rowww1.classList.add("row")
				const colw1 = document.createElement("div")
				colw1.classList.add("col-1")
				const iconn1 = document.createElement("i")
				iconn1.classList.add("bi", "bi-heart")
				iconn1.style.cursor = "pointer"
				
				colw1.appendChild(iconn1)
				rowww1.appendChild(colw1)
				
				const colw2 = document.createElement("div")
				colw2.classList.add("col-1")
				const iconn2 = document.createElement("i")
				iconn2.classList.add("bi", "bi-chat")
				iconn2.style.cursor = "pointer"
					colw2.appendChild(iconn2)
					rowww1.appendChild(colw2)
				const colw3 = document.createElement("div")
				colw3.classList.add("col-1")
				const iconn3 = document.createElement("i")
				iconn3.classList.add("bi", "bi-send")
				iconn3.style.cursor = "pointer"
					colw3.appendChild(iconn3)
					rowww1.appendChild(colw3)
				const colw4 = document.createElement("div")
				colw4.classList.add("col")
				rowww1.appendChild(colw4)
				const colw5 = document.createElement("div")
				colw5.classList.add("col-1")
				const iconn4 = document.createElement("i")
				iconn4.classList.add("bi", "bi-bookmark")
				iconn4.style.cursor = "pointer"
					colw5.appendChild(iconn4)
					rowww1.appendChild(colw5)
				
					colw.appendChild(rowww1)
				const rowww2 = document.createElement("div")
				rowww1.classList.add("row")
				
				const colww2 = document.createElement("div")
				colww2.classList.add("col", "fw-semibold", "small")
				colww2.innerText = "좋아요 " + response.map.feedCount + "개"
				rowww2.appendChild(colww2)
				colw.appendChild(rowww2)
				rowww.appendChild(colw)
				document.getElementById("feedCommentModalLieks").appendChild(rowww)
				
				const modalFooterComment = document.getElementById("modalFooterComment")
				modalFooterComment.innerHTML = ""
				
				const rowl = document.createElement("div")
				rowl.classList.add("row")
				
				const colr = document.createElement("div")
				colr.classList.add("col-2", "pt-2", "ps-4")
				const imgr = document.createElement("img")
				imgr.classList.add("img-fluid")
				imgr.style.width = "30px"
				imgr.style.height = "30px"
				imgr.src = "/roaming/resources/img/smile1.png"
				colr.appendChild(imgr)
				rowl.appendChild(colr)
				
				const colr1 = document.createElement("div")
				colr1.classList.add("col", "ps-0", "pt-1")
				
				const textarea = document.createElement("textarea")
				textarea.classList.add("form-control", "custom-textarea")
				textarea.placeholder = "댓글 입력"
				textarea.id = "feedCommentModalText"
				colr1.appendChild(textarea)
				rowl.appendChild(colr1)
				
				document.getElementById("modalFooterComment").appendChild(rowl)
				
				const textarea1 = document.getElementById("feedCommentModalText");
			    textarea1.addEventListener("keyup", function(event) {
			        if (event.key === "Enter" && !event.shiftKey) {
			            keyUpEvent(event);
			        }
			    });
			    function keyUpEvent(event) {
			    	registerFeedModalComment(feedId)
			    }
			}
		}
		xhr.open("post", "./feedCommentModal")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("feed_id=" + feedId)
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
	function registerFeedModalComment(feedId) {
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
		xhr.open("post", "./registerFeedModalComment")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("feed_id=" + reelsId + "&feed_comment=" + encodeURIComponent(reelsModalValue))	
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
	function registerFeedComment(feedId) {
		if(!mySessionId) {
			return
		}
		const feedTextBox = document.getElementById("feedTextBox" + feedId)
		const feedTextValue = feedTextBox.value
		const feedTextValueBr = feedTextValue.replace(/\n/g, "<br>")
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				feedTextBox.value = ""
				reloadFeedList()
				
			}
		}
		xhr.open("post", "./registerFeedComment")
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send("feed_id=" + feedId + "&reels_comment=" + encodeURIComponent(feedTextValue))
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
	function toggleFeedLike(feedId) {
		if(mySessionId == null) {
			location.href = "../user/loginPage"
			return
		}
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				refreshTotalFeedCount(feedId)
				refreshFeedHeart(feedId)
			}
		}
		xhr.open("get", "./toggleFeedLike?feed_id=" + feedId)
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
					heartReels.classList.add("bi", "bi-heart-fill", "fs-4", "p-0", "text-danger")
				} else {
					heartReels.classList.remove("bi", "bi-heart-fill", "fs-4", "p-0", "text-danger")
					heartReels.classList.add("bi", "bi-heart", "fs-4", "p-0")
				}
			}
		}
		
		xhr.open("get", "./isReelsLike?reels_id=" + reelsId)
		xhr.send()
	}
	function refreshFeedHeart(feedId) {
		
		if(mySessionId == null) return
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const heartFeed = document.getElementById("heartFeed" + feedId)
				
				
				if(response.isFeedLike) {
					heartFeed.classList.remove("bi", "bi-heart", "fs-4", "p-0")
					heartFeed.classList.add("bi", "bi-heart-fill", "fs-4", "p-0", "text-danger")
				} else {
					heartFeed.classList.remove("bi", "bi-heart-fill", "fs-4", "p-0", "text-danger")
					heartFeed.classList.add("bi", "bi-heart", "fs-4", "p-0")
				}
			}
		}
		
		xhr.open("get", "./isFeedLike?feed_id=" + feedId)
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
	function refreshTotalFeedCount(feedId) {
		
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const totalFeedCountBox = document.getElementById("totalFeedCount" + feedId)
				totalFeedCountBox.innerHTML = ""
				totalFeedCountBox.innerText = "좋아요 " + response.feedCount + "개"
			}
		}
		xhr.open("get", "./getTotalFeedCount?feed_id=" + feedId)
		xhr.send()
	}
	/* function unionList() {
		const xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText)
				const unionList = document.getElementById("unionList")
				unionList.innerHTML = ""
				
				response.list.forEach(function(map) {
					const row = document.createElement("div")
					row.classList.add("row", "my-5")
					
					const card = document.createElement("div")
					card.classList.add("card", "col", "m-0", "p-0")
					
					if(map.unionDto.type == 'feed') {
						const img11 = document.createElement("img")
						img11.src = "/uploadFiles/" + map.unionDto.image
						img11.style.borderRadius = "5px"
						img11.classList.add("img-fluid")
						card.appendChild(img11)
					} else {
						const video = document.createElement("video")
						video.classList.add("img-fluid")
						video.src = "/uploadFiles/" + map.unionDto.video
						video.style.borderRadius = "5px"
						video.controls = true
						card.appendChild(video)
					}
					
					const link = document.createElement("a")
					link.href = "./myPageUser?userId=" + map.userDto.id
					const img1 = document.createElement("img")
					img1.classList.add("profile-img")
					img1.src = "/uploadFiles/" + map.userDto.profile_img
					link.appendChild(img1)
					const div1 = document.createElement("div")
					div1.classList.add("fs-6", "profile-text")
					div1.innerText = map.userDto.user_name
					link.appendChild(div1)
					const div2 = document.createElement("div")
					div2.classList.add("fs-6", "profile-time")
					div2.innerText = map.unionDto.reg_date
					link.appendChild(div2)
					card.appendChild(link)
					
					const card1 = document.createElement("div")
					card1.classList.add("p-0")
					
					const row2 = document.createElement("div")
					row2.classList.add("row")
					
					const col2 = document.createElement("div")
					col2.classList.add("col-3", "mt-2", "text-center", "opacity-75")
					col2.innerText = "좋아요 " + 0 + "개"
					row2.appendChild(col2)
					const col3 = document.createElement("div")
					col3.classList.add("col", "mt-2")
					row2.appendChild(col3)
					const col4 = document.createElement("div")
					col4.classList.add("col-2", "mt-2", "text-end", "opacity-75")
					col4.innerText = "댓글 " + 0 + "개"
					row2.appendChild(col4)
					const col5 = document.createElement("div")
					col5.classList.add("col-2", "mt-2", "text-start", "opacity-75")
					col5.innerText = "공유 " + 0 + "개"
					row2.appendChild(col5)
					card1.appendChild(row2)
					
					const row3 = document.createElement("div")
					row3.classList.add("row", "m-0", "p-0")
					
					const col6 = document.createElement("div")
					col6.classList.add("col", "my-2", "text-center", "opacity-75")
					col6.innerText = "좋아요"
					const icon = document.createElement("i")
					icon.classList.add("bi", "bi-hand-thumbs-up")
					col6.appendChild(icon)
					row3.appendChild(col6)
					const col7 = document.createElement("div")
					col7.classList.add("col", "my-2", "text-center", "opacity-75")
					col7.innerText = "댓글"
					const icon1 = document.createElement("i")
					icon1.classList.add("bi", "bi-chat-left")
					col7.appendChild(icon1)
					row3.appendChild(col7)
					const col8 = document.createElement("div")
					col8.classList.add("col", "my-2", "text-center", "opacity-75")
					col8.innerText = "공유"
					const icon2 = document.createElement("i")
					icon2.classList.add("bi", "bi-reply")
					col8.appendChild(icon2)
					row3.appendChild(col8)
					
					card1.appendChild(row3)
					card.appendChild(card1)
					row.appendChild(card)
					
					document.getElementById("unionList").appendChild(row)
				})
			}
		}
		xhr.open("get", "./mainUnionList")
		xhr.send()
	} */
	
	
	window.addEventListener("DOMContentLoaded", function() {
		getSessionId()
		reloadFollowList()
		reloadRandomList() 
		storyList()
		unionLists()

	})
</script>
<title>mainPage</title>
    <style>
    .story-img {
    width: 90px;
    height: 90px;
    border-radius: 50%;
	    border: 2px solid transparent;
	    padding: 1px;
	    background-image: linear-gradient(#fff, #fff),
	    linear-gradient(to right, red 0%, orange 100%);
	    background-origin: border-box;
	    background-clip: content-box, border-box;
    }
    	.scroll-container {
		  height: 100vh; /* 스크롤 영역의 높이 설정 */
		  position: fixed;
		  right: 320px;
		  top: 0;
		}
		.scroll {
			overflow: auto;
			height: 19em;
		}
		.scrolll {
			overflow: auto;
			height: 19em;
		}
		.scrollrow {
		  display: flex;
		  flex-wrap: nowrap;
		  overflow-x: auto;
		}
		.scrollrow .col {
		  flex: 0 0 120px;
		  max-width: 120px;

		}		
        .fixed-left-navbar {
            position: fixed;
            top: 0;
            left: 320px;
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
		.custom-row {
		  margin-top: -5px;
		}
		.img {
		  max-width: 100%; /* 최대 너비는 100% */
		  height: auto; /* 높이는 자동으로 조정됨 */
		}
		
		/* 비디오 */
		.video {
		  max-width: 100%; /* 최대 너비는 100% */
		  height: auto; /* 높이는 자동으로 조정됨 */
		}
		.offcanvas-startd {
		  transform: translateX(calc(580px));
		}
		.col-col {
		    border: 1px solid #000;
		    padding: 2px;
		    margin-right: 2px;
		  }
		  .profile-img {
			  position: absolute;
			  top: 10px; /* 필요한 위치로 조정 */
			  left: 10px; /* 필요한 위치로 조정 */
			  width: 40px;
			  height: 40px;
			  border-radius: 50%;
			  border: 3px solid rgba(255, 255, 255, 0.5);
			}
			.profile-imgg {
			  
			  width: 50px;
			  height: 50px;
			  border-radius: 50%;
			  border: 3px solid rgba(255, 255, 255, 0.5);
			}
			.profile-text {
			  position: absolute;
			  top: 5px; /* 필요한 위치로 조정 */
			  left: 60px; /* 필요한 위치로 조정 */
			  width: 90px;
			  height: 30px;
			  font-weight: bold;
			  font-size: 20px;
			  color: white;
			}
			.profile-time {
			  position: absolute;
			  top: 25px; /* 필요한 위치로 조정 */
			  left: 60px; /* 필요한 위치로 조정 */
			  width: 90px;
			  height: 30px;
			  font-size: 12px;
			  color: rgba(255, 255, 255, 0.8);
			}
			.reverse {
				 transform: rotate(180deg);
			}
			/* .custom-textarea {
		  height: 40px;
		  width: 590px;
		  
		  border-radius: 40px;
		  margin-bottom: 10px;
		} */
		.custom-textarea {
			width: auto;
			height: 30px; /* 원하는 높이로 설정 */
	        max-width: 100%;
	        border: none;
        	max-height: 100%;
        	outline: none;
	        resize: none; /* (선택사항) 텍스트 에어리어의 크기 조절 비활성화 */
	    }
		  .union-img {
    width: auto; /* col 요소의 고정 가로 크기 */
    padding: 0;
    height: 600px; /* col 요소의 고정 세로 크기 */
    overflow: hidden; /* 넘치는 콘텐츠 숨김 */
    display: flex; /* 내부 컨텐츠 중앙 정렬을 위해 flex 사용 */
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    background-color: black; /* 남는 공간 검정 배경 */
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    border-radius: 1px;
  }

    
  .union-video {
    width: 100%;
    height: auto;
    display: flex;
    justify-content: center;
    background-color: black;
    align-items: center;
    max-height: 100%;
    object-fit: contain;
    border-radius: 1px;
  }
  .modal-content-feed {
    border: none;
    border-radius: 5px;
}
    </style>
</head>
<body>
	<div class="container-fluid">
		<%-- <div class="row">
			<div class="col">
				<jsp:include page="../common/topNaviFix.jsp"></jsp:include>
			</div>
		</div> --%>
		<div class="row">
			<div class="col-3 fixed-left-navbar">
				<jsp:include page="../common/facebookLeftNavi.jsp"></jsp:include>
			</div>
		</div>
		<div class="row mt-5">
			<div class="col">
				<div class="row">
					<div class="col-4"></div>
					<div class="col-4 mt-4">
						<div class="row">
							<div class="col"></div>
							<div class="col-10">
								<div class="row scrollrow mt-1 my-3" id="storyMainInfo"></div>
								<div class="row" id="checkStory"></div>
									<div class="row mt-5" id="unionLists"></div>
								</div>
							<div class="col"></div>
						</div>
						
						
					</div>	
					<div class="col-2 scroll-container">
						<div class="row mt-4">
							<div class="col text-start fw-semibold fs-5">광고</div>
						</div>
						<div class="row mt-2">
							<div class="col">
								<div class="card">
									<img class="img-fluid" src="/roaming/resources/img/ad1.jpeg">
								</div>
							</div>
							<div class="col">
								<div class="card">
									<img class="img-fluid" src="/roaming/resources/img/ad2.jpeg">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div class="row mt-3">
									<div class="col text-start fw-semibold fs-6">팔로우 목록</div>
								</div>
								<div class="row">
									<div class="col scroll">
										<div class="row" id="followHomeList"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div class="row mt-3">
									<div class="col text-start fw-semibold fs-6">친구 추천</div>
									<div class="col text-end fs-5" onclick="refreshRandom()"><i class="bi bi-arrow-counterclockwise"></i></div>
									<div class="col-1"></div>
								</div>
								<div class="row">
									<div class="col scrolll">
										<div class="row" id="randomHomeList"></div>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<img class="img-fluid" src="/roaming/resources/img/mainFeed.png">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="storyModal" data-bs-backdrop="static" data-bs-keyboard="true" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="storyModalFor">
            <div class="modal-header p-3">
                <h2 class="modal-title fs-4" id="staticBackdropLabel"></h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row justify-content-center" id="modalBodyList">
                    <div class="col">
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="followModal" data-bs-backdrop="false" data-bs-keyboard="true" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="followModalInfo">
            <div class="modal-body">
                <div class="row justify-content-center" id="followModalPhoto">
                    <div class="row">
                    	<div class="col">사진</div>
                    	<div class="col">
                    		<div class="row">
                    			<div class="col">아이디</div>
                    		</div>
                    		<div class="row">
                    			<div class="col">이름</div>
                    		</div>
                    	</div>
                    </div>
                    <div class="row">
                    	<div class="col">
                    		<div class="row">
                    			<div class="col">숫자</div>
                    		</div>
                    		<div class="row">
                    			<div class="col">게시물</div>
                    		</div>
                    	</div>
                    	<div class="col">
                    		<div class="row">
                    			<div class="col">숫자</div>
                    		</div>
                    		<div class="row">
                    			<div class="col">팔로워</div>
                    		</div>
                    	</div>
                    	<div class="col">
                    		<div class="row">
                    			<div class="col">숫자</div>
                    		</div>
                    		<div class="row">
                    			<div class="col">팔로잉</div>
                    		</div>
                    	</div>
                    </div>
                    <div class="row">
                    	<div class="col">사진</div>
                    	<div class="col">사진</div>
                    	<div class="col">사진</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
	
<!-- Modal -->
<div class="modal fade" id="exampleModal" data-bs-backdrop="true" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="informationModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body border-bottom text-center text-danger fw-semibold" style="cursor: pointer;">
        신고
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
      	관심 없음
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        게시물로 이동
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        공유 대상..
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        링크 복사
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        퍼가기
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        이 계정 정보
      </div>
      <div class="modal-body text-center fw-semibold" style="cursor: pointer;">
        취소
      </div>
    </div>
  </div>
</div>

<div class="modal fade" style="z-index: 9999;" id="informationModal2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body border-bottom text-center text-danger fw-semibold" style="cursor: pointer;">
        신고
      </div>
      <div class="modal-body border-bottom text-center text-danger fw-semibold" style="cursor: pointer;">
        팔로우 취소
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
      	즐겨찾기에 추가
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        게시물로 이동
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        공유 대상..
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        링크 복사
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        퍼가기
      </div>
      <div class="modal-body border-bottom text-center fw-semibold" style="cursor: pointer;">
        이 계정 정보
      </div>
      <div class="modal-body text-center fw-semibold" style="cursor: pointer;">
        취소
      </div>
    </div>
  </div>
</div>
<!-- 릴스 모달 -->
<div class="modal fade" id="reelsCommentModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-dialog-feed">
        <div class="modal-content">
        	<div class="row">
        		<div class="col"></div>
        		<div class="col">
        			<div class="modal-body">댓글</div>
        			<div class="modal-body">
                		<div class="row" id="modalBodyList"></div>
            		</div>

        		</div>
        	</div>
        </div>
    </div>
</div>
<!-- 피드 모달 -->
<div class="modal fade" id="feedCommentModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content modal-content-feed">
        	<div class="row">
        		<div class="col-7 pe-0" id="feedCommentPhoto">
        			
        		</div>
        		<div class="col ps-0">
        			<div class="modal-body modal-body-feed border-bottom">
        				<div class="row">
        					<div class="col-2" id="feedModalUser"></div>
        					<div class="col" id="feedModalUserName"></div>
        					<div class="col-2" id="feedModalUserDot"></div>
        				</div>
        			</div>
        			<div class="modal-body modal-body-feed border-bottom" style="overflow-y: auto; height: 800px;">
                		<div class="row" id="modalBodyListC"></div>
            		</div>
            		<div class="modal-body modal-body-feed border-bottom">
            			<div class="row" id="feedCommentModalLieks"></div>
            		</div>
            		<div class="modal-body p-0">
		               <div class="row py-0 ps-3" id="modalFooterComment">
		               </div>
            		</div>
        		</div>
        	</div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>