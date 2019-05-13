<%@page import="com.drunkenbros.model.domain.Alcohol"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<Alcohol> alcoholListByHit=(List)request.getAttribute("alcoholListByHit");
%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
<%-- $(function(){
	if(true){
		<%Alcohol test=alcoholListByHit.get(0);%>
		alert(<%=test.getName()%>);
	}
}) --%>
</script>
</head>
<body>
	<!-- 페이지 로딩 될 때 나타났다 사라지는 div / 이미지나 문구 추가 가능 -->
	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<aside id="fh5co-hero">
				<div class="flexslider">
					<!-- Main 페이지 화면 전환 list : 몇개나 더 필요? -->
					<ul class="slides">
						<!-- main 화면 url교체로 이미지 교체 가능 -->
						<%for(int i=1; i<5; i++){ %>
						<li style="background-image: url(/images/img_bg_<%=i%>.jpg);">
							<div class="overlay-gradient"></div>
							<div class="container-fluid">
								<div class="row">
									<div class="col-md-6 col-md-offset-3 col-md-pull-3 slider-text">
										<div class="slider-text-inner">	
											<h1 style="color: white; font-size:60px; font-weight:bolder; background-color: black; background-color: rgba( 255, 255, 255, 0.5 ); ">DrunkenBros' Review Site</h1>
										</div>
									</div>
								</div>
							</div>
						</li>
						<%} %>
					</ul>
				</div>
			</aside>
			

			<div id="fh5co-work" class="fh5co-light-grey">
				<div class="row animate-box">
					<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
						<h1>오늘의 추천주</h1>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4 text-center animate-box">
						<a href="work-single.html" class="work"
							style="background-image: url(images/portfolio-1.jpg);">
							<div class="desc">
								<h2>Absolute Vodca</h2>
								<span>평점 : 4.3</span>
								<span>부드럽게 넘어가는 술입니다. 하지만 마음 놓고 마시다가는 훅가니 조심하세요 ^^.</span>
							</div>
						</a>
					</div>
					<div class="col-md-4 text-center animate-box">
						<a href="work-single.html" class="work"
							style="background-image: url(images/portfolio-2.jpg);">
							<div class="desc">
								<h2>AGWA</h2>
								<span>평점 : 3.7</span>
								<span>짠 안주와 잘 어울립니다. 기름진 요리와도 잘 어울리지만 가격대비 때문에 별 하나 깎습니다. 가격이 좀 있는 편입니다.</span>
							</div>
						</a>
					</div>
					<div class="col-md-4 text-center animate-box">
						<a href="work-single.html" class="work"
							style="background-image: url(images/portfolio-3.jpg);">
							<div class="desc">
								<h2>WoodWalk</h2>
								<span>평점 : 2.9</span>
								<span>마시기 시작한 기억은 나는데 마시던 기억이 나질 않습니다 ㅜㅜ.</span>
							</div>
						</a>
					</div>
				</div>
			</div>

			
			<!--mapper에 selectAllByHit 만들어두고 아직 컨트롤러 처리는 안함-->
			<!-- 최근 게시글 뜨도록 한 부분으로 추정 -->
			<div id="fh5co-blog" class="blog-flex">
				<div class="featured-blog"
					style="background-image: url(images/blog-1.jpg);">
					<div class="desc-t">
						<div class="desc-tc">
							<span class="featured-head" style="font-weight:bold;">Popular Alcohol's</span>
							<h3>
								<a style="background-color: black; background-color: rgba( 255, 255, 255, 0.5 );" href="#">사람들이 <br>많이 찾은  술정보</a>
							</h3>
							<span><a href="#" class="read-button" style="font-weight:bold;">SHOW REVIEW</a></span>
						</div>
					</div>
				</div>
				<div class="blog-entry fh5co-light-grey">
					<div class="row animate-box">
						<div class="col-md-12">
							<h2>A Hotshot</h2>
						</div>
					</div>
					<div class="row">
						<%for(int i=0; i<alcoholListByHit.size(); i++){ %>
							<%Alcohol alcohol=alcoholListByHit.get(i); %>
							<%if(i>=3){break;} %>
							<div class="col-md-12 animate-box">
								<a href="/alcohols/<%=alcohol.getAlcohol_id()%>" class="blog-post"> <span class="img"
									style="background-image: url(/data/<%=alcohol.getAlcoholImageList().get(0).getFilename()%>);"></span>
									<div class="desc">
										<h3><%=alcohol.getName()%></h3>
										<h5>조회수 : <%=alcohol.getHit() %></h5>									
										<h5><%=alcohol.getSubcategory().getTopcategory().getName()%> / <%=alcohol.getSubcategory().getName()%></h5>
									</div>
								</a>
							</div>
						<%} %>
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

