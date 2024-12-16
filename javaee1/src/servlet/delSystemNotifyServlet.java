package servlet;

import bean.ClassNotify;
import bean.SystemNotify;
import dao.DelClassNotify;
import dao.DelClassNotifyImpl;
import dao.DelSystemNotify;
import dao.DelSystemNotifyImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/teacher/delete-notice")
public class delSystemNotifyServlet extends HttpServlet {

    private DelSystemNotify delSystemNotify = new DelSystemNotifyImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int usercode = (int) request.getSession().getAttribute("usercode");

        if(usercode==3) {
            String username = (String) request.getSession().getAttribute("username");

            if (username == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            List<SystemNotify> notifications = delSystemNotify.getSentNotifications(username);
            request.setAttribute("notifications", notifications);
            request.getRequestDispatcher("/teacher/del-system-notice.jsp").forward(request, response);
        }else{
            String username = (String) request.getSession().getAttribute("username");

            if (username == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            List<SystemNotify> notifications = delSystemNotify.getSentNotifications();
            request.setAttribute("notifications", notifications);
            request.getRequestDispatcher("/parent/watch-system-notice.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int notifyId = Integer.parseInt(request.getParameter("notifyId"));

        boolean success = delSystemNotify.deleteNotification(notifyId);
        if (success) {
            response.sendRedirect("del-system-notice?status=success");
        } else {
            response.sendRedirect("del-system-notice?status=error");
        }
    }
}