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
								<div class="container">
									<div class="col-md-12 text-center h2 mb-5">오늘은
										${memberDate.member_name}님이 클래스윌을 만난지
										${memberDate.days_since_registration} 일 입니다.</div>
									<div class="row">
										<div class="col">
											<div class="table-responsive">
												<table class="table table-hover">
													<thead>
														<tr>
															<th>회원 이름</th>
															<th>가입일</th>

														</tr>
													</thead>
													<tbody>
														<tr>
															<td>${memberDate.member_name}</td>
															<td>${memberDate.member_reg_date}</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<div class="container">
									<div class="col-md-12 text-center h2 mb-5">그 동안
										${member.member_name}님은 클래스윌과 함께 성장하셨습니다.</div>
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
							<div class="container">
								<div class="col-md-12 text-center h2 mb-5">
									성장을 위해 ${memberDate.member_name} 님은
									<fmt:formatNumber value="${memberMoney.total_amount}"
										type="number" pattern="#,###" />
									원을 투자하셨습니다
								</div>
								<div class="col-md-12 text-right h2 mb-5">성장을 위한 나의 투자</div>
								<div class="row mb-3">
									<div class="col-md-3">
										<label for="year">검색할 연도:</label> <select id="year"
											class="form-control">
											<option value="2024">2024년</option>
										</select>
									</div>
									<div class="col-md-3">
										<label for="month">검색할 월:</label> <select id="month"
											class="form-control">
											<option value="01">1월</option>
											<option value="02">2월</option>
											<option value="03">3월</option>
											<option value="04">4월</option>
											<option value="05">5월</option>
											<option value="06">6월</option>
											<option value="07">7월</option>
											<option value="08">8월</option>
											<option value="09">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select>
									</div>
									<div class="col-md-2">
										<input type="hidden" id="member_code"
											value="${memberMoney.member_code}" />
										<button id="fetchData" class="btn btn-primary mt-4">검색하기
										</button>
									</div>
								</div>
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>결제금액</th>
												<th>결제일</th>
												<th>결제상태</th>
												<th>사용한 윌페이</th>
											</tr>
										</thead>
										<tbody id="dataBody">


										</tbody>
									</table>
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
	            barPercentage: 0.2 // 막대 너비 설정
	        }
	        });
	    } else {
	      console.error("Cannot find canvas element with id 'chart'");
	    }
	  });//그래프용 script 끝!
	
	  	  
	  
	  $(document).ready(function(){
	    $('#fetchData').click(function(){
	        var year = $('#year').val();
	        var month = $('#month').val();
	        var member_code = $('#member_code').val(); 
			
	        if (!year || !month) {
	            alert("검색할 연도와 월을 선택해 주세요.");
	            return;
	        }
	        //console.log('Year:', year);
	        //console.log('Month:', month);
	        //console.log('member_code:', member_code);
	        $.ajax({
	            url: 'fetchPayData',
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ year: year, month: month, member_code: member_code }),
	            success: function(response) {
	                var tbody = $('#dataBody');
	                console.log($('#dataBody'));
	                tbody.empty(); // 기존 데이터 삭제

	                //console.log('Response:', response); // 받은 데이터 콘솔 출력
  					if (response.data && Array.isArray(response.data) && response.data.length > 0) {
                    	response.data.forEach(function(pay) {
	                        //console.log('Pay Code:', pay.pay_code); // 각 pay의 pay_code 출력
	                        //console.log('Pay Amount:', pay.pay_amount); // 각 pay의 pay_amount 출력
	               	 		var formattedAmount = new Intl.NumberFormat('ko-KR').format(pay.pay_amount) + ' 원'; 
	               	  		var formattedUseWillpay = new Intl.NumberFormat('ko-KR').format(pay.use_willpay) + ' 원';
	               	 		var payStatus = pay.pay_status === 'paid' ? '결제완료' : pay.pay_status;
	                        var formattedDate = new Date(pay.pay_datetime).toISOString().split('T')[0];
	                        var row = '<tr>' +
						    '<td>' + formattedAmount + '</td>' +
						    '<td>' + formattedDate + '</td>' +
						    '<td>' + payStatus + '</td>' +
						    '<td>' + formattedUseWillpay + '</td>' +
							'</tr>';

	                        tbody.append(row); // 테이블에 행 추가
	                    });
	                } else {
	                	alert("결제완료 된 데이터가 없습니다.");
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("Error fetching data:", error);
	            }
	        });
	    });
	});
	</script>

</body>
</html>