<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <title>faqPage</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<style>
    .nav-tabs .nav-link {
        color: #333; /* Dark Gray Color */
        font-weight: bold; /* Bold Font Weight */
    }
	.scroll {
			overflow: auto;
			height: 750px;
		}
    .nav-tabs .nav-link.active {
        background-color: #f8f9fa; /* Light Gray Background */
    }
    
    
</style>
<script>
function toggleCollapse(collapseId) {
    var collapseContent = document.getElementById(collapseId);
    if (collapseContent.classList.contains("show")) {
        collapseContent.classList.remove("show");
    } else {
        collapseContent.classList.add("show");
    }
}
</script>
<body>
    <!-- 위쪽 네비-->
    <%@ include file="../common/topNavi.jsp" %>

    <div class="container">
        <div class="row mt-5">
            <div class="col-2">
                <!-- 왼쪽 사이드바 -->
				<div class = "row">
					<div class = "col mx-4 border border-black text-center">
						<div class = "row py-3">
							<div class="col fs-4">고객센터</div>
						</div>
						<div class="row list py-2">
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./csNoticePage">공지사항</a>
							</div>
						</div>
						<div class="row list py-2" style="background-color: rgb(240, 240, 240);">
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./faqPage">자주하는 질문</a>
							</div>
						</div>
						<div class="row list mb-3 py-2" >
							<div class="col">
								<a class="link-dark link-offset-2 link-underline link-underline-opacity-0" href="./qaBoardPage">묻고 답하기</a>
							</div>
						</div>
					</div>
				</div>
            </div>

            <div class="col-8 scroll">
                <div class="row mb-2 border-bottom border-black border-2">
                    <div class="col">
                        <h3>자주하는 질문</h3>
                    </div>
                </div>

				<div class="row mt-4">
				    <div class="col-2"></div>
				    <div class="col-2 pe-0">
				        <select name="searchType" class="form-select">
				            <option value="qa_title">제목</option>
				            <option value="qa_content">내용</option>
				        </select>
				    </div>
				    <div class="col-5 text-center ps-1">
				        <input type="text" name="searchWord" class="form-control" placeholder="검색할 내용을 입력하세요">
				    </div>
				    <div class="col-1 text-start ps-0">
				        <button class="btn btn-dark fw-semibold" style="border-radius: 0px;">
				            검색
				        </button>
				    </div>
				    <div class="col-2"></div>
				</div>
                
                <div class="row mt-4">
                	<!-- 네비 탭 -->
	                <ul class="nav nav-tabs nav-fill" id="myTab" role="tablist">
	                    <c:forEach items="${faqLists}" var="faqList">
	                        <li class="nav-item" role="presentation">
	                            <a class="nav-link" id="faqTab${faqList.faqCategory.id}" data-bs-toggle="tab" href="#faqTabPane${faqList.faqCategory.id}" role="tab" aria-controls="faqTabPane${faqList.faqCategory.id}" aria-selected="true">${faqList.faqCategory.faq_name}</a>
	                        </li>
	                    </c:forEach>
	                </ul>
	
	                <!-- 콜랩스 있는 탭 내용 -->
	                <div class="tab-content" id="myTabContent">
	                    <c:forEach items="${faqLists}" var="faqList">
	                        <div class="tab-pane fade" id="faqTabPane${faqList.faqCategory.id}" role="tabpanel" aria-labelledby="faqTab${faqList.faqCategory.id}" tabindex="0">
	                            <c:forEach items="${faqList.faqDtos}" var="faqDto">
	                                <div class="clickable-div" onclick="toggleCollapse('collapseContent${faqDto.id}')">
	                                    <div class="row bg-secondary bg-opacity-10 border border-start-0 border-end-0 border-dark-subtle py-3">
	                                        <div class="col-1"><i class="bi bi-question-square"></i></div>
	                                        <div class="col-10">${faqDto.faq_title}</div>
	                                        <div class="col-1"><i class="bi bi-caret-down"></i></div>
	                                    </div>
	                                </div>
	                                <div class="collapse" id="collapseContent${faqDto.id}">
	                                    <div class="row  bg-opacity-10 border-bottom border-dark-subtle py-3">
	                                        <div class="col-1"><i class="bi bi-arrow-right"></i></div>
	                                        <div class="col-10">${faqDto.faq_content}</div>
	                                        <div class="col-1"></div>
	                                    </div>
	                                </div>
	                            </c:forEach>
	                        </div>
	                    </c:forEach>
	                </div>
                </div>
            </div>
            <div class="col-2"></div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
