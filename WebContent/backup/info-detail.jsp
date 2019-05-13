<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<style>
<!-- 평점 창 거리 벌리기 위한 div인데 잘 안됨 -->
.test{
	background:red;
	width:50px;
	height:50px;
}

</style>
<!-- 평점 관련 창 디자인 (수정 많이 필요) -->
<!-- <link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>-->
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<style>

</style>
</head>
<body>

	<div class="fh5co-loader"></div>

	<div id="page">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row">
					<!-- 상품 이미지 -->
					
					<div class="col-md-7">
						<a href="images/portfolio-1.jpg"
							class="image-popup img-portfolio-detail"> <img
							src="images/portfolio-1.jpg"
							alt="Free HTML5 Template by FreeHTML5.co" class="img-responsive">
						</a>

					</div>

					<!-- 상품 소개 -->
					<div class="col-md-4 fh5co-project-detail">
						<h2 class="fh5co-project-title">가그린</h2>
						<span class="fh5co-project-sub">Package of the year</span>
						<p>알콜 중독자도 합법적으로 마실 수 있는 알콜</p>


						<!-- /container -->

						<div class="fh5co-project-service">
							<h3>술정보(임시)</h3>
							<ul>
								<li>여기에 뭐 넣지</li>
								<li>분류</li>
								<li>브랜드</li>
							</ul>
						</div>
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

