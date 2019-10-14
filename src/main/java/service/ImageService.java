package service;

import java.io.*;

import javax.servlet.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.multipart.*;

@Service
public class ImageService {
	
	@Autowired
	ServletContext context;
	
	public String getPath(MultipartFile file, String id) throws IllegalStateException, IOException {
		String path = context.getRealPath("/") + "resources/images/profile/" + id + ".png";
		String fileName = id+".png";
		System.out.println(path);
		file.transferTo(new File(path));
		return fileName;
	}
}
