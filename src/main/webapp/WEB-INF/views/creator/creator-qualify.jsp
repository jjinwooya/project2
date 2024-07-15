<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	href="${pageContext.request.contextPath}/resources/css/creator/creator-qualify.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.creator-qualify-info{
		background: #eee;
		height: 200px;
		border-radius: 5px;
		padding: 20px;
		overflow-y: scroll;
		word-break: keep-all;
	}
	.container{
		justify-content: center;
	}
	.checkBox{
/* 		width: 20px; */
/*         height: 20px; */
        transform: scale(1.5); /* 크기 두 배로 확대 */
	}
	.qualify-body{
	background: white;
	margin: 0 auto;
	border-radius: 10px;
	}
	.regist_account{
/* 		border: 1px solid black; */
		border-radius: 10px;
		margin: 0 auto;
	}


</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<div class="qualify-body col-md-6 mt-5">
		<!-- Single Page Header start -->
		<div class="container py-3 col-md-8">
			<h2 class="text-center display-6">Creator 등록</h2>
			<hr class="text-center text-black">
		</div>
		
		<div class="container col-md-10">
		
			<div class="regist_account col-md-6 text-center py-3 mb-4">
				<c:choose>
					<c:when test="${token eq null}">
						<h5 class="text-black mb-3">⚜️ 계좌 등록 ⚜️</h5>
						<input type="button" class="col-md-3" value="+" onclick="linkAccount()">
					</c:when>
					<c:otherwise>
						<h5 class="text-black mb-3">💳 등록된 계좌 💳</h5>
						<table>
							<tr>
								<td>계좌번호</td>
								<td>${token.account_num}</td>
							</tr>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
			
			
			<div class="creator-qualify-info col-md-12 mb-5">
				<h6>◎일정 준수 의무</h6>
	
	크리에이터회원은 회사와 서면(전자우편, SMS, LMS, SNS 기타 전자문서를 포함)으로 협의된 일정에 대한 조정이 필요하거나 지연될 것으로 예상될 경우, 즉시 회사에 그 사유와 변경예정일에 대하여 고지하고 일정 변경에 관한 협의를 개시할 의무가 있습니다. 이와 같은 고지는 변경 전 협의되었던 일정 기준 10일 전까지 이루어져야 합니다.<br>
	- 변경할 일정은 고지한 때로부터 30일 이내로 상호 협의하여 조정함<br>
	- 변경 전 협의되었던 일정으로부터 10일 전까지 고지한 경우 변경으로 발생한 비용은 회사와 크리에이터회원이 공동부담하고, 변경 전 일정 기준 10일 미만의 기간 중 고지한 경우 변경으로 발생한 비용은 크리에이터회원이 부담함<br>
	- 크리에이터회원의 사정으로 일정이 중단되는 등 일정의 진행이 불가능한 경우, 회사의 고의 또는 과실이 없는 한 크리에이터회원은 이로 인해 발생한 비용 전액을 배상하여야 함<br>
	만일, 크리에이터회원이 정당한 사유 없이 일정 준수 의무를 위반하거나 중도에 클래스 제작을 중단함으로 인하여 회사에 손해가 발생한 경우 크리에이터회원은 이에 대한 손해배상책임을 부담합니다.<br>
				
				<h6 class="mt-3">◎클래스 저작권 및 초상권 (Copyright and Portrait right)</h6>
	
	- BASIC 또는 PLUS 서비스플랜을 이용할 경우 클래스에 관한 저작권이 크리에이터회원에게 귀속됨을 확인합니다.<br>
	- PRO 서비스플랜을 이용할 경우 클래스의 저작권(작성의 범위 제한이 없는 2차적저작물작성권을 포함)이 크리에이터회원과 회사에게 각 50%씩 귀속되며, 판매서비스 이용기간 동안에는 회사가 공동저작권자를 대표하여 권리를 행사합니다. 판매서비스 이용기간이 종료하는 경우, 크리에이터회원과 회사는 각자 자유롭게 클래스의 저작권을 행사할 수 있고, 회사는 재량으로 클래스를 계속적으로 판매하여 크리에이터회원에게 정산정책에 따른 정산금을 지급할 수 있습니다.<br>
	- PREMIUM 서비스플랜을 이용할 경우 클래스의 저작권(작성의 범위 제한이 없는 2차적저작물작성권을 포함)은 회사에게 귀속되며, 판매서비스 이용기간이 종료하면 회사는 독점적으로 자유롭게 클래스의 저작권을 사용할 수 있습니다.<br>
	- 클래스의 저작재산권이 회사에 귀속되거나 이용허락 되는 경우 회사가 이러한 권리를 정당하게 행사하는 것과 관련하여 크리에이터회원의 저작인격권 행사는 제한됩니다.<br>
	- 클래스의 저작재산권이 회사에 귀속되거나 이용허락 되는 경우 회사가 이러한 권리를 정당하게 행사하는 것과 관련하여 크리에이터회원은 웹사이트, 어플리케이션 및 기타 간행물, 홍보물 등에 본인의 초상(성명, 음성, 서명 등 그 타인을 식별할 수 있는 표지 포함)이 도화, 사진, 영상 등의 매체를 통해 복제, 배포, 공중송신 및 기타의 방법으로 공개되거나 사용되는 것에 동의합니다.<br>
	
				<h6 class="mt-3">◎정산 방식</h6>
	
	- 판매서비스에 따른 정산금은 아래 산식에 의하여 계산되는 월간 클래스 이용 회원당 정산금의 총 합계를 말합니다.<br>
	- 정산대상 클래스 x 서비스 수수료율(10%)<br>
	- 다만, 무상으로 제공되는 클래스는 정산 계산에 산입되지 않습니다.<br>
	- 정산금 지급 시 추천인에 대한 보상금이 추가로 지급될 수 있고 클래스 종류 및 서비스플랜에 따라 저작권자(신탁관리업자 등을 포함)에 대한 저작물 이용대가(음원사용료 등)가 공제될 수 있습니다.<br>
	- 회사는 클래스런칭일(프리뷰 등을 제외한 클래스 1회차 이상 공개된 날)부터 2개월 이내에 초기 정산내역을 통지하고 이후 매 익월 1일 정산내역을 통지합니다. 이 경우 크리에이터회원은 정산내역을 받은 날로부터 7일 이내에 서면으로 동의 여부를 전달하여야 합니다.  회사는 이 때 크리에이터회원이 동의 여부를 전달하지 않을 경우 정산내역에 동의한 것으로 간주된다는 뜻을 별도로 크리에이터회원에게 고지하고, 크리에이터회원이 동의 여부를 전달하지 않는 경우 정산내역에 동의한 것으로 간주합니다.<br>
	- 정산금은 크리에이터센터에 등록된 크리에이터회원 계좌로 정산내역통지일로부터 25일 이내에 지급합니다. 또한 관련 법령 및 회계 처리와 관련하여 회사는 크리에이터회원에게 세금계산서 등 서류 발급을 요청할 수 있습니다. 이 경우 회사는 크리에이터회원이 그 서류를 발급하여 교부할 때까지 정산금의 지급을 유예할 수 있습니다.<br>
	- 대한민국 외 거주자에 대하여서는 회사의 현지법인이 정산금을 지급할 수 있으며, 결제수수료, 환전 및 송금에 관한 수수료는 회사가 부담합니다. 다만, 해외계좌 수취수수료 및 관련 법령에 따른 제세공과금은 크리에이터회원이 부담합니다.<br>
	- 등록된 크리에이터회원 계좌가 대한민국 외 지역 소재 은행에서 발급된 경우, 외화 수취수수료 발생으로 인하여 누적 정산금이 미화 50달러(5,000 일본엔)을 초과하는 경우에만 정산금이 지급됩니다.<br>
			</div>
		</div>
		<div class="d-flex justify-content-center mb-5">
			<h6 class=" mx-4 mb-0">위의 약관에 동의하십니까?</h6>
			<input type="checkbox" value="여기체크박스" class="checkBox">
		</div>
		
		<div align="center" class="mt-5 pb-5">
			<button onclick="registCreator()" class="btn btn-outline-primary btn-lg">크리에이터 등록</button>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

</body>
	<script type="text/javascript">
		function linkAccount() {
			sessionStorage.setItem("redirectUrl", "creator-qualify");
			// 새 창을 열어 사용자 인증 서비스 요청(금융결제원 오픈뱅킹 API 활용)
			let authWindow = window.open("about:blank", "authWindow", "width=500, height=700, left=700, top=100");
			authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
							+ "response_type=code"
							+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
							+ "&redirect_uri=http://localhost:8081/class_will/callback"
							+ "&scope=login inquiry transfer"
							+ "&state=12345678901234567890123456789012"
							+ "&auth_type=0";
		}
	
		function registCreator() {
			if(!"${token}"){
				alert("계좌를 등록하여주십시오");
				return;
			} 
			if($(".checkBox").prop("checked")){
				debugger;
				if(confirm("크리에이터로 등록하시겠습니까?")){
					location.href='creator-regist';	
				}
			} else if(!$(".checkBox").prop("checked")){
				alert("약관에 동의하여 주십시오");
				$(".checkBox").focus();
				return;
			} 
		}
			
		
	</script>
</html>