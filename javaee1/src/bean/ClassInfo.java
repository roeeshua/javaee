package bean;

public class ClassInfo {
    private int id;          // 班级 ID
    private String name;     // 班级名称
    private String about;    // 班级简介

    // 构造函数
    public ClassInfo(int id, String name, String about) {
        this.id = id;
        this.name = name;
        this.about = about;
    }

    // Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    @Override
    public String toString() {
        return "ClassInfo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", about='" + about + '\'' +
                '}';
    }
}
