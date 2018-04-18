<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp" %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0">

<title>管理中心</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0">

<title>管理中心</title>

<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">

<link href="http://localhost:8080/OnlineShop/css/personal.css" rel="stylesheet" type="text/css">
<link href="http://localhost:8080/OnlineShop/css/infstyle.css" rel="stylesheet" type="text/css">
<script src="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
<script src="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/js/amazeui.js"></script>			

</head>
<body>
<!--头 -->
		<header>
			<article>
				<div class="mt-logo">
					<!--顶部导航条 -->
					<div class="am-container header">
						<ul class="message-l">
							<div class="topMessage">
								<div class="menu-hd">
									<a href="#" target="_top" class="h">登录</a>
									<a href="#" target="_top">注册</a>
								</div>
							</div>
						</ul>
						<ul class="message-r">
							<div class="topMessage home">
								<div class="menu-hd"><a href="#" target="_top" class="h">商城首页</a></div>
							</div>
							<div class="topMessage my-shangcheng">
								<div class="menu-hd MyShangcheng"><a href="#" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a></div>
							</div>
							<div class="topMessage mini-cart">
								<div class="menu-hd"><a id="mc-menu-hd" href="#" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
							</div>
							<div class="topMessage favorite">
								<div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>管理</span></a></div>
						</ul>
						</div>

						<!--悬浮搜索框-->

						<div class="nav white">
							<div class="logoBig">
								<li><img src="http://localhost:8080/OnlineShop/images/logobig.png" /></li>
							</div>

							<div class="search-bar pr">
								<a name="index_none_header_sysc" href="#"></a>
								<form>
									<input id="searchInput" name="index_none_header_sysc" type="text" placeholder="搜索" autocomplete="off">
									<input id="ai-topsearch" class="submit am-btn" value="搜索" index="1" type="submit">
								</form>
							</div>
						</div>

						<div class="clear"></div>
					</div>
				</div>
			</article>
		</header>
            <div class="nav-table">
					   <div class="long-title"><span class="all-goods">全部分类</span></div>
					   <div class="nav-cont">
							<ul>
								<li class="index"><a href="#">首页</a></li>
                                <li class="qc"><a href="#">闪购</a></li>
                                <li class="qc"><a href="#">限时抢</a></li>
                                <li class="qc"><a href="#">团购</a></li>
                                <li class="qc last"><a href="#">大包装</a></li>
							</ul>
						    <div class="nav-extra">
						    	<i class="am-icon-user-secret am-icon-md nav-user"></i><b></b>我的福利
						    	<i class="am-icon-angle-right" style="padding-left: 10px;"></i>
						    </div>
						</div>
			</div>
			<b class="line"></b>
		<div class="center">
			<div class="col-main">
				<div class="main-wrap">
					<div class="user-info">
						<!--标题 -->
						<div class="am-cf am-padding">
							<div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">发货</strong> </div>
						</div>
		
						<div class="login-form">
						<script type="text/javascript">
							function validate() {
								id = document.a.id.value;
								
								if(id==""){
									alert("商品名不能为空");
									document.a.id.focus();
									return;
								} 
								document.a.submit();
							}
						</script>
						
						
						
						  <form action ="shangpinServlet" mothod = "post" name="a">
							   <input type="hidden" name="method" value="fahuo">
							   
								  <table>
								  	<li>
								  		<ui>编号：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</ui>
								  		<ui><input type="text" name="id" ></ui>
								  	</li>
								  	 
								  	<input type="submit" name="发货" onclick="validate()">
								  </table>  
              			  </form>
         			    </div>
		
		
						<c:if test="${requestScope.errors != null }">
				              		<script type="text/javascript">
				              			var a = "${requestScope.errors}";
				              			alert(a);
				              		</script>
							 </c:if>
		
						<div class="clear"></div>
							
						</div>
					</div>
			</div>
			
			<aside class="menu">
				<ul>
					<li class="person active">
						<i class="am-icon-user"></i>管理中心
					</li>
					<li class="person">
						<p><i class="am-icon-newspaper-o"></i>商品管理</p>
						<ul>
							<li> <a href="index6.jsp">商品列表</a></li>
							<li> <a href="http://localhost:8080/OnlineShop/home/insertshangpin.jsp">增加商品</a></li>
							<li> <a href="http://localhost:8080/OnlineShop/home/deleteshangpin.jsp">删除商品</a></li>
							<li> <a href="http://localhost:8080/OnlineShop/home/updateshangpin.jsp">修改商品</a></li>
							<li> <a href="http://localhost:8080/OnlineShop/home/insertpicture.jsp">上传图片</a></li>
							<li> <a href="index7.jsp">订单列表</a></li>
							<li> <a href="http://localhost:8080/OnlineShop/home/fahuo.jsp">发货</a></li>
						</ul>
					</li>
					
				</ul>

			</aside>
		</div>

	</body>

</html>