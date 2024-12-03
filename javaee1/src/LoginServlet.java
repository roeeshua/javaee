import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
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
        UserService userService = new UserServiceImpl();
        if (UserDatabase.login(username, password, usercode)==1)
        {
                User user = new User(username,password,usercode);
                request.setAttribute("user", user);
                if(usercode==2){
                    request.getRequestDispatcher("teacherView.jsp").forward(request, response);
                }else if(usercode==1) {
                    request.getRequestDispatcher("parentView.jsp").forward(request, response);
                }else{
                    request.getRequestDispatcher("adminView.jsp").forward(request, response);
                }

        } else {
            if (!userService.is_exist(username,usercode)) {
                request.setAttribute("error", "用户名不存在");
            }
            else {
                if(UserDatabase.login(username, password, usercode)==0){
                    request.setAttribute("error", "审核未通过");
                }
                else request.setAttribute("error", "密码错误");
            }
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}