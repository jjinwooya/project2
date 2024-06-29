<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
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
<style>
	.main{
		color : white;
	}
	
	.csc_paging.disabled {
	    color: gray; /* 텍스트 색상 변경 */
	    cursor: not-allowed; /* 마우스 커서 스타일 변경 */
	    pointer-events: none; /* 클릭 이벤트 무시 */
	    text-decoration: none; /* 밑줄 제거 */
	}
	
</style>

<body>
    <!-- header Start -->
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"/>
    </header>
    <!-- header End -->
    
    <!-- Spinner Start (로딩시 뜨는 동그라미)-->
    <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-white" role="status"></div>
    </div>
    <!-- Spinner End -->
    
    <div class="container">
        <div class="row">
            <div class="col-12 main">
                <h3>공지사항</h3>
                <hr>
                <div>
                    <p><span>[클래스윌]</span>${board.notice_subject}</p>
                    <p><span>카테고리</span> | ${board.notice_category} &nbsp;&nbsp;&nbsp; <span>작성일</span> | ${board.notice_reg_date}</p>
                </div>
                <hr>
                <div>
                    ${board.notice_content}
                </div>
                <hr>
                <!-- 이전, 다음 페이징 -->
                <div>
					<c:choose>
					    <c:when test="${prev != 0}">
					        <span class="csc_paging"><a id="prevLink1" href="boardDetail?type=notice&code=${prev}">&laquo;이전</a></span>
					    </c:when>
					    <c:otherwise>
					        <span class="csc_paging disabled">&laquo;이전</span>
					    </c:otherwise>
					</c:choose>
					
					
					<c:choose>
					    <c:when test="${next != 0}">
					        <span class="csc_paging"><a id="nextLink1" href="boardDetail?type=notice&code=${next}">다음&raquo;</a></span>
					    </c:when>
					    <c:otherwise>
					        <span class="csc_paging disabled">다음&raquo;</span>
					    </c:otherwise>
					</c:choose>
                </div>    
                <!-- 목록 버튼 -->
                <div class="csc_detail_button">
                    <input type="button" value="목록" onclick="location.href='csc?type=notice'">
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>

</html>
