<%@ page import="bean.ClassInfo" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布系统通知</title>
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
    <h2>发布系统通知</h2>
    <form action="post-system-notice" method="post">
        <label for="content">通知内容:</label>
        <textarea id="content" name="content" required></textarea>
        <button type="submit">发布通知</button>
    </form>
</div>
</body>

<script>
    function postNotice() {
        var xhr = new XMLHttpRequest();
        var content = document.getElementById("content").value;

        xhr.open("POST", "post-system-notice", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                // 假设服务器返回的是一个简单的成功或失败消息
                var response = xhr.responseText;
                alert("通知已发布！");
            }
        };

        xhr.send("content=" + encodeURIComponent(content));
    }

    window.onload = function() {
        var button = document.querySelector("button[type='submit']");
        button.onclick = function(event) {
            event.preventDefault(); // 阻止表单的默认提交行为
            postNotice();
        };
    };
</script>

</html>