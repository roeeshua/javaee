package servlet;

import bean.ClassInfo;
import dao.JoinClassDao;
import dao.PJoinClassDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
public class PJoinClassServlet extends HttpServlet {

    private JoinClassDao joinClassDao = new PJoinClassDaoImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");

        System.out.println(username);
        if (username == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<ClassInfo> availableClasses = joinClassDao.getAvailableClasses(username);
        request.setAttribute("availableClasses", availableClasses);
        request.getRequestDispatcher("/parent/pjoin-class.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = (String) req.getSession().getAttribute("username");
        String classId = req.getParameter("classId");
        JoinClassDao joinClassDao = new PJoinClassDaoImpl();
        joinClassDao.applyToJoinClass(username, Integer.parseInt(classId));
        resp.sendRedirect("pjoin-class");
    }
}