<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp" %>  
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<title>购物车页面</title>

		<link href="http://localhost:8080/OnlineShop/AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css" />
		<link href="http://localhost:8080/OnlineShop/basic/css/demo.css" rel="stylesheet" type="text/css" />
		<link href="http://localhost:8080/OnlineShop/css/cartstyle.css" rel="stylesheet" type="text/css" />
		<link href="http://localhost:8080/OnlineShop/css/optstyle.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="http://localhost:8080/OnlineShop/js/jquery.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script/jquery-1.7.2.min.js"></script>
<%@ include file="/commons/queryCondition.jsp" %>	
<script type="text/javascript">
	
	$(function(){
		$(".delete").click(function(){
			
			var $tr = $(this).parent().parent();
			var title = $.trim($tr.find("td:first").text());
			var flag = confirm("确定要删除" + title + "的信息吗?");
			
			if(flag){
				return true;
			}
			
			return false;
		});
		
		//ajax 修改单个商品的数量:
		//1. 获取页面中所有的 text, 并为其添加 onchange 响应函数. 弹出确认对话框: 确定要修改吗? 
		$(":text").change(function(){
			var quantityVal = $.trim(this.value);

			var flag = false;
			
			var reg = /^\d+$/g;
			var quantity = -1;
			if(reg.test(quantityVal)){
				quantity = parseInt(quantityVal);
				if(quantity >= 0){
					flag = true;
				}
			}
			
			if(!flag){
				alert("输入的数量不合法!");
				$(this).val($(this).attr("class"));
				return;
			}
			
			var $tr = $(this).parent().parent();
			var title = $.trim($tr.find("td:first").text());

			if(quantity == 0){
				var flag2 = confirm("确定要删除" + title + "吗?");
				if(flag2){
					//得到了 a 节点
					var $a = $tr.find("td:last").find("a");
					//执行 a 节点的 onclick 响应函数. 
					$a[0].onclick();
					
					return;
				}
			}
			
			var flag = confirm("确定要修改" + title + "的数量吗?");
			
			if(!flag){
				$(this).val($(this).attr("class"));
				return;
			}
			//2. 请求地址为: shangpinServlet
			var url = "shangpinServlet";
			
			//3. 请求参数为: method:updateItemQuantity, id:name属性值, quantity:val, time:new Date()
			var idVal = $.trim(this.name);
			var args = {"method":"updateItemQuantity", "id":idVal, "quantity":quantityVal, "time":new Date()};
			
			//4. 在 updateItemQuantity 方法中, 获取 quanity, id, 再获取购物车对象, 调用 service 的方法做修改
			//5. 传回 JSON 数据: bookNumber:xx, totalMoney
			
			//6. 更新当前页面的 bookNumber 和 totalMoney
			$.post(url, args, function(data){
				var bookNumber = data.bookNumber;
				var totalMoney = data.totalMoney;
				
				$("#totalMoney").text("总金额: ￥" + totalMoney);
				$("#bookNumber").text("您的购物车中共有" + bookNumber + "本书");
			},"JSON");
			
		});
				
	})
	
</script>
</head>
<body>

