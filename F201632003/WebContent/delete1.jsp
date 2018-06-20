<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*"%>
<%@ page import="f201632003.*"%>
<%
	String s1 = request.getParameter("id");
	int id = ParseUtils.parseInt(s1, 0);
	String pg = request.getParameter("pg");
	
	BookDAO.delete(id);
	response.sendRedirect("list3.jsp?pg=" + pg);
%>