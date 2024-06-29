<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/class_detail.css">
<!-- Libraries Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Required JavaScript files -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script> --%>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- 데이트픽커 - JS, CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js "></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<style>
    .flatpickr-calendar {
        font-size: 24px; /* 기본 글꼴 크기 조정 */
    }
    .flatpickr-calendar .flatpickr-months {
        height: 110px; /* 월 선택 영역 크기 조정 */
    }
    .flatpickr-calendar .flatpickr-days {
        grid-template-rows: repeat(6, 2em); /* 날짜 영역 크기 조정 */
    }
    .flatpickr-months .flatpickr-month {
        height: 55px;
    }
    .minusBtn {
        background: none;
        border: none;
        background-image: url("${pageContext.request.contextPath}/resources/img/headcount_minus.png");
        background-size: cover;
        width: 25px;
        height: 25px;
    }

    .addBtn {
        background: none;
        border: none;
        background-image: url("${pageContext.request.contextPath}/resources/img/headcount_plus.png");
        background-size: cover;
        width: 26px;
        height: 26px;
    }
    .disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }
    .btn-custom {
        color: white;
    }
    .btn-check:checked + .btn-custom {
        border: 2px solid white; /* 원하는 테두리 색상 */
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 선택 시 테두리 효과 */
        color: white;
    }
    .selected_time {
        color: white;
    }
    .headcount {
        color: white;
    }
</style>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    var heartOverlays = document.querySelectorAll(".heart-overlay");
    var originalSrc = "${pageContext.request.contextPath}/resources/images/profile/heart.png";
    var changeSrc = "${pageContext.request.contextPath}/resources/images/profile/heart_full.png";

    heartOverlays.forEach(function(heartOverlay) {
        heartOverlay.addEventListener("click", function() {
            var img = this;
            img.classList.add("fade");

            setTimeout(function() {
                if (img.src.includes("heart_full.png")) {
                    img.src = originalSrc;
                } else {
                    img.src = changeSrc;
                }
                img.classList.remove("fade");
            }, 300); 
        });
    });
});
</script>
</head>
<body>
<header>
    <jsp:include page="../inc/top.jsp" />
</header>
<div class="container1">
    <!-- 캐러셀 시작 -->
    <div class="row col-md-12">
        <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
            </div>
            <div class="carousel-inner" role="listbox">
                <div class="carousel-item active rounded">
                    <img src="${pageContext.request.contextPath}/resources/img/fruite-item-1.jpg" class="img-fluid bg-secondary rounded" alt="First slide">
                </div>
                <div class="carousel-item rounded">
                    <img src="${pageContext.request.contextPath}/resources/img/fruite-item-2.jpg" class="img-fluid rounded" alt="Second slide">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <!-- 캐러셀 끝 -->
    </div> <!-- row -->

    <!-- navbar -->
    <nav class="sticky-nav sticky-nav1 col-md-9">
        <div class="row">
            <div class="col box2">
                <ul class="nav-container nav-container1">
                    <li class="nav-item nav-item1">
                        <a class="navbar-item navbar-item1" href="#section1">프로그램 상세</a>
                    </li>
                </ul>
            </div>
            <div class="col box2">
                <ul class="nav-container nav-container1">
                    <li class="nav-item nav-item1">
                        <a class="navbar-item navbar-item1" href="#section2">후기</a>
                    </li>
                </ul>
            </div>
            <div class="col box2">
                <ul class="nav-container nav-container1">
                    <li class="nav-item nav-item1">
                        <a class="navbar-item navbar-item1" href="#section3">커리큘럼</a>
                    </li>
                </ul>
            </div>
            <div class="col box2">
                <ul class="nav-container nav-container1">
                    <li class="nav-item nav-item1">
                        <a class="navbar-item navbar-item1" href="#section4">Q&A</a>
                    </li>
                </ul>
            </div>
            <div class="col box2">
                <ul class="nav-container nav-container1">
                    <li class="nav-item nav-item1">
                        <a class="navbar-item navbar-item1" href="#section5">1:1 채팅하기</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- navbar -->

    <div class="row">
        <!-- navbar content -->
        <div class="content1 col-md-9">
            <div id="section1">
                <img src="${pageContext.request.contextPath}/resources/images/class/class1.png" class="classImg">
            </div>
            <div id="section2">
                <div class="row reviewInfo my-2">
                    <!-- 테이블 -->
                    <div class="card text-center">
                        <div class="card-body p-2">
                            <%-- <c:forEach var="map" items="${map }"> --%>
                            <table>
                                <thead>
                                    <tr>
                                        <th>후기</th>
                                        <th>작성일자</th>
                                        <th>작성자</th>
                                        <th>별점</th>
                                    </tr>
                                </thead>
							     <tbody>
							        <c:choose>
							            <c:when test="${empty classReview}">
							                <tr>
							                    <td colspan="4">
							                        <h6 style="color: black;">리뷰가 존재하지 않습니다</h6>
							                    </td>
							                </tr>
							            </c:when>
							            <c:otherwise>
							                <c:forEach var="map" items="${classReview}">
							                    <c:if test="${map.class_review_subject != null}">
							                        <tr>
							                            <td class="creator-review-subject">
