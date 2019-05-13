<%@page import="java.util.List"%>
<%@page import="com.drunkenbros.common.member.BirthSetter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!BirthSetter birth = new BirthSetter();%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	var idOverlabCheckFlag;

	$(function() {
		idOverlabCheckFlag=false;
		
		$("select[name='birthYear']").change(function() {
			setBirthDate();
		});
		$("select[name='birthMonth']").change(function() {
			setBirthDate();
		});
		$("input[name='id']").keyup(function() {
			idOverlabCheckFlag=false;	//ID 내용 바꿀 때마다 flag를 false로 바꿔서 가입 막음
		});
		$("input[name='bt_idChecker']").click(function() {
			idOverlapCheck();
		});
		$("input[name='bt_regist']").click(function() {
			regist();
		});

		$("#alert-success").hide();
        $("#alert-danger").hide();
		$("input[name='pass']").keyup(function(){
			comparePass();
		});
		$("input[name='pass2']").keyup(function(){
			comparePass();
		});
		$("input[name='phonenum']").keyup(function(){//change 말고
			//alert();
			var phonenumVal=$("input[name='phonenum']").val();
			//alert(phonenum);
			$("input[name='phonenum']").val(autoHypenPhone(phonenumVal));
		});
	});

	//=================================================================
	// 아이디 중복 확인 버튼 눌렀을 때 중복 확인
	//=================================================================
	function idOverlapCheck(){
		if(!checkIdExist()){
			//6글자 미만으로 입력해서 회원가입 막음
			$("#modal-title").text("아이디를 6글자 이상 입력해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		$.ajax({
			url:"/member/regist/idoverlap",
			type:"POST",
			data:{
				id:$("input[name='id']").val(),
			},
			success:function(result){
				var json=JSON.parse(result);
				if(json.resultCode==1){
					$("#modal-title").text(json.msg);
					$("#myModal").modal('toggle');
					idOverlabCheckFlag=true;
				}else{
					$("#modal-title").text(json.msg);
					$("#myModal").modal('toggle');
				}
			}

		});
	}
	
	//=================================================================
	// 회원가입 버튼 눌렀을 때 회원 DB에 등록 등록
	//=================================================================
	function regist() {
		//아이디체크
		if(!idOverlabCheckFlag){
			$("#modal-title").text("아이디 중복 여부를 체크해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		if(!checkIdExist()){
			//6글자 미만으로 입력해서 회원가입 막음
			$("#modal-title").text("아이디를 6글자 이상 입력해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		//비번 글자수 체크 //비번 동일하지 않으면 가입되지 않도록 만들기
		if(!checkPassExist()){
			//비번 글자수 부족
			$("#modal-title").text("비밀번호를 6글자 이상 입력해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		//이름 체크 - 1글자 이상 입력해야 됨
		if(!checkNameExist()){
			$("#modal-title").text("이름을 1글자 이상 입력해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		//Email 체크
		if(!checkEmailExist()){
			$("#modal-title").text("Email을 1글자 이상 입력해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		//연락처 체크
		if(!checkPhonenumExist()){
			$("#modal-title").text("연락처를 1글자 이상 입력해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		
		//등록하기 전에 생일 선택했는지 확인
		var checkBirth=setBirth();
		if(checkBirth.length<10){
			$("#modal-title").text("생년월일을 선택해주세요.");
			$("#myModal").modal('toggle');
			return
		}

		//약관 동의 체크했는지 확인
		if(!checkAgreeChecker()){
			$("#modal-title").text("약관에 동의해주세요.");
			$("#myModal").modal('toggle');
			return;
		}
		console.log($("input[name='id']").val());
		console.log($("input[name='pass']").val());
		console.log($("input[name='name']").val());
		console.log($("input[name='birth']").val());
		console.log($("input[name='phonenum']").val());
		console.log($("input[name='email']").val());
		
		$.ajax({
			url:"/member/regist",
			type:"post",
			data:{
				id:$("input[name='id']").val(),
				pass:$("input[name='pass']").val(),
				name:$("input[name='name']").val(),
				birth:$("input[name='birth']").val(),
				phonenum:$("input[name='phonenum']").val(),
				email:$("input[name='email']").val()
			},
			success:function(result){
				var json=JSON.parse(result);
				if(json.resultCode==1){
					$(location).attr("href","/member/welcome");
				}else{
					alert(json.msg);
					$("#modal-title").text("회원가입에 실패했습니다..");
					$("#myModal").modal('toggle');
				}
			}
		});
	}

	//=================================================================
	//가입 버튼 눌렀을 때 입력사항 체크하기
	//=================================================================
	function checkIdExist(){
		var insertId=$("input[name='id']").val();
		if(insertId.length<6){
			return false;
		}else{
			return true;
		}
	}

	function checkPassExist(){
		var insertPass=$("input[name='pass']").val();
		if(insertPass.length<6){
			return false;
		}else{
			return true;
		}
	}
	
	function checkNameExist(){
		var insertName=$("input[name='name']").val();
		if(insertName.length<1){
			return false;
		}else{
			return true;
		}
	}
	
	function checkEmailExist(){
		var insertEmail=$("input[name='email']").val();
		if(insertEmail.length<1){
			return false;
		}else{
			return true;
		}
	}
	
	function checkPhonenumExist(){
		var insertPhone=$("input[name='phonenum']").val();
		if(insertPhone.length<1){
			return false;
		}else{
			return true;
		}
	}

	function checkAgreeChecker(){
		return $("input[name=agreeChecker]").is(':checked');
	}
	
	//=================================================================
	//비밀번호1과 2를 비교하는 함수. 비교 결과가 같으면 버튼 활성화/다르면 비활성화
	//=================================================================
	function comparePass(){
		var pass1=$("input[name='pass']").val();
        var pass2=$("input[name='pass2']").val();
       
        if(pass1 != "" || pass2 != ""){
            if(pass1 == pass2){
                $("#alert-success").show();
                $("#alert-danger").hide();
                $("input[name='bt_regist']").removeAttr("disabled");
            }else{
                $("#alert-success").hide();
                $("#alert-danger").show();
                $("input[name='bt_regist']").attr("disabled", "disabled");
            }    
        }else if(pass1 == "" && pass2 == ""){
        	 $("#alert-success").hide();
             $("#alert-danger").hide();
             $("input[name='bt_regist']").attr("disabled", "disabled");
        }
	}

	//=================================================================
	//생일 select의 date값을 변경하기 위한 함수 - 왜? 2월 윤달 떄문에 ㄱ-
	//=================================================================
	function setBirthDate() {
		var year = $("select[name='birthYear']").val();
		var month = $("select[name='birthMonth']").val();
		if (year != "생년" && month != "생월") {
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
					//alert(result.length);
					var optionSize = $("select[name='birthDate'] option").length;
					for (var i = 0; i < optionSize; i++) {
						$("select[name='birthDate'] option:first").remove();
					}
					$("select[name='birthDate']").append(
							"<option value=''>생일</option>");
					for (var i = 0; i < result.length; i++) {
						$("select[name='birthDate']").append(
								"<option>" + result[i] + "</option>");
					}
				}
			});
		}
	}

	//=================================================================
	// regist() 할 때 생일 select 값들 하나로 합쳐지도록 만듬
	//=================================================================
	function setBirth(){
		var year=$("select[name='birthYear']").val();
		var month=$("select[name='birthMonth']").val();
		var date=$("select[name='birthDate']").val();
		var checkBirth=year+"-"+month+"-"+date; 
		$("input[name='birth']").val(checkBirth);
		console.log(checkBirth);
		return checkBirth;
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
</script>
</head>
<body>
	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row">
					<h2 class="text-center" id="title">회원가입</h2>
					<p class="text-center">
						<small id="passwordHelpInline" class="text-muted">
							로그인 정보 및 가입 정보를 입력하세요.
						</small>
					</p>
					<hr>
					<!-- 모달(confirm) 세팅 -->
					<!-- Modal -->
					<div id="myModal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title" align="center">입력확인</h4>
								</div>
								<div class="modal-body">
									<form name="edit_form">
										<h3 class="modal-title" align="center" id="modal-title"></h3>
									</form>
								</div>
								<div class="modal-footer">

									<button type="button" class="btn btn-primary btn-round"
										data-dismiss="modal">확인</button>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-8 col-md-push-2 animate-box">
							<form role="form" method="post" action="register.php">
								<fieldset>
									<p class="text-uppercase pull-center">SIGN UP.</p>
									<div class="form-group">
										<input type="text" name="id" id="id"
											style="width: 70%; float: left" class="form-control input-lg"
											required placeholder="ID"> <input type="button"
											id="id_check" class="btn btn-outline-primary"
											name="bt_idChecker" value="중복체크">
									</div>
									<div class="form-group">
										<input type="password" name="pass" id="pass"
											class="form-control input-lg" required placeholder="Password">
									</div>
									<div class="form-group">
										<input type="password" name="pass2" id="pass2"
											class="form-control input-lg" required
											placeholder="Password2">
									</div>
									<div class="alert alert-success" id="alert-success">비밀번호가
										일치합니다.</div>
									<div class="alert alert-danger" id="alert-danger">비밀번호가
										일치하지 않습니다.</div>

									<div class="form-group">
										<input type="text" name="name" id="name"
											class="form-control input-lg" required placeholder="이름">
									</div>
									<div class="form-group">
										<input type="email" name="email" id="email"
											class="form-control input-lg" placeholder="Email 주소">
									</div>
									<div class="form-group">
										<input type="text" name="phonenum" id="phonenum"
											maxlength='13' class="form-control input-lg"
											placeholder="연락처">
									</div>
									<div class="row">
										<div class="col-md-4">
											<div class="form-group">
												<select name="birthYear" class="form-control"
													data-live-search="true">
													<option>생년</option>
													<%
														for (int i = 0; i < birth.getYearList().size(); i++) {
													%>
													<option><%=birth.getYearList().get(i)%></option>
													<%
														}
													%>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<select name="birthMonth" class="form-control"
													data-live-search="true">
													<option>생월</option>
													<%
														for (int i = 0; i < birth.getMonthList().size(); i++) {
													%>
													<option><%=birth.getMonthList().get(i)%></option>
													<%
														}
													%>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<select name="birthDate" class="form-control"
													data-live-search="true">
													<option>생일</option>
												</select> 
											</div>
										</div>
										<input type="hidden" name="birth" id="birth" />
									</div>
									<div class="row">
										<div class="col-md-2"></div>
										<div class="col-md-8">
											<div class="form-group">
												<label class="form-check-label"> <input
													type="checkbox" class="form-check-input"
													name="agreeChecker"> 서비스 약관 및 개인정보 수집, 이용에 동의해 주세요.</label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-2"></div>
										<div class="col-md-8">
											<div class="form-group">
												<input type="button" name="bt_regist"
													class="btn btn-lg btn-primary" value="회원가입" />
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