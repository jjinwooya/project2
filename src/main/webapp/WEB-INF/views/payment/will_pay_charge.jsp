<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CLASS-WILL charge</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js "></script>
<style>
body{
	color:white;
}

.full-height{
	height:100vh;
}
.title {
	background: #333333;
	color: white;
	height: 50px;
	display:flex;
	justify-content: center;
}
.title p {
	margin-top: 5px;
	text-align: center;
	font-weight: bold;
}

.custom-bg {
	background: black;
	height: 90vh;
}
.margin_use {
	margin-top: 20px;
}
#result { 
	box-sizing: border-box;
	height:60px;
	padding: 3px;
	margin: 0 15px;
} 
.package_group {
	display: flex;
	flex-flow: wrap;
	justify-content: space-between;
	padding: 0 10px;
}
.cutom-card {
	cursor:pointer;
}
.text_deco {
	text-decoration: line-through;
}
.regist_account input {
	width:100%;
	height:50px;
	border: 5px;
	border-radius:5px;
	background: white;
	font-size: 24px;
}
.account_area {
	width:100%;
	max-height: 500px;
	margin-bottom: 10px;
	position: relative;
}
.btn {
	color:white;
}
.accountInfo {
	width:100%;
	height:50px;
	border: 5px;
	border-radius:5px;
	background: #333333;
	font-size: 24px;
}
.accountInfo button img {
	width:45px;
	hegiht:45px;
}
#buttons-container button{
	display:block;
	width:100%;
	background: black;
}
#buttons-container button:hover{
	background: white;
	color: black !important;
	transition-duration : 0.5s
}
.modal-title {
	color: black;
}
.modal-body {
	color: black;
}
.custom-btn {
	color: white !important;
}
.submit_container {
	display: flex;
    flex-direction: column;
}

.selected {
    background: #336633 !important; /* 클릭 시 배경 색상 */
}
</style>
</head>
<body>
<div class="container full-height">
	<div class="title">
		<p style="font-size: 24px">충전하기</p>
	</div>
<!-- 	<div class="row"> -->
	<div class="row d-flex justify-content-center align-items-center">
		<div class="col-md-6  custom-bg">
			<div class="mx-3 margin_use">
				<label for="will_pay_charge" class="form-label">Will-pay 충전하기</label>
				<input type="text" class="form-control w-75" id="will_pay_charge" placeholder="충전할 금액을 입력해주세요.">
			</div>
			<p id="result"></p>
			<!-- package 종류 -->
			<hr>
			<div class="will_pay_package">
				<div class="mx-3">
					<label class="form-label">package</label>
				</div>
				<!-- package group -->
				<div class="package_group">
					<c:forEach var="package1" items="${packageInfo }" varStatus="status">
						<div class="card border-light mb-3 cutom-card" style="width:180px;">
							<div class="card-header">PLUS PACKAGE</div>
							<div class="card-body">
								<h5 class="card-title">${package1.reward_rate }% 더!</h5>
								<!-- package 가격정보 -->
								<p class="card-text">
									<span class="text_deco" id="text_deco">${package1.reward_fee }원</span><br>
									-> <span class="package_up_price" id="package_up_price">${package1.reward_total }원</span>
								</p>
								<input type="hidden" name="package_price" value="${package1.reward_fee }">
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 선택된 package 가격 -->
				<div class="mx-3">
					<label for="selected_package" class="form-label">선택된 package</label>
					<input type="text" class="form-control w-50" id="selected_package" readonly>
				</div>
				<hr>
			</div>
			<!-- 계좌 연동 시작 -->
			<div class="row">
				<c:choose>
					<c:when test="${empty token }">
						<p>계좌 등록</p>
						<div class="regist_account">
							<input type="button" value="+" onclick="linkAccount()">
						</div>
					</c:when>
					<c:otherwise>
						<div class="row d-flex justify-content-center h-25">
							<div id="buttons-container" class="row">
							</div>
							<div id="modals-container">
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<footer>
				<div class="row submit_container">
					<div class="d-grid btn_area_custom">
						<form action="account-withdraw" method="post" id="withdraw_form">
							<input type="hidden" name="fintech_use_num" id="form_fintech_use_num">
							<input type="hidden" name="user_name" id="form_user_name">
							<input type="hidden" name="tran_amt" id="form_tran_amt">
							<input type="hidden" name="tran_amt_total" id="form_tran_amt_total">
							<input type="hidden" name="payAc_type" id="form_payAc_type">
							<input type="hidden" name="member_code" value="${member_code }">
							<button type="submit" class="btn btn-success w-100">충전하기</button>
						</form>
					</div>		
				</div>			
			</footer>
		</div>
	</div>
