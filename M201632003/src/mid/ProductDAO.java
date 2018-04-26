package mid;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
	public static Product createProduct(ResultSet resultSet) throws SQLException {
		Product product = new Product();
		product.setId(resultSet.getInt("id"));
		product.settitle(resultSet.getString("title"));
		product.setCategoryTitle(resultSet.getString("name"));
		product.setUnitCost(resultSet.getInt("unitCost"));
		product.setQuantity(resultSet.getInt("quantity"));
		return product;
	}

	public static List<Product> findAll() throws Exception {
		String sql = "SELECT p.*, c.name " + "FROM product p LEFT JOIN category c on p.categoryId = c.id ";
		try (Connection connection = DB.getConnection("product");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Product> list = new ArrayList<Product>();
			while (resultSet.next())
				list.add(createProduct(resultSet));
			return list;
		}
	}

	public static List<Product> findAll(int currentPage, int pageSize) throws Exception {
		String sql = "SELECT p.*, c.name " + "FROM product p LEFT JOIN category c on p.categoryId = c.id " + "LIMIT ?,?";
		try (Connection connection = DB.getConnection("product");
				PreparedStatement statement = connection.prepareStatement(sql)){
			statement.setInt(1, (currentPage - 1) * pageSize);
			statement.setInt(2, pageSize);
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Product> list = new ArrayList<Product>();
				while (resultSet.next())
					list.add(createProduct(resultSet));
				return list;
			}
		}
	}

	public static List<Product> findByTitle(String title) throws Exception {
		String sql = "SELECT p.*, c.name " + "FROM product p LEFT JOIN category c on p.categoryId = c.id " + "where p.title LIKE ?" ;
		try (Connection connection = DB.getConnection("product");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, title + "%");
			try(ResultSet resultSet = statement.executeQuery()){
				ArrayList<Product> list = new ArrayList<Product>();
				while (resultSet.next())
					list.add(createProduct(resultSet));
				return list;
			}
		}
	}

	public static List<Product> findByCategoryId(int categoryId) throws Exception {
		String sql = "SELECT p.*, c.name " + "FROM product p LEFT JOIN category c on p.categoryId = c.id " + "where p.categoryId = ?" ;
		try (Connection connection = DB.getConnection("product");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, categoryId);
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Product> list = new ArrayList<Product>();
				while (resultSet.next())
					list.add(createProduct(resultSet));
				return list;
			}
		}
	}

	public static int count() throws Exception {
		String sql = "SELECT COUNT(*) FROM product";
		try (Connection connection = DB.getConnection("product");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			if (resultSet.next())
				return resultSet.getInt(1);
		}
		return 0;
	}
}