import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usercodeStr = request.getParameter("usercode");
        int usercode=0;
        try {
            usercode = Integer.parseInt(usercodeStr);
        } catch (NumberFormatException e) {
            // ����ת���쳣
            response.getWriter().write("��Ч�Ľ�ɫѡ��");
            return;
        }
        UserDao userService = new UserDaoImpl();
        if (UserDatabase.register(new User(username, password,usercode))) {
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "�û����Ѵ��ڣ���ѡ�������û���");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}