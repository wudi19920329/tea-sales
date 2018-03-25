package com.tea.servlet.json;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.CORBA.IntHolder;

import com.tea.dto.GoodsInfo;
import com.tea.entity.Goods;
import com.tea.servlet.BaseServlet;

@SuppressWarnings("serial")
@WebServlet("/featuredGoods")
public class GoodsJsonServlet extends BaseServlet {

	public Object randomDisplay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int random = (int) (Math.random() * 6) + 1;// FeaturedItems
		Map<String, Object> featuredItemsMap = new HashMap<String, Object>();
		List<Goods> featuredItems = new ArrayList<>(4);
		featuredItems = goodsHandle.findByCeta(random, new IntHolder(0), 0, 4);
		List<GoodsInfo> asDto = featuredItems.stream()
				.map(s -> new GoodsInfo(s.getId(), s.getImage(), s.getType_id(), s.getName(), s.getNum(), s.getPrice(),
						s.getContent(), s.getProducter_id(), s.getStates(), s.getCreatDate(), s.getDiscountPrice(),
						s.isDiscounted()))
				.collect(Collectors.toList());
		featuredItemsMap.put("totalCount", asDto.size());
		featuredItemsMap.put("goods", asDto);
		return featuredItemsMap;
	}

}
