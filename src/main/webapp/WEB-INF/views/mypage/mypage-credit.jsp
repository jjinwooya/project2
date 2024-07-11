<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>나의 클래스</title>
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
.refundBtn {
	display: none;
}
.refund_product {
	color:green;
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
		마이페이지<i class="bi bi-wallet"></i>윌페이
	</h1>

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
							<div class="col-md-12 text-center h2 mb-5">윌페이 사용 내역</div>
							<div class="container">
								<c:forEach begin="1" end="1" var="credit" items="${willpayChargeInfoList }">
									<h2>윌페이 잔액 <fmt:formatNumber value="${credit.member_credit}" type="number" pattern="#,###" /> 원</h2>
								</c:forEach>
								<a href="will-pay-charge" class="btn btn-primary">계좌 등록 및 충전</a>
								<button class="btn btn-light w-25" id="refundAgreeBtn" onclick="openPopUp()">환불 정책 동의</button>
								<button class="btn btn-light w-25 refundBtn" id="refundInputBtn" onclick="openPopUpRefund()">
									환불하기
								</button>
								<p style="margin-top:10px;">충전 내역</p>
								<table class="table table-hover">
									<thead>
										<tr>
											<th>WILL-PAY</th>
											<th>결제된 금액</th>
											<th>충전된 WILL-PAY</th>
											<th>충전 일시</th>
											<th>은행(계좌번호)</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="chargeInfo" items="${willpayChargeInfoList }">
											<tr>
												<td>${chargeInfo.pay_type }</td>
												<td>
													<fmt:formatNumber var="amt" value="${chargeInfo.will_pay_amount }"  pattern="#,###"/>
													${amt}원
												</td>
												<td>
													<fmt:formatNumber var="willpay_amt" value="${chargeInfo.will_pay_get_pay }"  pattern="#,###"/>
													${willpay_amt} WILL-PAY
												</td>
												<td>${chargeInfo.will_pay_date }&nbsp;(${chargeInfo.diff_date})</td>
												<td>${chargeInfo.will_pay_bank_name }&nbsp;(${chargeInfo.will_pay_account })</td>
												<td>
													<c:choose>
														<c:when test="${chargeInfo.will_pay_chargeType eq 2 }">
															<span class="refund_product">부분 환불가능</span>
														</c:when>
														<c:otherwise>
															<span class="refund_product">환불 가능상품</span>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:forEach>
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
<!-- Fruits Shop End-->



<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
<script>
	function openPopUp() {
		window.open("refund-agreeTerms", "agree", "width=544, height=532, top=270, left=700");			
	}
	
	function showRefundBtn() {
		$('#refundInputBtn').show();
		$("#refundAgreeBtn").hide();
	}
	
	function openPopUpRefund() {
		window.open("refund-inputRefund", "inputRefund", "width=544, height=532, top=270, left=700");	
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