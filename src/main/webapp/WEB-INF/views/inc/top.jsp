<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
    
<style>
    
/*** Top Navbar Start ***/
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');


* {
     font-family: "Noto Sans KR", sans-serif; 
}

.class-will-top {
    background: black;
}

.class-will-top a {
    color: inherit; 
    text-decoration: none; 
}

.navbar .navbar-nav .nav-link {
    padding: 0px 20px;
    font-size: 18px;
    color: white; 
    transition: .5s;
}

.navbar {
    height: 150px;
    border-bottom: 1px solid rgba(255, 255, 255, .3);
    background: black !important; /* Navbar 배경을 검정색으로 설정 */
}

.navbar .navbar-nav .nav-link:hover,
.navbar .navbar-nav .nav-link.active,
.navbar .navbar-nav .nav-link:hover .nav-link.active {
    color: white; /* 호버 상태에서 글자 색을 흰색으로 유지 */
    font-weight: bold; /* 호버 상태에서 볼드체 */
}


.navbar-nav > a:hover {
    background: white;
    border-radius: 5px;
}

.navbar-nav > div:hover {
    background: white;
    border-radius: 5px;
}

.navbar .dropdown-toggle::after {
    border: none;
    content: "\f107";
    font-family: "Font Awesome 5 Free";
    font-weight: 700;
    vertical-align: middle;
    margin-left: 8px;
    color: white; /* 드롭다운 토글 아이콘 색을 흰색으로 설정 */
}

@media (min-width: 1200px) {
    .navbar .nav-item .dropdown-menu {
        display: block;
        visibility: hidden;
        top: 100%;
        transform: rotateX(-75deg);
        transform-origin: 0% 0%;
        border: 0;
        transition: .5s;
        opacity: 0;
    }
}

@media (max-width: 1200px) {
    #navbarCollapse {
        background: lightgray;
        border-radius: 10px;
    }
}

.navbar-brand {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    padding: 0;
    margin: 0;
}

.navbar-toggler {
    border: none;
    background: none;
}

.navbar-toggler:focus {
    outline: none;
}

.navbar-toggler-icon {
    background-image: none;
    font-size: 1.5rem;
    color: white;
}

.dropdown .dropdown-menu a:hover {
    background: gray;
    color: var(--bs-light);
}

.navbar .nav-item:hover .dropdown-menu {
    transform: rotateX(0deg);
    visibility: visible;
    background: var(--bs-light) !important;
    border-radius: 10px !important;
    transition: .5s;
    opacity: 1;
}

#searchModal .modal-content {
    background: black;
   	margin: auto;
}

.collapse-category {
    background: black;
    color: white;
    position: absolute;
    width: 100%;
    z-index: 1000;
}

.collapse-category .collapse-category {
    background: black;
}

.top-ul {
    list-style: none;
}

.big-category {
    font-weight: bold;
    margin-bottom: 15px;
}

#top-class-regist {
    border: 1px solid white;
    border-radius: 5px;
}

.collapse-category .col {
    display: flex;
    flex-direction: column;
}

.collapse-category .big-category {
    flex-shrink: 0;
    margin-bottom: 10px;
}

.collapse-category .top-ul {
    padding-left: 0;
}

.collapse-category .top-ul li {
    list-style: none;
}



.offcanvas-body {
    color: white !important;
}

@media (min-width: 992px) {
    .offcanvas {
        display: none !important; /* 992px 이상 화면에서는 offcanvas 숨기기 */
    }
    
}

@media (max-width: 992px) {
    .navbar {
	    height: 120px;
	    border-bottom: 1px solid rgba(255, 255, 255, .3);
	    background: black !important; /* Navbar 배경을 검정색으로 설정 */
	}
    
}


.search-box {
	height: 40px;
	width:  300px;
	background-color: rgba(255, 255, 255, 0.8);
	border-radius: 40px;
	padding: 10px;
	border: 1px solid #f9deec;
	
}

