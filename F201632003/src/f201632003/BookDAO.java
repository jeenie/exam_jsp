package f201632003;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

public class BookDAO {
	private static Book createBook(ResultSet resultSet) throws SQLException {
		Book book = new Book();
		book.setId(resultSet.getInt("id"));
		book.setTitle(resultSet.getString("b.title"));
		book.setAuthor(resultSet.getString("author"));
		book.setCategoryId(resultSet.getInt("categoryId"));
		book.setCategoryName(resultSet.getString("categoryName"));
		book.setPublisherName(resultSet.getString("p.title"));
		book.setPrice(resultSet.getInt("price"));
		book.setAvailable(resultSet.getBoolean("available"));
		return book;
	}

	public static List<Book> findAll() throws SQLException, NamingException {
		String sql = "SELECT b.*, c.categoryName, p.title FROM book b LEFT JOIN category c ON b.categoryId = c.id LEFT JOIN publisher p ON b.publisherId = p.id"
				+ " ORDER BY b.id";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Book> list = new ArrayList<Book>();
			while (resultSet.next())
				list.add(createBook(resultSet));
			return list;
		}
	}

	public static List<Book> findAll(int currentPage, int pageSize) throws SQLException, NamingException {
		String sql = "SELECT b.*, c.categoryName, p.title FROM book b LEFT JOIN category c ON b.categoryId = c.id LEFT JOIN publisher p ON b.publisherId = p.id"
				+ " ORDER BY b.id" + " LIMIT ?, ?";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, (currentPage - 1) * pageSize);
			statement.setInt(2, pageSize);
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Book> list = new ArrayList<Book>();
				while (resultSet.next())
					list.add(createBook(resultSet));
				return list;
			}
		}
	}
	
	public static List<Book> findAll(int currentPage, int pageSize, String ss, String st) throws SQLException, NamingException {
		String sql = "call book_findAll(?, ?, ?, ?)";
		try(Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, (currentPage - 1) * pageSize);
			statement.setInt(2, pageSize);
			statement.setString(3, ss);
			statement.setString(4, st);
			try(ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Book> list = new ArrayList<Book>();
				while(resultSet.next())
					list.add(createBook(resultSet));
				return list;
			}
		}
	}

	public static int count() throws SQLException, NamingException {
		String sql = "SELECT COUNT(id) FROM book";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			if (resultSet.next())
				return resultSet.getInt(1);
			return 0;
		}
	}
	
	public static int count(String ss, String st) throws SQLException, NamingException {
		String sql = "call book_count(?, ?)";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, ss);
			statement.setString(2, st);
			try(ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next())
					return resultSet.getInt(1);
				return 0;
			}
		}
	}

	public static Book findOne(int id) throws SQLException, NamingException {
		String sql = "SELECT b.*, c.categoryName, p.title FROM book b LEFT JOIN category c ON b.categoryId = c.id LEFT JOIN publisher p ON b.publisherId = p.id"
				+ " WHERE b.id = ?";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, id);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next())
					return createBook(resultSet);
			}
			return null;
		}
	}

	public static void update(Book book) throws SQLException, NamingException {
		String sql = "UPDATE book SET title=?, author=?, categoryId=?, publisherId=?, price=?, available=?"
				+ " WHERE id=?";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, book.getTitle());
			statement.setString(2, book.getAuthor());
			statement.setInt(3, book.getCategoryId());
			statement.setInt(4, book.getPublisherId());
			statement.setInt(5, book.getPrice());
			statement.setBoolean(6, book.isAvailable());
			statement.setInt(7, book.getId());
			statement.executeUpdate();
		}
	}
	
	public static void delete(int id) throws SQLException, NamingException {
		String sql = "DELETE FROM book WHERE id =?";
		try(Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, id);
			statement.executeUpdate();
		}
	}
}
