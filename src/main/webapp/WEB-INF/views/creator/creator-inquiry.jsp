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
	rel="stylesheet">``
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
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css" rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-review.css" rel="stylesheet">
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">Creator</h1>
		<ol class="breadcrumb justify-content-center mb-0">
			<li class="breadcrumb-item"><a href="main">Home</a></li>
			<li class="breadcrumb-item"><a href="creator-main">크리에이터 페이지</a></li>
			<li class="breadcrumb-item active text-white">문의관리</li>
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
							<div class="creator-main-table col-md-12 mb-5">
								
								<!-- 	셀렉트박스 -->
								<jsp:include page="/WEB-INF/views/creator/classSelect.jsp" />
								
								<!-- 상단 카테고리 -->
								<div class="mt-5">
									<button class="category-btn reviewType" value="respond">응답문의</button>
									<button class="category-btn reviewType" value="respond">미응답문의</button>
								</div>
								<!-- 테이블 -->
								<div class="card text-center">
									<div class="card-body p-2">
										<table>
											<thead>
												<tr>
													<th>제목</th>
													<th>작성일자</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="creator-review-subject">
														<a onclick="creatorInquiry()">당일취소 가능한가요?</a>
													</td>
													<td>
														2024-05-11
													</td>
												</tr>
												
											</tbody>
										</table>
									</div>
								</div>

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

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	
	<script type="text/javascript">
	
	$(function() {
		$('.category-btn').click(function() {
			$('.category-btn').removeClass('active');
			$(this).addClass('active');
		});
		$('.category-btn').hover(
			function() {
		    	$(this).addClass('hover');
		    },
		    function() {
		    	$(this).removeClass('hover');
		    }
		);
	});		
	
	function creatorInquiry() {
		window.open("creator-inquiry-form", "pop", "width=700, height=700, left=700, top=50");
	}
	
	$(function() {
		$('#classSelect').change(function() {
			// ajax로 기존 선택했던 날짜 가져오기
			var classCode = $(
					'#classSelect').val();
			$.ajax({
				url : "getEndedClass",
				method : "get",
				data : {
					"classCode" : classCode
				},
				success : function(
						result) {
					$('#scheduleTableContainer').empty().append('<div id="grid"></div><div id="pagination"></div>');
					initializeGrid(result);
				}
			});
		});
	});
		
	</script>


</body>
</html>