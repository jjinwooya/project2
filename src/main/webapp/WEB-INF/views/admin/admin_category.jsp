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
    <style>
        .add-btn {
            cursor: pointer;
            color: blue;
            margin-left: 10px;
        }
        
    </style>
    
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_default.css">
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
</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

    <!-- 사이드 바 포함 -->
    <jsp:include page="side_bar.jsp"></jsp:include>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                
                <div class="container-fluid">
				   <div class="d-sm-flex align-items-center justify-content-between mb-4">
					    <h1 class="h3 mb-0 text-gray-800">카테고리 리스트</h1>
					    <div class="btn-group">
					        <button id="btn-delete" class="btn btn-danger btn-sm">삭제</button> <!-- 삭제 버튼 추가 -->
					        <input type="file" id="file-input" style="display:none;" />
					        <button id="btn-apply" class="btn btn-warning btn-sm">적용</button>
					    </div>
					</div>
				
				    <!-- Content Row -->
				    <div class="row">
				        <div class="col-xl-12 col-lg-12">
				            <div id="grid"></div>
<!-- 				            <div id="pagination"></div> -->
<!-- 				            <button id="add-category" class="btn btn-primary btn-sm mt-3">카테고리 추가</button> -->
				        </div>
				    </div>
				</div>
                
                </div>
                <!-- /.container-fluid -->

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
	document.addEventListener('DOMContentLoaded', function () {
	    const data = JSON.parse('${jo_list}');
	    console.log(data); // 데이터 구조를 확인하기 위해 콘솔에 출력
	    const itemsPerPage = 10; // 한 페이지당 표시할 항목 수
	    let currentPage = 1; // 현재 페이지 번호
	
	    // BootstrapSwitchRenderer 클래스 정의 (스위치 렌더러)
	    class BootstrapSwitchRenderer {
	        constructor(props) {
	            const el = document.createElement('div');
	            el.className = 'custom-control custom-switch';
	
	            const input = document.createElement('input');
	            input.type = 'checkbox';
	            input.className = 'custom-control-input';
	            input.id = 'customSwitch' + props.rowKey;
	            input.checked = props.value;
	            input.addEventListener('change', () => {
	                props.grid.setValue(props.rowKey, props.columnInfo.name, input.checked);
	            });
	
	            const label = document.createElement('label');
	            label.className = 'custom-control-label';
	            label.htmlFor = 'customSwitch' + props.rowKey;
	
	            el.appendChild(input);
	            el.appendChild(label);
	
	            this.el = el;
	        }
	
	        getElement() {
	            return this.el;
	        }
	
	        render(props) {
	            this.el.querySelector('input').checked = props.value;
	        }
	    }
	
	    // AddButtonRenderer 클래스 정의 (추가 버튼 렌더러)
	    class AddButtonRenderer {
	        constructor(props) {
	            const el = document.createElement('div');
	            el.className = 'add-btn';
	            el.textContent = '+';
	            el.addEventListener('click', () => {
	                const parentRowKey = props.rowKey;
	                const parentRow = props.grid.store.data.rawData.find(row => row.rowKey === parentRowKey);
	                const newRow = {
	                    id: data.length + 1,
	                    largeCategory: parentRow.largeCategory, // 상위 요소의 대분류 값 복사
	                    smallCategory: '',
	                    _children: [],
	                    expanded: false
	                };
	                if (!parentRow._children) {
	                    parentRow._children = [];
	                }
	                parentRow._children.push(newRow);
	                props.grid.appendRow(newRow, { parentRowKey });
	            });
	
	            this.el = el;
	        }
	
	        getElement() {
	            return this.el;
	        }
			
	        render(props) {
	            // 상위 요소에만 버튼 표시
	            console.log(props);
	            if (!props.tree) {
	                this.el.style.display = 'block'; // 최상위 요소에만 버튼 표시
	            } else {
	                this.el.style.display = 'none';  // 최상위 요소가 아닌 경우 버튼 숨기기
	            }
	        }
	    }
	    
	    // ToastUI Grid 생성
	    const grid = new tui.Grid({
	        el: document.getElementById('grid'),
	        data: data.slice(0, itemsPerPage), // 처음에 첫 페이지 데이터만 로드
	        treeColumnOptions: {
	            name: 'largeCategory',
	            useCascadingCheckbox: true,
	            useIcon: true, // 트리 아이콘 사용
	            isTop : true
	        },
	        columns: [
	            {
	                header: '추가',
	                name: 'add',
	                width: 50,
	                renderer: {
	                    type: AddButtonRenderer
	                }
	            },
	            { header: '대분류', name: 'largeCategory', editor: 'text' },
	            { header: '소분류', name: 'smallCategory', editor: 'text' },
	            {
	                header: '숨김',
	                name: 'hidden',
	                renderer: {
	                    type: BootstrapSwitchRenderer
	                }
	            }
	        ],
	        rowHeaders: ['checkbox'],
	        bodyHeight: 800, // 본체 높이 설정
	        height: 600 // 전체 높이 설정
	    });
	    
        $('#btn-apply').on('click', function () {
            const modifiedRows = grid.getModifiedRows();
            const jsonData = JSON.stringify(modifiedRows);
			if(confirm("정말 모든 변경사항을 저장하시겠습니까?")){
	            fetch('insert', {
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
			}
        });
        
        // 데이터 삭제 적용
        $('#btn-delete').on('click', function () {
            const checkedRows = grid.getCheckedRows();
            checkedRows.forEach(row => {
                grid.removeRow(row.rowKey);
            });
        });
        
        
	    // 무한 스크롤 로직
	    const gridContainer = document.querySelector('#grid .tui-grid-body-area');
	
	    gridContainer.addEventListener('scroll', () => {
	        // 스크롤이 끝에 도달했을 때 다음 페이지 데이터 로드
	        if (gridContainer.scrollTop + gridContainer.clientHeight >= gridContainer.scrollHeight) {
	            currentPage++;
	            const nextPageData = data.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);
	            if (nextPageData.length > 0) {
	                grid.appendRows(nextPageData);
	            }
	        }
	    });
	});
</script>
</body>
</html>
