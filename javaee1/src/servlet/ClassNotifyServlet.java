package servlet;

import bean.ClassInfo;
import dao.ClassNotifyDao;
import dao.ClassNotifyDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/teacher/post-notice")
public class ClassNotifyServlet extends HttpServlet {

    private ClassNotifyDao classNotifyDao = new ClassNotifyDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        List<ClassInfo> createdClasses = classNotifyDao.getCreatedClasses(username);
        request.setAttribute("createdClasses", createdClasses);
        request.getRequestDispatcher("/teacher/post-notice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sender = (String) request.getSession().getAttribute("username");
        int classId = Integer.parseInt(request.getParameter("classId"));
        String content = request.getParameter("content");

        boolean success = classNotifyDao.sendNotification(classId, sender, content);
        if (success) {
            response.sendRedirect("post-notice?status=success");
        } else {
            response.sendRedirect("post-notice?status=error");
        }
    }
}
