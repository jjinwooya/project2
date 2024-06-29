<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <!-- 본문 시작 -->
        <!-- Navbar start -->
        <div class="container-fluid fixed-top">
<!--             <div class="container topbar bg-primary d-none d-lg-block"> -->
<!--                 <div class="d-flex justify-content-between"> -->
<!--                     <div class="top-info ps-2"> -->
<!--                         <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">123 Street, New York</a></small> -->
<!--                         <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">Email@Example.com</a></small> -->
<!--                     </div> -->
<!--                     <div class="top-link pe-2"> -->
<!--                         <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a> -->
<!--                         <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a> -->
<!--                         <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
            <div class="container px-0 top-cate">
                <nav class="navbar navbar-expand-xl">
                    <a href="main" class="navbar-brand"><img src="${pageContext.request.contextPath}/resources/img/클래스로고2.png" width="180px"></a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="main" class="nav-item nav-link">Home</a>
                            <div class="nav-item dropdown">
                                <a href="shop" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">shop</a>
                                <div class="dropdown-menu m-0 bg-white rounded-0">
                                    <a href="chackout" class="dropdown-item">Chackout</a>
                                    <a href="404" class="dropdown-item">404 Page</a>
                                </div>
                            </div>
                            <a href="shop" class="nav-item nav-link">shop</a>
                            <a href="shop-detail" class="nav-item nav-link">shop-detail</a>
                            <a href="creator-main" class="nav-item nav-link">클래스등록</a>
                            <a href="event" class="nav-item nav-link">이벤트</a>
                        </div>
                        <div class="d-flex m-2 me-0">
                            <button class="btn-search btn border border-light btn-md-square rounded-circle me-4" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-light"></i></button>
                            <a href="#" class="position-relative me-4 my-auto">
                                <i class="fa fa-shopping-bag fa-2x"></i>
                                <span class="position-absolute bg-light rounded-circle d-flex align-items-center justify-content-center text-body px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
                            </a>
                            <a href="myPage" class="my-auto">
                                <i class="fas fa-user fa-2x"></i>
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->

        <!-- Modal Search Start -->
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">키워드 검색하기</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->
        
        <!-- Modal Search Start -->
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->
