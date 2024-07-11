<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/csc_notice.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style>
	th[colspan="4"] {
		text-align: center;
		font-size: 1.2em;
	}
	
	.boardArea {
		color : black;
	}	
	th:nth-child(1), td:nth-child(1) {
		width: 10%;
	}
	
	th:nth-child(2), td:nth-child(2) {
		width: 20%;
	}
	
	th:nth-child(3), td:nth-child(3) {
		width: 20%;
	}
	
	th:nth-child(4), td:nth-child(4) {
		width: 50%;
	}
</style>
    <head>
        <meta charset="utf-8">
        <title>고객센터</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    </head>

    <body>
        <!-- header Start -->
		<header>
        	<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
		</header>
		<!-- header End -->
		
		<!-- Spinner Start (로딩시 뜨는 동그라미)-->
	        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
	            <div class="spinner-grow text-white" role="status"></div>
	        </div>
        <!-- Spinner End -->
		<div class="container">
	<div class="row">
		<!--사이드바 영역  -->
		<!-- content 영역 - 게시판 형식의 공지/뉴스 -->
		<div class="col-12 main">
			<div id="csc_mainTitle">
				<h1>고객센터</h1>
			</div>
			<div class="category-buttons">
			    <button type="button" class="btn <c:if test="${param.type == 'notice'}">btn-primary active</c:if><c:if test="${param.type != 'notice'}">btn-primary</c:if>" onclick="location.href='csc?type=notice'">공지사항</button>
			    <button type="button" class="btn <c:if test="${param.type == 'faq'}">btn-primary active</c:if><c:if test="${param.type != 'faq'}">btn-secondary</c:if>" onclick="location.href='csc?type=faq'">FAQ</button>
			</div>
			<hr>
			<div class="row">
			
				
			<!-- 게시판 -->
			<div class="row boardArea">
				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리</th>
							<th>작성일</th>
							<th>제목</th>
						</tr>
					</thead>
					<tbody class="noticeTheaterList">
						<c:choose>
							<c:when test="${empty list }">
								<tr>
									<th colspan="4">게시물이 없습니다</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="board" items="${list}">
									<tr data-url="boardDetail?type=notice&code=${board.notice_code}">
										<td>${board.notice_code }</td>
										<td>${board.notice_category}</td>
										<td>${board.notice_reg_date}</td>
										<td>${board.notice_subject }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<!-- 페이지네이션-페이징 -->
			<hr>
			<div align="center">
				<c:forEach var="i" begin="1" end="${totalPages}">
				    <a href="${pageContext.request.contextPath}/csc?type=${type}&page=${i}&pageSize=${param.pageSize}">${i}</a>
				</c:forEach>
			</div>

		</div>
	</div>
</div>
        
        <footer>
        	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"/>
		</footer>

        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

        
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    </body>
    
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const rows = document.querySelectorAll("table tbody tr");
        rows.forEach(row => {
            row.addEventListener("click", function() {
                const url = this.getAttribute("data-url");
                window.location.href = url;
            });
        });
    });
</script>

</html>