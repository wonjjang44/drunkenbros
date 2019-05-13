<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<style>
.searchBarCustom{
	left:50px;
	width:500px;
	position:float;
}
</style>
</head>
<body>

	<div class="fh5co-loader"></div>

	<div id="page">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row">



					<!-- 이 안에 버튼들 들어올 예정 -->
					<!-- Search form -->
					<form class="form-inline">
						<i class="fas fa-search" aria-hidden="true"></i> 
						<input
							class="searchBarCustom" type="text"
							placeholder="Search" aria-label="Search">
					
					<button type="button" class="btn btn-secondary">검색</button>
					<button type="button" class="btn btn-pill btn-secondary">글등록</button>
					</form>
				</div>
			</div>
		</div>

		<div class="container-wrap">

			<!-- 상품 하나 / 클릭하면 상세페이지(work-single)로 넘어감 -->
			<div id="fh5co-work">
				<div class="row">
					<%
						for (int i = 0; i < 9; i++) {
					%>
					<div class="col-md-4 text-center animate-box">
						<a href="info-detail.jsp" class="work"
							style="background-image: url(images/portfolio-1.jpg);">
							<div class="desc">
								<h3>술 이름</h3>
								<span>술 정보</span> <span>술 평점</span>
							</div>
						</a>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
		<!-- END container-wrap -->

		<div class="container-wrap">
			<%@ include file="/inc/footer.jsp"%>
		</div>
		<!-- END container-wrap -->
	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
	</div>

	<%@ include file="/inc/tail.jsp"%>

</body>
</html>

