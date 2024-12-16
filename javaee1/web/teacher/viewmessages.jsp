<%@ page import="bean.Message" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>家长消息</title>
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
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
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
    <h2>收到的家长消息</h2>

    <!-- 查询表单 -->
    <div class="search-container">
        <form method="get" action="">
            <div class="search-row">
                <label for="sender">根据发送者用户名查询：</label>
                <input type="text" id="sender" name="sender" placeholder="输入发送者用户名" value="<%= request.getParameter("sender") != null ? request.getParameter("sender") : "" %>">
            </div>
            <div class="search-row">
                <label for="timestamp">根据发送时间查询消息（yyyy-MM）：</label>
                <input type="text" id="timestamp" name="timestamp" placeholder="输入时间，格式yyyy-MM" value="<%= request.getParameter("timestamp") != null ? request.getParameter("timestamp") : "" %>">
            </div>
            <div class="search-row">
                <label for="content">根据内容查询消息：</label>
                <input type="text" id="content" name="content" placeholder="输入查询内容" value="<%= request.getParameter("content") != null ? request.getParameter("content") : "" %>">
            </div>
            <div class="search-row">
                <button type="submit">查询</button>
            </div>
        </form>
    </div>

    <!-- 显示消息内容 -->
    <%
        String senderQuery = request.getParameter("sender");
        String timestampQuery = request.getParameter("timestamp");
        String contentQuery = request.getParameter("content");

        List<Message> messages = (List<Message>) request.getAttribute("messages");
        if (messages != null && !messages.isEmpty()) {
            messages = messages.stream()
                    .filter(message -> (senderQuery == null || senderQuery.isEmpty() || message.getSender().contains(senderQuery)) &&
                            (timestampQuery == null || timestampQuery.isEmpty() || message.getTimestamp().toString().startsWith(timestampQuery)) &&
                            (contentQuery == null || contentQuery.isEmpty() || message.getMessage().contains(contentQuery)))
                    .toList();
        }
    %>

    <% if (messages != null && !messages.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>发送者</th>
            <th>发送时间</th>
            <th>消息内容</th>
        </tr>
        </thead>
        <tbody>
        <% for (Message message : messages) { %>
        <tr>
            <td><%= message.getSender() %></td>
            <td><%= message.getTimestamp() %></td>
            <td><%= message.getMessage() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p>当前没有符合条件的消息</p>
    <% } %>
</div>
</body>
</html>
