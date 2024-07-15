<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');
	
	.class-will-bottom {
		font-family: "Nanum Gothic", sans-serif; 
		color: white;
	}
	
	.class-will-bottom a {
	    color: inherit; 
	    text-decoration: none; 
	}
		
	.bottom-ul {
		list-style: none;
		padding: 0;
	    margin: 0;
	    display: flex;
	    flex-wrap: wrap; 
	    color: white;
	}
	
	.bottom-menu {
		font-size: 20px;
		font-weight: bold;
		margin-right: 15px;
	}
	
	.bottom-info {
		margin-right: 15px;
	}
	
	.social-icons {
        display: flex;
        justify-content: center; 
        align-items: center;
        padding-top: 20px;
    }

    .social-icons .btn {
        margin-right: 10px;
    }
    
    .back-to-top {
	    position: fixed;
	    right: 25px;
	    bottom: 80px;
	    display: flex;
	    width: 40px;
	    height: 40px;
	    align-items: center;
	    justify-content: center;
	    transition: 0.5s;
	    z-index: 999;
	}
	
/* 	.chatbot { */
/* 		position: fixed; */
/* 	    right: 50px; */
/* 	    bottom: 80px; */
/* 	    display: flex; */
/* 	    width: 50px; */
/* 	    height: 50px; */
/* 	    align-items: center; */
/* 	    justify-content: center; */
/* 	    z-index: 999; */
/* 	} */
	
	.customer_service_center {
		color: white;
	}
	
	.bottom-csc {
		text-align: left;
	}
	
	.rounded-circle {
		width: 40PX;
		height: 40px;
		color: white;
	}

	.bottom-nevi-var {
		background: #333;
		position: fixed;
	    bottom: 0px;
		height: 65px; 
		color: white;
	    z-index: 999;
	    padding: 0px;
	    margin: 0 auto;
	}
	
	.bottom-nevi-item {
		font-size: 12px;
		margin: 0px;
		padding: 0px;
	}
	
	.bottom-icon {
		font-size: 20px;
	}
	
	.bottom-nav-link {
	    color: white !important;
	}
	
	.bottom-nav-link:hover,
	.bottom-nav-link:focus {
	    color: white !important;
	    font-weight: bold;
	}
	
	.bottom-nav-link:active {
	    color: white !important;
	    font-weight: bold;
	}
	
	.bottom-nav-link:active .bottom-icon {
	   font-size: 23px;
	}
	
	.badge-position-bt {
		top: 15px; /* 위로 이동 */ 
		right: 20px; /* 오른쪽으로 이동 */ 
	    transform: translate(50%, -50%); /* 적절한 위치로 조정 */
	    width: 12px !important;
	    height: 12px !important;
	    display: flex;
	    align-items: center;
	    justify-content: center;
		font-size: 8px;
	}
	