.search-txt {
    border: none;
    background : none;
    outline: none;
    float: left;
    padding: 0px;
    padding-left: 10px;
    color: black;
    font-size: 15px;
    width: 80%;
}

.search-btn {
	color: black;
	float: right;
	width: 40px;
	height: 100%;
	border-radius: 50%;
	border: none;
	background: none;
	font-size: 16px;
	display:flex;
	justify-content: center;
	align-items: center; 
	
	
}

.search-box-area {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    display: none;  
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.8);
    z-index: 999;
}

.search-box-area .modal-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: black;
    padding: 20px;
    border-radius: 10px;
    position: relative;
}

.search-box-area .modal-header .close {
    position: absolute;
    top: 10px;
    right: 10px;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
}

.recommend-keyword {
	color: white;
	border: 1px solid white;
	border-radius: 30px;
	padding: 10px 15px;;
	margin: 10px;
	font-size: 14px;
}



/*** Top Navbar End ***/

</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const collapseElements = document.querySelectorAll('[data-bs-toggle="collapse"]');

        let currentOpenCollapse = null;

        const openCollapse = (target) => {
            if (currentOpenCollapse && currentOpenCollapse !== target) {
                currentOpenCollapse.classList.remove('show');
            }
            target.classList.add('show');
            currentOpenCollapse = target;
        };

        const closeCollapse = (target) => {
            target.classList.remove('show');
            if (currentOpenCollapse === target) {
                currentOpenCollapse = null;
            }
        };

        collapseElements.forEach(function (elem) {
            const target = document.querySelector(elem.getAttribute('data-bs-target'));

            elem.addEventListener('mouseenter', () => openCollapse(target));
            
            target.addEventListener('mouseenter', () => openCollapse(target));
            target.addEventListener('mouseleave', () => closeCollapse(target));
        });
        
        
       
    });
    
    function logout() {
		
    	if(confirm("로그아웃하시겠습니까?")) {
    		location.href = "member-logout";
    	}
    } 
    
    
</script>




<!-- 본문 시작 -->
<!-- Navbar start -->
<div class="class-will-top">
	<div class="container-fluid ">
	    <div class="container px-0 top-cate">
	        <nav class="navbar navbar-expand-lg bg-body-tertiary">
	            <div class="container-fluid">
	                <div class="row w-100 d-lg-flex d-md-none d-none align-items-end top-nev-lg">
	                    
	                    <!-- 왼쪽 네비게이션 영역 -->
		                    <div class="col-5 d-none d-lg-flex justify-content-start  mb-3">
		                        <ul class="navbar-nav">
		                            <li class="nav-item">
		                                <a href="#" class="nav-link" data-bs-toggle="collapse" id="top-categoty"  data-bs-target="#collapse-category" aria-expanded="false" aria-controls="collapse-category">
	<!-- 	                                	<i class="bi bi-list"></i> 카테고리 -->
		                                	<span class="fa fa-bars"></span> 카테고리
		                                </a>
		                            </li>
		                            <li class="nav-item">
		                                <a class="nav-link" href="" data-bs-toggle="collapse" id="top-local" data-bs-target="#collapse-zone" aria-expanded="false" aria-controls="collapse-zone">
		                                	지역별
		                                </a>
		                            </li>
		                            <li class="nav-item">
		                                <a class="nav-link" href="event">이벤트</a>
		                            </li>
