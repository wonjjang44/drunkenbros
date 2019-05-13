<%@page import="com.drunkenbros.common.Pager"%>
<%@page import="com.drunkenbros.model.domain.Board"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Member loginMember = (Member) session.getAttribute("member");
	List<Board> boardList=boardList=(List)request.getAttribute("boardList");
	//out.print("게시물의 갯수는? : "+boardList.size());
	Pager pager = (Pager)request.getAttribute("pager");
%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<style>
table{
	margin-left:auto;
	margin-right:auto;
	vertical-align:middle;
}

</style>
</head>
<style>
#textScan{
	width:250px;
	heigth:30px;
	font-size:15px;
}
#scan{
	width:100px;
	height:50px;
	font-size:15px;
}
#scanButton{

}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	
});
//글쓰기 버튼
$(function(){
	$($("input[type='button']")[1]).click(function(){
		<%if(loginMember==null){%>
			alert("로그인이 필요한 페이지입니다.");
			return;
		<%}%>
		location.href="/board/board-regist";
	});
});
//검색 버튼
$(function(){
	$($("input[type='button']")[0]).click(function(){
		var msg=$("input[name='searching']").val();
		var searchMode=$("select[name='selectEffect']").val();
		//alert(msg);
		//alert(searchMode);
		if(searchMode=="title_content"){
			search_TC(msg);	
		}else if(searchMode=="title"){
			search(msg);	
		}else if(searchMode=="writer"){
			search_writer(msg);
		}else if(searchMode=="content"){
			search_comment(msg);
		}else if(searchMode=="cWriter"){
			search_cWriter(msg);
		}
	});
});

//제목+내용 검색
function search_TC(msg){
	$("form[name='searchForm']").attr({
		action:"/board/search_TC",
		method:"get"
	});
	$("form[name='searchForm']").submit();
}

//제목 검색
function search(msg){
	//alert(msg);
	//alert("검색 할거니..?");
	$("form[name='searchForm']").attr({
		action:"/board/search",
		method:"get"
	});
	$("form[name='searchForm']").submit();
}

//글작성자 검색
function search_writer(msg){
	alert("나 호출 했니..? 1");
	$("form[name='searchForm']").attr({
		action:"/board/search_writer",
		method:"get"
	});
	$("form[name='searchForm']").submit();
}

//댓글내용 검색
function search_content(msg){
	alert("나 호출 했니..? 2");
	$("form[name='searchForm']").attr({
		action:"/board/search_content",
		method:"get"
	});
	$("form[name='searchForm']").submit();
}

//댓글 작성자 검색
function search_cWriter(msg){
	alert("나 호출 했니..? 3");
	$("form[name='searchForm']").attr({
		action:"/board/search_cWriter",
		method:"get"
	});
	$("form[name='searchForm']").submit();
}


</script>
<body>

	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			
			<div id="fh5co-about">

				<div class="row">

					<div class="col-md-10 col-md-offset-1 text-center animate-box">
						<div class="about-desc">
							<h3>Bros 게시판</h3>
							<p>자유게시판입니다.</p>
						</div>
						<!-- 게시판 양식 만들어보자 -->
						<table class="table table-hover" style="text-align:center;">
							<thead>
									<tr>
										<th scope="col" width="10%" style="text-align: center;">번호</th>
										<th scope="col" width="45%" style="text-align: center;">제목</th>
										<th scope="col" width="20%" style="text-align: center;">글쓴이</th>
										<th scope="col" width="15%" style="text-align: center;">날짜</th>
										<th scope="col" width="10%" style="text-align: center;">조회수</th>
									</tr>
							</thead>
							<tbody>
								<% int num=pager.getNum(); %>
								<% int curPos=pager.getCurPos(); %>
								<%for(int i=0;i<pager.getPageSize();i++){ %>
								<%
									if(num<1)break;
									Board board=(Board)boardList.get(curPos++); 
									// System.out.println(i+" 번째 board_id : "+board.getBoard_id());
								%>
									<tr class="table-active">
										<td><%=num-- %></td>
							   <%-- <td><%=board.getBoard_id() %></td> --%>
										<td><a href="/board/detail?board_id=<%=board.getBoard_id()%>"><%=board.getTitle() %></a></td>
										<td><%=board.getMember().getName()%></td>
										<td><%=board.getRegdate().substring(0,10) %></td>
										<td><%=board.getHit() %></td>
									</tr>
									<%} %>
									<tr>
										<td colspan="5">
										<%-- 	<%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){ %>
											<%if(i>pager.getTotalPage()){break; }%>
											<a href="/boards?currentPage=<%=i%>">[<%=i %>]</a>
											<%} %> --%>
										<!-- start 페이져 Area -->
						                  <!-- Previous Page 화살표 -->
						                        <nav class="blog-pagination justify-content-center d-flex">
						                           <ul class="pagination">
						                              <%if(pager.getFirstPage()-1>0){ %>
						                                  <li><a href="/boards?currentPage=<%=pager.getFirstPage()-1%>">&laquo;</a></li>
						                               <%}else{ %>
						                                  <li><a href="javascript:alert('첫 페이지입니다')">&laquo;</a></li>
						                               <%} %>
						                        <!-- 페이지 숫자들 기입 -->
						                               <%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){%>
						                                 <%if(i>pager.getTotalPage())break; %>
						                                     <li <%if(request.getParameter("currentPage") !=null && Integer.parseInt(request.getParameter("currentPage"))==i){%>class="active"<%}%>><a href="/boards?currentPage=<%=i%>"><%=i %></a></li>
						                               <%}%>
						
						                        <!-- Next Page 화살표 -->
						                               <%if(pager.getLastPage()+1<pager.getTotalPage()){ %>
						                                  <li><a href="/boards?currentPage=<%=pager.getLastPage()+1%>">&raquo;</a></li>
						                               <%}else{ %>
						                                  <li><a href="javascript:alert('마지막 페이지입니다')">&raquo;</a></li>
						                               <%} %>
						                           </ul>
						                        </nav>
						                     <!-- End 페이져 Area -->
										</td>
									</tr>
							</tbody>
						</table>
						<div class="row">
							<form name="searchForm">
								<select id="scan" name="selectEffect">
									<option value="title_content">제목+내용</option>
									<option value="title">제목만</option>
									<option value="writer">글작성자</option>
									<option value="content">댓글내용</option>
									<option value="cWriter">댓글작성자</option>
								</select>
							
								<input type="text" placeholder="검색어를 입력해 주세요" id="textScan" name="searching">
								<!-- <input type="text" name="title" class="form-control" placeholder="글제목" id="textScan"> -->
								<input type="button" name="bt_comment" value="검색"
		                              class="btn btn-primary btn-modify" id="scanButton">
								<!-- <input type="button" value="글쓰기" id=""/> -->
								<input type="button" name="bt_write" value="글쓰기"
		                              class="btn btn-primary btn-modify">
							</form>
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

