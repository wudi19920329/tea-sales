package com.tea.enums;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum Specification {
	SMALL("小包", new BigDecimal("500"), "g"),

	BIG("大包", new BigDecimal("1000"), "g");

	private String desc;
	private BigDecimal weight;
	private String unit;

	private Specification(String desc, BigDecimal weight, String unit) {
		this.desc = desc;
		this.weight = weight;
		this.unit = unit;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

}
