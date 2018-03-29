
<%
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<script src="<c:url value="/resources/js/hogan.js" />"></script>
<script
	src="<c:url value="/resources/templates/generic/js/bloodhound.min.js" />"></script>
<script
	src="<c:url value="/resources/templates/generic/js/typeahead.bundle.min.js" />"></script>


<!-- Customer account menu logged in customer will display in customerAccount placeholder -->
<script type="text/html" id="customerLoggedInAccountTemplate">
		
</script>

<!-- Customer account menu not logged in customer will display in customerAccount placeholder -->
<script type="text/html" id="customerNotLoggedInAccountTemplate">
			
</script>

<!-- Mini shopping cart JS template -->
<script type="text/html" id="miniCartTemplate">
					 
                          {{#pageData}}
                          <li>
									<div class="cart-img">
											{{#product.image}}
												<img src="<c:out value="${pageContext.servletContext.contextPath}" />/{{product.image}}">
											{{/product.image}}
											{{^product.image}}
												&nbsp
											{{/product.image}}
									</div>	
									<div class="cart-content">
											<h4><a href="#">{{quantity}} x {{product.category.description}}</a></h4>
											<span class="cart-price">￥{{product.price}}</span>
									</div>
									<div class="cart-del">
											<button productid="{{productId}}" class="close removeProductIcon" onclick="removeItemFromMinicart('{{id}}')"><i class="fa fa-times-circle"></i></a>
									</div>			
							</li>
                            
                            <li>&nbsp;</li>
							<li class="total-price">共计&nbsp;{{product.price}}</li>
							<li class="checkout-bg">
									<a href="#" onclick="viewShoppingCartPage();">结账<i class="fa fa-angle-right"></i></a>
							</li>
                   			{{/pageData}}
					 	{{^pageData}}
							<h4 style="text-align: center;color:#666666;margin-top:10px;margin-bottom:10px;">您的购物车是空的</h4>
					 	{{/pageData}}
</script>

<!-- mini cart label button template -->
<script type="text/html" id="miniCartSummaryTemplate">
		<!-- empty cart and full summary subTotal & quantity -->
		{{^pageData}}
		<a href="#"><span class="lnr lnr-cart"></span>购物车 (0)</a>
		{{/pageData}}
		{{#pageData}}
		<a href="#"><span class="lnr lnr-cart"></span>购物车 <font color="red"><strong>({{totalCount}})</strong></font></a>
		{{/pageData}}
</script>


<!-- header-start -->
<header>
	<input type="hidden" id="customerId" value="${sessionScope.TEA_CUSTOMER.id}"/>
	<div class="header-top-area ptb-10 hidden-xs">
		<div class="container">
			<div class="row">
				<div class="col-lg-9 col-md-8 col-sm-8">
					<!-- placeholder for customer account -->
					<div class="header-top-left" id="customerAccount"
						style="margin-left: 20px;">
						<c:choose>

							<c:when test="${sessionScope.TEA_CUSTOMER!=null}">   
								<ul>
									<li class="click_menu"><a href="#">欢迎光临&nbsp;<span>${sessionScope.TEA_CUSTOMER.nickName}</span><i class="fa fa-angle-down"></i></a>
										<ul class="click_menu_show">
											<li><a href="/pages/shop/templates/generic/pages/dashboard.jsp" >我的账户</a></li>
											<li><a href="#" onClick="javascript:location.href='<c:url value="/shop/customer/logout" />';" href="#">退出</a></li>
										</ul>
									</li>
								</ul>
								<script type="text/javascript">
								
					                (function($) {
						    			$(".click_menu").on('click', function() {
						        			$(".click_menu_show").slideToggle(400)
						    			});
					                })(jQuery);
					            </script>    
						   	</c:when>
						   
						   	<c:otherwise>
						   		<ul>
									<li class="click_menu"><a href="javascript:void(0);">我的账户<i class="fa fa-angle-down"></i></a>
										<ul class="click_menu_show">
											<li><a href="javascript:void(0);" id="registerLink" onClick="javascript:location.href='/pages/shop/templates/generic/pages/register.jsp';">注册</a></li>
											<li><a href="javascript:void(0);" id="registerLink" onClick="javascript:location.href='/pages/shop/templates/generic/pages/logon.jsp';">登陆</a></li>
										</ul>
									</li>
								</ul>
								<script type="text/javascript">
					                (function($) {
					    			$(".click_menu").on('click', function() {
					        			$(".click_menu_show").slideToggle(400)
					    			});
					                })(jQuery); 
					            </script>       
						   	</c:otherwise>
						  
						</c:choose>	
						
						
					</div>

					<button class="btn btn-default header-left-menu type=" button"=""
						onclick="javascript:location.href='/shop/store/contactus.html';"
						aria-haspopup="true" aria-expanded="true">
						<a href="/shop/store/contactus.html">联系我们</a>
					</button>
				</div>

				<div class="col-lg-3 col-md-4 col-sm-4">
					<div class="header-top-right">
						<!-- Empty placeholder -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="header-bottom-area ptb-10">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-md-2 col-sm-3 col-xs-12">
					<!-- logo -->
					<div class="logo">
						<!--  use merchant store logo -->
						<a class="grey store-name" href="/"> <img
							class="logoImage"
							src="/resources/templates/generic/img/tea-logo.png">
						</a>
					</div>
				</div>
				<div class="col-lg-4 col-md-5 hidden-sm hidden-xs">
					<!-- <div class="single-header-bottom-info">
						<div class="header-bottom-icon">
							<span class="lnr lnr-rocket"></span>
						</div>
						<div class="header-bottom-text"></div>
					</div> -->
				</div>

				<div class="col-lg-4 col-md-4 col-sm-9 col-xs-12">
					<!-- search box -->
					<div class="input-group menu-search-box">
						<input type="text" class="form-control typeahead" type="search"
							name="q" id="searchField" placeholder="搜索" value="" /> <span
							class="input-group-btn">
							<button class="btn btn-default searchButton" type="submit">
								搜索</button>
						</span>
						<!-- important for submitting search -->
						<form id="hiddenSearchForm" method="post"
							action="<c:url value="/shop/search/search.html"/>">
							<input type="hidden" id="hiddenQuery" name="q">
						</form>
					</div>

					<!-- Shopping cart -->
					<div class="header-bottom-right">
						<div class="shop-cart" id="miniCartSummary"></div>
						<div class="shop-cart-hover fix">
							<ul id="miniCartDetails"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- header-end -->