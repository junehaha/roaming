<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>userRegisterPage</title>
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
		.custom-box {
	  position: relative;
	  display: flex;
	  /* 다른 스타일들 */
	}

	.custom-box::before {
	  content: "";
	  flex-grow: 1;
	  border-top: 1px solid black; /* 선의 색상을 설정합니다 */
	}

</style>
<script>
function checkValueAndSubmit(){
	const adminId=document.getElementById("adminId");
	const adminPw=document.getElementById("adminPw");
	
	const frm = document.getElementById("frm")
	
	if(adminId.value==""){
		alert("아이디를 입력해주세요")
		return;
	}else if(adminPw.value==""){
		alert("비밀번호를 입력해주세요")
		return;
	}
	
	if (checkPw == 0){
		alert("비밀번호확인이 일치하지 않습니다.")
	}
	
	frm.submit();
}

let checkPw = 0;

function passwordConfirm(){
	const adminPass = document.getElementById("adminPw")
	const adminPassConfirm = document.getElementById("adminPwConfirm")
	const isPassConfirmOk = document.getElementById("isPassConfirmOk")
	
	if(adminPass.value != adminPassConfirm.value){
		isPassConfirmOk.classList.add("text-danger");
		isPassConfirmOk.classList.remove("text-primary");
		isPassConfirmOk.innerText="비밀번호가 일치하지 않습니다."
		checkPw = 0;
	}else{
		isPassConfirmOk.classList.add("text-primary");
		isPassConfirmOk.classList.remove("text-danger");
		isPassConfirmOk.innerText="비밀번호가 일치합니다."
		checkPw = 1;
	}
}

</script>
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
								<div class="row text-center">
									<div class="col mt-5 fw-bold fs-4 text-center">관리자 회원가입</div>
								</div>
								<!-- 관리자 회원가입폼 -->
								<div class="row">
									<div class="col">
										<form id="frm" action="./adminRegisterProcess" method="post">
											<div class="row mt-5">
												<div class="col"></div>
												<div class="col-10">
													<label for="adminId"><span class="small fw-semibold">아이디 *</span></label>
													<input name="admin_id" type="text" placeholder="아이디를 입력해주세요" class="form-control mt-2" id="adminId">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<label for="adminPw"><span class="small fw-semibold">비밀번호 *</span></label>
													<input name="admin_pw" type="password" placeholder="비밀번호를 입력해주세요" class="form-control mt-2" id="adminPw">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
                                                <div class="col"></div>
												<div class="col-10">
                                                    <label for="adminPwCofirm"><span class="small fw-semibold">비밀번호 확인 *</span></label>
													<input type="password" placeholder="비밀번호를 한번더 입력해주세요" class="form-control mt-2" id="adminPwConfirm" onblur="passwordConfirm()">
                                                    <div id="isPassConfirmOk"></div>
												</div>
												<div class="col"></div>
											</div>
											<div class="row">
												<div class="col"></div>
												<div class="col-10">
													<input type="button" value="관리자 회원가입" onclick="checkValueAndSubmit()" class="btn btn-lg btn-block mt-3 w-100 buttonColor" style="border-radius: 5px;  background-color: #46B8FF !important; color : white;">
												</div>
												<div class="col"></div>
											</div>
										</form>
									</div>
								</div>

                                <div class="row my-4">
                                    <div class="col"></div>
                                    <div class="col-10">
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