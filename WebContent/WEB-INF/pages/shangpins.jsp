
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<title>搜索页面</title>

		<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css" />
		<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css" />

		<link href="http://localhost:8080/OnlineShop/basic/css/demo.css" rel="stylesheet" type="text/css" />

		<link href="http://localhost:8080/OnlineShop/css/seastyle.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="http://localhost:8080/OnlineShop/basic/js/jquery-1.7.min.js"></script>
		<script type="text/javascript" src="http://localhost:8080/OnlineShop/js/script.js"></script>
	</head>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		
		$("#pageNo").change(function(){
			var val = $(this).val();
			val = $.trim(val);
			
			//1. 校验 val 是否为数字 1, 2, 而不是 a12, b
			var flag = false;
			var reg = /^\d+$/g;
			var pageNo = 0;
			
			if(reg.test(val)){
				//2. 校验 val 在一个合法的范围内： 1-totalPageNumber
				pageNo = parseInt(val);
				if(pageNo >= 1 && pageNo <= parseInt("${bookpage.totalPageNumber }")){
					flag = true;
				}
			}
			
			
			if(!flag){
				alert("输入的不是合法的页码.");
				$(this).val("");
				return;
			}
			
			//3. 页面跳转
			var href = "shangpinServlet?method=getBooks&pageNo=" + pageNo + "&" + $(":hidden").serialize();
			window.location.href = href;
		});
	})
	
</script>
<%@ include file="/commons/queryCondition.jsp" %>
</head>
<body>
	
	<center>

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
									<a href="../../Login.jsp" target="_top" class="h">登录 </a>
									&nbsp;
									<a href="../../register.jsp" target="_top">注册</a>
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
						<div class="menu-hd"><a href="../../index6.jsp" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>管理</span></a></div>
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
			<b class="line"></b>
           <div class="search">
			<div class="search-list">
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
						   
						</div>
			</div>
			
				
					<div class="am-g am-g-fixed">
						<div class="am-u-sm-12 am-u-md-12">
	                  	<div class="theme-popover">														
							
							
							<div class="clear"></div>
                        </div>
							<div class="search-content">
								<ul class="am-avg-sm-2 am-avg-md-3 am-avg-lg-4 boxes">
									
								 
										<c:forEach items="${bookpage.list }" var="book">
											<li>
											<div class="i-pic limit">
												<a href="shangpinServlet?method=getBook&kind=${bookpage.kind }&pageNo=${bookpage.pageNo }&id=${book.id}">
												<!-- http://localhost:8080/OnlineShop/ 这个路径是Tomcat编译的项目路径  浏览器访问的都是你Tomcat编译的项目路径 -->
												<img src="http://localhost:8080/OnlineShop/image/shangpin_${book.id}.jpg" />											
												<p class="title fl">${book.title }</p>
												
												</a>
												<p class="price fl">
													${book.price }
													<a href="shangpinServlet?method=addToCart&kind=${bookpage.kind }&pageNo=${bookpage.pageNo }&id=${book.id}&title=${book.title}">加入购物车</a>
												</p>
											</div>
											</li>
										</c:forEach>
								 			
								</ul>
							</div>
							<div class="clear"></div>
							<!--分页 -->
							
							<ul class="am-pagination am-pagination-right">
								共 ${bookpage.totalPageNumber } 页
								&nbsp;&nbsp;
								当前第 ${bookpage.pageNo } 页		
								&nbsp;&nbsp;
								<c:if test="${bookpage.hasPrev }">
									<li class="am-active"><a href="shangpinServlet?method=getBooks&pageNo=1&kind=${bookpage.kind }">首页</a></li>
									<li><a href="shangpinServlet?method=getBooks&pageNo=${bookpage.prevPage }&kind=${bookpage.kind }">上一页</a></li>
								</c:if>
								<c:if test="${bookpage.hasNext }">
									<li><a href="shangpinServlet?method=getBooks&pageNo=${bookpage.nextPage }&kind=${bookpage.kind }">下一页</a></li>
									<li><a href="shangpinServlet?method=getBooks&pageNo=${bookpage.totalPageNumber }&kind=${bookpage.kind }">末页</a></li>
								</c:if>
								转到 <input type="text" size="1" id="pageNo"/> 页
							</ul>
							
						</div>
					</div>
					<div class="footer">
						
					</div>
				</div>

			</div>



		<script>
			window.jQuery || document.write('<script src="basic/js/jquery-1.9.min.js"><\/script>');
		</script>
		<script type="text/javascript" src="http://localhost:8080/OnlineShop/basic/js/quick_links.js"></script>

		<div class="theme-popover-mask"></div>

	</body>

</html>
