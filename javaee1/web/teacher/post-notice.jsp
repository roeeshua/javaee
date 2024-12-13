<%@ page import="bean.ClassInfo" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布通知</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        textarea {
            width: 100%;
            height: 100px;
        }
        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>发布通知</h2>
    <h3>选择班级发送通知</h3>
    <%
        List<ClassInfo> createdClasses = (List<ClassInfo>) request.getAttribute("createdClasses");
        if (createdClasses != null && !createdClasses.isEmpty()) {
    %>
    <table>
        <thead>
        <tr>
            <th>班级id</th>
            <th>班级名称</th>
            <th>班级简介</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (ClassInfo cls : createdClasses) {
        %>
        <tr>
            <td><%= cls.getId() %></td>
            <td><%= cls.getName() %></td>
            <td><%= cls.getAbout() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <form action="post-notice" method="post">
        <label for="classId">班级ID:</label>
        <input type="number" id="classId" name="classId" required>
        <label for="content">通知内容:</label>
        <textarea id="content" name="content" required></textarea>
        <button type="submit">发布通知</button>
    </form>
    <%
    } else {
    %>
    <p>您还没有创建过班级。</p>
    <% } %>
</div>
</body>
</html>
