<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp" %>  
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
		<title>支付</title>
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

							<h3 class="title">下单</h3>

							<div class="clear"></div>
						
						<div class="login-form">
						  <form action= "shangpinServlet?method=cash" method="post">
							   <div class="user-name">
								    <label for="user"><i class="am-icon-user"></i></label>
								    <input input type="text" name="username" placeholder="手机号">
                 			   </div>
                 			    <div class="user-name">
								    <label for="user"><i class="am-icon-user"></i></label>
								    <input input type="text" name="address" placeholder="地址">
                 			    </div>
                 <div class="user-pass">
								    <label for="password"><i class="am-icon-lock"></i></label>
								    <input input type="password" name="accountId" id="password" placeholder="请输入密码">
                 </div>
                 <div class="am-cf">
									<input type="submit" name="" value="下 单" class="am-btn am-btn-primary am-btn-sm">
				 </div>
              </form>
              <c:if test="${requestScope.errors != null }">
              		<script type="text/javascript">
              			var a = "${requestScope.errors}";
              			alert(a);
              		</script>
			  </c:if>
           </div>
            
            <div class="login-links">
                <label for="remember-me"><input id="remember-me" type="checkbox">记住密码</label>
								
							
				<br />
            </div>
								
						

				</div>
			</div>
		</div>


					<div class="footer ">
						
						
					</div>
	</body>

</html>	
	
	
	
	
	
	
	
	
	
	
	
<!-- 
	
	<center>
		<br><br>
		您一共买了 ${sessionScope.ShoppingCart.bookNumber } 本书
		<br>
		应付: ￥ ${ sessionScope.ShoppingCart.totalMoney}
	
		<br><br>
		
		<c:if test="${requestScope.errors != null }">
			<font color="red">${requestScope.errors }</font>
		</c:if>
		
		<form action="shangpinServlet?method=cash" method="post">
		
			<table cellpadding="10"> 
				<tr>
					<td>信用卡姓名:</td>
					<td><input type="text" name="username"/></td>
				</tr>
				<tr>
					<td>信用卡账号:</td>
					<td><input type="text" name="accountId"/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="Submit"/></td>
				</tr>
			</table>
		
		</form>
		
	</center>
	
</body>
</html> -->