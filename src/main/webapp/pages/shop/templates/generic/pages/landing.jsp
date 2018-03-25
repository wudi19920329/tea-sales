
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
		$
				.ajax({
					type : 'GET',
					dataType : "json",
					url : '/featuredGoods?method=randomDisplay',
					success : function(productList) {
						//set in slider
						var productsTemplate = Hogan
								.compile(document
										.getElementById("productBoxTemplate").innerHTML);
						 
						var productsRendred = productsTemplate
								.render(productList);
						$('#featuredItemsContainer').append(productsRendred);
						$('#featuredItemsContainer').LoadingOverlay("hide",
								true);
						//call init bindings
						initBindings();
						setProductRating(productList.products);
					},
					error : function(jqXHR, textStatus, errorThrown) {
						$(divProductsContainer).hideLoading();
						alert('Error ' + jqXHR + "-" + textStatus + "-"
								+ errorThrown);
					}
				});
	} 
</script>
<!--- END -->
