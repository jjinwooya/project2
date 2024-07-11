<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>리뷰 수정하기</title>
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

.star-rating {
	display: inline-block;
}

.star-rating span {
	font-size: 2rem;
	cursor: pointer;
	color: #ccc;
}

.star-rating .selected {
	color: #ffc107;
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
		<h1 class="text-center text-white display-6"></h1>
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
								<div class="col-md-12 text-center h2 mb-5">리뷰 수정하기</div>
								<form action="edit-review" method="post">
									<input type="hidden" name="class_review_code"
										value="${review.class_review_code}">
									<div class="form-group">
										<label for="subject">제목</label> <input type="text"
											class="form-control" id="subject" name="class_review_subject"
											value="${review.class_review_subject}" required>
									</div>
									<div class="form-group">
										<label for="content">내용</label>
										<textarea class="form-control" id="content"
											name="class_review_content" rows="5" required> ${review.class_review_content}</textarea>
									</div>
									<div class="form-group">
										<label for="rating">별점</label>
										<div id="star-rating" class="star-rating">
											<span data-value="1">&#9733;</span> <span data-value="2">&#9733;</span>
											<span data-value="3">&#9733;</span> <span data-value="4">&#9733;</span>
											<span data-value="5">&#9733;</span>
										</div>
										<input type="hidden" id="rating" name="class_review_rating"
											value="${review.class_review_rating}" required>
									</div>
									<button type="submit" class="btn btn-primary">수정</button>
									<button type="button"  class="btn btn-primary" onclick="window.history.back()">뒤로가기</button>
								</form>
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
	<script>
	document.addEventListener('DOMContentLoaded', function () {
        const stars = document.querySelectorAll('#star-rating span');
        const ratingInput = document.getElementById('rating');

        function updateStars(rating) {
            stars.forEach((star, index) => {
                star.classList.toggle('selected', index < rating);
            });
        }

        stars.forEach(star => {
            star.addEventListener('click', function () {
                const ratingValue = parseInt(this.getAttribute('data-value'));
                ratingInput.value = ratingValue;
                updateStars(ratingValue);
            });
        });

        // 초기 별점 설정
        updateStars(parseInt(ratingInput.value));
    });
    </script>
</body>
</html>