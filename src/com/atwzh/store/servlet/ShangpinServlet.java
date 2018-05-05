package com.atwzh.store.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.atwzh.store.dao.ShangpinDAO;
import com.atwzh.store.dao.impl.ShangpinDAOImpl;
import com.atwzh.store.domain.Account;
import com.atwzh.store.domain.Shangpin;
import com.atwzh.store.domain.ShoppingCart;
import com.atwzh.store.domain.ShoppingCartItem;
import com.atwzh.store.domain.Trade;
import com.atwzh.store.domain.User;
import com.atwzh.store.service.AccountService;
import com.atwzh.store.service.ShangpinService;
import com.atwzh.store.service.UserService;
import com.atwzh.store.web.StoreWebUtils;
import com.atwzh.store.web.CriteriaBook;
import com.atwzh.store.web.Page;
import com.google.gson.Gson;

public class ShangpinServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	private ShangpinService bookService = new ShangpinService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String methodName = request.getParameter("method");
		
		try {
			Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
			method.setAccessible(true);
			method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	private UserService userService = new UserService();
	
	protected void dingdan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
//		���� UserService �� getUser(username) ��ȡUser ����Ҫ�� trades �Ǳ�װ��õģ�����ÿһ�� Trrade ����� items Ҳ��װ���
		Set<Trade> trades = userService.getUserWithTrades1();
		
		
		request.setAttribute("trades", trades);
		
//		ת��ҳ�浽 /WEB-INF/pages/trades.jsp
		request.getRequestDispatcher("/home/dingdan.jsp").forward(request, response);

	}
	
	protected void fahuo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
//		���� UserService �� getUser(username) ��ȡUser ����Ҫ�� trades �Ǳ�װ��õģ�����ÿһ�� Trrade ����� items Ҳ��װ���
		String id = request.getParameter("id");
		
		StringBuffer errors = new StringBuffer("");
		
		if(id == null || id.trim().equals("")){
			errors.append("商品名不能为空");			
		}
		
		if(!errors.toString().equals("")){
			
			response.sendRedirect("http://localhost:8080/OnlineShop/home/fahuo.jsp");
		}
		else {
			errors.append("发货成功");
			request.setAttribute("errors", errors);
			bookService.updatedingdan(id);
			request.getRequestDispatcher("/home/fahuo.jsp").forward(request, response);
		}
		return;
		
	}
	
	
	
	
	protected void cash(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. ����֤: ��֤�����ֵ�Ƿ���ϻ����Ĺ淶: �Ƿ�Ϊ��, �Ƿ����תΪ int ����, �Ƿ���һ�� email. ����Ҫ���в�ѯ
		//���ݿ������κε�ҵ�񷽷�.
		String username = request.getParameter("username");
		
		String accountId = request.getParameter("accountId");
		String address = request.getParameter("address");
		//System.out.println(address);
		//String address1 = new String(address.getBytes("gb2312"), "utf-8");
		
		//System.out.println(address1);
		StringBuffer errors = validateFormField(username, accountId);
		//����֤ͨ���� 
		if(errors.toString().equals("")){
			errors = validateUser(username, accountId);
			
			//�û������˺���֤ͨ��
			if(errors.toString().equals("")){
				errors = validateBookStoreNumber(request);
				
				//�����֤ͨ��
				if(errors.toString().equals("")){
					errors = validateBalance(request, accountId);
				}
			}
		}
		if(address == null || address.trim().equals("")){
			errors.append("地址不能为空");			
		}
		if(!errors.toString().equals("")){
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/WEB-INF/pages/cash.jsp").forward(request, response);
			return;
		}
		
		//��֤ͨ��ִ�о�����߼�����
		bookService.cash(StoreWebUtils.getShoppingCart(request), username, accountId, address); 
		response.sendRedirect(request.getContextPath() + "/success.jsp");
	}
	
	protected void Login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. ����֤: ��֤�����ֵ�Ƿ���ϻ����Ĺ淶: �Ƿ�Ϊ��, �Ƿ����תΪ int ����, �Ƿ���һ�� email. ����Ҫ���в�ѯ
		//���ݿ������κε�ҵ�񷽷�.
		System.out.println("1111");
		String username = request.getParameter("username");
		String accountId = request.getParameter("accountId");
		
		StringBuffer errors = validateFormField(username, accountId);
		
		//����֤ͨ���� 
		if(errors.toString().equals("")){
			errors = validateUser(username, accountId);
			
			//�û������˺���֤ͨ��
			if(errors.toString().equals("")){
				errors = validateBookStoreNumber(request);
				
				//�����֤ͨ��
				if(errors.toString().equals("")){
					errors = validateBalance(request, accountId);
				}
			}
		}
		if(!errors.toString().equals("")){
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
			return;
		}
		User sc2 = StoreWebUtils.getUser(request);
		sc2.setUsername(username);
		//��֤ͨ��ִ�о�����߼�����
		response.sendRedirect("http://localhost:8080/OnlineShop/");
	}
	
	protected void lookdingdan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		��ȡ username ���������ֵ
		//String username = request.getParameter("username");
		User user1 = StoreWebUtils.getUser(request);
		String username = user1.getUsername();
		System.out.println(username);
