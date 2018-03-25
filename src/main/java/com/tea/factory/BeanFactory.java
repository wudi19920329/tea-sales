package com.tea.factory;

import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

/**
 * 工厂创建Dao或Service实例
 * 
 */
public class BeanFactory {

	// 加载配置文件
	private static final ResourceBundle BUNDLE;
	private static final Map<String, Object> INSTANCES_MAP = new HashMap<String, Object>();

	static {
		BUNDLE = ResourceBundle.getBundle("instance");
		BUNDLE.keySet().forEach(key -> {
			String className = BUNDLE.getString(key);
			try {
				INSTANCES_MAP.put(key, Class.forName(className).newInstance());
			} catch (Exception e) {
				e.printStackTrace();
				return;
			}
		});
	}

	/**
	 * 根据指定的key值读取文件获取文件的全路径，创建对象
	 * 
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getInstance(String key) {
		if (INSTANCES_MAP.get(key) != null) {
			return (T) INSTANCES_MAP.get(key);
		}
		return null;
	}

}
