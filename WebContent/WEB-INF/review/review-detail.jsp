<%@page import="com.drunkenbros.common.Pager"%>
<%@page import="com.drunkenbros.common.ReviewScoreSetter"%>
<%@page import="com.drunkenbros.model.domain.Review"%>
<%@page import="com.drunkenbros.model.domain.AlcoholImage"%>
<%@page import="com.drunkenbros.model.domain.Alcohol"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	Member loginMember = (Member) session.getAttribute("member");

	Pager pager = (Pager) request.getAttribute("pager");
	Alcohol alcohol = (Alcohol) request.getAttribute("alcohol");
	List<AlcoholImage> imageList = alcohol.getAlcoholImageList();
	List<Review> reviewList = (List) request.getAttribute("reviewList");
	ReviewScoreSetter scoreSetter = new ReviewScoreSetter();
	scoreSetter.setScore(reviewList);

	//out.print("totalScore : "+scoreSetter.getTotalScore());
	//out.print("averageScore : "+scoreSetter.getPlainAverageScore());
%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<%@ include file="/inc/head.jsp"%>
<style>
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function refreshScore(num){
   var score=num;
   //alert(num);
   //alert($($("img[name='star']")));
   for(var i=0;i<5;i++){
         $($("img[name='star']")[i]).attr("src","/images/star_f.png");
         if(i>=num){
         $($("img[name='star']")[i]).attr("src","/images/star_blank.png")   ;
            }
   }
   $("#myscore").html(score+" <small> / </small> 5");
   $("#myscoreVal").val(num);
   console.log("#myscoreVal : "+$("#myscoreVal").val());
}
//로그인한 후엔 세션에 "member"로 Attribute가 ADD가 된다. 만약 member가 null 이라면 로그인 하라고 경고창을 띄우고 밑에 리뷰등록은 실행X
function loginAlert(){
	alert("로그인이 필요한 서비스입니다.");
}

function registReview(){
	//리뷰 내용 입력하지 않았을 때 막기
	if($("#title").val()==""){
		alert("리뷰 제목을 작성해주세요.");
		return;
	};
	if($("#detail").val()==""){
		alert("리뷰 내용을 작성해주세요.");
		return;
	};
	
	$("#review-regist-form").attr({
	   method:"post",
	   action:"/review/regist"
	});
	$("#review-regist-form").submit();
}

function deleteReview(review_id){
   //alert(review_id);
   if(confirm("삭제 하시겠습니까?")){
      $("input[name='review_id']").val(review_id);
      $("#review-delete-form").attr({
         method:"post",
         action:"/review/delete/"+$("input[name='alcohol_id']").val()
      });
      $("#review-delete-form").submit();
   }
}

function viewLimit(obj,maxBytes){
   var strVal = obj.value;
   var strLength = strVal.length;
   var totalBytes = 0;
   var oneChar = "";
   var len=0;
   var str2="";

   for(var i=0;i<strLength;i++){
      oneChar = strVal.charAt(i);
      if(escape(oneChar).length > 4){
         totalBytes += 2;
      }else{
         totalBytes++; 
      }
      if(totalBytes <= maxBytes){
         len = i+1;
      }
   }
   if(totalBytes > maxBytes){
      alert("글자 수가 한글 : '"+maxBytes/2+"',영어 : '"+maxBytes+"'자로 제한 되어 있습니다.");
      str2 = strVal.substr(0,len);
      obj.value=str2;
      viewLimit(obj,maxBytes);
   }
   
   console.log(totalBytes);
   $("#counter").html("("+totalBytes+"/"+maxBytes+")");
}

