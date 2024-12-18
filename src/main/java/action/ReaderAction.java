package action;

import com.opensymphony.xwork2.ActionSupport;
import entity.Reader;
import lombok.Getter;
import lombok.Setter;
import mapper.ReaderMapper;
import utils.Result;

import java.util.List;

@Getter
@Setter
public class ReaderAction extends ActionSupport {
    Result result = new Result();
    String account;
    Reader reader;
    public String getAllReader() {
        List<Reader> AllReaderList = ReaderMapper.getAllReader();
        result = Result.success(AllReaderList);
        return "success";
    }
    public String getReaderByAccount(){
        Reader readerByName = ReaderMapper.getReaderByAccount(account);
        result=Result.success(readerByName);
        return "success";
    }

    public String deleteReaderByAccount(){
        if(ReaderMapper.deleteReaderByAccount(account)){
            result=Result.success();
            return "success";
        }
        result=Result.error("删除失败");
        return "error";
    }

    public String updataReader(){
        System.out.println(reader);
        if(ReaderMapper.updataReader(reader)){
            result=Result.success();
            return "success";
        }
        result=Result.error("修改失败");
        return "error";
    }
}
