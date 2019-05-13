<%@page import="com.drunkenbros.model.domain.Board"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	String board_id=request.getParameter("board_id");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	$("input[type='button']").click(function(){
		edit();
	});
});

function edit(){
	$("form").attr({
		action:"/board/edit",
		method:"POST"
	});
	$("form").submit();
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
                  <h1>게시글 수정</h1>
               </div>
            </div>
            <form>
	            <div class="row">
	               <div class="col-md-12 col-md-push-1 animate-box">
	                  <div class="row">
	                     <div class="col-md-2">
	                        <div class="form-group">
	                           <select class="form-control" placeholder="태그">
	                              <option>공지</option>
	                           
	                              <option>자유</option>
	                              <option>질문</option>
	                           </select>
	                        </div>
	                     </div>
	                     <div class="col-md-7">
	                        <div class="form-group">
	                           <input type="text" class="form-control" placeholder="글제목" name="title" value="<%=title%>">
	                           <input type="hidden" name="board_id" value="<%=board_id %>">
	                        </div>
	                     </div>
	                  </div>
	                  <div class="row">
	                     <div class="col-md-10">
	                        <div class="form-group">
	                           <textarea name="content" class="form-control" cols="30" rows="20"
	                              placeholder="글을 쓰시오"><%= content%></textarea>
	                        </div>
	                     </div>
	                     <div class="col-md-10">
	                        <div class="form-group">
	                           <input type="button" name="bt_regist" value="수정완료"
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