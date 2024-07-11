<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 등록폼</title>
<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous">
</script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/admin_form.css" rel="stylesheet" type="text/css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
#event_type_num{
	max-width: 680px;
	padding: 5px;
	background: #fff;
	border-radius: 5px;
	background: #fff;
}
.preview-img {
    max-width: 100%;
    height: auto;
}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">이벤트등록</h4>
				<form class="validation-form" novalidate action="admin-event-regist-pro" enctype="multipart/form-data" method="post" onsubmit="return confirm('이벤트를 등록하시겠습니까?');">
					<div class="mb-3">
						<label for="event_title">이벤트제목</label> 
						<input type="text" name="event_subject" id="event_title" class="form-control" required <c:if test="${not empty event}">value="${event.event_subject}"</c:if>/>
						<div class="invalid-feedback">이벤트 제목을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="event_thumbFile">썸네일</label>
						<input type="file" name="event_thumbFile" id="event_thumbFile" class="form-control" required onchange="previewImage(event, 'thumbnailPreview')" <c:if test="${not empty event}">value="${event.event_thumbnail}"</c:if>/>
						<img id="thumbnailPreview" class="preview-img" src="<c:out value='${event.event_thumbnail}'/>" />
						<div class="invalid-feedback">이미지를 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="event_imageFile">본문이미지</label>
						<input type="file" id="event_imageFile" name="event_imageFile" class="form-control" required onchange="previewImage(event, 'imagePreview')" <c:if test="${not empty event}">value="${event.event_image}"</c:if>/>
						<img id="imagePreview" class="preview-img" src="<c:out value='${event.event_image}'/>" />
						<div class="invalid-feedback">이미지를 선택해주세요.</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="event_start_date">이벤트 시작일</label>
							<input type="date" id="event_start_date" name="event_start_date" class="form-control" required <c:if test="${not empty event}">value="${event.event_start_date}"</c:if>>
							<div class="invalid-feedback">이벤트 시작일을 선택해주세요.</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="event_end_date">이벤트 종료일</label>
							<input type="date" id="event_end_date" name="event_end_date" class="form-control" required <c:if test="${not empty event}">value="${event.event_end_date}"</c:if>>
							<div class="invalid-feedback">이벤트 종료일을 선택해주세요.</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="event_start_date">포인트 지급유무</label>
							<input type="checkbox" id="event_point_active" name="event_point_active" value="true" <c:if test="${event.event_point_active eq true}">checked</c:if>>
							<div class="invalid-feedback">포인트 지급유무를 선택해주세요.</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="event_end_date">지급 포인트</label>
							<input type="text" id="event_point" name="event_point" class="form-control" required <c:if test="${not empty event}">value="${event.event_point}"</c:if>>
							<div class="invalid-feedback">지급포인트를 입력해주세요.</div>
						</div>
					</div>
					<hr class="mb-4">
					<div class="mb-4" align="center">
						<input type="submit" value="등록하기" class="btn btn-primary btn-lg btn-block">
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="history.back()">
					</div>
				</form>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Class Will</p>
		</footer>
	</div>
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

		  // 이벤트 시작일, 종료일 초기값 설정
		  <c:if test="${not empty event}">
			const startDate = '${event.event_start_date}'.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			const endDate = '${event.event_end_date}'.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			$("#event_start_date").val(startDate);
			$("#event_end_date").val(endDate);
		  </c:if>
	    }, false);
	    
	    function previewImage(event, previewId) {
	        var reader = new FileReader();
	        reader.onload = function(){
	            var output = document.getElementById(previewId);
	            output.src = reader.result;
	        };
	        reader.readAsDataURL(event.target.files[0]);
	    }
	    
	    $(function() {
	    	// 이벤트 시작일, 종료일 처리
			$("#event_end_date").change(function() {
				if($("#event_start_date").val() == ""){
					alert("이벤트 시작일을 먼저 선택해주세요");
					$('#event_end_date').val('');
					$("#event_start_date").focus();
				} else {
		            var startDateValue = $("#event_start_date").val();
		            $('#event_end_date').attr('min', startDateValue);
		        }
			});
	    	
			var today = new Date().toISOString().split('T')[0];
			$('#event_start_date').attr('min', today);
			
		    $('#event_start_date').change(function() {
		        $('#event_end_date').attr('min', $(this).val());
		        if($('#event_end_date').val() != '' && $('#event_start_date').val() > $('#event_end_date').val()){
		        	alert("이벤트 종료일을 체크해주세요");
		        	$('#event_start_date').val('');
		        }
		    });
		    $("#event_type_num").change(function() {
				if($("#event_type_num").val() == 3){
						$("#coupon_type_num").prop('disabled',false).css({"background": "white", "color" : "black"});
				} else{
					$("#coupon_type_num").prop('disabled',true);
				}
		    	
			});
		    
		});    
 	</script>
</body>
</html>
