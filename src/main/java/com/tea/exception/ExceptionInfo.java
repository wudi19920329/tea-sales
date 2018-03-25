package com.tea.exception;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ExceptionInfo implements Serializable {

	private String code;

	private String message;

	public ExceptionInfo(String code, String message) {
		super();
		this.code = code;
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
