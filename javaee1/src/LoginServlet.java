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
                // ����ת���쳣
                response.getWriter().write("��Ч�Ľ�ɫѡ��");
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
                request.setAttribute("error", "�û���������");
            }
            else {
                if(UserDatabase.login(username, password, usercode)==0){
                    request.setAttribute("error", "���δͨ��");
                }
                else request.setAttribute("error", "�������");
            }
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}