
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
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="expires" content="0">
		<title>商城后台</title>
		<style type=text/css>
#logon {
	margin: 0px auto;
	width: 550px
}

#login-box {
	width: 333px;
	height: 352px;
	padding: 58px 76px 0 76px;
	color: #ebebeb;
	font: 12px Arial, Helvetica, sans-serif;
	background:
		url('<c:url value="/resources/img/admin/login-box-backg.png" />')
		no-repeat left top;
}

#login-box h2 {
	padding: 0;
	margin: 0;
	color: #ebebeb;
	font: bold 36px "Calibri", Arial;
	border-bottom: 2px solid;
	padding-bottom: 0px;
}

#login-box {
	margin-left: 30px;
}

#controls {
	margin-left: -50px;
	margin-top: 30px;
}
</style>
		<link
			href="<c:url value="/resources/css/bootstrap/css/sm-bootstrap.css" />"
			rel="stylesheet" />
		<link href="<c:url value="/resources/css/shopizer-admin.css" />"
			rel="stylesheet" />
		<style type=text/css>
.sm label {
	color: #EBEBEB;
	font-size: 16px;
}

.sm a {
	color: #EBEBEB;
	font-size: 16px;
}
</style>
		<script src="<c:url value="/resources/js/bootstrap/jquery.js" />"></script>
		<script src="<c:url value="/resources/js/bootstrap/bootstrap-modal.js" />"></script>
		<script language="javascript">
			$(document).ready(function() {
				$('#formSubmitButton').click(function() {
					var params = {
						userName:$("#userName").val(),
						password:$("#password").val(),
						method:"logon"
					}
					$.ajax({
						type : 'POST',
						dataType : "json",
						data:params,
						url : '/user',
						success : function(data) {
							window.location.href = "admin_index.jsp";
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert($.parseJSON(jqXHR.responseText).message);
						}
					});
				});
			});
		</script>
</head>

<body>
	<div id="tabbable" class="sm">
		<br/><br />
		<div id="logon">
			<div id="login-box">
				<div class="row">
					<div style="float: left; width: 180px;">
						<p class="lead">登陆</p>
					</div>
					<div style="float: right;">
						<img alt="go to www.shopizer.com"
							src="<c:url value="/resources/img/shopizer_small.png" />" />
					</div>
				</div>

				<div class="row">
					<div id="controls">
						<form  class="form-horizontal" action="#">
							<div class="control-group">
								<label class="control-label" for="inputUser"> 用户名 </label>
								<div class="controls">
									<input type="text" id="userName" name="userName" placeholder="用户名" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputPassword"> 密码</label>
								<div class="controls">
									<input type="password" id="password" name="password" placeholder="密码" />
								</div>
							</div>
							<div class="control-group">
								<div class="controls">
									<a href="javascript:void(0)" class="btn" id="formSubmitButton">登陆</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>