<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/class_list.css">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<!-- Libraries Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<%-- <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet"> --%>

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Required JavaScript files -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!--     <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet"> -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5+5hb7ie2koOHD8y5Lx5ujD6nco4k5RfF7UoE6G7" crossorigin="anonymous">
    
<!-- 현재위치 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- 카카오 지도 api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b60a9d61c7090ce24f1b5bfa7ab26622"></script>

<script type="text/javascript">

// ------ like-class ------ 
document.addEventListener("DOMContentLoaded", function() {
    var heartImges = document.querySelectorAll(".heartImg");
    var originalSrc = "${pageContext.request.contextPath}/resources/images/profile/heart.png"; // 라이크 클래스 추가 안했을 시 
    var changeSrc = "${pageContext.request.contextPath}/resources/images/profile/heart_full.png"; // 라이크 클래스 추가 했을 시 

    heartImges.forEach(function(heartOverlay) {
        heartOverlay.addEventListener("click", function() {
            var img = this;
            var member_code = img.getAttribute("data-member-code");
            var class_code = img.getAttribute("data-class-code");
            var isFullHeart = img.src.includes("heart_full.png");

            var heart_status = !isFullHeart;
			
			// 로그인 해야만 이용 가능
			if(member_code == null || member_code == ""){ 
	            alert("로그인이 필요한 페이지 입니다.");
	            window.location.href = "member-login";
	            return;
			}
			
            if (heart_status) { // heart_status가 true일 때 (like-class 추가 시)
                img.src = changeSrc;
 				alert("관심 클래스에 추가되었습니다.");
            } else { // heart_status가 false일 때 (like-class 삭제 시)
                img.src = originalSrc;
 				alert("관심 클래스에서 삭제되었습니다.");
            }
            
            // AJAX 요청을 통해 서버로 업데이트 요청 전송
            var data = JSON.stringify({
                heart_status: heart_status,
                member_code: member_code,
                class_code: class_code
            });
            
            updateHeartStatus(data);
        });
    });
    
    function updateHeartStatus(data) {
    	
        var xhr = new XMLHttpRequest();
        
        xhr.open("POST", "${pageContext.request.contextPath}/update-heart-status", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    console.log("Heart status updated successfully");
                } else {
                    console.error("Error updating heartStatus");
                }
            }
        };
        
        xhr.send(data);
    }
    
    const urlParams = new URLSearchParams(window.location.search);
    const bigCategory = urlParams.get('class_big_category');
    const smallCategory = urlParams.get('class_small_category');
    const local = urlParams.get('common2_code');
    
    // 대 카테고리 선택
    const bigCategorySelect = document.getElementById('class_big_category');
    if (bigCategory) {
        bigCategorySelect.value = bigCategory;
    }
    
    // 소 카테고리 선택
    const smallCategorySelect = document.getElementById('class_small_category');
    if (smallCategory) {
        bigCategorySelect.value = bigCategory;
        smallCategorySelect.value = smallCategory;
    }
    
    // 지역 선택
    const localSelect = document.getElementById('class_local');
    if (local) {
        localSelect.value = local;
    }
});

</script>

