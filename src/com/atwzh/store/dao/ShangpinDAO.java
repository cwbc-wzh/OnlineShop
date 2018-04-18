package com.atwzh.store.dao;

import java.util.Collection;
import java.util.List;

import com.atwzh.store.domain.Shangpin;
import com.atwzh.store.domain.ShoppingCartItem;
import com.atwzh.store.web.CriteriaBook;
import com.atwzh.store.web.Page;

public interface ShangpinDAO {

	public abstract void insertshangpin(String name, String price, String salesnum, String storenum, String kind);
	public abstract void deleteshangpin(String id);
	public abstract void updateshangpin(String id, String name, String price,String date, String salesnum, String storenum, String kind);
	public abstract void insertpicture(String id, String path);
	public abstract void updatedingdan(String id);
	/**
	 * ���� id ��ȡָ�� Book ����
	 * @param id
	 * @return
	 */
	public abstract Shangpin getBook(int id);
	
	/**
	 * ���ݴ���� CriteriaBook ���󷵻ض�Ӧ�� Page ����
	 * @param cb
	 * @return
	 */
	public abstract Page<Shangpin> getPage(CriteriaBook cb);
	public abstract Page<Shangpin> getPage1(CriteriaBook cb);
	public abstract Page<Shangpin> search(CriteriaBook cb, String name);
	/**
	 * ���ݴ���� CriteriaBook ���󷵻����Ӧ�ļ�¼��
	 * @param cb
	 * @return
	 */
	public abstract long getTotalBookNumber(CriteriaBook cb);

	/**
	 * ���ݴ���� CriteriaBook �� pageSize ���ص�ǰҳ��Ӧ�� List 
	 * @param cb
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public abstract List<Shangpin> getPageList(CriteriaBook cb,int pageSize);

	/**
	 * ����ָ�� id �� book �� storeNumber �ֶε�ֵ
	 * @param id
	 * @return
	 */
	public abstract int getStoreNumber(Integer id);

	/**
	 * ���ݴ���� ShoppingCartItem �ļ���, 
	 * �������� books ���ݱ�� storenumber �� salesnumber �ֶε�ֵ
	 * @param items
	 */
	public abstract void batchUpdateStoreNumberAndSalesAmount(
			Collection<ShoppingCartItem> items);
	
}