<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>나의 클래스</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js" ></script>
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
		마이페이지<i class="bi bi-cart-check"></i>내가 신청한 클래스
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
							<div class="col-md-12 text-center h2 mb-5">
							<c:forEach var="name" begin="1" end="1" items="${payInfoList }" >
								성장해 나가는 ${name.member_name } 님
							 </c:forEach>
							</div>
							<div class="container">
								<h2>신청한 클래스</h2>
								<p>클래스 정보</p>
								<table class="table table-hover">
									<thead>
										<tr>
											<th>신청 클래스</th>
											<th>클래스 시작 일시</th>
											<th>결제 상태</th>
											<th>사용한 will-pay</th>
											<th>결제 날짜</th>
											<th>환불</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="pay" items="${payInfoList }">
											<c:if test="${pay.pay_status eq 'paid'}">
												<tr>
													<td>
														${pay.class_upper }/ ${pay.class_lower }<br>
														${pay.class_name } 
													</td>
													<td>
														${pay.class_schedule_date }<br>
														${pay.class_st_time } ~ ${pay.class_ed_time }<br>
													</td>
													<td>
														${pay.pg_provider }(${pay.card_name }) ${pay.pay_amount }원<br>
														인원수(${pay.pay_headcount })
													</td>
													<td>
														${pay.use_willpay } WILL-PAY
													</td>
													<td>
														${pay.pay_datetime }<br>
														(${pay.diff_date })
													</td>
													<td>
														<c:if test="${pay.refund_type eq '1' }">
<%-- 															<input type="button" value="환불하기" id="refundClass" onclick="refund('${pay.imp_uid}', '${pay.pay_amount}', '${pay.use_willpay}', '${pay.pay_code}', '${pay.pay_headcount }', '${pay.class_schedule_code }')"> --%>
															<button class="btn btn-dark" id="refundClass" onclick="refundPay('${pay.imp_uid}', '${pay.pay_amount}', '${pay.use_willpay}', '${pay.pay_code}', '${pay.pay_headcount }', '${pay.class_schedule_code }')">환불하기</button>
														</c:if>
													</td>
												</tr>
											</c:if>
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
function refundPay(param_imp_uid, param_amount, param_willpay, param_pay_code, param_pay_headcount, param_class_schedule_code) {
	let imp_uid = param_imp_uid; //imp_uid
	let amount = param_amount; //결제금액
	let willpay = param_willpay; // 윌페이
	let pay_code = param_pay_code; //페이코드
	let headcount = param_pay_headcount; //인원수
	let class_schedule_code = param_class_schedule_code; 
	
	let params = {
			imp_uid : imp_uid,
			amount : amount,
			member_credit : willpay,
			pay_code : pay_code,
			pay_headcount : headcount,
			class_schedule_code : class_schedule_code
	};
	
	if(confirm("환불하시겠습니까?")) {
		$.ajax({
			url: "refund",
			type: "POST",
			data: JSON.stringify(params),
			contentType: "application/json",
			dataType: "json",
			success: function(res) {
	// 			boolean successRefund = res;
				if(res) {
					alert("환불되었습니다.");
		            location.reload();
				}
			},
			error: function() {
				alert("호출 실패");
			}
		});
	}
	
}
	
</script>
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

</body>
</html>