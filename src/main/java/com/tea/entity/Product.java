package com.tea.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tea.enums.Category;
import com.tea.enums.Specification;
import com.tea.enums.Status;

public class Product {
	private Integer id;// 主键id
	private String image;// 图片地址
	private Category category;// 分类
	private String name;// 品种
	private Long inventory;// 库存
	private Specification specification;// 单位
	private BigDecimal price;// 价格
	private String content;// 描述
	private Status status = Status.TO_SELL;// 商品状态
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;
	private BigDecimal discountPrice;// 折后价格
	private Boolean discounted = Boolean.FALSE;// 是否打折

	public Product() {
		super();
	}

	public Product(String image, Category category, String name, Long inventory, Specification specification,
			BigDecimal price, String content,  BigDecimal discountPrice,
			Boolean discounted) {
		super();
		this.image = image;
		this.category = category;
		this.name = name;
		this.inventory = inventory;
		this.specification = specification;
		this.price = price;
		this.content = content;
		this.createTime = new Date();
		this.discountPrice = discountPrice;
		this.discounted = discounted;
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

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
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

	public BigDecimal getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(BigDecimal discountPrice) {
		this.discountPrice = discountPrice;
	}

	public boolean isDiscounted() {
		return discounted;
	}

	public void setDiscounted(boolean discounted) {
		this.discounted = discounted;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
