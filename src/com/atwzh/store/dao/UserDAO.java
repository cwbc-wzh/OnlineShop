package com.atwzh.store.dao;

import com.atwzh.store.domain.User;

public interface UserDAO {

	/**
	 * 根据用户名获取 User 对象
	 * @param username
	 * @return
	 */
	public abstract User getUser(String username);
	public abstract User getUser();
	public abstract void insUser(String username, String acID);
}

