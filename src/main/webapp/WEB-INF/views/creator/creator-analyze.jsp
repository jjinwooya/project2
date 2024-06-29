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


<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/creator/creator-analyze.css" rel="stylesheet">
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
			<li class="breadcrumb-item"><a href="main">Home</a></li>
			<li class="breadcrumb-item"><a href="main">크리에이터 페이지</a></li>
			<li class="breadcrumb-item active text-white">클래스분석</li>
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
						<!-- 	셀렉트박스 -->
						<jsp:include page="/WEB-INF/views/creator/classSelect.jsp" />
<!-- 							<div class="col-md-12 d-flex justify-content-center mb-5"> -->
<!-- 								<div class="col-xl-8"> -->
<!-- 									<div class="bg-light rounded py-2 d-flex justify-content-center mb-4"> -->
<!-- 										<select id="fruits" -->
<!-- 											name="fruitlist" class="border-0 form-select-sm bg-light me-3 selectClass" -->
<!-- 											form="fruitform"> -->
<!-- 											<option value="volvo">Nothing</option> -->
<!-- 											<option value="saab">Populari</option> -->
<!-- 											<option value="opel">Organic</option> -->
<!-- 											<option value="audi">Fantastic</option> -->
<!-- 										</select> -->
<!-- 									</div> -->
<!-- 									<hr> -->
<!-- 								</div> -->
<!-- 							</div> -->
							<div class="admin_dashboard" align="center">
								<div class="admin_main_center_card" onclick="location.href='#'">
									<div class="admin_main_card" align="left">진행한강의</div>
									<div align="right" class="card_num">
										<a href="#">0건</a>
									</div>
								</div>
								<div class="admin_main_center_card" onclick="location.href='#'">
									<div class="admin_main_card" align="left">참여회원수</div>
									<div align="right" class="card_num">
										<a href="#">0건</a>
									</div>
								</div>
								<div class="admin_main_center_card" onclick="location.href='#'">
									<div class="admin_main_card" align="left">총 후기수</div>
									<div align="right" class="card_num">
										<a href="#">0건</a>
									</div>
								</div>
								<div class="admin_main_center_card" onclick="location.href='#'">
									<div class="admin_main_card" align="left">누적예약 수</div>
									<div align="right" class="card_num">
										<a href="#">0건</a>
									</div>
								</div>
							</div>

							<div class="creator-main-table col-md-10 my-5">
								<div class="admin_main_chart">
									<canvas id="myChart" height="100px"></canvas>
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
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	
		<script type="text/javascript">
		var ctx = document.getElementById("myChart").getContext('2d');
		/*
		- Chart를 생성하면서, 
		- ctx를 첫번째 argument로 넘겨주고, 
		- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
		 */
		
		// 랜덤색상 생성 
// 		function getRandomColor() {
// 			const rColor = Math.floor(Math.random() * 128 + 128);
// 		    const gColor = Math.floor(Math.random() * 128 + 128);
// 		    const bColor = Math.floor(Math.random() * 128 + 128);
// 		    return 'rgba(' + rColor + ',' + gColor + ',' + bColor + ', 0.3)';
// 		}

// 		var chartColors = function() {
// 		    return getRandomColor();
// 		};
		 
		var myChart = new Chart(ctx,
			{
				type : 'line',
				data : {
					labels : ['1월', '2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					datasets : [ {
						label : '월간 매출 데이터',
						data : [2000, 3000, 2500, 2000, 2500, 3100, 2000, 3000, 2500, 2000, 2500, 3100],
// 						backgroundColor : chartColors,
// 						borderColor : chartColors,
						borderColor : 'rgb(192, 20, 20)',
// 						borderWidth : 1
						tension: 0.01
					} ]
				},
				options : {
					maintainAspectRatio : true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
					scales : {
						y : [ {
							ticks : {
								beginAtZero : true
							}
						} ]
					}
				}
			});
	</script>

</body>
</html>