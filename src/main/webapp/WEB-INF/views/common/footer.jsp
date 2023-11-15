<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
	    <!-- ***** Footer Start ***** -->
	    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="first-item">
                        <div class="logo">
                            <img src="/resources/images/trackers-navy-195.svg" alt="Trackers">
                        </div>
                        <ul>
                            <li><a href="#">서울특별시 서대문구</a></li>
                            <li><a href="#">trackers@company.com</a></li>
                            <li><a href="#">010-0200-0340</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3">
                    <h4>커뮤니티</h4>
                    <ul>
                        <li><a href="/community/posts?page=0&type=all">커뮤니티</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h4>스토어</h4>
                    <ul>
                        <li><a href="/store/products?page=0&sort=creDate&category=all">상품</a></li>
                        <li><a href="/store/creators?page=0&sort=creDate">크리에이터</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h4>고객지원</h4>
                    <ul>
                        <li><a href="/store/center/inquiries">고객센터</a></li>
                    </ul>
                </div>
                <div class="col-lg-12">
                    <div class="under-footer">
                        <p>Copyright © 2023 Trackers. All Rights Reserved.</p>
                        <p>트래커스에서 게시되거나 판매되는 모든 저작물은 저작권의 보호를 받고 있으며<br>원작자의 허가 없이 무단복제/도용/공유/재판매 등 저작권을 침해하는 경우 민형사상의 법적 책임을 질 수 있습니다.</p>
                        <p>트래커스는 본 플랫폼에서 발생하는 크리에이터 서비스의 당사자가 아닙니다.<br>제공 및 판매되는 콘텐츠에 대한 전반적인 책임은 스토어를 운영하는 크리에이터에 있습니다.<br>트래커스는 스토어와 콘텐츠에 관해 공정한 온라인 솔루션을 제공할 수 있도록 항상 최선을 다하겠습니다.</p>

                        <ul>
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-behance"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    	<!-- 자바스크립트 코드-->
<!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 -->


    <!-- Bootstrap -->
    <!-- <script src="/resources/js/popper.js"></script> -->
    <script src="/resources/js/bootstrap.min.js"></script>



    <!-- Plugins -->
    <script src="/resources/js/owl-carousel.js"></script>
    <script src="/resources/js/accordions.js"></script>
    
    <!-- <script src="/resources/js/datepicker.js"></script> -->
    
    <script src="/resources/js/scrollreveal.min.js"></script>
    
    <!-- <script src="/resources/js/waypoints.min.js"></script> -->
    
    <script src="/resources/js/jquery.counterup.min.js"></script>
    
    <!-- <script src="/resources/js/imgfix.min.js"></script>  -->
    <!-- <script src="/resources/js/slick.js"></script>  -->
    <!-- <script src="/resources/js/lightbox.js"></script>  -->
    <!-- <script src="/resources/js/isotope.js"></script>  -->
    
    
    
    <!-- Global Init -->
    <script src="/resources/js/custom.js"></script>

	<!-- Validation -->
	<script src="/resources/js/validation.js"></script> 
	
	
	<!-- co-main -->
			<!-- <script src="/resources/js/jquery-2.1.0.min.js"></script> -->
			<!-- <script src="/resources/js/browser.min.js"></script> -->
			<script src="/resources/js/breakpoints.min.js"></script>
			<script src="/resources/js/util.js"></script>
			<script src="/resources/js/main.js"></script>
	


	
	
	<!-- 
	================================================
			대시보드 탬플릿
	================================================
	 -->	
	<script src="/resources/js/black-dashboard.js"></script>
  
    <script>
 
        $(function() {
            var selectedClass = "";
            $("p").click(function(){
            selectedClass = $(this).attr("data-rel");
            $("#portfolio").fadeTo(50, 0.1);
                $("#portfolio div").not("."+selectedClass).fadeOut();
            setTimeout(function() {
              $("."+selectedClass).fadeIn();
              $("#portfolio").fadeTo(50, 1);
            }, 500);
                
            });
        });

    </script>
    


  </body>
  
  <!--

	TemplateMo 571 Hexashop 
	
	https://templatemo.com/tm-571-hexashop
	
	-->
  
</html>