<!-- JavaScript 코드 -->
<script>
// ------ 현재 위치 ------ 
// 현재 위치와 클래스 위치를 표시하는 함수
function showLocations(position) {
    var userLat = position.coords.latitude; // 현재위치 위도
    var userLng = position.coords.longitude; // 현재위치 경도
    
//     alert("현재 위치는 : " + userLat + ", " + userLng);
    
    // 카카오 지도에 현재 위치 표시
    var mapContainer = document.getElementById('collapseMapContainer'); // 지도를 표시할 div
    var mapOption = {
        center: new kakao.maps.LatLng(userLat, userLng), // 지도의 중심좌표
        level: 9
    };
    
    var map = new kakao.maps.Map(mapContainer, mapOption);
    
    // 현재 위치 마커 생성
    var currentMarkerImageSrc = '${pageContext.request.contextPath}/resources/images/class/map.png'; // 현재 위치 마커 이미지 주소
    var currentMarkerSize = new kakao.maps.Size(80, 80); // 현재 위치 마커 이미지 크기
    var currentMarkerImage = new kakao.maps.MarkerImage(currentMarkerImageSrc, currentMarkerSize);
    
    var currentMarkerPosition = new kakao.maps.LatLng(userLat, userLng);
    var currentMarker = new kakao.maps.Marker({
        position: currentMarkerPosition,
        image: currentMarkerImage, // 현재 위치 마커 이미지 설정
        zIndex: 1000 // 현재 위치 마커의 zIndex 설정
    });
    currentMarker.setMap(map);
    
    // 현재 위치 커스텀 오버레이 생성
    var currentPosition = new kakao.maps.LatLng(userLat, userLng);
    var currentContent = '<div style="padding:20px; color:red; font-weight: bold;"></div>'; // 현재 위치 커스텀 오버레이 내용
    var currentCustomOverlay = new kakao.maps.CustomOverlay({
        map: map,
        position: currentPosition,
        content: currentContent,
        xAnchor: 0.5, // 수평 방향에서 중앙에 위치
        yAnchor: 0.4 // 수직 방향에서 아래쪽에 위치
    });
    
    let jsonList = JSON.parse('${jsonList}'); // 서버에서 전달된 jsonList 사용
    console.log("jsonList : " + JSON.stringify(jsonList));
    
    var classLocations = [];
    
    for (var i = 0; i < jsonList.length; i++) {
        var classes = jsonList[i];
        classLocations.push({
            title: classes.class_name,
            latlng: new kakao.maps.LatLng(classes.class_map_x, classes.class_map_y) // 위도와 경도 순서 주의
        });
        console.log("title : " + classes.class_name);
        console.log("latlng : " + classes.class_map_x + ", " + classes.class_map_y);
    }
    
    // 클래스 위치 마커와 커스텀 오버레이 생성
    classLocations.forEach(function(location) {
        var markerImageSrc = '${pageContext.request.contextPath}/resources/images/class/map2.png'; // 클래스 위치 마커 이미지 주소
        var markerSize = new kakao.maps.Size(50, 50); // 클래스 위치 마커 이미지 크기
        var markerImage = new kakao.maps.MarkerImage(markerImageSrc, markerSize);
        
        var markerPosition = location.latlng;
        var marker = new kakao.maps.Marker({
            position: markerPosition,
            image: markerImage // 클래스 위치 마커 이미지 설정
        });
        marker.setMap(map);
        
        
        var content = '<div style="padding:10px; color:blue; font-size : 0.8em; font-weight: bold;">' + location.title + '</div>'; // 클래스 위치 커스텀 오버레이 내용
        var customOverlay = new kakao.maps.CustomOverlay({
            map: map,
            position: markerPosition,
            content: content,
            xAnchor: 0.5, // 수평 방향에서 중앙에 위치
            yAnchor: 0.4 // 수직 방향에서 아래쪽에 위치
        });
        
        // 초기 상태에서 오버레이를 맵에 추가하지 않음
        customOverlay.setMap(null);
        
        // 마커에 마우스 오버 이벤트 추가
        kakao.maps.event.addListener(marker, 'mouseover', function() {
            customOverlay.setMap(map);
        });
        
        // 마커에 마우스 아웃 이벤트 추가
        kakao.maps.event.addListener(marker, 'mouseout', function() {
            customOverlay.setMap(null);
        });
    });
}
// 현재 위치를 가져오는 함수
function getCurrentLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showLocations, showErrorMsg);
    } else {
        alert("Geolocation is not supported by this browser.");
    }
}

// 위치 가져오기 실패 시 에러 메시지 출력 함수
function showErrorMsg(error) {
    alert("위치 정보를 가져오지 못했습니다.");
    console.error(error);
}

