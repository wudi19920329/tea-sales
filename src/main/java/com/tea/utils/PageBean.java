package com.tea.utils;

import java.math.BigDecimal;
import java.util.List;

/**
 * 封装分页参数
 */
public class PageBean<T> {

	private int currentPage = 1; // 当前页, 默认显示第一页
	private int pageCount = 10; // 每页显示的行数(查询返回的行数), 默认每页显示4行
	private int total; // 总记录数
	private int totalPage; // 总页数 = 总记录数 / 每页显示的行数 (+ 1)
	private List<T> rows; // 分页查询到的数据
	private BigDecimal subTotalPrice;// 小计
	private Integer subTotalCount;// 数量小计

	// 返回总页数
	public int getTotalPage() {
		if (total % pageCount == 0) {
			totalPage = total / pageCount;
		} else {
			totalPage = total / pageCount + 1;
		}
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	 

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public BigDecimal getSubTotalPrice() {
		return subTotalPrice;
	}

	public void setSubTotalPrice(BigDecimal subTotalPrice) {
		this.subTotalPrice = subTotalPrice;
	}

	public Integer getSubTotalCount() {
		return subTotalCount;
	}

	public void setSubTotalCount(Integer subTotalCount) {
		this.subTotalCount = subTotalCount;
	}

}
