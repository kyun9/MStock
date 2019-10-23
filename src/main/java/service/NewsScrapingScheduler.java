  
package service;

import java.io.*;
import java.lang.reflect.*;
import java.text.*;
import java.util.*;

import javax.servlet.*;

import org.rosuda.REngine.*;
import org.rosuda.REngine.Rserve.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.scheduling.annotation.*;
import org.springframework.stereotype.*;

import com.google.gson.*;  
import com.google.gson.reflect.*;

import vo.*;

@Service
public class NewsScrapingScheduler {
	@Value("#{config['rsource.newsUpload']}")
	String rsource_location;
	@Autowired
	ServletContext context;
	
	static HashMap<String, Integer> map = new HashMap<>();
	// 회사 종목 코드 배열
	static String[] code = { "006400", "000660", "012330", "035420", "066570", "068270", "090430", "004170", "055550",
			"035720", "010950", "161890" };

	@Scheduled(fixedRate = 600000)
	public  void createNews() {
		System.out.println("test 시작");
		RConnection r = null;
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); // 파일명을 현재 연도-월-일-시-분으로 설정
		Gson gson = null;
		Type voListType = null;
		List<NewsRecode> newsRecode = null;
		List<NewCapsule> newCapsule = null;

		// 파일명 지정 및 생성
		String FileName = format1.format(System.currentTimeMillis());
		String path = context.getRealPath("/").replaceAll("\\\\","/")+"resources/json/";
		String folderPath = context.getRealPath("/")+"/resources/json";
		File filePath = new File(path + FileName + ".json");
		File folder = new File(folderPath);
		//폴더 존재 여부
		if(!folder.exists()) {
			folder.mkdir(); 
			System.out.println("폴더가 생성되었습니다.");
		}
		try {
			r = new RConnection();
			gson = new GsonBuilder().setPrettyPrinting().create();
			
			// 만일 파일이 존재하지 않으면
			if (!filePath.exists()) {
				System.out.println("파일 없음");
				newCapsule = new ArrayList<NewCapsule>();
				newsRecode = new ArrayList<NewsRecode>();

				// 회사개수 12개 만큼 반복
				for (int h = 0; h < code.length; h++) {
					newsRecode = new ArrayList<NewsRecode>();
					r.eval("code = '" + code[h] + "'");
					r.eval("source("+rsource_location+")");
					RList list = r.eval("navereco_info").asList();
					
					// 크롤링 결과인 dataframe을 받아 놓을 articleItem 2차원 배열
					String[][] articleItem = new String[4][10];

					// 항목 개수 4개 (title/press/time/content) 배열에 추가
					for (int i = 0; i < 4; i++) {
						articleItem[i] = list.at(i).asStrings();
					}

					// 종목 코드별 10개 기사 객체리스트에 추가
					for (int j = 0; j < 10; j++) {
						// map에 추가
						System.out.println(articleItem[0][j]);
						System.out.println(articleItem[1][j]);
						System.out.println(articleItem[2][j]);
						System.out.println(articleItem[3][j]);
						map.put(articleItem[0][j], 1);
						newsRecode.add(new NewsRecode(articleItem[0][j], articleItem[1][j], articleItem[2][j],
								articleItem[3][j]));
						System.out.println("새로운 기사 추가");
					}
					System.out.println("완료 " + code[h]);
					System.out.println("map size : "+map.size());
					newCapsule.add(new NewCapsule(code[h], newsRecode));
				}
			}
			// 파일이 존재하면
			else if (filePath.exists()) {
				System.out.println("파일 존재함");
				voListType = new TypeToken<List<NewCapsule>>() {}.getType();
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(new FileInputStream(filePath), "UTF8"));
				List<NewCapsule> bringNewCapsule = gson.fromJson(reader, voListType);
				newCapsule = new ArrayList<NewCapsule>();
				reader.close();

				// 회사개수 12개 만큼 반복
				for (int h = 0; h < code.length; h++) {
					newsRecode = bringNewCapsule.get(h).getNewsRecode();
					r.eval("code = '" + code[h] + "'");
					r.eval("source("+rsource_location+")");
					RList list = r.eval("navereco_info").asList();

					// 크롤링 결과인 dataframe을 받아 놓을 articleItem 2차원 배열
					String[][] articleItem = new String[4][10];

					// 항목 개수 4개 (title/press/time/content) 배열에 추가
					for (int i = 0; i < 4; i++) {
						articleItem[i] = list.at(i).asStrings();
						System.out.println(articleItem[i][0]);
					}

					// 종목 코드별 10개 기사 객체리스트에 추가
					for (int j = 0; j < 10; j++) {
						// HashMap Key 값으로 중복 확인
						// title 중복 되지 않을겨우
						if (!map.containsKey(articleItem[0][j])) {
							// map에 추가
							map.put(articleItem[0][j], 1);
							newsRecode.add(new NewsRecode(articleItem[0][j], articleItem[1][j],
									articleItem[2][j], articleItem[3][j]));
							System.out.println("새로운 기사 추가");
						}
						// title 중복 되는 경우
						else if (map.containsKey(articleItem[0][j])) {
							System.out.println("이미 있음");
						}
					}

					System.out.println("완료 " + code[h]);
					System.out.println("map size : "+map.size());
					newCapsule.add(new NewCapsule(code[h], newsRecode));
				}
			}

			Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), "utf-8"));
			gson.toJson(newCapsule, writer);
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			r.close();
		}
	}
	
}