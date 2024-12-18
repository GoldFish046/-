package entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Reader {
    private String account;
    private String name;
    private String phone;
    private String email;
    private int type;
    private String flag;
    public Reader(String account, String name, String phone, String email, int type, String flag){
        this.account = account;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.type = type;
        this.flag = flag;
    }
    public Reader(){}
}
