<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스윌 비밀번호 찾기</title>
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

<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<style type="text/css">
	
	body {
		background: black; 
	}
	
	article {
		margin: 0 auto;
		padding: 0 auto;
		color: white;
	}
	
	.reset-form {
		width: 500px;
		padding: 30px;
		margin-top: 50px;
		margin-bottom: 100px;
	}
	
	.btnLogin {
		padding: 0px 11px;
	}
	
	.regex{ 
		font-size: 15px;
		color: white;
	}
	
	span {
		font-size: 15px;
	}
	
	fieldset {
		width: 300px;
		margin: auto;
	}
</style>
</head>
<body>
	<header>
       	<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
	
	<article>
		<div class="container reset-form text-center">
			<form action="reset-passwd" method="POST">
				<div class="my-5">
					<h2>비밀번호 찾기</h2>
				</div>
				<span>가입하신 이메일 주소를 입력해 주세요.</span><br>
				<span>	이메일 주소로 비밀번호를 재설정할 수 있는 이메일을 보내드립니다.</span><br>
				<span>	발송된 이메일의 비밀번호 재설정은 10분 간 유효합니다.</span><br>
				<fieldset>
					<div class="input-group mt-5 mb-3">
					  <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
					  <input type="text" class="form-control" id="member_email" name="member_email" placeholder="이메일">
					</div>
					<div class="regex mb-3 mt-1" id="regex-email"></div>
					<div class="d-grid gap-2 btnLogin mt-5">
						<input type="button" value="전송하기" class="btn btn-outline-light btn-lg" onclick="sendMail()">
					</div>
				</fieldset>
			</form>
			<div class="mt-3 mb-5">
				<a href="member-login" class="text-center"><u>로그인하기</u></a>
			</div>
		</div>
	</article>
	
	
	
	<footer>
      	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"/>
	</footer>
	
	
    <!-- JavaScript Libraries -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
	
	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	
	<script>
		$(function() {
			// 이메일 정규표현식
			$("#member_email").on("input", function() {
				let inputEmail = $(this).val();
				let regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 형식
				
				 if (!regex.test(inputEmail)) {
			            $("#regex-email").text("올바르지 않은 이메일 형식입니다.");
			            $("#regex-email").css("color", "#FF4848");
			        } else {
			            $("#regex-email").text("");
			        }
			});
		
		});
		
		function sendMail() {
			
			$.ajax({
				type: "POST",
		        url: "find-passwd",
		    	data : {
			 		member_email : $("#member_email").val()
			 	},
			 	dataType : "json",
			 	success : function(result) {
			 		if(result) {
			 			alert("메일 발송이 완료되었습니다.\n메일함을 확인해 주세요.");
			 		} else {
			 			if(confirm("해당 이메일로 가입된 계정이 존재하지 않습니다.\n회원가입하시겠습니까?")) {
			 				location.href="member-join";
			 			}
			 		}
					
				},
				error : function() {
					alert("ajax 에러");
				}
				
				
				
			}); // ajax()
			
		} // sendMail()
		
		
		
		
		
	
	</script>
</body>
</html>