<%@page import="com.drunkenbros.common.member.BirthSetter"%>
<%@page import="com.drunkenbros.model.domain.Member"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Member member=null;
	BirthSetter birth=null;
	if(request.getAttribute("member")!=null && request.getAttribute("birth")!=null){
		member=(Member)request.getAttribute("member");
		birth=(BirthSetter)request.getAttribute("birth");
	}
%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/admin/inc/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var bt_editFlag;
//생일 중 생일 select에 초기값이 없어서 오류났던거임!
$(function(){
	//===============
	//생년월일 초기세팅
	//===============
	initBirth();
    //===============
    //날짜 변동 체크
    //===============
	$("select[name='birthYear']").change(function() {
		setBirthDate();
	});
	$("select[name='birthMonth']").change(function() {
		setBirthDate();
	});
	//===============
    //연락처 변동 체크
    //===============
	$("input[name='phonenum']").keyup(function(){//change 말고
		//alert();
		var phonenumVal=$("input[name='phonenum']").val();
		//alert(phonenum);
		$("input[name='phonenum']").val(autoHypenPhone(phonenumVal));
	});
	//================
	//Auth 초기설정
	//================
	$("select[name='auth_id']").val("<%=member.getAuth().getAuth_id()%>");

	//================
	//Button 들 이벤트 추가
	//================
	bt_editFlag=false;
	$("button[name='bt_edit']").click(function(){
		bt_editFlag=!bt_editFlag;
		if(bt_editFlag){
			removeDisabled();
		}else{
			//controller에서 edit하도록
			memberInfoEdit();
		}
	});
	$("button[name='bt_delete']").click(function(){
		if(confirm("정말 삭제하시겠습니까?")){
			memberInfoDel();
		}
	});
	
});

//==========================================================
//회원 생년월일 초기설정
//==========================================================
function initBirth(){
	$("select[name='birthYear']").val(<%=member.getBirth().substring(0, 4)%>);
	$("select[name='birthMonth']").val(<%=member.getBirth().substring(5, 7)%>);
	$("select[name='birthDate']").val(<%=member.getBirth().substring(8, 10)%>);
	
}

//==========================================================
//수정 버튼 눌렀을 때 input창 들 활성/비활성화 시키기
//==========================================================
function removeDisabled(){
	$("input").removeAttr("disabled");
	$("select").removeAttr("disabled");
};

//==========================================================
//수정 버튼 한번 더 눌렀을 때 정보 수정
//==========================================================
function memberInfoEdit(){
	//등록하기 전에 생일 선택했는지 확인
	var birth=setBirth();
	if(birth.length<10){return}

	//이렇게 쓰는거 맞던가? 졸려서 가물가물
	$("form").attr({
		action : "/admin/member/edit",	
		method : "post"		
	});
	$("form").submit();
}

//==========================================================
//삭제 버튼 눌렀을 때 정보 삭제
//==========================================================
function memberInfoDel(){
	$("form").attr({
		action : "/admin/member/delete",	
		method : "post"		
	});
	$("form").submit();
}
//=========================================================================
// 연락처 input 태그의 입력값을 받아와 (1) 숫자만 입력되게 하고, (2) 숫자 사이사이에 (-) 삽입되도록 함
//=========================================================================
function autoHypenPhone(str) {
	str = str.replace(/[^0-9]/g, '');
	var tmp = '';
	if (str.length < 4 || str.length >14) {
		return str;
	} else if (str.length < 7) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3);
		return tmp;
	} else if (str.length < 11) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 3);
		tmp += '-';
		tmp += str.substr(6);
		return tmp;
	} else {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 4);
		tmp += '-';
		tmp += str.substr(7);
		return tmp;
	}
	return str;
}
//==========================================================
//생일 select의 date값을 변경하기 위한 함수 - 왜? 2월달 떄문에 ㄱ-
//==========================================================
function setBirthDate() {
	var year = $("select[name='birthYear']").val();
	var month = $("select[name='birthMonth']").val();
	if (year != "생월" && month != "생월") {
		year = parseInt(year);
		month = parseInt(month);
		//alert(year+", "+month);

		$.ajax({
			url : "/member-regist/setBirthDate",
			type : "get",
			data : {
				year : year,
				month : month
			},
			success : function(result) {
				var optionSize = $("select[name='birthDate'] option").length;
				for (var i = 0; i < optionSize; i++) {
					$("select[name='birthDate'] option:first").remove();
				} 
				for (var i = 0; i < result.length; i++) {
					$("select[name='birthDate']").append(
							"<option>" + result[i] + "</option>");
				}
			}
		});
	}
}

