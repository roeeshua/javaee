public class UserServiceImpl implements UserService{
    UserDao userDao = new UserDaoImpl();
    @Override
    public void add_data(String username, String password,int usercode) {
        userDao.add_data(username,password,usercode);
    }

    @Override
    public boolean is_exist(String username,int usercode) {
        return userDao.is_exist(username,usercode);
    }

    @Override
    public int login(String username, String password,int usercode) {
        return userDao.login(username,password,usercode);
    }
}
