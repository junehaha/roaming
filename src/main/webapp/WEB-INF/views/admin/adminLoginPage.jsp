<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous"><title>adminLoginPage</title>
<style>
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

</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>
	<div class="container-fluid">
        <div class="row">
            <div class="col-3"></div>
            <div class="col">
                <div class="row">
                    <div class="col"></div>
                    <div class="col-10">
                        <div class="row">
                            <div class="col-2"></div>
                            <div class="col-8">
                            	<form action="./adminLoginProcess" method="post">

                                <div class="row mt-5">
                                    <div class="col-4"></div>
                                    <div class="col-4"><img class="img-fluid" src="/roaming/resources/img/originalLogo.png"></div>
                                    <div class="col-4"></div>
                                </div>
                                <div class="row mt-5">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <input type="text" name="admin_id" class="form-control" placeholder="관리자 아이디">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <input type="password" name="admin_pw" class="form-control" placeholder="관리자 비밀번호">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-1"></div>
                                    <div class="col small"><input type="checkbox" style="width: 17px; height: 17px; padding-top: 5px;">&nbsp;아이디 저장</div>
                                    <div class="col"></div>
                                    <div class="col"></div>
                                </div>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <button class="btn btn-lg btn-block mt-3 w-100" style="border-radius: 5px; background-color: #46B8FF !important; color : white;">관리자 로그인</button>
                                    </div>
                                    <div class="col"></div>
                                </div>
                                </form>
                                <div class="row mt-3">
                                    <div class="col small text-center"><input type="checkbox" style="width: 17px; height: 17px; padding-top: 5px;">&nbsp;로그인 상태 유지</div>
                                </div>
                                <div class="row mt-4 mb-5">
                                    <div class="col"></div>
                                    <div class="col-3 text-center small opacity-75 border-end" style="cursor: pointer;">아이디 찾기</div>
                                    <div class="col-3 text-center small opacity-75 border-end" style="cursor: pointer;">비밀번호 찾기</div>
                                    <div class="col-3 text-center small opacity-75">
                                    	<a href="../admin/adminRegisterPage" style="text-decoration: none; color: black;">관리자 회원가입</a>
                                    </div>
                                    <div class="col"></div>
                                </div>

                            </div> 
                            <div class="col-2"></div>
                        </div>
                    </div>
                    <div class="col"></div>
                </div>
            </div>
            <div class="col-3"></div>
        </div>
    </div>
<jsp:include page="../common/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>