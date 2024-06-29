<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
body, span, h1, h2, h3, h4, h5, h6, p {
	color: white;
}

a {
	text-decoration: none;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<div class="col-lg-3">
	<div class="row g-4">
		<div class="col-lg-12">
			<div class="mb-3">
				<div style="margin-bottom: 10px">
					<c:choose>
						<c:when test="${member.member_img != null}">
							<img
								src="${pageContext.request.contextPath}/resources/upload/${member.member_img}"
								style="width: 150px; height: 150px">
						</c:when>
						<c:otherwise>
							<img
								src="${pageContext.request.contextPath}/resources/img/default.png"
								style="width: 150px; height: 150px">
						</c:otherwise>
					</c:choose>
				</div>
				<input type="button" value="이미지등록" class="btn btn-primary"
					onclick="openUploadModal()">

				<ul class="list-unstyled fruite-categorie">
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="my-page" class="h5"><i class="fas fa-user fa-1x"></i>&nbsp;
								${member.member_name}님 <c:choose>
								<c:when test="${member.member_type eq 1}">일반회원</c:when>
								<c:when test="${member.member_type eq 2}">크리에이터</c:when>
								<c:otherwise>관리자님..</c:otherwise>
							</c:choose></a>
							
						</div>
					</li>
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="my-wish" class="h5"><i
								class="bi bi-emoji-heart-eyes"></i>&nbsp; 관심 클래스</a>
						</div>
					</li>
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="my-credit" class="h5"><i class="bi bi-wallet"></i>&nbsp;
								윌페이</a>
						</div>
					</li>
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="my-class" class="h5"><i class="bi bi-cart-check"></i>&nbsp;
								내가 신청한 클래스</a>
						</div>
					</li>
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="my-review" class="h5"><i class="bi bi-pencil-square"></i>&nbsp;
								나의 클래스 후기</a>
						</div>
					</li>
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="my-powerup" class="h5"><i class="bi bi-sunrise-fill"></i>&nbsp;
								나의 성장</a>
						</div>
					</li>
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="my-modify" class="h5"><i class="bi bi-gear"></i>&nbsp;
								회원정보변경</a>
						</div>
					</li>
					<li>
						<div class="d-flex justify-content-between fruite-name">
							<a href="" class="h5"><i class="bi bi-person-x-fill"></i>&nbsp;
								회원탈퇴</a>

						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog"
	aria-labelledby="uploadModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="uploadModalLabel" style="color: black;">이미지
					업로드</h5>
				<button type="button" class="close" data-dismiss="modal"
					style="color: black;" aria-label="Close"
					onclick="closeUploadModal()">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="uploadForm" enctype="multipart/form-data">
					<div class="form-group">
						<label for="imageFile" style="color: black;">이미지 파일 선택(jpg
							jpeg png파일만 가능합니다.)</label> <input type="file" class="form-control-file"
							id="imageFile" name="imageFile" accept=".jpg, .jpeg, .png"
							style="color: black;">
					</div>

					<div class="form-group">
						<img id="previewImage" src="#" alt="이미지 미리보기"
							style="width: 150px; height: 150px" />
					</div>

					<div class="form-group">
						<button type="submit" class="btn btn-primary">업로드</button>
						<button type="button" class="btn btn-primary"
							onclick="cancelUpload()">취소</button>
						<input type="button" value="이미지삭제" class="btn btn-primary"
							onclick="resetImg()">
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function openUploadModal() {
		$('#uploadModal').modal('show');
	}

	// 모달 닫기 함수
	function closeUploadModal() {
		$('#uploadModal').modal('hide');
	}
	function cancelUpload() {
		$('#imageFile').val(''); // 파일 입력 초기화
		$('#previewImage').hide(); // 미리보기 이미지 숨기기
	}

	function resetImg() {
		$.ajax({
			url : 'delete_image', // 서버측 이미지 삭제 경로
			type : 'POST',
			success : function(response) {
				alert('이미지 삭제 성공!');
				location.reload(); // 부모창 새로고침
			},
			error : function(response) {
				alert('이미지 삭제 실패!');
			}
		});
	}

	$(document).ready(function() {
		$('#imageFile').on('change', function() {
			previewImage();
		});

		// 이미지 업로드 form submit 처리
		$('#uploadForm').on('submit', function(event) {
			event.preventDefault();
			// 파일 입력 요소
			var fileInput = $('#imageFile')[0];
			var file = fileInput.files[0];

			// 파일이 선택되지 않은 경우
			if (!file) {
				alert('이미지 파일을 선택해 주세요.');
				return;
			}

			var formData = new FormData(this);

			$.ajax({
				url : 'upload_image', // 서버측 업로드 경로
				type : 'POST',
				data : formData,
				contentType : false,
				processData : false,
				success : function(response) {
					alert('이미지 업로드 성공!');
					closeUploadModal(); // 성공 시 모달 닫기
					location.reload(); // 부모창 새로고침

				},

				error : function(response) {
					alert('이미지 업로드 실패!');
				}
			});
		});

		// 		// 모달이 닫힐 때 form 리셋
		// 		$('#uploadModal').on('hidden.bs.modal', function(e) {
		// 			$(this).find('form')[0].reset(); // form 초기화
		//			$('#previewImage').hide(); // 미리보기 숨기기
		// 		});

	});
	function previewImage() {
		var fileInput = $('#imageFile')[0];
		var file = fileInput.files[0];

		// 파일이 선택되지 않은 경우
		if (!file) {
			alert('이미지 파일을 선택해 주세요.');
			return;
		}

		// 파일 확장자 검사
		var fileName = file.name;
		var validExtensions = [ 'jpg', 'jpeg', 'png' ];
		var fileExtension = fileName.split('.').pop().toLowerCase();

		if ($.inArray(fileExtension, validExtensions) === -1) {
			alert('jpg, jpeg, png 파일만 업로드 가능합니다.');
			$('#imageFile').val(''); // 파일 입력 초기화
			$('#previewImage').hide(); // 미리보기 이미지 숨기기
			return;
		}

		// FileReader를 이용한 미리보기
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#previewImage').attr('src', e.target.result);
			$('#previewImage').show();
		};
		reader.readAsDataURL(file); // 파일을 Data URL로 읽기
	}
</script>
