<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>WILL-PAY 충전 완료</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');
	* {
	  font-family: "Nanum Gothic", sans-serif;
	  font-weight: 400;
	  font-style: normal;
	}

	body { 
		margin: 0; 
		padding:0;
		background: black;
		color: white;
 	}

	article {
		margin: auto;
	}
	
	.payment_all{
		width: 700px;
		margin: 30px auto;
		border: 1px solid gray;
		border-radius: 10px;
	}
	
	#reserve_info {
		width: 700px;
	}

	h2 {
		text-align: center;
		margin: 50px 0;
	}
	
	h5 {
		margin-top: 30px;
	}
	.custom-bg {
		background: #CCCCCC;
	}
	.class_info {
		color: #660066;
		font-size: 0.8em;
	}
	.class_detail {
		display: flex;
		justify-content: flex-end;
	}
</style>
<script type="text/javascript">
    window.history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
    };
</script>
</head>
<body>
	<div class="container">
		<div class="row">
		<div class="payment_all">
			<h2>정상적으로 <span class="text-success">충전 완료</span> 되었습니다. </h2>	
			<div>
				<h5 class="text-success">충전 내역</h5>
				<p>은행 이름 : ${withdrawResult.will_pay_bank_name}</p>
				<p>
					<fmt:formatNumber var="withdraw_amt" value="${withdrawResult.will_pay_amount }" pattern="#,###"/>
					이체된 금액 : ${withdraw_amt}원
				</p> 
				<p>결제일시 : ${withdrawResult.will_pay_date}</p>
				<hr>
				<p><span class="text-success">충전된 WILL-PAY</span>
					<fmt:formatNumber var="amt" value="${withdrawResult.will_pay_get_pay }" pattern="#,###"/>
					: ${amt}원
				</p>
<!-- 						<p><span class="text-success">충전된 WILL-PAY</span> -->
<%-- 							<fmt:formatNumber var="amt_total" value="${withdrawResult.tran_amt_total }" pattern="#,###"/> --%>
<%-- 							: ${amt_total}원 --%>
<!-- 						</p> -->
				<p><span class="text-success">현재 보유 WILL-PAY</span>
					<fmt:formatNumber var="remain" value="${withdrawResult.member_credit }" pattern="#,###"/>
					: ${remain}원
				</p>
			</div>
			<div>
				<div class="row mt-5">
					<div class="d-flex justify-content-center bg-secondary-subtle rounded-bottom p-2">
						<button class="btn btn-dark mx-2" type="button" onclick="location.href='my-credit'">결제 내역 확인</button>
						<button class="btn btn-dark mx-2" type="button" onclick="location.href='./'">클래스윌 메인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>

</html>