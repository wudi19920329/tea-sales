package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum Category {
	GREEN_TEA("绿茶"),

	BLACK_TEA("红茶"),

	DARK_GREEN_TEA("黑茶"),

	OOLONG_TEA("乌龙茶"),

	YELLOW_TEA("黄茶");

	private String name;
	private String description;

	private Category(String description) {
		this.description = description;
		this.name = this.name();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
