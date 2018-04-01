package com.tea.entity;

import com.tea.utils.MD5;

/**
 * 客户表
 * 
 * @author Administrator
 *
 */
public class Customer {
	private Integer id;
	private String realName;
	private String phone;
	private String address;
	private Integer postcode;
	private String email;
	private String password;
	private String nickName;

	public Customer() {
		super();
	}

	public Customer(String realName, String phone, String address, Integer postcode, String email, String password,
			String nickName) {
		super();
		this.realName = realName;
		this.nickName = nickName;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.postcode = postcode;
		this.password = MD5.getMD5(MD5.getMD5(password));
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPostcode() {
		return postcode;
	}

	public void setPostcode(Integer postcode) {
		this.postcode = postcode;
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
