
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

<!-- footer-area-start -->
<div class="footer-area ptb-80">
	<div class="container">
		<div class="row">
			<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mar_b-30">
				<div class="footer-wrapper">
					<ul>
						<address>
							<div itemscope itemtype="http://schema.org/Organization">
								<strong><span itemprop="name">Vintage Bags</span></strong><br />
								<div itemprop="address" itemscope
									itemtype="http://schema.org/PostalAddress">
									<span itemprop="streetAddress">黄河路90号 郑州</span><br /> <span
										itemprop="addressLocality"> <span id="storeZoneName">郑州</span>,
										<span id="storeCountryName">中国</span>
									</span><br /> <span itemprop="postalCode">450000</span><br /> <abbr
										title="Phone">13213140079</abbr>: <span itemprop="telephone">888-888-8888</span>
								</div>
							</div>
						</address>
					</ul>
				</div>
			</div>

			<!--<div class="col-lg-2 col-md-3 hidden-sm col-xs-12 mar_b-30">-->
			<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mar_b-30">
				<div class="footer-wrapper">
					<div class="footer-title">
						<a href="#"><h3>友情链接</h3></a>
					</div>
					<div class="footer-wrapper">
						<ul class="usefull-link">
							<li class="active"><a href="/shop">主页</a></li>
							<c:set var="categorys" value="<%=com.tea.enums.TeaCategory.values()%>"/>
							<c:forEach var="category" items="${categorys}">
								<li><a href="/shop/category/handbags.html/ref=c:1"
								class="current"> <span class="name">${category.getDescription()}</span>
							</a></li>			
							</c:forEach>
							<li class=""><a href="/shop/store/contactus.html">联系我们</a></li>
							<li><a href="/shop/customer/registration.html">注册</a></li>
							<li><a href="/shop/customer/customLogon.html">登陆</a></li>


						</ul>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
				<div class="footer-wrapper"></div>
			</div>
		</div>
	</div>
</div>
<!-- footer-area-end -->

<!-- .copyright-area-start -->
<div class="copyright-area">
	<div class="container">
		<div class="row">
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 mar_b-30">
				<div class="copyright text-left">
					<p>
						© Vintage Bags 2017-2018&nbsp;-&nbsp;Powered by <a
							href="http://www.shopizer.com" class="footer-href"
							target="_blank">Shopizer</a>
					</p>
				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

				<div class="copyright-img text-right">
					<img src="/resources/img/payment/icons/MasterCard.png" width="50"
						alt="">&nbsp;<img
						src="/resources/img/payment/icons/Visa.png" width="50" alt="">&nbsp;<img
						src="/resources/img/payment/icons/AmericanExpress.png" width="50"
						alt="">&nbsp;<img
						src="/resources/img/payment/icons/PayPal.png" width="50" alt="">
				</div>

			</div>
		</div>
	</div>
</div>
<!-- .copyright-area-end -->