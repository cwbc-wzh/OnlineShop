package com.atwzh.store.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import com.atwzh.store.dao.AccountDAO;
import com.atwzh.store.dao.ShangpinDAO;
import com.atwzh.store.dao.TradeDAO;
import com.atwzh.store.dao.TradeItemDAO;
import com.atwzh.store.dao.UserDAO;
import com.atwzh.store.dao.impl.AccountDAOIml;
import com.atwzh.store.dao.impl.ShangpinDAOImpl;
import com.atwzh.store.dao.impl.TradeDAOImpl;
import com.atwzh.store.dao.impl.TradeItemDAOImpl;
import com.atwzh.store.dao.impl.UserDAOImpl;
import com.atwzh.store.db.JDBCUtils;
import com.atwzh.store.domain.Shangpin;
import com.atwzh.store.domain.ShoppingCart;
import com.atwzh.store.domain.ShoppingCartItem;
import com.atwzh.store.domain.Trade;
import com.atwzh.store.domain.TradeItem;
import com.atwzh.store.web.CriteriaBook;
import com.atwzh.store.web.Page;

public class ShangpinService {
	
	private ShangpinDAO bookDAO = new ShangpinDAOImpl();
	public void updateshangpin(String id, String name, String price,String date, String salesnum, String storenum, String kind){
		bookDAO.updateshangpin(id, name, price, date, salesnum, storenum,kind);
	}
	public void insertshangpin(String name, String price, String salesnum, String storenum, String kind){
		bookDAO.insertshangpin(name, price, salesnum, storenum, kind);
	}
	public void deleteshangpin(String id){
		bookDAO.deleteshangpin(id);
	}
	public void insertpicture(String name,String path){
		bookDAO.insertpicture(name, path);
	}
	public void updatedingdan(String id){
		bookDAO.updatedingdan(id);
	}

	
	public Page<Shangpin> getPage(CriteriaBook criteriaBook){
		return bookDAO.getPage(criteriaBook);
	}
	public Page<Shangpin> getPage1(CriteriaBook criteriaBook){
		return bookDAO.getPage1(criteriaBook);
	}
	public Page<Shangpin> search(CriteriaBook criteriaBook, String name){
		return bookDAO.search(criteriaBook, name);
	}
	public Shangpin getBook(int id) {
		return bookDAO.getBook(id);
	}
	

	public boolean addToCart(int id, ShoppingCart sc) {
		Shangpin book = bookDAO.getBook(id);
		
		if(book != null){
			sc.addBook(book);
			return true;
		}
		
		return false;
	}
	
	
	
	public void removeItemFromShoppingCart(ShoppingCart sc, int id) {
		sc.removeItem(id);
	}

	public void clearShoppingCart(ShoppingCart sc) {
		sc.clear();
	}

	public void updateItemQuantity(ShoppingCart sc, int id, int quantity) {
		sc.updateItemQuantity(id, quantity);
	}
	
	private AccountDAO accountDAO = new AccountDAOIml();
	private TradeDAO tradeDAO = new TradeDAOImpl();
	private UserDAO userDAO = new UserDAOImpl();
	private TradeItemDAO tradeItemDAO = new TradeItemDAOImpl();


	public void cash(ShoppingCart shoppingCart, String username,
			String accountId, String address) {
		
		//1. 更新 mybooks 数据表相关记录的 salesamount 和 storenumber
		bookDAO.batchUpdateStoreNumberAndSalesAmount(shoppingCart.getItems());
		
		
		//2. 更新 account 数据表的 balance
		accountDAO.updateBalance(Integer.parseInt(accountId), shoppingCart.getTotalMoney());
		
		//3. 向 trade 数据表插入一条记录
		Trade trade = new Trade();
		trade.setTradeTime(new Date(new java.util.Date().getTime()));
		trade.setUserId(userDAO.getUser(username).getUserId());
		trade.setTradeState(0);
		trade.setTradeAddress(address);
		tradeDAO.insert(trade);
		
		//4. 向 tradeitem 数据表插入 n 条记录
		Collection<TradeItem> items = new ArrayList<>();
		for(ShoppingCartItem sci: shoppingCart.getItems()){
			TradeItem tradeItem = new TradeItem();
			
			tradeItem.setBookId(sci.getBook().getId());
			tradeItem.setQuantity(sci.getQuantity());
			tradeItem.setTradeId(trade.getTradeId());
			
			items.add(tradeItem);
		}
		tradeItemDAO.batchSave(items);
		
		//5. 清空购物车
		shoppingCart.clear();
	}
}
