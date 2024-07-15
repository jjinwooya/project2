<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CLASS-WILL event</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

<!-- Icon Font Stylesheet -->
<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/> -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>


<!-- Libraries Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">

<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

body {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
  color : white;
}
main {
	width: 1400px;
	margin: 0 auto;
}

tr td{
 	border: 1px solid lightgray; 
}
.eventTable{
	margin: 0 auto;
	width: 60%;
	text-align: center;
	font-size: 20px;
	margin-top: 40px;
}
tr{
	height: 60px;
}
td > img{
	width: 100%;
}

.margin_use {
	margin-top: 40px;
}
.tab-pane {
	margin-top: 20px;
}

</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
</header>
<div class="container">
	<div class="row margin_use mx-5">
		<p class="fs-4 text-white"><i class="fa-duotone fa-gift"></i>친구 초대 이벤트</p>	
	</div>
	<div class="row">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">초대 메일 발송</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">추천 코드 입력</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">Contact</button>
			</li>
		</ul>
		
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
				<h5> 초대 메일 발송 </h5>
				<p>초대 하실 친구분의 메일 계정을 입력해 주세요</p>
				<p>나의 추천인 코드 : ${invite_code}</p>
				<p>친구 초대 메일 발송하기</p>
				<input type="text" placeholder="이메일" id="friendEmail">
				<input type="button" value="이메일 발송하기" id="sendingMail" onclick="javascript:sendingMail('${invite_code}')">
			</div>
			<div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
				<h5> 초대 메일 발송 </h5>
				<p>초대해 주신 친구 분의 코드를 입력해 주세요</p>
				<input type="text" placeholder="코드" id="invite_code">
				<input type="button" value="코드입력" onclick="javascript:requestInvite('${invite_code}')">
			</div>
			<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
				<div>
					초대 코드   : ${invite_info.invite_code} <br>
					연결된 친구 : ${invite_info.friend_email }
				</div>
			</div>
		</div>
	</div><!-- row 끝 -->
	<div align="center">
		<button type="submit" class="btn btn-outline-primary" id="searchBtn" onclick="goEventMain()">목록으로</button>
	</div>
</div>

	



<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
</footer>
<!-- JavaScript Libraries -->
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

<script type="text/javascript">
	function goEventMain() {
		location.href="event";
	}
	
	function requestInvite(invite_code){
		$.ajax({
			type: "post", 			
			url: "RequestInvite", 		
			data: {					
				invite_code: invite_code
			},
		 	dataType: "text", 		
		 	success: function (response) {
		 		if(response === "true"){
		 			alert("이벤트 등록 완료, 포인트를 획득하셨습니다");
		 			location.href = "eventDetail?event_code=0&tab=contact";
		 		}else{
		 			alert(response);
		 		}			
			},
			error: function (xhr, status, error) { 
				 console.log("error", e, status);
			}
		 });//end ajax	
	}
	
	function sendingMail(invite_code){
		 $.ajax({
				type: "post", 			
				url: "SendingEmail", 		
				data: {					
					friend_email: $("#friendEmail").val(), 
					invite_code: invite_code
				},
			 	dataType: "text", 		
			 	success: function (response) {
			 		if(response === "true"){
			 			alert("메일 발송 완료");
			 		}else{
			 			alert(response);
			 		}			
				},
				error: function (xhr, status, error) { 
					 console.log("error", e, status);
				}
			 });//end ajax 
	}
	
	
	$(document).ready(function() {
	    var tab = "${tab}";
	    var inviteCode = "${invite_code}";
		
	    if (tab === 'code') {
	        $('#profile-tab').tab('show');
	        $('#invite_code').val(inviteCode);
	    }else if(tab === 'contact'){
	    	$('#contact-tab').tab('show');
	    }
	    
	});
</script>


</body>
</html>