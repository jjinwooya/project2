<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 리뷰</title>
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

<!-- 별점 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">

.starStyle{
	color : #DC143C ;	
}
</style>
</head>
<body>
		<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
<%-- 			<c:set var="map" value="${classInquiry}"/> --%>
				<c:forEach var="map" items="${classReview}">
<%-- 					<c:if test="${member_code eq map.member_code}"> --%>
						<h4 class="mb-4">클래스리뷰</h4>
							<div>
								<p>🔸참여클래스 : ${map.class_name}</p>
								<p>🔸작성자 : ${map.member_nickname}</p>
								<p>🔸작성일 : ${map.class_review_date} ${map.class_review_time}</p>
							</div>
							<div class="reviewStar reviewStar1 col" onclick="creatorReview(event, '${param.class_code}')" style="text-align : left">
								<ul class="list-inline small">
        							<p style="display: inline-block; margin-right: 10px;">🔸별점 :</p>
									<c:forEach begin="1" end="${map.class_review_rating}">
										<li class="list-inline-item m-0"><i class="fa fa-star starStyle"></i></li>
									</c:forEach>
									<c:forEach begin="${map.class_review_rating + 1}" end="5">
										<li class="list-inline-item m-0"><i class="fa fa-star-o starStyle"></i></li>
									</c:forEach>
								</ul>
							</div> <!-- reviewStar -->
						
							<div class="mb-3">
								<label for="inquiry-subject">리뷰제목</label>
								<input type="text" class="form-control" id="inquiry-content" value="${map.class_review_subject}" readonly>
		<%-- 						${map.class_inquiry_subject} --%>
							</div>
							<div class="mb-3">
								<label for="inquiry-content">리뷰내용</label>
								<textarea rows="10" id="inquiry-content" class="form-control" readonly>${map.class_review_content}</textarea>
							</div>
							
							<hr class="mb-4">
							
							<div class="mb-4 creator-review-form-btn" align="center">
								<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="window.close()">
							</div>
					
<!-- 					<form class="validation-form creator-reaply-form" novalidate action="creator-review-replyPro" method="post" onsubmit="reviewSubmit()"> -->
					
<!-- 					</form> -->
<%-- 					</c:if> --%>
				</c:forEach>
			</div>
		</div> <!-- input-form-backgroud row -->
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; WillClass</p>
		</footer>
	</div> <!-- container -->

</body>
</html>