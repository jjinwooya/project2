<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
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
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_default.css">
    <!-- 이미지 canvas -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    
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


                <!-- Begin Page Content -->
                <div class="container-fluid">
				
                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">대쉬보드</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                오늘 방문자</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${daily_visit }명</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fa-regular fa-user fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                총 방문자</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800 totalVisit">${total_visit }명</div>
                                        </div>
                                        <div class="col-auto">
                                           <i class="fa-solid fa-users fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">오늘 회원가입
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${new_member}명</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                           <i class="fa-regular fa-user fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                총 회원수</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${total_member}명</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fa-solid fa-users fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                            <a class="dropdown-item" id="lineChartDownloadBtn">차트 다운로드</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="myAreaChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pie Chart -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">클래스 그래프</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                            aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">Dropdown Header:</div>
                                            <a class="dropdown-item" id="pieChartDownloadBtn">차트 다운로드</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="myPieChart"></canvas>
                                    </div>
                                    <div class="mt-4 text-center small" id="categoryLabels">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
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
    
    <script src="${pageContext.request.contextPath}/resources/js/demo/pie_chart.js"></script>
    
    <!-- Page level custom scripts -->
    <!-- TODO demo차트버리고 데이터 넣은 차트 채우기! -->
</body>
<script>
$(document).ready(function() {
    var myPieChart;
    var myLineChart;
    var category_name_data = ${category_name_list};
    var reservation_count_data = ${reservation_count_list};
    
    updatePieChart(reservation_count_data, category_name_data);

    // 카테고리 레이블 동적 생성
    var categoryLabelsContainer = $("#categoryLabels");
    var colors = ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#858796'];
    
    document.getElementById('lineChartDownloadBtn').addEventListener('click', function() {
        var link = document.createElement('a');
        link.href = myLineChart.toBase64Image();
        link.download = '매출차트.png';
        link.click();
    });
    
    document.getElementById('pieChartDownloadBtn').addEventListener('click', function() {
        downloadChartWithLabels();
    });
    
    category_name_data.forEach(function(category, index) {
        var colorClass = index < colors.length ? colors[index] : colors[index % colors.length];
        categoryLabelsContainer.append(
            '<span class="mr-2"><i class="fas fa-circle" style="color:' + colorClass + '"></i> ' + category + '</span>'
        );
        if ((index + 1) % 3 === 0) {
            categoryLabelsContainer.append('<br>');
        }
    });
    
    function fetchSalesData() {
        $.ajax({
            url: 'pay-chart',
            method: 'GET',
            success: function(data) {
                updateChart(data);
            },
            error: function(error) {
                console.error('Error fetching sales data:', error);
            }
        });
    }
    
    function updatePieChart(data, labels){
        var ctx = document.getElementById("myPieChart");
        myPieChart = new Chart(ctx, {
          type: 'doughnut',
          data: {
            labels: labels,
            datasets: [{
              data: data,
              backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#858796'],
              hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf', '#f6b23e', '#e94a3b', '#857896'],
              hoverBorderColor: "rgba(234, 236, 244, 1)",
            }],
          },
          options: {
            maintainAspectRatio: false,
            tooltips: {
              backgroundColor: "rgb(255,255,255)",
              bodyFontColor: "#858796",
              borderColor: '#dddfeb',
              borderWidth: 1,
              xPadding: 15,
              yPadding: 15,
              displayColors: false,
              caretPadding: 10,
            },
            legend: {
              display: false
            },
            cutoutPercentage: 80,
          },
        });
    }

    function downloadChartWithLabels() {
        // 차트와 카테고리 레이블을 포함하는 새로운 캔버스 생성
        html2canvas(document.querySelector(".chart-pie")).then(function(chartCanvas) {
            html2canvas(document.getElementById("categoryLabels")).then(function(labelsCanvas) {
                var finalCanvas = document.createElement("canvas");
                var finalContext = finalCanvas.getContext("2d");

                // finalCanvas 크기 설정 (차트와 레이블 높이 합산)
                finalCanvas.width = chartCanvas.width;
                finalCanvas.height = chartCanvas.height + labelsCanvas.height;

                // 차트 그리기
                finalContext.drawImage(chartCanvas, 0, 0);

                // 레이블 그리기
                finalContext.drawImage(labelsCanvas, 0, chartCanvas.height);

                // 다운로드 링크 생성 및 클릭
                var link = document.createElement('a');
                link.href = finalCanvas.toDataURL("image/png");
                link.download = '카테고리_랭킹차트.png';
                link.click();
            });
        });
    }

    function updateChart(data) {
        var ctx = document.getElementById("myAreaChart").getContext('2d');
        
        var labels = data.map(thing => {
            const monthNumber = parseInt(thing.month, 10);
            return monthNumber + "월";
        });
        
        var salesData = data.map(thing => {
            return thing.totalSales;
        });
        
        console.log(labels);
        console.log(salesData);
        
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

</html>
