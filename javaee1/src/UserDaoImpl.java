import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class UserDaoImpl implements UserDao {
    @Override
    public void add_data(String username, String password,int usercode){
        Connection conn = null;
        PreparedStatement preparedStatement =null;
        try{
            conn = JDBCTools.getConnection();  //¡¨Ω”
            String statement="";
            if(usercode==1){
                statement = "insert into parentstable values(?,?)";  //±‡–¥‘§±‡“Î”Ôæ‰
            } else if (usercode==2) {
                statement = "insert into teachertable values(?,?,0)";
            }
            else{
                statement = "insert into admintable values(?,?)";  //±‡–¥‘§±‡“Î”Ôæ‰
            }
            preparedStatement = conn.prepareStatement(statement);  //ªÒ»°”Ôæ‰
            //≤Â»Î∂‘”¶Œ ∫≈µƒ÷µ
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,password);
            //÷¥––mysql”Ôæ‰
            preparedStatement.execute();
        }catch (Exception e){
            e.printStackTrace();
        }
        finally {
            JDBCTools.release(preparedStatement,conn);
        }
    }

    @Override
    public boolean is_exist(String username,int usercode){
        Connection conn=null;
        PreparedStatement preparedStatement=null;
        ResultSet res=null;
        try {
            conn = JDBCTools.getConnection();  //¡¨Ω”
            String statement="";
            if(usercode==1){
                statement = "select * from parentstable where username = ?";  //±‡–¥‘§±‡“Î”Ôæ‰
            }
            else if(usercode==2){
                statement = "select * from teachertable where username = ?";  //±‡–¥‘§±‡“Î”Ôæ‰
            }else{
                statement = "select * from admintable where username = ?";  //±‡–¥‘§±‡“Î”Ôæ‰
            }
            preparedStatement = conn.prepareStatement(statement);  //ªÒ»°”Ôæ‰
            //≤Â»Î∂‘”¶Œ ∫≈µƒ÷µ
            preparedStatement.setString(1, username);
            res = preparedStatement.executeQuery();
            if (res.isBeforeFirst()) {
                return true;
            } else {
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCTools.release(res,preparedStatement,conn);
        }
        return false;
    }

    @Override
    public int login(String username, String password,int usercode) {
        Connection conn=null;
        PreparedStatement preparedStatement=null;
        ResultSet res=null;
        try {
            conn = JDBCTools.getConnection();  //¡¨Ω”
            String statement="";
            if(usercode==1){
                statement = "select * from parentstable where username = ? and password = ?";  //±‡–¥‘§±‡“Î”Ôæ‰
            }
            else if(usercode==2){
                statement = "select * from teachertable where username = ? and password = ?";  //±‡–¥‘§±‡“Î”Ôæ‰
            }else {
                statement = "select * from admintable where username = ? and password = ?";  //±‡–¥‘§±‡“Î”Ôæ‰
            }
            preparedStatement = conn.prepareStatement(statement);  //ªÒ»°”Ôæ‰
            //≤Â»Î∂‘”¶Œ ∫≈µƒ÷µ
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            res = preparedStatement.executeQuery();
            if (res.isBeforeFirst()) {
                res.next();
                if(usercode==2&&res.getInt("is_pass")==0)
                    return 0;
                else if(usercode==2&&res.getInt("is_pass")==1)
                    return 1;
                else
                    return 1;
            } else {
                return 2;
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCTools.release(res,preparedStatement,conn);
        }
        return 2;
    }
}

