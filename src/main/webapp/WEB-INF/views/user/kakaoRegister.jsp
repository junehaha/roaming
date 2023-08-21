<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>loginPage</title>
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
function selectNullPoint(){
	const birth = document.getElementById("birth")
	const phone = document.getElementById("phone")
	const email = document.getElementById("email")
	
	if(birth.value == ""){
		alert("생년월일을 입력해주세요.")
		return;
	}else if(phone.value == ""){
		alert("전화번호를 입력해주세요.")
		return;
	}else if(email.value == ""){
		alert("이메일을 입력해주세요.")
		return;
	}
	
	const frm = document.getElementById("frm");
	frm.submit();
}
</script>
</head>
<body>
	<div class="container-fluid">
	<jsp:include page="../common/topNavi.jsp"></jsp:include>
		<div class="row">
            <div class="col-3"></div>
            <div class="col">
                <div class="row">
                    <div class="col"></div>
                    <div class="col-10">
                        <div class="row mt-5">
                            <div class="col-2"></div>
                            <div class="col-8">
                                <div class="row mt-5">
                                    <div class="col mt-5 fw-semibold fs-4 text-center">
										<img src="../resources/img/kakaoMini.jpg" style="height: 30px; width: 30px;" class="mb-2"> 카카오로 간편 회원가입
									</div>
                                </div>
								  <div class="row mt-2">
                                	<div class="col text-center">
                                		<img src="../resources/img/originalLogo.png" style="height: 50px; width: 160px;">
                                	</div>
                                 </div>
 								<div class="row mt-3 mb-3">
                                	<div class="col text-center fw-semibold fs-5">
                                		<span class="text-primary">로밍</span> 이용시 필요한 추가 정보 작성을 해주세요.
                                	</div>
                                 </div>
                                <!-- <div class="row mt-5">
                                    <div class="col text-center">SNS 계정으로 로그인 하기</div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col"></div>
                                    <div class="col-8"><img class="img-fluid" src="/roaming/resources/img/loginlogo.png"></div>
                                    <div class="col"></div>
                                </div>
                                <div class="row mt-5">
                                    <div class="col pt-2 custom-box opacity-25"></div>
                                    <div class="col-2 text-center">또는</div>
                                    <div class="col pt-2 custom-box opacity-25 "></div>
                                </div> -->
                                <form action="./kakaoUserRegisterProcess" method="post" id="frm">
                                <div class="row mt-4">
                                    <div class="col"></div>
                                    <div class="col-10">
										<span class="small fw-semibold">생년월일 *</span>
                                        <input name="birth" type="date" class="form-control mt-2" id="birth">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col"></div>
                                    <div class="col-10">
										<span class="small fw-semibold">전화번호 *</span>
                                        <input type="text" name="phone_number" class="form-control  mt-2" placeholder="전화번호" id="phone">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col"></div>
                                    <div class="col-10">
										<span class="small fw-semibold">이메일 *</span>
                                        <input type="text" name="email" class="form-control mt-2" placeholder="이메일" id="email">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <input type="button" class="btn btn-dark btn-lg btn-block mt-3 w-100" style="border-radius: 5px;" value="회원가입" onclick="selectNullPoint()">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                </form>

                                <div class="row mt-4">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <img class="img-fluid" src="/roaming/resources/img/loginbanner.png">
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
        <jsp:include page="../common/footer.jsp"></jsp:include>
</html>