public class UserDatabase {
    public static boolean register(User user) {
        UserDao userDao = new UserDaoImpl();
        if (userDao.is_exist(user.getUsername())) {
            return false; // 用户名已存在
        }
        userDao.add_data(user.getUsername(), user.getPassword(),user.getUsercode());
        return true;
    }

    public static int login(String username, String password,int usercode) {
        UserDao userDao = new UserDaoImpl();
        if (userDao.login(username,password,usercode)==1)
            return 1;
        else if(userDao.login(username,password,usercode)==2)
            return 2;
        else
            return 0;
    }

}