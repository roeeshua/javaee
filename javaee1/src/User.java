
public class User {
    private String username;
    private String password;
    private int usercode;

    public User(String username, String password,int usercode) {
        this.username = username;
        this.password = password;
        this.usercode = usercode;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public int getUsercode(){return usercode;}
}