package servlet;

import dao.SendToDao;
import dao.SendToDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/parent/sendtoteacher.jsp")
public class SendToTeacherServlet extends HttpServlet {
    private final SendToDao sendToDao = new SendToDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        List<String> teachers = sendToDao.getTeachersByParent(username);
        request.setAttribute("teachers", teachers);
        request.getRequestDispatcher("/parent/sendtoteacher.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sender = (String) request.getSession().getAttribute("username");
        String receiver = request.getParameter("teacher");
        String message = request.getParameter("message");

        boolean success = sendToDao.sendMessage(sender, receiver, message);
        if (success) {
            response.sendRedirect("sendtoteacher?status=success");
        } else {
            response.sendRedirect("sendtoteacher?status=error");
        }
    }
}
