<%@page import="com.drunkenbros.model.domain.Subcategory"%>
<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.common.Pager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Pager pager = (Pager)request.getAttribute("pager");
	List<Subcategory> subList = (List)request.getAttribute("subList");
	
	if(request.getAttribute("msg") != null ){
		String msg=(String)request.getAttribute("msg");
		out.print("<script>alert('"+msg+"');</script>");
	}
	
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/admin/inc/head.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	searchTopcategory();

	$("#regist_btn").click(function(){
		regist();
	});
	$("#edit_btn").click(function(){
		edit();
	});
	$("#del_btn").click(function(){
		del();
	});
	
});

function searchTopcategory(){
	$.ajax({
		url:"/rest/alcohols/topcategory",
		type:"get",
		success:function(result){
			createTopcategory(result);
		}
	});
}

function createTopcategory(obj){
	$("#topcategory").html("");
	$("#topcategory_modal").html("");
	for(var i=0;i<obj.length;i++){
		$("#topcategory").append("<option value='"+obj[i].topcategory_id+"'>"+obj[i].name+"</option>");
		$("#topcategory_modal").append("<option value='"+obj[i].topcategory_id+"'>"+obj[i].name+"</option>");
	}
}

function regist(){
	$("form[name='regist_form']").attr({
		method:"post",
		action:"/admin/subcategories"
	});
	$("form[name='regist_form']").submit();
}

function edit(){
	$("form[name='edit_form']").attr({
		method:"post",
		action:"/admin/subcategories/edit"
	});
	$("form[name='edit_form']").submit();
}

function del(){
	$("form[name='del_form']").attr({
		method:"post",
		action:"/admin/subcategories/delete/"+$("input[name='subcategory_id']").val()
	});
	$("form[name='del_form']").submit();
}

function changeModalValue(subcategory_id){
	$("input[name='subcategory_id']").val(subcategory_id);
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
								<h4 class="card-title">Sub Category</h4>
								
								<div class="col-md-4 pr-1">
									<div class="row">
										<div class="form-group">
											<form name="regist_form">
												<select style="font-size: 14px;height: 50px;" class="form-control" name="topcategory_id" id="topcategory">
													<option value="null">TOP 카테고리 목록</option>
												</select>
												<br>
												<input type="text" class="form-control" placeholder="신규 하위 카테고리 이름을 입력해주세요." name="name"/>
												<input type="button" id="regist_btn" class="btn btn-primary btn-round" value="Sub 카테고리 항목 추가"/>
											</form>
										</div>
								</div>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table">
										<thead class=" text-primary">
											<th>SubCategory_ID</th>
											<th>TopCategory_Name</th>
											<th>SubCategory_Name</th>
											<th>수정</th>
											<th>삭제</th>
										</thead>
										<tbody>
										<%int num = pager.getNum(); %>
										<%int curPos = pager.getCurPos(); %>
										<%for(int i=0;i<pager.getPageSize();i++){ %>
										<%if(num<1)break; %>
										<%num--; %>
										<%Subcategory subcategory = subList.get(curPos++); %>
											<tr>
												<td><%=subcategory.getSubcategory_id() %></td>
												<td><%=subcategory.getTopcategory().getName() %></td>
												<td><%=subcategory.getName() %></td>
												<td><button type="button"
														class="btn btn-primary btn-round" onClick="changeModalValue(<%=subcategory.getSubcategory_id()%>)" data-toggle="modal" data-target="#editModal">수정</button></td>
												<td><button type="button"
														class="btn btn-primary btn-round" onClick="changeModalValue(<%=subcategory.getSubcategory_id()%>)" data-toggle="modal" data-target="#delModal">삭제</button></td>
											</tr>
										<%} %>
									 	
									 	<!-- Modal -->
											<div id="editModal" class="modal fade" role="dialog">
												<div class="modal-dialog">
											<!-- Modal content-->
													<div class="modal-content">
													<div class="modal-header">
														<h4 class="modal-title">카테고리 수정</h4>
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<form name="edit_form">
															<select class="form-control" name="topcategory_id" id="topcategory_modal">
															</select>
															<input type="hidden" id="modal_subcategory_id" name="subcategory_id" value="">
															<input type="text" class="form-control" placeholder="원하는 이름을 입력해주세요." id="edit_name" name="name" maxlength="6"/>
														</form>
													</div>
													<div class="modal-footer">
														<input type="button" class="btn btn-primary btn-round" id="edit_btn" value="Edit">
														<button type="button" class="btn btn-primary btn-round" data-dismiss="modal">Close</button>
													</div>
													</div>
												</div>
											</div>
									 	
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
															<input type="hidden" name="subcategory_id" value="">
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
				                                  <li><a href="/admin/subcategories?currentPage=<%=pager.getFirstPage()-1%>"><strong>&laquo;</strong></a></li>
				                               <%}else{ %>
				                                  <li><a href="javascript:alert('첫 페이지입니다')"><strong>&laquo;</strong></a></li>
				                               <%} %>
				                        <!-- 페이지 숫자들 기입 -->
				                               <%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){%>
				                        			<%if(i>pager.getTotalPage())break; %>
				                               		<li <%if(request.getParameter("currentPage") !=null && Integer.parseInt(request.getParameter("currentPage"))==i){%>class="active"<%}%>><a href="/admin/subcategories?currentPage=<%=i%>">[<%=i %>]</a></li>
				                               <%}%>
				
				                        <!-- Next Page 화살표 -->
				                               <%if(pager.getLastPage()+1<pager.getTotalPage()){ %>
				                                  <li><a href="/admin/subcategories?currentPage=<%=pager.getLastPage()+1%>"><strong>&raquo;</strong></a></li>
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