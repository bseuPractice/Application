<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "database1";
String userId = "root";
String password = "admin";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<h2 align="center"><font color="#FF00FF"><strong>Select query in JSP</strong></font></h2>
<table align="center" cellpadding="4" cellspacing="4">
<tr>

</tr>
<tr bgcolor="#008000">
<td><b>Id</b></td>
<td><b>Name</b></td>
<td><b>Price</b></td>
</tr>
<%
try {
connection = DriverManager.getConnection(
connectionUrl + dbName, userId, password);
statement = connection.createStatement();
String sql = "SELECT * FROM products";

resultSet = statement.executeQuery(sql);
while (resultSet.next()) {
%>
<tr bgcolor="#8FBC8F">

<td><%=resultSet.getString("product_id")%></td>
<td><%=resultSet.getString("product_name")%></td>
<td><%=resultSet.getString("price")%></td>

</tr>

<%
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>

