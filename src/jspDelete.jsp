<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>

<html>
<head>
<meta charset="utf8">
<title>JSP</title>
</head>

<body>
<form action="jspDelete.jsp">
<table>
<tr>
<td>Enter ID to delete</td>
<td><input type="text" name="product_id"/></td>
</tr>
<tr>
<td></td>
<td><input type="submit" value="Delete"/></td>
</tr>
</table>
</form>

<%! String driverName = "com.mysql.jdbc.Driver"; %>
<%! String url = "jdbc:mysql://localhost:3306/database1"; %>
<%! String user = "root"; %>
<%! String psw = "admin"; %>
<%
String id = request.getParameter("product_id");
if (id != null) {
Connection con = null;
PreparedStatement ps = null;
int productID = Integer.parseInt(id);
try {
Class.forName(driverName);
con = DriverManager.getConnection(url, user, psw);
String sql = "DELETE FROM Products WHERE product_id=" + productID;
ps = con.prepareStatement(sql);
int i = ps.executeUpdate();
if (i > 0) { %>
<jsp:forward page="/src/success.jsp"/>
<%
} else %>
<jsp:forward page="/src/failure.jsp"/>
<%
}
catch (SQLException sqe) {
request.setAttribute("error", sqe);
out.println(sqe);
}
}
%>
</body>
</html>