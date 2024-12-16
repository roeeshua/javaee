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

@WebServlet("/teacher/sendtoparent.jsp")
public class SendToParentServlet extends HttpServlet {
    private final SendToDao sendToDao = new SendToDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        List<String> parents = sendToDao.getParentsByTeacher(username);
        request.setAttribute("parents", parents);
        request.getRequestDispatcher("/teacher/sendtoparent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sender = (String) request.getSession().getAttribute("username");
        String receiver = request.getParameter("parent");
        String message = request.getParameter("message");

        boolean success = sendToDao.sendMessage(sender, receiver, message);
        if (success) {
            response.sendRedirect("sendtoparent?status=success");
        } else {
            response.sendRedirect("sendtoparent?status=error");
        }
    }
}
