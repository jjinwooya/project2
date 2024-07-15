$(function() {
	//엑세스 토큰 없을 시 충전버튼 비활성화
	let token = $("#sessionToken").val();
	if(token == '') {
		$("#chargeBtn").prop("disabled", true);
	}

    // 금액 입력 이벤트
    $('#will_pay_charge').on('input', function() {
        let willpay = $('#will_pay_charge').val();
        let regex = /^\d+0$/g;
        let formTranAmt = $("#form_tran_amt");
        var value = $(this).val().replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거

        if (regex.test(willpay) && willpay != "") {
            $("#result").text("");
        } else {
            $("#result").text("10원 단위로 입력해 주세요");
            $("#result").css("color", "red");
        }

        $('#selected_package').val("");
        $("#will_pay_chargeType").val("normal");
        	console.log($("#will_pay_chargeType").val());
        formTranAmt.val(willpay);
    });

    // 카드 클릭 이벤트
    $('.card').click(function() {
        // 클릭된 카드 내의 package_up_price 요소의 텍스트를 가져옴
        let packageUpPrice = $(this).find('.package_up_price').text();
        let rewardFee = $(this).find("#text_deco").text(); // 안에 있는 id,class 찾는 find() 메서드

        packageUpPrice = packageUpPrice.replace(/원/g, '');
        $("#form_tran_amt_total").val(packageUpPrice);

        rewardFee = rewardFee.replace(/원/g, '');
        $("#form_tran_amt").val(rewardFee);
        $("#will_pay_chargeType").val("package");

        // selected_package 입력 필드에 값을 설정
        $('#selected_package').val(packageUpPrice + "원");
        $('#will_pay_charge').val("");
    });

    $("#withdraw_form").on("submit", function(event) {
        let amt = $("#form_tran_amt").val();
        let regex = /^0\d*[1-9]$|^\d*[1-9]$/;
        let willpay = $("#will_pay_charge").val();

        if (!amt) {
            alert("금액 입력 또는 패키지를 선택해 주세요");
            return false;
        }

        if (willpay != '') {
            if (regex.test(willpay)) {
                alert("정확한 금액을 입력해주세요");
                return false;
            }
        }

        if (!$("#form_fintech_use_num").val() || !$("#form_user_name").val()) {
            alert("계좌를 선택해 주세요");
            return false;
        }
    });
    
	
});

document.addEventListener("DOMContentLoaded", function() {
    const bankInfo = bankInfoJson;

    const buttonsContainer = document.getElementById("buttons-container");
    const modalsContainer = document.getElementById("modals-container");
    bankInfo.forEach(info => {
        const button = document.createElement("button");
        button.type = "button";
        button.className = "btn btn-light text-black m-2 custom-btn";
        button.setAttribute("data-bs-toggle", "modal");
        button.setAttribute("data-bs-target", "#modal-" + info.transfer_agree_dtime);
        button.textContent = "등록된 계좌 (" + info.bank_name + ")";
        buttonsContainer.appendChild(button);

        // Create the modal
        const modal = document.createElement("div");
        modal.className = "modal fade";
        modal.id = "modal-" + info.transfer_agree_dtime;
        modal.tabIndex = -1;
        modal.innerHTML = 
            "<div class='modal-dialog'>" +
                "<div class='modal-content'>" +
                    "<div class='modal-header'>" +
                        "<h1 class='modal-title fs-5'>" + info.bank_name + "</h1>" +
                        "<button type='button' class='btn-close' data-bs-dismiss='modal'></button>" +
                    "</div>" +
                    "<div class='modal-body'>" +
                        "계좌:" + info.account_num_masked +
                    "</div>" +
                    "<div class='modal-footer'>" +
                        "<button type='button' class='btn btn-dark select-account' data-fintech-use-num='" + info.fintech_use_num + "' data-user-name='" + info.account_holder_name + "'>계좌 선택</button>" +
                        "<button type='button' class='btn btn-dark' onclick='linkAccount()'>계좌 추가</button>" +
                    "</div>" +
                "</div>" +
            "</div>";
        modalsContainer.appendChild(modal);
    });

    // 계좌 선택 버튼 클릭 이벤트
    modalsContainer.addEventListener("click", function(event) {
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

function linkAccount() {
    sessionStorage.setItem("redirectUrl", "will_pay_charge");
    
    // 새 창을 열어 사용자 인증 서비스 요청(금융결제원 오픈뱅킹 API 활용)
    let authWindow = window.open("about:blank", "authWindow", "width=500, height=700");
    authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?" +
        "response_type=code" +
        "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9" +
        "&redirect_uri=http://localhost:8081/class_will/callback" +
        "&scope=login inquiry transfer" +
        "&state=12345678901234567890123456789012" +
        "&auth_type=0";
}
