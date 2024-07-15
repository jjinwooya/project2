<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>CreatorMain</title>
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css"
	rel="stylesheet">
<style>
table {
	border-collapse: collapse;
	box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	background-color: white;
	width: 100%;
	border-radius: 10px;
	font-size: 15px;
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

td > a{
	display:-webkit-box; 
    word-wrap:break-word; 
    -webkit-line-clamp:1; 
    -webkit-box-orient:vertical; 
    overflow:hidden; 
    text-overflow:ellipsis;
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
/* .creator-intro{ */
/* 	background: white; */
/* 	border-radius: 10px; */
/* 	padding: 10px; */
	
/* } */
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

	<div class="container-fluid fruite">
		<div class="container">
			<h1 class="mt-4 text-white">Creator Center</h1>
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/creator/sideBar.jsp" />

						<div class="col-lg-9 creator-body">
							<!-- 크리에이터 인사 문구 -->
							<div class="creator-intro col-md-10">
								<div class="text-center text-white h2 mb-5">🌠 반가워요 Creator ${member.member_nickname} 님 🌠</div>
							</div>
							<!-- 크리에이터 이벤트 -->
							<div class="creator-event mt-5 my-5 col-md-10">
								<div align="right">
									<a href="csc?type=notice">+ 더보기</a>
								</div>
								<c:forEach var="creatorNotice" items="${creatorNoticeList}">
									<c:set var="noticeRegDate" value="${fn:substring(creatorNotice.notice_reg_date,0,10)}"/>
									<div class="card my-2">
									  <div class="card-body">
									    <h6 class="card-title"><a href="boardDetail?type=notice&code=${creatorNotice.notice_code}" style="color:black">${creatorNotice.notice_subject}</a></h6>
									    <div class="d-flex justify-content-between card-content">
										    <p class="card-text word-break">${noticeRegDate}</p> 
										    <a href="boardDetail?type=notice&code=${creatorNotice.notice_code}" class="btn btn-primary">상세보기</a>
									    </div>
									  </div>
									</div>
								</c:forEach>
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


</body>
</html>