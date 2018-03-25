package com.tea.enums;

public enum TeaCategory {
	GREEN_TEA("绿茶"),

	BLACK_TEA("红茶"),

	DARK_GREEN_TEA("黑茶"),

	OOLONG_TEA("乌龙茶"),

	YELLOW_TEA("黄茶");

	private String description;

	private TeaCategory(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
