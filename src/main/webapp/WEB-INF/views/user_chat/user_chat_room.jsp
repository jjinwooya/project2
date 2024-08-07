<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>1:1 채팅방</title>

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
		background: #D5D5D5;
	}
	
	.user-chat {
		padding: 0;
		margin: 0 auto;
		height: 100vh;
		display: flex; 
		flex-direction: column;
	}
	
	.chat-room-top {
		font-size: 18px;
		font-weight: bold;
		height: 55px;
		padding: 10px 10px;
		border-bottom: 1px solid #A6A6A6;
		background: rgb(246, 246, 246);
		align-items: center;
	}
	
	.receiver_name_top{
		font-size: 16px;
	
	}
	
	.chat-top-icon {
		border: none;
		background: none;
	}
	
	#chat-room-content {
		flex: 1;
		padding: 15px;
		overflow-y: auto;
	}
	
	.chatDate {
		font-size: 12px;
		text-align: center;
	}

    .receiver_msg, .my_msg {
        font-size: 14px;
        border-radius: 15px;
        padding: 10px;
        display: inline-block;
        max-width: 60%;
        word-wrap: break-word;
        
    }

    .receiver_msg {
        text-align: left;
        background:  #4C4C4C;
        color: white;
    }

    .my_msg {
        text-align: right;
        background: #FFA7A7;
        align-self: flex-end;
    }

    .send-time {
    	font-size: 10px;
    	margin: 0px 10px;
    	align-self: flex-end;
    }
    
    .chat-room-text {
        height: 100px; 
        background: white;
        display: flex;
    	align-items: flex-end; 
    }
    
    #send-msg-input {
		height: 100%;
	    width: 100%;
	    border: none;
	    outline: none;
	    padding: 10px;
	    font-size: 15px;
    }
    
    .chat-icon-area {
    	height: 50px;
    	padding: 10px;
    	width: 	100%; 
    	
    }
    
    #msg-send-btn {
    	background: #FFA7A7;
    	font-size: 13px;
    }
	
	.receiver_img {
		width: 30px;
		height: 30px;
	}
	
	.msg-area {
		margin: 8px 0px;
	}
	
	.receiver_name {
		font-size: 13px;
		margin: 5px;
	}
	
	.chat-icon-btm {
		font-size: 18px;
	}
	
</style>


