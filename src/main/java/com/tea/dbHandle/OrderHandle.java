package com.tea.dbHandle;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.tea.entity.Customer;
import com.tea.entity.Order;
import com.tea.entity.ShoppingCart;
import com.tea.enums.ExpressDeliveryMode;
import com.tea.enums.OrderStatus;
import com.tea.exception.ServiceException;
import com.tea.utils.JdbcUtils;
import com.tea.utils.PageBean;

public class OrderHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(Order order) {
		String sql = "INSERT INTO t_order(order_number,customer_id,payable_amount,shopping_cart_id,order_status,express_delivery_mode,description,create_time,update_time) VALUES (?,?,?,?,?,?,?,?,?)";
		try {
			qr.update(sql, order.getOrderNumber(), order.getCustomer().getId(), order.getPayableAmount(),
					order.getShoppingCart().getId(), order.getOrderStatus().name(),
					order.getExpressDeliveryMode().name(), order.getDescription(), order.getCreateTime(),
					order.getUpdateTime());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	  

	public Order queryById(Integer id) {
		String sql = "select * from t_orders t WHERE t.id = ?";
		try {
			return qr.query(sql, new BeanHandler<Order>(Order.class), id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void delete(Integer id) {
		String sql = "DELETE FROM t_orders WHERE id=?";
		try {
			qr.update(sql, id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public PageBean<Order> queryPageByCustomerId(PageBean<Order> pb, Integer customerId) {
		int totalCount = this.getTotalCountBy(customerId);
		pb.setTotal(totalCount);
		List<Object> params = new ArrayList<Object>();
		if (pb.getCurrentPage() <= 0) {
			pb.setCurrentPage(1); // 把当前页设置为1
		} else if (pb.getCurrentPage() > pb.getTotalPage()) {
			pb.setCurrentPage(pb.getTotalPage()); // 把当前页设置为最大页数
		}
		// 获取当前页： 计算查询的起始行、返回的行数
		int currentPage = pb.getCurrentPage();
		int index = (currentPage - 1) * pb.getPageCount(); // 查询的起始行
		int count = pb.getPageCount(); // 查询返回的行数

		// 分页查询数据; 把查询到的数据设置到pb对象中
		String sql = "select * from t_order o join t_customer c on c.id = o.customer_id AND c.id = ? limit ?,? ";
		params.add(customerId);
		params.add(index);
		params.add(count);
		try {
			// 根据当前页，查询当前页数据(一页数据)
			if (index >= 0) {
				List<Order> pageData = qr.query(sql, new ResultSetHandler<List<Order>>() {
					final List<Order> ORDERS = new ArrayList<Order>();
					@Override
					public List<Order> handle(ResultSet rs) throws SQLException {
						while (rs.next()) {
							Order order = new Order();
							order.setCreateTime(rs.getDate("create_time"));
							order.setCustomer(new Customer());
							order.setDescription(rs.getString("description"));
							order.setExpressDeliveryMode(ExpressDeliveryMode.valueOf(rs.getString("express_delivery_mode")));
							order.setId(rs.getInt("id"));
							order.setOrderNumber(rs.getString("order_number"));
							order.setOrderStatus(OrderStatus.valueOf(rs.getString("order_status")));
							order.setPayableAmount(rs.getBigDecimal("payable_amount"));
							order.setShoppingCart(new ShoppingCart());
							order.setUpdateTime(rs.getDate("update_time"));
							ORDERS.add(order);
						}
						return ORDERS;
					}
				}, params.toArray());
				// 设置到pb对象中
				pb.setRows(pageData);
				return pb;
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return null;

	}

	public int getTotalCountBy(Integer customerId) {
		String sql = "select count(1) from t_order o join t_customer c on c.id = o.customer_id AND c.id = ?" ;
		try {
			// 执行查询， 返回结果的第一行的第一列
			Long count = qr.query(sql, new ScalarHandler<Long>(), customerId);
			return count.intValue();
		} catch (Exception e) {
			throw new ServiceException("客户订单分页查询异常");
		}
	}

}