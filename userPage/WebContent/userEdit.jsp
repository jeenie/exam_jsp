<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*"%>
<%@ page import="net.user.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String 에러메시지 = null;
	
	String s1 = request.getParameter("id");
	int id = ParseUtils.parseInt(s1, 0);
	
	String pg = request.getParameter("pg");
	String ss = request.getParameter("ss");
	String st = request.getParameter("st");
	if(ss == null) ss = "0";
	if(st == null) st = "";
	String stEncoded = URLEncoder.encode(st, "UTF-8");
	
	String od = request.getParameter("od");
	User user = null;
	
	if(request.getMethod().equals("GET"))
		user = UserDAO.findOne(id);
	else {
		user = new User();
		user.setId(id);
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));
		String s2 = request.getParameter("departmentId");
		user.setDepartmentid(ParseUtils.parseInt(s2, 1));
		String s3 = request.getParameter("enabled");
		user.setEnabled(s3 != null);
		user.setUserType(request.getParameter("userType"));
		
		if(user.getName() == null || user.getName().length() == 0)
			에러메시지 = "이름을 입력하세요.";
		else if(user.getEmail() == null || user.getEmail().length() == 0)
			에러메시지 = "이메일을 입력하세요.";
		else {
			UserDAO.update(user);
			response.sendRedirect("userList.jsp?pg=" + pg + "&ss=" + ss+ "&st=" + stEncoded + "&od="+ od);
			return;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style> 
		body { font-family: 굴림체; } 
		input.form-control, select.form-control { width: 200px; }
	</style>
</head>
<body>
	<h1>사용자 등록</h1>
	<hr/>
	<form method="post">
		<div class="form-group">
			<label>이름</label>
			<input type="text" class="form-control" name="name" value="<%=user.getName() %>"/>
		</div>
		<div class="form-group">
			<label>이메일</label>
			<input type="email" class="form-control" name="email" value="<%=user.getEmail() %>" />
		</div>
		<div class="form-group">
			<label>학과</label>
			<select class="form-control" name="departmentId">
				<% for (Department d : DepartmentDAO.findAll()) {%>
					<% String selected = user.getDepartmentid() == d.getId() ? "selected" : ""; %>
					<option value="<%= d.getId()%>" <%= selected %>>
						<%= d.getDepartmentName() %>
					</option>
				<% } %>
			</select>
		</div>
		<div class="form-group">
			<label>Enabled
				<input type="checkbox" name="enabled" <%= user.isEnabled() ? "checked" : "" %>/>
			</label>
		</div>
		<div class="form-group">
			<label>사용자 유형</label>
				<input type="radio" name="userType" value="관리자" <%= user.getUserType().equals("관리자") ? "checked" : "" %> /> 관리자
				<input type="radio" name="userType" value="교수" <%= user.getUserType().equals("교수") ? "checked" : "" %> /> 교수
				<input type="radio" name="userType" value="교직원" <%= user.getUserType().equals("교직원") ? "checked" : "" %> /> 교직원
				<input type="radio" name="userType" value="학생" <%= user.getUserType().equals("학생") ? "checked" : "" %> /> 학생
		</div>
		<button type="submit" class="btn btn-primary">
			<i class="glyphicon glyphicon-ok"></i> 저장
		</button>
		<a href="userDelete.jsp?id=<%= id %>&pg=<%= pg %>&ss=<%= ss %>&st=<%=stEncoded %>&od=<%=od %>" class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?')">
			<i class="glyphicon glyphicon-trash"></i> 삭제
		</a>
		<a href="userList.jsp?pg=<%= pg %>&ss=<%= ss %>&st=<%=stEncoded %>&od=<%=od %>" class="btn btn-default">
			<i class="glyphicon glyphicon-list"></i> 목록으로
		</a>
	</form>
	<hr/>
	<% if(에러메시지 != null) { %>
		<div class="alert alert-danger">
			사용자등록 실패: <%= 에러메시지 %>
		</div>
	<% } %>
</body>
</html>