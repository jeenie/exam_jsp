package f201632003;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PublisherDAO {
	public static List<Publisher> findAll() throws Exception {
		String sql = "SELECT * FROM publisher";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Publisher> list = new ArrayList<Publisher>();
			while (resultSet.next()) {
				Publisher publisher = new Publisher();
				publisher.setId(resultSet.getInt("id"));
				publisher.setTitle(resultSet.getString("title"));
				list.add(publisher);
			}
			return list;
		}
	}
}
