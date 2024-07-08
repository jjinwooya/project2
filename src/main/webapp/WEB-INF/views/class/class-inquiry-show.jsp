<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 문의</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js" ></script>
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-review-form.css" rel="stylesheet">
</head>
<body>
		<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<c:forEach var="map" items="${classInquiry}">
						<h4 class="mb-4">클래스 문의</h4>
							<div>
								<p>🔸참여클래스 : ${map.class_name}</p>
								<p>🔸작성자 : ${map.member_nickname}</p>
								<p>🔸작성일 : ${map.class_inquiry_date} ${map.class_inquiry_time}</p>
							</div>
							<div class="mb-3">
								<label for="inquiry-subject">제목</label>
								<input type="text" class="form-control" id="inquiry-content" value="${map.class_inquiry_subject}" readonly>
							</div>
							<div class="mb-3">
								<label for="inquiry-content">내용</label>
								    <textarea rows="10" id="inquiry-content" class="form-control" readonly>${map.class_inquiry_content}</textarea>
							</div>
							
							<hr class="mb-4">
							
							<div class="mb-4 creator-review-form-btn" align="center">
								<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="window.close()">
							</div>
<%-- 					</c:if> --%>
				</c:forEach>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; WillClass</p>
		</footer>
	</div>

</body>
</html>