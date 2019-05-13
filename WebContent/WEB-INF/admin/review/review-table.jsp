<%@page import="com.drunkenbros.model.domain.Review"%>
<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.common.Pager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<Review> reviewList= (List) request.getAttribute("reviewList");
	Pager pager = (Pager) request.getAttribute("pager");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/admin/inc/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
<!--
function search(){
	var searchMode=$("select[name='searchMode']").val();
	var searchAuth=$("select[name='searchAuth']").val();
	var searchWord=$("input[name='searchWord']").val();
	
	$("input[name='search_Mode']").val(searchMode);
	$("input[name='search_Auth']").val(searchAuth);
	$("input[name='search_Word']").val(searchWord);

	//if(searchWord==""){alert("검색어를 입력해주세요.");return;}
	$("form").attr({
		action:"/admin/member/search",
		method:"post"
	}); 
	$("form").submit();
}
-->
function reviewDelete(review_id, num){
	if(confirm("리뷰NO :"+num+" - 이 리뷰를 정말 삭제하시겠습니까?")){
		location.href="/admin/review/delete?review_id="+review_id;	
	}
}
</script>
</head>
<form>
	<input type="hidden" name="search_Mode" value="">
	<input type="hidden" name="search_Auth" value="">
	<input type="hidden" name="search_Word" value="">
</form>
<body class="">
	<div class="wrapper ">
		<!-- sidebar -->
		<%@ include file="/admin/inc/sidebar.jsp"%>

		<div class="main-panel">
			<!-- Navbar -->
			<%@ include file="/admin/inc/navi.jsp"%>
			<!-- End Navbar -->
			<!-- <div class="panel-header panel-header-sm">
  
  
</div> -->
			<div class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<h4 class="card-title">리뷰 정보</h4>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table">
										<thead class=" text-primary">
											<th>No</th>
											<th>주류</th>
											<th>작성회원</th>
											<th>리뷰제목</th>
											<th>평점</th>
											<th>등록일</th>
											<th>조회수</th>
											<th>삭제</th>
										</thead>
										<!-- 일반회원 테이블 -->
										<tbody>
											<%
												int num = pager.getNum();
											%>
											<%
												int curPos = pager.getCurPos();
											%>
											<%
												for (int i = 1; i < pager.getPageSize(); i++) {
											%>
											<%
												if (num < 1)
														break;
											%>
											<%
												Review review= reviewList.get(curPos++);
											%>
											<tr>
												<td><%=num%></td>
												<td><a href="/admin/alcohols/<%=review.getAlcohol().getAlcohol_id()%>"><%=review.getAlcohol().getName()%></a></td>
												<td><a href="/admin/member/<%=review.getMember().getMember_id()%>"><%=review.getMember().getId()%></a></td>
												<td><%=review.getTitle()%></td>
												<td><%=review.getScore()%></td>
												<td><%=review.getRegdate()%></td>
												<td><%=review.getHit()%></td>
												<td><button type="button"
														class="btn btn-primary btn-round"
														onClick="reviewDelete(<%=review.getReview_id()%>, <%=num%>)">삭제</button></td>
											</tr>
											<%
													num--;
												}
											%>
											<tr>
												<td colspan="3">
													<%-- <%for (int i = pager.getFirstPage(); i <= pager.getLastPage(); i++) {%> 
														<%if (i > pager.getTotalPage())break;%> 
														<a href="/admin/member?currentPage=<%=i%>">[<%=i%>]</a> 
													<%}%> --%>
												</td>
											
												<td colspan="6">
												<div class="row">
													<div class="col-md-2">
														<div class="form-group">
															<select class="form-control" name="searchAuth">
																<option value="allMember">리뷰제목</option>
																<option value="allMember">주류번호</option>
																<option value="allMember">회원ID</option>
															</select>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group">
															<input type="text" class="form-control" name="searchWord"/>
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<button type="button" class="btn btn-primary btn-round"
																onclick="search()">검색</button>
														</div>
													</div>
														
												</div>
											</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- start 페이져 Area -->
										<!-- Previous Page 화살표 -->
				                  		<nav class="blog-pagination justify-content-center d-flex">
				                           <ul class="pagination">
				                              <%if(pager.getFirstPage()-1>0){ %>
				                                  <li><a href="/admin/topcategories?currentPage=<%=pager.getFirstPage()-1%>"><strong>&laquo;</strong></a></li>
				                               <%}else{ %>
				                                  <li><a href="javascript:alert('첫 페이지입니다')"><strong>&laquo;</strong></a></li>
				                               <%} %>
				                        <!-- 페이지 숫자들 기입 -->
				                               <%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){%>
				                        			<%if(i>pager.getTotalPage())break; %>
				                               		<li <%if(request.getParameter("currentPage") !=null && Integer.parseInt(request.getParameter("currentPage"))==i){%>class="active"<%}%>><a href="/admin/review?currentPage=<%=i%>">[<%=i %>]</a></li>
				                               <%}%>
				
				                        <!-- Next Page 화살표 -->
				                               <%if(pager.getLastPage()+1<pager.getTotalPage()){ %>
				                                  <li><a href="/admin/topcategories?currentPage=<%=pager.getLastPage()+1%>"><strong>&raquo;</strong></a></li>
				                               <%}else{ %>
				                                  <li><a href="javascript:alert('마지막 페이지입니다')"><strong>&raquo;</strong></a></li>
				                               <%} %>
				                           </ul>
				                        </nav>
	         				      <!-- End 페이져 Area -->
							</div>
							<div class="card-footer"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!--   Core JS Files   -->
	<%@ include file="/admin/inc/tail.jsp"%>
</body>

</html>