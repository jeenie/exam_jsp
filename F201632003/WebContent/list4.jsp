<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*"%>
<%@ page import="f201632003.*"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>
<%
	int currentPage = 1;
	int pageSize = 10;
	request.setCharacterEncoding("UTF-8");
	
	String pg = request.getParameter("pg");
	if (pg != null) currentPage = ParseUtils.parseInt(pg, 1);

	String ss = request.getParameter("ss"); 
	String st = request.getParameter("st"); 
	if (ss == null) ss = "0"; 
	if (st == null) st = ""; 
	String stEncoded = URLEncoder.encode(st, "UTF-8");
	
	int recordCount = BookDAO.count(ss, st);
	int lastPage = Math.max(1, (recordCount + pageSize - 1) / pageSize);
	if (currentPage > lastPage) currentPage = lastPage;
	
	List<Book> list = BookDAO.findAll(currentPage, pageSize, ss, st);
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
		<form class="form-inline">
			<div class="form-group">
				<select name="ss" class="form-control">
					<option value="0" <%= "0".equals(ss) ? "selected" : "" %>>전체</option>
					<option value="1" <%= "1".equals(ss) ? "selected" : "" %>>제목</option>
					<option value="2" <%= "2".equals(ss) ? "selected" : "" %>>카테고리</option>
				</select>
				<input type="text" class="form-control" name="st" value="<%= st %>" />
			</div>
			<button type="submit" class="btn btn-primary">조회</button>
			<a href="list4.jsp?pg=1" class="btn btn-default"> 
			검색취소 
			</a>
		</form>
		<table class="table table-bordered table-condensed">
			<thead>
				<tr>
					<th>ID</th>
					<th>제목</th>
					<th>저자</th>
					<th>카테고리</th>
					<th>출판사</th>
					<th>가격</th>
					<th>대여가능</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Book book : list) {
				%>

				<tr data-url="edit3.jsp?id=<%=book.getId()%>&pg=<%=currentPage%>">
					<td><%=book.getId()%></td>
					<td><%=book.getTitle()%></td>
					<td><%=book.getAuthor()%></td>
					<td><%=book.getCategoryName()%></td>
					<td><%=book.getPublisherName()%></td>
					<td><%=book.getPrice()%></td>
					<td><%=book.isAvailable()==true ? "O" : ""%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>

		<my:pagination pageSize="<%= pageSize %>"
			recordCount="<%= recordCount %>" queryStringName="pg" />

	</div>
	<script> $("[data-url]").click(function() { var url = $(this).attr("data-url"); location.href = url; }) </script>
</body>
</html>