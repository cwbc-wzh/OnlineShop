package com.atwzh.store.dao;

import java.util.Set;

import com.atwzh.store.domain.Trade;

public interface TradeDAO {

	/**
	 * �����ݱ��в��� Trade ����
	 * @param trade
	 */
	public abstract void insert(Trade trade);

	/**
	 * ���� userId ��ȡ��������� Trade �ļ���
	 * @param userId
	 * @return
	 */
	public abstract Set<Trade> getTradesWithUserId(Integer userId);
	public abstract Set<Trade> getTradesWithUserId1();
}