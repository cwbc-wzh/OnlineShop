<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>首页</title>
<!-- 这样就是绝对路径，就是导入项目下 的AmazeUI-2.4.2/assets/css/amazeui.css文件，根据想要导入的文件写路径 -->
<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css" />
<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css" />

<link href="http://localhost:8080/OnlineShop/basic/css/demo.css" rel="stylesheet" type="text/css" />

<link href="http://localhost:8080/OnlineShop/css/hmstyle.css" rel="stylesheet" type="text/css" />
<script src="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
<script src="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/js/amazeui.min.js"></script>

</head>
<body>
<div class="hmtop">
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
						<form action ="shangpinServlet" mothod = "post">
						   <input type="hidden" name="method" value="search">
						   	  <input id="searchInput" name="name" type="text" placeholder="搜索" autocomplete="off">
							  <input id="ai-topsearch" class="submit am-btn" value="搜索" index="1" type="submit">
	              		</form>
					</div>
				</div>

				<div class="clear"></div>
			</div>
             <b class="line"></b>
			<div class="shopNav">
				<div class="slideall" style="height: auto;">
			        
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
                
			    <div class="bannerTwo">
                      <!--轮播 -->
						<div class="am-slider am-slider-default scoll" data-am-flexslider id="demo-slider-0">
							<ul class="am-slides">
								<li class="banner1"><a href="introduction.html"><img src="http://localhost:8080/OnlineShop/images/ad5.jpg" /></a></li>
								<li class="banner2"><a><img src="images/ad6.jpg" /></a></li>
								<li class="banner3"><a><img src="images/ad7.jpg" /></a></li>
								<li class="banner4"><a><img src="images/ad8.jpg" /></a></li>
							</ul>
						</div>
						<div class="clear"></div>	
			    </div>

						<!--侧边导航 -->
						<div id="nav" class="navfull" style="position: static;">
							<div class="area clearfix">
								<div class="category-content" id="guide_2">
									
									<div class="category" style="box-shadow:none ;margin-top: 2px;">
										<ul class="category-list navTwo" id="js_climit_li">





					
											
                                 <!--比较多的导航	-->										
											<li >
												<div class="category-info">
													<h3 class="category-name b-category-name"><i><img src="http://localhost:8080/OnlineShop/images/cookies.png"></i><a class="ml-22" title="饼干、膨化"><a title="蒸蛋糕" href="index.jsp"><span>手机</span></a></a></h3>
					
                                             <b class="arrow"></b>
											</li>
											<li >
												<div class="category-info">
													<h3 class="category-name b-category-name"><i><img src="http://localhost:8080/OnlineShop/images/meat.png"></i><a class="ml-22" title="熟食、肉类"><a title="蒸蛋糕" href="index1.jsp"><span>家具</span></a></a></h3>
											
                                            <b class="arrow"></b>
											</li>
											<li >
												<div class="category-info">
													<h3 class="category-name b-category-name"><i><img src="http://localhost:8080/OnlineShop/images/bamboo.png"></i><a class="ml-22" title="素食、卤味"><a title="蒸蛋糕" href="index2.jsp"><span>甜点</span></a></a></h3>
												
                                             <b class="arrow"></b>
											</li>
											<li>
												<div class="category-info">
													<h3 class="category-name b-category-name"><i><img src="http://localhost:8080/OnlineShop/images/nut.png"></i><a class="ml-22" title="坚果、炒货"><a title="蒸蛋糕" href="index3.jsp"><span>水果</span></a></a></h3>
												
												<b class="arrow"></b>
											</li>											
															<li >
												<div class="category-info">
													<h3 class="category-name b-category-name"><i><img src="http://localhost:8080/OnlineShop/images/candy.png"></i><a class="ml-22" title="糖果、蜜饯"><a title="蒸蛋糕" href="index4.jsp"><span>电器</span></a></a></h3>
											
                                            <b class="arrow"></b>
											</li>
											<li >
												<div class="category-info">
													<h3 class="category-name b-category-name"><i><img src="http://localhost:8080/OnlineShop/images/chocolate.png"></i><a class="ml-22" title="巧克力"><a title="蒸蛋糕" href="index5.jsp"><span>服装</span></a></a></h3>
												
												<b class="arrow"></b>
											</li>
										
										</ul>
									</div>
								</div>

							</div>
						</div>
						<!--导航 -->
						<script type="text/javascript">
							(function() {
								$('.am-slider').flexslider();
							});
							$(document).ready(function() {
								$("li").hover(function() {
									$(".category-content .category-list li.first .menu-in").css("display", "none");
									$(".category-content .category-list li.first").removeClass("hover");
									$(this).addClass("hover");
									$(this).children("div.menu-in").css("display", "block")
								}, function() {
									$(this).removeClass("hover")
									$(this).children("div.menu-in").css("display", "none")
								});
							})
						</script>


					<!--小导航 -->
					<div class="am-g am-g-fixed smallnav">
						<div class="am-u-sm-3">
							<a href="sort.html"><img src="http://localhost:8080/OnlineShop/images/navsmall.jpg" />
								<div class="title">商品分类</div>
							</a>
						</div>
						<div class="am-u-sm-3">
							<a href="#"><img src="http://localhost:8080/OnlineShop/images/huismall.jpg" />
								<div class="title">大聚惠</div>
							</a>
						</div>
						<div class="am-u-sm-3">
							<a href="#"><img src="http://localhost:8080/OnlineShop/images/mansmall.jpg" />
								<div class="title">个人中心</div>
							</a>
						</div>
						<div class="am-u-sm-3">
							<a href="#"><img src="http://localhost:8080/OnlineShop/images/moneysmall.jpg" />
								<div class="title">投资理财</div>
							</a>
						</div>
					</div>

					
				<!--各类活动-->

				<div class="clear"></div>	
					<!--走马灯 -->

					<div class="marqueenTwo">
						<span class="marqueen-title"><i class="am-icon-volume-up am-icon-fw"></i>商城头条<em class="am-icon-angle-double-right"></em></span>
						<div class="demo">

							<ul>
								<li class="title-first"><a target="_blank" href="#">
									<img src="http://localhost:8080/OnlineShop/images/TJ2.jpg"></img>
									<span>[特惠]</span>洋河年末大促，低至两件五折							
								</a></li>
								<li class="title-first"><a target="_blank" href="#">
									<span>[公告]</span>商城与广州市签署战略合作协议
								     <img src="http://localhost:8080/OnlineShop/images/TJ.jpg"></img>
								     <p>XXXXXXXXXXXXXXXXXX</p>
							    </a></li>																    							    
								<li><a target="_blank" href="#"><span>[特惠]</span>女生节商城爆品1分秒	</a></li>
								<li><a target="_blank" href="#"><span>[公告]</span>华北、华中部分地区配送延迟</a></li>
								<li><a target="_blank" href="#"><span>[特惠]</span>家电狂欢千亿礼券 买1送1！</a></li>
								<li><a target="_blank" href="#"><span>[特惠]</span>洋河年末大促，低至两件五折</a></li>
								<li><a target="_blank" href="#"><span>[公告]</span>华北、华中部分地区配送延迟</a></li>
						
							</ul>
                       
						</div>
					</div>
					<div class="clear"></div>
				
				</div>
				
				
							
				<script type="text/javascript">
					if ($(window).width() < 640) {
						function autoScroll(obj) {
							$(obj).find("ul").animate({
								marginTop: "-39px"
							}, 500, function() {
								$(this).css({
									marginTop: "0px"
								}).find("li:first").appendTo(this);
							})
						}
						$(function() {
							setInterval('autoScroll(".demo")', 3000);
						})
					}
				</script>
			</div>


		<script>
			window.jQuery || document.write('<script src="basic/js/jquery.min.js "><\/script>');
		</script>
		<script type="text/javascript " src="basic/js/quick_links.js "></script>
	</body>


</html>