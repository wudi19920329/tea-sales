package com.tea.enums;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 快递配送方式
 * 
 * @author niuzhanyuan
 *
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum ExpressDeliveryMode {
	YTO_EXPRESS("圆通快递", new BigDecimal("8.00")), SF_EXPRESS("顺丰快递", new BigDecimal("14.00")), EMS("邮政特快专递",
			new BigDecimal("0.00"));
	private String description;
	private BigDecimal cost;
	private String name;

	private ExpressDeliveryMode(String description, BigDecimal cost) {
		this.description = description;
		this.cost = cost;
		this.name = this.name();
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getCost() {
		return cost;
	}

	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	

}
