
import java.util.List;

public interface UserDao {
    void add_data(String username, String password,int usercode);

    boolean is_exist(String username,int usercode);

    boolean is_exist(String username);

    int login(String username, String password,int usercode);
}
