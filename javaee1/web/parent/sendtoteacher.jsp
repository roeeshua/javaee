<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>站内沟通</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #2c3e50;
        }
        form {
            margin-top: 20px;
        }
        select, textarea, button {
            width: 100%;
            margin-top: 10px;
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
<a href="../parentView.jsp" class="return-button">返回</a>
<div class="container">
    <h2>与老师沟通</h2>
    <form action="sendtoteacher" method="post">
        <label for="teacher">选择要发送消息的老师:</label>
        <select name="teacher" id="teacher" required>
            <%
                List<String> teachers = (List<String>) request.getAttribute("teachers");
                if (teachers != null && !teachers.isEmpty()) {
                    for (String teacher : teachers) {
            %>
            <option value="<%= teacher %>"><%= teacher %></option>
            <%
                }
            } else {
            %>
            <option disabled>暂无同班老师</option>
            <% } %>
        </select>
        <label for="message">输入消息内容:</label>
        <textarea name="message" id="message" rows="5" placeholder="输入您的消息..." required></textarea>
        <button type="submit">发送消息</button>
    </form>
</div>
</body>
</html>
