package com.tea.dbHandle;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.tea.entity.User;
import com.tea.utils.JdbcUtils;

public class UserHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(User user) {
		String sql = "INSERT INTO t_user(user_name,password,role,create_time,update_name) VALUES (?,?,?,?,?)";
		try {
			qr.update(sql, user.getUserName(), user.getPassword(), user.getRole().name(), user.getCreateTime(),
					user.getUpdateTime());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void update(User user) {
		String sql = "update t_user set user_name=?,password=?,role=?,create_time=?,update_name=? where id=?";
		try {
			qr.update(sql, user.getUserName(), user.getPassword(), user.getRole().name(), user.getCreateTime(),
					user.getUpdateTime(), user.getId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public User queryById(Integer id) {
		String sql = "SELECT id,user_name as userName,password as password,role,create_time as createTime,update_name as updateName  FROM t_user WHERE id=?";
		try {
			return qr.query(sql, new BeanHandler<User>(User.class), id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public User queryByUserName(String userName) {
		String sql = "SELECT id,user_name as userName,password as password,role,create_time as createTime,update_time as updateTime  FROM t_user WHERE user_name=?";
		try {
			return qr.query(sql, new BeanHandler<User>(User.class), userName);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}