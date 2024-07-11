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
</head>
	<style>

	</style>

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
                        <h1 class="h3 mb-0 text-gray-800">신고관리</h1>
                    </div>
                    <div>
                        <button class="category-btn" data-category="member" onclick="location.href='admin-report?status=처리중'">처리중</button>
                        <button class="category-btn" data-category="teacher" onclick="location.href='admin-report?status=처리완료'">처리완료</button>
                    </div>
                    <!-- Content Row -->
                    <div class="row">
                        <div class="col-xl-12 col-lg-12">
                            <div id="grid"></div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
                	<jsp:include page="admin_modal.jsp">
               		    <jsp:param name="tableName" value="${tableName}" />
                	</jsp:include>
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

            class ButtonRenderer {
                constructor(props) {
                    const el = document.createElement('button');
                    el.className = 'btn btn-primary btn-sm';
                    el.innerText = '상세보기';
                    el.addEventListener('click', () => {
                        const rowKey = props.grid.getIndexOfRow(props.rowKey);
                        const rowData = props.grid.getRow(rowKey);
                        const class_report_code = rowData.class_report_code;
                        window.open("admin-class-report-detail?class_report_code=" + class_report_code, "신고 상세보기", "height=1000px, width=1200px");
                    });
                    this.el = el;
                }
                getElement() {
                    return this.el;
                }
                render(props) {
                    this.el.dataset.rowKey = props.rowKey;
                    this.el.dataset.columnName = props.columnName;
                    this.el.value = props.value;
                }
            }

            const grid = new tui.Grid({
                el: document.getElementById('grid'),
                data: data,
                columns: [
                    { header: '회원 아이디', name: 'member_email'},
                    { header: '클래스 이름', name: 'class_name'},
                    { header: '대분류', name: 'class_report_big_category'},
                    { header: '소분류', name: 'class_report_small_category'},
                    { header: '처리상태', name: 'class_report_status'},
                    {
                        header: '상세보기',
                        name: 'action',
                        renderer: {
                            type: ButtonRenderer
                        }
                    }
                ],
                bodyHeight: 400,
    	        pageOptions: {
    	            useClient: true,
    	            perPage: itemsPerPage
    	        }
            });
            
            $('#btn-apply').on('click', function () {
                const modifiedRows = grid.getModifiedRows();
                const jsonData = JSON.stringify(modifiedRows);

                fetch('/insert', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: jsonData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('변경 사항이 성공적으로 적용되었습니다.');
                        location.reload();
                    } else {
                        alert('변경 사항 적용 실패: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('변경 사항 적용 실패: 서버 오류');
                });
            });
        });

    </script>
</body>
</html>
