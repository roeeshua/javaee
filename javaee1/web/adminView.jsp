<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员管理系统</title>
    <style>
        /* 重置样式 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .success-container {
            text-align: center;
            padding: 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }

        .success-header h2 {
            color: #2c3e50;
        }

        .logout-button {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #e74c3c;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }

        .logout-button:hover {
            background-color: #c0392b;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .card {
            flex: 1;
            min-width: 250px;
            background-color: #fdfdfd;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card h5 {
            margin-bottom: 10px;
            color: #34495e;
        }

        .card p {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 15px;
        }

        .card a {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
        }

        .card a:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 登录成功信息 -->
    <div class="success-container">
        <div class="success-header">
            <h2>欢迎, 系统管理员 ${user.username} 登录成功!</h2>
        </div>
        <a href="index.jsp" class="logout-button">退出登录</a>
    </div>
    <!-- 功能模块 -->
    <div class="row">
        <!-- 审核教师信息 -->
        <div class="card">
            <h5>审核教师信息</h5>
            <p>查看并审核教师的注册信息。</p>
            <a href="teacher/review-teachers.jsp">审核教师</a>
        </div>

        <!-- 审核班级信息 -->
        <div class="card">
            <h5>审核班级信息</h5>
            <p>查看并审核教师创建的班级。</p>
            <a href="review-classes.jsp">审核班级</a>
        </div>

        <!-- 发布系统通知 -->
        <div class="card">
            <h5>发布系统通知</h5>
            <p>发布重要通知，通知将对所有用户可见。</p>
            <a href="post-notice.jsp">发布通知</a>
        </div>
    </div>
</div>
</body>
</html>
