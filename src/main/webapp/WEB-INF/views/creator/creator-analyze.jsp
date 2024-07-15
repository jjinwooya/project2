<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/creator/creator-analyze.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
#myChart{
	height: 400px;
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

	<div class="container-fluid fruite">
		<div class="container">
			<h1 class="mt-4 text-white">Creator Center</h1>
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/creator/sideBar.jsp" />

						<div class="col-lg-9 creator-body">
						<div class="creator-intro col-md-12">
							<div class="text-white h2">클래스분석</div>
							<hr class="text-white mb-5">
						</div>
						<!-- 	셀렉트박스 -->
						<jsp:include page="/WEB-INF/views/creator/classSelect.jsp" />
							<div class="admin_dashboard" align="center">
								<div class="admin_main_center_card" onclick="location.href='creator-class-last'">
									<div class="admin_main_card" align="left">진행한강의</div>
									<div align="right" class="card_num">
										<a href="#">${analyzeList.classCount}건</a>
									</div>
								</div>
								<div class="admin_main_center_card" onclick="location.href='creator-class-last'">
									<div class="admin_main_card" align="left">참여회원수</div>
									<div align="right" class="card_num">
										<a href="#">${analyzeList.attendCount}명</a>
									</div>
								</div>
								<div class="admin_main_center_card" onclick="location.href='creator-review'">
									<div class="admin_main_card" align="left">총 후기수</div>
									<div align="right" class="card_num">
										<a href="#">${analyzeReviewList.reviewCount}건</a>
									</div>
								</div>
								<div class="admin_main_center_card" onclick="location.href='creator-class'">
									<div class="admin_main_card" align="left">회당 평균참여수</div>
									<div align="right" class="card_num">
										<a href="#">${analyzeList.avgAttendCount}명</a>
									</div>
								</div>
							</div>

							<div class="creator-main-table col-md-10 my-5">
								<div class="admin_main_chart">
									<canvas id="myChart" height="400px"></canvas>
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
<!-- 	<script -->
<!-- 		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script> -->
<!-- 	<script -->
<!-- 		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script> -->

<!-- 	<!-- Template Javascript --> -->
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script> --%>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	
	<script type="text/javascript">
		var ctx = document.getElementById("myChart").getContext('2d');
		
		// 랜덤색상 생성 
		function getRandomColor() {
			const rColor = Math.floor(Math.random() * 128 + 128);
		    const gColor = Math.floor(Math.random() * 128 + 128);
		    const bColor = Math.floor(Math.random() * 128 + 128);
		    return 'rgba(' + rColor + ',' + gColor + ',' + bColor + ', 1)';
		}
	
		var chartColors = function() {
		    return getRandomColor();
		};
		
		// 데이터 변수 선언
		var MonthList = [
			 <c:forEach var="monthList" items="${GraphDataList}">
	         	"${monthList.month}월" ,
	         </c:forEach>
		 ];
		var SumList = [
			 <c:forEach var="sumList" items="${GraphDataList}">
	         	"${sumList.total_sum}" ,
	         </c:forEach>
		 ];
		
// 		$('#classSelect').change(function() {
// 			classCode = $('#classSelect').val();
// 			$.ajax({
// 				url: "graphByClass",
// 				method: "get",
// 				data: { "classCode" : classCode },
// 				success: function(data) {
// 					debugger;
// 					 var TheaterList = [
// 						 <c:forEach var="theater" items="${theaterList}">
// 				         	"${theater.theater_name}" ,
// 				         </c:forEach>
// 					 ];
// 				}
// 			});	
// 		});
		 
		var myChart = new Chart(ctx, {
		    type: 'bar', // 기본적으로 바 차트 설정
		    data: {
		        labels: MonthList,
		        datasets: [{
		            label: '월간 매출 데이터(전체)',
		            data: SumList,
		            backgroundColor: chartColors,
		            borderColor: 'rgb(192, 20, 20)',
		            borderWidth: 2,
		            yAxisID: 'shared-y-axis'  // 바 차트를 위한 y축 ID
		        }]
		    },
		    options: {
		        maintainAspectRatio: false,
		        scales: {
		            yAxes: [{
		                id: 'shared-y-axis', // 동일한 y축 ID
		                type: 'linear',
		                position: 'left',
		                ticks: {
		                    beginAtZero: true
		                },
		                scaleLabel: {
		                    display: true,
		                    labelString: '매출액'
		                }
		            }]
		        }
		    }
		});
		
		// 카테고리에 따른 데이터
		$('#classSelect').change(function() {
			const classCode = $('#classSelect').val();
			$.ajax({
				url : "graphByClass",
				method : "GET",
				data : {
					"classCode" : classCode
				},
				success : function(result) {
					var ChartSumList = [];
					MonthList.forEach(function(e, i){
						var data = result.filter(v => v.month === e.substring(0, 7))[0];
						ChartSumList.push(data ? data.total_sum : 0);
					})
					ChartChange(ChartSumList);
				}
			});
		});
	
		// 라인 차트 추가
		function ChartChange(data) {
			// '월간 매출 데이터 (전체)' 데이터셋을 찾기
		    var datasetIndex = myChart.data.datasets.findIndex(function(dataset) {
		        return dataset.label === '월간 매출 데이터 (클래스)';
		    });

		    // 기존 데이터셋이 있으면 삭제
		    if (datasetIndex !== -1) {
		        myChart.data.datasets.splice(datasetIndex, 1);
		    }
			myChart.data.datasets.push({
			    label: '월간 매출 데이터 (클래스)',
			    data: data,
			    borderColor: 'rgb(256, 0, 0)',
			    borderWidth: 2,
			    fill: false,
			    yAxisID: 'shared-y-axis' // 라인 차트를 위한 y축 ID
			});
		
			// 차트 업데이트
			myChart.update();
		}
		
	</script>

</body>
</html>