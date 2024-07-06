<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>환불 정책 동의</title>
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
</style>
</head>
<body>
<div class="container-fluid full-height d-flex align-items-center justify-content-center">
	<div class="card text-center w-100 h-100">
		<div class="card-header text-bg-secondary">
		 	환불 약관
		</div>
		<div class="card-body text-bg-dark">
			<h5 class="card-title">환불약관 동의</h5>
			<p class="card-text">
				보너스로 제공된 금액은 환불되지 않습니다. <br>
				사용자는 7일 이내에 서비스를 이용하지 않을 시 환불을 이용하실 수 없습니다.<br>
				실제 충전 금액 중 사용되지 않은 잔액에 대해서만 환불받을 수 있습니다.<br>
			</p>
			<a href="#" class="btn btn-light" id="agreeButton">동의하기</a>
		</div>
		<div class="card-footer text-bg-secondary">
		  CLASS-WILL
		</div>
	</div>
</div>
<script>
$('#agreeButton').click(function() {
	if (window.opener && !window.opener.closed) {
		window.opener.showRefundBtn();  // 부모 창의 함수를 호출하여 버튼을 보이게 합니다.
		window.close();  // 팝업창을 닫습니다.
	}
});	
</script>
</body>
</html>