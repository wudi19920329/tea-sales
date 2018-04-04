
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
<script type="text/javascript" src="<c:url value="/resources/js/jQuery.validate.js" />"></script>

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

</head>

<body>

	<!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->

	<jsp:include page="/pages/shop/templates/generic/sections/header.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/navbar.jsp" />
	
	
	

	<div id="main-content" class="container clearfix row-fluid">
		<div class="span12 col-md-12 no-padding common-row">
	
			<div class="span8 col-md-8 no-padding">
				<div class="checkout-box">
					<span class="box-title">
						<p class="p-title">修改密码</p>
					</span>
					<form method="post" action="#" id="changePasswordForm" >
						
						<div class="control-group form-group">
							<label class="required control-label">当前密码</label>
							<input name="password" id="password" class="span8 required form-control form-control-md" />
						</div>
						<div class="control-group form-group">
							<label class="required control-label">新密码</label>
							<input name="newPassword" id="newPassword" class="span8 required form-control form-control-md" />
						</div>
						<div class="control-group form-group">
							<label class="required control-label">确认密码</label>
							<input name="confirmPassword" id="confirmPassword" class="span8 required form-control form-control-md" />
						</div>
	
						<div class="form-actions">
							<input id="submitChangePassword"
								class="btn btn-large btn-disabled template-btn" type="button"
								name="changePassword" value="修改密码"/>
						</div>
					</form>
	
	
				</div>
			</div>
			<div class="span4 col-md-4">
				<jsp:include page="customerProfileMenu.jsp" />
				<jsp:include page="customerOrdersMenu.jsp" />
			</div>
		</div>
		<!--close .span12-->
	</div>
	<!--close .container "main-content" -->
	

	<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />
	
	<script>
	$(document).ready(function() {
		// 匹配密码
	    jQuery.validator.addMethod("isPwd", function(value, element) {
	        var str = value;
	        return this.optional(element) || /^\d{6}$/.test(str);
	    }, "密码为6位数字。");	
		var validate = $("#changePasswordForm").validate({
	        errorElement : 'span',
	        errorClass : 'help-block',
	        rules : {
	        	password :{
	        		required:true,
	        		 minlength : 6
	        	},
	        	newPassword :{
	        		required:true,
	        		minlength : 6
	        	},
	            confirmPassword : {
	                required : true,
	                isPwd : true,
	                equalTo : "#newPassword"
	            } 
	        },
	        messages : {
	        	password : {
	                required : "请输入旧密码。",
	                minlength : "旧密码不能小于6个字符。"
	            },
	            newPassword : {
	                required : "请输入新密码。",
	                minlength : "新密码不能小于6个字符。"
	            },
	            confirmPassword : {
	                required : "请输入确认密码。",
	                minlength : "确认密码不能小于5个字符。",
	                equalTo : "两次输入密码不一致不一致。"
	            } 
	        },
	        //自定义错误消息放到哪里
	        errorPlacement : function(error, element) {
	            element.removeClass("valid");
	            element.closest('.form-group').append(error);//显示错误消息提示
	        },
	        //给未通过验证的元素进行处理
	        highlight : function(element) {
	            $(element).closest('.form-group').addClass('has-error has-feedback');
	        },
	        //验证通过的处理
	        success : function(label) {
	            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
	            label.remove();
	        },
	    });
		
		$("#submitChangePassword").click(function(){
	 		if(validate.form()){
	 			var params = {
 					password:$("#password").val(),
			   		newPassword:$("#newPassword").val(),
			   		confirmPassword:$("#confirmPassword").val(),
			   		method:"changePassword"
			  }
			   $.ajax({
				   	data:params,
					type : 'POST',
					dataType : "json",
					url : '/customer',
					success : function(data) {
						alert("修改成功！");
						window.location.href = "dashboard.jsp";
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert(jqXHR.responseJSON.message);
					}
				});
	 		}
			   
		   
	   })
	})
		
	
	
	</script>
	
</body>

</html>
 
 