<!-- 							                                <a onclick="creatorReview()"> -->
<%-- 							                                    ${map.class_review_subject} --%>
<!-- 							                                </a> -->
                                                    		<a href="#" onclick="creatorReview(event, '${param.class_code}')">${map.class_review_subject}</a>
							                            </td>
							                            <td>
<!-- 							                                <a onclick="creatorReview()"> -->
<%-- 							                                    ${map.class_review_date} --%>
<!-- 							                                </a> -->
                                                    		<a href="#" onclick="creatorReview(event, '${param.class_code}')">${map.class_review_date}</a>
							                            </td>
							                            <td>
<!-- 							                                <a onclick="creatorReview()"> -->
<%-- 							                                    ${map.member_nickname} --%>
<!-- 							                                </a> -->
                                                    		<a href="#" onclick="creatorReview(event, '${param.class_code}')">${map.member_nickname}</a>
							                            </td>
							                            <td>
							                                <div class="reviewStar reviewStar1 col" onclick="creatorReview(event, '${param.class_code}')" style="text-align : left">
							                                    <ul class="list-inline small">
							                                        <c:forEach begin="1" end="${map.class_review_rating}">
							                                            <li class="list-inline-item m-0"><i class="fa fa-star starStyle"></i></li>
							                                        </c:forEach>
							                                        <c:forEach begin="${map.class_review_rating + 1}" end="5">
							                                            <li class="list-inline-item m-0"><i class="fa fa-star-o starStyle"></i></li>
							                                        </c:forEach>
							                                    </ul>
							                                </div> <!-- reviewStar -->
							                            </td>
							                        </tr>
							                    </c:if>
							                </c:forEach>
							            </c:otherwise>
							        </c:choose>
							    </tbody>
                            </table>
                            <%-- </c:forEach> --%>
                        </div>
                    </div>
                </div>
            </div>
            <!-- section2 -->
            <div id="section3">
                <img src="${pageContext.request.contextPath}/resources/images/class/class_curri.png" class="classImg">
            </div>
            <div id="section4">
                <!-- Q&A 내용 -->
                <!-- 테이블 -->
                <div class="card text-center my-2">
                    <div class="card-body p-2 reviewInfo">
                        <table>
                            <thead>
                                <tr>
                                    <th>제목</th>
                                    <th>작성일자</th>
                                    <th>작성자</th>
                                </tr>
                            </thead>
                            <tbody>
<!-- <<<<<<< HEAD -->
								<c:choose>
						            <c:when test="${empty classInquiry}">
						                <tr>
						                    <td colspan="4">
						                        <h6 style="color: black;">Q&A가 존재하지 않습니다</h6>
						                    </td>
						                </tr>
						            </c:when>
						            <c:otherwise>
										<c:forEach var="map" items="${classInquiry}">
			                                <tr>
			                                    <td class="creator-review-subject">
