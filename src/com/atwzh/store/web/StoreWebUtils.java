package com.atwzh.store.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.atwzh.store.domain.ShoppingCart;
import com.atwzh.store.domain.User;

public class StoreWebUtils {
	
	/**
	 * ��ȡ���ﳵ����: �� session �л�ȡ, �� session ��û�иĶ���.
	 * �򴴽�һ���µĹ��ﳵ����, ���뵽 session ��.
	 * ����, ��ֱ�ӷ���. 
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
