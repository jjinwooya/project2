<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/csc_faq.css">
    <meta charset="utf-8">
    <title>자주묻는질문</title>
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

    <style>
        body {
            color: white;
        }
        .accordion-button::after {
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns%3D%27http://www.w3.org/2000/svg%27 fill%3D%27%23fff%27 viewBox%3D%270 0 16 16%27%3E%3Cpath fill-rule%3D%27evenodd%27 d%3D%27M1.5 1a.5.5 0 0 1 .5.5v13a.5.5 0 0 1-1 0v-13a.5.5 0 0 1 .5-.5zM3 1.5a.5.5 0 0 1 1 0v13a.5.5 0 0 1-1 0v-13z%27/%3E%3C/svg%3E');
        }
        /* Disable hover effects for accordion */
        .accordion-button:hover {
            cursor: pointer;
            background-color: inherit;
        }
    </style>
</head>

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

    <div class="container main">
        <div class="row">
            <!-- content 영역 - FAQ -->
            <div class="col-md-12">
                <div class="row">
                    <div id="csc_mainTitle">
                        <h1>FAQ</h1>
                    </div>
					<div class="category-buttons">
					    <button type="button" class="btn <c:if test="${param.type == 'notice'}">btn-primary active</c:if><c:if test="${param.type != 'notice'}">btn-primary</c:if>" onclick="location.href='csc?type=notice'">공지사항</button>
					    <button type="button" class="btn <c:if test="${param.type == 'faq'}">btn-primary active</c:if><c:if test="${param.type != 'faq'}">btn-secondary</c:if>" onclick="location.href='csc?type=faq'">FAQ</button>
					</div>
                    <hr>
                </div>
                <!-- 구분 카테고리 시작 -->
                <div class="row mt-3">
                    <div class="csc_faq_sel">
						<select id="faq_category" name="faq_category" class="form-select form-select-sm w-25">
							<option value="">전체</option>
								<c:forEach items="${category}" var="cat">
								    <option value="${cat.common2_code}" data-category="${cat.code_value}">${cat.code_value}</option>
								</c:forEach>
						</select>
                    </div>
                </div>
                <hr>
                <!-- 자주묻는 질문 게시판 -->
					<div class="accordion" id="faqAccordion">
					    <c:choose>
					        <c:when test="${empty list}">
					            <div align="center">FAQ 게시물이 없습니다</div>
					        </c:when>
					        <c:otherwise>
					            <c:forEach var="faq" items="${list}" varStatus="status">
					                <div class="accordion-item" data-category="${faq.faq_category}">
					                    <h2 class="accordion-header" id="heading${status.index}">
					                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}">
					                            <span class="faq_category">[${faq.faq_category}]&nbsp;&nbsp;&nbsp;</span> ${faq.faq_subject}
					                        </button>
					                    </h2>
					                    <div id="collapse${status.index}" class="accordion-collapse collapse" aria-labelledby="heading${status.index}" data-bs-parent="#faqAccordion">
					                        <div class="accordion-body">
					                            ${faq.faq_content}
					                        </div>
					                    </div>
					                </div>
					            </c:forEach>
					        </c:otherwise>
					    </c:choose>
					</div>
                <hr>
            </div>
        </div>
    </div>
    
    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"/>
    </footer>

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

    <!-- Custom JavaScript to prevent hover effect -->
    <script>
        // Ensure accordion only toggles on click
        document.addEventListener('DOMContentLoaded', function () {
            var accordions = document.querySelectorAll('.accordion-button');

            accordions.forEach(function (accordion) {
                accordion.addEventListener('mouseover', function (event) {
                    event.stopPropagation();
                });
            });
        });
        
        $(document).ready(function() {
            // 카테고리 선택 변경 시 이벤트 핸들러
            $('#faq_category').on('change', function() {
            	debugger;
				var selectedCategory = $('#faq_category option:selected').data('category');
                // 모든 FAQ 항목을 숨깁니다.
                $('.accordion-item').hide();

                // 선택된 카테고리에 해당하는 FAQ 항목을 표시합니다.
                if (!selectedCategory) {
                    // '전체'가 선택된 경우 모든 항목을 표시합니다.
                    $('.accordion-item').show();
                } else {
                    // 특정 카테고리가 선택된 경우 해당 항목만 표시합니다.
                    $('.accordion-item').each(function() {
                        if ($(this).data('category') === selectedCategory) {
                            $(this).show();
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>