function report(){
	window.open("/report","window팝업","width=400px, height=300px, top=250px, left=250px, menubar=no, toolbar=no");
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
					<!-- 상품 이미지 -->
					<div class="col-md-6">

						<div id="myCarousel" class="carousel slide" data-ride="carousel">
							<!-- Indicators -->
							<ul class=carousel-indicators id="carousel-indicators">
								<%
									for (int i = 0; i < imageList.size(); i++) {
								%>
								<li data-target="#myCarousel" data-slide-to="<%=i%>"
									<%if (i == 0) {%> class="active" <%}%>></li>
								<%
									}
								%>
							</ul>

							<!-- Wrapper for slides -->
							<div class="carousel-inner" id="carousel-items">
								<%
									for (int k = 0; k < imageList.size(); k++) {
								%>
								<div class="item<%if (k == 0) {%> active<%}%>">
									<img name="photo" class="img-thumbnail"
										src="/data/<%=imageList.get(k).getFilename()%>" alt=""
										style="width: 100%;">
								</div>
								<%
									}
								%>
							</div>

							<!-- Left and right controls -->
							<a class="left carousel-control" href="#myCarousel"
								data-slide="prev"> <span
								class="glyphicon glyphicon-chevron-left"></span>
							</a> <a class="right carousel-control" href="#myCarousel"
								data-slide="next"> <span
								class="glyphicon glyphicon-chevron-right"></span>
							</a>
						</div>

					</div>

					<div class="col-md-6 fh5co-project-detail">
						<fieldset>
							<hr>
							<br>
							<h2 font-weight="bolder" font-size="30px">
								&nbsp; &nbsp;
								<%=alcohol.getName()%></h2>
							<br>
							<hr>
							<br> <br>
							<h4>
								&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
								&nbsp;상위카테고리 : <a href=""><%=alcohol.getSubcategory().getTopcategory().getName()%></a>
								</h5>
								<h4>
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp;하위카테고리 : <a href=""><%=alcohol.getSubcategory().getName()%></a>
									</h5>
									<h4>
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;도수 : <a href=""><%=alcohol.getDegree()%></a>
										</h5>
						</fieldset>
					</div>
				</div>
				<div class="row">
					<!-- 상품 소개 -->
					<div class="col-md-12 fh5co-project-detail">
						<fieldset>
							<br>
							<hr>
							<br>
							<p style="font-size: 18px;">
								&nbsp; &nbsp;
								<%=alcohol.getDetail()%></p>


							<!-- /container -->


						</fieldset>
					</div>

				</div>
			</div>
			<div class="test"></div>
			<!-- 평점과 리뷰 파트 -->
			<div class="container-wrap">
				<div id="fh5co-work">
					<div class="row">

						<h1 class="text-center">
							전체 평점 :
							<%
							for (int b = 0; b < 5; b++) {
						%>
							<%
								if (b >= scoreSetter.getRoundAverageScore()) {
							%>
							<img src="/images/star_blank.png" width="30px">
							<%
								} else {
							%>
							<img src="/images/star_f.png" width="30px">
							<%
								}
							%>
							<%
								}
							%>
							&nbsp;<%
								if (scoreSetter.getAverageScore().equals("NaN")) {
							%>
							0
							<%
								} else {
							%>
							<%=scoreSetter.getAverageScore()%>
							<%
								}
							%>
							/5.0
						</h1>
						<label></label>
						<div class="list-group">

							<!-- 리뷰 입력 -->
							<div class="row">
								<div class="media col-md-2">
									<br>
									<figure class="pull-left">
										<img class="media-object img-rounded img-responsive"
											src="http://placehold.it/350x250" alt="">
									</figure>

								</div>
								<form id="review-regist-form">
									<div class="col-md-7">
										<h4 class="list-group-item-heading"></h4>
										<input type="hidden" value="1" id="myscoreVal" name="score">
										<input type="hidden" value="<%=alcohol.getAlcohol_id()%>"
											name="alcohol_id">
										<textarea id="title" name="title" rows="1"
											class="form-control textarea" style="resize: none;"
											onkeyup="viewLimit(this,50)" placeholder="리뷰 제목을 작성해주세요."></textarea>
										<textarea id="detail" name="detail" rows="4"
											onkeyup="viewLimit(this,200)" class="form-control textarea"
											style="resize: none;" placeholder="리뷰를 작성해주세요."></textarea>
										<span id="counter">(0/200)</span>
									</div>
								</form>
								<div class="col-md-2 text-center">
									<div class="stars">
										<!-- 여기에 평점 매기는 장치 들어올 예정 -->
										<%
											for (int i = 0; i < 5; i++) {
												if (i == 0) {
										%>
										<img src="/images/star_f.png" name="star" width="20px"
											style="cursor: pointer;" onClick="refreshScore(<%=i + 1%>)">
										<%
											} else {
										%>
										<img src="/images/star_blank.png" name="star" width="20px"
											style="cursor: pointer;" onClick="refreshScore(<%=i + 1%>)">
										<%
											}
											}
										%>
									</div>
									<p id="myscore">
										1 <small> / </small> 5
									</p>
									<button type="button" class="btn btn-primary btn-lg btn-block"
										<%if (loginMember == null) {%> onClick="loginAlert()"
										<%} else {%> onClick="registReview()" <%}%>>리뷰 등록</button>
								</div>
							</div>
							<br>
							<hr>
							<!-- 리뷰 출력 -->
							<%
								int num = pager.getNum();
							%>
							<%
								int curPos = pager.getCurPos();
							%>
							<%
								for (int i = 0; i < pager.getPageSize(); i++) {
							%>
							<%
								if (num < 1)
										break;
							%>
							<%
								num--;
							%>
							<%
								Review review = reviewList.get(curPos++);
							%>
							<div class="row">
								<%
									if (loginMember != null) {
								%>
								<%
									if (loginMember.getMember_id() == review.getMember().getMember_id()) {
								%>
								<button type="button" class="close" style="width: 20px;"
									onclick="deleteReview(<%=review.getReview_id()%>)">&times;</button>
								<%
									}
								%>
								<%
									}
								%>
								<div class="media col-md-2">
									<br>
									<figure class="pull-left">
										<label class="list-group-item-text" style="font-size: 30px;"><%=review.getMember().getId()%></label>
									</figure>
								</div>
								<div class="col-md-7">
									<h4 class="list-group-item-heading"><%=review.getTitle()%></h4>
									<br>
									<p class="list-group-item-text"><%=review.getDetail()%></p>
								</div>
								<div class="col-md-2 text-center">
									<div class="stars">
										<%
											for (int k = 0; k < 5; k++) {
										%>
										<%
											if (k >= review.getScore()) {
										%>
										<img src="/images/star_blank.png" width="20px">
										<%
											} else {
										%>
										<img src="/images/star_f.png" width="20px">
										<%
											}
										%>
										<%
											}
										%>
									</div>
									<p>
										평점
										<%=review.getScore()%>
										<small> / </small> 5
									</p>
									<button type="button" class="btn btn-primary btn-lg btn-block"
										<%if (loginMember == null) {%> onClick="loginAlert()"
										<%} else {%> onClick="report()" <%}%>>신고하기</button>
								</div>
							</div>
							<hr>

							<%
								}
							%>
							<div class="col-md-5"></div>
							<span> <%
 	for (int i = pager.getFirstPage(); i < pager.getLastPage(); i++) {
 %> <%
 	if (i > pager.getTotalPage())
 			break;
 %> <a href="/alcohols/<%=alcohol.getAlcohol_id()%>?currentPage=<%=i%>"
								style="<%if (i == pager.getCurrentPage()) {%>font-size:30px;font-weight:bold;<%} else {%>font-size:20px;<%}%>">
									[<%=i%>]
							</a> <%
 	}
 %>
							</span>
						</div>

					</div>
				</div>
			</div>
		</div>

		<form id="review-delete-form">
			<input type="hidden" value="" name="review_id">
		</form>

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