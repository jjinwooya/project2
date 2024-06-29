<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js" ></script>
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-review-form.css" rel="stylesheet">
</head>
<body>
		<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">클래스문의</h4>
					<div>
						<p>작성자 : 김철철</p>
					</div>
					<div class="mb-3">
						<label for="inquiry-subject">문의제목</label>
						<input type="text" class="form-control" id="inquiry-content" readonly>
					</div>
					<div class="mb-3">
						<label for="inquiry-content">문의내용</label>
						<textarea rows="10" name="inquiry-content" id="inquiry-content" class="form-control" cols="50" readonly></textarea> 
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4 creator-review-form-btn" align="center">
						<input type="button" value="답글쓰기" onclick="writeReply()" class="btn btn-primary btn-lg btn-block">
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="window.close()">
					</div>
					
					<form class="validation-form creator-reaply-form" novalidate action="creator-review-replyPro" method="post" onsubmit="reviewSubmit()">
					
					</form>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; WillClass</p>
		</footer>
	</div>
	
	<script type="text/javascript">
		function writeReply() {
			$(".creator-reaply-form").append("<div class='mb-3'>"
					+ "<label for='creator-review-replyPro'>답글작성</label>"
					+ "<textarea rows='10' name='creator-review-replyPro' id='creator-review-replyPro' class='form-control' cols='50'></textarea>"
					+ "</div>"
					+ "<hr class='mb-4'>"
					+ "<div class='mb-4 creator-review-form-btn' align='center'>"
					+ "<input type='submit' value='등록하기' class='btn btn-primary btn-lg btn-block'>"
					+ "</div>"
			);
		}
		function reviewSubmit() {
			event.preventDefault(); // 폼 제출을 막음
			if(confirm("답변을 등록하시겠습니까?")){
				debugger;
				window.close();
			}
		}
	
	
	</script>

</body>
</html>