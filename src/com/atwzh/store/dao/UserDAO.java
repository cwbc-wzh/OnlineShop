package com.atwzh.store.dao;

import com.atwzh.store.domain.User;

public interface UserDAO {

	/**
	 * �����û�����ȡ User ����
	 * @param username
	 * @return
	 */
	public abstract User getUser(String username);
	public abstract User getUser();
	public abstract void insUser(String username, String acID);
}

