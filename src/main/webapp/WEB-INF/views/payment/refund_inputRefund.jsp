<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>환불</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style>
    html, body {
        height: 100%;
        margin: 0;
    }
    .full-height {
        height: 100%;
        margin: 0;
       	padding: 0;
    }
    .card {
        width: 100%;
        height: 100%;
        margin: 0;
        border: none; /* 카드 테두리 제거 */
        border-radius: 0; /* 카드 모서리 둥글게 제거 */
    }
    .card-body {
    	border: white !important;
    }
    .text_color {
    	color: green;
    }
    #will_pay_amt {
    	margin-top: 7px;
    }
    
    .form-group-center {
      	display: flex;
      	justify-content: center;
    }
</style>
</head>
<body>
<div class="container-fluid full-height d-flex align-items-center justify-content-center">
	<div class="card text-center w-100 h-100">
		<div class="card-header text-bg-secondary">
		 	환불
		</div>
		<div class="card-body text-bg-dark d-column justify-content-center" >
			<h5 class="card-title">환불가능 금액</h5>
			<p class="card-text">
				<span class="text_color">현재 WILL-PAY :</span>
				<span id="remainedWillpay">&nbsp;${member_willpay }</span>원
				<br>
				<span class="text_color">환불 가능한 WILL-PAY :</span>
				<span id="abledWillpay">&nbsp;${member_abledWillpay}</span>원
			</p>
			<div class="form-group form-group-center">
				<input type="text" class="form-control w-50" id="will_pay_refund_amt" placeholder="금액을 입력해 주세요">
			</div>
			<button type="submit" class="btn btn-light mt-3" onclick="refundWillpay('${member_abledWillpay}')">환불하기</button>
		</div>
		<div class="card-footer text-bg-secondary">
		  CLASS-WILL
		</div>
	</div>
</div>
<script>
$(function() {
	//LocaleString() - 포맷팅
	let remainedWillpay = $("#remainedWillpay").text();
	let remainWillpay = parseInt(remainedWillpay);
	$("#remainedWillpay").text(remainWillpay.toLocaleString());
	
	let abledWillpay = $("#abledWillpay").text();
	let ableWillpay = parseInt(abledWillpay);
	$("#abledWillpay").text(ableWillpay.toLocaleString());
});
</script>
<script>
function refundWillpay() {
	let refundAmt = $("#will_pay_refund_amt").val();
	let abledWillpay = $("#abledWillpay").text();
	
	let refundAmtParse = parseInt(refundAmt);
	let abledWillpayParse = parseInt(abledWillpay);
	
	let regex = /^[1-9]\d*0$/; // 0이 아닌 양의 정수를 검사하는 정규식
	
	if(refundAmtParse > abledWillpayParse) {
		alert("환불할 수 없는 금액입니다").
		return;
	}

	if (!regex.test(refundAmt)) {
		alert("숫자를 10원 단위로 입력해 주세요");
		return;
	}
	//------------------------------------
	
	$.ajax({
		url: "refund-willpay",
		type: "GET",
		data: {
			tran_amt : refundAmt
		},
// 		contentType: "application/json",
		dataType: "json",
		success: function(res) {
			console.log(res);
			if(res) {
				alert("환불이 완료 되었습니다.");
				window.close();
				if (window.opener && !window.opener.closed) {
					window.opener.location.reload(); // 부모 창 새로 고침
				}
			}
		},
		error: function() {
			alert("호출 실패");
		}
	});
}
	
</script>
</body>
</html>