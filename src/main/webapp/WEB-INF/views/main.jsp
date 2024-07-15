<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta property="og:title" content="Class Will">
<meta property="og:image" content="${pageContext.request.contextPath}/resources/img/class_will_thumb.png" />
<meta property="og:description" content="✨WE WILL JOURNEY, WE WILL GROW UP✨">

<title>클래스윌</title>


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

<!--  Bootstrap  -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!--  클래스 리스트 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/class_list.css">

<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	
	
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->

<style type="text/css">
	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');
    
 	body { 
 		background: black;  
 	} 
 	
 	article h1, h2 {
 		color: white;
 	} 
 	
 	.class-price {
 		color: black;
 	}
 	
	.vesitable .owl-stage {
	    margin: 20px 0;
	    position: relative;
	}
	
	.vesitable .owl-nav .owl-prev {
	    position: absolute;
 	    top: -30px; 
	    right: 0;
	    color: white;
	    padding: 5px 25px;
	    border: 1px solid #FF4848;
	    border-radius: 20px;
	    transition: 0.5s;
	}
	
	.vesitable .owl-nav .owl-next {
	    position: absolute;
 	    top: -30px; 
	    right: 80px;
	    color: white;
	    padding: 5px 25px;
	    border: 1px solid #FF4848;
	    border-radius: 20px;
	    transition: 0.5s;
	}
	
	.main-event {
	    background-color: black;
	    transition: background-color 0.5s ease;
	}
	
	.carousel-control-prev, .carousel-control-next {
	    width: 5%; /* 버튼의 너비를 줄여 양 끝에 더 가깝게 배치 */
	}
	
	.carousel-control-prev {
	    left: -15px; /* 좌측으로 더 이동 */
	}
	
	.carousel-control-next {
	    right: -15px; /* 우측으로 더 이동 */
	}
	

