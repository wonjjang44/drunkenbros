<%@page import="com.drunkenbros.model.domain.Board"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Board board=(Board)request.getAttribute("board");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=button] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=button]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$($("input[type='button']")[0]).click(function(){
	
});
$($("input[type='button']")[1]).click(function(){
	edit();
});

$($("input[type='button']")[2]).click(function(){
	del();
});

$($("input[type='button']")[3]).click(function(){
	getBoard();
});

function edit(){
	$("form").attr({
		action:"/board",
		method:"post"
	});
	$("form").submit();
}

function del(){
	if(!confirm("게시글을 삭제하시겠습니까?")){
		return;
	}
	$.ajax({
		url:"/board/delete",
		type:"get",
		data:{
			board_id:$("form[name=]")
		}
	});
}

function getBoard(){
	$("form").attr({
		
	});
}
</script>
</head>
<body>

<h3>임시 디테일</h3>

<div class="container">
  <form>
    <label></label>
    <input type="text" name="title"  placeholder="게시글 제목을 입력하세요" value=<%=board.getTitle() %>>
    <textarea id="subject" name="content" style="height:200px" placeholder="내용을 입력하세요" ><%=board.getContent() %></textarea>
    <input type="button" value="글쓰기">
    <input type="button" value="수정">
    <input type="button" value="삭제">
    <input type="button" value="목록">

  </form>
</div>

</body>
</html>
