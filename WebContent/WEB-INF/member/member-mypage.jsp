<%@page import="com.drunkenbros.common.member.BirthSetter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!BirthSetter birth = new BirthSetter();%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var bt_editFlag;

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
	//Button 들 이벤트 추가
	//================
	bt_editFlag=false;
	$("input[type='button']").click(function(){
		bt_editFlag=!bt_editFlag;
		if(bt_editFlag){
			removeDisabled();
		}else{
			//controller에서 edit하도록
			memberInfoEdit();
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
	//비번 글자수 체크 //비번 동일하지 않으면 가입되지 않도록 만들기
	if(!checkPassExist()){
		//비번 글자수 부족
		alert("새로운 비밀번호를 6글자 이상 입력해주세요.");
		return;
	}
	//등록하기 전에 생일 선택했는지 확인
	var birth=setBirth();
	if(birth.length<10){return}
	
	//이렇게 쓰는거 맞던가? 졸려서 가물가물
	$("form").attr({
		action : "/member/edit",	
		method : "post"		
	});
	$("form").submit();
}

//==========================================================
//비밀번호 입력 안했으면 멈춤 - 기능 더 업그레이드 하고 싶음!
//==========================================================
function checkPassExist(){
	var insertId=$("input[name='pass']").val();
	if(insertId.length<6){
		return false;
	}else{
		return true;
	}
}

//=========================================================================
//연락처 input 태그의 입력값을 받아와 (1) 숫자만 입력되게 하고, (2) 숫자 사이사이에 (-) 삽입되도록 함
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
<body>
	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row">
					<h2 class="text-center" id="title">My Page</h2>
					<p class="text-center">
						<small id="passwordHelpInline" class="text-muted">
							Developer: follow me on facebook <a
							href="https://www.facebook.com/JheanYu"> John niro yumang</a>
							inspired from <a href="https://p.w3layouts.com/">https://p.w3layouts.com/</a>.
						</small>
					</p>
					<hr>
					<div class="content">
						<div class="row">
							<form role="form" method="post" action="register.php">
								<fieldset>
									<div class="col-md-8 col-md-push-2 animate-box">
										<div class="row">
											<div class="col-md-8 pr-1">
												<div class="form-group">
													<label>ID</label> <input type="text" class="form-control"
														placeholder="ID를 입력해주세요." name="id" disabled readonly="readonly"
														value="<%=member.getId()%>"> <input type="hidden"
														name="member_id" value="<%=member.getMember_id()%>" />
													<div class="col-md-8 pr-1"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-8 pr-1">
												<div class="form-group">
													<label>Password</label> <input type="password"
														class="form-control" placeholder="비밀번호를 입력해주세요."
														name="pass" disabled value="">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-8 pr-1">
												<div class="form-group">
													<input type="hidden" class="form-control"
														placeholder="비밀번호를 위와 같이 입력해주세요." name="pass2" disabled
														value="<%=member.getPass()%>">
												</div>
											</div>
										</div>
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
													<label>이름</label> <input type="text" class="form-control"
														placeholder="이름을 입력해주세요." disabled name="name"
														value="<%=member.getName()%>">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-8 pr-1">
												<div class="form-group">
													<label>Email</label> <input type="text"
														class="form-control" placeholder="E-mail을 입력해주세요."
														disabled name="email" value="<%=member.getEmail()%>">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-8 pr-1">
												<div class="form-group">
													<label>연락처</label> <input type="text" class="form-control"
														placeholder="연락처를 입력해주세요." disabled name="phonenum"
														maxlength="13" value="<%=member.getPhonenum()%>">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-3">
												<div class="form-group">
													<label>생년</label> <select class="form-control"
														name="birthYear" disabled>
														<%
															for (int i = 0; i < birth.getYearList().size(); i++) {
														%>
														<option value="<%=birth.getYearList().get(i)%>"><%=birth.getYearList().get(i)%></option>
														<%
															}
														%>
													</select>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label>생월</label> <select class="form-control"
														name="birthMonth" disabled>
														<%
															for (int i = 1; i <= 12; i++) {
														%>
														<%
															if (i < 10) {
														%>
														<option value="<%="0" + i%>"><%="0" + i%></option>
														<%
															} else {
														%>
														<option value="<%=i%>"><%=i%></option>
														<%
															}
														%>
														<%
															}
														%>
													</select>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label>생일</label> <select class="form-control"
														name="birthDate" disabled>
														<%
															for (int i = 1; i <= 31; i++) {
														%>
														<%
															if (i < 10) {
														%>
														<option value="<%="0" + i%>"><%="0" + i%></option>
														<%
															} else {
														%>
														<option value="<%=i%>"><%=i%></option>
														<%
															}
														%>
														<%
															}
														%>
													</select>
												</div>
											</div>
											<input type="hidden" name="birth" id="birth" />
										</div>
										<div class="row">
											<div class="col-md-5">
												<div class="col-md-3">
													<div class="form-group">
														<input type="button" name="bt_regist"
															class="btn btn-lg btn-primary" value="정보수정" />
													</div>
												</div>
											</div>
										</div>

									</div>
								</fieldset>
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	<%@ include file="/inc/footer.jsp"%>
	</div>

	<%@ include file="/inc/tail.jsp"%>
	
</body>
</html>