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
    

</head>
<style>
   	#grid-container {
    	width: 30%;
	}
	
	.content-wrapper {
       	margin-top : 50px;
    }
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
                        <h1 class="h3 mb-0 text-gray-800">윌페이 매출</h1>
                    </div>
                    <div>
                        <button class="category-btn" data-category="member" onclick="location.href='admin-pay'">일반결제 관리</button>
                        <button class="category-btn" data-category="teacher" onclick="location.href='admin-pay-willpay'">윌페이 관리</button>
                    </div>
                    <!-- Content Row -->
                    <div class="row">
                       <!-- Area Chart -->
                        <div class="col-xl-8 col-lg-7">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">매출 그래프</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                            aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">Dropdown Header:</div>
                                            <a class="dropdown-item" id="downloadBtn">차트 다운로드</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="myAreaChart"></canvas>
                                    </div>
                                    <div id="grid-container">
                                    	<div id="grid"></div>
                             	        <button id="btn-apply" class="btn btn-primary mt-2">적용</button>
                                    </div>
                                </div>
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

    <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>
    
    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/js/demo/number_format.js"></script>
	
    
 <script>
	$(document).ready(function() {
		const data2 = ${jo_list};
		var myLineChart;
		
	    document.getElementById('downloadBtn').addEventListener('click', function() {
	        var link = document.createElement('a');
	        link.href = myLineChart.toBase64Image();
	        link.download = '윌페이매출차트.png';
	        link.click();
	    });
	    
	    function fetchSalesData() {
	        $.ajax({
	            url: 'willpay-chart',
	            method: 'GET',
	            success: function(data) {
	                updateChart(data);
	            },
	            error: function(error) {
	                console.error('Error fetching sales data:', error);
	            }
	        });
	    }
	    
        const grid = new tui.Grid({
            el: document.getElementById('grid'),
            data: data2,
            columns: [
                { header: '기준금액(이상)', name: 'reward_fee', editor: 'text', width : 120, sortable: true},
                { header: '보상률', name: 'reward_rate', editor: 'text', width : 120}],
           	bodyHeight: 200,
            sortingType: 'asc',  // 초기 오름차순 정렬
            columnOptions: {
                resizable: true
            }
        });
        
        grid.on('afterChange', (ev) => {
        	console.log(ev);
            const { columnName, value, rowKey } = ev.changes[0];
            if (columnName === 'reward_fee' || columnName === 'reward_rate') {
                if (!/^\d+$/.test(value)) {  // 숫자만 허용
                    alert('숫자만 입력 가능합니다.');
                	location.reload();
                }
            }
            grid.sort('reward_fee', true);  // 'reward_fee' 기준 오름차순 정렬
        });
        
        $('#btn-apply').on('click', function () {
            const modifiedRows = grid.getModifiedRows().updatedRows;

            // 각 수정된 행에 대해 개별적으로 업데이트 요청을 보냅니다.
            modifiedRows.forEach(row => {
                const jsonData = JSON.stringify(row);

                fetch('insertReward', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: jsonData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        console.log('변경 사항이 성공적으로 적용되었습니다.', row);
                        alert(data.message);
                    } else {
                        console.error('변경 사항 적용 실패: ', data.message, row);
                        alert('변경 사항 적용 실패: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error, row);
                    alert('변경 사항 적용 실패: 서버 오류');
                });
            });
        });
		
	    function updateChart(data) {
	        var ctx = document.getElementById("myAreaChart").getContext('2d');
			
	        var labels = data.map(thing => {
	        	  // month 값에서 앞의 0을 제거
	        	  const monthNumber = parseInt(thing.month, 10);
	        	  return monthNumber + "월";
	        	});
	        
	        var salesData = data.map(thing => {
				return thing.totalSales;
	        });
	        
	        
	        myLineChart = new Chart(ctx, {
	            type: 'line',
	            data: {
	                labels: labels,
	                datasets: [{
	                    label: "총 매출",
	                    lineTension: 0.3,
	                    backgroundColor: "rgba(78, 115, 223, 0.05)",
	                    borderColor: "rgba(78, 115, 223, 1)",
	                    pointRadius: 3,
	                    pointBackgroundColor: "rgba(78, 115, 223, 1)",
	                    pointBorderColor: "rgba(78, 115, 223, 1)",
	                    pointHoverRadius: 3,
	                    pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
	                    pointHoverBorderColor: "rgba(78, 115, 223, 1)",
	                    pointHitRadius: 10,
	                    pointBorderWidth: 2,
	                    data: salesData,
	                }],
	            },
	            options: {
	                maintainAspectRatio: false,
	                layout: {
	                    padding: {
	                        left: 10,
	                        right: 25,
	                        top: 25,
	                        bottom: 0
	                    }
	                },
	                scales: {
	                    xAxes: [{
	                        time: {
	                            unit: 'date'
	                        },
	                        gridLines: {
	                            display: false,
	                            drawBorder: false
	                        },
	                        ticks: {
	                            maxTicksLimit: 7
	                        }
	                    }],
	                    yAxes: [{
	                        ticks: {
	                            maxTicksLimit: 5,
	                            padding: 10,
	                            callback: function(value, index, values) {
	                                return number_format(value) + "원";
	                            }
	                        },
	                        gridLines: {
	                            color: "rgb(234, 236, 244)",
	                            zeroLineColor: "rgb(234, 236, 244)",
	                            drawBorder: false,
	                            borderDash: [2],
	                            zeroLineBorderDash: [2]
	                        }
	                    }],
	                },
	                legend: {
	                    display: false
	                },
	                tooltips: {
	                    backgroundColor: "rgb(255,255,255)",
	                    bodyFontColor: "#858796",
	                    titleMarginBottom: 10,
	                    titleFontColor: '#6e707e',
	                    titleFontSize: 14,
	                    borderColor: '#dddfeb',
	                    borderWidth: 1,
	                    xPadding: 15,
	                    yPadding: 15,
	                    displayColors: false,
	                    intersect: false,
	                    mode: 'index',
	                    caretPadding: 10,
	                    callbacks: {
	                        label: function(tooltipItem, chart) {
	                            var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
	                            return datasetLabel + ': ' + number_format(tooltipItem.yLabel) + "원";
	                        }
	                    }
	                }
	            }
	        });
	    }
	
	    fetchSalesData();
	    

	});
	

</script>
</body>
</html>
