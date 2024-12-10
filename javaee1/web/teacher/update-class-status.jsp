<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String classId = request.getParameter("classId");
    String action = request.getParameter("action");

    String url = "jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai";
    String dbUsername = "root";
    String dbPassword = "175617";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        java.lang.Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        if ("approve".equals(action)) {
            // 更新is_pass为1
            String updateQuery = "UPDATE classtable SET is_pass = 1 WHERE id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setInt(1, Integer.parseInt(classId));
            stmt.executeUpdate();
        } else if ("reject".equals(action)) {
            // 删除班级记录
            String deleteQuery = "DELETE FROM classtable WHERE id = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, Integer.parseInt(classId));
            stmt.executeUpdate();
        }
        response.setStatus(200); // 操作成功
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500); // 操作失败
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
