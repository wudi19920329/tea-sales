package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum Status {
	HAS_BEEN_SOLD_OUT("已售罄"), FAYE_FLY("正式售卖中");

	private String desc;

	private Status(String desc) {
		this.desc = desc;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

}
