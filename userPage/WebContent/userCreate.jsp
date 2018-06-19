<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*"%>
<%@ page import="net.user.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String 에러메시지 = null;
	
	String pg = request.getParameter("pg");
	String ss = request.getParameter("ss");
	String st = request.getParameter("st");
	if(ss == null) ss = "0";
	if(st == null) st = "";
	String stEncoded = URLEncoder.encode(st, "UTF-8");
	
	String od = request.getParameter("od");
	User user = new User();
	
	if(request.getMethod().equals("GET")) {
		user.setUserid("");
		user.setPassword("");
		user.setName("");
		user.setEmail("");
		user.setEnabled(false);
		user.setUserType("");
	}
	else {
		user = new User();
		user.setUserid(request.getParameter("userid"));
		user.setPassword(request.getParameter("password"));
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));
		String s2 = request.getParameter("departmentId");
		user.setDepartmentid(ParseUtils.parseInt(s2, 1));
		String s3 = request.getParameter("enabled");
		user.setEnabled(s3 != null);
		user.setUserType(request.getParameter("userType"));
		
		if(user.getUserid() == null || user.getUserid().length() == 0)
			에러메시지 = "아이디를 입력하세요.";
		else if(user.getPassword() == null || user.getPassword().length() == 0)
			에러메시지 = "비밀번호를 입력하세요.";
		else if(user.getName() == null || user.getName().length() == 0)
			에러메시지 = "이름을 입력하세요.";
		else if(user.getEmail() == null || user.getEmail().length() == 0)
			에러메시지 = "이메일을 입력하세요.";
		else if(request.getParameter("userType") == null || user.getUserType().length() == 0)
			에러메시지 = "사용자 유형을 선택하세요.";
		else {
			UserDAO.insert(user);
			response.sendRedirect("userList.jsp?pg=999999");
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
			<label>아이디</label>
			<input type="text" class="form-control" name="userid" value="<%=user.getUserid() %>"/>
		</div>
		<div class="form-group">
			<label>비밀번호</label>
			<input type="text" class="form-control" name="password" value="<%=user.getPassword() %>"/>
		</div>
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