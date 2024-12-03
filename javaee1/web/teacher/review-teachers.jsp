<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>审核教师信息</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #3498db;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .btn {
            padding: 8px 16px;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin: 0 5px;
        }

        .btn-approve {
            background-color: #2ecc71;
        }

        .btn-approve:hover {
            background-color: #27ae60;
        }

        .btn-reject {
            background-color: #e74c3c;
        }

        .btn-reject:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>教师审核列表</h2>
    <%
        // 数据库连接
        String url = "jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai"; // 替换为你的数据库地址
        String username = "root";
        String password = "175617";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // 查询 is_pass = 0 的教师信息
            String query = "SELECT username, password FROM teachertable WHERE is_pass = 0";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();
    %>
    <table>
        <thead>
        <tr>
            <th>用户名</th>
            <th>密码</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                String teacherUsername = rs.getString("username");
                String teacherPassword = rs.getString("password");
        %>
        <tr id="row-<%= teacherUsername %>">
            <td><%= teacherUsername %></td>
            <td><%= teacherPassword %></td>
            <td>
                <button class="btn btn-approve" onclick="updateStatus('<%= teacherUsername %>', 'approve')">通过</button>
                <button class="btn btn-reject" onclick="updateStatus('<%= teacherUsername %>', 'reject')">不通过</button>
            </td>
        </tr>
        <%
            }
            if (!hasData) {
        %>
        <tr>
            <td colspan="3">暂无需要审核的教师信息。</td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <p>加载数据时出现错误，请稍后重试。</p>
    <%
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</div>

<script>
    function updateStatus(username, action) {
        // 使用AJAX处理通过和不通过的操作
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "update-teacher-status.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onload = function () {
            if (xhr.status === 200) {
                // 删除行
                const row = document.getElementById("row-" + username);
                if (row) row.remove();

                // 如果表格为空，则显示提示信息
                const tbody = document.querySelector("tbody");
                if (tbody.children.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="3">暂无需要审核的教师信息。</td></tr>';
                }
            } else {
                alert("操作失败，请重试！");
            }
        };
        xhr.send("username=" + username + "&action=" + action);
    }
</script>
</body>
</html>

