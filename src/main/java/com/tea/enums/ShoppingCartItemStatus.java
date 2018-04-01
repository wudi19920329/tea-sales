package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum ShoppingCartItemStatus {
	FOR_THE_PAYMENT("待付款"), PAYMENT_HAS_BEEN("已付款");
	private String description;

	private ShoppingCartItemStatus(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
