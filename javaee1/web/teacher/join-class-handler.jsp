<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 获取当前教师的用户名
    String teacherUsername = (String) session.getAttribute("username");

    if (teacherUsername == null) {
        response.sendRedirect("index.jsp");  // 如果未登录，重定向到首页
        return;
    }

    // 获取提交的班级 ID
    String classIdParam = request.getParameter("classId");
    if (classIdParam == null || classIdParam.isEmpty()) {
        out.println("<h3>班级 ID 未传递，无法申请加入班级。</h3>");
        return;
    }

    int classId = 0;
    try {
        classId = Integer.parseInt(classIdParam);
    } catch (NumberFormatException e) {
        out.println("<h3>班级 ID 无效。</h3>");
        return;
    }

    // 数据库连接信息
    String url = "jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai";
    String dbUsername = "root";
    String dbPassword = "175617";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // 连接数据库
        java.lang.Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // 获取教师 ID
        String getTeacherIdSql = "SELECT id FROM teachertable WHERE username = ?";
        stmt = conn.prepareStatement(getTeacherIdSql);
        stmt.setString(1, teacherUsername);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            int teacherId = rs.getInt("id");

            // 查询教师是否已经申请加入该班级
            String checkSql = "SELECT * FROM teacher_class WHERE teacher_id = ? AND class_id = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setInt(1, teacherId);
            stmt.setInt(2, classId);
            ResultSet checkRs = stmt.executeQuery();

            if (checkRs.next()) {
                out.println("<h3>您已申请过加入该班级，请勿重复操作。</h3>");
            } else {
                // 插入加入班级的请求
                String insertSql = "INSERT INTO teacher_class (teacher_id, class_id, is_approved) VALUES (?, ?, FALSE)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setInt(1, teacherId);
                stmt.setInt(2, classId);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    out.println("<h3>加入班级申请成功，等待班级创建者审核！</h3>");
                } else {
                    out.println("<h3>加入班级失败，请重试。</h3>");
                }
            }
        } else {
            out.println("<h3>教师信息未找到，请确保已登录。</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>发生错误：" + e.getMessage() + "</h3>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="join-class.jsp">返回加入班级页面</a>
