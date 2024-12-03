<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String action = request.getParameter("action");

    String url = "jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai"; // 替换为你的数据库地址
    String dbUsername = "root";
    String dbPassword = "175617";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        if ("approve".equals(action)) {
            // 设置 is_pass = 1
            String updateQuery = "UPDATE teachertable SET is_pass = 1 WHERE username = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, username);
            stmt.executeUpdate();
        } else if ("reject".equals(action)) {
            // 删除记录
            String deleteQuery = "DELETE FROM teachertable WHERE username = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setString(1, username);
            stmt.executeUpdate();
        }
        response.setStatus(200); // 成功
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500); // 失败
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
