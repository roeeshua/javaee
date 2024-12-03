import java.util.ArrayList;
import java.util.List;

public class UserDatabase {

    public static boolean register(User user) {
        UserService userService = new UserServiceImpl();
        if (userService.is_exist(user.getUsername(),user.getUsercode())) {
            return false; // 用户名已存在
        }
        userService.add_data(user.getUsername(), user.getPassword(),user.getUsercode());
        return true;
    }

    public static int login(String username, String password,int usercode) {
        UserService userService = new UserServiceImpl();
        if (userService.login(username,password,usercode)==1)
            return 1;
        else if(userService.login(username,password,usercode)==2)
            return 2;
        else
            return 0;
    }

}