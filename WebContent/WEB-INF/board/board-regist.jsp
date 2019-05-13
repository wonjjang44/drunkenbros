<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Member loginMember = (Member) session.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
		$($("input[type='button']")[0]).click(function() {
			regist();
		});
	});

	$(function() {
		$($("input[type='button']")[1]).click(function() {
			back();
		});
	});

	function regist() {
		$("form").attr({
			action : "/board/regist",
			method : "post"
		});
		$("form").submit();
	}

	function back() {
		if (confirm("사이트에서 나가시겠습니까?\n\n변경사항이 저장되지 않을 수 있습니다.") == true) {
			location.href = "/boards";
		}
	}
</script>
</head>
<body>
	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row animate-box">
					<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
						<h1>게시글 등록</h1>
					</div>
				</div>
				<form>
					<div class="row">
						<div class="col-md-12 col-md-push-1 animate-box">
							<input type="hidden" name="member_id" value="<%=loginMember.getMember_id()%>">
							<div class="row">
								<div class="col-md-2">
									<div class="form-group">
										<select class="form-control">
											<option>태그</option>
											<option>공지</option>
											<option>자유</option>
											<option>질문</option>
										</select>
									</div>
								</div>

								<div class="col-md-7">
									<div class="form-group">
										<input type="text" name="title" class="form-control"
											placeholder="제목">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-10">
									<div class="form-group">
										<textarea name="content" class="form-control" id="" cols="30"
											rows="20" placeholder="게시글을 작성해주세요."></textarea>
									</div>
								</div>
							</div>
							 <div class="row">
								<div class="col-md-10">
									<div class="form-group">
										<input type="button" name="bt_regist" value="글쓰기"
											class="btn btn-primary btn-modify"> 
										<input type="button" name="bt_back" value="목록"
											class="btn btn-primary btn-modify">
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>

		<%@ include file="/inc/footer.jsp"%>
		<%@ include file="/inc/tail.jsp"%>
	</div>
</body>
</html>