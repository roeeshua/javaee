package servlet;
import bean.ClassInfo;
import dao.SystemNotifyDao;
import dao.SystemNotifyDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/teacher/post-notice")
public class SystemNotifyServlet extends HttpServlet {

    private SystemNotifyDao systemNotifyDao = new SystemNotifyDaoImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("post-system-notice.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sender = (String) request.getSession().getAttribute("username");
        String content = request.getParameter("content");

        boolean success = systemNotifyDao.sendNotification(sender, content);
        if (success) {
            response.sendRedirect("post-notice?status=success");
        } else {
            response.sendRedirect("post-notice?status=error");
        }
    }
}
