<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스윌 환불규정</title>
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

<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
	
	body {
		background: black; 
	}
	
	article {
		margin: 0 auto;
		padding: 0 auto;
	}
	
	.refund-info {
		width: 1200px;
		padding: 50px;
	}
	
	.list {
		padding: 15px;
	}
	
	
	

</style>
</head>
<body>
	<header>
       	<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
	
	<article>
		<div class="container refund-info">
			<h3>환불규정</h3>
			<br>
			<br>
						
			<h4>취소환불규정</h4>
			<br>
			
			<h5>제 24 조 (회사의 환불 정책)</h5>
			<br>
			
			<p>① 구매한 상품에 대한 취소 및 환불은 아래의 내용을 따릅니다. 취소 처리가 가능한 결제 방식에 대해서는 취소 처리드리며, 취소 처리가 불가한 방식에 대해서는 계좌 입금 방식으로 환불 처리를 드리게 됩니다. 사용하신 쿠폰 및 포인트가 있는 경우는 해당 금액을 제외하고 환불드리며, 쿠폰과 포인트는 사용 하신 쿠폰 또는 포인트의 형태로 재생성해 드립니다.</p>
			
			<p>[취소 및 환불 약관]</p>
			<div class="list">
				- 정해진 사용 날짜가 있는 경우, 이틀 전까지 전액 환불 드리며, 수업 전날과 수업 당일은 환불이 불가합니다.<br>
				- 정해진 사용 날짜가 없는 상품의 경우, 구매 후 1개월 이내로는 환불 드리며, 1개월 이후로는 환불 드리지 않습니다.<br>
				- 이미 사용한 상품에 대해서는 환불이 불가합니다. 다만, Host의 동의가 있는 경우 환불이 가능합니다.<br>
				- Host의 사유로 인해 상품이 사용 되지 못한 경우에는 기간에 관계없이 환불이 가능합니다.<br>
			</div>
			<br>
			
		</div>
	</article>

	<footer>
      	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"/>
	</footer>
</body>
</html>