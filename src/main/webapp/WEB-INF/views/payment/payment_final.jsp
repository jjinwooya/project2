<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>클래스윌 결제 완료</title>
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
    window.onpopstate = function () {  //onpopstate 뒤로가기 버튼
        history.go(1);
    };
</script>
</head>
<body>
	<div class="container">
		<div class="row">
		<div class="payment_all">
			<h2>정상적으로 <span class="text-success">결제 완료</span> 되었습니다. </h2>	
			<div>
				<h5 class="text-success">결제 내역</h5>
				<p>주문번호 : ${paySuccessInfo.pay_merchant_uid}</p>
				<p>결제일시 : 
<%-- 					<fmt:parseDate value="${pay.class_pay_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate"/> --%>
<%-- 					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
					${paySuccessInfo.pay_datetime} 
				</p>
			</div>
			<div>
				<h5 class="text-success">결제 정보</h5>
				<p>결제종류 : ${paySuccessInfo.card_name}(${paySuccessInfo.pg_provider})</p>
				<p>결제수단 : ${paySuccessInfo.pay_type}</p>
				<hr>
				<p>클래스 가격(인원수:&nbsp;${paySuccessInfo.pay_headcount}) :
					<fmt:formatNumber value="${paySuccessInfo.total_amount}" var="total" pattern="#,###"/> 
					${total}원
				</p>
				<p>
					WILL-PAY 사용금액 :
					<fmt:formatNumber value="${paySuccessInfo.use_willpay}" var="amount" pattern="#,###"/> 
					${amount}원
				</p>
				<hr>
				<p>
					<b>최종 결제금액 :
					<fmt:formatNumber value="${paySuccessInfo.result_amount}" var="result" pattern="#,###"/> 
					${result} 원
					</b>
				</p>
			</div>
			<div>
				<h5 class="text-success">클래스 정보</h5>
				<div class="row" id="reserve_info">
					<div class="col text-center">
						<img src="${pageContext.request.contextPath }/resources/img/oh.png" id="class_poster" alt="썸네일" style="width: 250px;" >
					</div>
					<div class="col">
						<ul class="list-group list-group-flush">
							<li class="list-group-item custom-bg">
							 	<!-- 클래스 유형 -->
								<p class="class_info">카테고리(상세):</p>
								<span class="class_detail">${paySuccessInfo.upper_level}(${paySuccessInfo.lower_level})  </span>
							</li>
							<li class="list-group-item custom-bg">
								<!-- 클래스 이름 -->
								<p class="class_info">클래스 이름: </p>
								<span class="class_detail">${paySuccessInfo.class_name}</span>
							</li>
							<li class="list-group-item custom-bg">
								<!-- 클래스 일시 -->
								<p class="class_info">일시: </p>
								<span class="class_detail">${paySuccessInfo.class_schedule_date}</span>
							</li>
							<li class="list-group-item custom-bg">
								<!--클래스 장소 -->
								<p class="class_info">장소: </p>
								<span class="class_detail">${paySuccessInfo.class_location}</span>
							</li>
							<li class="list-group-item custom-bg">
								<!--  시작 시간~ 끝나는 시간 -->
								<p class="class_info"> 시작시간 ~ 종료시간</p>
								<span class="class_detail"> 
									<img src="${pageContext.request.contextPath}/resources/img/pay_clock.svg" style="width: 15px;">
									${paySuccessInfo.class_st_time} ~ ${paySuccessInfo.class_ed_time}
								</span>
							</li>
						</ul>
					</div>
				</div> <!-- row -->
				<div class="row mt-5">
					<div class="d-flex justify-content-center bg-secondary-subtle rounded-bottom p-2">
						<button class="btn btn-dark mx-2" type="button" onclick="location.href='my-class'">결제 내역 확인</button>
						<button class="btn btn-dark mx-2" type="button" onclick="location.href='./'">클래스윌 메인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>

</html>