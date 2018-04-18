<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp" %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
		<title>注册</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no">
		<meta name="renderer" content="webkit">
		<meta http-equiv="Cache-Control" content="no-siteapp" />

		<link rel="stylesheet" href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.min.css" />
		<link href="http://localhost:8080/OnlineShop/css/dlstyle.css" rel="stylesheet" type="text/css">
		
</head>
<body>
	
	
<div class="login-boxtitle">
			<a href="home/demo.html"><img alt="" src="http://localhost:8080/OnlineShop/images/logobig.png" /></a>
		</div>

		<div class="res-banner">
			<div class="res-main">
				<div class="login-banner-bg"><span></span><img src="http://localhost:8080/OnlineShop/images/big.jpg" /></div>
				<div class="login-box">

						<div class="am-tabs" id="doc-my-tabs">
							<ul class="am-tabs-nav am-nav am-nav-tabs am-nav-justify">
								<li class="am-active"><a href="">注册</a></li>
							</ul>

							<div class="am-tabs-bd">
								<div class="am-tab-panel am-active">
									<form method="post" action="shangpinServlet">
										<input type="hidden" name="method" value="register">
										   <div class="user-email">
													<label for="email"><i class="am-icon-envelope-o"></i></label>
													<input type="input" name="username" id="email" placeholder="请输入手机号">
											</div>										
											 <div class="user-pass">
													<label for="password"><i class="am-icon-lock"></i></label>
													<input type="password" name="password" id="password" placeholder="设置密码">
											 </div>										
											
			                 
											<div class="am-cf">
													<input type="submit" name="" value="注册" class="am-btn am-btn-primary am-btn-sm am-fl">
											</div>				
								</form>
								</div>

							</div>
						</div>

				</div>
			</div>	
	</body>

</html>