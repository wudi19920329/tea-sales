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
            <script>
				function editAddress(formId){
					$( "#editBillingAddress_"+formId).submit();	
				}
				function editShippingAddress(formId){
					$( "#editShippingAddress_"+formId).submit();	
				}
				function addShippingAddress(formId){
					$( "#addShippingAddress_"+formId).submit();	
				}
			</script>    
		    <script type="text/html" id="productBoxTemplate">
				{{#goods}}
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
										{{#discounted}}<del>{{priceStr}}</del>&nbsp;<span itemprop="price" class="specialPrice">{{discountPriceStr}}</span>{{/discounted}}
										{{^discounted}}<span itemprop="price">{{priceStr}}</span>{{/discounted}}
									</h4>
									<div class="store-btn">
      									<div class="store-btn-addtocart"><a class="addToCart" href="javascript:void(0)" productId="{{id}}">添加到购物车</a></div>
   									</div>
								</div>
						</div>
				{{/goods}}
    		</script>            
                
 	</head>
	<body>
 	
 	    <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
		
		<jsp:include page="/pages/shop/templates/generic/sections/header.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/navbar.jsp" />
		
		
		
		<div id="main-content" class="container clearfix row-fluid">
				<div class="span12 common-row">
		
					  <div class="span8 col-md-8 no-padding">
						<div class="checkout-box">
							<span class="box-title">
								<p class="p-title">
									收货地址
									&nbsp;<a href="javascript:void(0)" onclick="editAddress('${customer.id}');">编辑</a>
								</p>
							</span>
							
							<form action="#" method="get" id="editBillingAddress_">
								<input type="hidden" name="customerId" value="${customer.id}">
								<input type="hidden" name="billingAddress" value="true"/>
								<address>
									
									姓名：${sessionScope.TEA_CUSTOMER.realName}
									<br/>
									<br/>
									手机号：${sessionScope.TEA_CUSTOMER.phone}
									<br/>
									<br/>
									收货地址：${sessionScope.TEA_CUSTOMER.address}
								</address>
						   </form>
						</div>
						<br/>
						 
					 </div>
					 <div class="span4 col-md-4">
					 	<jsp:include page="customerProfileMenu.jsp" />
					 	<jsp:include page="customerOrdersMenu.jsp" />
					 </div>
					</div>
				</div>
		<!--close .container "main-content" -->
		
		
		<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />

 	</body>
 
 </html>	
