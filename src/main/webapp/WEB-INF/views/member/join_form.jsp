<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>클래스윌 회원가입</title>
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
	}
	
	.join-form {
		width: 500px;
		padding: 30px;
		margin-top: 50px;
		margin-bottom: 100px;
		
	}
	
	fieldset {
		background: rgb(183, 183, 183, 0.5);
		padding: 20px;
		color: white;
		border-radius: 10px; 
		
	}
	
	fieldset a {
		text-decoration: underline;
	}
	
	.auth-choice {
		text-align: center;
	}
	
	.auth-detail {
		cursor: pointer;
		font-size: 13px;
		margin: 0 auto;
	}
	
	.form-check {
		margin: 8px;
	}
	
	ul {
		list-style: none;
	}
	
	.modal-content {
		background: #333;
		width: 600px;
		color: white;
	}
	
	.modal-body {
		background: #4d4d4d;
	}
	
	table {
		margin: 20px;
		padding: 15px;
		
	}
	th, td, li {
		color: white;
	}
	
	h2 {
		color: white;
		margin: 30px;
		text-align: center;
	}
	
	#phone-auth-btn {
		height: 58px;
		width: 145px;;
		border-radius: 10px;
		background: #FFCC80;
	}
	
	.form-check-center {
		margin-left: 30px;
	}
	
	.join-form-input {
		margin: 10px;
	}
	
	.regex {
		margin: 0;
		padding: 0;
		font-size: 12px;
	}
	
	@media (min-width: 992px) {
/* 	    .offcanvas { */
/* 	        display: none !important; /* 992px 이상 화면에서는 offcanvas 숨기기 */ */
/* 	    } */
	    
	}
	
</style>

</head>
<body>

	<header>
       	<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
	
	<article>
		<div class="container join-form">
			<form action="member-join" method="POST">
				<h2>회원가입</h2>
				<div class="form-floating mt-3">
					<input type="text" class="form-control" id="member_name" name="member_name" placeholder="name" required maxlength="30">
					<label for="name">이름</label>
				</div>
				<div class="regex" id="regex-name"></div>
				
				<div class="form-floating mt-3">
					<input type="email" class="form-control" id="member_email" name="member_email" placeholder="name@example.com" required maxlength="50">
					<label for="email">이메일</label>
				</div>
				<div class="regex" id="regex-email"></div>
				<div class="form-floating mt-3">
					<input type="password" class="form-control" id="member_pwd" name="member_pwd" placeholder="Password" required maxlength="20">
					<label for="passwd">비밀번호</label>
				</div>
				<div class="regex " id="regex-pwd"></div>
				
				<div class="row nav-fill" > 
					<div class="col-8">
						<div class="form-floating mt-3">
							<input type="text" class="form-control" id="member_tel" name="member_tel" placeholder="010-1234-5678" required maxlength="13">
							<label for="phone_number">휴대전화</label>
						</div>
						<div class="regex" id="regex-tel"></div>
					</div>	
					<div class="d-grid gap-2 col-4 mt-3" style="height: 58px; padding: 0">
						<button class="float-start" type="button" id="phone-auth-btn" onclick="authSms()">인증번호 전송</button>
					</div>	
				</div>
				<div class="form-floating mt-3 mb-3" id="sms-auth">