//		���� UserService �� getUser(username) ��ȡUser ����Ҫ�� trades �Ǳ�װ��õģ�����ÿһ�� Trrade ����� items Ҳ��װ���
		User user = userService.getUserWithTrades(username);
		
//		�� User ������뵽 request ��
		
		
		request.setAttribute("user", user);
		
//		ת��ҳ�浽 /WEB-INF/pages/trades.jsp
		request.getRequestDispatcher("/WEB-INF/pages/trades.jsp").forward(request, response);

	}
	protected void zhuxiao(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		session.removeAttribute("User");
		
		
		
//		ת��ҳ�浽 /WEB-INF/pages/trades.jsp
		request.getRequestDispatcher("/home/home2.jsp").forward(request, response);

	}
	
	protected void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		String salesnum = request.getParameter("salesnum");
		String storenum = request.getParameter("storenum");	
		String kind = request.getParameter("kind");	
		name = new String(name.getBytes("ISO-8859-1"), "utf-8");
		StringBuffer errors = new StringBuffer("");
		
		if(name == null || name.trim().equals("")){
			errors.append("商品名不能为空");			
		}
		if(price == null || price.trim().equals("")){
			errors.append("价格不能为空");			
		}
		if(salesnum == null || salesnum.trim().equals("")){
			errors.append("销售数不能为空");			
		}
		if(storenum == null || storenum.trim().equals("")){
			errors.append("库存不能为空");			
		}
		if(kind == null || kind.trim().equals("")){
			errors.append("种类不能为空");			
		}
		
		if(!errors.toString().equals("")){
			
			response.sendRedirect("http://localhost:8080/OnlineShop/home/insertshangpin.jsp");
		}
		else {
			errors.append("添加商品成功");
			request.setAttribute("errors", errors);
			bookService.insertshangpin(name, price, salesnum, storenum, kind);
			request.getRequestDispatcher("/home/insertshangpin.jsp").forward(request, response);
		
			
		}
		return;
		
	}
	protected void insertpicture(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		 // ����Ƿ�Ϊ��ý���ϴ�
        if (!ServletFileUpload.isMultipartContent(request)) {
            // ���������ֹͣ
            PrintWriter writer = response.getWriter();
            writer.println("Error: ��������� enctype=multipart/form-data");
            writer.flush();
            return;
        }
  
        // �����ϴ�����
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // �����ڴ��ٽ�ֵ - �����󽫲�����ʱ�ļ����洢����ʱĿ¼��
        factory.setSizeThreshold(1024 * 1024 * 50);
        // ������ʱ�洢Ŀ¼
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
  
        ServletFileUpload upload = new ServletFileUpload(factory);
          
        // ��������ļ��ϴ�ֵ
        upload.setFileSizeMax(1024 * 1024 * 50);
          
        // �����������ֵ (�����ļ��ͱ�����)
        upload.setSizeMax(1024 * 1024 * 50);
  
        // ������ʱ·�����洢�ϴ����ļ�
        // ���·����Ե�ǰӦ�õ�Ŀ¼
        String uploadPath = getServletContext().getRealPath("./") + File.separator + upload;
        
          
        // ���Ŀ¼�������򴴽�
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
  
        try {
            // ���������������ȡ�ļ�����
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
  
            if (formItems != null && formItems.size() > 0) {
                // ����������
                for (FileItem item : formItems) {
                    // �����ڱ��е��ֶ�
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        // �ڿ���̨����ļ����ϴ�·��
                        System.out.println(filePath);
                        // �����ļ���Ӳ��
                        item.write(storeFile);
                        //request.setAttribute("message",
                        //    "�ļ��ϴ��ɹ�!");
                    }
                }
            }
        } catch (Exception ex) {
        	ex.printStackTrace();
            //request.setAttribute("message",
            //        "������Ϣ: " + ex.getMessage());
        }

    	response.sendRedirect("http://localhost:8080/OnlineShop/home/insertpicture.jsp");
    }
    
		
	
	protected void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		StringBuffer errors = new StringBuffer("");
		
		if(id == null || id.trim().equals("")){
			errors.append("编号不能为空");			
		}
		
		if(!errors.toString().equals("")){
			response.sendRedirect("http://localhost:8080/OnlineShop/home/deleteshangpin.jsp");
		}
		else {
			errors.append("删除商品成功");
			request.setAttribute("errors", errors);
			bookService.deleteshangpin(id);
			request.getRequestDispatcher("/home/deleteshangpin.jsp").forward(request, response);
		}
	}
	protected void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		String date = request.getParameter("date");		
		String salesnum = request.getParameter("salesnum");
		String storenum = request.getParameter("storenum");		
		String kind = request.getParameter("kind");		
		name = new String(name.getBytes("ISO-8859-1"), "utf-8");
		
		StringBuffer errors = new StringBuffer("");
		if(id == null || id.trim().equals("")){
			errors.append("商品编号不能为空");			
		}
		if(name == null || name.trim().equals("")){
			errors.append("商品名不能为空");			
		}
		if(price == null || price.trim().equals("")){
			errors.append("价格不能为空");			
		}
		if(date == null || date.trim().equals("")){
			errors.append("价格不能为空");			
		}
		if(salesnum == null || salesnum.trim().equals("")){
			errors.append("销售数不能为空");			
		}
		if(storenum == null || storenum.trim().equals("")){
			errors.append("库存不能为空");			
		}
		if(kind == null || kind.trim().equals("")){
			errors.append("种类不能为空");			
		}
		
		if(!errors.toString().equals("")){
			response.sendRedirect("http://localhost:8080/OnlineShop/home/updateshangpin.jsp");
		}
		else {
			errors.append("修改商品信息成功");
			request.setAttribute("errors", errors);
			bookService.updateshangpin(id, name, price, date, salesnum, storenum, kind);
			request.getRequestDispatcher("/home/updateshangpin.jsp").forward(request, response);
		}
		return;
	}

	protected void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. ����֤: ��֤�����ֵ�Ƿ���ϻ����Ĺ淶: �Ƿ�Ϊ��, �Ƿ����תΪ int ����, �Ƿ���һ�� email. ����Ҫ���в�ѯ
		//���ݿ������κε�ҵ�񷽷�.
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		userService.insertUser(username, password);
		response.sendRedirect("http://localhost:8080/OnlineShop/");
	}
	
	private AccountService accountService = new AccountService();
	
	//��֤����Ƿ����
	public StringBuffer validateBalance(HttpServletRequest request, String accountId){
		
		StringBuffer errors = new StringBuffer("");
		ShoppingCart cart = StoreWebUtils.getShoppingCart(request);
		
		Account account = accountService.getAccount(Integer.parseInt(accountId));
		if(cart.getTotalMoney() > account.getBalance()){
			errors.append("余额不足!");
		}
		
		return errors;
	}
	
	//��֤����Ƿ����
	public StringBuffer validateBookStoreNumber(HttpServletRequest request){
		
		StringBuffer errors = new StringBuffer("");
		ShoppingCart cart = StoreWebUtils.getShoppingCart(request);
		
		for(ShoppingCartItem sci: cart.getItems()){
			int quantity = sci.getQuantity();
			int storeNumber = bookService.getBook(sci.getBook().getId()).getStoreNumber();
			
			if(quantity > storeNumber){
				errors.append(sci.getBook().getTitle() + "��治��<br>");
			}
		}
		
		return errors;
	}

	//��֤�û������˺��Ƿ�ƥ��
	public StringBuffer validateUser(String username, String accountId){
		boolean flag = false;
		User user = userService.getUserByUserName(username);
		if(user != null){
			int accountId2 = user.getAccountId();
			if(accountId.trim().equals("" + accountId2)){
				flag = true;
			}
		}
		
		StringBuffer errors2 = new StringBuffer("");
		if(!flag){
			errors2.append("用户名和账号不匹配");
		}
		
		return errors2;
	}
	
	//��֤�����Ƿ���ϻ����Ĺ���: �Ƿ�Ϊ��. 
	public StringBuffer validateFormField(String username, String accountId){
		StringBuffer errors = new StringBuffer("");
		
		if(username == null || username.trim().equals("")){
			errors.append("手机号不能为空");
		}
		
		if(accountId == null || accountId.trim().equals("")){
			errors.append("密码不能为空");			
		}
		
		return errors;
	}

	protected void updateItemQuantity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//4. �� updateItemQuantity ������, ��ȡ quanity, id, �ٻ�ȡ���ﳵ����, ���� service �ķ������޸�
		String idStr = request.getParameter("id");
		String quantityStr = request.getParameter("quantity");
		
		ShoppingCart sc = StoreWebUtils.getShoppingCart(request);
		
		int id = -1;
		int quantity = -1;
		
		try {
			id = Integer.parseInt(idStr);
			quantity = Integer.parseInt(quantityStr);
		} catch (Exception e) {}
		
		if(id > 0 && quantity > 0)
			bookService.updateItemQuantity(sc, id, quantity);
		
		//5. ���� JSON ����: bookNumber:xx, totalMoney
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("bookNumber", sc.getBookNumber());
		result.put("totalMoney", sc.getTotalMoney());
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(result);
		response.setContentType("text/javascript");
		response.getWriter().print(jsonStr);
	}

	protected void clear(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ShoppingCart sc = StoreWebUtils.getShoppingCart(request);
		bookService.clearShoppingCart(sc);
		
		request.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(request, response);
	}
	
	protected void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idStr = request.getParameter("id");
		
		int id = -1;
		try {
			id = Integer.parseInt(idStr);
		} catch (Exception e) {}
		
		ShoppingCart sc = StoreWebUtils.getShoppingCart(request);
		bookService.removeItemFromShoppingCart(sc, id);
		
		if(sc.isEmpty()){
			request.getRequestDispatcher("/WEB-INF/pages/emptycart.jsp").forward(request, response);
			return;
		}
		
		request.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(request, response);
	}
	
	protected void forwardPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page = request.getParameter("page");
		request.getRequestDispatcher("/WEB-INF/pages/" + page + ".jsp").forward(request, response);
	}

	protected void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. ��ȡ��Ʒ�� id
		String idStr = request.getParameter("id");
		int id = -1;
		boolean flag = false;
		String kind = request.getParameter("kind");
		try {
			id = Integer.parseInt(idStr);
		} catch (Exception e) {}
		
		if(id > 0){
			//2. ��ȡ���ﳵ����
			ShoppingCart sc = StoreWebUtils.getShoppingCart(request);
			
			//3. ���� BookService �� addToCart() ��������Ʒ�ŵ����ﳵ��
			flag = bookService.addToCart(id, sc);
		}
		//System.out.println(kind);
		if(flag){
			//4. ֱ�ӵ��� getBooks() ����. 
			
			response.sendRedirect("http://localhost:8080/OnlineShop/shangpinServlet?method=getBooks&kind="+kind);
			//getBooks(request, response);
			return;
		}
		
		response.sendRedirect(request.getContextPath() + "/error-1.jsp");
	}
	
	protected void getBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idStr = request.getParameter("id");
		int id = -1;

		Shangpin book = null;
		
		try {
			id = Integer.parseInt(idStr);
		} catch (NumberFormatException e) {}
		
		if(id > 0)
			book = bookService.getBook(id);
		
		if(book == null){
			response.sendRedirect(request.getContextPath() + "/error-1.jsp");
			return;
		}
		
		request.setAttribute("book", book);
		request.getRequestDispatcher("/WEB-INF/pages/shangpin.jsp").forward(request, response);
	}
	

	
	protected void getBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pageNoStr = request.getParameter("pageNo");
		String minPriceStr = request.getParameter("minPrice");
		String maxPriceStr = request.getParameter("maxPrice");
		String Kind = request.getParameter("kind");
		int pageNo = 1;
		int minPrice= 0;
		int maxPrice = Integer.MAX_VALUE;
		int kind = 1;
		try {
			pageNo = Integer.parseInt(pageNoStr);
		} catch (NumberFormatException e) {}
		
		try {
			minPrice = Integer.parseInt(minPriceStr);
		} catch (NumberFormatException e) {}
		
		try {
			maxPrice = Integer.parseInt(maxPriceStr);
		} catch (NumberFormatException e) {}
		try {
			kind = Integer.parseInt(Kind);
		} catch (NumberFormatException e) {}
		CriteriaBook criteriaBook = new CriteriaBook(minPrice, maxPrice, pageNo, kind);
		Page<Shangpin> page = bookService.getPage(criteriaBook);
		page.setKind(kind);
		request.setAttribute("bookpage", page);
		
		request.getRequestDispatcher("/WEB-INF/pages/shangpins.jsp").forward(request, response);
	}


	protected void getshangpin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pageNoStr = request.getParameter("pageNo");
		String minPriceStr = request.getParameter("minPrice");
		String maxPriceStr = request.getParameter("maxPrice");
		int pageNo = 1;
		int minPrice= 0;
		int maxPrice = Integer.MAX_VALUE;
		try {
			pageNo = Integer.parseInt(pageNoStr);
		} catch (NumberFormatException e) {}
		
		try {
			minPrice = Integer.parseInt(minPriceStr);
		} catch (NumberFormatException e) {}
		
		try {
			maxPrice = Integer.parseInt(maxPriceStr);
		} catch (NumberFormatException e) {}

		CriteriaBook criteriaBook1 = new CriteriaBook(minPrice, maxPrice, pageNo);
		Page<Shangpin> page1 = bookService.getPage1(criteriaBook1);
		request.setAttribute("bookpage", page1);
		
		request.getRequestDispatcher("/home/shangpin.jsp").forward(request, response);
	}
	
protected void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pageNoStr = request.getParameter("pageNo");
		String minPriceStr = request.getParameter("minPrice");
		String maxPriceStr = request.getParameter("maxPrice");
		String name = request.getParameter("name");
		name = new String(name.getBytes("ISO-8859-1"), "utf-8");
		int pageNo = 1;
		int minPrice= 0;
		int maxPrice = Integer.MAX_VALUE;
		try {
			pageNo = Integer.parseInt(pageNoStr);
		} catch (NumberFormatException e) {}
		
		try {
			minPrice = Integer.parseInt(minPriceStr);
		} catch (NumberFormatException e) {}
		
		try {
			maxPrice = Integer.parseInt(maxPriceStr);
		} catch (NumberFormatException e) {}

		CriteriaBook criteriaBook1 = new CriteriaBook(minPrice, maxPrice, pageNo);
		Page<Shangpin> page1 = bookService.search(criteriaBook1, name);
		request.setAttribute("bookpage", page1);
		
		request.getRequestDispatcher("/search.jsp").forward(request, response);
	}

}
