<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
table {
	border-collapse: collapse;
}

td {
	padding: 5px;
	border: solid 1px gray;
}
</style>
</head>
<body>
	<table>
		<% for (int i = 0; i <= 4; i += 4) { %>
				<%out.println(" <tr>"); %>
				<%for (int j = 2; j <= 5; ++j) { %>
					<td style = "background-color : <%= (i + j) == 2 || (i + j) == 4 || (i + j) == 7 || (i + j) == 9 ? "#ccffcc" : "#ffffcc"  %>">
					<%for (int k = 1; k <= 9; k++) { %>
						<% out.println((i + j) + " x " + k + " = " + (i + j) * k + "<br/>");
					}
					out.println(" </td>");

				}
				out.println(" </tr>");
			}
		%>
	</table>
</body>
</html>