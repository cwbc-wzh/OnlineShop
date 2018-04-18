package com.atwzh.store.dao.impl;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;

import com.atwzh.store.dao.ShangpinDAO;
import com.atwzh.store.domain.Shangpin;
import com.atwzh.store.domain.ShoppingCartItem;
import com.atwzh.store.web.CriteriaBook;
import com.atwzh.store.web.Page;

public class ShangpinDAOImpl extends BaseDAO<Shangpin> implements ShangpinDAO {
	
	public String getDate(){
		Calendar ca = Calendar.getInstance();
		int year = ca.get(Calendar.YEAR);
		int mouth = ca.get(Calendar.MONTH);
		int day = ca.get(Calendar.DATE);
		String data = year + "-" + mouth + "-" + day;
		
		return data;
	}
	
	public void insertshangpin(String name, String price, String salesnum, String storenum, String kind) {
		String date = getDate();
	
		String sql = "INSERT INTO shangpin "
				+ "(Author, Title, Price, Publishingdate, Salesamount, "
				+ "Storenumber, Remark, kind) VALUES "
				+ "('iphone', '"+name+"', '"+price+"', "
				+ "'"+date+"','"+salesnum+"','"+storenum+"', '0', '"+kind+"');";
		update(sql);
	}
	
	public void deleteshangpin(String id) {
		
		String sql = "DELETE FROM shangpin WHERE id = '"+id+"';";
		update(sql);
	}
	public void insertpicture(String id, String path) {
		
		update2(id, path);
	}
	public void updateshangpin(String id, String name, String price,String date, String salesnum, String storenum, String kind) {
		
		String sql = "UPDATE shangpin SET Title = "
				+ "'"+name+"', Price = '"+price+"', "
				+ "Publishingdate ="
				+ " '"+date+"', Salesamount = '"+salesnum+"', "
				+ "Storenumber = '"+storenum+"',"
						+ "kind = '"+kind+"' WHERE id = '"+id+"';";
		update(sql);
	}
	public void updatedingdan(String id) {
		
		String sql = "UPDATE trade SET tradestate = '1' WHERE tradeid = '"+id+"'";
		update(sql);
	}
	@Override
	public Shangpin getBook(int id) {
		String sql = "SELECT id, author, title, price, publishingDate, " +
				"salesAmount, storeNumber, remark, kind FROM shangpin WHERE id = ?";
		return query(sql, id);
	}
	
	//3. 
	@Override
	public Page<Shangpin> getPage(CriteriaBook cb) {
		Page<Shangpin> page = new Page<>(cb.getPageNo());
		
		page.setTotalItemNumber(getTotalBookNumber(cb));
		//校验 pageNo 的合法性
		cb.setPageNo(page.getPageNo());
		page.setList(getPageList(cb, 4));
		
		return page;
	}
	public Page<Shangpin> getPage1(CriteriaBook cb) {
		Page<Shangpin> page = new Page<>(cb.getPageNo());
		
		page.setTotalItemNumber(getTotalBookNumber(cb));
		//校验 pageNo 的合法性
		cb.setPageNo(page.getPageNo());
		page.setList(getPageList1(cb));
		
		return page;
	}
	public Page<Shangpin> search(CriteriaBook cb, String name) {
		Page<Shangpin> page = new Page<>(cb.getPageNo());
		
		page.setTotalItemNumber(getTotalBookNumber(cb));
		//校验 pageNo 的合法性
		cb.setPageNo(page.getPageNo());
		page.setList(getPageList2(cb, name));
		
		return page;
	}
	//1. 
	@Override
	public long getTotalBookNumber(CriteriaBook cb) {
		String sql = "SELECT count(id) FROM shangpin WHERE price >= ? AND price <= ? AND kind = ?";
		return getSingleVal(sql, cb.getMinPrice(), cb.getMaxPrice(),cb.getKind()); 
	}
	
	//2. 
	/**
	 * MySQL 分页使用 LIMIT, 其中 fromIndex 从 0 开始。 
	 */
	@Override
	public List<Shangpin> getPageList(CriteriaBook cb, int pageSize) {
		String sql = "SELECT id, author, title, price, publishingDate, " +
				"salesAmount, storeNumber, remark FROM shangpin " +
				"WHERE price >= ? AND price <= ? AND kind = ? " +
				"LIMIT ?, ?";
		
		return queryForList(sql, cb.getMinPrice(), cb.getMaxPrice(), cb.getKind(),
				(cb.getPageNo() - 1) * pageSize, pageSize);
	}
	public List<Shangpin> getPageList1(CriteriaBook cb) {
		String sql = "SELECT id, author, title, price, publishingDate, " +
				"salesAmount, storeNumber, remark,kind FROM shangpin " +
				
				"LIMIT ?, ?";
		
		return queryForList(sql,0, 1000);
	}
	public List<Shangpin> getPageList2(CriteriaBook cb, String name) {
		String sql = "SELECT id, author, title, price, publishingDate, " +
				"salesAmount, storeNumber, remark,kind FROM shangpin " +
				
				"where Title = '"+name+"'";
		
		return queryForList(sql);
	}
	
	@Override
	public int getStoreNumber(Integer id) {
		String sql = "SELECT storeNumber FROM shangpin WHERE id = ?";
		return getSingleVal(sql, id);
	}
	
	@Override
	public void batchUpdateStoreNumberAndSalesAmount(
			Collection<ShoppingCartItem> items) {
		String sql = "UPDATE shangpin SET salesAmount = salesAmount + ?, " +
				"storeNumber = storeNumber - ? " +
				"WHERE id = ?";
		Object [][] params = null;
		params = new Object[items.size()][3];
		List<ShoppingCartItem> scis = new ArrayList<>(items);
		for(int i = 0; i < items.size(); i++){
			params[i][0] = scis.get(i).getQuantity();
			params[i][1] = scis.get(i).getQuantity();
			params[i][2] = scis.get(i).getBook().getId();
		}
		batch(sql, params);
	}
	
}