</div>
<script>
$(function() {
	//금액 입력 이벤트
	$('#will_pay_charge').on('input', function() {
	let willpay = $('#will_pay_charge').val();
		let regex = /^\d+0$/g;
		let formTranAmt = $("#form_tran_amt");
		var value = $(this).val().replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거
		
		if(regex.test(willpay) && willpay != "") {
			$("#result").text("");
		} else {
			$("#result").text("10원 단위로 입력해 주세요");
			$("#result").css("color", "red");
		}
		
		$('#selected_package').val("");
		$("#form_payAc_type").val("normal");
		formTranAmt.val(willpay);
	});
	
	//카드 클릭 이벤트
	
	$('.card').click(function() {
		
        // 클릭된 카드 내의 package_up_price 요소의 텍스트를 가져옴
        let packageUpPrice = $(this).find('.package_up_price').text();
        let rewardFee = $(this).find("#text_deco").text(); //안에 있는 id,class 찾는 find() 메서드
        
        packageUpPrice = packageUpPrice.replace(/원/g, '');
        $("#form_tran_amt_total").val(packageUpPrice);
//         console.log("amt_total", packageUpPrice);
        
        rewardFee = rewardFee.replace(/원/g, '');
        $("#form_tran_amt").val(rewardFee);
        $("#form_payAc_type").val("package");
//         console.log("amt", rewardFee);
        
        // selected_package 입력 필드에 값을 설정
        $('#selected_package').val(packageUpPrice);
        $('#will_pay_charge').val("");
    });
	
	$("#withdraw_form").on("submit", function(event){
// 		event.preventDefault();
		let amt = $("#form_tran_amt").val();
		let regex = /^0\d*[1-9]$|^\d*[1-9]$/;
		let willpay = $("#will_pay_charge").val();
		
		if(!amt) {
			alert("금액 입력 또는 패키지를 선택해 주세요");
			return false;
		}
		
		if(willpay != '') {
			if(regex.test(willpay)) {
				alert("정확한 금액을 입력해주세요");
				return false;
			}
		}
		
		if(!$("#form_fintech_use_num").val() || !$("#form_user_name").val()) {
			alert("계좌를 선택해 주세요");
			return false;
		}
		
	});
	
});

document.addEventListener("DOMContentLoaded", function() {
	const bankInfo = ${packageInfoJson};
	
    const buttonsContainer = document.getElementById("buttons-container");
    const modalsContainer = document.getElementById("modals-container");
    bankInfo.forEach(info => {
        const button = document.createElement("button");
        button.type = "button";
        button.className = "btn btn-light text-black m-2 custom-btn";
        button.setAttribute("data-bs-toggle", "modal");
        button.setAttribute("data-bs-target", "#modal-" + info.transfer_agree_dtime);
//         const img = document.createElement("img");
//         img.src = info.imgSrc;
//         button.appendChild(img);
        button.textContent  = "등록된 계좌";
        buttonsContainer.appendChild(button);
        
        // Create the modal
        const modal = document.createElement("div");
        modal.className = "modal fade";
        modal.id = "modal-" + info.transfer_agree_dtime;
        modal.tabIndex = -1;
        modal.innerHTML = 
            "<div class='modal-dialog'>" 
                + "<div class='modal-content'>"
                    + "<div class='modal-header'>"
                        + "<h1 class='modal-title fs-5'>" + info.bank_name + "</h1>"
                        + "<button type='button' class='btn-close' data-bs-dismiss='modal'></button>"
                    + "</div>"
                    + "<div class='modal-body'>"
                        + "계좌:" + info.account_num_masked
                    + "</div>"
                    + "<div class='modal-footer'>"
                    	+ "<button type='button' class='btn btn-dark select-account' data-fintech-use-num='" + info.fintech_use_num + "' data-user-name='" + info.account_holder_name + "'>계좌 선택</button>"
                        + "<button type='button' class='btn btn-dark'>계좌 추가</button>"
                    + "</div>"
                + "</div>"
            + "</div>";
        modalsContainer.appendChild(modal);
    });
    
 	// 계좌 선택 버튼 클릭 이벤트
    modalsContainer.addEventListener("click", function(event) {
    	debugger;
        if (event.target && event.target.classList.contains("select-account")) {
            const fintechUseNum = event.target.getAttribute("data-fintech-use-num");
            const userName = event.target.getAttribute("data-user-name");
            
            document.getElementById("form_fintech_use_num").value = fintechUseNum;
            document.getElementById("form_user_name").value = userName;

            // 모달 닫기
            const modal = event.target.closest(".modal");
            const modalInstance = bootstrap.Modal.getInstance(modal);
            modalInstance.hide();
            
         // 모든 버튼의 selected 클래스를 제거
            var allButtons = document.querySelectorAll(".custom-btn");
            allButtons.forEach(function(btn) {
                btn.classList.remove("selected");
            });

            // 클릭된 모달을 연 버튼에 selected 클래스 추가
            var triggerButton = document.querySelector("[data-bs-target='#" + modal.id + "']");
            if (triggerButton) {
                triggerButton.classList.add("selected");
            }
        }
    });
});
</script>
<script>

function linkAccount() {
	sessionStorage.setItem("redirectUrl", "will_pay_charge");
	// 새 창을 열어 사용자 인증 서비스 요청(금융결제원 오픈뱅킹 API 활용)
	let authWindow = window.open("about:blank", "authWindow", "width=500, height=700" );
	authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
					+ "response_type=code"
					+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
					+ "&redirect_uri=http://localhost:8081/class_will/callback"
					+ "&scope=login inquiry transfer"
					+ "&state=12345678901234567890123456789012"
					+ "&auth_type=0";
}
</script>

</body>
</html>