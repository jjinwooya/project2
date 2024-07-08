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
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Something else here</a>
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
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Something else here</a>
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

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Content Column -->
                        <div class="col-lg-6 mb-4">

                            <!-- Project Card Example -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Projects</h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <h4 class="small font-weight-bold">Server Migration <span -->
<!--                                             class="float-right">20%</span></h4> -->
<!--                                     <div class="progress mb-4"> -->
<!--                                         <div class="progress-bar bg-danger" role="progressbar" style="width: 20%" -->
<!--                                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div> -->
<!--                                     </div> -->
<!--                                     <h4 class="small font-weight-bold">Sales Tracking <span -->
<!--                                             class="float-right">40%</span></h4> -->
<!--                                     <div class="progress mb-4"> -->
<!--                                         <div class="progress-bar bg-warning" role="progressbar" style="width: 40%" -->
<!--                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div> -->
<!--                                     </div> -->
<!--                                     <h4 class="small font-weight-bold">Customer Database <span -->
<!--                                             class="float-right">60%</span></h4> -->
<!--                                     <div class="progress mb-4"> -->
<!--                                         <div class="progress-bar" role="progressbar" style="width: 60%" -->
<!--                                             aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div> -->
<!--                                     </div> -->
<!--                                     <h4 class="small font-weight-bold">Payout Details <span -->
<!--                                             class="float-right">80%</span></h4> -->
<!--                                     <div class="progress mb-4"> -->
<!--                                         <div class="progress-bar bg-info" role="progressbar" style="width: 80%" -->
<!--                                             aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div> -->
<!--                                     </div> -->
<!--                                     <h4 class="small font-weight-bold">Account Setup <span -->
<!--                                             class="float-right">Complete!</span></h4> -->
<!--                                     <div class="progress"> -->
<!--                                         <div class="progress-bar bg-success" role="progressbar" style="width: 100%" -->
<!--                                             aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->

                            <!-- Color System -->
<!--                             <div class="row"> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-primary text-white shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Primary -->
<!--                                             <div class="text-white-50 small">#4e73df</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-success text-white shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Success -->
<!--                                             <div class="text-white-50 small">#1cc88a</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-info text-white shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Info -->
<!--                                             <div class="text-white-50 small">#36b9cc</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-warning text-white shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Warning -->
<!--                                             <div class="text-white-50 small">#f6c23e</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-danger text-white shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Danger -->
<!--                                             <div class="text-white-50 small">#e74a3b</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-secondary text-white shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Secondary -->
<!--                                             <div class="text-white-50 small">#858796</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-light text-black shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Light -->
<!--                                             <div class="text-black-50 small">#f8f9fc</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-6 mb-4"> -->
<!--                                     <div class="card bg-dark text-white shadow"> -->
<!--                                         <div class="card-body"> -->
<!--                                             Dark -->
<!--                                             <div class="text-white-50 small">#5a5c69</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->

<!--                         </div> -->

<!--                         <div class="col-lg-6 mb-4"> -->

                            <!-- Illustrations -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Illustrations</h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="text-center"> -->
<!--                                         <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" -->
<%--                                             src="${pageContext.request.contextPath}/resources/img/undraw_posting_photo.svg" alt="..."> --%>
<!--                                     </div> -->
<!--                                     <p>Add some quality, svg illustrations to your project courtesy of <a -->
<!--                                             target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>, a -->
<!--                                         constantly updated collection of beautiful svg images that you can use -->
<!--                                         completely free and without attribution!</p> -->
<!--                                     <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on -->
<!--                                         unDraw &rarr;</a> -->
<!--                                 </div> -->
<!--                             </div> -->

<!--                             Approach -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Development Approach</h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce -->
<!--                                         CSS bloat and poor page performance. Custom CSS classes are used to create -->
<!--                                         custom components and custom utility classes.</p> -->
<!--                                     <p class="mb-0">Before working with this theme, you should become familiar with the -->
<!--                                         Bootstrap framework, especially the utility classes.</p> -->
<!--                                 </div> -->
<!--                             </div> -->

<!--                         </div> -->
<!--                     </div> -->

<!--                 </div> -->
                <!-- /.container-fluid -->

<!--             </div> -->
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

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
	var myLineChart;
	var category_name_data = ${category_name_list};
	var reservation_count_data = ${reservation_count_list};
	
	updatePieChart(reservation_count_data, category_name_data);
    // 카테고리 레이블 동적 생성
    var categoryLabelsContainer = $("#categoryLabels");
    var colors = ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#858796'];
    
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
    
	function updatePieChart(data, lables){
		var ctx = document.getElementById("myPieChart");
		var labels = lables;
		var myPieChart = new Chart(ctx, {
		  type: 'doughnut',
		  data: {
		    labels: lables,
		    datasets: [{
		      data: data,
		      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
		      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
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
	
    function updateChart(data) {
        var ctx = document.getElementById("myAreaChart").getContext('2d');
        var currentMonth = new Date().getMonth(); // 0부터 시작하므로, 0은 1월, 1은 2월 ...
		
        var labels = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
        labels = labels.slice(0, currentMonth + 1);

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
                    data: data,
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
