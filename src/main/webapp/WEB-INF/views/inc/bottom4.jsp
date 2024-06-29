<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');
	
	.class-will-bottom {
/* 		background: black; */
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
        justify-content: center; /* 아이콘을 가운데 정렬 */
        align-items: center;
        padding-top: 20px;
    }

    .social-icons .btn {
        margin-right: 10px; /* 아이콘 간의 간격 조절 */
    }
    
    .back-to-top {
	    position: fixed;
	    right: 30px;
	    bottom: 200px;
	    display: flex;
	    width: 40px;
	    height: 40px;
	    align-items: center;
	    justify-content: center;
	    transition: 0.5s;
	    z-index: 999;
	}
	
	.chatbot {
		position: fixed;
	    right: 50px;
	    bottom: 100px;
	    display: flex;
	    width: 50px;
	    height: 50px;
	    align-items: center;
	    justify-content: center;
	    z-index: 999;
	}
	
	h3 {
		color: white;
	}
	
	.bottom-csc {
		text-align: left;
	}
	
	.rounded-circle {
		width: 40PX;
		height: 40px;
	}

</style>
	
	<!-- Back to Top -->
	<a href="#" class="btn btn-light focus-ring focus-ring-light border-3 border-light rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   
	<!-- chatbot -->
<%-- 	<a href="#" class="chatbot"><img src="${pageContext.request.contextPath}/resources/img/chatbot-icon2.png" width="150px" alt="chatbot" ></a>    --%>
        
        
    <!-- Footer Start -->
	<div class="class-will-bottom">
        <div class="container-fluid bg-dark text-white-50 footer mt-5" style="background-color: #333;">
            <div class="container py-5 text-center">
				<div class="row g-4">
					<div class="col-4 col-sm-9">
						<div class="row">
							<div class="col-4 col-mb-6">
							  <img src="${pageContext.request.contextPath}/resources/img/class_will_logo.png" id="logo" width="150px" alt="Logo" class="d-inline-block align-text-top">
							</div>
							<div class="col-8 col-mb-6">
								<ul class="bottom-ul">
									<li class="bottom-menu"><a href="csc">공지사항</a></li>
									<li class="bottom-menu"><a href="csc-faq">FAQ</a></li>
									<li class="bottom-menu"><a href="use-info">이용약관</a></li>
									<li class="bottom-menu"><a href="privacy-info">개인정보처리방침</a></li>
									<li class="bottom-menu"><a href="refund-info">환불규정</a></li>
								</ul>
							</div>
						</div>
						<div class="row">
							<div class="col-4 col-mb-6 social-icons">
								<div class="d-flex justify-content-end pt-3">
	                                <a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle" ><i class="fab fa-twitter"></i></a>
	                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i class="fab fa-facebook-f"></i></a>
	                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i class="fab fa-youtube"></i></a>
	                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i class="fab fa-linkedin-in"></i></a>
	                            </div>
							</div>
							<div class="col-8 col-mb-6">
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
					<div class="col-4 col-lg-3 bottom-csc">
						<h3>고객센터</h3>
						<div class="d-grid gap-2 py-2">
							<button class="btn btn-light">문의하기</button>
						</div>
						<p style="font-size: 13px;">*주중 10시~18시/주말 및 공휴일 제외</p>
					</div>
				</div>
            </div>
        </div>
	</div><!-- class-will-bottom -->        
   <!-- Footer End -->

    
    <script>
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
			w.addEventListener("load",l);}})();
		ChannelIO('boot', {
			"pluginKey": "e4e4b39e-51da-4d32-b93f-b4e5dcacd689" // fill your plugin key
		});
		
		
		let clickCount = 0;
	    const logo = document.getElementById('logo');

	    logo.addEventListener('click', () => {
	        clickCount++;
	        if (clickCount === 10) {
	            window.location.href = 'admin-login';
	        }
	    });
	</script>