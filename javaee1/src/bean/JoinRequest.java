package bean;

public class JoinRequest {
    private int class_id; // 申请ID

    private int teacher_id; // 申请ID
    private String teacherUsername; // 申请教师的用户名
    private String className; // 班级名称

    // 构造方法
    public JoinRequest(int class_id,int teacher_id, String teacherUsername, String className) {
        this.class_id = class_id;
        this.teacher_id = teacher_id;
        this.teacherUsername = teacherUsername;
        this.className = className;
    }

    public int getClassId() {
        return class_id;
    }
    public int getTeacherId() {
        return teacher_id;
    }
    // 设置申请ID

    // 获取教师用户名
    public String getTeacherUsername() {
        return teacherUsername;
    }

    // 设置教师用户名
    public void setTeacherUsername(String teacherUsername) {
        this.teacherUsername = teacherUsername;
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
