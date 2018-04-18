package com.atwzh.store.dao.impl;

import java.util.LinkedHashSet;
import java.util.Set;

import com.atwzh.store.dao.TradeDAO;
import com.atwzh.store.domain.Trade;

public class TradeDAOImpl extends BaseDAO<Trade> implements TradeDAO {

	@Override
	public void insert(Trade trade) {
		String sql = "INSERT INTO trade (userid, tradetime, tradestate, tradeaddress) VALUES " +
				"(?, ?, ?,?)";
		long tradeId = insert(sql, trade.getUserId(), trade.getTradeTime(), trade.getTradeState(), trade.getTradeAddress());
		trade.setTradeId((int)tradeId);
	}

	@Override
	public Set<Trade> getTradesWithUserId(Integer userId) {
		String sql = "SELECT tradeId, userId, tradeTime, tradeState FROM trade " +
				"WHERE userId = ? ORDER BY tradeTime DESC";
		return new LinkedHashSet<Trade>(queryForList(sql, userId));
	}
	public Set<Trade> getTradesWithUserId1() {
		String sql = "SELECT tradeId, userId, tradeTime, tradeState,tradeAddress FROM trade " +
				"where tradeState = 0 ORDER BY tradeTime DESC";
		return new LinkedHashSet<Trade>(queryForList(sql));
	}

}
