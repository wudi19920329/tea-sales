package com.tea.utils;

import java.util.Random;

public class RandomEnums {
	private static int random = (int) (Math.random() * 10);// 生成种子
	private static Random rand = new Random(random);

	public static <T extends Enum<T>> T random(Class<T> ec) {
		return random(ec.getEnumConstants());
	}

	public static <T> T random(T[] values) {
		return values[rand.nextInt(values.length)];
	}
}