<!--顶部导航条 -->
		<div class="am-container header">
			<ul class="message-l">
				<div class="topMessage">
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

			<!--购物车 -->
			<div class="concent">
				<div id="cartTable">
					<div class="cart-table-th">
						<div class="wp">
							<div class="th th-chk">
								<div id="J_SelectAll1" class="select-all J_SelectAll">
								</div>
							</div>
							<div class="th th-item">
								<div class="td-inner">商品信息</div>
							</div>
							<div class="th th-sum">
								<div class="td-inner">&nbsp&nbsp</div>
							</div>
							<div class="th th-price">
								<div class="td-inner">单价</div>
							</div>
							<div class="th th-amount">
								<div class="td-inner">数量</div>
							</div>

							<div class="th th-op">
								<div class="td-inner">操作</div>
							</div>
						</div>
					</div>
					<div class="clear"></div>

					<tr class="item-list">
						<div class="bundle  bundle-last ">
							<div class="bundle-hd">
								
							</div>
							<div class="clear"></div>
							<div class="bundle-main">
							<c:forEach items="${sessionScope.ShoppingCart.items }" var="item">
								<ul class="item-content clearfix">

									<li class="td td-item">
										<div class="item-pic">
											<img src="http://localhost:8080/OnlineShop/images/kouhong.jpg_80x80.jpg" class="itempic J_ItemImg">
										</div>
										<div class="item-info">
											<div class="item-basic-info">
												${item.book.title }
											</div>
										</div>
									</li>
									<li class="td td-info">
										<div class="item-props item-props-can">

										</div>
									</li>
									<li class="td td-sum">
										<div class="td-inner">
											
										</div>
									</li>
									<li class="td td-price">
										<div class="item-price price-promo-promo">
											<div class="price-content">
												<div class="price-line">
													<em class="J_Price price-now" tabindex="0">${item.book.price }</em>
												</div>
											</div>
										</div>
									</li>
									<li class="td td-amount">
										<div class="amount-wrapper ">
											<div class="item-amount ">
												<div class="sl">

													<input class="${item.quantity }" type="text" size="1" name="${item.book.id }" value="${item.quantity }"/>

												</div>
											</div>
										</div>
									</li>
									
									<li class="td td-op">
										<div class="td-inner">
											<a href="shangpinServlet?method=remove&pageNo=${param.pageNo }&id=${item.book.id }" class="delete">删除</a>
										</div>
									</li>
								</ul>
								</c:forEach>
								
							</div>
						</div>
					</tr>
					<div class="clear"></div>


				</div>

				<div class="float-bar-wrapper">
					
					
					
					<div class="float-bar-right">
						<a href="shangpinServlet?method=clear" font_color ="white">
							<div class="btn-area">
								 <font color="#FFF">清空购物车</font>
							</div>
						</a>
					</div>
					<div class="float-bar-right">
						<a href="shangpinServlet?method=forwardPage&page=cash">
							<div class="btn-area">
									<font color="#FFF">结账</font>
							</div>
						</a>
					</div>
					<div class="float-bar-right">
						<a href="shangpinServlet?method=getBooks&pageNo=${param.pageNo }">
							<div class="btn-area">
									<font color="#FFF">继续购物</font>
							</div>
						</a>
					</div>

					
					<div class="float-bar-right">
							<font size="5px">总金额: ￥ ${ sessionScope.ShoppingCart.totalMoney}</font>
					</div>
						
						

				</div>

				<div class="footer">
					
				</div>

			</div>


		<!--引导 -->
		<div class="navCir">
			<li><a href="home2.html"><i class="am-icon-home "></i>首页</a></li>
			<li><a href="sort.html"><i class="am-icon-list"></i>分类</a></li>
			<li class="active"><a href=""><i class="am-icon-shopping-basket"></i>购物车</a></li>	
			<li><a href="http://localhost:8080/OnlineShop/person/index.html"><i class="am-icon-user"></i>我的</a></li>					
		</div>
	</body>

</html>
















<!-- 
	<center>
		
		<br><br>
		<div id="bookNumber">您的购物车中共有 ${sessionScope.ShoppingCart.bookNumber } 本书</div>
		<table cellpadding="10">
			<tr>
				<td>Title</td>
				<td>Quantity</td>
				<td>Price</td>
				<td>&nbsp;</td>
			</tr>
			
			<c:forEach items="${sessionScope.ShoppingCart.items }" var="item">
				<tr>
					<td>${item.book.title }</td>
					<td> 
						<input class="${item.quantity }" type="text" size="1" name="${item.book.id }" value="${item.quantity }"/>
					</td>
					<td>${item.book.price }</td>
					<td><a href="shangpinServlet?method=remove&pageNo=${param.pageNo }&id=${item.book.id }" class="delete">删除</a></td>
				</tr>
			</c:forEach>
			
			<tr>
				<td colspan="4" id="totalMoney">总金额: ￥ ${ sessionScope.ShoppingCart.totalMoney}</td>
			</tr>
			
			<tr>
				<td colspan="4">
					<a href="shangpinServlet?method=getBooks&pageNo=${param.pageNo }">继续购物</a>
					&nbsp;&nbsp;
					
					<a href="shangpinServlet?method=clear">清空购物车</a>
					&nbsp;&nbsp;
					
					<a href="shangpinServlet?method=forwardPage&page=cash">结账</a>
					&nbsp;&nbsp;
				</td>
			</tr>
			
		</table>
		
	</center>
	
	<br><br>
	
	
</body>
</html> -->