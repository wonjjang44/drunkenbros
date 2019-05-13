<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="fh5co-loader"></div>
	
	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row">
					<h1 class="text-center" id="title">회원가입을 환영합니다!</h1>
					<p class="text-center">
						<small class="text-muted"> Drunken Bros's의 다양한 술 정보와 회원들의 리뷰들을 경험해보세요! </small>
					</p>
				</div><br><br>
				<div class="row">
					<div class="col-md-5"></div>
					<div>
						<input type="button" class="btn btn-lg btn-primary"
							onclick="location.href='/member/member-login'" value="로그인" />
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="/inc/footer.jsp"%>
		<%@ include file="/inc/tail.jsp"%>
	</div>
</body>
</html>