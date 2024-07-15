<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Insert title here</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-main.css" rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/creator/creator-classReg.css" rel="stylesheet">

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script> -->
    <style>
        .delete-btn {
            display: none;
            cursor: pointer;
            color: red;
            
        }
        tr:hover .delete-btn {
            display: inline;
        }
        .addCurri{
        	cursor: pointer;
        }
        .note-editor.note-frame .note-editing-area .note-editable {
            background-color: black; /* 배경색을 검정색으로 설정 */
            color: white;            /* 글씨색을 흰색으로 설정 */
        }
    </style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<!-- Spinner Start (로딩시 뜨는 동그라미)-->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-white" role="status"></div>
	</div>
	<!-- Spinner End -->


	<div class="container-fluid fruite">
		<div class="container">
			<h1 class="mt-4 text-white">Creator Center</h1>
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<jsp:include page="/WEB-INF/views/creator/sideBar.jsp" />

						<div class="col-lg-9 creator-body" >
							<div class="creator-intro col-md-12">
								<div class="text-white h2">클래스등록</div>
								<hr class="text-white mb-5">
							</div>
							<div class="creator-main-table col-xl-8 mb-5 ">
								<form class="validation-form classReg" novalidate action="creator-classRegPro" name="fr" method="post" enctype="multipart/form-data" onsubmit="return confirm('클래스를 등록하시겠습니까?');">
									<div class="classReg-basic">
										<div class="h4">클래스 기본정보</div>
										<div class="h6 d-flex justify-content-start mt-4">
											<p>작성상태 :</p>
											<p>&nbsp;작성중</p>
										</div>
										<div class="classReg-basic-form">
											<div class="col-md-6 mt-2 mb-4">
												<label for="class_show" class="h6">공개여부</label> 
												<select name="class_hide" id="class_hide" class="form-control" required>
													<option value="">선택해주세요</option>
													<option value="1">공개</option>
													<option value="2">비공개</option>
												</select>
												<div class="invalid-feedback">공개여부를 선택해주세요.</div>
											</div>
											<div class="col-md-12 mt-2 my-4">
												<label for="class_name" class="h6">클래스 제목</label> 
												<input type="text" name="class_name" id="class_name" class="form-control" required />
												<div class="invalid-feedback">클래스명을 입력해주세요.</div>
											</div>
											<div class="row"> 
												<div class="col-md-6 my-4">
													<label for="class_big_category" class="h6">카테고리</label> 
													<select name="class_big_category" id="class_big_category" class="form-control" required>
														<option value="">선택해주세요</option>
														<c:forEach var="category" items="${categoryList}">
															<option value="${category.common2_code}">${category.code_value}</option>
														</c:forEach>
													</select>
													<div class="invalid-feedback">카테고리를 선택해주세요</div>
												</div>
												<div class="col-md-6 my-4">
													<label for="class_small_category" class="h6">상세분류</label> 
													<select name="class_small_category" id="class_small_category" class="form-control" required>
													</select>
													<div class="invalid-feedback">상세분류를 선택해주세요.</div>
												</div>
											</div>
											
											<div class="my-4">
												<label for="class_hashtag" class="h6">해쉬태그 선택</label>
												<div id="item-list" class="d-flex form-control">
													<c:forEach var="hashtag" items="${hashtagList}">
														<button type="button" class="item" data-value="#${hashtag.hash_tag_name}">#${hashtag.hash_tag_name}</button>
													</c:forEach>
											    </div>
											    <input type="hidden" id="selected-items" name="class_hashtag" value="" >
											    <div class="invalid-feedback">해쉬태그를 선택해주세요.</div> 
											</div>
											<div class="col-md-12 my-4">
												<label for="class_thumnail" class="h6">커버이미지</label> 
												<input type="file" name="class_thumnail" id="class_thumnail" class="form-control" required />
												<div class="invalid-feedback">커버이미지 선택해주세요.</div>
											</div>
											<div class="col-md-12 my-4">
												<label for="class_image" class="h6">본문이미지</label> 
												<input type="file" name="file1" class="form-control class_image mb-1" required />
												<input type="file" name="file2" class="form-control class_image"  />
												<input type="file" name="file3" class="form-control class_image mt-1" />
												<div class="invalid-feedback">본문이미지 선택해주세요.</div>
											</div>
											<div class="my-4">
												<label for="summernote" class="h6">클래스 소개</label> 
												<textarea name="class_ex" id="summernote" maxlength="3000" cols="30" rows="5" placeholder="내용을 입력해주세요" class="with-border form-control" required></textarea>
												<div class="invalid-feedback">클래스 소개를 입력해주세요.</div>
											</div>
											<div class="col-md-12 my-4">
												<label for="postCode" class="h6">주소</label><br>
												<input type="hidden" id="sido" name="sido" readonly>
												<div class="d-flex justify-content-between">
													<div class="col-md-3">
											    		<input type="text" id="post_code" name="post_code" class="form-control my-1" size="6" readonly onclick="search_address()" placeholder="우편번호">
													</div>
													<div class="col-md-9">
														<input type="text" id="address1" name="address1" class="form-control my-1" placeholder="클릭 시 주소검색" size="25" readonly onclick="search_address()">
													</div>
												</div>
												<input type="text" id="address2" name="address2" class="form-control" placeholder="상세주소" size="25" pattern="^.{2,20}$" maxlength="20" required>
												
												<!-- 주소지의 x y 좌표 -->
												<div class="d-flex justify-content-between">
													<div class="col-md-6">
											    		<input type="text" id="location_x" name="location_x" placeholder="X좌표" class="form-control my-1" readonly>
													</div>
													<div class="col-md-6">
														<input type="text" id="location_y" name="location_y" placeholder="Y좌표" class="form-control my-1" readonly>
													</div>
												</div>
												<div class="invalid-feedback">주소를 입력해주세요.</div>
											</div>
											<div class="col-md-12 my-4">
												<label for="class_price" class="h6">회당 클래스가격(원)</label> 
												<input type="text" name="class_price" id="class_price" class="form-control my-1" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" required />
												<div class="invalid-feedback">클래스 가격을 입력해주세요.</div>
											</div>
										</div>
									</div>
									
									<div class="classReg-calc my-3">
										<div class="d-flex justify-content-between">
											<div class="h4">클래스 커리큘럼</div>
											<div class="h6 addCurri">+ 추가하기</div>
										</div>
										<table id="timeTable" class="table">
							        		<tr>
							        			<th>회차</th>
							        			<th>커리큘럼내용</th>
							        		</tr>
							        		<tr>
							        			<td>1차시</td>
							        			<td>
							        				<textarea name="1차시" maxlength="1000" rows="5" placeholder="내용을 입력해주세요" class="form-control curri_content" required></textarea>
							        			</td>
							        		</tr>
							        	</table>
									</div>
						        	<div class="invalid-feedback">커리큘럼을 입력해주세요.</div>
									
									<div class="classReg-creator-info my-3">
										<div class="d-flex justify-content-between">
											<div class="h4">크리에이터 정보</div>
										</div>
										<div class="classReg-creator-info-form">
											<div class="col-md-12 mt-2 mb-5">
												<label for="class_creator_explain" class="h6">크리에이터 소개</label>
												<textarea name="class_creator_explain" class="class_creator_explain with-border" maxlength="3000" cols="30" rows="5" placeholder="내용을 입력해주세요" required></textarea> 
