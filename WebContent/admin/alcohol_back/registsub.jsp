<%@ page contentType="text/html; charset=UTF-8"%>
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
$(function(){
	searchTopcategory();
	$("input[type='button']").click(function(){
		//alert("버튼 클릭");
		regist();
	});
});
function searchTopcategory(){
	$.ajax({
		url:"/rest/alcohols/topcategory",
		type:"get",
		success:function(result){
			//alert(result[0].name);
			createTopcategory(result);
		}
	});
}
function createTopcategory(obj){
	for(var i=0;i<obj.length;i++){
		$("#topcategory").append("<option value='"+obj[i].topcategory_id+"'>"+"ID:"+obj[i].topcategory_id+","+obj[i].name+"</option>")
	}
}

function regist(){
	$.ajax({
		url:"/rest/alcohols/subcategory",
		type:"post",
		data:{
			topcategory_id:$("select[name='topcategory_id']").val(),
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
}

</script>
</head>
<body>

<h3>하위카테고리등록---</h3>

<div class="container">
  <form>
  	<select id="topcategory" name="topcategory_id">
  		<option value="null">상위 분류를 선택해주세요.</option>
  	</select>
    <label for="name">하위 분류 명</label>
    <input type="text" id="name" maxlength="9" name="name" placeholder="하위 분류 명">
    
    <input type="button" value="등록">
  </form>
</div>

</body>
</html>
