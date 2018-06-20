package f201632003;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	public static List<Category> findAll() throws Exception {
		String sql = "SELECT * FROM category";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Category> list = new ArrayList<Category>();
			while (resultSet.next()) {
				Category category = new Category();
				category.setId(resultSet.getInt("id"));
				category.setCategoryName(resultSet.getString("categoryName"));
				list.add(category);
			}
			return list;
		}
	}
}