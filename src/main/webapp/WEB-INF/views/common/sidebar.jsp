<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="sidebar">
	
		<nav class="navbar navbar-expand-md navbar-absolute navbar-transparent">
			 <div class="navbar-wrapper">
				<div class="navbar-toggle d-inline">
					<button type="button" class="navbar-toggler">
						<i class="tim-icons icon-settings-gear-63"></i>
						<!-- <span class="navbar-toggler-bar bar1"></span>
						<span class="navbar-toggler-bar bar2"></span>
						<span class="navbar-toggler-bar bar3"></span> -->
					</button>
				</div>
			</div>
		</nav>
		
	  <div class="sidebar-wrapper">
	    <div class="logo">
	      <a href="javascript:void(0)" class="simple-text logo-normal">
	        ${sessionScope.store_name}
	      </a>
	    </div>
	    <ul class="nav">
	      <li>
	        <a href="/store/my/sales">
	          <i class="tim-icons icon-money-coins"></i>
	          <p>판매 현황</p>
	        </a>
	      </li>
	      <li>
	        <a href="/store/my/sales/table">
	          <i class="tim-icons icon-paper"></i>
	          <p>정산 내역</p>
	        </a>
	      </li>
	      <li>
	        <a href="/store/my/products">
	        <!-- 임시 URI -->
	          <i class="tim-icons icon-basket-simple"></i>
	          <p>상품 관리</p>
	        </a>
	      </li>
	      <li>
	        <a href="/store/my/subscribes">
	          <i class="tim-icons icon-gift-2"></i>
	          <p>구독 관리</p>
	        </a>
	      </li>
	      <li>
	        <a href="/store/my/reviews?page=0">
	          <i class="tim-icons icon-pencil"></i>
	          <p>후기 관리</p>
	        </a>
	      </li>
	      <li>
	        <a href="/store/my/inquiries?page=0">
	          <i class="tim-icons icon-chat-33"></i>
	          <p>문의 관리</p>
	        </a>
	      </li>
	      <li>
	        <a href="/store/my/notices">
	          <i class="tim-icons icon-volume-98"></i>
	          <p>공지 관리</p>
	        </a>
	      </li>
	      <li>
	        <a href="/store/my/creators">
	          <i class="tim-icons icon-settings"></i>
	          <p>스토어 관리</p>
	        </a>
	      </li>
	    </ul>
	  </div>
	</div>