package com.tea.tools;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class JdbcUtils {
	// 链接池
	private static DataSource dataSource;

	static {
		dataSource = new ComboPooledDataSource();
	}

	public static DataSource getDataSource() {
		return dataSource;
	}

	/**
	 * DBUtils工具类对象
	 */

	public static QueryRunner getQueryRunner() {
		return new QueryRunner(dataSource);
	}
}
