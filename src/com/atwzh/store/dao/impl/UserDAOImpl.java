package com.atwzh.store.dao.impl;

import com.atwzh.store.dao.UserDAO;
import com.atwzh.store.domain.User;

public class UserDAOImpl extends BaseDAO<User> implements UserDAO {

	@Override
	public User getUser(String username) {
		String sql = "SELECT userId, username, accountId " +
				"FROM userinfo WHERE username = ?";
		return query(sql, username); 
	}
	public User getUser() {
		String sql = "SELECT userId, username, accountId " +
				"FROM userinfo";
		return query(sql); 
	}
	public void insUser(String username,String acID) {
		
		String sql2 = "INSERT INTO account VALUES "
				+ "('"+acID+ "','2000000')";
		update(sql2);
		String sql = "INSERT INTO userinfo(username, accountid) "
				+ "VALUES('"+username+"', "+acID+")";
		update(sql);
	}
}
