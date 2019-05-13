<%@page import="com.drunkenbros.model.domain.AlcoholImage"%>
<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.model.domain.Alcohol"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Alcohol alcohol = (Alcohol) request.getAttribute("alcohol");
	List<AlcoholImage> imageList = (List) request.getAttribute("imageList");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/admin/inc/head.jsp"%>
<style>
.carousel-inner img {
	width: 100%;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="/js/ckeditor/ckeditor.js"></script>
<script>
	$(function() {
		searchTopcategory();
		$("#edit_btn").click(function() {
			edit();
		});
		$("button[name='list_btn']").click(function() {
			location.href = "/admin/alcohols";
		});
		CKEDITOR.replace("detail");
	});
	function searchTopcategory() {
		$.ajax({
			url : "/rest/alcohols/topcategory",
			type : "get",
			success : function(result) {
				//alert(result[0].name);
				createTopcategory(result);
			}
		});
	}

	function searchSubcategory(obj) {
		var top_id = $("#topcategory option:selected").val();
		//alert(obj.options[obj.options.selectedIndex].val);
		//alert($("#topcategory option:selected").val());
		if (top_id == "null") {
			$("#subcategory").html(
					"<option value='null'>Please, select subcategory</option>");
		} else {
			$.ajax({
				url : "/rest/alcohols/subcategory/"
						+ $("#topcategory option:selected").val(),
				type : "get",
				success : function(result) {
					$("#subcategory").html("");
					createSubcategory(result);
				}
			});
		}
	}

	function createTopcategory(obj) {
		for (var i = 0; i < obj.length; i++) {
			$("#topcategory").append(
					"<option value='"+obj[i].topcategory_id+"'>" + obj[i].name
							+ " (고유번호 : " + obj[i].topcategory_id
							+ ") </option>")
		}
	}

	function createSubcategory(obj) {
		$("#subcategory").append(
				"<option value='null'>Please, select subcategory</option>");
		for (var i = 0; i < obj.length; i++) {
			$("#subcategory")
					.append(
							"<option value='"+obj[i].subcategory_id+"'>"
									+ obj[i].name + "(고유번호 : "
									+ obj[i].subcategory_id + ")</option>")
		}
	}

	function edit() {
		$("form").attr({
			method : "post",
			action : "/admin/alcohols/edit/" + $("#alcohol_id").val()
		});
		$("form").submit();
	}

	/*******************************************************************
	 *                               이미지 슬라이드 관련 !!!
	 *******************************************************************/
	function addPhoto(obj) {
		var path = URL.createObjectURL(obj.files[0]);
		$("#carousel-items").html("");
		$("#carousel-indicators").html("");
		//첫번째 사진은 활성화로 갱신
		$("#carousel-items")
				.append(
						"<div class='item active'><img class='img-thumbnail' src='"
								+ path
								+ "' style='width: 100%;height: 300px;'/></div>");
		$("#carousel-indicators")
				.append(
						"<li data-target='#myCarousel' data-slide-to='0' class='active'></li>");
		for (var i = 1; i < obj.files.length; i++) {
			path = URL.createObjectURL(obj.files[i]);
			$("#carousel-items").append(
					"<div class='item'><img class='img-thumbnail' src='" + path
							+ "' style='width: 100%;height: 300px;'/></div>");
			$("#carousel-indicators")
					.append(
							"<li data-target='#myCarousel' data-slide-to='"+i+"'></li>");
		}
	}
</script>
</head>

<body class="">
	<div class="wrapper ">
		<%@ include file="/admin/inc/sidebar.jsp"%>
		<div class="main-panel">
			<!-- Navbar -->
			<%@ include file="/admin/inc/navi.jsp"%>
			<!-- End Navbar -->
			<!-- <div class="panel-header panel-header-sm">
  
  
</div> -->
			<div class="content">
				<div class="row">
					<div class="col-md-3">

						<div id="myCarousel" class="carousel slide" data-ride="carousel"
							style="width: 100%;">
							<!-- Indicators -->
							<ol class="carousel-indicators" id="carousel-indicators">
								<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
								<%
									for (int i = 1; i < imageList.size(); i++) {
								%>
								<li data-target="#myCarousel" data-slide-to="<%=i%>"></li>
								<%
									}
								%>

							</ol>

							<!-- Wrapper for slides -->
							<div class="carousel-inner" id="carousel-items">
								<%
									for (int i = 0; i < imageList.size(); i++) {
								%>
								<%
									AlcoholImage image = imageList.get(i);
								%>
								<%
									if (i == 0) {
								%>
								<div class="item active">
									<img name="photo" class="img-thumbnail"
										src="/data/<%=imageList.get(0).getFilename()%>" alt=""
										style="width: 100%; height: 300px;">
								</div>
								<%
									} else {
								%>
								<div class="item">
									<img name="photo" class="img-thumbnail"
										src="/data/<%=image.getFilename()%>" alt=""
										style="width: 100%; height: 300px;">
								</div>
								<%
									}
								%>
								<%
									}
								%>

							</div>

							<!-- Left and right controls -->
							<a class="left carousel-control" href="#myCarousel"
								data-slide="prev"> <span
								class="glyphicon glyphicon-chevron-left"></span> <span
								class="sr-only">Previous</span>
							</a> <a class="right carousel-control" href="#myCarousel"
								data-slide="next"> <span
								class="glyphicon glyphicon-chevron-right"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>

					</div>

					<div class="col-md-8">
						<div class="card card-user">
							<div class="card-header">
								<h5 class="card-title">술 세부 정보</h5>
								<input type="hidden" id="alcohol_id" name="alcohol_id"
									value="<%=alcohol.getAlcohol_id()%>" />
							</div>
							<div class="card-body">
								<form enctype="multipart/form-data">
									<div class="row">

										<div class="col-md-5 pr-1">
											<div class="form-group">
												<label>술 이름</label> <input type="text" class="form-control"
													name="name" placeholder="Input Alcohol's Name"
													value="<%=alcohol.getName()%>">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label for="topcategory">Top 카테고리</label> <select
													class="form-control" onchange="searchSubcategory(this)"
													id="topcategory" name="topcategory_id"
													style="font-size: 14px; height: 50px;">
													<option
														value="<%=alcohol.getSubcategory().getTopcategory().getTopcategory_id()%>"><%=alcohol.getSubcategory().getTopcategory().getName()%></option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label for="subcategory">Sub 카테고리</label> <select
													class="form-control" id="subcategory" name="subcategory_id"
													style="font-size: 14px; height: 50px;">
													<option
														value="<%=alcohol.getSubcategory().getSubcategory_id()%>"><%=alcohol.getSubcategory().getName()%></option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label for="degree">Degree</label> <input type="text"
													id="degree" name="degree" class="form-control"
													placeholder="Input Degree" value="<%=alcohol.getDegree()%>">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="">
												<label>Image</label> <input type="file" name="myFiles" accept="image/*"
													class="form-control" onchange="addPhoto(this)" multiple></input>
											</div>
										</div>
									</div>
									<div class="form-group"></div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label for="detail">세부정보</label>
												<textarea id="detail" name="detail"
													class="form-control textarea" placeholder="Input Details"><%=alcohol.getDetail()%></textarea>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="update ml-auto mr-auto">
											<button type="button" class="btn btn-primary btn-round"
												data-toggle="modal" data-target="#editModal">수정하기</button>
											<button type="button" name="list_btn"
												class="btn btn-primary btn-round">돌아가기</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

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
							<p>크리스탈</p>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-primary btn-round"
								id="edit_btn" value="Edit">
							<button type="button" class="btn btn-primary btn-round"
								data-dismiss="modal">Close</button>
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