package com.tea.entity;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.tea.Constants;
import com.tea.enums.ExpressDeliveryMode;
import com.tea.enums.OrderStatus;

public class Order {
	private Integer id;
	private Customer customer;
	private BigDecimal payableAmount;
	private ShoppingCart shoppingCart;
	private OrderStatus orderStatus = OrderStatus.WAIT_FOR_DELIVERY;
	private ExpressDeliveryMode expressDeliveryMode;// 配送方式
	private String description;
	private Date createTime;
	private Date updateTime;
	private String orderNumber;

	public Order() {
		super();
	}

	public Order(Customer customer, BigDecimal payableAmount, ShoppingCart shoppingCart,
			ExpressDeliveryMode expressDeliveryMode, String description) {
		super();
		this.customer = customer;
		this.payableAmount = payableAmount;
		this.shoppingCart = shoppingCart;
		this.expressDeliveryMode = expressDeliveryMode;
		this.description = description;
		this.createTime = new Date();
		this.updateTime = new Date();
		this.orderNumber = generateOrderNumber();
	}

	private String generateOrderNumber() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return MessageFormat.format(Constants.ORDER_NUMBER_PREFIX, customer.getId(),
				simpleDateFormat.format(new Date()));
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

}
