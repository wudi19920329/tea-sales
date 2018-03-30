package com.tea.dto;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ShoppingCartItemVo implements Serializable {
	private Integer id;
	private Integer quantity;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

}
