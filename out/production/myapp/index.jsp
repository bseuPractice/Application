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
PreparedStatement ps = null;
%>

<h2 align="center"><font color="#FF00FF"><strong>Select query in JSP</strong></h2>
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
connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
statement = connection.createStatement();
String sql = "SELECT * FROM Products;";
if (connection == null) {%>
<script>alert("Connection is null");</script>
<%
}
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

<form action="index.jsp">
    <table>
        <tr>
            <td>Enter ID to delete</td>
            <td><input name="product_id"/></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="Delete"/></td>
        </tr>
    </table>
</form>

<%
String id = request.getParameter("product_id");
if (id != null && connection != null) {

    try {

        int productID = Integer.parseInt(id);
        String sqlDelete = "DELETE FROM Products WHERE product_id=" + productID + ";";
        statement = connection.createStatement();
        int i = statement.executeUpdate(sqlDelete);
        %>
<script>document.location.href = "/src/index.jsp";</script>
        <%
            if (i > 0){
                out.println("Product wasn't deleted.");
            }

    } catch (Exception e) {
%>
    <script>alert("Cannot do this, check your database manually.");</script>
<%
    }
}
%>



<form action="index.jsp">
    <table>
        <tr>
            <td>Enter Name and Price to Insert</td>
            <td><input name="product_name"/></td>
            <td><input name="product_price"/></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="Insert"/></td>
        </tr>
    </table>
</form>

<%
String productName = request.getParameter("product_name");
String productPrice = request.getParameter("product_price");
if (productName != null && productPrice != null && connection != null) {

    try {

        float productPriceFloat = Float.parseFloat(productPrice);
        String sqlInsert = "insert into products (product_name, price) values ('" + productName + "', " + productPriceFloat + ");";
        ps = connection.prepareStatement(sqlInsert);
        ps.executeUpdate();
%>
<script>document.location.href = "/src/index.jsp";</script>
<%
} catch (SQLException sqe) {
%>
    <script>alert("Cannot do this, check your database manually.")</script>
<%
}
}
%>

<form action="index.jsp">
    <table>
        <tr>
            <td>Enter Name, Price, ID to Update</td>
            <td><input name="name"/></td>
            <td><input name="price"/></td>
            <td><input name="id"/></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="Update"/></td>
        </tr>
    </table>
</form>

<%
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String idUp = request.getParameter("id");
    if (idUp != null && name != null && price != null && connection != null) {

        try {

            float priceFloat = Float.parseFloat(price);
            String sqlUpdate = "update products set product_name = '" + name + "', price = " + priceFloat +
                     " where product_id = " + idUp + ";";
            statement = connection.createStatement();
            int i = statement.executeUpdate(sqlUpdate);

%>
<script>document.location.href = "/src/index.jsp";</script>
<%
    if (i == 0){
        out.println("Product wasn't updated.");
    }
} catch (Exception sqe) {
%>
<script>alert("Cannot do this, check your database manually.")</script>
<%
        }
    }
%>

</body>
</html>