package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum Status {
	HAS_BEEN_SOLD_OUT("已售罄"), FAYE_FLY("正式售卖中"),TO_SELL("待售卖");

	private String desc;
	private String name;

	private Status(String desc) {
		this.desc = desc;
		this.name = this.name();
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	

}
