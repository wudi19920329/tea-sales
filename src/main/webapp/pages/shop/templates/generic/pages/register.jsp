
<%
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link href="<c:url value="/resources/citydata/css/city-picker.css" />"
	rel="stylesheet">

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>


<!-- requires functions.jsp -->
<script type="text/javascript"
	src="<c:url value="/resources/js/jQuery.validate.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/citydata/js/city-picker.data.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/citydata/js/city-picker.js" />"></script>


<script type="text/javascript">


$(document).ready(function() {
	//城市信息
    var $citypicker3 = $('#address');
    $('#reset').click(function () {
        $citypicker3.citypicker('reset');
    });
    $('#destroy').click(function () {
        $citypicker3.citypicker('destroy');
        $("#address").blur().attr("readonly",true);
    });

	
	
	// 手机号码验证
    jQuery.validator.addMethod("isPhone", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请正确填写您的手机号码。");
 	// 地址
    jQuery.validator.addMethod("address", function(value, element) {
    	if($("#address").attr("readonly")){
    		return true;
    	}
        return false;
    }, "请确认地址。");
	//邮箱
	jQuery.validator.addMethod("isEmail",function(value,element,params){  
        var isEmail = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;  
        return this.optional(element)||(isEmail.test(value));  
    },"*请输入正确的邮箱。");  
	
	// 匹配密码，以字母开头，长度在6-12之间，必须包含数字和特殊字符。
    jQuery.validator.addMethod("isPwd", function(value, element) {
        var str = value;
        if (str.length < 6 || str.length > 18)
            return false;
        if (!/^[a-zA-Z]/.test(str))
            return false;
        if (!/[0-9]/.test(str))
            return fasle;
        return this.optional(element) || /[^A-Za-z0-9]/.test(str);
    }, "以字母开头，长度在6-12之间，必须包含数字和特殊字符。");	
	
	
   var validate = $("#registrationForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
        	realName :{
        		required:true
        	},
        	phone :{
        		required:true,
        		isPhone:true
        	},
        	address :{
        		required:true,
        		address:true
        	},
        	email : {
                required : true,
                isEmail:"*请输入正确的邮箱。", 
            },
            password : {
                required : true,
                isPwd : true
            },
            confirmPassword : {
                required : true,
                isPwd : true,
                equalTo : "#password"
            } 
        },
        messages : {
        	realName : {
        		required:"请输入姓名。"
        	},
        	phone : {
        		required:"请输入手机号。"
        	},
        	address : {
        		required:"请选择地址。"
        	},
            email : {
                required : "请输入Email地址。",
                email:"*请输入正确的邮箱。"
            },
            password : {
                required : "请输入密码。",
                minlength : jQuery.format("密码不能小于{0}个字符。")
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

   $("#subBtn").click(function(){
 		if(validate.form()){
 			var params = {
			   		realName:$("#realName").val(),
			   		address:$("#address").val(),
			   		phone:$("#phone").val(),
			   		email:$("#email").val(),
			   		password:$("#password").val(),
			   		confirmPassword:$("#confirmPassword").val()
			   }
		   $.ajax({
			   	data:params,
				type : 'POST',
				dataType : "json",
				url : '/register?method=submit',
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
					alert(jqXHR.responseJSON.message);
				}
			});
 		}
		   
	   
   })
   
   
 
	
});


 


 
 
 </script>

<c:set var="register_url"
	value="${pageContext.request.contextPath}/shop/customer/register.html" />
<div id="registrationError" class="alert alert-warning common-row"
	style="display: none;"></div>


<!-- page-title-wrapper-end -->
<!-- contuct-form-area-start -->
<div class="login-area ptb-80">
	<div class="container">
		<div class="row">
			<div class=" col-lg-6 col-md-6 col-sm-8  col-xs-12">
				<div class="login-title">
					<h3>个人信息</h3>
				</div>
				<div class="login-form">
					<form method="post" action="#" id="registrationForm"
						class="form-signin required-validate">
						<div class="form-group login-page">
							<label for="realName">姓名 <span>*</span></label> <input
								name="realName" id="realName"
								class="span8 required form-control form-control-md" />
						</div>
						<div class="form-group login-page">
							<label for="phone">手机号 <span>*</span></label> <input name="phone"
								id="phone" class="span8 required form-control form-control-md" />
						</div>

						<!-- 城市信息start -->
						<div class="form-group login-page">
							<label for="address">居住地址 <span>*</span></label>
							<div style="position: relative;">
								<input id="address" name="address" class="form-control" 
									type="text" data-toggle="city-picker">
							</div><!-- readonly -->
						</div>
						<div class="form-group">
							<button class="btn btn-warning" id="reset" type="button">重置</button>
							<button class="btn btn-danger" id="destroy" type="button">确定</button>
						</div>
						<!-- 城市信息end -->

						<div class="login-title">
							<h3>登陆信息</h3>
						</div>
						<div class="form-group login-page">
							<label for="email">邮箱地址 <span>*</span></label> <input
								name="email" id="email"
								class="span8 required email form-control form-control-md" />
						</div>
						<div class="form-group login-page">
							<label for="password">密码<span>*</span></label> <input
								type="password" name="password" id="password"
								class="span8 required password form-control form-control-md" />
						</div>
						<div class="form-group login-page">
							<label for="confirmPassword">确认密码<span>*</span></label> <input
								type="password" name="confirmPassword" id="confirmPassword"
								class="span8 required checkPassword form-control form-control-md" />
						</div>
						<button type="button" id="subBtn"
							class="btn btn-default login-btn">创建账户</button>
					</form>
				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-4 hidden-xs">
				<h3 class="short_headline">
					<span>为什么注册</span>
				</h3>
				<p>简化结算流程通过你的信息,再订购一个项目从一个产品链接</p>

			</div>
		</div>
	</div>
</div>
<!-- contuct-form-area-end -->



