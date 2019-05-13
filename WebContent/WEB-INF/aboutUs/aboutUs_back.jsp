<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/inc/head.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
</head>
<body>

	<div class="fh5co-loader"></div>

	<div id="page">
		<%@ include file="/inc/menubar.jsp"%>
		<div class="container-wrap">
			
			<div id="fh5co-contact">
				<div class="row animate-box">
					<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
						<h2>Contact us</h2>
						<p>Far far away, behind the word mountains, far from the
							countries Vokalia and Consonantia.</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 col-md-push-1 animate-box">
						<h3>Our Address</h3>
						<ul class="contact-info">
							<li><i class="icon-location4"></i>198 West 21th Street,
								Suite 721 New York NY 10016</li>
							<li><i class="icon-phone3"></i>+ 1235 2355 98</li>
							<li><i class="icon-location3"></i><a href="#">info@yoursite.com</a></li>
							<li><i class="icon-globe2"></i><a href="#">www.yoursite.com</a></li>
						</ul>
					</div>
					<div class="col-md-7 col-md-push-1 animate-box">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Name">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Email">
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<textarea name="" class="form-control" id="" cols="30" rows="7"
										placeholder="Message"></textarea>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<input type="submit" value="Send Message"
										class="btn btn-primary btn-modify">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END container-wrap -->

		
		<%@ include file="/inc/footer.jsp"%>
		
		<!-- END container-wrap -->
	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
	</div>

	<%@ include file="/inc/tail.jsp"%>

</body>
</html>

