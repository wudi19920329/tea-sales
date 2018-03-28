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
		
		
		<!-- home banner -->
			<!-- slider-area-start -->
			<div class="slider-area">
				<section id="home-banner">
					<article>
			
						<div class="banner-text">
							<h2>Vintage bags</h2>
							<p>Summer styles available</p>
							<div class="slider-button store-btn button-link">
								<div class="store-btn-addtocart">
									<a class="more" href="#">More details</a>
								</div>
							</div>
						</div>
			
						<div class="image-content">
							<img alt="text"
								src="/resources/templates/generic/img/banner-resized.jpg" />
						</div>
					</article>
				</section>
				<p>&nbsp;</p>
				<h2>特色品种</h2>
			</div>
			<!-- slider-area-end -->
			
			
			<!-- home page - top category CUSTOM CONTENT in home page -->
			<div class="service-area pt-80">
				<div class="container">
					<p>
						<!-- 自定义特色品种 -->
					</p>
				</div>
			</div>
			
			
			
			<!-- Using ajax -->
			<!-- featured items -->
			<section class="products-grid">
				<div class="container">
					<div id="featuredItemsContainer" class="row products-container"></div>
				</div>
			</section>
			
			
			
			<!-- PUT BACK LATEST BLOGS -->
			
			
			
			<!-- signup box -->
			<!-- purchase-progress-area-end -->
			<!-- contact-area-start -->
			<!--
					<div class="contact-area ptb-40">
						<div class="container">
							<div class="row">
								<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mar_b-30">
									<div class="contuct-info text-center">
										<h4>Sign up for news & offers!</h4>
										<p>You may safely unsubscribe at any time</p>
									</div>
								</div>
								<div class="col-lg-6 col-md-8 col-sm-12 col-lg-offset-1 col-xs-12">
									<div class="search-box">
										<form action="#">
											<input type="email" placeholder="Enter your email address"/>
											<button><span class="lnr lnr-envelope"></span></button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					-->
			<!-- contact-area-end -->
			
			<!-- load products -->
			<script>
				$(document).ready(function() {
					$('#featuredItemsContainer').LoadingOverlay("show");
					var tpl = $('#productBoxTemplate').text();
					tpl = tpl.replace("COLUMN-SIZE", "3");
					$('#productBoxTemplate').text(tpl);
					//get products
					loadFeaturedItems();
				})
			
				function loadFeaturedItems() {
					$.ajax({
						type : 'GET',
						dataType : "json",
						url : '/product?method=featureds',
						success : function(productList) {
							//set in slider
							var productsTemplate = Hogan.compile(document
									.getElementById("productBoxTemplate").innerHTML);
			
							var productsRendred = productsTemplate.render(productList);
							$('#featuredItemsContainer').append(productsRendred);
							$('#featuredItemsContainer').LoadingOverlay("hide", true);
							//call init bindings
							initBindings();
							setProductRating(productList.pageData);
						},
						error : function(jqXHR, textStatus, errorThrown) {
							$(divProductsContainer).hideLoading();
							alert('Error ' + jqXHR + "-" + textStatus + "-" + errorThrown);
						}
					});
				}
			</script>
			<!--- END -->
		
	
	<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />

 	</body>
 
 </html>