<!-- 												<input type="text" name="class_creator_explain" class="class_creator_explain" class="form-control" required /> -->
												<div class="invalid-feedback">크리에이터 소개를 입력해주세요.</div>
											</div>
											<div class="mt-5 mb-3" align="center">
												<button type="submit" value="1" name="class_regist_status" class="btn btn-outline-primary btn-lg">제출하기</button>
												<button type="submit" value="3" name="class_regist_status" class="btn btn-outline-primary btn-lg" >저장하기</button>
												<input type="button" value="돌아가기" class="btn btn-outline-primary btn-lg" onclick="history.back()">
												<hr class="mb-4">
											</div>
										</div>
									</div>
									
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

	<!-- Template Javascript -->
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script> --%>
	
	<script type="text/javascript">	
		window.addEventListener('load', () => {
		      const forms = document.getElementsByClassName('validation-form');
		
		      Array.prototype.filter.call(forms, (form) => {
		        form.addEventListener('submit', function (event) {
		          if (form.checkValidity() === false) {
		            event.preventDefault();
		            event.stopPropagation();
		            window.scrollTo({ top: 0, behavior: 'smooth' });
		          }
		
		          form.classList.add('was-validated');
		        }, false);
		      });
		}, false);
		
		$(function() {
			
			// 폼 제출시 체크
			    $('.classReg').on('submit', function(e) {
			    	
//             	// 유효성 검사
//         	        // 선택 상자의 값이 비어 있는지 확인
        	        if ($("#selected-items").val() == "") {
        	        	alert("해쉬태그를 선택해주세요!");
        	            $("#item-list").focus();
        	            return false; // 폼 제출을 막음
        	        }
        	        if ($("#summernote").val() == "") {
        	        	alert("클래스소개를 입력해주세요!");
        	            $("#summernote").focus();
        	            return false; // 폼 제출을 막음
        	        }
        	        if ($("#post_code").val() == "") {
        	        	alert("주소를 입력해주세요!");
        	            $("#post_code").focus();
        	            return false; // 폼 제출을 막음
        	        }
        	        if ($(".class_creator_explain").val() == "") {
        	        	alert("크리에이터 소개를 입력해주세요!");
        	            $(".class_creator_explain").focus();
        	            return false; // 폼 제출을 막음
        	        }
        	
        	
        	        return true; // 폼 제출을 허용
            });
			
			
			
			// 카테고리 선택시 상세카테
			$("#class_big_category").change(function() {
				var big_category = $("#class_big_category").val();
				$.ajax({
					url: "getCategoryDetail",
					method: "get",
					data: { "big_category" : big_category },
					success: function(data) {
						$("#class_small_category").empty();
						$("#class_small_category").append('<option value="">선택해주세요</option>');
						$.each(data, function(index, item) {
							$("#class_small_category").append(
								$('<option></option>').val(item.common3_code).text(item.code_value)	
							);
						});
					}
				});		
			});
			
			// 회차 추가 및 데이터 전달
			let roundCount = 1;
		    $('.addCurri').on('click', function() {
		  	 if(roundCount < 5){
		  		roundCount++;
	            let newRow = '<tr>'
			                     + '<td>' + roundCount + '차시 <span class="delete-btn">&times;</span></td>'
			                     + '<td><textarea name="' + roundCount + '차시" maxlength="1000" rows="5" placeholder="내용을 입력해주세요" class="form-control curri_content" required></textarea></td>'
			                 + '</tr>';
	            $('#timeTable').append(newRow);
		  	} else{
		  		 alert("차시는 5회까지 추가 가능합니다!");
		  	}
		       });

			$('#timeTable').on('mouseenter', 'tr', function() {
			    $(this).find('.delete-btn').show();
			});
			
			$('#timeTable').on('mouseleave', 'tr', function() {
			    $(this).find('.delete-btn').hide();
			});
			
			$('#timeTable').on('click', '.delete-btn', function() {
				if($('#timeTable tr').length - 1 < 2){
					alert("1차시는 삭제할 수 없습니다");
					return;
				}
			    $(this).closest('tr').remove();
			    updateTextAreaNames();
			});
			
			function updateTextAreaNames() {
	            let rows = $('#timeTable tr');
	            roundCount = rows.length - 1; // 첫 번째 tr은 헤더이므로 제외
	            rows.each(function (index) {
	                if (index > 0) { // 첫 번째 tr은 헤더이므로 제외
	                    $(this).find('textarea').attr('name', index + '차시' );
	                    $(this).find('td:first').html(index + '차시 <span class="delete-btn">&times;</span>');
	                }
	            });
	        }
			
			// 클래스 가격 
			$("#class_price").on('input', function() {
		         if ($(this).val() <= 0) {
		             $(this).val(''); // 값이 0 이하일 경우 비움
		         }
		     });
		
			$("#class_price").on('keypress', function(e) {
		         if (e.key === '-' || (e.key === '0' && $(this).val() === '')) {
		             e.preventDefault(); // '-'나 맨 처음에 '0' 입력을 막음
		         }
		     });
			
			
			
			// 썸머노트 설정
			$('#summernote').summernote({
				  height: 300,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",					// 한글 설정
				  placeholder: '최대3000자까지 쓸 수 있습니다'	,//placeholder 설정
				  toolbar: [
						    // [groupName, [list of button]]
						    ['fontname', ['fontname']],
						    ['fontsize', ['fontsize']],
						    ['color', ['color']],
						    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
						    ['para', ['ul', 'ol', 'paragraph']],
						    ['height', ['height']],
	// 					    ['insert',['picture']]// 이미지 첨부
						  ],
						fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
						fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
			          
			});
			$('.class_creator_explain').summernote({
				  height: 200,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",					// 한글 설정
				  placeholder: '최대500자까지 쓸 수 있습니다'	,//placeholder 설정
				  toolbar: [
						     // [groupName, [list of button]]
						     ['fontname', ['fontname']],
						     ['fontsize', ['fontsize']],
						     ['style', ['bold', 'italic', 'underline', 'clear']],
						     ['para', ['ul', 'ol']],
						   ],
				  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
				  fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
				  // callbacks은 이미지 업로드 처리
	// 			  callbacks : {                                                    
	// 			  onImageUpload : function(files, editor, welEditable) {   
			        // 다중 이미지 처리를 위해 for문을 사용
	// 					for (var i = 0; i < files.length; i++) {
	// 						imageUploader(files[i], this);
	// 					}
	// 				 }
	// 			  }
			});
		});
		
		// 해쉬태그 다중선택
		document.addEventListener('DOMContentLoaded', () => {
		    const items = document.querySelectorAll('.item');
		    const form = document.querySelector('.validation-form');
		    const selectedItemsInput = document.getElementById('selected-items');
	
		    items.forEach(item => {
		        item.addEventListener('click', () => {
		            item.classList.toggle('selected');
		            updateSelectedItems();
		        });
		    });
	
		    form.addEventListener('submit', (event) => {
		        updateSelectedItems();
		    });
	
		    function updateSelectedItems() {
		        const selectedItems = Array.from(items)
		            .filter(item => item.classList.contains('selected'))
		            .map(item => item.getAttribute('data-value'));
	
		        selectedItemsInput.value = selectedItems.join(',');
		    }
		    
		});
	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		// 주소검색
	    function search_address() {
	        new daum.Postcode({ // daum.Postcode 객체 생성
	            oncomplete: function(data) {
	                console.log(data);
	                document.fr.post_code.value = data.zonecode;
	        		let address = data.roadAddress; // 기본주소 변수에 저장
	        		if(data.buildingName != "") {
	        			address += " (" + data.buildingName + ")";
	        		}
	        		document.fr.sido.value = data.sido;
	        		// 기본주소 출력
	        		document.fr.address1.value = address;
	        		// 상세주소 입력 항목에 커서 요청
	        		document.fr.address2.focus();
	        		let location = address.replace(/\s+/g, '');// 공백 제거
	        		
	        		 $.ajax({
        		        url: 'geocode',
        		        type: 'GET',
        		        data: { address: address },
        		        success: function(response) {
        		            console.log('Coordinates:', response);
        		            // XML 파싱 및 좌표 추출
        		            var parser = new DOMParser();
        		            var xmlDoc = parser.parseFromString(response, "text/xml");
        		            var x = xmlDoc.getElementsByTagName("x")[0].childNodes[0].nodeValue;
        		            var y = xmlDoc.getElementsByTagName("y")[0].childNodes[0].nodeValue;
							$("#location_x").val(y);
							$("#location_y").val(x);
        		        },
        		        error: function(error) {
        		            console.log('Error:', error);
        		        }
        		    });
	            }
	        }).open();
	    }
		
		
	</script>

</body>
</html>