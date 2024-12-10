<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 获取表单数据
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
    ResultSet rs = null;

    try {
        // 连接数据库
        java.lang.Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // 获取班级创建者的教师 ID
        String getTeacherIdSql = "SELECT id FROM teachertable WHERE username = ?";
        stmt = conn.prepareStatement(getTeacherIdSql);
        stmt.setString(1, creator);
        rs = stmt.executeQuery();

        int teacherId = -1;
        if (rs.next()) {
            teacherId = rs.getInt("id");
        } else {
            out.println("<h3>教师信息未找到，请确保已登录。</h3>");
            return;
        }

        // 插入班级信息
        String insertClassSql = "INSERT INTO classtable (name, about, creator, is_pass) VALUES (?, ?, ?, 0)";
        stmt = conn.prepareStatement(insertClassSql);
        stmt.setString(1, className);
        stmt.setString(2, classDescription);
        stmt.setString(3, creator);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            // 获取刚插入的班级 ID
            String getClassIdSql = "SELECT id FROM classtable WHERE name = ? AND creator = ?";
            stmt = conn.prepareStatement(getClassIdSql);
            stmt.setString(1, className);
            stmt.setString(2, creator);
            rs = stmt.executeQuery();

            int classId = 0;
            if (rs.next()) {
                classId = rs.getInt("id");
            }

            // 将班级创建者的教师 ID 插入到 teacher_class 表中
            String insertTeacherClassSql = "INSERT INTO teacher_class (teacher_id, class_id, is_approved) VALUES (?, ?, TRUE)";
            stmt = conn.prepareStatement(insertTeacherClassSql);
            stmt.setInt(1, teacherId);
            stmt.setInt(2, classId);
            stmt.executeUpdate();

            out.println("<h3>班级创建成功，等待管理员审核！</h3>");
        } else {
            out.println("<h3>班级创建失败，请重试。</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>发生错误：" + e.getMessage() + "</h3>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<a href="create-class.jsp">返回创建页面</a>
