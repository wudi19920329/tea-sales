package com.tea.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.tea.enums.ExpressDeliveryMode;
import com.tea.enums.OrderStatus;

public class Order {
	private Integer id;
	private Customer customer;
	private BigDecimal payableAmount;
	private ShoppingCart shoppingCart;
	private OrderStatus orderStatus;
	private ExpressDeliveryMode expressDeliveryMode;// 配送方式
	private Date createTime;
	private Date updateTime;

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

	public BigDecimal getPayableAmount() {
		return payableAmount;
	}

	public void setPayableAmount(BigDecimal payableAmount) {
		this.payableAmount = payableAmount;
	}

	public ShoppingCart getShoppingCart() {
		return shoppingCart;
	}

	public void setShoppingCart(ShoppingCart shoppingCart) {
		this.shoppingCart = shoppingCart;
	}

	public OrderStatus getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(OrderStatus orderStatus) {
		this.orderStatus = orderStatus;
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

	public ExpressDeliveryMode getExpressDeliveryMode() {
		return expressDeliveryMode;
	}

	public void setExpressDeliveryMode(ExpressDeliveryMode expressDeliveryMode) {
		this.expressDeliveryMode = expressDeliveryMode;
	}

}
