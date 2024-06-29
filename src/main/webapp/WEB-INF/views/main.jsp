<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
/*   		font-family: "Nanum Gothic", sans-serif;   */
/*  		font-family: "Noto Sans KR", sans-serif; */
 	} 
 	

 	
 	article h1, h2 {
 		color : white;
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
	    border: 1px solid var(--bs-secondary);
	    border-radius: 20px;
	    transition: 0.5s;
	}
	
	.vesitable .owl-nav .owl-next {
	    position: absolute;
 	    top: -30px; 
	    right: 88px;
	    color: white;
	    padding: 5px 25px;
	    border: 1px solid var(--bs-secondary);
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
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event1.jpg" class="d-block w-100 d-lg-flex d-md-none d-none" alt="...">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event1_mini.jpg" class="d-block w-100 d-flex d-lg-none " alt="...">
							</div>
							<div class="carousel-item">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event2.jpg" class="d-block w-100 d-lg-flex d-md-none d-none" alt="...">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event2_mini.jpg" class="d-block w-100 d-flex d-lg-none " alt="...">
							</div>
							<div class="carousel-item">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event3.jpg" class="d-block w-100 d-lg-flex d-md-none d-none" alt="...">
								<img src="${pageContext.request.contextPath}/resources/images/event/main_event3_mini.jpg" class="d-block w-100 d-flex d-lg-none " alt="...">
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
	        <div class="container-fluid vesitable py-3">
	            <div class="container py-3">
	                <h2 class="mb-0 ">클래스윌 TOP10</h2>
	                
	                <div class="owl-carousel vegetable-carousel justify-content-center">
	                
						<div class="rounded position-relative vesitable-item">
							<div class="vesitable-img">
								<img src="${pageContext.request.contextPath}/resources/images/products/s4.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary  px-3 py-2 rounded position-absolute" style="top: 8px; right: 10px;">
								<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay ratio ratio-1x1">
	                        </div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">1111테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                    <div class="rounded position-relative vesitable-item">
							<div class="vesitable-img">
								<img src="${pageContext.request.contextPath}/resources/images/products/s5.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 8px; right: 10px;">
		                        <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay ratio ratio-1x1">
	                        </div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                    <div class="rounded position-relative vesitable-item">
							<div class="position-relative position-relative1">
								<img src="${pageContext.request.contextPath}/resources/images/products/s7.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 8px; right: 10px;">
		                     	<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay ratio ratio-1x1">
							</div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                    <div class="rounded position-relative vesitable-item">
							<div class="position-relative position-relative1">
								<img src="${pageContext.request.contextPath}/resources/images/products/s11.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 8px; right: 10px;">
		                        <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay ratio ratio-1x1">
		                    </div>    
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                    <div class="rounded position-relative vesitable-item">
							<div class="position-relative position-relative1">
								<img src="${pageContext.request.contextPath}/resources/images/products/s4.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary px-2 py-1 rounded position-absolute" style="top: 8px; right: 10px;">
		                        <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay ratio ratio-1x1" >
	                        </div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                    <div class="rounded position-relative vesitable-item">
							<div class="position-relative1">
								<img src="${pageContext.request.contextPath}/resources/images/products/s5.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary px-2 py-1 rounded position-absolute" style="top: 8px; right: 10px;">
		                    	<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay" width="25px">
	                        </div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                    <div class="rounded position-relative vesitable-item">
							<div class="vesitable-img">
								<img src="${pageContext.request.contextPath}/resources/images/products/s7.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 8px; right: 10px;">
	                        	<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay" width="25px">
	                        </div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                    
		                <div class="rounded  vesitable-item">
							<div class="vesitable-img">
								<img src="${pageContext.request.contextPath}/resources/images/products/s11.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 8px; right: 10px;">
		                        <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay" >
	                        </div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
	                    
	                     <div class=" rounded  vesitable-item">
							<div class="vesitable-img">
								<img src="${pageContext.request.contextPath}/resources/images/products/s11.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
							</div>
	                        <div class="bg-tertiary px-3 py-1 position-absolute" style="top: 8px; right: 10px;">
		                        <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay" >
	                        </div>
	                        <div class="p-4 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
									<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								</div>
								<div class="createrName d-flex align-items-center py-2">
									<div class="px-3 py-1 position-absolute"  style="bottom: 120px; left: 6px;">
										<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" width="15px;">
									</div>	
									<p class="mb-0 ml-5 px-4">테크니컬아티스트 홍상범</p>
								</div>
								<div class="className">
									<h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
								</div>
					            <div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
									</div>
									<div class="col-md-6 price">
										<h5>50,000원</h5>
									</div>
								</div>
							</div>
	                    </div>
		                    
	                </div> <!--  owl-carousel -->
	            </div>
	        </div>
	        <!-- Vesitable Shop End -->
        </div> <!--  main-top10 -->
	

 		<div class="container-fluid fruite py-3">
            <div class="container py-3">
                <div class="tab-class text-center">
                    <div class="row g-4">
                        <div class="col-lg-4 text-start">
                            <h2 style="margin-bottom: 20px;">신규 오픈 클래스</h2>
                        </div>
                    </div>
                     <div class="row g-4">
                         <div class="col-lg-12">
                             <div class="row g-4">
                             
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s4.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
			                              	<div class="classCategory col-md-10">
			                              		<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								          </div>
									       <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">UI 디자이너 리제</p>
						               		</div>
							               <div class="className">
							                  <h6>디자인과 연출을 모두 잡는 언리얼 게임 UI FX 포트폴리오</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s7.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
											<div class="classCategory col-md-10">
			                              		<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
											</div>
									       <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">테크니컬아티스트 홍상범</p>
						               		</div>
							               <div class="className">
							                  <h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s5.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
			                              	<div class="classCategory col-md-10">
								             	<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								          </div>
									       <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">게임그래픽 전문학원 지지스쿨</p>
						               		</div>
							               <div class="className">
							                  <h6>툴 기초 완벽 정복, 게임 그래픽 입문 100강사전</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s5.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
			                              	<div class="classCategory col-md-10">
								            	<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								          </div>
									       <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">게임그래픽 전문학원 지지스쿨</p>
						               		</div>
							               <div class="className">
							                  <h6>툴 기초 완벽 정복, 게임 그래픽 입문 100강사전</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s5.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-tertiary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
			                              	<div class="classCategory col-md-10">
								          		<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								          </div>
									       <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">게임그래픽 전문학원 지지스쿨</p>
						               		</div>
							               <div class="className">
							                  <h6>툴 기초 완벽 정복, 게임 그래픽 입문 100강사전</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s4.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
			                              	<div class="classCategory col-md-10">
								            	<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								          </div>
									       <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">UI 디자이너 리제</p>
						               		</div>
							               <div class="className">
							                  <h6>디자인과 연출을 모두 잡는 언리얼 게임 UI FX 포트폴리오</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s5.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
			                              	<div class="classCategory col-md-10">
								           		<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
								          </div>
									       <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">게임그래픽 전문학원 지지스쿨</p>
						               		</div>
							               <div class="className">
							                  <h6>툴 기초 완벽 정복, 게임 그래픽 입문 100강사전</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="col-md-6 col-lg-4 col-xl-3 ">
                                     <div class="rounded position-relative class-item classCard">
                                         <div class="">
                                             <img src="${pageContext.request.contextPath}/resources/images/products/s7.jpg" class="img-fluid w-100 rounded-top classPic" alt="">
                                             <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heart-overlay">
                                         </div>
<!--                                          <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">원데이</div> -->
                                         <div class="p-4 border border-secondary border-top-0 rounded-bottom " style="background: white; text-align: left; padding: 15px;">
			                              	<div class="classCategory col-md-10">
												<button type="button" class="btn btn-outline-success btn-sm category" >원데이</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>
												<button type="button" class="btn btn-outline-dark btn-sm category">카테고리</button>			
								          </div>
									      <div class="createrName d-flex align-items-center">
						            			<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
						                 		<p class="mb-0 ml-2">테크니컬아티스트 홍상범</p>
						               		</div>
							               <div class="className">
							                  <h6>왕초보에서 이모티콘 마스터로! 클립스튜디오로 만드는 카카오톡 이모티콘</h6>
							               </div>
							               <div class="row classInfo">
							                  <div class="col-md-6 add">
							                     <a href="" class="btn btn-outline-dark btn-sm disabled">부산 사상구</a>
							                  </div>
							                  <div class="col-md-6 price">
							                     <h5>50,000원</h5>
							                  </div>
							               </div>
                                         </div>
                                     </div>
                                 </div>
                                 
                             </div><!-- row -->
                         </div>
                     </div>
                 </div>
             </div>
         </div>      
        <!-- Fruits Shop End-->

	      
	    
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
		    var heartOverlays = document.querySelectorAll(".heart-overlay");
		    var originalSrc = "${pageContext.request.contextPath}/resources/images/profile/heart.png";
		    var changeSrc = "${pageContext.request.contextPath}/resources/images/profile/heart_full.png";
		
		    heartOverlays.forEach(function(heartOverlay) {
		        heartOverlay.addEventListener("click", function() {
		            var img = this;
		            img.classList.add("fade");
		
		            setTimeout(function() {
		                if (img.src.includes("heart_full.png")) {
		                    img.src = originalSrc;
		                } else {
		                    img.src = changeSrc;
		                }
		                img.classList.remove("fade");
		            }, 300); 
		        });
		    });
		    
		    
		}); // addEventListener
		
	</script>
</body>
</html>