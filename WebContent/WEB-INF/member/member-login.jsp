<%@page import="com.drunkenbros.model.domain.Member"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#alert-danger").hide();
		$("input[name='bt_login']").click(function() {
			login();
		});
	});
	//로그인 버튼 눌렀을 때 아이디와 패스워드 입력했는지 확인하는 함수
	function loginCheck() {

	}

	//체크 다 했으면 로그인!
	function login() {
		$.ajax({
			url : "/member/login",
			type : "post",
			data : {
				id : $("input[name='id']").val(),
				pass : $("input[name='pass'").val()
			},
			success : function(result) {
				//alert("서버에서 받아온 결과 : "+result);//result가 object형으로 찍히는건 json화되어 전송되었기 때문!

				var json = JSON.parse(result);

				if (json.resultCode == 1) {
					//성공시 세션 등록하고 main 화면으로
					//alert("로그인 성공");
					location.href = "/";//주소값은 임시
				} else {
					//실패 시 로그인 실패메시지(alert?)
					//창에 로그인 실패 메시지 띄우기
					//alert("로그인 실패");
					$("#alert-danger").show();
				}

			}
		});

	}
</script>
</head>
<body>
	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row">
					<h2 class="text-center" id="title">로그인</h2>
					<p class="text-center">
						<small id=class="text-muted"> 로그인 아이디와 비밀번호를 입력해주세요. </small>
					</p>
					<hr>
				</div>
				<div class="row">
					<div class="col-md-12 col-md-push-3 animate-box">
						<form role="form">
							<fieldset>
								<div class="row">
									<div class="form-group">
										<div class="col-md-6">
											<div class="form-group">
												<input type="text" name="id" id="id"
													class="form-control input-lg" placeholder="ID를 입력해주세요.">
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<input type="password" name="pass" id="pass"
												class="form-control input-lg" placeholder="비밀번호를 입력해주세요.">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="alert alert-danger" id="alert-danger">회원정보가
										일치하지 않습니다.</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<input type="button" name="bt_login"
											class="btn btn-primary btn-modify" value="로그인">
									</div>
									<div class="col-md-2">
										<input type="button" name="bt_login" onclick = "location.href = '/member/member-regist'" 
											class="btn btn-primary btn-modify" value="회원가입">
									</div>
								</div>
							</fieldset>
						</form>
					</div>

				</div>
			</div>
		</div>
	<%@ include file="/inc/footer.jsp"%>
	</div>

	<%@ include file="/inc/tail.jsp"%>
	
</body>
</html>