</head>
<body>
	
	<div class="user-chat container-fluid">
		<!-- 채팅방 상단 -->
		<div class="chat-room-top d-flex justify-content-between">
			<button class="chat-top-icon" id="to-chat-list"><i class="bi bi-chevron-left"></i></button>
			<span class="receiver_name_top">${receiverInfo.member_nickname}</span>
			<button class="chat-top-icon pe-5"><i class="bi bi-three-dots-vertical"></i></button>
		</div>
		
		<!-- 채팅 내역 -->
		<div class="d-flex flex-column" id="chat-room-content">
			<!-- 날짜 -->
			<div class="d-flex flex-row justify-content-center">
				<span class="chatDate">2024년 7월 4일 목요일</span>
			</div>	
			<!-- 주고 받은 메시지 -->		
			<div class="d-flex flex-row flex-column msg-area">
				<div class="d-flex flex-row mb-1">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
					<span class="receiver_name">${receiverInfo.member_nickname}</span>
				</div>	
				<div class="d-flex flex-row">
					<span class="receiver_msg">안녕하세요~ .</span>
					<span class="send-time">오후 5:03</span>
				</div>
			</div>		
			
			<div class="d-flex flex-row justify-content-end msg-area">
				<span class="send-time">오후 5:04</span>
				<span class="my_msg">안녕하세요. 둘리예요.</span>
			</div>		
			
			<div class="d-flex flex-row justify-content-end msg-area">
				<span class="send-time">오후 5:04</span>
				<span class="my_msg">준비물이 있을까요?</span>
			</div>	
				
			<div class="d-flex flex-row flex-column msg-area">
				<div class="d-flex flex-row mb-1">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
					<span class="receiver_name">길동이</span>
				</div>	
				<div class="d-flex flex-row">
					<span class="receiver_msg">준비해오실 건 없습니다. </span>
					<span class="send-time">오후 5:05</span>
				</div>
			</div>		
			
			<div class="d-flex flex-row flex-column msg-area">
				<div class="d-flex flex-row mb-1">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
					<span class="receiver_name">길동이</span>
				</div>	
				<div class="d-flex flex-row ">
					<span class="receiver_msg">모두 준비해드립니다.</span>
					<span class="send-time">오후 5:05</span>
				</div>
			</div>		
			<div class="d-flex flex-row justify-content-end msg-area">
				<span class="send-time">오후 5:06</span>
				<span class="my_msg">그렇군요. 감사합니다.</span>
			</div>		
			<div class="d-flex flex-row flex-column msg-area">
				<div class="d-flex flex-row mb-1">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
					<span class="receiver_name">길동이</span>
				</div>	
				<div class="d-flex flex-row ">
					<span class="receiver_msg">또 다른 문의사항 있으신가요?</span>
					<span class="send-time">오후 5:06</span>
				</div>
			</div>		
			<div class="d-flex flex-row justify-content-end msg-area">
				<span class="send-time">오후 5:07</span>
				<span class="my_msg">아뇨 없어요</span>
			</div>		
			<div class="d-flex flex-row flex-column msg-area">
				<div class="d-flex flex-row mb-1">
					<img src="${pageContext.request.contextPath}/resources/images/class/pic.png" class="receiver_img">
					<span class="receiver_name">길동이</span>
				</div>	
				<div class="d-flex flex-row ">
					<span class="receiver_msg">네 좋은 하루되세요~</span>
					<span class="send-time">오후 5:09</span>
				</div>
			</div>			
			<div class="d-flex flex-row justify-content-end msg-area">
				<span class="send-time">오후 5:10</span>
				<span class="my_msg">감사합니다~ ☺️</span>
			</div>		
			
		</div>
		
		<!-- 메시지 입력창 -->
		<div class="chat-room-text d-flex flex-column">
			<input type="text" id="send-msg-input" class="d-flex flex-row" placeholder="메시지 보내기" onkeypress="checkEnter(event, this)">
			<div class="chat-icon-area flex-row d-flex justify-content-between">
				<button type="button" class="btn chat-icon-btm p-0" id=""><i class="bi bi-paperclip"></i></button>
				<button type="button" class="btn" id="msg-send-btn"  onclick="send(this)" >전송</button>
			</div>
		</div>
		
	</div>
	
	<script type="text/javascript">
		let receiver_email = "${receiverInfo.member_email}";
		let receiver_code =  "${receiverInfo.member_code}";
		console.log("receiver_email : " + receiver_email);
		console.log("receiver_code : " + receiver_code);
		
		if(receiver_email != "") {
			const startMessage = {
					type: "TYPE_INIT_COMPLETE",
					receiver_email : receiver_email
			};
			window.parent.postMessage(startMessage, '*');
		}
		
		
		function send(target) {
			let inputElement = $("#send-msg-input");
			let inputValue = $("#send-msg-input").val();
			let room_code = "";
			
			const message = {
				    type: 'SEND_MESSAGE',
				    chat_room_code: room_code,
				    sender_code: 'user1',
				    content: inputValue
			};
			window.parent.postMessage(message, '*');
			
			// 입력 메세지가 비어있을 경우 작업 종료
			if(inputValue == "") {
				inputElement.focus();
				return;
			}
			
			// 채팅 입력창 초기화
			inputElement.val("");
			inputElement.focus();
			
		}
		
		function checkEnter(event, target) {
			console.log("checkEnter - event : " + event + ", target : " + target);
			// 누른 키의 코드값 가져오기
			let keyCode = event.keyCode;
			if(keyCode == 13) { // 엔터키 감지하여 send() 함수 호출
				send(target);
			}
		}
	
		
		$(function() {
			// 뒤로 가기 누르면 채팅 목록으로 가기
			$("#to-chat-list").on("click", function() {
				location.href = "user-chat-list";
			});
			
						
			// 부모창(top.jsp)으로부터 전송된 메시지 수신/처리 후 다시 보내기
			$(window).on("message", function(event) {
				const data = event.originalEvent.data;
				console.log("data : " + data);
				
				if (data.type === "NEW_MESSAGE") {
					// 채팅방에 메세지 추가
				    $('#chat-room-content').append(`<p>${data.content}</p>`);
				    
				    const readMessage = {
				        type: "READ_MESSAGE",
				        chat_room_code: '12345',
				        message_code: data.message_code // Use message unique code
				    };
				    
				    window.parent.postMessage(readMessage, '*');
				}
			});
			
			
			
		});
		
		
	</script>



	
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