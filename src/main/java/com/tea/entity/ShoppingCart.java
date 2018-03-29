package com.tea.entity;

import java.util.Date;

/**
 * 购物车
 * 
 * @author niuzhanyuan
 *
 */
public class ShoppingCart {
	private Integer id;// 主键id
	private Customer customer;// 客户
	private Date createTime;// 创建时间
	private Date updateTime;// 更新时间

	public ShoppingCart() {
		super();
	}

	public ShoppingCart(Customer customer) {
		super();
		this.customer = customer;
		this.createTime = new Date();
		this.updateTime = new Date();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}
