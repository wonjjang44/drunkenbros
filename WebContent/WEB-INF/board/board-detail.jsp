<%@page import="com.drunkenbros.common.Pager"%>
<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.model.domain.Comments"%>
<%@page import="com.drunkenbros.model.domain.Board"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Member loginMember=null;
	if(session.getAttribute("member")!=null){
		loginMember = (Member) session.getAttribute("member");
	}
	Board board = (Board) request.getAttribute("board");
	List<Comments> commentsList = (List) request.getAttribute("commentsList");

	Pager pager = (Pager) request.getAttribute("pager");
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<script>
	$(function() {
		getComments();

		$("input[name='bt_comment']").click(function() {
			//alert("댓글 쓸거니..?");
			insertComments();
		});

		$("input[name='bt_edit']").click(function() {
			edit();
		});

		$("input[name='bt_del']").click(function() {
			del();
		});

		$("input[name='bt_write']").click(function() {
			write();
		});

		$("input[name='bt_back']").click(function() {
			back();
		});
	});

	//원래는 aop에서 공통코드로 처리해도 되는 부분이지만 급하니 그냥 여기서 처리함
	function loginCheck() {
<%if (loginMember == null) {%>
	alert("로그인이 필요한 서비스입니다.");
		return false;
<%} else {%>
	if (
<%=loginMember.getMember_id()%>
	!= $(
				"input[name='board_member_id']").val()) {
			alert("게시글 작성자가 아닙니다.");
			return false;
		}
<%}%>
	return true;
	}

	function edit() {
		if (!loginCheck()) {
			alert("로그인 문제있음");
			return;
		}
		;

		$("form").attr({
			action : "/board/board-edit",
			method : "post"
		});
		$("form").submit();
	}

	function del() {
		if (!loginCheck()) {
			return;
		}
		;
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
		alert("write 눌렀니..?");
		$("form").attr({
			action : "board/board-regist",
			method : "get"
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
		<%if (loginMember == null) {%>
			alert("로그인이 필요합니다.");
				return;
		<%}%>
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
				location.reload();
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
		<%if(loginMember!=null){%>
			<%if(loginMember.getMember_id()!=board.getMember().getMember_id()){%>
				alert("댓글 작성자가 아닙니다.");
				return;
			<%}%>
		<%}else{%>
			alert("로그인이 필요합니다.");
		<%}%>
		confirm("댓글을 삭제하시겠습니까?");
		//여기에 삭제할 권한 있는지 체크
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

	<!-- 누락부분
		1. hidden
		2. form
	 -->

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<!-- 상세보기  -->
				<div class="row">

					<div class="col-xs-2 col-md-2"></div>
					<div class="col-xs-8 col-md-8">

						<h2 class="text-center">게시글 보기</h2>
						<p>&nbsp;</p>
						<div class="table table-responsive">
							<form>
								<input type="hidden" name="board_id"
									value="<%=board.getBoard_id()%>"> <input type="hidden"
									name="board_member_id"
									value="<%=board.getMember().getMember_id()%>"> <input
									type="hidden" name="loginMember_id"
									<%if (loginMember != null) {%>
									value="<%=loginMember.getMember_id()%>" <%}%>>
								<input type="hidden" name="title" value="<%=board.getTitle()%>">
								<input type="hidden" name="content"
									value="<%=board.getContent()%>">

								<table class="table">

									<tr>
										<th class="success">글번호</th>
										<td>No</td>
										<th class="success">조회수</th>
										<td><%=board.getHit()%></td>
									</tr>


									<tr>
										<th class="success">작성자</th>
										<td><%=board.getMember().getName()%></td>
										<th class="success">작성일</th>
										<td><%=board.getRegdate()%></td>
									</tr>

									<tr>
										<th class="success">제목</th>
										<td colspan="3"><%=board.getTitle()%></td>
									</tr>

									<tr>
										<th class="success"><br>글 내용</th>
										<td colspan="3"><br><%=board.getContent()%>
											<div style="height: 100px"></div></td>
									</tr>

									<tr>
										<td colspan="4" class="text-center"><input type="button"
											class="btn btn-success" value="답글 쓰기" onclick=""> <input
											type="button" name="bt_edit" class="btn btn-warning"
											value="수정하기"> <input type="button" name="bt_del"
											class="btn btn-danger" value="삭제하기"> <input
											type="button" name="bt_back" class="btn btn-primary"
											value="목록보기" onclick=""></td>
									</tr>

								</table>
							</form>

						</div>

					</div>

				</div>

				<!-- 댓글 폼 -->
				<div id="reply-div" class="row">
					<div class="col-md-8 col-md-push-2 animate-box">
						<!-- 댓글 입력 폼 -->
						<div class="row">
							<div class="col-md-10 col-md-push-1 animate-box">
								<label>댓글 입력</label> <input type="hidden" name="loginMember_id"
									<%if (loginMember != null) {%>
									value="<%=loginMember.getMember_id()%>" <%}%>>
								<input type="hidden" name="comments_id">
								<div class="form-group">
									<textarea name="msg" class="form-control" cols="15" rows="3"
										placeholder="댓글 입력창"></textarea>
									<input type="button" name="bt_comment" value="댓글쓰기"
										class="btn btn-primary btn-modify">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-2 col-md-2"></div>
					<div class="col-xs-8 col-md-8">
						<div class="form-group">
							<table class="table table-striped">
								<thead colspan="4">
									<th>댓글</th>
								</thead>
								<tr>
									<td width="12%">작성자</td>
									<td width="50%">댓글내용</td>
									<td width="25%">등록날짜</td>
								</tr>
								<tbody id="reply-table">
									<%
										int num = pager.getNum();
										int curPos = pager.getCurPos();
										for (int i = 1; i < pager.getPageSize(); i++) {
									%>
									<%
										if (num < 1)break;
											Comments comments = commentsList.get(curPos++);
											num--;
									%>
									<tr>
										<td width="12%"><%=comments.getMember().getId()%></td>
										<td width="50%"><%=comments.getMsg()%></td>
										<td width="20%"><%=comments.getCregdate()%></td>
										<td width='3%' onClick='commentsDel()'>X</td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
							<table class="table">
								<tr>
									<td>
										<!-- start 페이져 Area --> <!-- Previous Page 화살표 -->
										<nav class="blog-pagination justify-content-center d-flex">
											<ul class="pagination">
												<%
													if (pager.getFirstPage() - 1 > 0) {
												%>
												<li><a
													href="/board/detail?currentPage=<%=pager.getFirstPage() - 1%>">&laquo;</a></li>
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
													href="/board/detail?currentPage=<%=i%>&board_id=<%=board.getBoard_id()%>"><%=i%></a></li>
												<%
													}
												%>

												<!-- Next Page 화살표 -->
												<%
													if (pager.getLastPage() + 1 < pager.getTotalPage()) {
												%>
												<li><a
													href="/board/detail?currentPage=<%=pager.getLastPage() + 1%>">&raquo;</a></li>
												<%
													} else {
												%>
												<li><a href="javascript:alert('마지막 페이지입니다')">&raquo;</a></li>
												<%
													}
												%>
											</ul>
										</nav> <!-- End 페이져 Area -->
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<table>

				</table>
			</div>
		</div>
	<%@ include file="/inc/footer.jsp"%>
	<%@ include file="/inc/tail.jsp"%>
	</div>


</body>
</html>