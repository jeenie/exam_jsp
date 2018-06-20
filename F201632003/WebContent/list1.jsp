<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*"%>
<%@ page import="f201632003.*"%>
<%
	request.setCharacterEncoding("UTF-8");
 	List<Book> list = BookDAO.findAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
body {
	font-family: 굴림체;
}

thead th {
	background-color: #eee;
}

tr:hover td {
	background-color: #ffe;
	cursor: pointer;
}

table.table {
	margin-top: 5px;
}

select[name=od] {
	margin-right: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<h1>책목록</h1>

		<table class="table table-bordered table-condensed">
			<thead>
				<tr>
					<th>ID</th>
					<th>제목</th>
					<th>저자</th>
					<th>카테고리</th>
					<th>가격</th>
					<th>대여가능</th>
				</tr>
			</thead>
			<tbody>
				<% for(Book book : list) { %>
				<tr>
					<td><%= book.getId() %></td>
					<td><%= book.getTitle() %></td>
					<td><%= book.getAuthor() %></td>
					<td><%= book.getCategoryName() %></td>
					<td><%= book.getPrice() %></td>
					<td><%= book.isAvailable() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
</body>
</html>