<!-- 				                            <li class="nav-item"> -->
<!-- 				                                <a class="nav-link" data-bs-toggle="modal" data-bs-target="#searchModal" href="#"><i class="bi bi-search bi-top"></i></a> -->
<!-- 				                            </li> -->
		                        </ul>
		                    </div> <!-- col-5 -->
	
	                    <!-- 가운데 로고 영역 (큰 화면) -->
	                    <div class="col-2 d-none d-lg-flex justify-content-center">
	                        <a class="navbar-brand" href="main">
	                            <img src="${pageContext.request.contextPath}/resources/img/class_will_logo.png" width="200px" alt="Logo" class="d-inline-block align-text-top">
	                        </a>
	                    </div>
	
	                    <!-- 오른쪽 네비게이션 영역 -->
	                    <div class="col-5 mb-3">
							<div class="row mb-4">
		                    	<div class="col d-none d-lg-flex justify-content-end ">
									<ul class="navbar-nav">
									    <li class="nav-item px-4">
									        <a class="nav-link" href="creator-main" id="top-class-regist">클래스등록</a>
									    </li>
									    <li class="nav-item">
									        <a class="nav-link" href="main-test"><i class="bi bi-envelope bi-top"></i></a>
									    </li>
									    
									    <c:choose>
											<c:when test="${empty member.member_email}">
												<li class="nav-item"> 
													<a class="nav-link" href="member-login">로그인</a>
												</li>
											</c:when>
											<c:when test="${member.member_type eq 3}">
												<li class="nav-item"> 
													<a class="nav-link" href="admin"><i class="bi bi-gear"></i> 관리자</a>
												</li>
												<li class="nav-item">
												    <a class="nav-link" onclick="logout()">로그아웃</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="nav-item">
												    <a class="nav-link" href="my-page"><i class="bi bi-person-circle bi-top"></i></a>
												</li>
												<li class="nav-item">
												    <a class="nav-link" onclick="logout()">로그아웃</a>
												</li>
											</c:otherwise>
										</c:choose>
									</ul>
			                     </div>  <!--  col -->           
			            	</div> 
			            	<!-- top 검색창 -->
			            	<div class="row">
								<div class="col d-none d-lg-flex justify-content-end px-4">
									<form class="search-box">
										<input class="search-txt align-items-center" type="text" name="keyword" placeholder="관심 주제, 클래스, 크리에이터">
										<button class="search-btn" type="button" ><i class="bi bi-search bi-top"></i></button>
									</form>
								</div>
							</div>   
	                    </div>
		            </div> <!-- row -->
	                

                    <!-- 로고와 햄버거 버튼 (작은 화면) -->
					<div class="row w-100 d-flex d-lg-none align-items-end">
	                    <div class="col-8 d-flex d-lg-none justify-content-start">
	                        <a class="navbar-brand" href="main">
	                            <img src="${pageContext.request.contextPath}/resources/img/class_will_logo.png" width="150px" alt="Logo" class="d-inline-block align-text-top">
	                        </a>
	                    </div>
	                    <div class="col-4 d-flex d-lg-none justify-content-end align-items-center mb-3 mx-0">
	                         <button class="navbar-toggler py-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#top-offcanvas">
		                        <span class="fa fa-bars text-white"></span>
		                    </button>
	                    </div>
					</div>
					
				</div> <!-- container-fluid -->
				
	            <!-- 오프캔버스 -->
	            <div class="offcanvas offcanvas-start " id="top-offcanvas" style="background-color: #333; color: white;">
	                <div class="offcanvas-header">
	                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	                </div>
	                <div class="offcanvas-body">
	                	<div>
		                    <ul>
		                    	<c:choose>
									<c:when test="${empty member.member_email}">
										<li class=""> 
											<a class="" href="member-login">로그인</a>
										</li>
									</c:when>
									<c:when test="${member.member_type eq 3}">
										<li class=""> 
											<a class="" href="admin"><i class="bi bi-gear"></i> 관리자</a>
										</li>
										<li class="">
										    <a class="" onclick="logout()">로그아웃</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="">
										    <a class="" href="my-page"><i class="bi bi-person-circle bi-top"></i> 내 정보</a>
										</li>
										<li class="">
										    <a class="" onclick="logout()">로그아웃</a>
										</li>
									</c:otherwise>
								</c:choose>
		                    	<li>이벤트</li>
		                    	<li>카테고리</li>
		                    	<li>지역별</li>
	                 	   </ul>
	                    </div>
	                     <div class="dropdown mt-3">
					      <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
					        Dropdown button
					      </button>
					      <ul class="dropdown-menu">
					        <li><a class="dropdown-item" href="#">Action</a></li>
					        <li><a class="dropdown-item" href="#">Another action</a></li>
					        <li><a class="dropdown-item" href="#">Something else here</a></li>
					      </ul>
					    </div>
	                </div> <!-- offcanvas-body -->
	            </div> <!-- offcanvas -->
	            
	        </nav>
	    </div> <!-- top-cate -->
	</div> <!-- container-fluid -->
	<!-- Navbar End -->
	
