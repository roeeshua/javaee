import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usercodeStr = request.getParameter("usercode");
        int usercode = 0;

        try {
            usercode = Integer.parseInt(usercodeStr);
        } catch (NumberFormatException e) {
            response.getWriter().write("��Ч�Ľ�ɫѡ��");
            return;
        }

        UserDao userDao = new UserDaoImpl();

        if (UserDatabase.login(username, password, usercode) == 1) {
            // �����û����� session
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("usercode", usercode);

            // ���ݽ�ɫ��ת����ͬҳ��
            if (usercode == 2) {
                request.getRequestDispatcher("teacherView.jsp").forward(request, response);
            } else if (usercode == 1) {
                request.getRequestDispatcher("parentView.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("adminView.jsp").forward(request, response);
            }
        } else {
            if (!userDao.is_exist(username, usercode)) {
                request.setAttribute("error", "�û���������");
            } else {
                if (UserDatabase.login(username, password, usercode) == 0) {
                    request.setAttribute("error", "���δͨ��");
                } else {
                    request.setAttribute("error", "�������");
                }
            }
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
