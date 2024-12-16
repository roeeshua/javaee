<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>教师管理系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
        }
        .card {
            flex: 1;
            min-width: 250px;
            background-color: #fdfdfd;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 15px;
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
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
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
            <h2>欢迎, 教师${sessionScope.username} 登录成功!</h2>
        </div>
        <a href="index.jsp" class="logout-button">退出登录</a>
    </div>

    <!-- 功能模块 -->
    <div class="row">
        <!-- 创建班级 -->
        <div class="card">
            <h5>创建班级</h5>
            <p>创建新的班级信息，等待管理员审核后生效。</p>
            <a href="teacher/create-class.jsp">创建班级</a>
        </div>

        <!-- 加入班级 -->
        <div class="card">
            <h5>加入班级</h5>
            <p>加入已生效的班级，需班级创建者审核通过。</p>
            <a href="teacher/join-class">加入班级</a>
        </div>

        <!-- 审核加入班级的老师 -->
        <div class="card">
            <h5>老师加入班级审核</h5>
            <p>审核加入班级的老师。</p>
            <a href="teacher/audit-user">老师加入班级审核</a>
        </div>

        <!-- 审核加入班级的家长 -->
        <div class="card">
            <h5>家长加入班级审核</h5>
            <p>审核加入班级的家长。</p>
            <a href="teacher/audit-parent">家长加入班级审核</a>
        </div>

        <!-- 发布通知 -->
        <div class="card">
            <h5>发布通知</h5>
            <p>发布班级通知，通知不可修改但可以删除。</p>
            <a href="teacher/post-notice">发布通知</a>
        </div>

        <!-- 发布通知 -->
        <div class="card">
            <h5>删除通知</h5>
            <p>删除班级通知</p>
            <a href="teacher/delete-notice">删除通知</a>
        </div>

        <!-- 查看系统通知 -->
        <div class="card">
            <h5>查看系统通知</h5>
            <p>查看管理员发布的系统通知</p>
            <a href="teacher/del-system-notice">查看系统通知</a><!-- 通过管理员的删除通知的功能的doget进行一些改写得到 -->
        </div>

        <!-- 查看或查询班级通知 -->
        <div class="card">
            <h5>查看或查询班级通知</h5>
            <p>查看老师发布的班级通知，可以进行多条件查询</p>
            <a href="parent/watch-class-notice">查看或查询班级通知</a>
        </div>

        <!-- 与家长沟通 -->
        <div class="card">
            <h5>与家长沟通</h5>
            <p>通过站内消息与班级家长进行沟通交流。</p>
            <a href="teacher/sendtoparent">与家长沟通</a>
        </div>

        <!-- 查看或查询同班家长消息 -->
        <div class="card">
            <h5>查看或查询同班家长消息</h5>
            <p>查看同班家长消息，可以进行多条件查询</p>
            <a href="teacher/viewmessages">查看或查询同班家长消息</a>
        </div>
    </div>
</div>
</body>
</html>