<!-- 	<!-- Modal Search Start --> 
<!-- 	<div class="modal fade" id="searchModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 	    <div class="modal-dialog"> -->
<!-- 	        <div class="modal-content rounded-0"> -->
<!-- 	            <div class="modal-header"> -->
<!-- 	                <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5> -->
<!-- 	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 	            </div> -->
<!-- 	            <div class="modal-body d-flex align-items-center"> -->
<!-- 	                <div class="input-group w-75 mx-auto d-flex"> -->
<!-- 	                    <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1"> -->
<!-- 	                    <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!-- 	        </div> -->
<!-- 	    </div> -->
<!-- 	</div> -->
<!-- 	<!-- Modal Search End --> 
	
<!-- 	<!-- Modal Search2 Start --> 
<!-- 	<div class="modal fade container-fluid" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 	    <div class="modal-dialog modal-xl"> -->
<!-- 	        <div class="modal-content rounded-0"> -->
<!-- 	            <div class="modal-header d-flex justify-content-center"> -->
<!-- 	                <form action="search-keyword" class="search-box d-flex justify-content-center" method="post"> -->
<!-- 						<input class="search-txt align-items-center " type="text" name="keyword" placeholder="관심 주제, 클래스, 크리에이터"> -->
<!-- 						<button class="search-btn" type="button" data-bs-toggle="modal" data-bs-target="#searchModal"> -->
<!-- 							<i class="bi bi-search bi-top"></i> -->
<!-- 						</button> -->
<!-- 					</form> -->
<!-- 	                <button type="button" class="btn-close d-flex justify-content-end" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 	            </div> -->
<!-- 	            <div class="modal-body d-flex align-items-center justify-content-center"> -->
<!-- 	                <h5>추천 검색어</h5> -->
<!-- 	            </div> -->
<!-- 	        </div> -->
<!-- 	    </div> -->
<!-- 	</div> -->
<!-- 	<!-- Modal Search End --> 
	
	<!-- Search Box Area -->
	<div class="search-box-area" id="searchModal">
	    <div class="modal-content">
	        <div class="modal-header">
	            <span class="close">&times;</span>
	        </div>
	        <div class="modal-body">
	            <form action="search-keyword" class="search-box d-flex justify-content-center" method="post">
	                <input class="search-txt align-items-center" id="keyword" type="text" name="keyword" placeholder="관심 주제, 클래스, 크리에이터">
	                <button class="search-btn" type="submit"> <i class="bi bi-search bi-top"></i></button>
	            </form>
	        </div>
	        <div class="recommend my-3 py-3 text-center">
	            <!-- 추천 검색어 영역 -->
	            <h5 class="mb-3">추천 검색어</h5>
	            <ul class="d-flex justify-content-center">
	            	<li class="btn recommend-keyword"><a href="">추천어1</a></li>
	            	<li class="btn recommend-keyword"><a href="">추천어2</a></li>
	            	<li class="btn recommend-keyword"><a href="">추천어3</a></li>
	            	<li class="btn recommend-keyword"><a href="">추천어4</a></li>
	            	<li class="btn recommend-keyword"><a href="">추천어5</a></li>
	            </ul>
	        </div>
	    </div>
	</div>
				
	
	
	<div class="container-fluid">
		<!-- 분야 카테고리 -->
	    <div class="collapse collapse-category" id="collapse-category">
	        <div class="card card-body collapse-category">
	            <div class="container">
	                <div class="row" id="fieldCategoryArea">
	                <!-- 분야 카테고리 목록 ajax -->
	                </div><!-- row -->
	            </div>
	        </div>
	    </div>
		<!-- 지역 카테고리 -->
	    <div class="collapse collapse-category" id="collapse-zone">
			<div class="card card-body collapse-category">
		  		<div class="container">
					<div class="row" id="localCategoryArea">
						<!-- 지역 카테고리 목록 ajax -->
					</div><!-- row -->
				</div>
			</div>
		</div>
	</div>  
