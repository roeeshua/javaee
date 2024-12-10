<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>审核班级信息</title>
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
    <h2>班级审核列表</h2>
    <%
        String url = "jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai";
        String username = "root";
        String password = "175617";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            java.lang.Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            String query = "SELECT id, name, about, creator FROM classtable WHERE is_pass = 0";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();
    %>
    <table>
        <thead>
        <tr>
            <th>班级名称</th>
            <th>班级简介</th>
            <th>创建者</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                int classId = rs.getInt("id");
                String className = rs.getString("name");
                String classAbout = rs.getString("about");
                String classCreator = rs.getString("creator");
        %>
        <tr id="row-<%= classId %>">
            <td><%= className %></td>
            <td><%= classAbout %></td>
            <td><%= classCreator %></td>
            <td>
                <button class="btn btn-approve" onclick="updateStatus('<%= classId %>', 'approve')">通过</button>
                <button class="btn btn-reject" onclick="updateStatus('<%= classId %>', 'reject')">拒绝</button>
            </td>
        </tr>
        <%
            }
            if (!hasData) {
        %>
        <tr>
            <td colspan="4">暂无需要审核的班级信息。</td>
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
    function updateStatus(classId, action) {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "update-class-status.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onload = function () {
            if (xhr.status === 200) {
                const row = document.getElementById("row-" + classId);
                if (row) row.remove();

                const tbody = document.querySelector("tbody");
                if (tbody.children.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="4">暂无需要审核的班级信息。</td></tr>';
                }
            } else {
                alert("操作失败，请重试！");
            }
        };
        xhr.send("classId=" + classId + "&action=" + action);
    }
</script>
</body>
</html>
