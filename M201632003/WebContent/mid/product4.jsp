<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, mid.*"%>
<%
String s = request.getParameter("categoryId");
int categoryId = (s == null) ? -1 : Integer.parseInt(s);
List<Product> list;
if (categoryId == 0)
	list = ProductDAO.findAll();
else
	list = ProductDAO.findByCategoryId(categoryId);
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
thead th {
	background-color: #eee;
}

table.table {
	width: 700px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<h1>제품목록</h1>
		<form class="form-inline">
			<div class="form-group">
				<label>제품유형</label> 
				<label><input type="radio" name="categoryId"
						value="0" <%=categoryId == 0 ? "checked" : ""%> /> 전체</label>
					<% for(Category c : CategoryDAO.findAll()) { %>
					<label><input type="radio" name="categoryId"
						value="<%= c.getId() %>"
						<%=categoryId == c.getId() ? "checked" : ""%> /> <%= c.getName() %></label>
					<% } %>
			</div>
			<button type="submit" class="btn btn-primary">조회</button>
		</form>
		<table class="table table-bordered table-condensed">
			<thead>
				<tr>
					<th>id</th>
					<th>제품명</th>
					<th>카테고리</th>
					<th>가격</th>
					<th>수량</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Product product : list) {
				%>
				<tr>
					<td><%=product.getId()%></td>
					<td><%=product.getTitle()%></td>
					<td><%=product.getCategoryTitle() %></td>
					<td><%=product.getUnitCost() %></td>
					<td><%=product.getQuantity() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
</body>
</html>