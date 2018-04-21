package com.tea.dbHandle;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.tea.entity.Customer;
import com.tea.entity.ShoppingCart;
import com.tea.enums.ShoppingCartStatus;
import com.tea.utils.JdbcUtils;

public class ShoppingCartHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(ShoppingCart shoppingCart) {
		String sql = "INSERT INTO t_shopping_cart(customer_id,status,create_time,update_time) VALUES (?,?,?,?)";
		try {
			qr.update(sql, shoppingCart.getCustomer().getId(), shoppingCart.getStatus().name(),
					shoppingCart.getCreateTime(), shoppingCart.getUpdateTime());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void update(ShoppingCart shoppingCart) {
		String sql = "update t_shopping_cart set customer_id=?,status=?,create_time=?,update_time=? where id=?";
		try {
			qr.update(sql, shoppingCart.getCustomer().getId(), shoppingCart.getStatus().name(),
					shoppingCart.getCreateTime(), shoppingCart.getUpdateTime(), shoppingCart.getId());
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

	public ShoppingCart queryNoSettlementByCustomerId(Integer customerId) {
		String sql = "SELECT id,customer_id as customerId,status,create_time as createTime,update_time as updateTime FROM t_shopping_cart WHERE customer_id=? AND status = ?";
		try {
			return qr.query(sql, new ResultSetHandler<ShoppingCart>() {
				@Override
				public ShoppingCart handle(ResultSet rs) throws SQLException {
					ShoppingCart shoppingCart = null;
					while (rs.next()) {
						shoppingCart = new ShoppingCart();
						Customer customer = new Customer();
						customer.setId(rs.getInt("customerId"));
						shoppingCart.setCreateTime(rs.getDate("createTime"));
						shoppingCart.setId(rs.getInt("id"));
						shoppingCart.setCustomer(customer);
						shoppingCart.setStatus(ShoppingCartStatus.valueOf(rs.getString("status")));
						shoppingCart.setUpdateTime(rs.getDate("updateTime"));
					}

					return shoppingCart;
				}
			}, customerId, ShoppingCartStatus.NO_SETTLEMENT.name());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}