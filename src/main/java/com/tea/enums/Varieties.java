package com.tea.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT, timezone = "Asia/Shanghai")
public enum Varieties {
	/**
	 * 绿茶
	 */
	YINGSHAN_CLOUD_TEA("英山云雾茶",Category.GREEN_TEA),
	THE_WEST_LAKE_LONGJING("西湖龙井",Category.GREEN_TEA),
	EMEI_SNOW_BUD("峨眉雪芽",Category.GREEN_TEA),
	MAE_TAM_GREEN_BUD("湄潭翠芽",Category.GREEN_TEA),
	LANXIN_SPARROW_TONGUE("兰馨雀舌",Category.GREEN_TEA),
	MEPHENTERMINE_TEA("惠明茶",Category.GREEN_TEA),
	
	/**
	 * 红茶
	 */
	QIINEN_BLACK_TEA("祁门红茶",Category.BLACK_TEA),
	DARJEELING_TEA("大吉岭红茶",Category.BLACK_TEA),
	UZBEKISTAN_SRI_LANKA("乌巴-斯里兰卡",Category.BLACK_TEA),
	ASSAM_BLACK_TEA("阿萨姆红茶",Category.BLACK_TEA),
	
	/**
	 * 黑茶
	 */
	THREE_POINT("三尖",Category.DARK_GREEN_TEA),
	EIGHT_BRICK("茯砖",Category.DARK_GREEN_TEA),
	TILE("花砖",Category.DARK_GREEN_TEA),
	BLACK_BRICK("黑砖",Category.DARK_GREEN_TEA),
	GREEN_TEA("青砖茶",Category.DARK_GREEN_TEA),
	
	/**
	 * 乌龙茶
	 */
	ANXI_TIEGUANYIN("安溪铁观音",Category.OOLONG_TEA),
	PHOENIX_NARCISSUS("凤凰水仙",Category.OOLONG_TEA),
	ORIENTAL_BEAUTY("东方美人",Category.OOLONG_TEA),
	LOHAN_ALOES("罗汉沉香",Category.OOLONG_TEA),
	RED_WATER_OOLONG("红水乌龙",Category.OOLONG_TEA),
	
	
	/**
	 * 黄茶
	 */
	HIPPOCAMPAL_PALACE_TEA("海马宫茶",Category.YELLOW_TEA),
	HUOSHAN_YELLOW_FLOWER_TEA("霍山黄芽茶",Category.YELLOW_TEA),
	YUANAN_YELLOW_TEA("远安黄茶",Category.YELLOW_TEA),
	JUNSHAN_ISLAND_SILVER_NEEDLE_TEA("君山银针茶",Category.YELLOW_TEA),
	LU_DING_TEA("路丁茶",Category.YELLOW_TEA);
	
	
	
	private String desc;
	
	private Category category;

	private Varieties(String desc,Category category) {
		this.desc = desc;
		this.category =  category;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
	
	
	
	
}
