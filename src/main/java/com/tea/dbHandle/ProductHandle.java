package com.tea.dbHandle;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.commons.lang3.StringUtils;

import com.tea.entity.Product;
import com.tea.enums.Category;
import com.tea.enums.Status;
import com.tea.exception.ServiceException;
import com.tea.utils.JdbcUtils;
import com.tea.utils.PageBean;

public class ProductHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(Product product) {
		String sql = " INSERT t_product(name,image,category,inventory,specification,price,content,status,create_time,discount_price,discounted) VALUES(?,?,?,?,?,?,?,?,?,?,?);";
		try {
			qr.update(sql, product.getName(),product.getImage(), product.getCategory().name(), 
					product.getInventory(), product.getSpecification().name(), product.getPrice(), product.getContent(),
					product.getStatus().name(), product.getCreateTime(), product.getDiscountPrice(),
					product.isDiscounted());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void delete(int id) {
		String sql = "DELETE FROM t_product WHERE id=?";
		try {
			qr.update(sql, id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void update(Product product) {
		String sql = "UPDATE t_product SET image=?,category=?,name=?,inventory=?,specification=?,price=?,content=?,status=?,create_time=?,discount_price=?,discounted=? WHERE id =?";
		try {
			qr.update(sql, product.getImage(), product.getCategory().name(), product.getName(),
					product.getInventory(), product.getSpecification().name(), product.getPrice(), product.getContent(),
					product.getStatus().name(), product.getCreateTime(), product.getDiscountPrice(),
					product.isDiscounted(), product.getId());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public List<Product> queryAll() {
		String sql = "SELECT * FROM t_product";
		try {
			return qr.query(sql, new BeanListHandler<Product>(Product.class));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public Product queryById(int id) {
		String sql = "SELECT id,name,image,category,inventory,specification,price,content,status,create_time createTime,discount_price discountPrice,discounted FROM t_product where id =?";
		try {
			return qr.query(sql, new BeanHandler<Product>(Product.class), id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public List<Product> queryByKeyword(String keyword) {
		String sql = "SELECT * FROM t_product WHERE category LIKE ?";
		try {
			return qr.query(sql, new BeanListHandler<Product>(Product.class), MessageFormat.format("%{0}%", keyword));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public List<Product> queryByCategory(Category category) {
		try {
			String sql = "SELECT * FROM t_product WHERE category =?";
			return qr.query(sql, new BeanListHandler<Product>(Product.class), category.name());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public PageBean<Product> queryPageByCategory(PageBean<Product> pb, Category category,String name , Status status) {
		int totalCount = this.getTotalCountBy(category,name,status);
		pb.setTotal(totalCount);

		List<Object> list = new ArrayList<Object>();

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
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT");
		sb.append("     	p.id,");
		sb.append("     	p.image,");
		sb.append("     	p.category,");
		sb.append("     	p.name,");
		sb.append("     	p.inventory,");
		sb.append("     	p.specification,");
		sb.append("     	p.price,");
		sb.append("     	p.content,");
		sb.append("     	p.status,");
		sb.append("     	p.create_time createTime,");
		sb.append("     	p.discount_price discountPrice,");
		sb.append("     	p.discounted");
		sb.append(" FROM ");
		sb.append("     	t_product p");
		sb.append(" WHERE 	1=1  ");
		// 判断
		if (category != null) {
			sb.append("  AND p.category = ? ");
			list.add(category.name());
		}
		if (StringUtils.isNoneBlank(name)) {
			sb.append("  AND p.name like ? ");
			list.add(MessageFormat.format("%{0}%", name));
		}
		if (status!=null) {
			sb.append("  AND p.status = ? ");
			list.add(status.name());
		}
		
		sb.append(" limit ?,? ");
		list.add(index);
		list.add(count);
	
		try {
			// 根据当前页，查询当前页数据(一页数据)
			if (index >= 0) {
				List<Product> pageData = qr.query(sb.toString(), new BeanListHandler<Product>(Product.class),
						list.toArray());
				// 设置到pb对象中
				pb.setRows(pageData);
				return pb;
			}else{
				pb.setRows(Arrays.asList());
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return null;

	}

	public int getTotalCountBy(Category category,String name,Status status) {
		StringBuilder sb = new StringBuilder();
		List<Object> list = new ArrayList<Object>();
		sb.append(" SELECT");
		sb.append("   count(1) ");
		sb.append(" FROM ");
		sb.append(" t_product p WHERE 1=1 ");
		// 判断
		if (category != null) {
			sb.append("  AND p.category = ? ");
			list.add(category.name());
		}
		if (StringUtils.isNoneBlank(name)) {
			sb.append("  AND p.name like ? ");
			list.add(MessageFormat.format("%{0}%", name));
		}
		if (status!=null) {
			sb.append("  AND p.status = ? ");
			list.add(status.name());
		}
		try {
			// 执行查询， 返回结果的第一行的第一列
			Long count = qr.query(sb.toString(), new ScalarHandler<Long>(), list.toArray());
			return count.intValue();
		} catch (Exception e) {
			throw new ServiceException("产品分页查询异常");
		}
	}
}
