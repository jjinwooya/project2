<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스윌 이벤트</title>
<!-- 부트스트랩 CSS, JS -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css"> --%>
<%-- <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script> --%>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<%-- <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet"> --%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

body {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
  background-color : black;
}

main {
	width: 1400px;
	margin: 0 auto;
}

.event_title {
	text-align: left;
	margin: 30px 0px;
	border-bottom: 1px solid lightgray;
}
.event_title > h1{
	margin-bottom: 15px;
}

body {
	box-sizing: border-box;
	padding: 0;
}

 .event_flow { 
 	display: flex; 
 	flex-flow: row wrap; 
 	align-content: flex-start; 
 } 
 
.margin_use {
	margin-top: 100px;
}

/* item에 hidden 처리하기.*/
.item {
	width: 360px;
	aspect-ratio: 10/6;
	position: relative;
 	overflow: hidden; 
	border-radius: 10px;
	margin: 10px 30px;
}

.item:after {
	/* block & content */
	display: block;
	content: "";
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.2);
	position: absolute;
	top: 0;
	left: 0;
	z-index: 2;
	opacity: 0;
}

.imgBox {
	width: 100%;
	height: 100%;
	position: absolute;
}

.imgBox img {
	width: 100%;
	height: 100%;
	/* 사진이나 비디오의 규격 맞출 때 object-fit 이용하기. */
	object-fit: cover;
	z-index: 1;
}

.textBox {
	position: absolute;
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	align-items: flex-start;
	padding: 20px;
	z-index: 3;
}

.textBox p {
	color: white;
	margin: 5px 0 0;
}

.textBox_name {
	font-size: 16px;
	font-weight: 500;
	opacity: 0;
	transform: translateY(50px);
}

.textBox_price {
	font-size: 16px;
	font-weight: 400;
	opacity: 0;
	transform: translateY(50px);
}

/* 마우스 올렸을 때에 기능 추가하기. */
.item:hover:after {
	opacity: 1;
}

/* 기능 1 : 화면 살짝 불투명 + 화면 커지기. */
.item:hover .imgBox img {
	transform: scale(1.1);
	/* 블러 처리하기. */
	filter: blur(3px);
}

/* 기능 2 : 상품 정보 보이면서 위로 올라가기. */
.item:hover .textBox .textBox_name {
	opacity: 1;
	transform: translateY(0px);
}

/* 기능 2 : 상품 정보 보이면서 위로 올라가기. */
.item:hover .textBox .textBox_price {
	opacity: 1;
	transform: translateY(0px);
}

/* 자연스럽게 트랜지션 적용하기. */
.item:after, .item .imgBox img, .item .textBox_name, .item .textBox_price
	{
	transition: all 0.4s ease-in-out;
}
.category-bar {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px;
}

.category-btn {
  background-color: #ddd;
  border: none;
  color: #333;
  padding: 10px 20px;
  margin: 0 5px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.category-btn.active,
.category-btn:hover,
.category-btn.active:hover {
  background-color: #007bff;
  color: #fff;
}

</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
</header>
<div class="container">
	<div class="row margin_use mx-4">
		<h1 class="display-6 text-white">이벤트</h1>
	</div>
	<div class="row event_flow">
			<div class="item movie-event" onclick="event_detail(0)">
				<div class="imgBox">
					<img src="${pageContext.request.contextPath}/resources/images/event/invite_friend_cut.png" alt="썸네일"/>
				</div>
				<div class="textBox">
					<p class="textBox_name">클래스윌 친구초대 이벤트!</p>
					<p class="textBox_price">2024-07-01  ~  무기한</p>
				</div>
			</div>
		<c:forEach var="eventList" items="${list}" >
			<div class="item movie-event" onclick="event_detail(${eventList.event_code})">
				<div class="imgBox">
					<img src="${pageContext.request.contextPath}/${eventList.event_thumbnail}" alt="썸네일"/>
				</div>
				<div class="textBox">
					<p class="textBox_name">${eventList.event_subject}</p>
					<p class="textBox_price">${eventList.event_start_date}  ~  ${eventList.event_end_date}</p>
				</div>
			</div>
		</c:forEach>
	</div>
	
</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
</footer>
<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript">
// 	function event_detail(event_num) {
// 		location.href='eventDetail?event_num=' + event_num;
// 	} 
	function event_detail(event_code) {
		location.href='eventDetail?event_code=' + event_code;
	} 
	
	$(function() {
		$('.category-btn').click(function() {
			$('.category-btn').removeClass('active');
			$(this).addClass('active');
		});
		$('.category-btn').hover(
			function() {
		    	$(this).addClass('hover');
		    },
		    function() {
		    	$(this).removeClass('hover');
		    }
		);
		
// 		$('.EventType').click(function() {
// 			$.ajax({
// 				type: "get",
// 				url: "eventType",
// // 					dataType: "JSON",
// 				data : {
// 					eventType : $('button.active').val()
// 				},
// 				success: function(data) {
// 					console.log(data)
// 					$(".eventMain").empty();
// 					var eventHtml = '<div class="container eventMain">';
// 	                data.forEach(function(eventList) {
// 	                    eventHtml += '<div class="item movie-event" onclick="event_detail(' + eventList.event_num + ')">' +
// 	                                    '<div class="imgBox">' +
// 	                                        '<img src="resources/upload/' + eventList.event_thumbnail + '" alt="썸네일"/>' +
// 	                                    '</div>' +
// 	                                    '<div class="textBox">' +
// 	                                        '<p class="textBox_name">' + eventList.event_subject + '</p>' +
// 	                                        '<p class="textBox_price">' + eventList.event_start + ' ~ ' + eventList.event_end + '</p>' +
// 	                                    '</div>' +
// 	                                '</div>';
// 	                });
// 	                eventHtml += '</div>';
// 	                $(".eventMain").append(eventHtml);
					
					
// 				},
// 				error: function() {
// 					alert("이벤트 오류!");
// 				}
// 			});
// 		});
		
	});
</script>

</body>
</html>