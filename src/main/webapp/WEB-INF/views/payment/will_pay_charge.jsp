<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CLASS-WILL charge</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js "></script>
<style>
body{
	color:white;
}

.full-height{
	height:100vh;
}
.title {
	background: #333333;
	color: white;
	height: 50px;
	display:flex;
	justify-content: center;
}
.title p {
	margin-top: 5px;
	text-align: center;
	font-weight: bold;
}

.custom-bg {
	background: black;
	height: 90vh;
}
.margin_use {
	margin-top: 20px;
}
#result { 
	box-sizing: border-box;
	height:60px;
	padding: 3px;
	margin: 0 15px;
} 
.package_group {
	display: flex;
	flex-flow: wrap;
	justify-content: space-between;
	padding: 0 10px;
}
.cutom-card {
	cursor:pointer;
}
.text_deco {
	text-decoration: line-through;
}
.regist_account input {
	width:100%;
	height:50px;
	border: 5px;
	border-radius:5px;
	background: white;
	font-size: 24px;
}
.account_area {
	width:100%;
	max-height: 500px;
	margin-bottom: 10px;
	position: relative;
}
.btn {
	color:white;
}
.accountInfo {
	width:100%;
	height:50px;
	border: 5px;
	border-radius:5px;
	background: #333333;
	font-size: 24px;
}
.accountInfo button img {
	width:45px;
	hegiht:45px;
}
#buttons-container button{
	display:block;
	width:100%;
	background: black;
}
#buttons-container button:hover{
	background: white;
	color: black !important;
	transition-duration : 0.5s
}
.modal-title {
	color: black;
}
.modal-body {
	color: black;
}
.custom-btn {
	color: white !important;
}
.submit_container {
	display: flex;
    flex-direction: column;
}

.selected {
    background: #336633 !important; /* 클릭 시 배경 색상 */
}
</style>
</head>
<body>
<div class="container full-height">
	<div class="title">
		<p style="font-size: 24px">충전하기</p>
	</div>
<!-- 	<div class="row"> -->
	<div class="row d-flex justify-content-center align-items-center">
		<div class="col-md-6  custom-bg">
			<div class="mx-3 margin_use">
				<label for="will_pay_charge" class="form-label">Will-pay 충전하기</label>
				<input type="text" class="form-control w-75" id="will_pay_charge" placeholder="충전할 금액을 입력해주세요.">
			</div>
			<p id="result"></p>
			<!-- package 종류 -->
			<hr>
			<div class="will_pay_package">
				<div class="mx-3">
					<label class="form-label">package</label>
				</div>
				<!-- package group -->
				<div class="package_group">
					<c:forEach var="package1" items="${packageInfo }" varStatus="status">
						<div class="card border-light mb-3 cutom-card" style="width:180px;">
							<div class="card-header">PLUS PACKAGE</div>
							<div class="card-body">
								<h5 class="card-title">${package1.reward_rate }% 더!</h5>
								<!-- package 가격정보 -->
								<p class="card-text">
									<span class="text_deco" id="text_deco">${package1.reward_fee }원</span><br>
									-> <span class="package_up_price" id="package_up_price">${package1.reward_total }원</span>
								</p>
								<input type="hidden" name="package_price" value="${package1.reward_fee }">
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 선택된 package 가격 -->
				<div class="mx-3">
					<label for="selected_package" class="form-label">선택된 package</label>
					<input type="text" class="form-control w-50" id="selected_package" readonly>
				</div>
				<hr>
			</div>
			<!-- 계좌 연동 시작 -->
			<div class="row">
				<c:choose>
					<c:when test="${empty token }">
						<p>계좌 등록</p>
						<div class="regist_account">
							<input type="button" value="+" onclick="linkAccount()">
						</div>
					</c:when>
					<c:otherwise>
						<div class="row d-flex justify-content-center h-25">
							<div id="buttons-container" class="row">
							</div>
							<div id="modals-container">
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<footer>
				<div class="row submit_container">
					<div class="d-grid btn_area_custom">
						<form action="account-withdraw" method="post" id="withdraw_form">
							<input type="hidden" name="fintech_use_num" id="form_fintech_use_num">
							<input type="hidden" name="user_name" id="form_user_name">
							<input type="hidden" name="tran_amt" id="form_tran_amt">
							<input type="hidden" name="tran_amt_total" id="form_tran_amt_total">
							<input type="hidden" name="will_pay_chargeType" id="will_pay_chargeType">
<%-- 							<input type="hidden" name="member_code" value="${member_code }"> --%>
							<button type="submit" class="btn btn-success w-100" id="chargeBtn">충전하기</button>
						</form>
					</div>		
				</div>			
			</footer>
		</div>
	</div>
</div>
<input type="hidden" value="${token }" id="sessionToken">
<script>
	// JSON 데이터를 JavaScript 변수에 할당
	let	bankInfoJson = JSON.parse('${bankInfoJson}');
		console.log("bankInfoJson1111111111 : " + bankInfoJson + ", dataType " + typeof(bankInfoJson));
</script>
<script src="${pageContext.request.contextPath }/resources/js/will_pay_charge.js"></script>
</body>
</html>