</script>
<style>
/*    #map { */
/*        width: 200px; */
/*        height: 600px; */
/*        right : 0px; */
/*        top : 300px; */
/*    } */
   
body {
    position: relative;
/*     padding-top: 50px; /* 내 위치 버튼과 겹치지 않도록 상단 패딩 설정 */ */
}
        
#mapContainer {
	position: absolute;
	top: 370px; /* 내 위치 버튼 아래에 표시될 위치 지정 */
	right: 100px; /* 오른쪽 여백 설정 */
	width: 800px; /* 지도 컨테이너의 너비 설정 */
	height: 400px; /* 지도 컨테이너의 높이 설정 */
/*             border: 1px solid #ccc; */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
<script type="text/javascript">
</script>
<style type="text/css">
body {
	color: white;
	background : black;
}
.hashtag {
	width : 123px;
	height : 45px;
	font-size : 0.9em;
    cursor: pointer;
    border-radius : 30px !important;
}
.classList{
/*         margin-right: 50px; /* 오른쪽 여백을 auto로 설정하여 왼쪽으로 이동 */ */
}
.form-controls {
    border-radius : 30px !important;
}

.mapPop {
/* 	text-align : center; */
	margin: 0 auto; /* 수평 가운데 정렬 */
	display: flex;
	justify-content: center;
	margin-bottom : 20px;
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp" />
</header>

<div class="container1">
   <div class="col-md-12">
	<!-- 카테고리 바 -->   
		<div class="row">
			<div class="categoryBar">
				<div class="row justify-content-center"> <!-- 가운데 정렬 -->
					<div class="categoryBarBox col-md-12">
						<!-- 셀렉트박스 리스트 -->
						<div class="row rowCenter">
						<!-- 카테고리바 카테고리 시작 -->
							<div class="col-md-3">
								<label for="class_big_category" class="h6">카테고리</label> 
								<select name="class_big_category" id="class_big_category" class="form-control"  onchange="updateCategory()">
										<option value="bigCategoryAll" id="class_big_category_all">전체</option>
									<c:forEach var="bigCategoryList" items="${bigCategoryList}">
										<option value="${bigCategoryList.common2_code}">${bigCategoryList.code_value}</option>
									</c:forEach>
								</select>
							</div>
							
							<div class="col-md-3">
								<label for="class_small_category" class="h6">상세분류</label> 
								<select name="class_small_category" id="class_small_category" class="form-control"  onchange="updateSmallCategory()">
									<option value="smallCategoryAll" id="class_small_category_all">전체</option>
								</select>
							</div>
						<!-- 카테고리바 카테고리 끝 -->
						
						<!-- 카테고리바 지역 시작 -->
							<div class="col-md-3">
								<label for="class_local" class="h6">지역</label> 
								<select name="class_local" id="class_local" class="form-control" onchange="updateLocal()">
									<option value="classLocalAll" id="class_local_all">전체</option>
									<c:forEach var="localList" items="${localList}">
										<option value="${localList.common2_code}">${localList.code_value}</option>
									</c:forEach>
								</select>
							</div>
	<!-- 					카테고리바 지역 끝 -->
							
							<!-- 셀렉트 검색 버튼 -->
							<div class="btnSearchDiv col mt-4">
								<div class="w-100 btnDiv">
									<button type="button" class="btn btn-outline-light btnSearch">검색</button>
								</div>
							</div>
							<!-- 셀렉트 검색 버튼 -->
							
							<!-- 셀렉트 초기화 버튼 -->
							<div class="btnResetDiv col mt-4">
								<div class="w-100 btnDiv">
									<button type="button" class="btn btn-outline-light btnReset" onclick="resetCategory()">초기화</button>
								</div>
							</div>
							<!-- 셀렉트 초기화 버튼 -->
						</div>
						<!-- 셀렉트박스 리스트 끝 -->
						
						<!-- 해시태그 리스트 -->
						<div class="row">
							<hr>
							<div class="col hashtagDiv">
								<div class="form form1 d-flex flex-wrap">
									<c:forEach var="hashtag" items="${hashtagList}">
	<!-- 									<button type="button" class="item" data-value="#${hashtag.hash_tag_name}">#${hashtag.hash_tag_name}</button> -->
										<input type="text" class="form-control form-inputs hashtag" data-value="#${hashtag.hash_tag_name}" value="#${hashtag.hash_tag_name}" readonly>
									</c:forEach>
								</div>
							</div>
						</div>
						<!-- 해시태그 리스트 -->
					</div>
				</div>
			</div>
		</div>
		<!-- 카테고리 바 -->
	
		<!-- 클래스 개수 시작 -->
		<c:set var="classCount" value="${fn:length(classList)}" />
		<div class="row">
			<div class="col-6">
				<div class="classCount">
					<h5>${classCount}개의 클래스</h5>
				</div>
			</div>
			<div class="col-6 box11">
				<div class="col-6">
					<p>
						<a class="btn btn-outline-light btnLocation mt-3 mr-0" data-bs-toggle="collapse"  onclick="getCurrentLocation()" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
							내 위치 주변 클래스 찾기
						</a>
					</p>
				</div>
				<div class="col-6 classList mr-0 mt-3">
					<select id="classListSelect" class="form-select selectBox1 w-100" aria-label="Default select example">
						<option value="lowPrice" selected>낮은 가격순</option>
						<option value="highPrice">높은 가격순</option>
						<option value="starList">별점순</option>
						<option value="reviewList">후기순</option>
					</select>
				</div>
			</div>
		</div> <!-- row -->
		<!-- 클래스 개수 끝 -->
	
		<!-- 지도 보이는 영역 -->
		<div class="collapse" id="collapseExample">
			<div class="card card-body col-md-10 mapPop">
		        <div id="collapseMapContainer" style="width:100%;height:400px;"></div> <!-- 이 div에 지도를 표시 -->
			</div>
		</div>
		<!-- 지도 보이는 영역 -->
	
		<!-- 첫번째 줄 -->
		<div class="row pb-4 mb-4 d-flex flex-wrap" id="classListContainer">
			<c:forEach var="classList" items="${classList}">
				<div class="col-lg-3 col-md-6 mb-4 mb-lg-0 d-flex classCard">
					<div class="card shadow-sm border-0 rounded flex-fill mb-4">
						<div class="card-body p-0 position-relative card-body1 position-relative1">
							<a href="class-detail?class_code=${classList.class_code}">
							<img src="${pageContext.request.contextPath}/resources/images/products/s4.jpg"  class="w-100 card-img-top classPic"></a>
	<%-- 						<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png"  id="heartOverlay" class="heart-overlay" data-class-code="${classList.class_code}" data-member-code="${classList.member_code}"> --%>
							<!-- 라이크 클래스 하트 이미지 변경-->
							<c:choose>
								<c:when test="${not empty likeClassCode}"> <!-- likeClassList 존재 -->
									<c:set var="isLiked" value="false"/> <!-- 삭제 -->
									<c:forEach var="likeClassCode" items="${likeClassCode}">
										<c:if test="${likeClassCode.class_code == classList.class_code}">
											<c:set var="isLiked" value="true"/> <!-- 추가 -->
										</c:if>
									</c:forEach>
									<c:if test="${isLiked}">
									<img src="${pageContext.request.contextPath}/resources/images/profile/heart_full.png" id="heartOverlay" class="heartImg" data-class-code="${classList.class_code}" data-member-code="${classList.member_code}">
									</c:if>
									<c:if test="${not isLiked}">
									<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heartImg" data-class-code="${classList.class_code}" data-member-code="${classList.member_code}">
									</c:if>
								</c:when>
								<c:otherwise> <!-- likeClassList 존재 X -->
									<img src="${pageContext.request.contextPath}/resources/images/profile/heart.png" id="heartOverlay" class="heartImg" data-class-code="${classList.class_code}" data-member-code="${classList.member_code}">
								</c:otherwise>
							</c:choose>
							<!-- 라이크 클래스 하트 이미지 변경 -->
							
							<div class="card-bodys d-flex flex-column">
								<div class="classCategory col-md-10">
									<button type="button" class="btn btn-outline-secondary btn-sm category btn1">${classList.class_big_category}</button>
									<button type="button" class="btn btn-outline-secondary btn-sm category btn1">${classList.class_small_category}</button>
								</div>
								<div class="createrName d-flex align-items-center">
									<img src="${pageContext.request.contextPath}/resources/images/class/pic.png">
									<p class="mb-0 ml-2">${classList.member_nickname}</p>
								</div>
								<div class="className">
								   <a href="class-detail?class_code=${classList.class_code}"><h6>${classList.class_name}</h6></a>
								</div>
								<div class="row classInfo">
									<div class="col-md-6 add">
										<a href="" class="btn btn-outline-dark btn-sm disabled btn1">${classList.local_name}</a>
									</div>
									<div class="col-md-6 price">
										<p><fmt:formatNumber value="${classList.class_price}" pattern="#,###" />원</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
   </div> <!-- col-md-12 -->
</div> <!-- container -->

<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
	
	
<!-- Required JavaScript files -->
<script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
<script type="text/javascript">

// 대카테고리에 따른 소카테고리 값
$(function() {
	
	// 대 카테고리 선택시 소 카테고리 리스트 나타남
	$("#class_big_category").change(function() {
		var big_category = $("#class_big_category").val();

		// AJAX 요청을 통해 소 카테고리 리스트를 업데이트
		$.ajax({
			url: "small-category",
			method: "get",
			data: { 
			    big_category: big_category
			},
			success: function(data) {
			    $("#class_small_category").empty();

				// 전체 옵션 추가
				$("#class_small_category").append(
				    $('<option></option>').val('smallCategoryAll').text('전체')
				);

				// 소 카테고리 옵션 추가
				$.each(data, function(index, item) {
				    $("#class_small_category").append(
						$('<option></option>').val(item.common3_code).text(item.code_value)
					);
				});
				
				// 대 카테고리가 "전체"일 경우 소 카테고리도 "전체"
				if (big_category === 'bigCategoryAll') {
			    	$("#class_small_category").val('smallCategoryAll');
				}
                
				// 파라미터로 전달받은 값이 있으면 선택 (소 카테고리)
				var urlParams = new URLSearchParams(window.location.search);
				var small_category = urlParams.get('class_small_category');

				if (small_category) {
			    	$("#class_small_category").val(small_category);
				}
            },
				error: function(xhr, status, error) {
				console.error('AJAX Error: ', error);
			}
		});
	});

	// 페이지 로드 시, 파라미터로 전달받은 값에 따라 선택
	$(document).ready(function() {
		var urlParams = new URLSearchParams(window.location.search);
		var bigCategory = urlParams.get('class_big_category');
		var smallCategory = urlParams.get('class_small_category');
		var big_category = $("#class_big_category").val();

		if (smallCategory) {
	    	$("#class_small_category").val(smallCategory);
		}

		if (bigCategory) {
	    	$("#class_big_category").val(bigCategory).change(); 
		} 
        
//         if (bigCategory) {
//             $("#class_big_category").val(bigCategory);

//             // bigCategory를 먼저 설정한 후 change 이벤트 강제 발생
//             $("#class_big_category").change();
//         }
        
//         // bigCategory가 "bigCategoryAll"인 경우 소 카테고리도 "전체"로 설정
//         if (bigCategory === 'bigCategoryAll') {
//             $("#class_small_category").val('smallCategoryAll');
//         } else if (smallCategory) {
//             $("#class_small_category").val(smallCategory);
//         }

	});
});

// ------------------------------------------------------------------------------------

var contextPath = '<%= request.getContextPath() %>';

$(function() {
	
	// -------------- 검색 버튼 클릭 시 -------------- 
	$(".btnSearch").on("click", function() {
	    var big_category = $("#class_big_category").val();
	    var small_category = $("#class_small_category").val();
	    var local = $("#class_local").val();

	    // big_category "전체"인 경우
	    if (big_category === "bigCategoryAll") {
			big_category = [];
			$("#class_big_category option").each(function() {
				if ($(this).val() !== "bigCategoryAll") {
					big_category.push($(this).val());
				}
			});
		}
	    
		// small_category "전체"인 경우
		if (small_category === "smallCategoryAll") {
			small_category = [];
			$("#class_small_category option").each(function() {
				if ($(this).val() !== "smallCategoryAll") {
					small_category.push($(this).val());
				}
			});
		}
	    
		// local "전체"인 경우
		if (local === "classLocalAll") {
			local = [];
			$("#class_local option").each(function() {
				if ($(this).val() !== "classLocalAll") {
					local.push($(this).val());
				}
			});
		}
	    
		// Ajax 요청을 통해 필터링된 클래스 목록을 가져옴
		fetchClassList({
			big_category: big_category,
			small_category: small_category,
			local: local,
		});
	});	// btnSearch 끝
    
	// -------------- 해시태그 클릭 시 -------------- 
    $(".hashtag").on("click", function() {
		var hashtag = $(this).val(); 
		fetchClassList({
			hashtag: hashtag 
		});
	}); // hashtag 해시태그 끝
    
	// -------------- 클래스 정렬 셀렉트 박스 -------------- 
	$("#classListSelect").on("change", function() {
    	
		var selectedOption = $(this).val();
        
		var url;
		if (selectedOption === "lowPrice") {
			url = "class-low-price";
		} else if (selectedOption === "highPrice") {
			url = "class-high-price";
		} else if (selectedOption === "starList") {
			url = "class-star-list";
		} else if (selectedOption === "reviewList") {
			url = "class-review-list";
		}
        
		// AJAX 요청 데이터 설정
		var data = {
			classListSelect: selectedOption
		};
        
		$.ajax({
			type: "GET",
			url: url,
			dataType: "json",
			data: data,
			contentType: "application/json",
			success: function(filter) {
				console.log("ajax 성공");
				updateClassList(filter);
			},
			error: function(xhr, status, error) {
				console.error("Error details:", xhr, status, error);
                alert("오류 발생: " + error);
			}
		});
	}); // classListSelect() 끝
});

//------------------------------------------------------------------------------------
// 초기화 버튼 (셀렉트 컨테이너 값 초기화)
function resetCategory() {
	
	// 카테고리 선택 초기화
	document.getElementById('class_big_category').value = 'bigCategoryAll';
	document.getElementById('class_small_category').value = 'smallCategoryAll';
	document.getElementById('class_local').value = 'classLocalAll';

	fetchClassList({
		hash_tag: "" // 필터링 파라미터 초기화
	});
    
	// 콜랩스 닫기
	var collapseElement = document.getElementById('collapseExample');
	var collapse = new bootstrap.Collapse(collapseElement, {
		toggle: false
	});
	collapse.hide();
    
	// classListSelect 선택 초기화
	document.getElementById('classListSelect').value = 'lowPrice';
    
} // resetCategory 끝

//------------------------------------------------------------------------------------
//AJAX 요청 함수
function fetchClassList(data) {
	$.ajax({
		type: "GET",
		url: "filter-class",
		dataType: "json",
		data: data,
		contentType: "application/json",
		success: function(filter) {
			updateClassList(filter);
		},
		error: function(xhr, status, error) {
			console.error("Error details:", xhr, status, error);
			alert("오류 발생: " + error);
		}
	});
}

//------------------------------------------------------------------------------------
// 클래스 목록 갯수 업데이트 함수
function updateClassList(filterClass) {
		$(".classCount").html('<h5>' + filterClass.length + '개의 클래스</h5>');
		
		$("#classListContainer").html("");
		
		for (let filter of filterClass) {
			$("#classListContainer").append(generateClassCardHTML(filter));
		}
	 
	    if (filterClass.length == 0) {
	        $("#classListContainer").html('<h5 style="text-align: center; margin-top : 50px;">조건과 일치하는 클래스가 존재하지 않습니다.</h5>');
	    }
	    
		console.log("ajax 성공ㅇㅇㅇㅇㅇㅇ");
}

//------------------------------------------------------------------------------------
function updateParameterClass(bigCategory, smallCategory) {
	$.ajax({
		url: "update-class-list",
		method: "get",
		data: { 
			bigCategory: bigCategory,
			smallCategory: smallCategory
		},
        success: function(data) {
			var classListContainer = $(".classListContainer");
			classListContainer.empty(); // 기존 클래스 목록을 비웁니다.

            if (data.length > 0) {
				// 클래스 목록을 생성하여 추가합니다.
				$.each(data, function(index, item) {
					var classCard = generateClassCardHTML(item);
					classListContainer.append(classCard);
				});

				classListContainer.show(); // 클래스 목록을 보여줍니다.
			} else {
				classListContainer.hide(); // 데이터가 없으면 목록을 숨깁니다.
			}
		},
		error: function(xhr, status, error) {
			console.error('AJAX Error: ', error);
		}
	});
}
//------------------------------------------------------------------------------------
//클래스 카드 HTML 생성 함수

function generateClassCardHTML(filter) {
	
	return '<div class="col-lg-3 col-md-6 mb-4 mb-lg-0 d-flex classCard">' 
	+ '<div class="card shadow-sm border-0 rounded flex-fill mb-4">' 
	+ '<div class="card-body p-0 position-relative card-body1 position-relative1">'
	+ '<a href="class-detail?class_code=' + filter.class_code + '">'
	+ '<img src="' + contextPath + '/resources/images/products/s4.jpg" class="w-100 card-img-top classPic">' 
	+ '</a>' 
	+ '<img src="' + contextPath + '/resources/images/profile/heart.png" id="heartOverlay" class="heartImg" data-class-code="'
	+ filter.class_code + '" data-member-code="' + filter.member_code + '">' 
	+ '<div class="card-bodys d-flex flex-column">'
	+ '<div class="classCategory col-md-10">'
	+ '<button type="button" class="btn btn-outline-secondary btn-sm category btn1">' + filter.class_big_category + '</button>' 
	+ '<button type="button" class="btn btn-outline-secondary btn-sm category btn1">' + filter.class_small_category + '</button>' 
	+ '</div>' 
	+ '<div class="createrName d-flex align-items-center">' 
	+ '<img src="' + contextPath + '/resources/images/class/pic.png">' 
	+ '<p class="mb-0 ml-2">' + filter.member_nickname + '</p>' 
	+ '</div>' 
	+'<div class="className">'
	+ '<a href="class-detail"><h6>' + filter.class_name + '</h6></a>' 
	+ '</div>'
	+ '<div class="row classInfo">' 
	+ '<div class="col-md-6 add">' 
	+ '<a href="" class="btn btn-outline-dark btn-sm disabled btn1">' + filter.local_name + '</a>' 
	+ '</div>' 
	+ '<div class="col-md-6 price">' 
	+ '<p>' + filter.class_price + '원</p>' 
	+ '</div>' 
	+ '</div>' 
	+ '</div>' 
	+ '</div>' 
	+ '</div>' 
	+ '</div>';
}

</script>
</body>
</html>
