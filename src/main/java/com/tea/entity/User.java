package com.tea.entity;

import com.tea.tools.MD5;

public class User {
	private int id;
	private String realName;
	private String phone;
	private String address;
	private String email;
	private String password;
	
	public User() {
		super();
	}

	public User(String realName, String phone, String address, String email, String password) {
		super();
		this.realName = realName;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.password = MD5.getMD5(MD5.getMD5(password));
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
