package bean;

public class JoinRequest {
    private int class_id; // 申请ID

    private int id; // 申请ID
    private String Username; // 申请人的用户名
    private String className; // 班级名称

    // 构造方法
    public JoinRequest(int class_id,int id, String Username, String className) {
        this.class_id = class_id;
        this.id = id;
        this.Username = Username;
        this.className = className;
    }

    public int getClassId() {
        return class_id;
    }
    public int getId() {
        return id;
    }
    // 设置申请ID

    // 获取教师用户名
    public String getUsername() {
        return Username;
    }

    // 设置教师用户名
    public void setUsername(String Username) {
        this.Username = Username;
    }

    // 获取班级名称
    public String getClassName() {
        return className;
    }

    // 设置班级名称
    public void setClassName(String className) {
        this.className = className;
    }

//    @Override
//    public String toString() {
//        return "JoinRequest{" +
//                "id=" + id +
//                ", teacherUsername='" + teacherUsername + '\'' +
//                ", className='" + className + '\'' +
//                '}';
//    }
}
