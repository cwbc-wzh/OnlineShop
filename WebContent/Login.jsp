<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head lang="en">
		<meta charset="UTF-8">
		<title>登录</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no">
		<meta name="renderer" content="webkit">
		<meta http-equiv="Cache-Control" content="no-siteapp" />

		<link rel="stylesheet" href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.css" />
		<link href="http://localhost:8080/OnlineShop/css/dlstyle.css" rel="stylesheet" type="text/css">
	</head>

	<body>

		<div class="login-boxtitle">
			<a href="home.html"><img alt="logo" src="http://localhost:8080/OnlineShop/images/logobig.png" /></a>
		</div>

		<div class="login-banner">
			<div class="login-main">
				<div class="login-banner-bg"><span></span><img src="http://localhost:8080/OnlineShop/images/big.jpg" /></div>
				<div class="login-box">

							<h3 class="title">登录商城</h3>

							<div class="clear"></div>
						
						<div class="login-form">
						  <form action ="shangpinServlet" mothod = "post">
							   <input type="hidden" name="method" value="Login">
							   <div class="user-name">
								    <label for="user"><i class="am-icon-user"></i></label>
								    <input type="text" name="username" id="user" placeholder="手机号">
				                 </div>
				                 <div class="user-pass">
									<label for="password"><i class="am-icon-lock"></i></label>
									<input type="password" name="accountId" id="accountId" placeholder="请输入密码">
				                 </div>
				                 <div class="am-cf">
									<input type="submit" name="" value="登 录" class="am-btn am-btn-primary am-btn-sm">
								</div>
              			  </form>
              			  
              			  <c:if test="${!empty requestScope.errors}">
		              		<script type="text/javascript">
		              			var a = "${requestScope.errors}";
		              			alert(a);
		              		</script>
			 			 </c:if>
         			    </div>
            
            <div class="login-links">
                
								<a href="register.jsp" class="zcnext am-fr am-btn-default">注册</a>
								<br />
            </div>
							

				</div>
			</div>
		</div>


					
					
	</body>

</html>