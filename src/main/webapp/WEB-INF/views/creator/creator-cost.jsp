<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="${pageContext.request.contextPath}/resources/css/creator/creator-cost.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
								<div class="text-white h2">클래스정산</div>
								<hr class="text-white mb-5">
							</div>
							<div align="center">
								<!-- 날짜 선택 셀렉트박스 -->
								<div class="col-md-6  mb-5" >
									<div class="col-xl-8">
										<div class="bg-light rounded py-2 mb-4">
											<label for="monthPicker"></label>
	    									<input type="month" id="monthPicker" name="monthPicker">
										</div>
	<!-- 									<hr class="text-white"> -->
									</div>
								</div>
								
								<div class="creator-event my-3">
									<h5 class="col-md-8 mt-5 text-white mb-3" align="center">💲 상세정산 💲</h5>
									<div class="card col-md-8 my-1 card-body">
	<!-- 								    <div class="d-flex justify-content-start card-content"> -->
	<!-- 									    <p class="card-text">상태&nbsp;:</p> -->
	<!-- 									    <p class="card-text">&nbsp;지급완료</p> -->
	<!-- 								    </div> -->
									    <div class="d-flex justify-content-between card-content">
										    <p class="card-text h6">원데이클래스 수익&nbsp;:</p>
										    <p class="card-text h6 classIncome"></p>
										    
									    </div>
									    <div class="d-flex justify-content-between card-content">
										    <p class="card-text h6">수수료(10%)&nbsp;:</p>
										    <p class="card-text h6 classFee"></p>
									    </div>
									    <div class="d-flex justify-content-between card-content">
										    <p class="card-text h4">정산금&nbsp;:</p>
										    <p class="card-text h4 totalSettle"></p>
									    </div>
									</div>
									
<!-- 									<hr class="col-md-8 text-white mt-5"> -->
									
	<!-- 								<p class="text-white">계좌변경</p> -->
	<!-- 								<div class="regist_account mb-5"> -->
	<!-- 									<input type="button" class="col-md-3" value="+" onclick="linkAccount()"> -->
	<!-- 								</div> -->
									<div class="col-md-8 mt-5">
										<c:choose>
											<c:when test="${token eq null}">
												<h5 class="mb-3 text-white">⚜️ 계좌 등록 ⚜️</h5>
												<input type="button" class="col-md-3" value="+" onclick="linkAccount()">
											</c:when>
											<c:otherwise>
												<h5 class="mb-3 text-white">💳 등록된 계좌 💳</h5>
												<table>
													<tr>
														<td>계좌번호</td>
														<td>${token.account_num}</td>
													</tr>
	<!-- 												<tr> -->
	<!-- 													<td> -->
	<!-- 														계좌변경 -->
	<!-- 													</td> -->
	<!-- 													<td> -->
	<!-- 														<input type="button" class="col-md-6" value="+" onclick="linkAccount()"> -->
	<!-- 													</td> -->
	<!-- 												</tr> -->
												</table>
											</c:otherwise>
										</c:choose>
									</div>
									
<!-- 									<hr class="col-md-8 text-white mt-5"> -->
									
									<h5 class="col-md-8 mt-4 text-white mt-5 mb-3" >💰 총정산금 💰</h5>
									<div class="card col-md-8 mb-5">
									  <div class="card-body">
									  	<div class="d-flex justify-content-between mb-3">
										    <p class="card-title h6" align="left">누적 정산금</p>
											<p class="card-text word-break " >정산기간 : ${settlementDate} ~ </p>
										</div> 
										<form action="creator-settlement" method="Post">
										    <div class="d-flex justify-content-center card-content mb-3">
											    <input type="text" class="card-text word-break h4 mb-3 form-control col-md-4 total_sum" disabled name="total_sum" value="" pattern="#,###"> 
										    </div>
											<button type="submit" class="btn btn-outline-primary btn-lg settlement">정산받기</button>
										</form>
									  </div>
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
<!-- 	<script -->
<!-- 		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script> -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		document.addEventListener('DOMContentLoaded', (event) => {
	        const monthPicker = document.getElementById('monthPicker');
	        const today = new Date();
	
	        // Ensure the date object is correct
	        console.log("Today's date object:", today);
	        
	        // Correctly retrieve year and month
	        const year = today.getFullYear();
	        console.log('Year:' +  year); // Debugging output
	        const month = String(today.getMonth()+1).padStart(2, '0'); // Ensure month is two digits
	        console.log('Month: ' + month); // Debugging output
	
	        // Set default value to current month
	        const currentMonth = year + '-' + month;
	        
	        monthPicker.value = currentMonth;
	        monthPicker.max = currentMonth;
	    });
		
		// 계좌 등록
		function linkAccount() {
			sessionStorage.setItem("redirectUrl", "creator-cost");
			// 새 창을 열어 사용자 인증 서비스 요청(금융결제원 오픈뱅킹 API 활용)
			let authWindow = window.open("about:blank", "authWindow", "width=500, height=700, left=700, top=100" );
			authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
							+ "response_type=code"
							+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
							+ "&redirect_uri=http://localhost:8081/class_will/callback"
							+ "&scope=login inquiry transfer"
							+ "&state=12345678901234567890123456789012"
							+ "&auth_type=0";
		}
		
		// 월에 따른 정산금 불러오기
		$(function() {
			if(${SumSettlement.total_sum} == 0){
				$(".settlement").prop('disabled', true);
			}
			var fmtTotalSum = formatNumber(${SumSettlement.total_sum}*0.9);
			$('.total_sum').val("금액 : " + fmtTotalSum + " 원");
			
			var monthPicker = $("#monthPicker").val();
			monthPick(monthPicker);
			
			$("#monthPicker").change(function() {
				var monthPicker = $("#monthPicker").val();
				monthPick(monthPicker);
			});
			
			function monthPick(monthPicker) {
				$.ajax({
					url: "getMonthSettlement",
					method: "get",
					data: { "monthPicker" : monthPicker },
					success: function(data) {
						console.log(data);
						$(".classIncome").text(formatNumber(data.total_sum) + ' 원');
						$(".classFee").text(formatNumber(data.total_sum * 0.1)  + ' 원');
						$(".totalSettle").text(formatNumber(data.total_sum * 0.9)  + ' 원');
					}
				});
			}
			
			function formatNumber(number) {
			    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			
			
			
		});
	</script>

</body>
</html>