</style>
	<!-- Back to Top -->
	<a href="#" class="btn btn-light focus-ring focus-ring-success  border-3 border-success-subtle rounded-circle back-to-top"><i class="fa fa-arrow-up text-black"></i></a>  
	
    <!-- Footer Start -->
    <div class="class-will-bottom mt-3">
	    <div class="container-fluid text-white-50 footer pt-1 mt-3 pb-3" style="background-color: #191919;">
	        <div class="container py-3">
	            <div class="pb-2">
	                <div class="row g-4" >
	                    <div class="col-lg-3 d-flex align-items-center justify-content-center" >
	                        <a href="#">
	                             <img src="${pageContext.request.contextPath}/resources/img/class_will_logo.png" id="logo" width="150px" alt="Logo" class="d-inline-block align-text-top">
	                        </a>
	                    </div>
	                    <div class="col-lg-6 d-flex justify-content-start align-items-center" >
	                        <div class="">
	                       		 <ul class="bottom-ul">
									<li class="bottom-menu"><a href="csc?type=notice">공지사항</a></li>
									<li class="bottom-menu"><a href="csc?type=faq">FAQ</a></li>
									<li class="bottom-menu"><a href="use-info">이용약관</a></li>
									<li class="bottom-menu"><a href="privacy-info">개인정보처리방침</a></li>
									<li class="bottom-menu"><a href="refund-info">환불규정</a></li>
								</ul>
	                        </div>
	                    </div>
	                    <div class="col-lg-3 pt-5">
	                    	<div class="customer_service_center">
		                        <h3>고객센터</h3>
								<div class="d-grid gap-2 py-2">
									<button class="btn btn-light">문의하기</button>
								</div>
								<p style="font-size: 13px;">*주중 10시~18시/주말 및 공휴일 제외</p>
							</div>	
	                    </div>
	                </div>
	            </div>
	            <div class="row g-5 mb-5">
	                <div class="col-lg-3 d-flex align-items-start justify-content-center">
	                    <div class="d-flex pt-3 justify-content-center social-icons">
	                         <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle text-white" ><i class="fab fa-twitter"></i></a>
	                         <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle text-white" href=""><i class="fab fa-facebook-f"></i></a>
	                         <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle text-white" href=""><i class="fab fa-youtube"></i></a>
	                         <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle text-white" href=""><i class="fab fa-linkedin-in"></i></a>
	                     </div>
	                </div>
	                <div class="col-lg-6 ">
	                    <div class="d-flex flex-column text-start footer-item" >
	                       <ul class="bottom-ul">
								<li class="bottom-info">(주)클래스윌</li>
								<li class="bottom-info">대표: 김부기</li>
								<li class="bottom-info">사업자등록번호: 000-00-00000 </li>
								<li class="bottom-info">통신판매업신고번호: 0000-부산진구-0000</li>
								<li class="bottom-info">주소: 부산 부산진구 동천로 109 삼한골든게이트 7층</li>
								<li class="bottom-info">051-803-0909</li>
								<li class="bottom-info">이메일: boogimovie@gmail.com</li>
							</ul>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    
    

		<div class="container-fluid bottom-nevi-var d-lg-none align-items-center">
		    <ul class="nav nav-pills nav-justified d-flex align-items-center justify-content-center">
		        <li class="nav-item bottom-nevi-item d-flex justify-content-center align-items-center">
		            <a class="nav-link bottom-nav-link px-0 mx-2" href="./"><i class="bi bi-house-door-fill bottom-icon"></i><br>홈</a>
		        </li>
		        <li class="nav-item bottom-nevi-item d-flex justify-content-center align-items-center">
		            <a class="nav-link search-btn2 bottom-nav-link px-0 mx-2 " href="#"><i class="bi bi-search bi-top bottom-icon"></i><br>검색</a>
		        </li>
		        <li class="nav-item bottom-nevi-item d-flex justify-content-center align-items-center">
		            <a class="nav-link bottom-nav-link px-0 mx-2" href="creator-main"><i class="bi bi-plus-circle bottom-icon"></i><br>클래스 등록</a>
		        </li>
		        <li class="nav-item bottom-nevi-item d-flex justify-content-center align-items-center">
		        
		            <a class="nav-link bottom-nav-link px-0 mx-2 position-relative openChatModal" href="#" id="openChatModal2" >
		            	<i class="bi bi-envelope bi-top bottom-icon"></i>
<!-- 		            	<span class="position-absolute badge-position-bt bg-danger border border-light rounded-circle alerts"></span> -->
						<br>메시지
					</a>
		        </li>
		        <li class="nav-item bottom-nevi-item d-flex justify-content-center align-items-center">
		            <a class="nav-link bottom-nav-link px-0 mx-2" href="my-page"><i class="bi bi-person-circle bi-top bottom-icon"></i><br>내 정보</a>
		        </li>
		    </ul>
		</div>
				

	</div>
    <!-- Footer End -->
    
    <!-- 제이쿼리 -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script>
		// 챗봇
		(function(){
			var w=window;
			if(w.ChannelIO){
				return w.console.error("ChannelIO script included twice.");
			}
			var ch=function(){ch.c(arguments);};
			ch.q=[];
			ch.c=function(args){
				ch.q.push(args);
			};
			w.ChannelIO=ch;
			function l(){if(w.ChannelIOInitialized){return;}
			w.ChannelIOInitialized=true;
			var s=document.createElement("script");
			s.type="text/javascript";
			s.async=true;
			s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";
			var x=document.getElementsByTagName("script")[0];
			if(x.parentNode){x.parentNode.insertBefore(s,x);}}
			if(document.readyState==="complete"){l();}
			else{w.addEventListener("DOMContentLoaded",l);
			w.addEventListener("load",l);}
		})();
		ChannelIO('boot', {
			"pluginKey": "e4e4b39e-51da-4d32-b93f-b4e5dcacd689" // fill your plugin key
		});		
	</script>