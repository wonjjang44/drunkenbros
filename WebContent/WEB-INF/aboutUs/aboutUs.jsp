<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
</head>
<body>

	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">

			<!-- 유저 붙여보기 테스트 -->
			

			<div id="fh5co-contact">
				<div class="row animate-box">
					<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
						<h1>About Us</h1>
						<h4>Hello! 드렁큰 Bros의 관리자들을 소개합니다.</h4>
					</div>
				</div>
				
				<div class="row">
				<!-- 유저들 만들기 -->
					
					<div class="col-md-4 pr-1 animate-box">
						<div style="text-align: center;"><h3>◀ 이상훈 ▶</h3></div>
						<div style="text-align: center;">
							<img src="/images/drunken_poto/poto_2.jpg" width="180px" height="180px">
						</div>
						<hr>
						<ul class="contact-info">
							<li><i class="icon-user"></i>
								IT의 정상에 서겠습니다. <br>여러분들과 함께 할 수 있는 친숙한 개발자가 되겠습니다.
							</li>
							<!-- <li><i class="icon-phone3"></i>연락처</li> -->
							<li><i class="icon-location3"></i><a href="#">이메일@이메일주소.com</a></li>
							<li><i class="icon-globe2"></i><a href="#">포트폴리오사이트</a></li>
						</ul>
					</div>
					
					
					
					<div class="col-md-4 pr-1 animate-box">
						<div style="text-align: center;"><h3>◀ 이희원 ▶</h3></div>
						<div style="text-align: center;">
							<img src="/images/drunken_poto/poto_1.jpg" width="180px" height="180px">
						</div>
						<hr>
						
						<ul class="contact-info">
							<li><i class="icon-user"></i>
								부지런히 배워 한사람 몫 이상을 하는 개발자가 되겠습니다.
							</li>
							<!-- <li><i class="icon-phone3"></i>연락처</li> -->
							<li><i class="icon-location3"></i><a href="#">ppossing35@gmail.com</a></li>
							<li><i class="icon-globe2"></i><a href="http://ppossing.dothome.co.kr/">http://ppossing.dothome.co.kr/</a></li>
						</ul>
					</div>
					
					
					<div class="col-md-4 pr-1 animate-box">
						<div style="text-align: center;"><h3>◀ 이양원 ▶</h3></div>
						<div style="text-align: center;">
							<img src="/images/drunken_poto/poto_3.jpg" width="180px" height="180px">
						</div>
						<hr>
						
						<ul class="contact-info">
							<li><i class="icon-user"></i>
								한국의 마크 주커버그가 되겠습니다.
							</li>
							<!-- <li><i class="icon-phone3"></i>연락처</li> -->
							<li><i class="icon-location3"></i><a href="#">wonjjang44@naver.com</a></li>
							<li><i class="icon-globe2"></i><a href="https://github.com/wonjjang44">https://github.com/wonjjang44</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- END container-wrap -->


		<%@ include file="/inc/footer.jsp"%>

		<!-- END container-wrap -->
	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
	</div>

	<%@ include file="/inc/tail.jsp"%>

</body>
</html>

