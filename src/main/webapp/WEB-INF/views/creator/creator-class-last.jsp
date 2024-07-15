<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Multi Datepicker Example</title>
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
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-class-plan.css"
	rel="stylesheet">

<!-- Toast UI Grid Script -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.grid/latest/tui-grid.css">

<!-- Toast UI Grid Script -->
<!-- <script src="https://uicdn.toast.com/tui.grid/latest/tui-grid.js"></script> -->

<!-- Toast UI Pagination CSS -->
<link rel="stylesheet"	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">

<!-- Toast UI Pagination Script -->

<style>
.delete-btn {
	display: none;
	cursor: pointer;
	color: red;
}

tr:hover .delete-btn {
	display: inline;
}

.hidden {
	display: none;
}

th, td {
	text-align: center;
}
</style>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<!-- Toast UI Grid Script -->
	<script
		src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	<script src="https://uicdn.toast.com/tui.grid/latest/tui-grid.js"></script>
	<!-- Toast UI Pagination Script -->


	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<!-- Spinner Start (로딩시 뜨는 동그라미)-->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-white" role="status"></div>
	</div>
	<!-- Spinner End -->

	<div class="container-fluid fruite">
		<div class="container">
			<h1 class="mt-4 text-white">Creator Center</h1>
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/creator/sideBar.jsp" />
						<!-- 	셀렉트박스 -->
						<div class="col-md-9 creator-body">
							<div class="creator-intro col-md-12">
								<div class="text-white h2">진행완료수업</div>
								<hr class="text-white mb-5">
							</div>
							<c:set var="classCode" value="${classCode}" />
							<div class="col-md-12  mb-2" align="center">
								<div class="col-md-8">
									<div
										class="bg-light rounded py-2 d-flex justify-content-center mb-4">
										<select id="classSelect" name="classSelect"
											class="border-0 form-select-sm bg-light me-3 selectClass">
											<option value="">클래스를 선택해주세요</option>
											<c:forEach var="classInfo" items="${classList}">
												<option value="${classInfo.class_code}"
													<c:if test="${classInfo.class_code eq classCode}">selected</c:if>>
													${classInfo.class_name} ( ${classInfo.endClass} )</option>
											</c:forEach>
										</select>
									</div>
									<hr>
								</div>
							</div>

							<div class="creator-main-table col-xl-12 mb-5">

								<div id="scheduleTableContainer" class="col-md-12">
									<div class="row">
										<div class="col-md-12">
											<div id="grid"></div>
											<div id="pagination"></div>
										</div>
									</div>
								</div>
								<div align="center" class="mt-3">
									<button class="btn btn-outline-primary btn-lg"
										onclick="location.href='creator-class'">돌아가기</button>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

	<!-- JavaScript Libraries -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

	<script>
		$(document).ready(function() {

			const data = null;
			const itemsPerPage = 10;
			let currentPage = 1;

			initializeGrid(data);

			function initializeGrid(data) {
				const gridContainer = document
						.getElementById('grid');
				if (gridContainer) {
					new tui.Grid({
						el : gridContainer,
						data : data,
						columns : [ {
								header : '클래스날짜',
								name : 'class_schedule_date',
								width : 'auto'
							}, {
								header : '회차',
								name : 'class_round'
							}, {
								header : '시작시간',
								name : 'class_st_time'
							}, {
								header : '종료시간',
								name : 'class_ed_time'
							}, {
								header : '참여인원',
								name : 'attend_count'
							},
						],
						rowHeaders : [ 'rowNum' ],
						bodyHeight : 418,
						pageOptions : {
							useClient : true,
							perPage : itemsPerPage
						}
					});
				}
			}

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
					success : function(result) {
						$('#scheduleTableContainer').empty().append('<div id="grid"></div><div id="pagination"></div>');
						initializeGrid(result);
					}
				});
			});

		});
	</script>


</body>
</html>