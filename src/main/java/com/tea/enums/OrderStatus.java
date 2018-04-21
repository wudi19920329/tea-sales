package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 订单状态表
 * 
 * @author niuzhanyuan
 *
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum OrderStatus {
	WAIT_FOR_DELIVERY("待发货"), DELIVERED("已发货");
	private String description;
	private String name;

	private OrderStatus(String description) {
		this.description = description;
		this.name = this.name();
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
