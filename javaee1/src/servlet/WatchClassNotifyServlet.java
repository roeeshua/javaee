package servlet;

import bean.ClassNotify;
import dao.DelClassNotify;
import dao.DelClassNotifyImpl;
import dao.WatchClassNotifyDao;
import dao.WatchClassNotifyDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class WatchClassNotifyServlet extends HttpServlet {
    private WatchClassNotifyDao delClassNotify = new WatchClassNotifyDaoImpl();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int usercode = (int) request.getSession().getAttribute("usercode");
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<ClassNotify> notifications = delClassNotify.getSentNotifications(username,usercode);
        request.setAttribute("notifications", notifications);
        request.getRequestDispatcher("/parent/watch-class-notice.jsp").forward(request, response);
    }
}
