package com.atwzh.store.service;

import java.util.Iterator;
import java.util.Set;

import com.atwzh.store.dao.ShangpinDAO;
import com.atwzh.store.dao.TradeDAO;
import com.atwzh.store.dao.TradeItemDAO;
import com.atwzh.store.dao.UserDAO;
import com.atwzh.store.dao.impl.ShangpinDAOImpl;
import com.atwzh.store.dao.impl.TradeDAOImpl;
import com.atwzh.store.dao.impl.TradeItemDAOImpl;
import com.atwzh.store.dao.impl.UserDAOImpl;
import com.atwzh.store.domain.Trade;
import com.atwzh.store.domain.TradeItem;
import com.atwzh.store.domain.User;

public class UserService {

	private UserDAO userDAO = new UserDAOImpl();
	
	public User getUserByUserName(String username){
		return userDAO.getUser(username);
	}
	public void insertUser(String username, String acID){
		userDAO.insUser(username, acID);
	}

	private TradeDAO tradeDAO = new TradeDAOImpl();
	private TradeItemDAO tradeItemDAO = new TradeItemDAOImpl();
	private ShangpinDAO bookDAO = new ShangpinDAOImpl();
	
	public User getUserWithTrades(String username){
	
//		���� UserDAO �ķ�����ȡ User ����
		User user = userDAO.getUser(username);
		if(user == null){
			return null;
		}
		
//		���� TradeDAO �ķ�����ȡ Trade �ļ��ϣ�����װ��Ϊ User ������
		int userId = user.getUserId();
		
//		���� TradeItemDAO �ķ�����ȡÿһ�� Trade �е� TradeItem �ļ��ϣ�������װ��Ϊ Trade ������
		Set<Trade> trades = tradeDAO.getTradesWithUserId(userId);
		
		if(trades != null){
			Iterator<Trade> tradeIt = trades.iterator();
			
			while(tradeIt.hasNext()){
				Trade trade = tradeIt.next();
				
				int tradeId = trade.getTradeId();
				Set<TradeItem> items = tradeItemDAO.getTradeItemsWithTradeId(tradeId);
				
				if(items != null){
					for(TradeItem item: items){
						item.setBook(bookDAO.getBook(item.getBookId())); 
					}
					
					if(items != null && items.size() != 0){
						trade.setItems(items);						
					}
				}
				
				if(items == null || items.size() == 0){
					tradeIt.remove();	
				}
				
			}
		}
		
		if(trades != null && trades.size() != 0){
			user.setTrades(trades);			
		}
		
		return user;
	}
	public Set<Trade> getUserWithTrades1(){
		

//		���� TradeItemDAO �ķ�����ȡÿһ�� Trade �е� TradeItem �ļ��ϣ�������װ��Ϊ Trade ������
		Set<Trade> trades = tradeDAO.getTradesWithUserId1();
		
		if(trades != null){
			Iterator<Trade> tradeIt = trades.iterator();
			
			while(tradeIt.hasNext()){
				Trade trade = tradeIt.next();
				
				int tradeId = trade.getTradeId();
				Set<TradeItem> items = tradeItemDAO.getTradeItemsWithTradeId(tradeId);
				
				if(items != null){
					for(TradeItem item: items){
						item.setBook(bookDAO.getBook(item.getBookId())); 
					}
					
					if(items != null && items.size() != 0){
						trade.setItems(items);						
					}
				}
				
				if(items == null || items.size() == 0){
					tradeIt.remove();	
				}
				
			}
		}
		
		return trades;
	}
}
