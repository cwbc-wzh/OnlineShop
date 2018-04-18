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

<title>订单管理</title>

<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">

<link href="http://localhost:8080/OnlineShop/css/personal.css" rel="stylesheet" type="text/css">
<link href="http://localhost:8080/OnlineShop/css/orstyle.css" rel="stylesheet" type="text/css">

<script src="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
<script src="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/js/amazeui.js"></script>

</head>
<body>
<header>
			<article>
				<div class="mt-logo">
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
								</div>
							</div>
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
								<div class="menu-hd"><a href="/OnlineShop/index6.jsp" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>管理</span></a></div>
							</c:if>
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
			
		<c:choose>
				<c:when test="${!empty sessionScope.User.username}">  
							<div class="center">
			<div class="col-main">
				<div class="main-wrap">

					<div class="user-order">

						<!--标题 -->
						<div class="am-cf am-padding">
							<div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">亲爱的${user.username}, 您的订单如下：</strong></div>
						</div>
						<hr/>

						<div class="am-tabs am-tabs-d2 am-margin" data-am-tabs>

						

							<div class="am-tabs-bd">
								<div class="am-tab-panel am-fade am-in am-active" id="tab1">
									<div class="order-top">
										<div class="th th-item">
											<td class="td-inner">商品</td>
										</div>
										<div class="th th-price">
											<td class="td-inner">单价</td>
										</div>
										<div class="th th-number">
											<td class="td-inner">数量</td>
										</div>


									</div>

									<div class="order-main">
										<div class="order-list">

										
										
										
										
										
											
									<c:forEach items="${user.trades }" var="trade">				
										
											<div class="order-status3">
												<div class="order-title">
													<div class="dd-num">订单编号：${trade.tradeId }</div>
													<div class="dd-num"><span>成交时间：${trade.tradeTime }</span></div>
													<div class="dd-num">	
														交易状态：
														<c:if test="${trade.tradeState == 0 }">
															<span>已下单</span>
														</c:if>
														<c:if test="${trade.tradeState == 1 }">
															<span>已发货</span>
														</c:if>
													</div>
												</div>
											<c:forEach items="${trade.items }" var="item">
												<div class="order-content">
													<div class="order-left">
														<ul class="item-list">
															<li class="td td-item">
																
																<div class="item-info">
																	<div class="item-basic-info">
																		${item.book.title }
																	</div>
																</div>
															</li>
															<li class="td td-price">
																<div class="item-price">
																	${item.book.price }
																</div>
															</li>
															<li class="td td-number">
																<div class="item-number">
																	<span>×</span>${item.quantity }
																</div>
															</li>
															<li class="td td-operation">
																
															</li>
														</ul>
													</div>
													
												</div>

											</div>
										</c:forEach>		
										
										<br><br><br><br><br><br><br><br>
										
						</c:forEach>					
											
											
											
											
											
											
											
											
											
											
											
											
										</div>

									</div>

								</div>
							
								
								

							
											
											
							
													
												</div>
											</div>


										</div>

									</div>

								</div>
							</div>
					
				</c:when>
				<c:otherwise> 
				<div class="center">
				<div class="col-main">
					<div class="main-wrap">
	
						<div class="user-order">
	
							<!--标题 -->
							<div class="am-cf am-padding">
								<div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">您还没有登录，请点击
					<a href="Login.jsp" target="_top" class="h">登录 </a></strong></div>
							</div>
					</div>
					</div>
					</div>
					</div>
					
				</c:otherwise>
			</c:choose>

			












						</div>
					</div>
				</div>
				<!--底部-->
				
			</div>

		</div>

	</body>

</html>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<!-- 
	
	
	
	<center>
		<br><br>
		<h4>User: ${user.username }</h4>
		
		<br><br>
			<table>
				<c:forEach items="${user.trades }" var="trade">
					
					<tr>
					<td>
					<table border="1" cellpadding="10" cellspacing="0">
					
						<tr>
							<td colspan="3">TradTime: ${trade.tradeTime }</td>
						</tr>
						
						<tr>
							<td colspan="3">State: 
							<c:if test="${trade.tradeState == 0 }">
								<span>已下单</span>
							</c:if>
							<c:if test="${trade.tradeState == 1 }">
								<span>已发货</span>
							</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="3">id: ${trade.tradeId }</td>
						</tr>
						<c:forEach items="${trade.items }" var="item">
							
							<tr>
								<td>${item.book.title }</td>
								<td>${item.book.price }</td>
								<td>${item.quantity }</td>
							</tr>
							
						</c:forEach>
						
					</table>
					<br><br>
					</td>
					</tr>
					
				</c:forEach>
			</table>
		
	</center>
	
</body>
</html>
 -->