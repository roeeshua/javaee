<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>创建班级</title>
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
        .container, .edit-container {
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
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        label {
            font-weight: bold;
        }
        input, textarea, button {
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        textarea {
            resize: none;
            height: 100px;
        }
        button {
            background-color: #3498db;
            color: #fff;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
        .edit-form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .return-button {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #e74c3c;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .return-button:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<!-- 创建班级的表单 -->
<a href="../teacherView.jsp" class="return-button">返回</a>
<div class="container">
    <h2>创建班级</h2>
    <form action="create-class-handler.jsp" method="post">
        <label for="className">班级名称:</label>
        <input type="text" id="className" name="className" required>

        <label for="classDescription">班级简介:</label>
        <textarea id="classDescription" name="classDescription" required></textarea>

        <button type="submit">提交</button>
    </form>
</div>

<!-- 更改班级信息的区域 -->
<div class="edit-container">
    <h2>更改待审核班级信息</h2>
    <%
        // 获取当前教师用户名（从 session 中）
        String creator = (String) session.getAttribute("username");

        if (creator == null) {
            out.println("<p>您尚未登录，请先登录。</p>");
        } else {
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

                // 查询待审核的班级信息
                String sql = "SELECT id, name, about FROM classtable WHERE creator = ? AND is_pass = 0";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, creator);

                rs = stmt.executeQuery();

                while (rs.next()) {
                    int classId = rs.getInt("id");
                    String className = rs.getString("name");
                    String classDescription = rs.getString("about");
    %>
    <form class="edit-form" action="update-class-handler.jsp" method="post">
        <input type="hidden" name="classId" value="<%= classId %>">
        <label for="className-<%= classId %>">班级名称:</label>
        <input type="text" id="className-<%= classId %>" name="className" value="<%= className %>" required>

        <label for="classDescription-<%= classId %>">班级简介:</label>
        <textarea id="classDescription-<%= classId %>" name="classDescription" required><%= classDescription %></textarea>

        <button type="submit">提交修改</button>
        <button type="reset">取消修改</button>
    </form>
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
</div>
</body>
</html>
