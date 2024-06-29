<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록폼</title>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath}/resources/css/admin_form.css" rel="stylesheet" type="text/css">

<style>
	/* Summernote 라인 높이 조정 */
	.note-editable {
	    line-height: 0.5; /* 원하는 라인 높이로 설정 */
	}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">
					<c:choose>
					    <c:when test="${param.type eq 'notice'}">
					        공지사항
					    </c:when>
					    <c:when test="${param.type eq 'faq'}">
					        FAQ
					    </c:when>
					</c:choose>
					<c:choose>
					    <c:when test="${registType eq 'modify'}">
					        수정
					    </c:when>
					    <c:otherwise>
					        등록
					    </c:otherwise>
					</c:choose>
				폼</h4>
				<form class="validation-form" novalidate action="<c:out value='admin-csc-pro'/>" method="post">
				<input type="hidden" name="type" value="<c:out value='${param.type}'/>">
				<input type="hidden" name="registType" value="<c:out value='${registType}'/>">
				<input type="hidden" name="code" value="<c:choose>
				    <c:when test='${param.type eq "notice"}'>
				        <c:out value='${notice.notice_code}'/>
				    </c:when>
				    <c:when test='${param.type eq "faq"}'>
				        <c:out value='${faq.faq_code}'/>
				    </c:when>
				</c:choose>">
					<div class="mb-3">
						<label for="movie_name">글제목</label> 
						<c:choose>
						    <c:when test="${not empty notice}">
						        <input type="text" id="notice_name" class="form-control" required name="subject" 
						               placeholder="글제목을 입력하세요" value="${notice.notice_subject}" />
						    </c:when>
						    <c:when test="${not empty faq}">
						        <input type="text" id="notice_name" class="form-control" required name="subject" 
						               placeholder="글제목을 입력하세요" value="${faq.faq_subject}" />
						    </c:when>
						    <c:otherwise>
						    	<input type="text" id="notice_name" class="form-control" required name="subject" 
						               placeholder="글제목을 입력하세요"/>
						    </c:otherwise>
					    </c:choose>
						<div class="invalid-feedback">글제목을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<select name="category" id="notice_category" class="form-control">
						    <option value="">카테고리</option>
						    <c:forEach items="${category}" var="cat">
						        <option value="${cat.common2_code}"
						            ${cat.code_value eq collectCat ? 'selected="selected"' : ''}>
						            ${cat.code_value}
						        </option>
						    </c:forEach>
						</select>
					</div>
					<div class="mb-3">
						<label for="movie_story">내용</label> 
						<textarea id="summernote" class="form-control" rows="10" cols="100" required name="content">
							<c:choose>
						    <c:when test="${not empty notice}">
						    	${notice.notice_content}
						    </c:when>
						    <c:when test="${not empty faq}">
						    	${faq.faq_content}
						    </c:when>
					    </c:choose>
						</textarea>
						<div class="invalid-feedback">내용을 입력해주세요.</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
						<input type="submit" value="등록하기" class="btn btn-primary btn-lg btn-block" >
						<input type="reset" value="다시작성" class="btn btn-primary btn-lg btn-block" >
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="history.back()">
					</div>
				</form>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Class Will</p>
		</footer>
	</div>
<script>
	window.addEventListener('load', () => {
		console.log("${registType}");
		const forms = document.getElementsByClassName('validation-form');
	
		Array.prototype.filter.call(forms, (form) => {
			form.addEventListener('submit', function (event) {
				if (form.checkValidity() === false) {
					event.preventDefault();
					event.stopPropagation();
				}
				
				
		// 카테고리 선택 여부 확인
		const categorySelect = document.getElementById('notice_category');
		if (categorySelect.value === "카테고리") {
		    event.preventDefault();
		    event.stopPropagation();
		    alert("카테고리를 선택해주세요.");
		}		
				
			form.classList.add('was-validated');
			}, false);
		});
	}, false);
</script>
<script>
$('#summernote').summernote({
    placeholder: '공지를 입력하세요.',
    tabsize: 1,
    height: 800,
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
<script>
	function copyDisabledSelectValue() {
		var disabledSelect = document.getElementById("theater_name_select");
		var hiddenInput = document.getElementById("hidden-disabled-select");
		hiddenInput.value = disabledSelect.value;
	}
</script>

</body>
</html>