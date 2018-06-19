package net.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

public class UserDAO {

	public static User createUser(ResultSet resultSet) throws Exception {
		User user = new User();
		user.setId(resultSet.getInt("id"));
		user.setUserid(resultSet.getString("userid"));
		user.setPassword(resultSet.getString("password"));
		user.setName(resultSet.getString("name"));
		user.setEmail(resultSet.getString("email"));
		user.setDepartmentid(resultSet.getInt("departmentid"));
		user.setEnabled(resultSet.getBoolean("enabled"));
		user.setUserType(resultSet.getString("userType"));
		return user;
	}

	public static List<User> findAll(int currentPage, int pageSize, String ss, String st, String od) throws Exception {
		String sql = "call user_findAll(?, ?, ?, ?, ?)";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, (currentPage - 1) * pageSize);
			statement.setInt(2, pageSize);
			statement.setString(3, ss);
			statement.setString(4, st + "%");
			statement.setString(5, od);
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<User> list = new ArrayList<User>();
				while (resultSet.next()) {
					User user = createUser(resultSet);
					user.setDepartmentName(resultSet.getString("departmentName"));
					list.add(user);
				}
				return list;
			}
		}
	}

	public static int count(String ss, String st) throws SQLException, NamingException {
		String sql = "call user_count(?, ?)";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, ss);
			statement.setString(2, st);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next())
					return resultSet.getInt(1);
			}
		}
		return 0;
	}

	public static User findOne(int id) throws Exception {
		String sql = "SELECT * FROM user WHERE id = ?";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, id);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next())
					return createUser(resultSet);
			}
		}
		return null;
	}

	public static void update(User user) throws SQLException, NamingException {
		String sql = "call user_edit(?, ?, ?, ?, ?, ?)";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, user.getName());
			statement.setString(2, user.getEmail());
			statement.setInt(3, user.getDepartmentid());
			statement.setBoolean(4, user.isEnabled());
			statement.setString(5, user.getUserType());
			statement.setInt(6, user.getId());
			statement.executeUpdate();
		}
	}

	public static void insert(User user) throws SQLException, NamingException {
		String sql = "call user_create(?, ?, ?, ?, ?, ?, ?)";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, user.getUserid());
			statement.setString(2, user.getPassword());
			statement.setString(3, user.getName());
			statement.setString(4, user.getEmail());
			statement.setInt(5, user.getDepartmentid());
			statement.setBoolean(6, user.isEnabled());
			statement.setString(7, user.getUserType());
			statement.executeUpdate();
		}
	}

	public static void delete(int id) throws SQLException, NamingException {
		String sql = "DELETE FROM user WHERE id = ?";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, id);
			statement.executeUpdate();
		}
	}
}
