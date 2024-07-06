<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>나의 성장</title>
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

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
	table-layout: fixed; /* 테이블 레이아웃 고정 */
	word-wrap: break-word; /* 단어를 셀 내에서 줄바꿈 */
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
@media ( max-width : 768px) {
	.table-responsive {
		overflow-x: auto; /* 가로 스크롤 가능하도록 설정 */
	}
	.table {
		min-width: 600px; /* 테이블 최소 너비 설정 */
	}
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
			마이페이지<i class="bi bi-sunrise-fill"></i>나의 성장
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
								<div class="col-md-12 text-center h2 mb-5">항상 고마운
									${member.member_name}님</div>
								<div class="container">
									<div class="row">
										<div class="col">
											<div class="table-responsive">
												<table class="table table-hover">
													<thead>
														<tr>
															<th>수료한 월</th>
															<th>수료한 클래스 수</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="item" items="${memberMaster}">
															<tr>
																<td>${item.month}</td>
																<td>${item.class_count}개</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>

							</div>

							<div class="mt-5">
								<canvas id="chart" style="width: 100%; height: 400px;"></canvas>
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
	<script>
	$(document).ready(function() {
	    // 데이터 준비
	    var labels = [];
	    var data = [];

	    // ${memberMaster}에서 데이터 추출하여 배열에 추가
	    <c:forEach var="item" items="${memberMaster}">
	      labels.push("${item.month}");
	      data.push(${item.class_count});
	    </c:forEach>;

	    // Chart.js를 이용한 그래프 생성
	    var ctx = document.getElementById('chart');
	    if (ctx) {
	      ctx = ctx.getContext('2d');
	      var myChart = new Chart(ctx, {
	        type: 'bar', // 막대 그래프로 설정
	        data: {
	          labels: labels,
	          datasets: [{
	            label: '수료한 클래스 수',
	            data: data,
	            backgroundColor: 'rgba(54, 162, 235, 1)', // 막대 색상 설정
	            borderColor: 'rgba(54, 162, 235, 1)',
	            borderWidth: 1
	          }]
	        },
	        options: {
	            scales: {
	                y: {
	                    beginAtZero: true,
	                    title: {
	                        display: true,
	                        text: '수료한 클래스 수',
	                        font: {
	                            size: 16 // 폰트 크기 설정
	                        }
	                    },
	                    ticks: {
	                        stepSize: 1, // 세로 축 간격 설정
	                        font: {
	                            size: 14 // 폰트 크기 설정
	                        }
	                    }
	                },
	                x: {
	                    title: {
	                        display: true,
	                        text: '월',
	                        font: {
	                            size: 16 // 폰트 크기 설정
	                        }
	                    }
	                }
	            },
	            plugins: {
	                legend: {
	                    display: true,
	                    position: 'top'
	                },
	                tooltip: {
	                    callbacks: {
	                        label: function(tooltipItem) {
	                            return tooltipItem.dataset.label + ': ' + tooltipItem.raw + ' 개'; // 데이터 값 뒤에 " 개" 추가
	                        }
	                    }
	                }
	            },
	            responsive: true,
	            maintainAspectRatio: false,
	            barPercentage: 0.4 // 막대 너비 설정
	        }
	        });
	    } else {
	      console.error("Cannot find canvas element with id 'chart'");
	    }
	  });
	
	</script>

</body>
</html>