package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 快递配送方式
 * 
 * @author niuzhanyuan
 *
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum ExpressDeliveryMode {
	YTO_EXPRESS("圆通快递"), SF_EXPRESS("邮政特快专递"), EMS("邮政特快专递");
	private String description;

	private ExpressDeliveryMode(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
