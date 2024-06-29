<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 등록폼</title>
<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
body {
	min-height: 50vh;
	background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
		to(#1d466c));
	background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 600px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}

.mb-3>select {
	width: 250px;
	padding: 5px;
	border: 1px solid #999;
	font-family: url('http://i.ibb.co/98Vbb8L/gnb-bg.gif') no-repeat 95% 50%;
	border-radius: 2px;
	-webkit-appearance: none;
	-mox-appearance: none;
	appearance: none;
	text-align: center;
}

.subject {
	margin-bottom: 5px;
	width: 300px;
}

.mb-3 {
	margin: 0 auto;
}
.mb-3>input {
	width: 250px;
	padding: 5px;
	border: 1px solid #999;
	font-family: url('http://i.ibb.co/98Vbb8L/gnb-bg.gif') no-repeat 95% 50%;
	border-radius: 2px;
	-webkit-appearance: none;
	-mox-appearance: none;
	appearance: none;
	text-align: center;
}
.space{
	margin-top: 50px;
}
.form-control{
	border: 1px solid #bbb;
}
</style>
</head>
<body>
<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">클래스 상세정보</h4>
				<hr>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">클래스 코드</div>
							<input type="text" id="pay_num" class="form-control" value="${classInfo.class_code }" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">클래스 이름</div>
							<input type="text" id="res_code" class="form-control" value="${classInfo.class_name }" readonly />
						</div>
					</div>
					
					<c:choose>
					    <c:when test="${classInfo.class_type eq 0}">
					        <c:set var="classTypeValue" value="원데이클래스" />
					    </c:when>
					    <c:when test="${classInfo.class_type eq 1}">
					        <c:set var="classTypeValue" value="정기클래스" />
					    </c:when>
					    <c:otherwise>
					        <c:set var="classTypeValue" value="기타 클래스" />
					    </c:otherwise>
					</c:choose>
					
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">클래스 구분</div>
							<input type="text" id="member_id" class="form-control" value="${classTypeValue}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">강사 이름</div>
							<input type="text" id="pay_date" class="form-control" value="${classInfo.member_name}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">대 카테고리</div>
							<input type="text" id="theaterInfo" class="form-control" value="${classInfo.class_big_category}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">소 카테고리</div>
							<input type="text" id="booth_num" class="form-control" value="${classInfo.class_small_category}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">강의위치</div>
							<input type="text" id="res_seat" class="form-control" value="${classInfo.class_location}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">해시태그</div>
							<input type="text" id="movie_date" class="form-control" value="${classInfo.class_hashtag }" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">클래스 가격</div>
							<input type="text" id="screen_round" class="form-control" value="${classInfo.class_price }" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">class_ex</div>
							<input type="text" id="movie_name" class="form-control" value="${classInfo.class_ex }" readonly />
						</div>
						<c:choose>
						    <c:when test="${classInfo.class_regist_status eq 1}">
						        <c:set var="class_type" value="등록대기" />
						    </c:when>
						    <c:when test="${classInfo.class_regist_status eq 2}">
						        <c:set var="class_type" value="등록완료" />
						    </c:when>
						</c:choose>
						<div class="col-md-6">
							<div class="subject">등록 상태</div>
							<input type="text" id="pay_cancel_date" class="form-control" value="${class_type }" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">강사소개</div>
							<input type="text" id="pay_type" class="form-control" value="${classInfo.class_creator_explain}" readonly />
						</div>
<!-- 						<div class="col-md-6"> -->
<!-- 							<div class="subject">결제금액</div> -->
<%-- 							<input type="text" id="pay_amount" class="form-control" value="${reserveDetail.ticket_pay_price}원" readonly /> --%>
<!-- 						</div> -->
<!-- 					</div> -->
		
					<div class="space"></div>
					<hr class="mb-4">
					<div class="mb-4" align="center">
						<c:if test="${classInfo.class_regist_status eq 1}">
							<input type="button" value="등록처리" class="btn btn-primary btn-lg btn-block" onclick="registClass(${classInfo.class_code})">
						</c:if>
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="window.close()">
					</div>
			</div>
		</div>
	</div>
	
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Class Will</p>
		</footer>
	<script>
	    window.addEventListener('load', () => {
	      const forms = document.getElementsByClassName('validation-form');
	
	      Array.prototype.filter.call(forms, (form) => {
	        form.addEventListener('submit', function (event) {
	          if (form.checkValidity() === false) {
	            event.preventDefault();
	            event.stopPropagation();
	          }
	
	          form.classList.add('was-validated');
	        }, false);
	      });
	    }, false);
	    
	    function registClass(code){
			if(confirm("정말 등록처리 하겠습니까?")){
				location.href = "registClass?class_code=" + code;
			}	    		
	    }
 	</script>
</body>
</html>