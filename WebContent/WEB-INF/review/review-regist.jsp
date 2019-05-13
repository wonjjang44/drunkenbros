<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Required meta tags-->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Colorlib Templates">
<meta name="author" content="Colorlib">
<meta name="keywords" content="Colorlib Templates">

<!-- Font special for pages-->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i"
	rel="stylesheet">

<!-- Main CSS-->
<link href="css/main.css" rel="stylesheet" media="all">
</head>

<body>
	<div class="fh5co-loader"></div>

	<div id="page" style="background-color: #00000C;">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			<div id="fh5co-work">
				<div class="row">

					<div class="page-wrapper bg-dark p-t-100 p-b-50">
						<div class="wrapper wrapper--w900">
							<div class="card card-6">
								<div class="card-heading">
									<h2 class="title">술 정보 등록</h2>
								</div>
								<div class="card-body">
									<form method="POST">
										<div class="form-row">
											<div class="name">술 이름</div>
											<div class="value">
												<input class="input--style-6" type="text" name="full_name">
											</div>
										</div>
										<div class="form-row">
											<div class="name">작성자</div>
											<div class="value">
												<div class="input-group">
													<input class="input--style-6" type="email" name="email"
														placeholder="example@email.com">
												</div>
											</div>
										</div>
										<div class="form-row">
											<div class="name">글 내용</div>
											<div class="value">
												<div class="input-group">
													<textarea class="textarea--style-6" name="message"
														placeholder="Message sent to the employer"></textarea>
												</div>
											</div>
										</div>
										<div class="form-row">
											<div class="name">파일등록</div>
											<div class="value">
												<div class="input-group js-input-file">
													<input class="input-file" type="file" name="file_cv"
														id="file"> <label class="label--file" for="file">Choose
														file</label> <span class="input-file__info">No file chosen</span>
												</div>
												<div class="label--desc">Upload your CV/Resume or any
													other relevant file. Max file size 50 MB</div>
											</div>
										</div>
									</form>
								</div>
								<div class="card-footer">
									<button class="btn btn--radius-2 btn--blue-2" type="submit">Send
										Application</button>
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