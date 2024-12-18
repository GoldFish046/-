package utils;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Result {

    static final int SUCCESS = 1;
    static final int ERROR = 0;

    int code;
    String msg;
    Object data;

    public static Result success() {
        Result result = new Result();
        result.setCode(SUCCESS);
        return result;
    }

    public static Result success(Object data) {
        Result result = new Result();
        result.setCode(SUCCESS);
        result.setData(data);
        return result;
    }

    public static Result error(String msg) {
        Result result = new Result();
        result.setCode(ERROR);
        result.setMsg(msg);
        return result;
    }
}
