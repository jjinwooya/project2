<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/b43f956240.js" crossorigin="anonymous"></script>
</head>
<body>

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath }/admin">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img src="${pageContext.request.contextPath}/resources/img/class_will_logo.png" width="80px">
                </div>
                <div class="sidebar-brand-text mx-3">Class Will</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath }/admin">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>대쉬보드</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                관리
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fa-solid fa-user"></i>
                    <span>회원 관리</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">회원 관리 :</h6>
                        <a class="collapse-item" href="${pageContext.request.contextPath}/admin-member?type=일반회원">회원 리스트</a>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-member?type=크리에이터">강사 리스트</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseClass"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fa-solid fa-school"></i>
                    <span>클래스 관리</span>
                </a>
                <div id="collapseClass" class="collapse" aria-labelledby="headingClass"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">클래스 관리:</h6>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-class?type=1">리스트</a>
                    </div>
                </div>
            </li>
            
            <!-- Nav Item - 카테고리 -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCategory"
                    aria-expanded="true" aria-controls="collapseCategory">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <span>카테고리 관리</span>
                </a>
                <div id="collapseCategory" class="collapse" aria-labelledby="headingCategory"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">클래스 카테고리 관리:</h6>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-category">리스트</a>
                    </div>
                </div>
            </li>
            
            <!-- Nav Item - 고객센터 -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCsc"
                    aria-expanded="true" aria-controls="collapseCsc">
                   <i class="fa-solid fa-handshake"></i>
                    <span>고객센터 관리</span>
                </a>
                <div id="collapseCsc" class="collapse" aria-labelledby="headingCsc"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">고객센터 관리:</h6>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-csc?type=notice">공지사항 리스트</a>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-csc?type=faq">FAQ 리스트</a>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-event">이벤트 리스트</a>
                    </div>
                </div>
            </li>
            
            <!-- Nav Item - 결제관리 -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePay"
                    aria-expanded="true" aria-controls="collapsePay">
                 	 <i class="fa-solid fa-coins"></i>
                    <span>결제 관리</span>
                </a>
                <div id="collapsePay" class="collapse" aria-labelledby="headingPay"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">결제 관리:</h6>
                        <a class="collapse-item" href="admin-pay">일반 결제</a>
                        <a class="collapse-item" href="admin-pay-willpay">크레딧 결제</a>
                    </div>
                </div>
            </li>
            
            <!-- Nav Item - 신고관리 -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseComplaint"
                    aria-expanded="true" aria-controls="collapseComplaint">
                   <i class="fa-solid fa-robot"></i>
                    <span>신고 관리</span>
                </a>
                <div id="collapseComplaint" class="collapse" aria-labelledby="headingComplaint"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">클래스신고 관리:</h6>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-report?status=처리중">처리중 리스트</a>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-report?status=처리완료">처리완료 리스트</a>
                        <h6 class="collapse-header">1:1 채팅 관리:</h6>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-report?status=처리중">처리중 리스트</a>
                        <a class="collapse-item" href="${pageContext.request.contextPath }/admin-report?status=처리완료">처리완료 리스트</a>
                    </div>
                </div>
            </li>
            <hr class="sidebar-divider">
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}">
                <i class="fa-solid fa-house"></i>
                <span>메인 페이지</span></a>
            </li>

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
</body>
</html>