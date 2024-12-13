package servlet;

import bean.JoinRequest;
import dao.AuditUserDao;
import dao.AuditUserDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/teacher/audit-user")
public class AuditUserServlet extends HttpServlet {

    private AuditUserDao auditUserDao = new AuditUserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<JoinRequest> joinRequests = auditUserDao.getPendingRequests(username);
        request.setAttribute("joinRequests", joinRequests);
        request.getRequestDispatcher("/teacher/audit-user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.startsWith("approve_")) {
            int classId = Integer.parseInt(action.split("_")[1]);
            int teacherId = Integer.parseInt(action.split("_")[2]);
            auditUserDao.approveRequest(classId,teacherId);
        } else if (action != null && action.startsWith("reject_")) {
            int classId = Integer.parseInt(action.split("_")[1]);
            int teacherId = Integer.parseInt(action.split("_")[2]);
            auditUserDao.rejectRequest(classId,teacherId);
        }
        response.sendRedirect("audit-user");
    }
}
