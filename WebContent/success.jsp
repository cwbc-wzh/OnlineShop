<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>付款成功页面</title>
<link rel="stylesheet"  type="text/css" href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.css"/>
<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
<link href="http://localhost:8080/OnlineShop/basic/css/demo.css" rel="stylesheet" type="text/css" />

<link href="http://localhost:8080/OnlineShop/css/sustyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://localhost:8080/OnlineShop/basic/js/jquery-1.7.min.js"></script>
</head>
<body>
	
<!--顶部导航条 -->
<div class="am-container header">
  <ul class="message-l">
    <div class="topMessage">
     <div class="menu-hd">
       <c:choose>
			<c:when test="${!empty sessionScope.User.username}">  
				欢迎您！${sessionScope.User.username }
				&nbsp;&nbsp;
				<a href="shangpinServlet?method=zhuxiao" target="_top">注销</a>
			</c:when>
			<c:otherwise> 
				<a href="Login.jsp" target="_top" class="h">登录 </a>
				&nbsp;
				<a href="register.jsp" target="_top">注册</a>
			</c:otherwise>
		</c:choose>
     </div></div>
  </ul>
  <ul class="message-r">
    			<div class="topMessage home">
						<div class="menu-hd"><a href="#" target="_top" class="h">商城首页</a></div>
					</div>
					<div class="topMessage my-shangcheng">
						<div class="menu-hd MyShangcheng"><a href="shangpinServlet?method=lookdingdan" target="_top">订单</a></div>
					</div>
					<div class="topMessage mini-cart">
						<div class="menu-hd"><a id="mc-menu-hd" href="shangpinServlet?method=forwardPage&page=cart" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span></a></div>
					</div>
					<div class="topMessage favorite">
					<c:if test= "${sessionScope.User.username =='admin'}">
						<div class="menu-hd"><a href="index6.jsp" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>管理</span></a></div>
					</c:if>
  </ul>
</div>

<!--悬浮搜索框-->

<div class="nav white">
	<div class="logo"><img src="http://localhost:8080/OnlineShop/images/logo.png" /></div>
    <div class="logoBig">
      <li><img src="http://localhost:8080/OnlineShop/images/logobig.png" /></li>
    </div>
    
    <div class="search-bar pr">
        <a name="index_none_header_sysc" href="#"></a>       
        <form>
        <input id="searchInput" name="index_none_header_sysc" type="text" placeholder="搜索" autocomplete="off">
        <input id="ai-topsearch" class="submit" value="搜索" index="1" type="submit"></form>
    </div>     
</div>

<div class="clear"></div>



<div class="take-delivery">
 <div class="status">
   <h2>您已成功下单</h2>
   
  </div>
</div>


<div class="footer" >
 <div class="footer-hd">

 </div>
 <div class="footer-bd">
 
 </div>
</div>


</body>
</html>
