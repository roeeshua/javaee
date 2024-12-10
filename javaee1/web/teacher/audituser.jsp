<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>审核加入班级请求</title>
    <style>
        /* 页面样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 20px;
            padding-top: 20px;
        }
        .container {
            width: 60%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #2c3e50;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        button {
            background-color: #3498db;
            color: #fff;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 4px;
        }
        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>加入班级审核</h2>

    <%
        String creatorUsername = (String) session.getAttribute("username");
        if (creatorUsername == null) {
            response.sendRedirect("../index.jsp");  // 如果未登录，重定向到首页
            return;
        }

        // 数据库连接信息
        String url = "jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai";
        String dbUsername = "root";
        String dbPassword = "175617";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // 连接数据库
            java.lang.Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            // 查询待审核的加入请求
            String sql = "SELECT tc.teacher_id, c.id As class_id, t.username AS teacher_name, c.name AS class_name, tc.is_approved " +
                    "FROM teacher_class tc " +
                    "JOIN teachertable t ON tc.teacher_id = t.id " +
                    "JOIN classtable c ON tc.class_id = c.id " +
                    "WHERE c.creator = ? AND tc.is_approved = FALSE";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, creatorUsername);
            rs = stmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p>没有待审核的加入班级请求。</p>");
            } else {
    %>
    <form action="audituser-handler.jsp" method="post">
        <table>
            <tr>
                <th>教师姓名</th>
                <th>班级名称</th>
                <th>操作</th>
            </tr>
            <%
                while (rs.next()) {
                    String teacherName = rs.getString("teacher_name");
                    String className = rs.getString("class_name");
                    int teacherId = rs.getInt("teacher_id");
                    int classId = rs.getInt("class_id");
            %>
            <tr>
                <td><%= teacherName %></td>
                <td><%= className %></td>
                <td>
                    <button type="submit" name="approve" value="<%= teacherId + "_" + classId %>">批准</button>
                    <button type="submit" name="reject" value="<%= teacherId + "_" + classId %>">拒绝</button>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </form>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>发生错误：" + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</div>
</body>
</html>
