<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml"> 
     <head>
       	 	<meta charset="utf-8">
       	 	<meta http-equiv="x-ua-compatible" content="ie=edge">
   			<title>Tea shop</title>
   			<meta name="viewport" content="width=device-width, initial-scale=1.0">
   			<meta name="description" content="茶叶店铺">
   			<meta name="author" content="牛占元">

			<!-- include all header js and css -->
            <jsp:include page="/pages/shop/templates/generic/sections/shopLinks.jsp" />
			<script src="<c:url value="/resources/js/jquery.alphanumeric.pack.js" />"></script>
                
		    <script type="text/html" id="productBoxTemplate">
				{{#pageData}}
                        <div itemscope itemtype="http://schema.org/Enumeration" class="col-md-COLUMN-SIZE col-sm-6 col-xs-12 product"  item-name="{{name}}" item-price="{{price}}" data-id="{{id}}">
								<div class="thumbnail product-img">
                                    {{#image}}
									<a href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html">
										<img src="{{image}}" alt="" />
									</a>
									{{/image}}
								</div>
								<div class="product-content text-center">
									<a class="listing-product-name" href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html"><h3 itemprop="name">{{varieties.desc}}</h3></a>
									<h4>
										{{#discounted}}<del>￥{{price}}</del>&nbsp;<span itemprop="price" class="specialPrice">￥{{discountPrice}}</span>{{/discounted}}
										{{^discounted}}<span itemprop="price">￥{{price}}</span>{{/discounted}}
									</h4>
									<div class="store-btn">
      									<div class="store-btn-addtocart"><a class="addToCart" href="javascript:void(0)" productId="{{id}}">添加到购物车</a></div>
   									</div>
								</div>
						</div>
				{{/pageData}}
    		</script>            
                
 	</head>
 
 	<body>
 	  <!--[if lt IE 8]>
           <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
       <![endif]-->
	
		<jsp:include page="/pages/shop/templates/generic/sections/header.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/navbar.jsp" />
		
		<div class="entry-header-area ptb-40">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="entry-header">
							<h1 class="entry-title">
								检阅你的订单
							</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		 
		
		
		<!-- cart-main-area start -->
		<div class="cart-main-area ptb-40">
			<div class="container">
				<c:choose>
					<c:when test="${not empty sessionScope.cart}">
						<c:choose>
							<c:when test="${not empty sessionScope.cart.pageData}">
								<!-- cart-main-area start -->
								<div class="cart-main-area ptb-40">
									<div class="container">
										<div class="row">
											<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
												<div class="table-content table-responsive">
													<!-- 
									Shopping cart has to be id=mainartTable
									 -->
													<table id="mainCartTable"
														class="table table-hover table-condensed">
														<c:forEach items="${sessionScope.cart.pageData}"
															var="shoppingCartItem" varStatus="itemStatus">
															<c:if test="${itemStatus.index eq 0}">
																<thead>
																	<tr>
																		<th>商品</th>
																		<th>数量</th>
																		<th>价格</th>
																		<th>共计</th>
																		<th></th>
																	</tr>
																</thead>
																<tbody>
															</c:if>
																<tr>
																	<td data-th="商品">
																		<div class="row-cart">
																			<div class="col-sm-4 hidden-xs">
																				<c:if test="${shoppingCartItem!=null}">
																					<img width="60"
																						src="/<c:url value="${shoppingCartItem.product.image}"/>"
																						class=""/>
																				</c:if>
																			</div>
																			<div class="col-sm-8">
																				<span class="nomargin"><strong>${shoppingCartItem.product.varieties.desc}</strong></span>
																			</div>
																		</div>
																	</td>
																	<td width="10%"
																		data-th="数量">
																		<input type="number"
																		class="input-small quantity text-center"
																		value="${shoppingCartItem.quantity}" name="quantity"
																		id="${shoppingCartItem.id}"/>
																	</td>
		
																	<td
																		data-th="价格"><strong>￥${shoppingCartItem.product.price}</strong></td>
																	<td
																		data-th="共计"
																		class=""><strong>￥${shoppingCartItem.product.price * shoppingCartItem.quantity}</strong></td>
		
																	<td width="10%" class="actions" data-th="">
																		<div class="cart-del">
																			<a href="javascript:void(0);"  class="cart-close removeProductIcon"
																				style="clear: both !important;"
																				onclick="javascript:removeItemFromCart('${shoppingCartItem.id}');">
																				<i class="fa fa-times"></i>
																			</a> <input type="hidden" name="lineItemId" id="lineItemId"
																				value="${shoppingCartItem.id}" />
																		</div>
																	</td>
		
																</tr>
														</c:forEach>
													</table>
												</div>
		
												<div class="row">
													<div class="col-lg-8 col-md-8 col-sm-7 col-xs-12">
														<div class="buttons-cart">
															<a href="javascript:void(0);" onclick="updateCart('#mainCartTable')" >重新计算</a> 
															<a href="/">继续购物</a>
														</div>
													</div>
													<div class="col-lg-4 col-md-4 col-sm-5 col-xs-12">
														<div class="cart_totals">
															<h2>
																共计
															</h2>
															<div class="cart-totals-table">
																<table>
																	<tbody>
																		
																			<tr class="cart-subtotal">
																				<th>小计</th>
																				<td><span class="amount">￥${sessionScope.cart.subTotalPrice}</span></td>
																			</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div class="wc-proceed-to-checkout">
															<a href="checkout.jsp">进入结算</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- cart-main-area end -->
		
							</c:when>
							<c:otherwise>
								<h4>
									你的购物车是空的
								</h4>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<h4>
							你的购物车是空的
						</h4>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!-- cart-main-area end -->
		
		
		
		
		<script>
			$(document).ready(function() {
				$('.quantity').numeric();
				$("input[type='text']").keypress(function(e) {
					if (e.which == 13) {
						e.preventDefault();
					}
				});
				$('#checkoutButton').click(function(e) {
					location.href = '<c:url value="/shop/order/checkout.html"/>';
				});
			});
		</script>		
		<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />
 	</body>
 	</html>


