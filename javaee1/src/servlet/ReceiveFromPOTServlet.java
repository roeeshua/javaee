package servlet;

import dao.ReceiveFromDao;
import dao.ReceiveFromDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import bean.Message;

import java.io.IOException;
import java.util.List;

public class ReceiveFromPOTServlet extends HttpServlet {
    private ReceiveFromDao receiveFromDao = new ReceiveFromDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Username = (String) request.getSession().getAttribute("username");
        if (Username == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 获取收到的消息
        List<Message> messages = receiveFromDao.getMessages(Username);
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/teacher/viewmessages.jsp").forward(request, response);
    }
}