<%-- 			                                        <a onclick="creatorInquiry()">${map.class_inquiry_subject}</a> --%>
                                                    <a href="#" onclick="creatorInquiry(event, '${param.class_code}')">${map.class_inquiry_subject}</a>
			                                    </td>
			                                    <td>
<%-- 			                                        <a onclick="creatorInquiry()">${map.class_inquiry_date}</a> --%>
                                                    <a href="#" onclick="creatorInquiry(event, '${param.class_code}')">${map.class_inquiry_date}</a>
			                                    </td>
			                                    <td>
<%-- 			                                        <a onclick="creatorInquiry()">${map.member_nickname}</a> --%>
<%-- 		                                            <a href="#" onclick="creatorInquiry(event)" data-class-code="${map.class_code}">${map.member_nickname}</a> --%>
                                                    <a href="#" onclick="creatorInquiry(event, '${param.class_code}')">${map.member_nickname}</a>
                                                    
		                                            
			                                    </td>
			                                </tr>
		                                </c:forEach>
                                	</c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- section4 -->
            <div id="section5">
                <p>1:1 채팅하기</p>
            </div>
        </div> 
        <!-- content -->
        <!-- 우측 강의 소개 -->
        <div class="col-md-3">
            <form action="payment" method="post" id="class_form">
                <input type="hidden" name="class_code" value="${classInfo.class_code }">
                <input type="hidden" name="class_big_category" value="${classInfo.class_big_category }">
                <input type="hidden" name="class_small_category" value="${classInfo.class_small_category }">
                <div class="box1">
                    <h6>${classInfo.class_name }</h6>
                    <h3>${classInfo.class_ex }</h3>
                    <div class="row">
                        <div id="datePicker"></div>
                        <!-- 선택된 날짜를 저장할 input -->
                        <input type="hidden" id="selected_dates" name="selected_dates">
                    </div>
                    <!-- 타임 픽커 선택div -->
                    <div class="row ">
                        <p class="fw-bold fs-4 text-center text-white">시간 선택</p>
                        <!-- ajax 호출 시 출력될 area -->
                        <div class="time_area" align="center">
                            <!-- <div class="btn-group-vertical" role="group" aria-label="Vertical radio toggle button group"> -->
                            <%-- <c:forEach var="time" items="${class_schedule }" varStatus="status"> --%>
                            <%-- <input type="radio" class="btn-check" name="class_schedule_time" id="vbtn-radio${status.count }" autocomplete="off"> --%>
                            <%-- <label class="btn btn-custom" for="vbtn-radio${status.count }"> --%>
                            <%-- <span class="selected_time">${time.class_st_time }~${time.class_ed_time }</span><br> --%>
                            <%-- 현재 남은 자리: <span class="headcount">${time.class_remain_headcount}</span>자리 --%>
                            <!-- </label> -->
                            <%-- </c:forEach> --%>
                            <!-- </div> -->
                        </div>
                        <input type="hidden" id="select_time" name="select_time">
                    </div>
                    <!-- 인원 수 체크 -->
                    <div class="class_headcount">
                        <div class="col d-flex justify-content-end mt-3">
                            <p class="fw-bold text-white">인원 수 선택</p>
                        </div>
                        <div class="col d-flex justify-content-end mt-1">
                            <input class="reserve1 minusBtn" type="button" id="headcount_prev">
                            <input class="reserve1 countText" type="text" name="selected_headcount" id="class_count" value="1" readonly style="text-align: right;">
                            <input class="reserve1 addBtn" type="button" id="headcount_next">
                        </div>
                    </div>

                    <div class="row"> <!-- 해시태그 시작 -->
                        <div class="col-md-4">
                            <b><a href="#">#원데이</a></b>
                        </div>
                        <div class="col-md-4">
                            <b><a href="#">#클래스</a></b>
                        </div>
                        <div class="col-md-4">
                            <b><a href="#">#관련</a></b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <b><a href="#">#키워드</a></b>
                        </div>
                        <div class="col-md-4">
                            <b><a href="#">#크리에이터가</a></b>
                        </div>
                        <div class="col-md-4">
                            <b><a href="#">#지정가능</a></b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <b><a href="#">#키워드</a></b>
                        </div>
                        <div class="col-md-4">
                            <b><a href="#">#크리에이터가</a></b>
                        </div>
                        <div class="col-md-4">
                            <b><a href="#">#지정가능</a></b>
                        </div>
                    </div> <!-- 해시태그 끝 -->

                    <div class="box3"> <!-- 좋아요, 공유버튼 -->
                        <div class="row"> 
                            <div class="col-md-6 btn mx-auto" style="display: flex; align-items: center;">
                                <button type="button" class="btn btn-light w-100 btn-customs">
                                    <%-- <img src="${pageContext.request.contextPath}/resources/images/class/heart1.png" class="button-icon">5214 --%>
                                    <div style="display: flex; align-items: center;">
                                        <img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="button-icon heart-overlay">
                                        <div class="heartCount"><span>5124</span></div>
                                    </div>
                                </button>
                            </div>