<!-- 					<input type="text" class="form-control" id="phone_auth_number" name="phone_auth_number" placeholder="123456" required> -->
<!-- 					<label for="phone_auth_number">인증번호</label> -->
				</div>
				<div class="regex" id="regex-auth"></div>
				<fieldset>
					<h5>서비스 정책</h5>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="" id="allCheck" name="check-agree">
						<label class="form-check-label" for="allCheck">
							전체동의
						</label>
					</div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="" id="ageAgree" name="check-agree" required>
						<label class="form-check-label" for="ageAgree">
							만14세 이상입니다.(필수)
						</label>
						
					</div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="" id="serviceAgree" name="check-agree" required>
						<label class="form-check-label" for="serviceAgree">
							서비스 이용약관 동의 (필수)
						</label>
						<a class="auth-detail float-end link" data-bs-toggle="modal" data-bs-target="#serviceAgreeInfo">내용보기</a>
					</div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="" id="personerAgree" name="check-agree" required>
						<label class="form-check-label" for="personerAgree">
							개인정보 수집 및 이용 동의 (필수)
						</label>
						<a class="auth-detail float-end" data-bs-toggle="modal" data-bs-target="#personerAgreeInfo">내용보기</a>
					</div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="" id="marketing-all" name="check-agree">
						<label class="form-check-label" for="marketing-all">
							마케팅 수신 동의 (선택)
						</label>
						<a class="auth-detail float-end" data-bs-toggle="modal" data-bs-target="#marketingImfo">내용보기</a> 
					</div>
					<div class="auth-choice row">
						<div class="col" >
							<div class="form-check form-check-center">
								<input class="form-check-input" type="checkbox" value="Y" id="member_marketing1" name="member_marketing1">
								<label class="form-check-label float-start" for="member_marketing1">이메일 수신</label>
							</div>
						</div>
						<div class="col">
							<div class="form-check form-check-center">
								<input class="form-check-input" type="checkbox" value="Y" id="member_marketing2" name="member_marketing2">
								<label class="form-check-label float-start" for="member_marketing2">문자 수신</label>
							</div>
						</div>
					</div>
				</fieldset>
				<div class="d-grid gap-2 py-3">
						<input type="submit" id="btnSub" value="가입하기" class="btn btn-outline-light btn-lg">
				</div>
			</form>
			
			<!-- 서비스 이용약관 동의 -->
			<div class="modal" id="serviceAgreeInfo" tabindex="-1" aria-labelledby="serviceAgreeInfoLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
						  <h1 class="modal-title fs-5" id="serviceAgreeInfoLabel">서비스 이용약관</h1>
						  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							
							
						
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
			
			<!-- 개인정보 수집 및 이용 동의 -->
			<div class="modal" id="personerAgreeInfo" tabindex="-1" aria-labelledby="personerAgreeInfoLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
						  <h1 class="modal-title fs-5" id="personerAgreeInfoLabel">개인정보 수집 및 이용동의</h1>
						  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<table class="tabel" border="1">
								<tr>
									<th>수집시기</th>
									<th>수집 및 이용 목적</th>
									<th>이용 및 보유기간</th>
								</tr>
								<tr>
									<td>[필수] 이름, 이메일, 휴대전화번호, 비밀번호	</td>
									<td>회원가입 및 서비스 이용</td>
									<td>회원 탈퇴 후 30일까지</td>
								</tr>
							</table>
							<ul>
								<li>※고객님께서는 [필수] 개인정보 수집 및 이용동의에 거부할 수 있습니다.</li>
								<li>단, 거부할 경우 회원가입이 불가능합니다.</li>
							</ul>
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
			
			<!-- 마케팅 수신 동의 내용 -->
			<div class="modal" id="marketingImfo" tabindex="-1" aria-labelledby="marketingImfoLabel" aria-hidden="true" >
				<div class="modal-dialog ">
					<div class="modal-content">
						<div class="modal-header">
						  <h1 class="modal-title fs-5" id="marketingImfoLabel">서비스 이용약관</h1>
						  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<table class="tabel" border="1">
								<tr>
									<th>목적</th>
									<th>항목</th>
									<th>보유기간</th>
								</tr>
								<tr>
									<td>클래스윌이 제공하는 이용자 맞춤형 서비스 및 상품 추천, 각종 경품 행사, 이벤트 등의 광고성 정보를 전자우편이나 서신우편, 문자(SMS 또는 카카오 알림톡), 푸시, 전화 등을 통해 이용자에게 제공합니다.</td>
									<td>이름, 이메일주소, 휴대전화번호, 마케팅 수신 동의 여부</td>
									<td><u>회원 탈퇴 후 30일 또는 동의 철회시까지</u></td>
								</tr>
							</table>
							<ul>
								<li>※고객님께서는 [필수] 개인정보 수집 및 이용동의에 거부할 수 있습니다.</li>
								<li>단, 거부할 경우 회원가입이 불가능합니다.</li>
							</ul>
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
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
	
	<script type="text/javascript">
		$(function() {
			
			// 전체선택 체크박스 체크 상태값을 각 체크박스의 체크 상태값으로 설정
			$("#allCheck").click(function() {
				let checkboxes = document.querySelectorAll('input[name="check-agree"]');
				for(let check of checkboxes) {
					check.checked = document.querySelector("#allCheck").checked;
				}
				document.querySelector("#member_marketing1").checked = document.querySelector("#allCheck").checked;
				document.querySelector("#member_marketing2").checked = document.querySelector("#allCheck").checked;
			});
			
			
			// 하나라도 체크 해제되면 전체 체크 버튼도 해제되도록 설정
			$("input[name='check-agree']").click(function() {
			    // 모든 체크박스를 순회하며 하나라도 체크가 해제된 것이 있는지 확인
			    let allChecked = true;
			    $("input[name='check-agree']").each(function() {
			        if (!this.checked) {
			            allChecked = false;
			            return false; // each 루프 종료
			        }
			    });
		
			    // 전체 체크 버튼에 상태 반영
			    $("#allCheck").prop("checked", allChecked);
			});
			
			// 선택 체크박스  
			$("#marketing-all").on("click", function() {
				document.querySelector("#member_marketing1").checked = document.querySelector("#marketing-all").checked;
				document.querySelector("#member_marketing2").checked = document.querySelector("#marketing-all").checked;
				
			});
			
			
			
			// 이름 정규표현식
			$("#member_name").on("input", function() {
				let inputName = $(this).val();
				let regex = /^[가-힣a-zA-Z]{2,30}$/; // 2~30자 이내 한글, 영문 대소문자만 입력 가능
				
				 if (!regex.test(inputName)) {
			            $("#regex-name").text("올바르지 않은 이름입니다.");
			            $("#regex-name").css("color", "#FF4848");
			        } else {
			            $("#regex-name").text("");
			        }
				
			});
			
			
			// 이메일 정규표현식
			$("#member_email").on("input", function() {
				let inputEmail = $(this).val();
				let regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 형식
				
				 if (!regex.test(inputEmail)) {
// 			            $(this).val("");
			            $("#regex-email").text("규칙에 맞는 이메일 주소를 입력해 주세요.");
			            $("#regex-email").css("color", "#FF4848");
			        } else {
			            $("#regex-email").text("");
			        }
			});
			
			// 비밀번호 정규표현식
			$("#member_pwd").on("input", function() {
			      let inputPwd = $(this).val();
			
			      let regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{6,16}$/;
			
			      if (!regex.test(inputPwd)) {
			          $("#regex-pwd").text("6자리 이상 영문자, 숫자, 특수문자를 입력하세요.");
			          $("#regex-pwd").css("color", "#FF4848");
			      } else {
			      	 $("#regex-pwd").text("");
			      }
			  });
			
// 			핸드폰번호 정규표현식
			$("#member_tel").on("input", function() {
			      let inputTel = $(this).val();
			
			      let regex = /^[0-9-]{0,13}$/;
			
			      if (!regex.test(inputTel)) {
			          $("#regex-tel").text("규칙에 맞는 핸드폰 번호를 입력해 주세요.");
			          $("#regex-tel").css("color", "#FF4848");
			      } else {
			      	 $("#regex-tel").text("");
			      }
			 });
			
			$("#member_tel").on("blur", function() {
				let inputTel = $(this).val();
			    let regex = /^[0-9-]{0,13}$/;
			    if (!regex.test(inputTel)) {
			    	$(this).val("");
			    }
			});



		    
			
		});	
		
		function authSms() {
			
			$("#sms-auth").html('<input type="text" class="form-control" id="phone_auth_number" name="phone_auth_number" placeholder="123456" required>'
					+'<label for="phone_auth_number">인증번호</label>');
			
// 			$.ajax({
// 				type: "GET",
// 		        url: "send-one",
// 		    	data : {
// 		    		member_tel : $("#member_tel").val()
// 			 	},
// 			 	dataType : "json",
// 			 	success : function(response) {
// 			 		if(response) {
// 			 			alert("메시지 전송이 완료되었습니다. 인증번호를 입력해 주세요.")
// 			 		} else {
// 			 			alert("메시지 전송에 실패했습니다.");
// 			 		}
					
// 				}, 
// 				error : function() {
// 					alert("ajax 오류");
					
// 				}
				
				
				
// 			});
			
			
			
			
		} // authSms()
		

		
	</script>
	
</body>
</html>