import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class UserDaoImpl implements UserDao {
    @Override
    public void add_data(String username, String password,int usercode){
        Connection conn = null;
        PreparedStatement preparedStatement =null;
        try{
            conn = JDBCTools.getConnection();  //����
            String statement="";
            if(usercode==1){
                statement = "insert into parentstable (username, password) values(?,?)";  //��дԤ�������
            } else if (usercode==2) {
                statement = "insert into teachertable (username, password, is_pass)values(?,?,0)";
            }
            else{
                statement = "insert into admintable (username, password) values(?,?)";  //��дԤ�������
            }
            preparedStatement = conn.prepareStatement(statement);  //��ȡ���
            //�����Ӧ�ʺŵ�ֵ
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,password);
            //ִ��mysql���
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
            conn = JDBCTools.getConnection();  //����
            String statement="";
            if(usercode==1){
                statement = "select * from parentstable where username = ?";  //��дԤ�������
            }
            else if(usercode==2){
                statement = "select * from teachertable where username = ?";  //��дԤ�������
            }else{
                statement = "select * from admintable where username = ?";  //��дԤ�������
            }
            preparedStatement = conn.prepareStatement(statement);  //��ȡ���
            //�����Ӧ�ʺŵ�ֵ
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
    public boolean is_exist(String username) {//ע��ʱȷ�����мҳ�����Ա��ʦ�û���������
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;
        try {
            conn = JDBCTools.getConnection();
            String statement = "SELECT EXISTS (SELECT 1 FROM parentstable WHERE username = ?) " +
                    "OR EXISTS (SELECT 1 FROM teachertable WHERE username = ?) " +
                    "OR EXISTS (SELECT 1 FROM admintable WHERE username = ?)";
            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, username);
            preparedStatement.setString(3, username);
            res = preparedStatement.executeQuery();
            if (res.next()) {
                return res.getBoolean(1);  // Assuming EXISTS returns a boolean
            }
        } catch (Exception e) {
            e.printStackTrace();  // Consider using a logger instead
        } finally {
            JDBCTools.release(res, preparedStatement, conn);
        }
        return false;
    }

    @Override
    public int login(String username, String password,int usercode) {
        Connection conn=null;
        PreparedStatement preparedStatement=null;
        ResultSet res=null;
        try {
            conn = JDBCTools.getConnection();  //����
            String statement="";
            if(usercode==1){
                statement = "select * from parentstable where username = ? and password = ?";  //��дԤ�������
            }
            else if(usercode==2){
                statement = "select * from teachertable where username = ? and password = ?";  //��дԤ�������
            }else {
                statement = "select * from admintable where username = ? and password = ?";  //��дԤ�������
            }
            preparedStatement = conn.prepareStatement(statement);  //��ȡ���
            //�����Ӧ�ʺŵ�ֵ
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

