<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 获取表单数据
    int classId = Integer.parseInt(request.getParameter("classId"));
    String className = request.getParameter("className");
    String classDescription = request.getParameter("classDescription");

    // 获取当前教师用户名（从 session 中）
    String creator = (String) session.getAttribute("username");

    if (creator == null) {
        response.sendRedirect("index.jsp"); // 如果没有登录，重定向到登录页面
        return;
    }

    // 数据库连接信息
    String url = "jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai";
    String dbUsername = "root"; // 替换为你的数据库用户名
    String dbPassword = "175617"; // 替换为你的数据库密码

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // 连接数据库
        java.lang.Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // 更新班级信息
        String sql = "UPDATE classtable SET name = ?, about = ? WHERE id = ? AND creator = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, className);
        stmt.setString(2, classDescription);
        stmt.setInt(3, classId);
        stmt.setString(4, creator);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            out.println("<h3>班级信息更新成功！</h3>");
        } else {
            out.println("<h3>更新失败，请重试。</h3>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>发生错误：" + e.getMessage() + "</h3>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="create-class.jsp">返回</a>
