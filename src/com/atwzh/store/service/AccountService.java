package com.atwzh.store.service;

import com.atwzh.store.dao.AccountDAO;
import com.atwzh.store.dao.impl.AccountDAOIml;
import com.atwzh.store.domain.Account;

public class AccountService {
	
	private AccountDAO accountDAO = new AccountDAOIml();
	
	public Account getAccount(int accountId){
		return accountDAO.get(accountId);
	}
	
}
