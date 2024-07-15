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

<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/creator/creator-review.css" rel="stylesheet">
	
	<!-- Toast UI Grid Script -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.grid/latest/tui-grid.css">
<!-- Toast UI Pagination CSS -->
<link rel="stylesheet"	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<!-- Toast UI Pagination Script -->
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	<!-- Toast UI Grid Script -->
	<script src="https://uicdn.toast.com/tui.grid/latest/tui-grid.js"></script>

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

						<div class="col-lg-9 creator-body">
							<div class="creator-intro col-md-12">
								<div class="text-white h2">후기관리</div>
								<hr class="text-white mb-5">
							</div>
							<div class="creator-main-table col-md-12 mb-5">
								
								<!-- 	셀렉트박스 -->
								<jsp:include page="/WEB-INF/views/creator/classSelect.jsp" />
								<!-- 상단 카테고리 -->
								<div class="mt-5">
									<button class="category-btn reviewTypeNo" value="N">미응답후기</button>
									<button class="category-btn reviewTypeYes" value="Y">응답후기</button>
								</div>
								<!-- 테이블 -->
								<div id="scheduleTableContainer" class="col-md-12">
									<div id="grid"></div>
									<div id="pagination"></div>
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

	<!-- Template Javascript -->
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script> --%>
	
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
		
		const itemsPerPage = 10;
		let currentPage = 1;
		const data = ${rw_list};
		let grid;
		let columns;
		
		initialGrid(data);
		
		function initialGrid(data) {
			columns = [
				{ header: '후기제목', name: 'class_review_subject', align: 'center'  },
				{ header: '작성일', name: 'class_review_date', align: 'center', width: '120' },
				{ header: '답변여부', name: 'review_reply_status', align: 'center', width:'100' }
			];

			grid = new tui.Grid({
				el: document.getElementById('grid'),
				data: data,
				columns: columns,
				rowHeaders: ['rowNum'],
				bodyHeight: 418,
				pageOptions: {
					useClient: true,
					perPage: itemsPerPage
				}
			});
			
			grid.on('click', (ev) => {
	            const rowKey = ev.rowKey;  // 클릭한 행의 키 값
	            const rowData = grid.getRow(rowKey);  // 클릭한 행의 데이터
	            console.log("rowKey: " + rowKey);
	            console.log("rowData: " + rowData);
	            debugger;
	            window.open("creator-review-form?class_review_code=" + rowData.class_review_code, "pop", "width=700, height=700, left=700, top=50");
	        });
		}
		var classCode;
		//클래스에 따른 후기
		$('#classSelect').change(function() {
			$('.category-btn').removeClass("active");
			classCode = $('#classSelect').val();
			$.ajax({
				url: "getReviewByClass",
				method: "get",
				data: { "classCode" : classCode },
				success: function(data) {
					// JSON 형태로 파싱
					var reviewData = JSON.parse(JSON.stringify(data));
					$('#scheduleTableContainer').empty().append('<div id="scheduleTableContainer" class="col-md-12">'
					 + '<div id="grid"></div><div id="pagination"></div></div></div>');
					// 데이터 ToastUI에 넣어서 전환
					initialGrid(reviewData);
					
				}
			});	
		});
		
		$('.category-btn').click(function() {
			var type = $(this).val();
			console.log("type: " + type);
			$.ajax({
				url: "getReviewByType",
				method: "get",
				data: { "classCode" : classCode,
						"type" : type	
				},
				success: function(data) {
					// JSON 형태로 파싱
					var reviewData = JSON.parse(JSON.stringify(data));
					$('#scheduleTableContainer').empty().append('<div id="scheduleTableContainer" class="col-md-12">'
					 + '<div id="grid"></div><div id="pagination"></div></div></div>');
					// 데이터 ToastUI에 넣어서 전환
					initialGrid(reviewData);
				}
			});	
		});

		
	});	// onready 끝	
		
	</script>


</body>
</html>