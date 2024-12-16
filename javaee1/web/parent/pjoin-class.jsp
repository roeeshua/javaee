<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ page import="bean.ClassInfo" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        .return-button:hover {
            background-color: #c0392b;
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
    </style>
</head>
<body>
<a href="../parentView.jsp" class="return-button">返回</a>
<div class="container">
    <h2>加入班级</h2>
    <table>
        <thead>            <tr>
            <th>班级名称</th>
            <th>班级简介</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<ClassInfo> availableClasses = (List<ClassInfo>) request.getAttribute("availableClasses");
            if (availableClasses != null && !availableClasses.isEmpty()) {
                for (ClassInfo cls : availableClasses) {
        %>

        <tr>
            <td><%= cls.getName() %></td>
            <td><%= cls.getAbout() %></td>
            <td>
                <form action="pjoin-class" method="post">
                    <button type="submit" name="classId" value="<%=cls.getId()%>">申请加入</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3" style="text-align: center;">暂无可加入的班级</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>