<!--                             <div class="col-md-4 btn mx-auto" style="display: flex; align-items: center;"> -->
<!--                                 <button type="button" class="btn btn-light w-100 btn-customs"> -->
<!--                                     <div style="display: flex; align-items: center;"> -->
<%--                                         <img src="${pageContext.request.contextPath}/resources/images/class/share1.png" class="button-icon"> --%>
<!--                                         <div class="shareClass"><span>공유하기</span></div> -->
<!--                                     </div> -->
<!--                                 </button> -->
<!--                             </div> -->
                            <div class="col-md-6 btn mx-auto" style="display: flex; align-items: center;">
                                <button type="button" class="btn btn-light w-100 btn-customs">
                                    <div style="display: flex; align-items: center;" onclick="classComplain(event, '${param.class_code}')">
                                        <img src="${pageContext.request.contextPath}/resources/img/warning.png" class="button-icon">
                                        <div class="shareClass"><span>신고하기</span></div>
                                    </div>
                                </button>
                            </div>
                        </div> <!-- row -->
                    </div> 
                    <!-- 좋아요, 공유버튼 -->
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-light w-100">신청하기</button>
                    </div>
                </div>
            </form>
            <!-- 폼 끝 -->
        </div> 
        <!-- 오른쪽 강의 소개  -->
    </div>
