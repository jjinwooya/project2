<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Multi Datepicker Example</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-class-plan.css"
	rel="stylesheet">
	
<!-- Toast UI Grid Script -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.grid/latest/tui-grid.css">
<!-- Toast UI Pagination CSS -->
<link rel="stylesheet"	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">
<style>
.delete-btn {
	display: none;
	cursor: pointer;
	color: red;
}

tr:hover .delete-btn {
	display: inline;
}

.hidden {
	display: none;
}

th, td {
	text-align: center;
}
</style>
</head>
<body>
<!-- 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
	
	<!-- Toast UI Pagination Script -->
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	<!-- Toast UI Grid Script -->
	<script src="https://uicdn.toast.com/tui.grid/latest/tui-grid.js"></script>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<!-- Spinner Start (로딩시 뜨는 동그라미)-->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-white" role="status"></div>
	</div>
	<!-- Spinner End -->

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">Creator</h1>
		<ol class="breadcrumb justify-content-center mb-0">
			<li class="breadcrumb-item"><a href="main">Home</a></li>
			<li class="breadcrumb-item"><a href="main">크리에이터 페이지</a></li>
			<li class="breadcrumb-item active text-white">클래스 일정관리</li>
		</ol>
	</div>
	<!-- Single Page Header End -->

	<div class="container-fluid fruite">
		<div class="container">
			<h1 class="mb-4 text-white">Creator Center</h1>
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/creator/sideBar.jsp" />

						<div class="col-md-9 creator-body">
							<div class="col-md-12 mb-2" align="center">
								<div class="col-xl-6 mb-5">
									<hr style="color:white;" class="col-xl-8">
									<div>
										<h3 class="text-white">일정등록</h3>
									</div>
									<hr style="color:white;" class="col-xl-8">
								</div>
							</div>
							<form id="dateForm" action="creatorPlanPro" method="POST">
								<jsp:include page="/WEB-INF/views/creator/classSelect.jsp" />
								<!-- 	셀렉트박스 -->
								<div class="creator-main-table col-xl-12 mb-5">

									<div id="scheduleTableContainer" class="col-md-12"></div>

									<div id="datepicker"></div>
									<input type="hidden" name="selectedDates" id="selectedDates">

									<div class="creator-plan-bottom">

										<div class="my-4 d-flex justify-content-center">
											<label for="class_total_headcount" class="h5 my-3"
												style="width: 150px;">참여 가능 인원 : </label> <input
												type="number" name="class_total_headcount"
												id="class_total_headcount" class="form-control my-1" min="1"
												style="width: 100px;" />
										</div>

										<div class="container creator-plan-time mt-3 mb-5">
											<table id="timeTable" class="table">
												<tr>
													<th>회차</th>
													<th>시작시간</th>
													<th>종료시간</th>
												</tr>
												<tr>
													<td>1회차</td>
													<td><input name="1회차_start" type="time"
														class="form-control startTime time"></td>
													<td><input name="1회차_end" type="time"
														class="form-control endTime time"></td>
												</tr>
											</table>
											<div class="d-flex justify-content-center mt-3">
												<button id="addRowBtn" class="form-control plusRound"
													type="button" style="width: 100px;">회차 추가</button>
											</div>
										</div>

										<div align="center" class="mb-3">
											<button type="submit" class="btn btn-outline-primary btn-lg">등록하기</button>
											<button type="button" class="btn btn-outline-primary btn-lg" 
												onclick="location.reload()">다시작성</button>
											<button type="button" class="btn btn-outline-primary btn-lg" 
												onclick="location.href='creator-class'">돌아가기</button>
										</div>
									</div>

								</div>
							</form>
						</div>
						
					</div>

				</div>
			</div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-multidatespicker/1.6.4/jquery-ui.multidatespicker.min.js"></script>
	<!-- JavaScript Libraries -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Template Javascript -->
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script> --%>

	<script>
		$(document).ready(function() {
			$("#classSelect").val("");
			
			// 참여인원 처리
		     $('#class_total_headcount').on('input', function() {
		         if ($(this).val() <= 0) {
		             $(this).val(''); // 값이 0 이하일 경우 비움
		         }
		     });
		
		     $('#class_total_headcount').on('keypress', function(e) {
		         if (e.key === '-' || (e.key === '0' && $(this).val() === '')) {
		             e.preventDefault(); // '-'나 맨 처음에 '0' 입력을 막음
		         }
		     });
		    
		    // 회차 추가 기능
		    let roundCount = 1;
		    $('#addRowBtn').on('click', function() {
		  	 if(roundCount < 5){
		             roundCount++;
		             let newRow = '<tr>'
		                     + '<td>' + roundCount + '회차 <span class="delete-btn">&times;</span></td>'
		                     + '<td><input name="' + roundCount + '회차_start" type="time" class="form-control startTime"></td>'
		                     + '<td><input name="' + roundCount + '회차_end" type="time" class="form-control endTime"></td>'
		                 + '</tr>';
		             $('#timeTable tbody').append(newRow);
		  	} else{
		  		 alert("회차는 5회까지 추가 가능합니다!");
		  	}
		       });

			$('#timeTable').on('mouseenter', 'tr', function() {
			    $(this).find('.delete-btn').show();
			});
			
			$('#timeTable').on('mouseleave', 'tr', function() {
			    $(this).find('.delete-btn').hide();
			});
			
			$('#timeTable').on('click', '.delete-btn', function() {
			    $(this).closest('tr').remove();
			    updateTextAreaNames();
			});
			
			function updateTextAreaNames() {
	            let rows = $('#timeTable tr');
	            roundCount = rows.length - 1; // 첫 번째 tr은 헤더이므로 제외
	            rows.each(function (index) {
	                if (index > 0) { // 첫 번째 tr은 헤더이므로 제외
	                    $(this).find('time').attr('name', index + '회차_start');
	                    $(this).find('td:first').html(index + '회차 <span class="delete-btn">&times;</span>');
	                }
	            });
	        }
			
			const data = null;
			const itemsPerPage = 10;
			let currentPage = 1;

			initializeGrid(data);
			
			class ButtonRenderer {
                constructor(props) {
                    const el = document.createElement('button');
                    el.className = 'btn btn-primary btn-sm';
                    el.innerText = '삭제';
                    el.addEventListener('click', () => {
                    	event.preventDefault();
                        const rowKey = props.grid.getIndexOfRow(props.rowKey);
                        const rowData = props.grid.getRow(rowKey);
                        const class_code = rowData.class_code;
                        const class_schedule_code = rowData.class_schedule_code;
                        console.log("rowKey: " + rowKey);
                        console.log("rowData: " + rowData);
                        console.log("class_code: " + class_code);
                        console.log("class_schedule_code: " + class_schedule_code);
        				if(confirm("일정을 삭제하시겠습니까?")){
        			      $.ajax({
        			          url: "deleteSchedule",
        			          method: "get",
        			          data: { "classScheduleCode": class_schedule_code },
        			          success: function(data) {
        			        	alert(data.answer);
        			        	location.reload();
        			          }
        			      });
        				} else{
        					return;
        				}
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

			function initializeGrid(data) {
				const gridContainer = document
						.getElementById('grid');
				if (gridContainer) {
					new tui.Grid({
						el : gridContainer,
						data : data,
						columns : [ {
								header : '클래스날짜',
								name : 'class_schedule_date',
								width : 'auto',
								align: "center"
							}, {
								header : '회차',
								name : 'class_round',
								align: "center"
							}, {
								header : '시작시간',
								name : 'class_st_time',
								align: "center"
							}, {
								header : '종료시간',
								name : 'class_ed_time',
								align: "center"
							}, {
								header : '참여인원',
								name : 'attend_count',
								align: "center"
							},
							{
		                        header: '삭제',
		                        name: 'action',
		                        renderer: {
		                            type: ButtonRenderer
		                        },
		                        width : 'auto'
		                    }
						],
						rowHeaders : [ 'rowNum' ],
						bodyHeight : 418,
						pageOptions : {
							useClient : true,
							perPage : itemsPerPage
						}
					});
				}
			}
			
			
			$('#classSelect').change(function() {
				// ajax로 기존 선택했던 날짜 가져오기
				var classCode = $('#classSelect').val();
				$.ajax({
					url: "getSelectedDates",
					method: "get",
					data: { "classCode" : classCode },
					success: function(data) {
						// JSON 형태로 파싱
						var scheduleData = JSON.parse(JSON.stringify(data));
						// 날짜 배열 생성
						var selectedDates = [];
						scheduleData.forEach(function(item) {
				        	if (item.class_schedule_date) {
				            	selectedDates.push(item.class_schedule_date);
				            }
				        });
						
						selectedDates = [...new Set(selectedDates)];
						$('#scheduleTableContainer').empty();
						if(selectedDates.length > 0){ // 등록된 일정이 있다면 달력 안보이기
							$('.creator-plan-bottom').addClass('hidden');
							$('#datepicker').addClass('hidden');
							$('#scheduleTableContainer').empty().append('<div id="scheduleTableContainer" class="col-md-12"><div id="grid"></div><div id="pagination"></div></div>'
							 + '<div align="center">'
							 + '<button type="button" class="btn btn-outline-primary btn-lg my-2" onclick="location.href=\'creator-class\'">돌아가기</button>'
							 + '<button type="button" class="btn btn-outline-danger btn-lg mw-2 mx-2 deleteAllBtn">전체삭제</button>'
				 			 + '</div>');
							initializeGrid(data);
							
						} else{ // 일정이 등록된게 없으면 보이기
							$('.creator-plan-bottom').removeClass('hidden');
							$('#datepicker').removeClass('hidden');
							$('#scheduleTableContainer').empty();
						}
						
					}
				});	
			});

			$(document).on('click', '.deleteAllBtn', function() {
			    deleteAllSchedule();
			});
			
			window.deleteAllSchedule = function() {
				var classCode = $('#classSelect').val();
				if(confirm("전체일정을 삭제하시겠습니까?")){
			      $.ajax({
			          url: "deleteAllSchedule",
			          method: "get",
			          data: { "classCode": classCode },
			          success: function(data) {
			        	alert(data.answer);
			        	location.reload();
			        	
			          }
			      });
				} else{
					return;
				}
			}
			
	        // jQuery UI datepicker 한국어 설정
	        $.datepicker.regional['ko'] = {
	            closeText: '닫기',
	            prevText: '이전',
	            nextText: '다음',
	            currentText: '오늘',
	            monthNames: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
	            monthNamesShort: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
	            dayNames: ['일','월','화','수','목','금','토'],
	            dayNamesShort: ['일','월','화','수','목','금','토'],
	            dayNamesMin: ['일','월','화','수','목','금','토'],
	            weekHeader: '주',
	            dateFormat: 'yy-mm-dd',
	            firstDay: 0,
	            isRTL: false,
	            showMonthAfterYear: true,
	            yearSuffix: '년'
	        };
	        $.datepicker.setDefaults($.datepicker.regional['ko']);
	
	        // 이전에 선택된 날짜 목록 (예시)
	        var today = new Date();
            today.setHours(0, 0, 0, 0); // 시간 부분을 0으로 설정
            
            var threeMonthsLater = new Date();
            threeMonthsLater.setMonth(today.getMonth() + 3); // 오늘 날짜로부터 3달 후 설정
            threeMonthsLater.setHours(23, 59, 59, 999); // 해당 날짜의 마지막 시간으로 설정

            $('#datepicker').multiDatesPicker({
                beforeShowDay: function(date) {
                    var dateString = $.datepicker.formatDate('yy-mm-dd', date);
                    if (date <= today || date > threeMonthsLater) {
                        return [false, 'disabled-date'];
                    }
                    return [true, ''];
                },
                onSelect: function(dateText, inst) {
                	
                	// ui-state-highlight
                    selectedDates = $('#datepicker').multiDatesPicker('getDates');
                    var $datepicker = $('#datepicker');
//                     debugger;
                    // 선택된 날짜에 대해 .selected-date 클래스 추가/제거
                    $datepicker.find('.selected-date');
                    selectedDates.forEach(function(date) {
                        var dateObj = $.datepicker.parseDate('yy-mm-dd', date);
                        $datepicker.find('td[data-year="' + dateObj.getFullYear() + '"][data-month="' + dateObj.getMonth() + '"] a').filter(function() {
                            return $(this).text() == dateObj.getDate();
                        }).addClass('selected-date');
                    });

                    var dateIndex = selectedDates.indexOf(dateText);
                    if (dateIndex > -1) {
                    	 var dateObj = $.datepicker.parseDate('yy-mm-dd', dateText);
                         $datepicker.find('td[data-year="' + dateObj.getFullYear() + '"][data-month="' + dateObj.getMonth() + '"] a').filter(function() {
                             return $(this).text() == dateObj.getDate();
                         }).addClass('selected-date');
                    } else {
                        $('#datepicker').multiDatesPicker('removeDates', dateText);
                    }
                }
            });

            // submit 버튼 클릭 시 선택된 날짜를 hidden input에 설정
            $('#dateForm').on('submit', function(e) {
                var selectedDates = $('#datepicker').multiDatesPicker('getDates');
                $('#selectedDates').val(selectedDates.join(','));
                
            	// 유효성 검사
        	        var classValue = $("#classSelect").val();
        	        var time = $("#time").val();
        	        var selectedDates = $("#selectedDates").val();
        	        
        	        // 선택 상자의 값이 비어 있는지 확인
        	        if (classValue === "") {
        	            alert('클래스를 선택해주세요');
        	            return false; // 폼 제출을 막음
        	        }
        	        if (selectedDates == "") {
        	            alert('날짜를 선택해주세요');
        	            return false; // 폼 제출을 막음
        	        }
//         	        if (time == "") {
//         	            alert('시간을 선택해주세요');
//         	            return false; // 폼 제출을 막음
//         	        }
        	
        	        // 다른 유효성 검사나 처리 로직을 추가할 수 있음
        	
        	        return true; // 폼 제출을 허용
        	        location.reload();
//         	        $("#classSelect").trigger("change");
            });
            
        });
    </script>


</body>
</html>