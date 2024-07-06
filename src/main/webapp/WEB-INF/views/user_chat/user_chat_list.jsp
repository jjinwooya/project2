<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>1:1 채팅 목록</title>

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

<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<style type="text/css">
	
	body {
		background:#F6F6F6;
	}
	
	.user-chat {
		padding: 0;
		margin: 0 auto;
		height: 100vh;
		display: flex; 
		flex-direction: column;
	}

	.chat-List-top {
		font-size: 20px;
		font-weight: bold;
		height: 55px;
		padding: 10px 10px;
		border-bottom: 1px solid #A6A6A6;
		background:  #D5D5D5;
		align-items: center;
	}
	
	.chat-top-filter {
		font-size: 12px;
		border-radius: 20px;
		border: 1px solid gray;
		padding: 5px 10px;;
		margin-left: 10px;
	}
	
	#chat-close {
		font-size: 30px;
		color: gray;
		font-weight: bold;
	}
	
	.chat-list-content{
		overflow-y: auto;
	}
	
	.chat-list {
		border-bottom: 1px solid #A6A6A6;
		margin: 0;
		
	}
	
	.receiver_img_area {
		padding: 0px;
		align-content:center;
		text-align:center;
	}
	
	.receiver_img {
		
		width: 40px;
		height: 40px;
	}
	
	.receiver_name {
		font-weight: bold;
		font-size: 15px;
	}
	
	.chat-list {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	
	.send-time-area {
		padding: 0 10px;
		text-align:right;
		
	}
	.send-time {
		color: gray;
		font-size: 12px;
	}
	
	.last_msg {
		font-size: 14px;
	}
	
</style>



</head>
<body>
	
	<div class="user-chat container-fluid">
		
		<div class="chat-List-top d-flex justify-content-between align-items-center">
			<div class="d-flex align-items-center">
				<span class="px-2">채팅</span>
				<button class="btn btn-outline-dark chat-top-filter">전체</button>
				<button class="btn btn-outline-dark chat-top-filter">안 읽은 메시지</button>
			</div>
<!-- 			<div class="d-flex align-items-center pb-2"> -->
<!-- 				<span id="chat-close">&times;</span> -->
<!-- 			</div>	 -->
		</div>
		
		<div class="chat-list-content">
		
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0">
					<span class="receiver_name d-flex flex-row">길동이</span>
					<span class="last_msg d-flex flex-row">안녕하세요~ 길동이예요.</span>
				</div>
				<div class="send-time-area col-3">
					<span class="send-time">오후 5:05</span>
				</div>
			</div> <!-- chat-list -->
			
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0">
					<span class="receiver_name d-flex flex-row">호야</span>
					<span class="last_msg d-flex flex-row">네네 감사합니다~ </span>
				</div>
				<div class="send-time-area col-3 ">
					<span class="send-time">오후 5:03</span>
				</div>
			</div> <!-- chat-list -->
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0" >
					<span class="receiver_name d-flex flex-row">길동이</span>
					<span class="last_msg d-flex flex-row">안녕하세요~ 길동이예요.</span>
				</div>
				<div class="send-time-area col-3">
					<span class="send-time">오후 5:05</span>
				</div>
			</div> <!-- chat-list -->
			
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0">
					<span class="receiver_name d-flex flex-row">호야</span>
					<span class="last_msg d-flex flex-row">네네 감사합니다~ </span>
				</div>
				<div class="send-time-area col-3 ">
					<span class="send-time">오후 5:03</span>
				</div>
			</div> <!-- chat-list -->
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0">
					<span class="receiver_name d-flex flex-row">길동이</span>
					<span class="last_msg d-flex flex-row">안녕하세요~ 길동이예요.</span>
				</div>
				<div class="send-time-area col-3">
					<span class="send-time">오후 5:05</span>
				</div>
			</div> <!-- chat-list -->
			
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0">
					<span class="receiver_name d-flex flex-row">호야</span>
					<span class="last_msg d-flex flex-row">네네 감사합니다~ </span>
				</div>
				<div class="send-time-area col-3 ">
					<span class="send-time">오후 5:03</span>
				</div>
			</div> <!-- chat-list -->
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0">
					<span class="receiver_name d-flex flex-row">길동이</span>
					<span class="last_msg d-flex flex-row">안녕하세요~ 길동이예요.</span>
				</div>
				<div class="send-time-area col-3">
					<span class="send-time">오후 5:05</span>
				</div>
			</div> <!-- chat-list -->
			
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7 p-0">
					<span class="receiver_name d-flex flex-row">호야</span>
					<span class="last_msg d-flex flex-row">네네 감사합니다~ </span>
				</div>
				<div class="send-time-area col-3 ">
					<span class="send-time">오후 5:03</span>
				</div>
			</div> <!-- chat-list -->
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7">
					<span class="receiver_name d-flex flex-row">길동이</span>
					<span class="last_msg d-flex flex-row">안녕하세요~ 길동이예요.</span>
				</div>
				<div class="send-time-area col-3">
					<span class="send-time">오후 5:05</span>
				</div>
			</div> <!-- chat-list -->
			
			<div class="chat-list row">
				<div class="receiver_img_area col-2">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
				</div>
				<div class="d-flex flex-column col-7">
					<span class="receiver_name d-flex flex-row">호야</span>
					<span class="last_msg d-flex flex-row">네네 감사합니다~ </span>
				</div>
				<div class="send-time-area col-3 ">
					<span class="send-time">오후 5:03</span>
				</div>
			</div> <!-- chat-list -->
			
		</div> <!-- chat-list-content -->
		
		
	
	
	
	
	
	
	
	
	</div> <!-- user-chat -->
	
	



	
    <!-- JavaScript Libraries -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/lightbox/js/lightbox.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
	
	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	
</body>
</html>