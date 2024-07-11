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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<style>
.custom-confirm-button {
    background-color: #1E90FF !important; /* 예 버튼 색상 */
    color: #fff !important;
}
.custom-cancel-button {
    background-color: #FF4500 !important; /* 아니요 버튼 색상 */
    color: #fff !important;
}
</style>
</head>
<body>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
		<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">클래스문의</h4>
					<div>
						<p>🔸참여클래스 : ${inquiry.class_name}</p>
						<p>🔸작성자 : ${inquiry.member_nickname}</p>
						<p>🔸작성일 : ${inquiry.class_inquiry_date} ${inquiry.class_inquiry_time}</p>
					</div>
					<div class="mb-3">
						<label for="inquiry-subject">제목</label>
						<input type="text" value="${inquiry.class_inquiry_subject}" name="inquiry-subject" id="inquiry-subject" class="form-control" disabled> 
					</div>
					<div class="mb-3">
						<label for=inquiry-content>내용</label>
						<textarea rows="10" name="inquiry-content" id="inquiry-content" class="form-control" cols="50" disabled>${inquiry.class_inquiry_content}
						</textarea> 
					</div>
					<hr class="mb-4">
					
					<div class="mb-4 creator-inquiry-form-btn writeInquiry" align="center">
						<input type="button" value="답글쓰기" onclick="writeReply()" class="btn btn-primary btn-lg btn-block">
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="window.close()">
					</div>
					
					<div class="creator-reply-form">
					
					</div>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; WillClass</p>
		</footer>
	</div>
	
	<script type="text/javascript">
	
		function writeReply() {
			$(".creator-reply-form").append("<div class='mb-3'>"
					+ "<label for='creator-inquiry-replyPro'>후기답글</label>"
					+ "<textarea rows='10' name='inquiryReply' id='creator-inquiry-replyPro' class='form-control' cols='50'></textarea>"
					+ "</div>"
					+ "<hr class='mb-4'>"
					+ "<div class='mb-4 creator-inquiry-form-btn' align='center'>"
					+ "<input type='button' value='등록하기' class='btn btn-primary btn-lg btn-block mx-1' onclick='inquirySubmit()'>"
					+ "<input type='button' value='돌아가기' class='btn btn-primary btn-lg btn-block' onclick='window.close()'>"
					+ "</div>"
			);
			$(".writeInquiry").hide();
		}
		
		function inquirySubmit() {
			var inquiryCode = ${inquiry.class_inquiry_code};
			var inquiryStatus = "${inquiry.class_inquiry_status}";
			var inquiryReply = $("#creator-inquiry-replyPro").val();
			event.preventDefault(); // 폼 제출을 막음
			
		    Swal.fire({
		        title: "답글을 등록하시겠습니까?",
		        icon: "question",
		        showCancelButton: true,
		        confirmButtonColor: "green",
		        cancelButtonColor: "#3085d6",
		        confirmButtonText: "예",
		        cancelButtonText: "아니요",
		        customClass: {
		            popup: 'swal-wide',
		            confirmButton: 'custom-confirm-button',
		            cancelButton: 'custom-cancel-button'
		        }
		    }).then((result) => {
		        if (result.isConfirmed) {
		        	$.ajax({
						url: "insertInquiryReply",
						method: "get",
						data: { "inquiryReply" : inquiryReply,
								"inquiryCode" : inquiryCode,
								"inquiryStatus" : inquiryStatus
						},
						success: function(data) {
							Swal.fire("성공", "답글이 등록 되었습니다.", "success").then(() => {
		                        window.opener.location.reload(); // 부모창 리로드
		                        window.close();
		                    });
						},
		                error: function(e) {
		                    Swal.fire("실패", "답글등록에 실패하였습니다.", "error");
		                },
		                timeout: 100000
					});	
		        }
		    });
				
		}

		function inquiryDelete() {
			var inquiryCode = ${inquiry.class_inquiry_code};
			event.preventDefault(); // 폼 제출을 막음
		    Swal.fire({
		        title: "답글을 등록하시겠습니까?",
		        icon: "question",
		        showCancelButton: true,
		        confirmButtonColor: "green",
		        cancelButtonColor: "#3085d6",
		        confirmButtonText: "예",
		        cancelButtonText: "아니요",
		        customClass: {
		            popup: 'swal-wide',
		            confirmButton: 'custom-confirm-button',
		            cancelButton: 'custom-cancel-button'
		        }
		    }).then((result) => {
		        if (result.isConfirmed) {
		        	$.ajax({
		        		url: "deleteInquiryReply",
						method: "get",
						data: { "inquiryCode" : inquiryCode,
						},
						success: function(data) {
							Swal.fire("성공", "답글이 등록 되었습니다.", "success").then(() => {
		                        window.opener.location.reload(); // 부모창 리로드
		                        window.close();
		                    });
						},
		                error: function(e) {
		                    Swal.fire("실패", "답글등록에 실패하였습니다.", "error");
		                },
		                timeout: 100000
					});	
		        }
		    });				
				
				
		}
		
		$(function() {
			if(${inquiry.class_inquiry_status eq 'Y'}){
				$(".creator-reply-form").append("<div class='mb-3'>"
						+ "<label for='creator-inquiry-replyPro'>후기답글</label>"
						+ "<textarea rows='10' name='creator-inquiry-replyPro' id='creator-inquiry-replyPro' class='form-control' cols='50'></textarea>"
						+ "</div>"
						+ "<hr class='mb-4'>"
						+ "<div class='mb-4 creator-inquiry-form-btn' align='center'>"
						+ "<input type='button' value='답글수정' class='btn btn-primary btn-lg btn-block mx-1' onclick='inquirySubmit()'>"
						+ "<input type='button' value='돌아가기' class='btn btn-primary btn-lg btn-block' onclick='window.close()'>"
						+ "<input type='button' value='답글삭제' class='btn btn-danger btn-lg btn-block mx-1' onclick='inquiryDelete()'>"
						+ "</div>"
				);
				$(".writeInquiry").hide();
				$('#creator-inquiry-replyPro').val('${reply.class_reply_content}');
			}
			debugger;
		});
		
	
	</script>

</body>
</html>