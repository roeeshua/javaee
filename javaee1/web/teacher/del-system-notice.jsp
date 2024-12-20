<%@ page import="bean.SystemNotify" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>删除通知</title>
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
        button {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>删除已发布的通知</h2>
    <%
        List<SystemNotify> notifications = (List<SystemNotify>) request.getAttribute("notifications");
        if (notifications != null && !notifications.isEmpty()) {
    %>
    <table>
        <thead>
        <tr>
            <th>通知ID</th>
            <th>通知内容</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (SystemNotify notification : notifications) {
        %>
        <tr>
            <td><%= notification.getId() %></td>
            <td><%= notification.getContent() %></td>
            <td>
                <form action="del-system-notice" method="post" style="display:inline;">
                    <input type="hidden" name="notifyId" value="<%= notification.getId() %>">
                    <button type="submit">删除</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <%
    } else {
    %>
    <p>您还没有发送过通知。</p>
    <% } %>
</div>
</body>
</html>
