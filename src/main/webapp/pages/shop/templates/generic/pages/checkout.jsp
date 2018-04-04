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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<script type="text/html" id="productBoxTemplate">
				{{#rows}}
                        <div itemscope itemtype="http://schema.org/Enumeration" class="col-md-COLUMN-SIZE col-sm-6 col-xs-12 product"  item-name="{{name}}" item-price="{{price}}" data-id="{{id}}">
								<div class="thumbnail product-img">
                                    {{#image}}
									<a href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html">
										<img src="{{image}}" alt="" />
									</a>
									{{/image}}
								</div>
								<div class="product-content text-center">
									<a class="listing-product-name" href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html"><h3 itemprop="name">{{name}}</h3></a>
									<h4>
										{{#discounted}}<del>￥{{price}}</del>&nbsp;<span itemprop="price" class="specialPrice">￥{{discountPrice}}</span>{{/discounted}}
										{{^discounted}}<span itemprop="price">￥{{price}}</span>{{/discounted}}
									</h4>
									<div class="store-btn">
      									<div class="store-btn-addtocart"><a class="addToCart" href="javascript:void(0)" productId="{{id}}">添加到购物车</a></div>
   									</div>
								</div>
						</div>
				{{/rows}}
    		</script>

<script>
	$(document).ready(function() {
		(function(){
			$("#expressDeliveryModeCost").html("￥"+$("#expressDeliveryMode").find("option:selected").data("cost"));
			$("#totalAmounts").html("￥"+(parseFloat($("#subTotalPrice").val())+parseFloat($("#expressDeliveryMode").find("option:selected").data("cost"))));
			$("#payableAmount").val(parseFloat($("#subTotalPrice").val())+parseFloat($("#expressDeliveryMode").find("option:selected").data("cost")));
			$("#expressDeliveryMode").change(function(){
				$("#expressDeliveryModeCost").html($(this).find("option:selected").data("cost"));
				$("#totalAmounts").html("￥"+(parseFloat($("#subTotalPrice").val())+parseFloat($(this).find("option:selected").data("cost"))));
				$("#payableAmount").val(parseFloat($("#subTotalPrice").val())+parseFloat($(this).find("option:selected").data("cost")));
			});
		})();
		
		$("#submitOrder").click(function(){
			 
			if(!document.getElementById('customerAgreed').checked) {
			    alert("请勾选用户协议！");
			    return;
			} 
			var params = {
				method:"submit",
				description:$("#description").val(),
				expressDeliveryMode:$("#expressDeliveryMode").val(),
				payableAmount:$("#payableAmount").val()
			};
			$.ajax({
				type : 'post',
				dataType : "json",
				data:params,
				url : '/order',
				success : function(data) {
					window.location.href="confirmation.jsp?orderNumber="+data;
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("购买失败");
					alert('Error ' + jqXHR + "-" + textStatus + "-" + errorThrown);
				}
			});
		}) 
		
	});
 
</script>

</head>
<body>
	<!--[if lt IE 8]>
           <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
       <![endif]-->
	<jsp:include page="/pages/shop/templates/generic/sections/header.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/navbar.jsp" />

	<!-- page-title-wrapper-end -->
	<!-- entry-header-area start -->
	<div class="entry-header-area ptb-40">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="entry-header">
						<h1 class="entry-title">结账</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- entry-header-area end -->
	<!-- coupon-area start -->
	<div class="coupon-area">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="coupon-accordion"></div>
				</div>
			</div>
		</div>
	</div>



	<!-- coupon-area end -->
	<!-- checkout-area start -->
	<div class="checkout-area pb-50">
		<div class="container">
			<div class="row">


				<!-- If error messages -->
				<div id="checkoutError"
					class="<c:if test="${errorMessages!=null}">alert  alert-error alert-danger </c:if>">
					<c:if test="${errorMessages!=null}">
						<c:out value="${errorMessages}" />
					</c:if>
				</div>
				<!--alert-error-->
				<form id="checkoutForm" action="#">
					<input type="hidden" id="useDistanceWindow"
						name="useDistanceWindow"
						value="<c:out value="${shippingMetaData.useDistanceModule}"/>">
						<div class="col-lg-6 col-md-6">
							<div class="checkbox-form">
								<h3>付款信息</h3>
								<div class="form-group login-page">
									<label>姓名</label> <input
										value="${sessionScope.TEA_CUSTOMER.realName}"
										readonly="readonly"
										class="span8 required form-control form-control-md" />
								</div>
								<div class="form-group login-page">
									<label>手机号</label> <input
										value="${sessionScope.TEA_CUSTOMER.phone}" readonly="readonly"
										class="span8 required form-control form-control-md" />
								</div>
								<div class="form-group login-page">
									<label>收货地址</label> <input
										value="${sessionScope.TEA_CUSTOMER.address}"
										readonly="readonly"
										class="span8 required form-control form-control-md" />
								</div>
								<div class="form-group login-page">
									<label>邮编</label> <input
										value="${sessionScope.TEA_CUSTOMER.postcode}"
										readonly="readonly"
										class="span8 required form-control form-control-md" />
								</div>
								<div class="form-group login-page">
									<div class="country-select">
										<label>快递方式<span class="required">*</span></label> <select
											id="expressDeliveryMode" name="expressDeliveryMode"
											class="billing-country-list"
											style="background-color: rgb(255, 255, 255);">
											<c:set var="expressDeliveryModes"
												value="<%=com.tea.enums.ExpressDeliveryMode.values()%>" />
											<c:forEach var="expressDeliveryMode"
												items="${expressDeliveryModes}">
												<option data-cost="${expressDeliveryMode.getCost()}" value="${expressDeliveryMode.getName()}">${expressDeliveryMode.getDescription()}</option>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="order-notes">
									<div class="checkout-form-list">
										<label>订单描述</label>
										<textarea id="description" cols="30" rows="10" path="comments"
											placeholder="订单或交货说明"></textarea>
									</div>
								</div>
							</div>
						</div>
					<div class="col-lg-6 col-md-6">
						<div class="your-order">
							<h3>订单摘要</h3>
							<div class="your-order-table table-responsive">
								<table id="summary-table">
									<!-- requires summary-table -->
									<thead>
										<tr>
											<th class="product-name">商品</th>
											<th class="product-total">共计</th>
										</tr>
									</thead>
									<tbody id="summaryRows">
										<c:forEach items="${sessionScope.cart.rows}"
											var="shoppingCartItem">
											<tr class="cart_item">
												<td class="product-name">
													${shoppingCartItem.product.name} <strong
													class="product-quantity"> x
														${shoppingCartItem.quantity}</strong>
												</td>
												<td class="product-total"><span class="amount">￥${shoppingCartItem.product.price * shoppingCartItem.quantity}</span>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<!-- subtotals -->
										<tr id="cart-subtotal-order.total.subtotal"
											class="cart-subtotal subt">
											<td class="order-total-label">小计</td>
											<input type="hidden" id="subTotalPrice"
												value="${sessionScope.cart.subTotalPrice}"></input>
											<td><strong>${sessionScope.cart.subTotalPrice}</strong></td>
										</tr>
										<tr id="cart-subtotal-order.total.shipping"
											class="cart-subtotal subt">
											<td class="order-total-label">运费</td>
											<td><strong id="expressDeliveryModeCost"></strong></td>
										</tr>


										<tr id="totalRow" class="total-box order-total">
											<th>共计</th>
											<td><strong><span class="amount grand-total"
													id="totalAmounts"></span></strong>
												<input type="hidden" id="payableAmount"/>	
													</td>
										</tr>
									</tfoot>
								</table>
							</div>

							<!-- Payments -->
							<div class="payment-method">
								<ul class="nav nav-tabs" role="tablist">


									<li role="presentation" class="active"><a
										href="#MONEYORDER" class="paymentMethodSelected"
										name="moneyorder" aria-controls="#MONEYORDER" role="tab"
										data-toggle="tab">

											<h5>订单支付说明</h5>

									</a></li>


								</ul>
								<!--  redit card https://codepen.io/llgruff/pen/JdyJWR -->
								<div class="v-margin20">
									<div class="tab-content">
										<div class="payment-tab tab-pane active" id="MONEYORDER">
											<!-- exception for stripe, braintree... which has it's own page -->

											<div class="control-group">
												<label class="control-label">货到付款</label>
												<div class="controls"></div>
											</div>

											<div class="control-group payment-method-box">
												请检查你的订单，订单将按照订单地址邮寄。</div>
										</div>
										<!-- values set by javascript -->
									</div>
								</div>


								<!-- customer agreement -->
								<div class="checkout-box" id="customerAgreementSection">
									<label id="customerAgreement" class="checkbox"> 
										<input id="customerAgreed" name="customerAgreed" class="required" title="请同意用户协议" type="checkbox" value="true"/>
										<input type="hidden" name="_customerAgreed" value="on"/> <a href="javascript:void(0);">我同意条款和条件</a>
									</label>
								</div>

								<div class="order-button-payment">
									<button id="submitOrder" type="button" class="btn-disabled">提交订单
									</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- checkout-area end -->
 


	<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />
</body>
</html>





