package net.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

public class DepartmentDAO {
	public static Department createDepartment(ResultSet resultSet) throws SQLException {
		Department department = new Department();
		department.setId(resultSet.getInt("id"));
		department.setDepartmentName(resultSet.getString("departmentName"));
		return department;
	}
	
	public static List<Department> findAll() throws SQLException, NamingException {
		String sql = "SELECT * FROM department";
		try(Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Department> list = new ArrayList<Department>();
				while(resultSet.next())
					list.add(createDepartment(resultSet));
				return list;
		}
	}
}
