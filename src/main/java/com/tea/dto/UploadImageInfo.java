package com.tea.dto;

import java.io.Serializable;

@SuppressWarnings("serial")
public class UploadImageInfo implements Serializable {
	private String data;
	private String message;

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
