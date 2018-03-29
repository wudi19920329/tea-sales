package com.tea.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.tea.enums.Category;
import com.tea.enums.Specification;
import com.tea.enums.Status;
import com.tea.enums.Varieties;

public class Product {
	private Integer id;// 主键id
	private String image;// 图片地址
	private Category category;// 分类
	private Varieties varieties;// 品种
	private Long inventory;// 库存
	private Specification specification;// 单位
	private BigDecimal price;// 价格
	private String content;// 描述
	private Status status = Status.FAYE_FLY;// 商品状态
	private Date createTime;
	private BigDecimal discountPrice;// 折后价格
	private boolean discounted;// 是否打折

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

	public Varieties getVarieties() {
		return varieties;
	}

	public void setVarieties(Varieties varieties) {
		this.varieties = varieties;
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

}
