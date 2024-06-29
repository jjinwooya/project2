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
                        <h1 class="h3 mb-0 text-gray-800">클래스 리스트</h1>
                            <div class="btn-group">
               <button id="btn-download" class="btn btn-success btn-sm" onclick="downloadExcel('class', '전체 클래스 리스트', false)">엑셀 다운로드</button>
                          <button id="btn-upload" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#excelUploadModal">데이터 업로드</button>
                            <input type="file" id="file-input" style="display:none;" />
                        </div>
                        </div>
   						<div>
	                        <button class="category-btn" data-category="member" onclick="location.href='admin-class?type=1'">등록대기</button>
	                        <button class="category-btn" data-category="teacher" onclick="location.href='admin-class?type=2'">등록완료</button>
	                    </div>
                    </div>

                    <!-- Content Row -->
                    <div class="row">
                        <div class="col-xl-12 col-lg-12">
                            <div id="grid"></div>
                            <div id="pagination"></div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
				<jsp:include page="admin_modal.jsp" >
					<jsp:param value="${tableName}" name="tableName"/>
				</jsp:include>
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <!-- Footer 내용 생략 -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
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
        document.addEventListener('DOMContentLoaded', function () {
            const data = ${jo_list};
    	    const itemsPerPage = 10;
    	    let currentPage = 1;

            // 상세보기 버튼
	        class ButtonRenderer {
	            constructor(props) {
	                const el = document.createElement('button');
	                el.className = 'btn btn-primary btn-sm';
	                el.innerText = '상세보기';
	                el.addEventListener('click', () => {
	                    const rowKey = props.grid.getIndexOfRow(props.rowKey);
	                    const rowData = props.grid.getRow(rowKey);
	                    const classCode = rowData.class_code;
	                    window.open("admin-class-detail?class_code=" + classCode, "클래스 상세보기", "height=600px, width=800px");
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
                    { header: '클래스이름', name: 'class_name' , editor: 'text'},
                    { header: '클래스구분', name: 'class_type' , editor: 'text'},
                    { header: '카테고리', name: 'class_category' , editor: 'text'},
                    { header: '강사이름', name: 'member_name' , editor: 'text'},
                    { header: '등록상태', name: 'class_regist_status' , editor: 'text'},
                    {
                        header: 'Action',
                        name: 'action',
                        renderer: {
                            type: ButtonRenderer
                        }
                    }
                ],
    	        pageOptions: {
    	            useClient: true,
    	            perPage: itemsPerPage
    	        },
                bodyHeight: 400
            });
            
            // 페이지 변경 이벤트
            pagination.on('beforeMove', function (event) {
                const currentPage = event.page;
                const startRow = (currentPage - 1) * 10;
                const endRow = startRow + 10;

                grid.resetData(data.slice(startRow, endRow));
            });
            
            // 초기 데이터 설정
            grid.resetData(data.slice(0, 10));
        });
    </script>
	
</body>
</html>