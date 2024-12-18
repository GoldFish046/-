package action;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;
import utils.Result;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
@Getter
@Setter
public class UploadAction {
    private File upload;
    private String uploadContentType;
    private String uploadFileName;
    private Result result;

    public String fileupload() {
        uploadFileName = StringUtils.substringAfterLast(uploadFileName,".");
        String flag = System.currentTimeMillis() + "";
        try {
            byte[] buffer=new byte[1024];
            FileInputStream fileInputStream=new FileInputStream(upload);
            FileOutputStream fileOutputStream=new FileOutputStream("C:/Code Files/java/BooksManagerSystem_20241026/src/main/resources/img/"+flag+"."+uploadFileName);
            int len=fileInputStream.read(buffer);
            while (len>=0){
                fileOutputStream.write(buffer);
                len=fileInputStream.read(buffer);
            }
            fileInputStream.close();
            fileOutputStream.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        result=Result.success(flag);
        return "success";
    }
}