</div> <!-- class-will-top -->

<script>
$(function() {
	
	$("#top-categoty").on("mouseover", function() {
		$.ajax({
			type: "GET",
	        url: "top-field-category",
		 	dataType : "json",
		 	contentType: "application/json",
		 	success : function(fieldCategory) {
		 		$("#fieldCategoryArea").html("");
			 	for(field of fieldCategory) {
			 		console.log("field.id : " + field.id);
			 		console.log("field.largeCategory : " + field.largeCategory);
			 		let fieldSmallAreaId = "fieldSmallArea"+field.id;
			 		
			 		$("#fieldCategoryArea").append(
						 ' <div class="col col-2 text-left">'
	                       + '<div>'
	                           + '<a href="class-list"><span class="big-category mb-3">'+field.largeCategory+'</span></a>'
	                           + '<ul class="top-ul mt-3 mb-3" id="'+fieldSmallAreaId+'">'
	                           + '</ul>'
	                       + '</div>'
	                   + '</div>');
			 		
			 		for(children of field.children) {
			 			console.log("children.id : "+ children.id);
			 			console.log("children.largeCategory : "+children.largeCategory);
			 			console.log("children.smallCategory : "+children.smallCategory);
			 			 $("#" + fieldSmallAreaId).append('<li><a href="">' + children.smallCategory + '</a></li>');
			 		
			 		}
			 	}
		 		
		 	},
		 	error: function(xhr, status, error) {
		        console.error("Error details:", xhr, status, error); // 디버깅 정보 출력
				
		        alert("오류 발생" + error);
		    }
			
		});
	
		
	});
	
	
	$("#top-local").on("mouseover", function() {
		$.ajax({
			type: "GET",
	        url: "top-local-category",
		 	dataType : "json",
		 	contentType: "application/json",
		 	success : function(localCategory) {
		 		$("#localCategoryArea").html("");
			 	for(local of localCategory) {
				 	$("#localCategoryArea").append(
				 		  '<div class="col col-2 text-left mb-3">'
						+ 	'<a href="class-list"><span class="big-category">' + local.local_name + '</span></a>'
						+ '</div>'		
				 	);
			 	}
		 	},
		 	error: function(xhr, status, error) {
		        console.error("Error details:", xhr, status, error); // 디버깅 정보 출력
		        alert("오류 발생" + error);
		    }
		});
	
		
	});
	
	
    // 검색창과 검색 버튼 클릭 시 #search-box-area 나타남
    $('.search-box, .search-txt, .search-btn, .search-btn2').on('click', function(event) {
        $('#searchModal').fadeIn();
        $("#keyword").focus();
    });

    // close 버튼 클릭 시 #search-box-area 사라짐
    $('.search-box-area .close').on('click', function() {
        $('#searchModal').fadeOut();
    });
	
    const collapseElements = $('[data-bs-toggle="collapse"]');

    let currentOpenCollapse = null;

    const openCollapse = (target) => {
        if (currentOpenCollapse && currentOpenCollapse !== target) {
            currentOpenCollapse.removeClass('show');
        }
        target.addClass('show');
        currentOpenCollapse = target;
    };

    const closeCollapse = (target) => {
        target.removeClass('show');
        if (currentOpenCollapse === target) {
            currentOpenCollapse = null;
        }
    };

    collapseElements.each(function() {
        const elem = $(this);
        const target = $(elem.attr('data-bs-target'));

        elem.on('mouseenter', () => openCollapse(target));
        target.on('mouseenter', () => openCollapse(target));
        target.on('mouseleave', () => closeCollapse(target));
    });
	
	

    

	
});



</script>