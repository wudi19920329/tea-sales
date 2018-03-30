package com.tea.dbHandle;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.tea.entity.Product;
import com.tea.entity.ShoppingCart;
import com.tea.entity.ShoppingCartItem;
import com.tea.enums.Category;
import com.tea.enums.Specification;
import com.tea.enums.Status;
import com.tea.enums.Varieties;
import com.tea.exception.ServiceException;
import com.tea.utils.JdbcUtils;
import com.tea.utils.PageBean;

public class ShoppingCartItemHandle {

	private QueryRunner qr = JdbcUtils.getQueryRunner();

	public void insert(ShoppingCartItem shoppingCartItem) {
		String sql = "INSERT INTO t_shopping_cart_item(product_id,shopping_cart_id,quantity,create_time,update_time) VALUES (?,?,?,?,?)";
		try {
			qr.update(sql, shoppingCartItem.getProduct().getId(), shoppingCartItem.getShoppingCart().getId(),
					shoppingCartItem.getQuantity(), shoppingCartItem.getCreateTime(), shoppingCartItem.getUpdateTime());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void updateQuantity(ShoppingCartItem shoppingCartItem) {
		String sql = "update t_shopping_cart_item set quantity=?,update_time=? where id=?";
		try {
			qr.update(sql,  shoppingCartItem.getQuantity(), new Date(),shoppingCartItem.getId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ShoppingCartItem queryBy(Integer productId,Integer shoppingCartId) {
		String sql = "select * from t_shopping_cart_item sci WHERE sci.product_id = ? AND sci.shopping_cart_id = ?";
		try {
			return qr.query(sql, new BeanHandler<ShoppingCartItem>(ShoppingCartItem.class), productId,shoppingCartId);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public ShoppingCartItem queryById(Integer id) {
		String sql = "select * from t_shopping_cart_item sci WHERE sci.id = ?";
		try {
			return qr.query(sql, new BeanHandler<ShoppingCartItem>(ShoppingCartItem.class), id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public void delete(Integer id) {
		String sql = "DELETE FROM t_shopping_cart_item WHERE id=?";
		try {
			qr.update(sql, id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	

	public PageBean<ShoppingCartItem> queryPageByCustomerId(PageBean<ShoppingCartItem> pb, Integer customerId) {
		int totalCount = this.getTotalCountBy(customerId);
		pb.setTotalCount(totalCount);
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
		String sql = "SELECT                                                \n"
				+ "	p.id productId,                                         \n"
				+ "	p.category,                                             \n"
				+ "	p.image,                                                \n"
				+ "	p.price,                                                \n"
				+ "	p.specification,                                        \n"
				+ "	p.status,                                               \n"
				+ "	p.varieties,                                            \n"
				+ "	sc.id shoppingCartId,                                   \n"
				+ "	sci.quantity quantity,                                  \n"
				+ "	sci.id shoppingCartItemId                               \n"
				+ "FROM                                                     \n"
				+ "	t_shopping_cart_item sci                                \n"
				+ "	JOIN t_product p on p.id = sci.product_id               \n"
				+ "	JOIN t_shopping_cart sc on sc.id =sci.shopping_cart_id  \n"
				+ "WHERE													\n" + "	sc.customer_id = ? limit ?,? ";
		params.add(customerId);
		params.add(index);
		params.add(count);
		try {
			// 根据当前页，查询当前页数据(一页数据)
			if (index >= 0) {
				List<ShoppingCartItem> pageData = qr.query(sql, new ResultSetHandler<List<ShoppingCartItem>>() {
					final List<ShoppingCartItem> SHOPPINGCARTITEMS = new ArrayList<ShoppingCartItem>();

					@Override
					public List<ShoppingCartItem> handle(ResultSet rs) throws SQLException {
						while(rs.next()){
							Product product = new Product();
							product.setId(rs.getInt("productId"));
							product.setCategory(Category.valueOf(rs.getString("category")));
							product.setImage(rs.getString("image"));
							product.setPrice(rs.getBigDecimal("price"));
							product.setSpecification(Specification.valueOf(rs.getString("specification")));
							product.setStatus(Status.valueOf(rs.getString("status")));
							product.setVarieties(Varieties.valueOf(rs.getString("varieties")));
							ShoppingCart shoppingCart = new ShoppingCart();
							shoppingCart.setId(rs.getInt("shoppingCartId"));
							ShoppingCartItem shoppingCartItem = new ShoppingCartItem();
							shoppingCartItem.setProduct(product);
							shoppingCartItem.setShoppingCart(shoppingCart);
							shoppingCartItem.setQuantity(rs.getInt("quantity"));
							shoppingCartItem.setId(rs.getInt("shoppingCartItemId"));
							SHOPPINGCARTITEMS.add(shoppingCartItem);
						}
						return SHOPPINGCARTITEMS;
					}
				}, params.toArray());
				// 设置到pb对象中
				pb.setPageData(pageData);
				return pb;
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return null;

	}

	public int getTotalCountBy(Integer customerId) {
		String sql = "SELECT                                                \n"
				+ "	count(1)                                         		\n"
				+ "FROM                                                       \n"
				+ "	t_shopping_cart_item sci                                \n"
				+ "	JOIN t_shopping_cart sc on sc.id =sci.shopping_cart_id  \n"
				+ "WHERE														\n" + "	sc.customer_id = ?";
		try {
			// 执行查询， 返回结果的第一行的第一列
			Long count = qr.query(sql, new ScalarHandler<Long>(), customerId);
			return count.intValue();
		} catch (Exception e) {
			throw new ServiceException("购物车产品分页查询异常");
		}
	}

}