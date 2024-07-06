<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 신고하기</title>
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
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style type="text/css">
.checkComplain {
	margin-left : 20px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">클래스 신고</h4>
					<div>
						<p>작성자 : ${member.member_name }</p>
					</div>
					<div class="mb-3">
						<label for="event_title">신고사유</label>
<!-- 						<textarea rows="10" name="event_subject" id="event_title" class="form-control" cols="50"></textarea>  -->
					</div>
					<form action="complain-class-pro" method="post" onsubmit="return confirmSubmit();">
					<input type="hidden" value="${param.class_code}" name="class_code">
					<div class="mb-3 checkComplain">
						<select name="big_category" id="big_category" class="form-control" onchange="loadSubCategories()">
						    <option value="">대 카테고리</option>
						    <c:forEach items="${big_category}" var="cat">
						        <option value="${cat.common2_code}"
						            ${cat.code_value eq collectCat ? 'selected="selected"' : ''}>
						            ${cat.code_value}
						        </option>
						    </c:forEach>
						</select>
					</div>
					<div class="mb-3 checkComplain">
						<select name="small_category" id="small_category" class="form-control">
						    <option value="">소 카테고리</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="movie_story">내용</label> 
						<textarea id="summernote" class="form-control" rows="10" cols="100" required name="content">
						</textarea>
						<div class="invalid-feedback">내용을 입력해주세요.</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4 creator-review-form-btn" align="center">
						<input type="submit" value="신고하기" class="btn btn-primary btn-lg btn-block">
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="window.close()">
					</div>
					</form>
					<form class="validation-form creator-reaply-form" novalidate action="creator-review-replyPro" method="post" onsubmit="reviewSubmit()">
						
					</form>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Class Will</p>
		</footer>
	</div>
	
	<script type="text/javascript">
	
		function loadSubCategories() {
			var categoryCode = $("#big_category").val();
			
			$.ajax({
				url: "getSubCategories",
				type: "GET",
				data: {
					categoryCode: categoryCode 
				},
				dataType: "json",
				success: function(data) {
					if(data == null){
						return;
					}
					var subCategorySelect = $("#small_category");
					subCategorySelect.empty();
					subCategorySelect.append('<option value="">소 카테고리</option>');
					$.each(data, function(index, item) {
						subCategorySelect.append('<option value="' + item.common2_code + '">' + item.code_value + '</option>');
					});
				},
				error: function(xhr, status, error) {
					console.error("Error loading subcategories: ", error);
				}
			});
		}
		
		function reviewSubmit() {
			event.preventDefault(); // 폼 제출을 막음
			if(confirm("후기를 등록하시겠습니까?")){
				window.close();
				return true;
			} else{
				return false;
			}
		}
		
		function confirmSubmit() {
			if(confirm("신고를 등록하시겠습니까?")) {
				return true; // 폼 제출 계속
			} else {
				return false; // 폼 제출 중단
			}
		}
		
	</script>
<script>
$('#summernote').summernote({
    placeholder: '내용을 입력하세요.',
    tabsize: 1,
    height: 400,
    toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'underline', 'clear']],
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['table', ['table']],
        ['insert', ['link', 'picture', 'video']],
        ['view', ['fullscreen', 'codeview', 'help']],
        ['height', ['height']]
    ],
    callbacks: {
        onImageUpload: function(files) {
            for (var i = 0; i < files.length; i++) {
                uploadImage(files[i]);
            }
        }
    }
});

function uploadImage(file) {
    var data = new FormData();
    data.append('file', file);

    $.ajax({
        url: 'admin-uploadImage',
        type: 'POST',
        data: data,
        contentType: false,
        processData: false,
        success: function(response) {
            var jsonResponse = JSON.parse(response);
            var imageUrl = jsonResponse.url;
            console.log(imageUrl);
            $('#summernote').summernote('insertImage', imageUrl, function ($image) {
                $image.attr('src', imageUrl);
                $image.attr('class', 'img-responsive');	
            });
        }
    });
}
</script>
</body>
</html>
