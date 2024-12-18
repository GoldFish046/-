package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import entity.User;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import mapper.UserMapper;
import utils.MD5util;
import utils.Result;

import java.util.List;

@Getter
@Setter
@ToString
public class UserAction extends ActionSupport {
    User user;
    Result result = Result.error("账号或密码不能为空");

    public String getAllUser() {
        List<User> AllUserList = UserMapper.getAllUser();
        result = Result.success(AllUserList);
        return "success";
    }

    public String register() {
        if (user == null || user.getAccount().isEmpty() || user.getPassword().isEmpty()) {
            result = Result.error("账号或密码不能为空");
            return "input";
        }
        User tempUser = UserMapper.getUserByAccount(user.getAccount());
        if (tempUser != null) {
            result = Result.error("用户名已存在");
            return "input";
        } else {
            user.setPassword(MD5util.stringToMD5(user.getPassword()));
            result = Result.success();
            return UserMapper.newUser(user);
        }
    }

    public String login() {
        if (user.getAccount().isEmpty() || user.getPassword().isEmpty()) {
            result = Result.error("账号或密码不能为空");
            return "input";
        }
        user.setPassword(MD5util.stringToMD5(user.getPassword()));
        User tempUser = UserMapper.loginInspection(user);
        if (tempUser != null) {
            tempUser=UserMapper.getUserByAccount(tempUser.getAccount());
            if (tempUser != null) {
                tempUser.setPassword(null);
            }
            result = Result.success(tempUser);
            return "success";
        } else {
            result = Result.error("用户名或密码错误");
            return "login";
        }
    }
}
