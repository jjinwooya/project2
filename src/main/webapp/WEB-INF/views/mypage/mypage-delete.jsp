<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원 탈퇴</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">


<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/myPage.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.grid/latest/tui-grid.css" />
<script
	src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.grid/latest/tui-grid.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style>
body {
	
}

table {
	border-collapse: collapse;
	box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	background-color: white;
	width: 100%;
	border-radius: 10px;
	font-size: 15px;
	table-layout: fixed; /* 테이블 레이아웃 고정 */
	word-wrap: break-word; /* 단어를 셀 내에서 줄바꿈 */
}

/* 테이블 행 */
th, td {
	padding: 15px 8px;
	border-bottom: 1px solid #ddd;
	color: black;
}

th {
	background-color: #eee;
	color: black;
}

td>a {
	display: -webkit-box;
	word-wrap: break-word;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* 테이블 올렸을 때 */
tbody tr:hover {
	background-color: white;
	opacity: 0.9;
	cursor: pointer;
}

/* 테이블 비율 */
th:nth-child(1), td:nth-child(1) {
	padding-left: 20px;
}

th:nth-child(2), td:nth-child(2) {
	width: 130px;
	text-align: center;
}

@media ( max-width : 768px) {
	.table-responsive {
		overflow-x: auto; /* 가로 스크롤 가능하도록 설정 */
	}
	.table {
		min-width: 600px; /* 테이블 최소 너비 설정 */
	}
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>


	<!-- Spinner Start (로딩시 뜨는 동그라미)-->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-white" role="status"></div>
	</div>
	<!-- Spinner End -->

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">
			마이페이지<i class="bi bi-person-x-fill"></i>회원 탈퇴
		</h1>
	</div>

	<div class="container-fluid fruite">
		<div class="container">
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/mypage/sideBar.jsp" />

						<div class="col-lg-9 creator-body">
							<div class="creator-event mt-5">
								<div class="col-md-12 text-center h2 mb-5">또 보고 싶을
									${member.member_name}님</div>
								<!-- 								여기부터 토스트 ui -->
								<div class="table-responsive">
									<h3>나의 흔적이 ${totalReview}개 있습니다.</h3>
									<p>${member.member_name}님이작성한 리뷰들</p>
									<table class="table table-hover">
										<thead>
											<tr>
												<th>클래스 이름</th>
												<th>리뷰제목</th>
												<th>리뷰삭제</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="memberReviews" items="${memberReviews}"
												varStatus="loop">
												<tr>
													<td>${memberReviews.class_name}</td>
													<td>${memberReviews.class_review_subject}</td>
													<td><button class="btn btn-danger"
															onclick="confirmDelete(${memberReviews.class_review_code})">삭제</button></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<div id="pageList">
										<input type="button" value="이전"
											onclick="location.href='my-delete?pageNum2=${pageNum2 - 1}'"
											<c:if test="${pageNum2 == 1}">disabled</c:if> />
										<c:forEach var="i" begin="1" end="${maxPage2}">
											<c:choose>
												<c:when test="${pageNum2 == i}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="my-delete?pageNum2=${i}">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<input type="button" value="다음"
											onclick="location.href='my-delete?pageNum2=${pageNum2 + 1}'"
											<c:if test="${pageNum2 == maxPage2 or maxPage2 == 0}">disabled</c:if> />
									</div>
								</div>
								<div class="table-responsive">
									<c:set var="credit" value="${member.member_credit}" />
									<h3>${member.member_name}님의
										남은 윌페이 잔액은
										<fmt:formatNumber value="${credit}" type="number"
											pattern="#,##0" />
										원 입니다. <a href="my-credit" class="btn btn-primary">윌페이
											페이지로 이동</a>
									</h3>
									<br>
									<h3>회원 탈퇴시 남은 윌페이는 환불되지 않습니다. 참고부탁드립니다.</h3>
									<div class="col-lg-6 col-md-12 ">
										<h3>회원탈퇴</h3>
										<form action="member-quit" method="POST">
											<div class="login-form-input">
												<h5>비밀번호를 한번 더 입력해주세요</h5>
												<div class="input-group">
													<input type="password" id="member_pwd" name="member_pwd"
														class="form-control" placeholder="비밀번호" required
														maxlength="20">
												</div>
												<div class="regex py-2" id="regex-pwd"></div>
											</div>
											<div class="d-grid gap-2 py-2 btnLogin">
												<input type="submit" id="btnSub" value="회원탈퇴하기"
													class="btn btn-outline-light btn-lg">
											</div>
										</form>
									</div>
									<!-- col -->
									<!--									<table class="table table-hover"> -->
									<!-- 										<thead> -->
									<!-- 											<tr> -->
									<!-- 												<th>클래스 이름</th> -->
									<!-- 												<th>리뷰 제목</th> -->
									<!-- 												<th>리뷰 별점</th> -->
									<!-- 												<th>작성 날짜</th> -->
									<!-- 												<th>답변 여부</th> -->
									<!-- 												<th>수정</th> -->
									<!-- 												<th>삭제</th> -->
									<!-- 											</tr> -->
									<!-- 										</thead> -->
									<!-- 										<tbody> -->
									<!-- 											<tr> -->
									<!-- 												<td>아직 미정</td> -->
									<!-- 												<td>아직 미정</td> -->
									<!-- 												<td>아직 미정</td> -->
									<!-- 												<td>아직 미정</td> -->
									<!-- 												<td>아직 미정</td> -->
									<!-- 												<td>아직 미정</td> -->
									<!-- 											</tr> -->

									<!-- 										</tbody> -->
									<!-- 									</table> -->
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

	<!-- JavaScript Libraries -->
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
	<script>
	 function confirmDelete(review_code) {
		   if (confirm("삭제하시겠습니까?")) {
             deleteReview(review_code);
         }	
	   }
	   
	   function deleteReview(review_code) {
	        $.ajax({
	            url: 'delete-review',
	            type: 'POST',
	            data: {review_code: review_code},
	            success: function(response) {
	                alert('성공적으로 삭제했습니다.');
	                location.reload(); 
	            },
	            error: function() {
	                alert('리뷰 삭제에 실패하였습니다.');
	            }
	        });
	    } 
	   $(function() {
					
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
			
		}); 
	</script>

</body>
</html>