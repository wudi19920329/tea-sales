package com.tea.entity;

import java.util.Date;

/**
 * 购物车，产品中间表
 * 
 * @author niuzhanyuan
 *
 */
public class ShoppingCartItem {
	private Integer id;// 主键id
	private Product product;
	private ShoppingCart shoppingCart;
	private Integer quantity;
	private Date createTime;
	private Date updateTime;

	public ShoppingCartItem() {
		super();
	}

	public ShoppingCartItem(Product product, ShoppingCart shoppingCart, Integer quantity) {
		super();
		this.product = product;
		this.shoppingCart = shoppingCart;
		this.quantity = quantity;
		this.createTime = new Date();
		this.updateTime = new Date();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ShoppingCart getShoppingCart() {
		return shoppingCart;
	}

	public void setShoppingCart(ShoppingCart shoppingCart) {
		this.shoppingCart = shoppingCart;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
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