//==========================================================
//생년월일 select 하나로 합쳐줌. 수정할 때 사용할 것
//==========================================================
function setBirth(){
	var year=$("select[name='birthYear']").val();
	var month=$("select[name='birthMonth']").val();
	var date=$("select[name='birthDate']").val();
	var birth=year+"-"+month+"-"+date; 
	$("input[name='birth']").val(birth);
	return birth;
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
					<div class="col-md-8">
						<div class="card card-user">
							<div class="card-header">
								<h5 class="card-title">회원 상세 정보</h5>
							</div>
							<div class="card-body">
								<form>
									<div class="row">
										<input type="hidden" name="member_id" value="<%=member.getMember_id()%>"/>
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label>ID</label> <input type="text"
													class="form-control" placeholder="ID를 입력해주세요." name="id"
													disabled value="<%=member.getId()%>">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label>Password</label> <input type="text"
													class="form-control" placeholder="비밀번호를 입력해주세요." name="pass"
													disabled value="<%=member.getPass()%>">
											</div>
										</div>
									</div>
									<%-- <div class="row">	
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<input type="hidden"
													class="form-control" placeholder="비밀번호를 위와 같이 입력해주세요."  name="pass2"
													disabled value="<%=member.getPass()%>">
											</div>
										</div>
									</div> --%>
									<!-- <div class="row">
										<div class="col-md-8 pr-1">
											<div class="alert alert-success" id="alert-success" visibility:hidden>
											비밀번호가 일치합니다.</div>
											<div class="alert alert-danger" id="alert-danger" visibility:hidden>
											비밀번호가일치하지 않습니다.</div>
										</div>
									</div> -->
									<div class="row">
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label>이름</label> <input
													type="text" class="form-control" placeholder="이름을 입력해주세요."
													disabled name="name" value="<%=member.getName()%>">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label>Email</label> <input type="text"
													class="form-control" placeholder="E-mail을 입력해주세요." 
													disabled name="email"value="<%=member.getEmail()%>">
											</div>
										</div>
									</div>
									<div class="row">	
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label>연락처</label> <input type="text" 
													class="form-control" placeholder="연락처를 입력해주세요." maxlength='13'
													disabled name="phonenum" value="<%=member.getPhonenum()%>">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-3">
											<div class="form-group">
												<label>생년</label>
												<select class="form-control" name="birthYear" disabled>
													<%for (int i = 0; i < birth.getYearList().size(); i++) {%>
													<option value="<%=birth.getYearList().get(i)%>"><%=birth.getYearList().get(i)%></option>
													<%}%>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<label>생월</label>
												<select class="form-control" name="birthMonth" disabled>
													<%for (int i = 0; i < birth.getMonthList().size(); i++) {%>
													<option value="<%=birth.getMonthList().get(i)%>"><%=birth.getMonthList().get(i)%></option>
													<%}%>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">		
												<label>생일</label>							
												<select class="form-control" name="birthDate" disabled>
													<%for(int i=1; i<=31; i++){ %>
														<% if(i<10){%>
															<option value="<%="0"+i%>"><%="0"+i%></option>
														<%}else{%>
															<option value="<%=i%>"><%=i%></option>
														<%}%>
													<%} %>
												</select>
											</div>
										</div>
										<input type="hidden" name="birth" id="birth"/>
									</div>
									<div class="row">
										<div class="col-md-5">
											<div class="form-group">
												<label>권한</label> 
												<select class="form-control" name="auth_id" id="auth_id" disabled>
													<option value="1">총관리자</option>
													<option value="2">부관리자(회원,사이트관리)</option>
													<option value="3">부관리자(사이트관리)</option>
													<option value="4">일반회원</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="update ml-5 mr-5">
											<button type="button" class="btn btn-primary btn-round" name="bt_edit">
												수정</button>
											<button type="button" class="btn btn-primary btn-round" name="bt_delete">
												삭제</button>
										</div>
									</div>
								</form>
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