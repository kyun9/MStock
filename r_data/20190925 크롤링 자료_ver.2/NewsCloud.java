package service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class NewsCloud {
	
	//hadoop 연동시
	//company : 주식 종목 12개
	//news : 뉴스 언론사 3개
//	public static String[] company = {"삼성SDI","현대모비스","SK하이닉스","네이버","LG전자"
//            						,"셀트리온","아모레퍼시픽","신세계","신한은행","카카오"
//            						,"S-Oil","한국콜마"};
//	public static String[] news = {"파이낸셜","한겨레","조선일보"};
//	
	@Scheduled(fixedRate=600000)
	public static void cloud() throws RserveException, IOException{
		//R코드를 source 하여 클라우드 저장 및 뉴스 기사 텍스트로 저장
		//뉴스 기사는 언론사 3개 별 주식 종목 관련
		//ex)파이낸셜_삼성SDI.txt 로 저장
		RConnection rc = new RConnection();
		rc.eval("source('c:/Rstudy/CompanyOne.R' , encoding = 'UTF-8')");
		rc.close();

//		//******************************하둡 연동 시작
//	    Configuration conf = new Configuration();
//		conf.set("fs.defaultFS", "hdfs://192.168.111.120:9000");
//		
//		//연동 후 하둡에 저장될 디렉토리 설정을 위한 변수 생성
//	    FileSystem fileSystem = FileSystem.get(conf);
//	    Path path = null;
//	    Path localPath = null;
//	    String dir = "";
//	    String localdir = "";
//	    SimpleDateFormat dayformat = new SimpleDateFormat ( "yyyyMMdd");
//	    SimpleDateFormat timeformat = new SimpleDateFormat ("HH시mm분");
//	    Date date = new Date();
//	    
//	    
//	    //종목 12개 별 날짜 및 시간 관련 디렉토리 생성 후
//	    //R 소스로 저장한 txt 파일 하둡에 저장
//	    
//	    //ex)하둡에 /삼성SDI/20190924/12시00분 으로 디렉토리 생성
//	    //그 후 Rserve 디렉토리(C:/Program Files/R/R-3.6.1/bin/x64/) 아래 txt 파일을
//	    //copyFromLocalFile 로 이동시키는 작업
//	    for(int i=0;i<company.length;i++) {
//	    	dir = "/"+company[i];
//	    	path = new Path(dir);
//		    System.out.println(path);
//		    if (!fileSystem.exists(path)) {
//			  fileSystem.mkdirs(path);
//		    }
//		    dir = dir + "/" + dayformat.format(date);
//		    path = new Path(dir);
//		    System.out.println(path);
//		    if(!fileSystem.exists(path)) {
//			  fileSystem.mkdirs(path);
//		    }
//		    dir = dir + "/" + timeformat.format(date);
//		    path = new Path(dir);
//		    System.out.println(path);
//		    fileSystem.mkdirs(path);
//		    for(int j=0;j<news.length;j++) {
//		    	localdir = "C:/Rstudy/"+ news[j] + "_" + company[i] + ".txt";
//		    	//localdir = "C:/Program Files/R/R-3.6.1/bin/x64/"+ news[j] + "_" + company[i] + ".txt";
//		    	localPath = new Path(localdir);
//		    	fileSystem.copyFromLocalFile(localPath, path);
//		    }
//	    }
//
//	    //하둡 연동 닫기
//	    fileSystem.close();	    
		System.out.println("수행 성공");
		
	}
	
	
	public static void main(String[] args) throws RserveException, IOException  {
		NewsCloud.cloud();
	}
}
