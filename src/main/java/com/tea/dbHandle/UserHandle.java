package com.tea.dbHandle;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.tea.entity.User;
import com.tea.utils.JdbcUtils;

public class UserHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(User user) {
		String sql = "INSERT INTO user(real_name,nick_name,phone,address,email,password) VALUES (?,?,?,?,?,?)";
		try {
			qr.update(sql, user.getRealName(), user.getNickName(), user.getPhone(), user.getAddress(), user.getEmail(),
					user.getPassword());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void update(User user) {
		String sql = "update user set real_name=?,nick_name=?,phone=?,address=?,email=?,password=? where id=?";
		try {
			qr.update(sql, user.getRealName(), user.getNickName(), user.getPhone(), user.getAddress(), user.getEmail(),
					user.getPassword(), user.getId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<User> query() {
		String sql = "SELECT id,real_name,nick_name,phone,address,email,password FROM user WHERE real_name LIKE ? OR email LIKE ?";
		try {
			return qr.query(sql, new BeanListHandler<User>(User.class));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public User queryById(int id) {
		String sql = "SELECT id,real_name as realName,nick_name as nickName,phone,address,email,password FROM user WHERE id=?";
		try {
			return qr.query(sql, new BeanHandler<User>(User.class), id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public User queryByEmail(String email) {
		String sql = "SELECT id,real_name as realName,nick_name as nickName,phone,address,email,password FROM user WHERE email=?";
		try {
			return qr.query(sql, new BeanHandler<User>(User.class), email);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public User queryByRealName(String realName) {
		String sql = "SELECT id,real_name as realName,nick_name as nickName,phone,address,email,password FROM user WHERE real_name=?";
		try {
			return qr.query(sql, new BeanHandler<User>(User.class), realName);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public List<User> queryByRealNameLike(String keyword) {

		String sql = "SELECT * FROM user WHERE real_name LIKE ?";
		try {
			return qr.query(sql, new BeanListHandler<User>(User.class), "%" + keyword + "%");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}