package action;

import com.opensymphony.xwork2.ActionSupport;
import entity.Book;
import lombok.Getter;
import lombok.Setter;
import mapper.BookMapper;
import utils.Result;

import java.util.List;

@Getter
@Setter
public class BookAction extends ActionSupport {
    Result result = new Result();
    int index;
    Book newBook;

    public String getAllBook() {
        List<Book> AllBooksList = BookMapper.getAllBook();
        result = Result.success(AllBooksList);
        return "success";
    }

    public String getAllAvaBook() {
        List<Book> AllBooksList = BookMapper.getAllAvaBook();
        result = Result.success(AllBooksList);
        return "success";
    }

    public String deleteBook() {
        if (BookMapper.deleteBook(index)) {
            result = Result.success();
            return "success";
        }
        result = Result.error("删除失败");
        return "error";
    }

    public String insertNewBook(){
        if(BookMapper.insertNewBook(newBook)){
            result = Result.success();
            return "success";
        }
        result = Result.error("添加失败");
        return "error";
    }

    public String updateBook(){
        System.out.println(newBook);
        if(BookMapper.updateBook(newBook)){
            result = Result.success();
            return "success";
        }
        result = Result.error("修改失败");
        return "error";
    }
}
