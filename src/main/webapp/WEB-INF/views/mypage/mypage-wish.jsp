<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>나의 관심클래스</title>
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
		<h1 class="text-center text-white display-6">
			마이페이지<i class="bi bi-emoji-heart-eyes"></i>관심클래스
		</h1>
	</div>

	<div class="container-fluid fruite">
		<div class="container">
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/mypage/sideBar.jsp" />

						<div class="col-lg-9 creator-body">


							<div class="creator-event mt-5">
								<div class="col-md-12 text-center h2 mb-5">
									${member.member_name} 님은 이런 클래스를 관심있게 보고 있어요</div>
								<div class="container">
									<h2>관심 클래스</h2>
									<p>나의 관심 클래수 개수 : ${total_likes}개</p>
									<table class="table table-hover">
										<thead>
											<tr>
												<th>클래스 이름</th>
												<th>클래스 위치</th>
												<th>클래스 가격</th>
												<th>상세보기</th>
												<th>관심 취소하기</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="memberLike" items="${memberLike}">
												<tr>
													<td>${memberLike.class_name}</td>
													<td>${memberLike.class_location}</td>
													<c:set var="credit" value="${memberLike.class_price}" />
													<td><fmt:formatNumber value="${credit}" type="number"
															pattern="#,##0" /> 원</td>
													<td><a
														href="class-detail?class_code=${memberLike.class_code}"
														class="btn btn-primary">상세보기</a></td>
													<td><button class="btn btn-danger"
															onclick="cancelLike('${memberLike.class_code}', '${member.member_code}')">취소</button></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<div id="pageList">
										<input type="button" value="이전"
											onclick="location.href='my-wish?pageNum=${pageNum - 1}'"
											<c:if test="${pageNum == 1}">disabled</c:if> />
										<c:forEach var="i" begin="1" end="${maxPage}">
											<c:choose>
												<c:when test="${pageNum == i}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="my-wish?pageNum=${i}">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<input type="button" value="다음"
											onclick="location.href='my-wish?pageNum=${pageNum + 1}'"
											<c:if test="${pageNum == maxPage or maxPage == 0}">disabled</c:if> />
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
	<script>
		function cancelLike(classCode, memberCode) {
			// 사용자에게 확인을 받기 위한 confirm 창 표시
			var confirmCancel = confirm("관심 클래스를 취소하시겠습니까?");

			// 사용자가 확인을 선택한 경우
			if (confirmCancel) {
				var data = JSON.stringify({
					heart_status : false,
					class_code : classCode,
					member_code : memberCode
				});
				var xhr = new XMLHttpRequest();
				xhr
						.open(
								"POST",
								"${pageContext.request.contextPath}/update-heart-status",
								true);
				xhr.setRequestHeader("Content-Type",
						"application/json;charset=UTF-8");

				xhr.onreadystatechange = function() {
					if (xhr.readyState === 4) {
						if (xhr.status === 200) {
							if (xhr.responseText === "success") {
								alert('관심 클래스가 취소되었습니다.');
								location.reload(); // 페이지를 새로고침하여 변경사항을 반영
							} else {
								alert('취소하는 도중 오류가 발생했습니다.');
							}
						} else {
							alert('서버와의 통신에 실패했습니다.');
						}
					}
				};

				xhr.send(data);
			}
		}
	</script>
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