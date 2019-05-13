<%@page import="com.drunkenbros.model.domain.Topcategory"%>
<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.common.Pager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Pager pager = (Pager)request.getAttribute("pager");
	List<Topcategory> topList = (List)request.getAttribute("topList");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/admin/inc/head.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	//getListAsync();
	
	$("#add_btn").click(function(){
		regist();
	});
	$("#edit_btn").click(function(){
		edit();
	});
	$("#del_btn"	).click(function(){
		del();
	});
	
});
function regist(){
	$("form[name='add_form']").attr({
		method:"post",
		action:"/admin/topcategories"
	});
	$("form[name='add_form']").submit();
	
	/*
	$.ajax({
		url:"/rest/alcohols/topcategory",
		type:"post",
		data:{
			name:$("input[name='name']").val()
		},
		success:function(result){
			if(result.code==1){
				alert("등록 성공");
			}else{
				alert("등록 실패");
			}
		}
	});
	getListAsync();
	*/
}

function changeModalValue(topcategory_id){
	$("input[name='topcategory_id']").val(topcategory_id);
}

function edit(){
	$("form[name='edit_form']").attr({
		method:"post",
		action:"/admin/topcategories/edit"
	});
	$("form[name='edit_form']").submit();
}

function del(){
	$("form[name='del_form']").attr({
		method:"post",
		action:"/admin/topcategories/delete/"+$("input[name='topcategory_id']").val()
	});
	$("form[name='del_form']").submit();
}

/************************************현재 사용 안하는 로직************************************
function getListAsync(){
	$.ajax({
		url:"/rest/alcohols/topcategory",
		type:"get",
		success:function(result){
			var str = "";
			$("#myTbody").html("");
			for(var i=0;i<result.length;i++){
				str += "<tr>";
				str += "<td>"+result[i].topcategory_id+"</td>";
				str += "<td>"+result[i].name+"</td>";
				str += "<td><button type='button' class='btn btn-primary btn-round'>수정</button></td>";
				str += "<td><button type='button' class='btn btn-primary btn-round'>삭제</button></td>";
				str += "</tr>";
			}
				$("#myTbody").append(str);
		}
	});
}
*************************************************************************************/
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
								<h4 class="card-title">Top Category</h4>
								<div class="col-md-4 pr-1">
									<div class="form-group">
										<form name="add_form">
											<input type="text" class="form-control" placeholder="신규 상위 카테고리 이름을 입력해주세요." name="name"/>
											<input type="button" class="btn btn-primary btn-round" id="add_btn" value="Top 카테고리 항목 추가"/>
										</form>
									</div>
								</div>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table">
										<thead class=" text-primary">
											<th>TopCategory_id</th>
											<th>Name</th>
											<th>수정</th>
											<th>삭제</th>
										</thead>
										<tbody id="myTbody">
										<%int num = pager.getNum(); %>
										<%int curPos = pager.getCurPos(); %>
										<%for(int i=0;i<pager.getPageSize();i++){ %>
										<%if(num<1)break; %>
										<%num--; %>
										<%Topcategory topcategory=topList.get(curPos++); %>
										<tr>
											<td><%=topcategory.getTopcategory_id() %></td>
											<td><%=topcategory.getName() %></td>
											<td><button type="button" class="btn btn-primary btn-round" onClick="changeModalValue(<%=topcategory.getTopcategory_id()%>)" data-toggle="modal" data-target="#editModal">
											수정</button></td>
											<td><button type="button" class="btn btn-primary btn-round" onClick="changeModalValue(<%=topcategory.getTopcategory_id()%>)" data-toggle="modal" data-target="#delModal">
											삭제</button></td>
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
															<input type="hidden" id="modal_topcategory_id" name="topcategory_id" value="">
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
															<input type="hidden" name="topcategory_id" value="">
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
				                                  <li><a href="/admin/topcategories?currentPage=<%=pager.getFirstPage()-1%>"><strong>&laquo;</strong></a></li>
				                               <%}else{ %>
				                                  <li><a href="javascript:alert('첫 페이지입니다')"><strong>&laquo;</strong></a></li>
				                               <%} %>
				                        <!-- 페이지 숫자들 기입 -->
				                               <%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){%>
				                        			<%if(i>pager.getTotalPage())break; %>
				                               		<li <%if(request.getParameter("currentPage") !=null && Integer.parseInt(request.getParameter("currentPage"))==i){%>class="active"<%}%>><a href="/admin/topcategories?currentPage=<%=i%>">[<%=i %>]</a></li>
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