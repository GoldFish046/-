package action;

import com.opensymphony.xwork2.ActionSupport;
import entity.Book;
import entity.Borrow;
import lombok.Getter;
import lombok.Setter;
import mapper.BorrowMapper;
import utils.Result;

import java.util.List;


@Getter
@Setter
public class BorrowAction extends ActionSupport {
    Result result = new Result();
    String account;
    Borrow  borrow;
    public String getAllBorrow() {
        List<Borrow> AllBorrowList = BorrowMapper.getAllBorrow();
        result = Result.success(AllBorrowList);
        return "success";
    }
    public String getAllMyBorrow(){
        List<Book>  myBorrowList = BorrowMapper.getAllMyBorrow(account);
        result = Result.success(myBorrowList);
        return "success";
    }
    public String borrowNewBook(){
        if(BorrowMapper.borrowNewBook(borrow)){
            result = Result.success();
            return "success";
        }else{
            result = Result.error("借阅失败");
            return "error";
        }
    }
    public String returnBook(){
        if(BorrowMapper.returnBook(borrow)){
            result = Result.success();
            return "success";
        }else{
            result = Result.error("还书失败");
            return "error";
        }
    }
}
