package com.atwzh.store.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.atwzh.store.domain.ShoppingCart;
import com.atwzh.store.domain.User;

public class StoreWebUtils {
	
	/**
	 * 获取购物车对象: 从 session 中获取, 若 session 中没有改对象.
	 * 则创建一个新的购物车对象, 放入到 session 中.
	 * 若有, 则直接返回. 
	 * @param request
	 * @return
	 */
	public static ShoppingCart getShoppingCart(HttpServletRequest request){
		HttpSession session = request.getSession();
		
		ShoppingCart sc = (ShoppingCart) session.getAttribute("ShoppingCart");
		if(sc == null){
			sc = new ShoppingCart();
			session.setAttribute("ShoppingCart", sc);
		}
		
		return sc;
	}
	public static User getUser(HttpServletRequest request){
		HttpSession session = request.getSession();
		
		User sc2 = (User) session.getAttribute("User");
		if(sc2 == null){
			sc2 = new User();
			session.setAttribute("User", sc2);
		}
		return sc2;
	}
}
