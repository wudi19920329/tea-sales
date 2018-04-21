package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum ShoppingCartStatus {
	NO_SETTLEMENT("未结算"), HAVE_ALREADY_SETTLED("已结算");
	private String description;

	private ShoppingCartStatus(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
