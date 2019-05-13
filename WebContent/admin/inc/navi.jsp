<%@ page contentType="text/html; charset=UTF-8"%>
<nav
	class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
	<div class="container-fluid">
		<div class="navbar-wrapper">
			<div class="navbar-toggle">
				<button type="button" class="navbar-toggler">
					<span class="navbar-toggler-bar bar1"></span> <span
						class="navbar-toggler-bar bar2"></span> <span
						class="navbar-toggler-bar bar3"></span>
				</button>
			</div>
			<a class="navbar-brand" href="#">메인 페이지</a>
		</div>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navigation" aria-controls="navigation-index"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-bar navbar-kebab"></span> <span
				class="navbar-toggler-bar navbar-kebab"></span> <span
				class="navbar-toggler-bar navbar-kebab"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end"
			id="navigation">
			<!-- <form>
				<div class="input-group no-border">
					<input type="text" value="" class="form-control"
						placeholder="Search...">
					<div class="input-group-append">
						<div class="input-group-text">
							<i class="nc-icon nc-zoom-split"></i>
						</div>
					</div>
				</div>
			</form> -->
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link btn-rotate"
					href="/admin/logout">
						<label>관리자 로그아웃</label>
				</a></li>
			</ul>
		</div>
	</div>
</nav>