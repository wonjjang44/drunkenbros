<%@page import="com.drunkenbros.common.Pager"%>
<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.model.domain.Comments"%>
<%@page import="com.drunkenbros.model.domain.Board"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Member loginMember = (Member) request.getSession().getAttribute("member");
	Board board = (Board) request.getAttribute("board");
	Comments comments = (Comments) request.getAttribute("comments");
	List<Comments> commentsList = (List) request.getAttribute("commentsList");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
		getComments();

		$($("input[type='button']")[0]).click(function() {
			//alert("댓글 쓸거니..?");
			$("textarea[name='msg']").text("");
			insertComments();

		});

		$($("input[type='button']")[1]).click(function() {
			edit();
		});

		$($("input[type='button']")[2]).click(function() {
			del();
		});

		$($("input[type='button']")[3]).click(function() {
			write();
		});

		$($("input[type='button']")[4]).click(function() {
			back();
		});
	});

	function edit() {
		//    alert("edit 눌렀니..?"); 
		$("form").attr({
			action : "/board-edit.jsp",
			method : "post"
		});
		$("form").submit();
	}

	function del() {
		if (!confirm("삭제 하시겠습니까??")) {
			return;
		}
		$("form").attr({
			action : "/board/delete",
			method : "post"
		});
		$("form").submit();
	}

	function write() {
		//alert("write 눌렀니..?");
		$("form").attr({
			action : "/board-regist.jsp",
			method : "post"
		});
		$("form").submit();
	}

	function back() {
		//alert("back 눌렀니..?");
		location.href = "/boards";
	}

	//댓글 전체 가져오기
	function getComments() {
		$.ajax({
			url : "/board/comments",
			type : "get",
			data : {
				board_id : $("input[name='board_id']").val()
			},
			success : function(result) {
				var json = JSON.parse(result);
				//alert(json[0].msg);
			}
		});
	}

	//댓글 한건 등록
	function insertComments() {
		$.ajax({
			url : "/board/insertComments",
			type : "post",
			data : {
				board_id : $("input[name='board_id']").val(),
				member_id : $("input[name='loginMember_id']").val(),
				msg : $("textarea[name='msg']").val()
			},
			success : function(result) {
				//alert(result);
				renderList(result);
			}
		});
	}

	//댓글 비동기로 처리
	function renderList(obj) {
		var json = JSON.parse(obj);
		//$("#reply-div").html("");
		var str = "";
		str += "<tr>";
		str += "<td width='12%'>" + json.writer + "   </td>";
		str += "<td width='75%'> " + json.msg + "</td>";
		str += "<td width='15%'>" + json.cregdate + "</td>";
		str += "<td width='3%' onClick='commentsDel()'>X</td>";
		str += "</tr>";
		$("#reply-table").append(str);
	}

	//댓글 삭제
	function commentsDel() {
		alert("나눌렀니..?");
		$.ajax({
			url : "/board/oneCommentsDel",
			type : "get",
			data : {
				comments_id : $("input[name='comments_id']").val()
			},
			success : function(result) {
				alert(result);
			}
		});
	}
</script>
<body>
	<div class="fh5co-loader"></div>

	<div id="page">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row animate-box">
					<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
						<h1>글 상세보기(수정&삭제)</h1>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 col-md-push-1 animate-box">
						<div class="row">
							<div class="col-md-2">
								<label>태그</label>
								<form>
									<div class="form-group">
										<input type="text" class="form-control" name="tag_id"
											readonly="readonly" placeholder="태그" value="<%=1%>">
										<input type="hidden" name="board_id"
											value="<%=board.getBoard_id()%>">
									</div>
							</div>
							<div class="col-md-7">
								<label>글제목</label>
								<div class="form-group">
									<input type="text" class="form-control" name="title"
										placeholder="글제목" readonly="readonly"
										value="<%=board.getTitle()%>">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-2">
								<label>글쓴이</label>
								<div class="form-group">
									<input type="text" class="form-control" name="writer"
										placeholder="글쓴이" readonly="readonly"
										value="<%=board.getMember().getName()%>">
								</div>
							</div>
							<div class="col-md-4">
								<label>등록날짜</label>
								<div class="form-group">
									<input type="text" class="form-control" readonly="readonly"
										name="regdate" placeholder="등록날짜"
										value="<%=board.getRegdate().substring(0, 10)%>">
								</div>
							</div>
							<div class="col-md-10">
								<label>글 내용</label>
								<div class="form-group">
									<textarea name="content" class="form-control" id="" cols="30"
										rows="20" placeholder="글 내용" name="content"
										readonly="readonly"><%=board.getContent()%></textarea>
								</div>
							</div>
							</form>
						</div>


						<!-- 댓글 폼 들어올 자리 -->
						<div id="reply-div" class="row">
							<div class="col-md-10">
								<div class="form-group">
									<table class="table table-hover">
										<thead colspan="4">
											<th>댓글</th>
										</thead>
										<tbody id="reply-table">
											<%
												for (int i = 0; i < commentsList.size(); i++) {
											%>
											<%
												comments = (Comments) commentsList.get(i);
											%>
											<tr>
												<td width="12%">작성자<%=comments.getMember().getName()%></td>
												<td width="75%">댓글 내용<%=comments.getMsg()%></td>
												<td width="15%">등록날짜<%=comments.getCregdate()%></td>
												<td width="3%"></td>
											</tr>
											<%
												}
											%>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 댓글 입력 폼 -->
						<div class="row">
							<div class="col-md-8">
								<label>댓글 입력</label> <input type="hidden" name="loginMember_id"
									value="<%=loginMember.getMember_id()%>"> <input
									type="hidden" name="comments_id">
								<div class="form-group">
									<textarea name="msg" class="form-control" cols="15" rows="3"
										placeholder="댓글 입력창"></textarea>
									<input type="button" name="bt_comment" value="댓글쓰기"
										class="btn btn-primary btn-modify">
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-1">
								<div class="form-group">
									<input type="button" name="bt_edit" value="수정"
										class="btn btn-primary btn-modify">
								</div>
							</div>
							<div class="col-md-1">
								<div class="form-group">
									<input type="button" name="bt_del" value="삭제"
										class="btn btn-primary btn-modify">
								</div>
							</div>
							<div class="col-md-1">
								<div class="form-group">
									<input type="button" name="bt_write" value="글쓰기"
										class="btn btn-primary btn-modify">
								</div>
							</div>

							<div class="col-md-1">
								<div class="form-group">
									<input type="button" name="bt_back" value="목록"
										class="btn btn-primary btn-modify">
								</div>

							</div>

						</div>
					</div>
				</div>
			</div>
		</div>

		<%@ include file="/inc/footer.jsp"%>
		<%@ include file="/inc/tail.jsp"%>
	</div>
</body>
</html>