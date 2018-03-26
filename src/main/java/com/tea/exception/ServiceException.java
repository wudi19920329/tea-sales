package com.tea.exception;

@SuppressWarnings("serial")
public class ServiceException extends RuntimeException {

	private String errorCode;

	public ServiceException() {
		super();
	}

	public ServiceException(String errorCode, String message) {
		super(message);
		this.errorCode = errorCode;
	}

	public ServiceException(String message) {
		super(message);
	}

	public ServiceException(String message, Throwable cause) {
		super(message, cause);
	}

	public ServiceException(Throwable cause) {
		super(cause);
	}

	public String getErrorCode() {
		return errorCode;
	}
}
