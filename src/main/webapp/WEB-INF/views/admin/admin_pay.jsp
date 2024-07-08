<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자 페이지</title>

    <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
    <!-- Toast UI Grid CSS -->
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.grid/latest/tui-grid.css">
    
    <!-- Toast UI Grid Script -->
    <script src="https://uicdn.toast.com/tui.grid/latest/tui-grid.js"></script>
    
    <!-- Toast UI Pagination CSS -->
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">

    <!-- Toast UI Pagination Script -->
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	<!-- admin_utils.js 로드 -->
    <script src="${pageContext.request.contextPath}/resources/js/admin_utils.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_default.css">
    
    <script>
    	if("${alert}" != null && "${alert}" != ""){
    		alert("${alert}");
    	}
    </script>
    
    <style>
		.content-wrapper {
        	margin-top : 50px;
        }
	</style>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <%-- <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/side_bar.jsp"></jsp:include> --%>
        <jsp:include page="side_bar.jsp"></jsp:include>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">


                <div class="container-fluid">
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">결제관리</h1>
                        <div class="btn-group">
                            <button id="btn-download" class="btn btn-success btn-sm" onclick="downloadExcel('pay', '전체 결제 리스트', false)">엑셀 다운로드</button>
                            <input type="file" id="file-input" style="display:none;" />
                        </div>
                    </div>
                    <div>
                        <button class="category-btn" data-category="member" onclick="location.href='admin-pay'">일반결제 관리</button>
                        <button class="category-btn" data-category="teacher" onclick="location.href='admin-pay-willpay'">윌페이 관리</button>
                    </div>
                    <!-- Content Row -->
                    <div class="row">
                        <div class="col-xl-12 col-lg-12">
                            <div id="grid"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <!-- Footer 내용 생략 -->
        </div>
        <!-- End of Content Wrapper -->
        
    </div>
    <!-- End of Page Wrapper -->

    <!-- Bootstrap core JavaScript-->
   <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>

    <!-- Toast UI Grid Script -->
    <script src="https://uicdn.toast.com/tui.grid/latest/tui-grid.js"></script>
    
    <script>
        $(document).ready(function () {
            const data = ${jo_list};
    	    const itemsPerPage = 10;
    	    let currentPage = 1;
    	    
            const grid = new tui.Grid({
                el: document.getElementById('grid'),
                data: data,
                columns: [
                    { header: '이메일(아이디)', name: 'member_email', editor: 'text' },
                    { header: '클래스명', name: 'class_name', editor: 'text' },
                    { header: '결제일자', name: 'pay_datetime', editor: 'text' },
                    { header: '결제금액', name: 'pay_amount', editor: 'text' },
                    { header: '결제수단', name: 'pay_type', editor: 'text' },
                    { header: '결제상태', name: 'pay_status', editor: 'text' },
                ],
                rowHeaders: ['rowNum'],
                bodyHeight: 400,
    	        pageOptions: {
    	            useClient: true,
    	            perPage: itemsPerPage
    	        }
            });
        });
    </script>
</body>
</html>
