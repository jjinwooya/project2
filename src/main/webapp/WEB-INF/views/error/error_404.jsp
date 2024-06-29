<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<!--  Bootstrap  -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!--  클래스 리스트 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/class_list.css">

<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>

	<header>
		<jsp:include page = "../inc/top.jsp"></jsp:include>
	</header>

	<article class="col-md-12 d-flex justify-content-center" style="margin: 100px auto;">
		<div>
			<h3 class="mb-5">죄송합니다.요청하신 페이지를 찾을 수 없습니다.</h3>
			<h5 style="line-height: 50px;">
				방문하시려는 페이지의 주소가 잘못 입력되었거나,<br>
				페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.<br>
				입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.<br>
				관련 문의사항은 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.<br>
				감사합니다.<br>
			</h5>
		</div>
	</article>
	
	<footer>
		<jsp:include page = "../inc/bottom.jsp"></jsp:include>
	</footer>

</body>
</html>