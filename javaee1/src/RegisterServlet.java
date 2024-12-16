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
            // 处理转换异常
            response.getWriter().write("无效的角色选择");
            return;
        }
        UserDao userService = new UserDaoImpl();
        if (UserDatabase.register(new User(username, password,usercode))) {
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "用户名已存在，请选择其他用户名");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}