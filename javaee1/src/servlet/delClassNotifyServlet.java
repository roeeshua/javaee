package servlet;

import bean.ClassNotify;
import dao.DelClassNotify;
import dao.DelClassNotifyImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/teacher/delete-notice")
public class delClassNotifyServlet extends HttpServlet {

    private DelClassNotify delClassNotify = new DelClassNotifyImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        List<ClassNotify> notifications = delClassNotify.getSentNotifications(username);
        request.setAttribute("notifications", notifications);
        request.getRequestDispatcher("/teacher/delete-notice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int notifyId = Integer.parseInt(request.getParameter("notifyId"));

        boolean success = delClassNotify.deleteNotification(notifyId);
        if (success) {
            response.sendRedirect("delete-notice?status=success");
        } else {
            response.sendRedirect("delete-notice?status=error");
        }
    }
}