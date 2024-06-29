<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/class_detail.css"> --%>
<%-- <link href="${pageContext.request.contextPath}/resources/lib/lightbox/css/lightbox.min.css" rel="stylesheet"> --%>
<%-- <link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet"> --%>

<%-- <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"> --%>

<<<<<<< HEAD
=======
<!-- Template Stylesheet -->
>>>>>>> branch 'main' of https://github.com/hawt34/class3_project_T2_2.git
<%-- <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet"> --%>

<!-- <link rel="preconnect" href="https://fonts.googleapis.com"> -->
<!-- <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> -->
<!-- <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> -->

<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/> -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet"> -->

<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script> --%>

<%-- <link href="${pageContext.request.contextPath}/resources/css/category-bar.css" rel="stylesheet"> --%>

</head>
<body>

<div class="categoryBar">
    <div class="row justify-content-center"> <!-- 가운데 정렬 -->
		<div class="categoryBarBox col-md-11">
			<div class="row height d-flex align-items-center mx-5">
				<div class="col-md-6">
					<div class="form form1">
						<i class="fa fa-search"></i>
						<input type="text" class="form-control form-input search-input" placeholder="클래스 검색">
					</div>
				</div>
			</div>
			
			<!-- 셀렉트박스 리스트 -->
			<div class="row mx-5">
				<div class="selectDiv">
					<select class="form-select categorySelect w-100" aria-label="Default select example">
						<option selected>카테고리</option>
						<option value="1">드로잉</option>
						<option value="2">디지털 드로잉</option>
						<option value="3">핸드메이드</option>
						<option value="4">쿠킹 / 베이킹</option>
						<option value="5">플라워 / 가드닝</option>
						<option value="6">뷰티</option>
						<option value="7">스포츠</option>
						<option value="8">요가 / 필라테스</option>
						<option value="9">사진 / 영상</option>
						<option value="10">음악</option>
					</select>
				</div>
				<div class="selectDiv">
					<select class="form-select categorySelect w-100" aria-label="Default select example">
						<option selected>지역</option>
						<option value="1">서울</option>
						<option value="2">부산</option>
						<option value="3">인천</option>
					</select>
				</div>
				<div class="selectDiv">
					<select class="form-select categorySelect w-100"  aria-label="Default select example">
						<option selected>유형</option>
						<option value="1">원데이</option>
						<option value="2">정기</option>
					</select>
				</div>
				<div class="selectDiv">
					<select class="form-select categorySelect w-100" aria-label="Default select example" id="customRange2">
						<option selected>금액</option>
						<option value="1">
						</option>
					</select>
				</div>
				<div class="col-md-3 btnReset">
					<button type="button" class="btn btn-outline-light">초기화</button>
				</div>
			</div>
			<!-- 셀렉트박스 리스트 -->
			
			<!-- 카테고리 셀렉스 리스트 -->
			<div class="row mx-5">
			    <div class="mt-3 col-md-2 position-relative chooseDiv">
			        <input type="text" class="form-control chooseResult" id="exampleFormControlInput1" placeholder="카테고리1" readonly>
			        <img src="${pageContext.request.contextPath}/resources/images/class/x.png" class="xicon">
			    </div>
			    <div class="mt-3 col-md-2 position-relative chooseDiv">
			        <input type="text" class="form-control chooseResult" id="exampleFormControlInput1" placeholder="카테고리2" readonly>
			        <img src="${pageContext.request.contextPath}/resources/images/class/x.png" class="xicon">
			    </div>
			    <div class="mt-3 col-md-2 position-relative chooseDiv">
			        <input type="text" class="form-control chooseResult" id="exampleFormControlInput1" placeholder="카테고리3" readonly>
			        <img src="${pageContext.request.contextPath}/resources/images/class/x.png" class="xicon">
			    </div>
			    <div class="mt-3 col-md-2 position-relative chooseDiv">
			        <input type="text" class="form-control chooseResult" id="exampleFormControlInput1" placeholder="카테고리4" readonly>
			        <img src="${pageContext.request.contextPath}/resources/images/class/x.png" class="xicon">
			    </div>
			    <div class="line col-md-12">
			    	<hr>
			    </div>
			</div>
			<!-- 카테고리 셀렉스 리스트 -->
			
			<!-- 해시태그 리스트 -->
			<div class="row mx-5 ">
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 가족" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 커플" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 반려동물" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 선물" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 데이트" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 단체" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 가족" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 가족" readonly>
					</div>
				</div>
				<div class="col-md-1 hashtagDiv">
					<div class="form form1">
						<input type="text" class="form-control form-inputs hashtag" placeholder="# 가족" readonly>
					</div>
				</div>
			</div>
			<!-- 해시태그 리스트 -->
		</div>
	</div>
</div>

</body>
</html>