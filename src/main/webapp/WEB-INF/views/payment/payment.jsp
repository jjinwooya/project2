<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ClASS-WILL payment</title>
<!-- 부트스트랩 - js,css -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css"> --%>
<%-- <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script> --%>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/payment.css">

<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
<!-- PortOne - SDK -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>

.margin_use {
	margin-top: 50px;
}
.payment_title {
	display: flex;
	align-items: center;
}
#back_button {
	border: 0;
	background: none;
	background-image: url("${pageContext.request.contextPath}/resources/img/left_arrow.png");
	background-size: cover;
	width:20px;
	height: 20px;
	margin-bottom:3px; 
}
.nav-item {
	color: white;
}
.accordion {
	width: 100%;
	margin-top: 15px;
}
#class_poster {
	background-size: cover;
	max-width: 520px;
	max-height: 240px;
}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
</header>
	<div class="container margin_use">
		<div class="row">
			<div class="payment_title">
				<input type="button" id="back_button" onclick="history.back()">
				<h5>클래스 결제</h5>
			</div>
		</div>
		<div class="row">
			<div class="offset-md-1 col-md-5">
				<div class="card " >
					<h5 class="card-header">클래스 정보</h5>
					<div class="card-body">
						<div class="card payment_status_box">
							<div class="row ">
								<img src="${pageContext.request.contextPath }/resources/img/${payInfo.class_thumnail}" class="img-fluid" id="class_poster" alt="썸네일" >
							</div> <!-- row -->
						</div>
						<h5 class="card-title text-success">클래스 이름</h5>
						<p class="card-text">${payInfo.class_name }</p>
						<h5 class="card-title text-success">클래스 유형</h5>
						<p class="card-text">${payInfo.class_upper }</p>
						<h5 class="card-title text-success">클래스 카테고리</h5>
						<p class="card-text">${payInfo.class_lower }</p>
						<h5 class="card-title text-success">예약 날짜 / 시간</h5>
						<p class="card-text">${payInfo.class_schedule_date } / ${payInfo.class_st_time }~${payInfo.class_ed_time }</p>
						<h5 class="card-title text-success">장소</h5>
						<p class="card-text">${payInfo.class_location }</p>
					</div> <!-- card-body 끝 -->
				</div><!-- card -->
				<div class="card">
					<h5 class="card-header ">연락처 정보</h5>
					<div class="card-body">
						<h5 class="card-title text-success">연락처</h5>
						<p class="card-text">
							<c:set var="phoneNumber" value="${payInfo.member_tel }" />
							<c:set var="formatPhoneNumber" value="${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}" />
							${formatPhoneNumber }
						</p>
						<h5 class="card-title text-success">이메일</h5>
						<p class="card-text">${payInfo.member_email }</p>
						<h5 class="card-title text-success">이름(닉네임)</h5>
						<p class="card-text">${payInfo.member_nickname }</p>
					</div>
				</div>
			</div>
			<!-- 결제 -->
			<div class="col-md-5">
				<!-- 취소 및 환불 안내 -->
				<div class="row ">
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button rounded-bottom" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" >
									취소 및 환불 안내
								</button>
							</h2>
							<div id="collapseOne" class="accordion-collapse collapse " data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<span>날짜 별 취소 및 환불 정책</span><br>
									<ul>
										<li>클래스 시작 3일 전 취소 : 100% 환불</li>
										<li>클래스 시작 당일 이후 취소 : 환불 불가</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 결제 안내 -->
				<div class="row">
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button rounded-bottom" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" >
									결제 안내
								</button>
							</h2>
							<div id="collapseTwo" class="accordion-collapse collapse " data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<ul>
										<li>
											결제 완료 시 온라인 티켓이 발행되며, 클래스 결제/예약 내역 페이지를 통해 티켓을 확인 하실 수 있습니다. 그리고 등록해주신 연락처로 클래스 정보를 포함한 알림이 발송됩니다.
										</li>
										<li>
											웹 페이지 우측 하단의 문의하기(채널톡) 을 통해 문의 주시면 빠르게 도움 드릴 수 있도록 하겠습니다.
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 결제 정보 -->
				<div class="card">
					<h5 class="card-header">결제 정보</h5>
					<div class="card-body">
						<h6 class="card-title">클래스 결제 정보</h6>
						<p class="card-text text-end"><span class="font_color">원데이 수강</span></p>
						<p class="card-text text-end">
							<span class="font_color"><fmt:formatNumber value="${payInfo.class_price }" pattern="#,###" /></span>원
						</p>
						<p class="card-text text-end"><span class="font_color">${payInfo.headcount }</span>명</p>
						<p class="card-text text-end">
							소계:&nbsp; <span class="font_color" id="subtotal">
								<fmt:formatNumber value="${payInfo.subtotal }" pattern="#,###"/>
							</span>원
						</p>
					<hr>
						<h6 class="card-title">WILL-PAY</h6>
						<h6 class="card-title text-end">보유 WILL-PAY &nbsp;<span class="font_color">${payInfo.member_credit }</span>원</h6>
						<div class="col d-flex justify-content-end">
							<input type="text" placeholder="윌페이" id="will_pay_input">
							<input type="button" value="전부 사용" id="will_btnCredit">
						</div>
						<!-- 10 단위 검증 -->
						<div class="col d-flex justify-content-end">
							<p id="result"></p>
						</div>
					<hr>
						<p class="card-text text-end">
							총 결제 금액: 
							<span class="font_color" id="total"></span>만원
						</p>
						<div class="row">
							<div class="col d-flex justify-content-center">
								<a href="javascript:void(0);" class="btn btn-dark w-100" onclick="myFunction()">결제하기</a>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
