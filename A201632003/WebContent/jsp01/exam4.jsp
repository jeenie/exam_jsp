<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
input.form-control {
	width: 200px;
}
</style>
</head>
<body>
		<%
		String s1 =request.getParameter("number1");
		if(s1 == null) 
			s1 ="-1";
		int number = Integer.parseInt(s1);
		number++;
		%>
		
	<div class="container">
		<form>
			<div class="form-group">
				<label>number1:</label> <input type="number" name="number1"
					class="form-control" value="<%= number %>" />
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-primary" name="cmd" value="확인">
			</div>
		</form>
	</div>
</body>
</html>
