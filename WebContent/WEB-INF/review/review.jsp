<%@page import="com.drunkenbros.common.Pager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.drunkenbros.model.domain.Alcohol"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	Pager pager = (Pager) request.getAttribute("pager");
%>
<!-- 페이저는 : ${pager} <br>
알콜 리스트는 : ${alcoholList} -->
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<style>
body {
	background-color: #f5f5f5;
}

.in-line {
	width: 450px;
	height: 40px;
}

input {
	margin: 0;
}

input[type="text"] {
	width: 80%;
	height: 100%;
	border: 1px solid;
	font-size: 1em;
	padding-left: 5px;
	font-style: oblique;
	display: inline;
	outline: none;
	box-sizing: border-box;
	color: black;
}

input[type=button] {
	width: 20%;
	height: 100%;
	background-color: black;
	border: 1px solid;
	background-color: #ECECEC;
	font-size: 1em;
	color: black;
	outline: none;
	display: inline;
	margin-left: -10px;
	box-sizing: border-box;
}

input[type=button]:hover {
	background-color: #1B1B1B;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
		$("input[name='bt_search']").click(function() {
			search();
		});
		$("input[name='searchWord']").keyup(function() {
			if (event.keyCode == '13') {
				search();
			}
		});
	});

	function search() {
		var searchWord = $("input[name='searchWord']").val();
		if (searchWord == "") {
			alert("검색어를 입력해주세요.");
		}
		location.href = "/alcohols/search?searchWord=" + searchWord;

	}
</script>
</head>
<body>
	<!-- 로딩될 때 뜨는 페이지 -->
	<div class="fh5co-loader"></div>

	<!-- 본 페이지 -->
	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>

		<div class="container-wrap">

			<div id="fh5co-blog">
				<div class="row">

					<c:set var="num" value="${pager.num}" />
					<!-- 여기는 num 필요 없는거 아님? ㅋ -->
					<c:set var="curPos" value="${pager.curPos}" />
					<!-- alcoholList for문 돌리기 시작! -->
					<c:forEach var="alcohol" items="${alcoholList}"
						begin="${pager.curPos}" end="${pager.curPos+pager.pageSize-1}">

						<div class="col-md-4">
							<div class="fh5co-blog animate-box">

								<!-- 이미지, 최종적으로 슬라이드로 구현 예정 -->
								<c:set var="imageEaChecker" value="${1}" />
								<c:forEach var="alcoholImage"
									items="${alcohol.alcoholImageList}">
									<c:if test="${imageEaChecker == 1}">
										<!-- 링크 누를때마다 hit(조회수) 오르도록 만들 것 -->
										<a href="/alcohols/${alcohol.alcohol_id}" class="blog-bg"
											style="background-image: url(/data/${alcoholImage.filename}); background-size: contain;"></a>
										<c:set var="imageEaChecker" value="${imageEaChecker+1}" />
									</c:if>
								</c:forEach>

								<div class="blog-text" style="border:1px solid;">
									<h3 style="text-align: center; overflow: hidden; height: 50px;">
										<a href="/alcohols/${alcohol.alcohol_id}">${alcohol.name}</a>
									</h3>
									<hr style="border: 1px solid;">
									<p
										style="overflow: hidden; width: 100%; height: 100px; text-overflow: ellipsis;">${alcohol.detail}</p>
									<ul class="stuff">
										<li><i class="icon-heart3"></i>${alcohol.score}</li>
										<li><i class="icon-eye2"></i>${alcohol.hit}</li>
										<li><a href="/alcohols/${alcohol.alcohol_id}">Read
												More<i class="icon-arrow-right22"></i>
										</a></li>
									</ul>
								</div>
							</div>
						</div>
					</c:forEach>
					<!-- End of For -->
				</div>
			</div>
		</div>
		<!-- 검색 Container -->
		<div class="container-wrap">
			<div id="fh4co-work" style="height: 150px;">
				<div class="row">
					<div style="height: 25px;"></div>
				</div>
				<div class="row">
					<!-- Search form -->
					<div class="col-md-2"></div>

					<div class="col-md-7" style="float: none; margin: auto;">
						<!-- start 페이져 Area -->
						<!-- Previous Page 화살표 -->
						<div class="blog-pagination justify-content-center d-flex"
							style="float: none; margin: auto;">
							<ul class="pagination"
								style="float: none; margin: auto; background-color: red">
								<%
									if (pager.getFirstPage() - 1 > 0) {
								%>
								<li><a
									href="/alcohols?currentPage=<%=pager.getFirstPage() - 1%>">&laquo;</a></li>
								<%
									} else {
								%>
								<li><a href="javascript:alert('첫 페이지입니다')">&laquo;</a></li>
								<%
									}
								%>
								<!-- 페이지 숫자들 기입 -->
								<%
									for (int i = pager.getFirstPage(); i < pager.getLastPage(); i++) {
								%>
								<%
									if (i > pager.getTotalPage())
											break;
								%>
								<li
									<%if (request.getParameter("currentPage") != null
						&& Integer.parseInt(request.getParameter("currentPage")) == i) {%>
									class="active" <%}%>><a
									href="/alcohols?currentPage=<%=i%>"><%=i%></a></li>
								<%
									}
								%>

								<!-- Next Page 화살표 -->
								<%
									if (pager.getLastPage() + 1 < pager.getTotalPage()) {
								%>
								<li><a
									href="/alcohols?currentPage=<%=pager.getLastPage() + 1%>">&raquo;</a></li>
								<%
									} else {
								%>
								<li><a href="javascript:alert('마지막 페이지입니다')">&raquo;</a></li>
								<%
									}
								%>
							</ul>
						</div>
						<!-- End 페이져 Area -->
					</div>
					<div class="col-md-1"></div>
				</div>
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-9">
						<div class="in-line">
							<input type="text" name="searchWord" value=""
								placeholder="검색어를 입력해주세요."> <input type="button"
								name="bt_search" value="검색">
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

