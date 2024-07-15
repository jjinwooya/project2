<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 상세보기</title>
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
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
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
				<h4 class="mb-4">클래스 신고 상세정보</h4>
				<hr>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">회원 이메일</div>
							<input type="text" id="pay_num" class="form-control" value="${report.member_email}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">클래스 이름</div>
							<input type="text" id="res_code" class="form-control" value="${report.class_name }" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">신고 카테고리</div>
							<input type="text" id="member_id" class="form-control" value="${report.category }" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">처리상태</div>
							<input type="text" id="movie_name" class="form-control" value="${report.class_report_status}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<textarea rows="5" cols="30" readonly="readonly">${report.class_report_content}</textarea>
					</div>
					<div class="space"></div>
					<hr class="mb-4">
					<div class="mb-4" align="center">
						<input type="button" value="클래스 상세페이지" class="btn btn-primary btn-lg btn-block" onclick="classDetail(${report.class_code})">
						<input type="button" value="처리" class="btn btn-primary btn-lg btn-block" onclick="showModal()">
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="window.close()">
					</div>
			</div>
		</div>
	</div>
	
	<!-- 모달창 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">처리 옵션 선택</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>원하는 처리를 선택하세요:</p>
	        <button type="button" class="btn btn-danger" onclick="hideClass(${report.class_report_code},${report.class_code})">클래스 숨김 처리</button>
	        <button type="button" class="btn btn-secondary" onclick="cancelReport(${report.class_report_code})">신고 취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료-->
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Class Will</p>
		</footer>
<script>
	// 모달 표시 함수
	function showModal() {
	  $('#exampleModal').modal('show'); // 부트스트랩 모달 표시
	}
	
	// 클래스 숨김 처리 함수
	function hideClass(class_report_code, class_code) {
	  $.ajax({
		 url : "hideClass",
		 method : "POST",
		 data : {
			 class_report_code : class_report_code,
			 class_code : class_code,
		 },
		 success : function(response){
			 if(response == "true"){
				 alert('클래스가 숨겨졌습니다.');
				 window.close();
				 window.opener.location.reload();
			 }else{
				 alert('데이터 오류.');
			 }
		 }
	  });
	  $('#exampleModal').modal('hide'); // 모달 닫기

	}
	
	// 신고 취소 함수
	function cancelReport(class_report_code) {
	  $.ajax({
		 url : "cancelReport",
		 method : "POST",
		 data : {
		        class_report_code: class_report_code
		}, 
		 success : function(response){
			 if(response == "true"){
				alert('신고가 취소되었습니다');	 
				// 자식 창 닫기
				window.close();
				// 부모 창 새로고침
				window.opener.location.reload();
			 }else{
				 alert('데이터 오류.');
			 }
		 }
	  });
	}
	
	
	function classDetail(class_code){
		location.href="class-detail?class_code=" + class_code + "&fromReport=true";
	}
</script>
</body>
</html>