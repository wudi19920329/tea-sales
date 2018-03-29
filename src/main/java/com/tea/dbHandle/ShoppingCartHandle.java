package com.tea.dbHandle;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.tea.entity.ShoppingCart;
import com.tea.utils.JdbcUtils;

public class ShoppingCartHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(ShoppingCart shoppingCart) {
		String sql = "INSERT INTO t_shopping_cart(customer_id,create_time,update_time) VALUES (?,?,?)";
		try {
			qr.update(sql, shoppingCart.getCustomer().getId(), shoppingCart.getCreateTime(),
					shoppingCart.getUpdateTime());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void update(ShoppingCart shoppingCart) {
		String sql = "update t_shopping_cart set customer_id=?,create_time=?,update_time=? where id=?";
		try {
			qr.update(sql, shoppingCart.getCustomer().getId(), shoppingCart.getCreateTime(),
					shoppingCart.getUpdateTime());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ShoppingCart queryById(Integer id) {
		String sql = "SELECT id,customer_id as customerId,create_time as createTime,update_time as updateTime FROM t_shopping_cart WHERE id=?";
		try {
			return qr.query(sql, new BeanHandler<ShoppingCart>(ShoppingCart.class), id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public ShoppingCart queryByCustomerId(String customerId) {
		String sql = "SELECT id,customer_id as customerId,create_time as createTime,update_time as updateTime FROM t_shopping_cart WHERE customer_id=?";
		try {
			return qr.query(sql, new BeanHandler<ShoppingCart>(ShoppingCart.class), customerId);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}