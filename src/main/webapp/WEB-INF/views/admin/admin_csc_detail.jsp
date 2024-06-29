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
    
    <!-- Spinner Start (로딩시 뜨는 동그라미)-->
    <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-white" role="status"></div>
    </div>
    <!-- Spinner End -->
    
    <div class="container">
        <div class="row">
            <div class="col-12 main">
                <h3>
   					<c:choose>
					    <c:when test="${param.type eq 'notice'}">
					        공지사항
					    </c:when>
					    <c:when test="${param.type eq 'faq'}">
					        FAQ
					    </c:when>
					</c:choose>
                </h3>
                <hr>
                <div>
                    <p><span>[클래스윌]</span>
                    <c:choose>
                    	<c:when test="${not empty notice}">
                    		 ${notice.notice_subject}
                    	</c:when>
                    	<c:when test="${not empty faq}">
                    		 ${faq.faq_subject}
                    	</c:when>
                    </c:choose>
                    </p>
                    <p><span>카테고리</span> | 
                    	<c:choose>
                    		<c:when test="${not empty notice }">
                    			${notice.notice_category}		
                    		</c:when>
                    		<c:when test="${not empty faq }">
                    			${faq.faq_category}		
                    		</c:when>
                    	</c:choose>
                     
                    
                    &nbsp;&nbsp;&nbsp; <span>작성일</span> | 
                    <c:choose>
                    	<c:when test="${not empty notice }">
                    		${notice.notice_reg_date}	
                    	</c:when>
                    	<c:when test="${not empty faq }">
                    		${faq.faq_reg_date}	
                    	</c:when>
                    </c:choose>
                    
                    </p>
                </div>
                <hr>
                <div>
                	<c:choose>
                		<c:when test="${not empty notice }">
                			${notice.notice_content }
                		</c:when>
                		<c:when test="${not empty faq }">
                			${faq.faq_content }
                		</c:when>
                	</c:choose>
                </div>
                <hr>
            </div>
        </div>
        <div class="btnArea">
        	<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
			<button type="button" class="btn btn-secondary" id="deleteBtn">삭제</button>
        </div>
    </div>
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
<script>
	const type = "${param.type}";
	const code = "${param.code}";
	
	
	// 공통 이벤트 핸들러 함수
	function handleButtonClick(action) {
		location.href = "admin-csc-" + action + "?type=" + type + "&code=" + code;
	}

	// 버튼 클릭 이벤트 리스너 설정
	$(document).ready(function() {
		$("#updateBtn, #deleteBtn").on("click", function() {
			const action = this.id === "updateBtn" ? "modify" : "delete";
			if(action === "delete"){
				if(confirm("정말 삭제하시겠습니까?")){
					handleButtonClick(action);		
				}
			}else{
				handleButtonClick(action);	
			}
			
		});
	});
</script>
</html>