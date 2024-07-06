<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Insert title here</title>
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css"
	rel="stylesheet">
<style>
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

td > a{
	display:-webkit-box; 
    word-wrap:break-word; 
    -webkit-line-clamp:1; 
    -webkit-box-orient:vertical; 
    overflow:hidden; 
    text-overflow:ellipsis;
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
		<h1 class="text-center text-white display-6">Creator</h1>
		<ol class="breadcrumb justify-content-center mb-0">
			<li class="breadcrumb-item"><a href="main text-white">Home</a></li>
			<li class="breadcrumb-item active text-white">크리에이터 페이지</li>
		</ol>
	</div>
	<!-- Single Page Header End -->

	<div class="container-fluid fruite">
		<div class="container">
			<h1 class="mb-4 text-white">Creator Center</h1>
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/creator/sideBar.jsp" />

						<div class="col-lg-9 creator-body">
							<!-- 크리에이터 인사 문구 -->
							<div class="col-md-12 text-center text-white h2 mb-5">반가워요 6ellMin 님</div>
							
							<!-- 크리에이터 이벤트 -->
							<div class="creator-event mt-5">
							
								<div class="card col-md-10 my-2">
								  <div class="card-body">
								    <h6 class="card-title">[업데이트] CLASS101 클래스 및 신규 상품 오픈 지원 재개 안내</h6>
								    <div class="d-flex justify-content-between card-content">
									    <p class="card-text word-break">중단되었던 크리에이터 지원이 재개되었어요!!</p> 
									    <a href="#" class="btn btn-primary">상세보기</a>
								    </div>
								  </div>
								</div>
								<div class="card col-md-10 my-2">
								  <div class="card-body">
								    <h6 class="card-title">[신규 런칭] 모임으로 배움을 확장하다!</h6>
								    <div class="d-flex justify-content-between card-content">
									    <p class="card-text">신규 서비스, 101 School에 참여하세요!</p>
									    <a href="#" class="btn btn-primary">상세보기</a>
								    </div>
								  </div>
								</div>
							</div>

							<div class="creator-main-table col-md-10 my-5">
								<div class="d-flex justify-content-end md-5">
									<a href="#">+ 더보기</a>
								</div>
								<table>
									<thead>
										<tr>
											<th>공지사항</th>
											<th>날짜</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><a>존나중요한 공지 드립니다 빡집중하세여</a></td>
											<td>2024-06-12</td>
										</tr>
										<tr>
											<td><a>존나중요한 공지 드립니다 빡집중하세여</a></td>
											<td>2024-06-12</td>
										</tr>
										<tr>
											<td><a>존나중요한 공지 드립니다 빡집중하세여</a></td>
											<td>2024-06-12</td>
										</tr>
										<tr>
											<td><a>존나중요한 공지 드립니다 빡집중하세여</a></td>
											<td>2024-06-12</td>
										</tr>
										<tr>
											<td><a>존나중요한 공지 드립니다 빡집중하세여 길게 쓰는겁니다 길게 기일게 길게</a></td>
											<td>2024-06-12</td>
										</tr>
									</tbody>
								</table>
							</div>
						
						</div>
					</div>



<!-- 					<div class="col-12"> -->
<!-- 						<div class="pagination d-flax justify-content-center mt-5"> -->
<!-- 							<a href="#" class="rounded">&laquo;</a> <a href="#" -->
<!-- 								class="active rounded">1</a> <a href="#" class="rounded">2</a> <a -->
<!-- 								href="#" class="rounded">3</a> <a href="#" class="rounded">4</a> -->
<!-- 							<a href="#" class="rounded">5</a> <a href="#" class="rounded">6</a> -->
<!-- 							<a href="#" class="rounded">&raquo;</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
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
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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