<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>加入班级</title>
    <style>
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
            width: 45%;
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
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        button {
            background-color: #3498db;
            color: #fff;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>加入班级</h2>
    <table>
        <thead>
        <tr>
            <th>班级名称</th>
            <th>班级简介</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 获取当前教师用户名（从 session 中）
            String teacherUsername = (String) session.getAttribute("username");

            if (teacherUsername == null) {
                out.println("<p>您尚未登录，请先登录。</p>");
            } else {
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

                    // 查询所有可以加入的班级信息（排除当前教师是班级创建者的班级）
                    String sql = "SELECT id, name, about, creator FROM classtable WHERE is_pass = 1 AND creator != ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, teacherUsername);

                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int classId = rs.getInt("id");
                        String className = rs.getString("name");
                        String classDescription = rs.getString("about");
        %>
        <tr>
            <td><%= className %></td>
            <td><%= classDescription %></td>
            <td>
                <form action="join-class-handler.jsp" method="post">
                    <input type="hidden" name="classId" value="<%= classId %>">
                    <button type="submit">加入班级</button>
                </form>
            </td>
        </tr>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>加载班级信息时发生错误：" + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
