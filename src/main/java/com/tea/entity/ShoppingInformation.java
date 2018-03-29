package com.tea.entity;

import java.util.Date;

/**
 * 配送信息
 * 
 * @author niuzhanyuan
 *
 */
public class ShoppingInformation {
	private Integer id;
	private Order order;
	private String location;// 配送位置
	private Date createTime;
	private Date updateTime;

}
