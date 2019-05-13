<%@page import="com.drunkenbros.model.domain.Alcohol"%>
<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.common.Pager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Pager pager = (Pager)request.getAttribute("pager");
	List<Alcohol> alcoholList = (List)request.getAttribute("alcoholList");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/admin/inc/head.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	$("#del_btn").click(function(){
		del();
	});
});

function goRegist(){
	location.href="/admin/alcohol/regist";
}

function changeModalValue(alcohol_id){
	$("input[name='alcohol_id']").val(alcohol_id);
}

function del(){
	$("form[name='del_form']").attr({
		method:"post",
		action:"/admin/alcohols/delete/"+$("input[name='alcohol_id']").val()
	});
	$("form[name='del_form']").submit();
}
</script>
</head>

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
								<h4 class="card-title">술 정보 관리</h4>
								<button type="button" class="btn btn-primary btn-round" onClick="goRegist()">
									술 항목 추가</button>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table">
										<thead class=" text-primary">
											<th>Alcohol_id</th>
											<th>Topcategory</th>
											<th>Subcategory</th>
											<th>Name</th>
											<th>Degree</th>
											<th>삭제</th>
										</thead>
										<tbody>
										<%int num = pager.getNum(); %>
										<%int curPos = pager.getCurPos(); %>
										<%for(int i=0;i<pager.getPageSize();i++){ %>
										<%if(num<1)break; %>
										<%num--; %>
										<%Alcohol alcohol = alcoholList.get(curPos++); %>
											<tr>
												<td><%=alcohol.getAlcohol_id() %></td>
												<td><%=alcohol.getSubcategory().getTopcategory().getName() %></td>
												<td><%=alcohol.getSubcategory().getName() %></td>
												<td><a href="/admin/alcohols/<%=alcohol.getAlcohol_id()%>"><%=alcohol.getName() %></a></td>
												<td><%=alcohol.getDegree() %></td>
												<td>
												<button type="button" class="btn btn-primary btn-round" onClick="changeModalValue(<%=alcohol.getAlcohol_id()%>)" data-toggle="modal" data-target="#delModal">삭제</button>
												</td>
											</tr>
										<%} %>
									 	
									 	<!-- Modal -->
											<div id="delModal" class="modal fade" role="dialog">
												<div class="modal-dialog">
											<!-- Modal content-->
													<div class="modal-content">
													<div class="modal-header">
														<h4 class="modal-title">카테고리 삭제</h4>
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<form name="del_form">
															<input type="hidden" name="alcohol_id" value="">
															<p>삭제 하시겠습니까?</p>
														</form>
													</div>
													<div class="modal-footer">
														<input type="button" class="btn btn-primary btn-round" id="del_btn" value="Delete">
														<button type="button" class="btn btn-primary btn-round" data-dismiss="modal">Close</button>
													</div>
													</div>
												</div>
											</div>
									 	
										</tbody>
									</table>
								</div>
								<!-- start 페이져 Area -->
										<!-- Previous Page 화살표 -->
				                  		<nav class="blog-pagination justify-content-center d-flex">
				                           <ul class="pagination">
				                              <%if(pager.getFirstPage()-1>0){ %>
				                                  <li><a href="/admin/alcohols?currentPage=<%=pager.getFirstPage()-1%>"><strong>&laquo;</strong></a></li>
				                               <%}else{ %>
				                                  <li><a href="javascript:alert('첫 페이지입니다')"><strong>&laquo;</strong></a></li>
				                               <%} %>
				                        <!-- 페이지 숫자들 기입 -->
				                               <%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){%>
				                        			<%if(i>pager.getTotalPage())break; %>
				                               		<li <%if(request.getParameter("currentPage") !=null && Integer.parseInt(request.getParameter("currentPage"))==i){%>class="active"<%}%>><a href="/admin/alcohols?currentPage=<%=i%>">[<%=i %>]</a></li>
				                               <%}%>
				
				                        <!-- Next Page 화살표 -->
				                               <%if(pager.getLastPage()+1<pager.getTotalPage()){ %>
				                                  <li><a href="/admin/alcohols?currentPage=<%=pager.getLastPage()+1%>"><strong>&raquo;</strong></a></li>
				                               <%}else{ %>
				                                  <li><a href="javascript:alert('마지막 페이지입니다')"><strong>&raquo;</strong></a></li>
				                               <%} %>
				                           </ul>
				                        </nav>
	         				      <!-- End 페이져 Area -->
							</div>
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