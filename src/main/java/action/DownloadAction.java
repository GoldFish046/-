package action;

import lombok.Getter;
import lombok.Setter;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import cn.hutool.core.io.FileUtil;
import utils.Result;

public class DownloadAction {
    @Getter
    @Setter
    private String flag;
    private String filename;
    private InputStream inputStream;
    private static final String filepath = "C:/Code Files/java/BooksManagerSystem_20241026/src/main/resources/img/";

    public InputStream getInputStream() throws IOException {
        return new BufferedInputStream(Files.newInputStream(Paths.get(filepath + filename)));
    }

    public String download() {
        List<String> fileNames = FileUtil.listFileNames(filepath);
        String avatar = fileNames.stream().filter(s -> s.contains(flag)).findFirst().orElse("");
        filename = new String(avatar.getBytes(), StandardCharsets.ISO_8859_1);
        return "success";
    }
}
