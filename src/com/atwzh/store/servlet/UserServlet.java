package com.atwzh.store.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.atwzh.store.domain.User;
import com.atwzh.store.service.UserService;

/**
 * Servlet implementation class UserServlet
 */
public class UserServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserService userService = new UserService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		��ȡ username ���������ֵ
		String username = request.getParameter("username");
		
//		���� UserService �� getUser(username) ��ȡUser ����Ҫ�� trades �Ǳ�װ��õģ�����ÿһ�� Trrade ����� items Ҳ��װ���
		User user = userService.getUserWithTrades(username);
		
//		�� User ������뵽 request ��
		
		
		request.setAttribute("user", user);
		
//		ת��ҳ�浽 /WEB-INF/pages/trades.jsp
		request.getRequestDispatcher("/WEB-INF/pages/trades.jsp").forward(request, response);

	}

}
