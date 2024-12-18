package entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class User {
    private String account;
    private String password;
    private String type;
    public User(){}
    public User(String account, String password){
        this.account = account;
        this.password = password;
    }
    public User(String account, String password,String type){
        this.account = account;
        this.password = password;
        this.type=type;
    }
}