</style>
</head>
<body>
	<header>
       	<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
	
	<article>
		<div class="main-event">
			<div class="container-fluid main-event">
				<div class="container align-items-center">
					<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner ">
							<div class="carousel-item active ">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event1.jpg" class="d-block w-100 d-lg-flex d-md-none d-none" alt="..." onclick="location.href='event'">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event1_mini.jpg" class="d-block w-100 d-flex d-lg-none " alt="..." onclick="location.href='event'">
							</div>
							<div class="carousel-item">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event2.jpg" class="d-block w-100 d-lg-flex d-md-none d-none" alt="..." onclick="location.href='event'">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event2_mini.jpg" class="d-block w-100 d-flex d-lg-none " alt="..." onclick="location.href='event'">
							</div>
							<div class="carousel-item">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event3.jpg" class="d-block w-100 d-lg-flex d-md-none d-none" alt="..." onclick="location.href='event'">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event3_mini.jpg" class="d-block w-100 d-flex d-lg-none " alt="..." onclick="location.href='event'">
							</div>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
			</div>
		</div> <!-- main-event -->
		
		
		<div class="main-top10">
	      	<!-- Vesitable Shop Start-->
	        <div class="container-fluid vesitable py-3 mt-3">
	            <div class="container py-3">
	                <h3 class="mb-0 ">클래스윌 TOP10</h3>
	                
	                <div class="owl-carousel vegetable-carousel justify-content-center">
	                	
	                	<c:forEach var="contents" items="${top10List}">
	                		 
							<div class="rounded position-relative vesitable-item" style="width: 306px;">
								<div class="vesitable-img">
									<img style="height : 225px;" src="${pageContext.request.contextPath}/resources/upload/${contents.class_thumnail}" class="img-fluid w-100 rounded-top classPic" onclick="location.href='class-detail?class_code=${contents.class_code}'">
								</div>
		                        <div class="text-white bg-tertiary rounded position-absolute" style="top: 5px; right: 5px;">
									<!-- like class 하트 여부-->
									<c:choose>
										<c:when test="${not empty likeClassList and not empty sessionScope.member}">
											<c:forEach var="likeClass" items="${likeClassList}">
												<c:if test="${likeClass.class_code eq contents.class_code}">
													<img src="${pageContext.request.contextPath}/resources/images/profile/heart_full.png" id="heartOverlay" class="heartImg" 
														data-class-code="${contents.class_code}" data-member-code="${sessionScope.member.member_code}" style="width: 25px; height: 25px;">
												</c:if>
												<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heartImg" 
													data-class-code="${contents.class_code}" data-member-code="${sessionScope.member.member_code}" style="width: 25px; height: 25px;" style="width: 25px; height: 25px;">
											</c:forEach>
										</c:when>
										<c:otherwise>
											<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heartImg" 
												data-class-code="${contents.class_code}" data-member-code="${sessionScope.member.member_code}" style="width: 25px; height: 25px;">
										</c:otherwise>
									</c:choose>
		                        </div>
		                        <div class="p-3 rounded-bottom classCardBtm" onclick="location.href='class-detail?class_code=${contents.class_code}'" >
									<div class="classCategory w-100 col-md-10">
										<button type="button" class="btn btn-outline-dark btn-sm category mb-2" >${contents.big_category}</button>
										<button type="button" class="btn btn-outline-dark btn-sm category mb-2">${contents.small_category}</button>
										<c:set var="hashtags" value="${fn:split(contents.class_hashtag, ',')}" />
										<button type="button" class="btn btn-outline-secondary btn-sm category mb-2">${hashtags[0]}</button>
									</div>
									<div class="createrName d-flex align-items-center py-2">
										<div class="px-2 py-2 position-absolute"  style="bottom: 120px; left: 6px;">
											<c:choose>
												<c:when test="${empty contents.member_img}">
													<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="member_img" style="width: 25px; height: 25px;">
												</c:when>	
												<c:otherwise>
													<img src="${pageContext.request.contextPath}/resources/upload/${contents.member_img}" class="member_img" style="width: 25px; height: 25px;">
												</c:otherwise>
											</c:choose>
										</div>	
										<p class="mb-0 ml-5 px-4">${contents.member_nickname}</p>
									</div>
									<div class="className">
										<h6>${contents.class_name}</h6>
									</div>
						            <div class="row classInfo d-flex justify-content-between">
										<div class="col add">
											<a href="" class="btn btn-outline-dark btn-sm disabled">${contents.local_name}</a>
										</div>
										<div class="col price  ">
											<h5 class="class-price"><fmt:formatNumber value="${contents.class_price}" pattern="#,###" />원</h5>
										</div>
									</div>
								</div>
		                    </div>
		                    
	                	</c:forEach>
		                    
	                </div> <!--  owl-carousel -->
	            </div>
	        </div>
	        <!-- Vesitable Shop End -->
        </div> <!--  main-top10 -->
	

 		<div class="container-fluid fruite py-3 mb-5">
            <div class="container py-3">
                <div class="tab-class text-center">
                    <div class="row g-4">
                        <div class="col-7 pe-0">
                            <h3 class="float-start" style="margin-bottom: 20px;">신규 오픈 클래스</h3>
                        </div>
                        <div class="col-5 ps-0 pt-2">
                            <h5 class="float-end">
                            	<a href="class-list" style="text-decoration: none; color: #FF4848;">자세히 보기 <i class="bi bi-arrow-right"></i></a>
                            </h5>
                        </div>    
                    </div>
					<div class="row g-4">
						<div class="col-lg-12">
							<div class="row g-4">
							
								<c:forEach var="contents" items="${newClassList}">
									<div class="col-md-6 col-lg-4 col-xl-3" style="width: 330px;">
										<div class="rounded position-relative class-item classCard">
											<div class="">
												<!-- ${contents.class_thumnail} 썸네일 이미지  -->
												<img style="height : 225px;" src="${pageContext.request.contextPath}/resources/upload/${contents.class_thumnail}" class="img-fluid w-100 rounded-top classPic" 
														onclick="location.href='class-detail?class_code=${contents.class_code}'">
												<!-- like class 하트 여부-->
												<c:choose>
													<c:when test="${not empty likeClassList and not empty sessionScope.member}">  <!-- likeClassList 존재 -->
														<c:set var="isLiked" value="false"/> <!-- 삭제 -->
														<c:forEach var="likeClass" items="${likeClassList}">
															<c:if test="${likeClass.class_code eq contents.class_code}">
																<c:set var="isLiked" value="true"/> 
															</c:if>
														</c:forEach>
														<c:if test="${isLiked}">
															<img src="${pageContext.request.contextPath}/resources/images/profile/heart_full.png" id="heartOverlay" 
																class="heartImg" data-class-code="${contents.class_code}" data-member-code="${sessionScope.member.member_code}">
														</c:if>
														<c:if test="${not isLiked}">
															<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" 
																class="heartImg" data-class-code="${contents.class_code}" data-member-code="${sessionScope.member.member_code}">
														</c:if>
													</c:when>
													<c:otherwise>
														<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heartImg" 
															data-class-code="${contents.class_code}" data-member-code="${sessionScope.member.member_code}">
													</c:otherwise>
												</c:choose>
											</div>
									<!-- 	<div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
											<div class="p-3 border border-secondary border-top-0 rounded-bottom classCardBtm" onclick="location.href='class-detail?class_code=${contents.class_code}'" >
												<div class="classCategory w-100 col-md-10">
													<button type="button" class="btn btn-outline-dark btn-sm category mb-2" >${contents.big_category}</button>
													<button type="button" class="btn btn-outline-dark btn-sm category mb-2">${contents.small_category}</button>
													<c:set var="hashtags" value="${fn:split(contents.class_hashtag, ',')}" />
													<button type="button" class="btn btn-outline-secondary btn-sm category mb-2">${hashtags[0]}</button>
												</div>
												<div class="createrName d-flex align-items-center">
													<c:choose>
														<c:when test="${empty contents.member_img}">
															<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="member_img">
														</c:when>	
														<c:otherwise>
															<img src="${pageContext.request.contextPath}/resources/upload/${contents.member_img}" class="member_img">
														</c:otherwise>
													</c:choose>
													<p class="mb-0 ml-2">${contents.member_nickname}</p>
												</div>
												<div class="className mt-2">
												   <h6>${contents.class_name}</h6>
												</div>
												<div class="row classInfo d-flex justify-content-between">
												   <div class="col add float-start ">
												      <a href="" class="btn btn-outline-dark btn-sm disabled">${contents.local_name}</a>
													</div>
													<div class="col price float-end">
												   		<h5 class="class-price"><fmt:formatNumber value="${contents.class_price}" pattern="#,###" />원</h5>
												   </div>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
                                 
                             </div><!-- row -->
                         </div>
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
		document.addEventListener("DOMContentLoaded", function() {
			var heartImges = document.querySelectorAll(".heartImg");
		    var originalSrc = "${pageContext.request.contextPath}/resources/images/profile/heart.png"; // 라이크 클래스 추가 안했을 시 
		    var changeSrc = "${pageContext.request.contextPath}/resources/images/profile/heart_full.png"; // 라이크 클래스 추가 했을 시 

		    heartImges.forEach(function(heartOverlay) {
		        heartOverlay.addEventListener("click", function() {
		            var img = this;
		            var member_code = img.getAttribute("data-member-code");
		            var class_code = img.getAttribute("data-class-code");
		            var isFullHeart = img.src.includes("heart_full.png");

		            var heart_status = !isFullHeart;
					
					// 로그인 해야만 이용 가능
					if(member_code == null || member_code == ""){ 
						if(confirm("로그인 후 이용가능합니다.\n로그인하시겠습니까?")){
				            window.location.href = "member-login";
				            return;
						}
						return;
					}
					
		            if (heart_status) { // heart_status가 true일 때 (like-class 추가 시)
		                img.src = changeSrc;
		 				alert("관심 클래스에 추가되었습니다.");
		            } else { // heart_status가 false일 때 (like-class 삭제 시)
		                img.src = originalSrc;
		 				alert("관심 클래스에서 삭제되었습니다.");
		            }
		            
		            // AJAX 요청을 통해 서버로 업데이트 요청 전송
		            var data = JSON.stringify({
		                heart_status: heart_status,
		                member_code: member_code,
		                class_code: class_code
		            });
		            
		            updateHeartStatus(data);
		        });
		    });
		    
		    function updateHeartStatus(data) {
		    	
		        var xhr = new XMLHttpRequest();
		        
		        xhr.open("POST", "${pageContext.request.contextPath}/update-heart-status", true);
		        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		        xhr.onreadystatechange = function() {
		            if (xhr.readyState === 4) {
		                if (xhr.status === 200) {
		                    console.log("Heart status updated successfully");
		                } else {
		                    console.error("Error updating heartStatus");
		                }
		            }
		        };
		        
		        xhr.send(data);
		    }
		    
		    
		}); // addEventListener
		
	</script>
</body>
</html>