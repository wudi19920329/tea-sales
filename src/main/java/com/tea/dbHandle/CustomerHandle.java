package com.tea.dbHandle;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.tea.entity.Customer;
import com.tea.utils.JdbcUtils;

public class CustomerHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(Customer customer) {
		String sql = "INSERT INTO t_customer(real_name,nick_name,phone,address,postcode,email,password) VALUES (?,?,?,?,?,?,?)";
		try {
			qr.update(sql, customer.getRealName(), customer.getNickName(), customer.getPhone(), customer.getAddress(),customer.getPostcode(),
					customer.getEmail(), customer.getPassword());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void update(Customer customer) {
		String sql = "update t_customer set real_name=?,nick_name=?,phone=?,address=?,email=?,password=? where id=?";
		try {
			qr.update(sql, customer.getRealName(), customer.getNickName(), customer.getPhone(), customer.getAddress(),
					customer.getEmail(), customer.getPassword(), customer.getId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Customer> query() {
		String sql = "SELECT id,real_name,nick_name,phone,address,postcode,email,password FROM t_customer WHERE real_name LIKE ? OR email LIKE ?";
		try {
			return qr.query(sql, new BeanListHandler<Customer>(Customer.class));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public Customer queryById(int id) {
		String sql = "SELECT id,real_name as realName,nick_name as nickName,phone,address,postcode,email,password FROM t_customer WHERE id=?";
		try {
			return qr.query(sql, new BeanHandler<Customer>(Customer.class), id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public Customer queryByName(String nickName) {
		String sql = "select * from t_customer t WHERE t.nick_name = ?";
		try {
			return qr.query(sql, new BeanHandler<Customer>(Customer.class), nickName);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public Customer queryByEmail(String email) {
		String sql = "SELECT id,real_name as realName,nick_name as nickName,phone,address,postcode,email,password FROM t_customer WHERE email=?";
		try {
			return qr.query(sql, new BeanHandler<Customer>(Customer.class), email);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public Customer queryByRealName(String realName) {
		String sql = "SELECT id,real_name as realName,nick_name as nickName,phone,address,postcode,email,password FROM t_customer WHERE real_name=?";
		try {
			return qr.query(sql, new BeanHandler<Customer>(Customer.class), realName);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public List<Customer> queryByRealNameLike(String keyword) {

		String sql = "SELECT * FROM t_customer WHERE real_name LIKE ?";
		try {
			return qr.query(sql, new BeanListHandler<Customer>(Customer.class), "%" + keyword + "%");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}