package com.tea.enums;

public enum AdminRole {
	SUPER_ADMIN("超级管理员"), GENERAL_ADMIN("普通管理员");

	private String description;

	private AdminRole(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
