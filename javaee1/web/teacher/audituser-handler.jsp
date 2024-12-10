<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String creatorUsername = (String) session.getAttribute("username");
    if (creatorUsername == null) {
        response.sendRedirect("index.jsp");  // 未登录时，重定向到首页
        return;
    }

    String action = request.getParameter("approve") != null ? "approve" : "reject";
    String teacherClassIds = request.getParameter(action);
    if (teacherClassIds == null) {
        out.println("<h3>无效的请求。</h3>");
        return;
    }

    // 从参数中解析出教师ID和班级ID
    String[] ids = teacherClassIds.split("_");
    int teacherId = Integer.parseInt(ids[0]);
    int classId = Integer.parseInt(ids[1]);

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

        String sql;
        if ("approve".equals(action)) {
            sql = "UPDATE teacher_class SET is_approved = TRUE WHERE teacher_id = ? AND class_id = ?";
        } else {
            sql = "DELETE FROM teacher_class WHERE teacher_id = ? AND class_id = ?";
        }

        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, teacherId);
        stmt.setInt(2, classId);

        int rows = stmt.executeUpdate();
        if (rows > 0) {
            out.println("<h3>操作成功。</h3>");
        } else {
            out.println("<h3>操作失败，请重试。</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>发生错误：" + e.getMessage() + "</h3>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="audituser.jsp">返回审核页面</a>
