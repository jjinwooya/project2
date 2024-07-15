<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>mypage</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">


<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/myPage.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css"
	rel="stylesheet">
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style>
body {
	
}
table {
	border-collapse: collapse;
	box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	background-color: white;
	width: 100%;
	border-radius: 10px;
	font-size: 15px;
}

/* 테이블 행 */
th, td {
	padding: 15px 8px;
	border-bottom: 1px solid #ddd;
	color: black;
}

th {
	background-color: #eee;
	color: black;
}

td>a {
	display: -webkit-box;
	word-wrap: break-word;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* 테이블 올렸을 때 */
tbody tr:hover {
	background-color: white;
	opacity: 0.9;
	cursor: pointer;
}

/* 테이블 비율 */
th:nth-child(1), td:nth-child(1) {
	padding-left: 20px;
}

th:nth-child(2), td:nth-child(2) {
	width: 130px;
	text-align: center;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<!-- Spinner Start (로딩시 뜨는 동그라미)-->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-white" role="status"></div>
	</div>
	<!-- Spinner End -->

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">마이페이지</h1>
		<ol class="breadcrumb justify-content-center mb-0">
			<li class="breadcrumb-item"><a href="main">Home</a></li>
		</ol>
	</div>

	<div class="container-fluid fruite">
		<div class="container">
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/mypage/sideBar.jsp" />

						<div class="col-lg-9 creator-body">
							<!-- 크리에이터 인사 문구 -->

							<!-- 크리에이터 이벤트 -->
							<div class="creator-event mt-5">
								<div class="col-md-12 text-center h2 mb-5">반가워요 ${member.member_name}님</div>
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-emoji-heart-eyes"></i>&nbsp;관심 클래스</h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;">내가 관심있는 클래스 입니다.</p>
											<a href="my-wish" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-wallet"></i>&nbsp;윌페이</h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;" >윌페이 충전을 할 수 있는 곳 입니다.</p>
											<a href="my-credit" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-cart-check"></i>&nbsp;내가 신청한 클래스</h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;" >내가 신청한 클래스 입니다.</p>
											<a href="my-class" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-pencil-square"></i>&nbsp;나의 클래스 후기</h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;">클래스 후기를 적을 수 있는 곳 입니다.</p>
											<a href="my-review" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-patch-question"></i>&nbsp;나의 클래스 문의</h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;">내가 적은 클래스 문의를 확인할 수 있는  곳 입니다.</p>
											<a href="my-inquiry" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-sunrise-fill"></i>&nbsp;나의 성장 확인 </h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;" >나는 이렇게 성장했어요!</p>
											<a href="my-powerup" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-gear"></i>&nbsp;회원정보변경</h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;" >회원 정보를 변경할 수 있는 곳 입니다.</p>
											<a href="my-modify" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<div class="card col-md-10 my-2">
									<div class="card-body">
										<h6 class="card-title"><i class="bi bi-person-x-fill"></i>&nbsp;회원탈퇴</h6>
										<div class="d-flex justify-content-between card-content">
											<p class="card-text" style="color:black;">회원 탈퇴를 할 수 있는 곳입니다.</p>
											<a href="my-delete" class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Fruits Shop End-->



	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

	<!-- JavaScript Libraries -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

</body>
</html>