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

function searchSubcategory(obj){
	var top_id = $("#topcategory option:selected").val();
	//alert(obj.options[obj.options.selectedIndex].val);
	//alert($("#topcategory option:selected").val());
	if(top_id=="null"){
		$("#subcategory").html("<option value='null'>하위 분류를 선택해주세요.</option>");
	}else{
		$.ajax({
			url:"/rest/alcohols/subcategory/"+$("#topcategory option:selected").val(),
			type:"get",
			success:function(result){
				//alert(result[0].topcategory.topcategory_id);
				$("#subcategory").html("");
				createSubcategory(result);
			}
		});
	}
}

function createTopcategory(obj){
	for(var i=0;i<obj.length;i++){
		$("#topcategory").append("<option value='"+obj[i].topcategory_id+"'>"+"ID:"+obj[i].topcategory_id+","+obj[i].name+"</option>")
	}
}

function createSubcategory(obj){
	$("#subcategory").append("<option value='null'>Please, select subcategory</option>");
	for(var i=0;i<obj.length;i++){
		$("#subcategory").append("<option value='"+obj[i].subcategory_id+"'>"+"Top-ID:"+obj[i].topcategory.topcategory_id+",Sub-ID:"+obj[i].subcategory_id+","+obj[i].name+"</option>")
	}
}

function regist(){
	$("form").attr({
		method:"post",
		action:"/admin/alcohols/regist"
	});
	$("form").submit();
}

</script>
</head>
<body>

<h3>술 등록---</h3>

<div class="container">
  <form enctype="multipart/form-data">
  	<select onchange="searchSubcategory(this)" id="topcategory" name="topcategory_id">
  		<option value="null">상위 분류를 선택해주세요.</option>
  	</select>
  	<select id="subcategory" name="subcategory_id">
  		<option value="null">하위 분류를 선택해주세요.</option>
  	</select>
    <label for="name">술 이름</label>
    <input type="text" id="name" maxlength="9" name="name" placeholder="술 이름">
    <label for="degree">술 도수</label>
    <input type="text" id="degree" maxlength="9" name="degree" placeholder="술 도수">
    
    <input type="file" name="myFile"/>
    <br>
    <label for="detail">상세 설명</label>
    <textarea id="detail" name="detail" placeholder="상세 설명을 적어주세요." style="height:200px"></textarea>
    
    <input type="button" value="등록">
  </form>
</div>

</body>
</html>
