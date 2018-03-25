package com.tea.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.tea.Constants;

@SuppressWarnings("serial")
public class GoodsInfo implements Serializable {
	private Integer id;
	private String image;
	private Integer type_id;// 商品类型id
	private String name;
	private Integer num;// 数量
	private String priceStr;
	private String content;//
	private Integer producter_id;
	private Integer states;
	private Date creatDate;
	private String discountPriceStr;
	private boolean discounted;

	public GoodsInfo(Integer id, String image, Integer type_id, String name, Integer num, BigDecimal price,
			String content, Integer producter_id, Integer states, Date creatDate, BigDecimal discountPrice,
			boolean discounted) {
		super();
		this.id = id;
		this.image = image;
		this.type_id = type_id;
		this.name = name;
		this.num = num;
		this.setPriceStr(price);
		this.content = content;
		this.producter_id = producter_id;
		this.states = states;
		this.creatDate = creatDate;
		this.setDiscountPriceStr(discountPrice);
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

	public Integer getType_id() {
		return type_id;
	}

	public void setType_id(Integer type_id) {
		this.type_id = type_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getPriceStr() {
		return priceStr;
	}

	public void setPriceStr(BigDecimal priceStr) {
		this.priceStr = Constants.CURRENCY_SYMBOL + priceStr;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getProducter_id() {
		return producter_id;
	}

	public void setProducter_id(Integer producter_id) {
		this.producter_id = producter_id;
	}

	public Integer getStates() {
		return states;
	}

	public void setStates(Integer states) {
		this.states = states;
	}

	public Date getCreatDate() {
		return creatDate;
	}

	public void setCreatDate(Date creatDate) {
		this.creatDate = creatDate;
	}

	public String getDiscountPriceStr() {
		return discountPriceStr;
	}

	public void setDiscountPriceStr(BigDecimal discountPriceStr) {
		this.discountPriceStr = Constants.CURRENCY_SYMBOL + discountPriceStr;
	}

	public boolean isDiscounted() {
		return discounted;
	}

	public void setDiscounted(boolean discounted) {
		this.discounted = discounted;
	}

}