</footer>
<script>
$(function() {
	let subtotalText = $("#subtotal").text().trim(); //trim()으로 앞뒤 공백 제거
	let subtotal = parseInt(subtotalText.replace(/,/g, ''), 10);
	$("#total").text(subtotal.toLocaleString());
	
	$("#will_pay_input").on("input", function() {
		let willpay = $(this).val();
		let regex = /^\d+0$/;
		
		if (!regex.test(willpay)) {
               $("#result").text('10원 단위로 입력해 주세요');
               $("#result").css("color", "red");
           } else {
           	$('#result').text("");
           }

	});
	//--------------------------------------------
	$("#will_btnCredit").on("click", function() {
// 		let subtotal = parseInt(subtotalValue);
		$.ajax({
			url: "will-pay-all",
			type: "GET",
			data: {
				member_code: "${payInfo.member_code}"
			},
			dataType: 'json',
			success: function(data) {
				let credit = parseInt(data.member_credit);
				
	            if (credit == 0) {
	                $('#will_pay_input').val(0);
	                $('#memberCredit').prop("disabled", true);
	            }
				
				if(credit > subtotal) {
					$("#will_pay_input").val(subtotal);
				} else {
					$("#will_pay_input").val(credit);
				}
				
				//total value 계산
				let total = subtotal - credit;
                if (total < 0) {
                    total = 0;
                }
                // 포맷팅된 값을 HTML 요소에 설정
                $('#total').text(total.toLocaleString());
				
			},
			error: function() {
				alert("호출 실패!");
			}
		});
	});
	//---------------------------------------------------
	//total 관련 자바스크립트
	$("#will_pay_input").on("input", function() {
		let payInput = parseInt($("#will_pay_input").val());
		let total = subtotal - payInput;
		if (total < 0) {
            total = 0;
        }
// 		if(isNaN($("#total")) || $("#will_pay_input").val() === "") {
// 			$("#total").text("0");
// 		}
		
		//형변환
		let subtotalS = subtotal.toString();
		let totalS = total.toString();
		if(payInput > subtotal) {
			//최대값 지정
			$("#will_pay_input").val(subtotalS);
			
			$("#total").text(total);
		} else {
			$("#total").text(total.toLocaleString());
			
			if($("#will_pay_input").val() == "") {
				$("#total").text(subtotal.toLocaleString());
			}
		}
	});
	$('#will_pay_input').on('keydown', function(event) {
        let payInput1 = parseInt($("#will_pay_input").val());

        // Allow backspace, delete, tab, escape, enter, period, and arrow keys
        if ($.inArray(event.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl/cmd+A
            (event.keyCode === 65 && (event.ctrlKey === true || event.metaKey === true)) ||
            // Allow: Ctrl/cmd+C
            (event.keyCode === 67 && (event.ctrlKey === true || event.metaKey === true)) ||
            // Allow: Ctrl/cmd+X
            (event.keyCode === 88 && (event.ctrlKey === true || event.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (event.keyCode >= 35 && event.keyCode <= 39)) {
            return;
        }

        // Ensure that it is a number and stop the keypress
        if ((event.shiftKey || (event.keyCode < 48 || event.keyCode > 57)) &&
            (event.keyCode < 96 || event.keyCode > 105)) {
            event.preventDefault();
        }

        // Prevent entering value that will exceed subtotal
        if (!isNaN(payInput1) && payInput1 >= subtotal && event.keyCode >= 48 && event.keyCode <= 57) {
            event.preventDefault();
        }
    });
});
//-------------------------------------------------------------------------------------------------
function myFunction() {
	//결제 전 유효성 체크
	let willPayCredit = $("#will_pay_input").val();
	let regex = /^\d+0$/;
	
	if(!regex.test(willPayCredit) && willPayCredit != "") {
		alert("10원 단위로 입력해 주세요.");
		return false; // 함수 실행 중단
	}
	//------------------------------------
	let subtotalText = $("#subtotal").text().trim(); //trim()으로 앞뒤 공백 제거
	let subtotal = parseInt(subtotalText.replace(/,/g, ''), 10);
	//사용한 will-pay
	let use_willpay = $("#will_pay_input").val();
	//undefined 일 시 0 저장
	if(!use_willpay) {
		use_willpay = 0;
	}
	console.log("사용한 will-pay", use_willpay);
	
	let pg = "kcp.AO09C";
	let className = "${payInfo.class_name}";
	
	
	let amount = $("#total").text().replace(/,/g, '');
	let parsedAmount = parseInt(amount, 10);
	let member_email = "${payInfo.member_email}";
	let member_name = "${payInfo.member_name}";
	let member_tel = "${payInfo.member_tel}";
	
	let IMP = window.IMP;   // 생략 가능
	IMP.init("imp00262041"); //imp00262041
	IMP.request_pay(
		{
            pg: pg,
            pay_method: "card",
            merchant_uid: "order_" + new Date().getTime(),
            name: className,
            amount: parsedAmount,
//             amount: 1000,
            buyer_email: member_email,
            buyer_name: member_name,
            buyer_tel: member_tel //필수
        },
        function (rsp) {
            if(rsp.success) {
				console.log(rsp.imp_uid);
				$.ajax({
		            url: "verify",
		            type: "POST",
		            data: JSON.stringify({ 
		            	imp_uid: rsp.imp_uid,
		            	merchant_uid : rsp.merchant_uid,
		            	class_code: "${payInfo.class_code}",
		            	class_st_time: "${payInfo.class_st_time}",
		            	class_ed_time: "${payInfo.class_ed_time}",
		            	class_schedule_date : "${payInfo.class_schedule_date}",
		            	pay_headcount: "${payInfo.headcount }",
		            	use_willpay: use_willpay,
		            	member_code: "${payInfo.member_code}",
		            	class_schedule_code: "${payInfo.class_schedule_code}"
		            }),
					contentType: "application/json",
		            dataType: "json",
		            success: function(response) {
		                if(response.success) {
		                    console.log("결제 검증 성공:", response.error);
		                    //GET 방식 결제정보 전달
		                    location.href="payment-final?pay_code=" + response.pay_code;
		                } else {
		                    console.log("결제 검증 실패:", response.error);
		                }
		            },
		            error: function(err) {
		                console.error("결제 검증 요청 실패:", err);
		            }
		        });
            } else {
                alert("사유: " + rsp.error_msg);
            } // if-else

        } // function(rsp)

    );
	
	
}
</script>
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