</div>
<!-- container1 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    let classScheduleArray = ${class_schedule_date};
    // console.log("받은 날짜: " + classScheduleArray);
    let class_code = "${classInfo.class_code}"
    let headcount = "";
    let enableDates = [];

    enableDates = classScheduleArray.map(item => item.class_schedule_date);

    //기본 flatpickr 설정
    let flatpickrOptions = {
        dateFormat: "Y-m-d",
        inline: true,
        locale: "ko" // 한글 설정
    };
    debugger;
    var today = new Date();
    today.setHours(0, 0, 0, 0);

    //오늘 날짜 들어있으면 filter
    enableDates = enableDates.filter(dateStr => {
        let date = new Date(dateStr);
        date.setHours(0, 0, 0, 0);
        return date.getTime() > today.getTime();
    });

    // 원데이 클래스 타입인 경우의 옵션
    flatpickrOptions.mode = "single"; // 단일 선택 모드
    flatpickrOptions.enable = enableDates; // 선택 가능한 날짜 설정
    flatpickrOptions.disable = [
        function(date) {
            // 오늘 날짜 포함 이전 날짜 비활성화
            return date < today;
        }
    ]; // 선택 가능한 날짜 설정

    flatpickrOptions.onChange = function(selectedDates, dateStr, instance) {
        console.log(dateStr);
        $.ajax({
            url: 'date-changed',
            type: 'GET',
            data: {
                date: dateStr,
                class_code: "${classInfo.class_code}"
            },
            dataType: "json",
            success: function(response) {
                let scheduleTime = response;
                $(".time_area").empty();
                $.each(scheduleTime, function(index, time) {
                    //현재 남아있는 자리 (class_remain_headcount)
                    let remain = time.class_remain_headcount.toString();
                    if(remain == '0') {
                        return false;
                    }

                    let countT = index + 1;

                    let radioInput = $('<input>', {
                        type: 'radio',
                        class: 'btn-check',
                        name: 'class_schedule_time',
                        id: 'vbtn-radio' + countT,
                        autocomplete: 'off'
                    });

                    var label = $('<label>', {
                        class: 'btn btn-custom',
                        for: 'vbtn-radio' + countT
                    });

                    var timeSpan = $('<span>', {
                        class: 'selected_time',
                        text: time.class_st_time + '~' + time.class_ed_time
                    });

                    var headcountSpan = $('<span>', {
                        class: 'headcount',
                        text: remain
                    });

                    label.append(timeSpan);
                    label.append('<br>현재 남은 자리: ');
                    label.append(headcountSpan);
                    label.append('자리');

                    $(".time_area").append(radioInput);
                    $(".time_area").append(label);

                });
                // 라디오 버튼의 change 이벤트 설정
                $('input[name="class_schedule_time"]').change(function() {
                    //인원수 초기화
                    count.val(1);
                    // 체크된 라디오 버튼의 라벨을 찾습니다.
                    var label = $(this).next('label');
                    // 라벨 안의 .headcount 요소의 값을 가져옵니다.
                    headcount = label.find('.headcount').text();
                    var selectedTime = label.find('.selected_time').text();
                    $('#select_time').val(selectedTime);
                    updateCount();
                });
            }, //success 끝
            error: function() {
                alert("호출 실패");
            }
        });
        // selectedDate = selectedDates.map(date => date.toISOString().slice(0, 10));
        // parsedDate = new Date(selectedDate + 1);
        // console.log("선택된 날짜:" + selectedDate);
        // let dateString = dateStr.toString;
        document.getElementById('selected_dates').value = dateStr;
    };

    // 인원수 변경 버튼 변수 설정
    let count = $("#class_count");
    let prev = $("#headcount_prev");
    let next = $("#headcount_next");

    function updateCount() {
        let currentValue = parseInt(count.val());
        if(currentValue <= 1) {
            prev.prop('disabled', true);
            prev.addClass("disabled");
        } else {
            prev.prop('disabled', false);
            prev.removeClass("disabled")
        }
    }

    // 초기 검사
    updateCount();

    // 증가 후 검사
    next.click(function() {
        let currentValue = parseInt(count.val());
        if(currentValue < headcount) {
            count.val(currentValue + 1);
        }
        updateCount();
    });
    // 감소 후 검사
    prev.click(function() {
        let currentValue = parseInt(count.val());
        if(currentValue > 1) {
            count.val(currentValue - 1);
        }
        updateCount();
    });
    // flatpickr를 초기화합니다.
    flatpickr("#datePicker", flatpickrOptions);

    // 유효성 검사
    $("#class_form").submit(function(event) {
        if (!$("#selected_dates").val() || !$("input[name='class_schedule_time']:checked").val()) {
            alert("날짜와 시간을 선택하세요.");
            event.preventDefault();
            return false;
        }

        if ($("#class_count").val() <= 0) {
            alert("인원 수를 선택하세요.");
            event.preventDefault();
            return false;
        }

        return true;
    });

});
</script>
<script type="text/javascript">
function creatorReview(event, class_code) {
    event.preventDefault(); // 기본 동작 방지 (예: href="#" 의 경우)
    window.open("creator-review-form2?class_code=" + class_code, "pop", "width=700, height=800, left=700, top=50");
}

function creatorInquiry(event, class_code) {
    event.preventDefault(); // 기본 동작 방지 (예: href="#" 의 경우)
    window.open("creator-inquiry-form2?class_code=" + class_code, "pop", "width=700, height=800, left=700, top=50");
}

function classComplain(event, class_code) {
    event.preventDefault(); // 기본 동작 방지 (예: href="#" 의 경우)
	window.open("class-complain?class_code=" + class_code, "pop", "width=700, height=600, left=700, top=50");	
}
</script>
<!-- Required JavaScript files -->
<script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>

<footer>
    <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
</body>
</html>