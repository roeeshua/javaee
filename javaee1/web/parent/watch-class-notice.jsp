<%@ page import="bean.ClassNotify" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>班级通知</title>
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
        .search-container {
            margin-bottom: 20px;
        }
        .search-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .search-row label {
            flex: 1;
            margin-right: 10px;
            font-weight: bold;
        }
        .search-row input {
            flex: 2;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-row button {
            flex: 1;
            margin-left: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>班级通知</h2>

    <!-- 查询表单 -->
    <div class="search-container">
        <form method="get" action="">
            <div class="search-row">
                <label for="className">根据班级名字查询消息：</label>
                <input type="text" id="className" name="className" placeholder="输入班级名字" value="<%= request.getParameter("className") != null ? request.getParameter("className") : "" %>">
            </div>
            <div class="search-row">
                <label for="senderName">根据发送者用户名查询消息：</label>
                <input type="text" id="senderName" name="senderName" placeholder="输入发送者用户名" value="<%= request.getParameter("senderName") != null ? request.getParameter("senderName") : "" %>">
            </div>
            <div class="search-row">
                <label for="content">根据内容查询消息：</label>
                <input type="text" id="content" name="content" placeholder="输入通知内容" value="<%= request.getParameter("content") != null ? request.getParameter("content") : "" %>">
            </div>
            <div class="search-row">
                <button type="submit">查询</button>
            </div>
        </form>
    </div>

    <!-- 显示通知内容 -->
    <%
        String classNameQuery = request.getParameter("className");
        String senderNameQuery = request.getParameter("senderName");
        String contentQuery = request.getParameter("content");

        List<ClassNotify> notifications = (List<ClassNotify>) request.getAttribute("notifications");
        if (notifications != null && !notifications.isEmpty()) {
            notifications = notifications.stream()
                    .filter(notification -> (classNameQuery == null || classNameQuery.isEmpty() || notification.getClassname().contains(classNameQuery)) &&
                            (senderNameQuery == null || senderNameQuery.isEmpty() || notification.getSender().contains(senderNameQuery)) &&
                            (contentQuery == null || contentQuery.isEmpty() || notification.getContent().contains(contentQuery)))
                    .toList();
        }
    %>

    <% if (notifications != null && !notifications.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>通知ID</th>
            <th>班级ID</th>
            <th>班级名称</th>
            <th>通知发送者</th>
            <th>通知内容</th>
        </tr>
        </thead>
        <tbody>
        <% for (ClassNotify notification : notifications) { %>
        <tr>
            <td><%= notification.getId() %></td>
            <td><%= notification.getClassId() %></td>
            <td><%= notification.getClassname() %></td>
            <td><%= notification.getSender() %></td>
            <td><%= notification.getContent() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p>当前没有符合条件的班级通知</p>
    <% } %>
</div>
</body>
</html>
