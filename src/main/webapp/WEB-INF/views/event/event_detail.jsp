<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스윌 이벤트</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
  

.btn-outline-primary{
	color : white!important;
}
body{
	background-color : black;
	color : white!important;
}
main {
	width: 1400px;
	margin: 0 auto;
	
}

tr td{
 	border: 1px solid lightgray; 
}
.eventTable{
	margin: 0 auto;
	width: 60%;
	text-align: center;
	font-size: 20px;
	margin-top: 40px;
}
tr{
	height: 60px;
}
td > img{
	width: 100%;
}

</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>

	<main>
		<table class="eventTable">
			<tr>
				<td style="background:black; color: white;">이벤트</td>
				<td colspan="3">${event.event_subject}</td>
			</tr>
			<tr>
				<td style="background:black; color: white;">등록날짜</td>
				<td><fmt:formatDate value="${eventRegDate}" pattern="yyyy-MM-dd"/></td>
				<td style="background:black; color: white;">이벤트기간</td>
				<td>
					${eventStartDate} ~ ${eventEndDate}
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<c:if test="${not empty event.event_image}">
						<img alt="본문이미지" src="${pageContext.request.contextPath}/${event.event_image}">
					</c:if>
				</td>
			</tr>
		</table>
		<div class="buttonArea" align="center">
	        <a href="javascript:void(0);" onclick="getPoint('${event.event_point}', '${param.event_code }')" aria-label="포인트 받기">
	            <img alt="포인트받기버튼" src="${pageContext.request.contextPath}/resources/images/event/point_button.png" style="width:300px;height:100px">
	        </a>
		</div>
		<div align="center">
			<button type="submit" class="btn btn-outline-primary" id="searchBtn" onclick="goEventMain()">목록으로</button>
		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		function getPoint(event_point, event_code){
			// 포인트 AJAX 처리 하기
			 $.ajax({
		        url: 'event-point',
		        type: 'POST',
		        data: {
		        	"event_point": event_point,
		        	"event_code" : event_code
		        },
		        success: function(response) {
		            alert(response.message);  // 서버 응답 메시지를 알림으로 표시
		        },
		        error: function(xhr, status, error) {
		            alert(xhr.responseText);  // 오류가 발생한 경우의 처리
		        }
			});
		}
		
		function goEventMain() {
			location.href="event";
		}
		
		
	</script>


</body>
</html>