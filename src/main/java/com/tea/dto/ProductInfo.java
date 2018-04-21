package com.tea.dto;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tea.enums.Category;
import com.tea.enums.ExpressDeliveryMode;
import com.tea.enums.Specification;
import com.tea.enums.Status;

public class ProductInfo {
	private Integer id;// 主键id
	private String image;// 图片地址
	private Category category;// 分类
	private String name;// 品种
	private Long inventory;// 库存
	private Specification specification;// 单位
	private BigDecimal payableAmount;// 总金额
	private String content;// 描述
	private Status status = Status.TO_SELL;// 商品状态
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;
	private BigDecimal finalPrice;
	private ExpressDeliveryMode expressDeliveryMode;
	

	private Integer quantity;

	public ProductInfo() {
		super();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Long getInventory() {
		return inventory;
	}

	public void setInventory(Long inventory) {
		this.inventory = inventory;
	}

	public Specification getSpecification() {
		return specification;
	}

	public void setSpecification(Specification specification) {
		this.specification = specification;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getPayableAmount() {
		return payableAmount;
	}

	public void setPayableAmount(BigDecimal payableAmount) {
		this.payableAmount = payableAmount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getFinalPrice() {
		return finalPrice;
	}

	public void setFinalPrice(BigDecimal finalPrice) {
		this.finalPrice = finalPrice;
	}

	public ExpressDeliveryMode getExpressDeliveryMode() {
		return expressDeliveryMode;
	}

	public void setExpressDeliveryMode(ExpressDeliveryMode expressDeliveryMode) {
		this.expressDeliveryMode = expressDeliveryMode;
	}
	
	

}
