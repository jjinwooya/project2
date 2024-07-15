<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>CreatorClass</title>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
<!-- 	rel="stylesheet"> -->
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-class.css"
	rel="stylesheet">

<!-- Toast UI Grid Script -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.grid/latest/tui-grid.css">

<!-- Toast UI Pagination CSS -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">

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

	<!-- Single Page Header start -->
<!-- 	<div class="container-fluid page-header py-5"> -->
<!-- 		<h1 class="text-center text-white display-6">Creator</h1> -->
<!-- 		<ol class="breadcrumb justify-content-center mb-0"> -->
<!-- 			<li class="breadcrumb-item"><a href="main">Home</a></li> -->
<!-- 			<li class="breadcrumb-item"><a href="main">크리에이터 페이지</a></li> -->
<!-- 			<li class="breadcrumb-item active text-white">클래스</li> -->
<!-- 		</ol> -->
<!-- 	</div> -->
	<!-- Single Page Header End -->

	<div class="container-fluid fruite">
		<div class="container">
			<h1 class="mt-4 text-white">Creator Center</h1>
			<div class="row g-4">
				<div class="col-md-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/creator/sideBar.jsp" />

						<div class="col-md-9 creator-body">
							<div class="creator-intro col-md-12">
								<div class="text-white h2">클래스페이지</div>
								<hr class="text-white mb-5">
							</div>
								
								<!-- 버튼들 -->
								<div class="mb-3" align="right">
									<button class="category-btn classReg" value="respond"
										onclick="location.href='creator-classReg'">클래스등록</button>
									<button class="category-btn classReg" value="respond"
										onclick="location.href='creator-class-plan'">일정등록</button>
									<button class="category-btn classReg" value="respond"
										onclick="location.href='creator-class-last'">진행완료</button>
								</div>
								<!-- 	셀렉트박스 -->
								<div class="mb-1 col-md-3">
									<select class="form-control selectBox">
										<option value="">전체</option>
										<c:forEach var="status" items="${regStatus}">
											<option value="${status.common2_code}">${status.code_value}</option>
										</c:forEach>
									</select>
								</div>
							<div class="creator-main-table col-md-12 mb-5" align="center">

								<div class="row">
									<div class="col-md-12">
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
	</div>
	<!-- Fruits Shop End-->



	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

	<!-- JavaScript Libraries -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	$(document).ready(function () {
		const itemsPerPage = 10;
		let currentPage = 1;
		const data = ${cl_list};
		let grid;
		let columns;

		function initialGrid(data) {
			columns = [
				{ header: '클래스제목', name: 'class_name', align: 'center'  },
				{ header: '지원상태', name: 'code_value', align: 'center', width: '120' },
				{ header: '카테고리', name: 'cate', className: 'hide-column', align: 'center', width: '150' },
				{ header: '공개여부', name: 'hide', className: 'hide-column', align: 'center', width: '100' },
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

// 	            console.log('Clicked Row Data:', rowData);
// 	            console.log('class_code:' + rowData.class_code);
	            location.href = 'creator-classModify?class_code=' + rowData.class_code;
	        });
		}
		
		function handleResize() {
			const isMobile = window.innerWidth <= 767;

			// 그리드 API를 사용하여 컬럼 숨기기/보이기
			grid.setColumns(isMobile ? [
				{ header: '클래스제목', name: 'class_name', width: 'auto', align: 'center' },
				{ header: '지원상태', name: 'code_value', align: 'center'  },
				{ header: '공개여부', name: 'hide', align: 'center'  }
			] : columns);
		}

		// 그리드 초기화
		initialGrid(data);
		
		// 카테고리에 따른 데이터
		$('.selectBox').change(function() {
			const status = $('.selectBox').val();
			$.ajax({
				url : "getStatusClass",
				method : "get",
				data : {
					"status" : status
				},
				success : function(result) {
					$('.creator-main-table').empty().append('<div id="grid"></div><div id="pagination"></div>');
					initialGrid(result);
				}
			});
		});

		// 초기 창 크기에 맞게 설정
		handleResize();

		// 창 크기 변경 시 이벤트 리스너 등록
		window.addEventListener('resize', handleResize);
	});
</script>



</body>
</html>