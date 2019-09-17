package service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import vo.StockInfoVO;

@Service
public class StockInfoService {
	
	public StockInfoVO getInfo(String code) {
		StockInfoVO vo= new StockInfoVO();
		
		String geturl = "http://asp1.krx.co.kr/servlet/krx.asp.XMLSise?code="+code;
		String JongCd = geturl.substring(51, 57);
		String gettime="";
		String janggubun = "";
		String DungRakrate_str = "";
		
		int dailystock_length = 0;
		
		int CurJuka = 0;
		int Debi = 0;
		float StandardPrice = 0;
		float DungRakrate = 0;
		
		String line="";
		String xml = "";
		
		String Stockinfo[]= new String [17];
		String Dailystock[][] = new String [10][9];
		
		try{
			URL url = new URL(geturl);
			URLConnection conn = url.openConnection();
			HttpURLConnection httpConnection = (HttpURLConnection) conn;
			InputStream is = null;
			InputStreamReader isr = null;
			
			is =  new URL(geturl).openStream();
			isr = new InputStreamReader(is, "UTF-8");		
			
			BufferedReader rd = new BufferedReader(isr,400);
			
			StringBuffer strbuf = new StringBuffer();
			
			//xml line1 공백제거
			while ((line = rd.readLine()) != null){			
			  	strbuf.append(line);
			}
			
			//System.out.println("주가정보");
			//System.out.println(strbuf.toString()); //xml파싱확인
			
			DocumentBuilderFactory docFact = DocumentBuilderFactory.newInstance();
			docFact.setNamespaceAware(true);
			DocumentBuilder docBuild = docFact.newDocumentBuilder();

			Document doc = docBuild.parse(new InputSource(new StringReader(strbuf.toString())));

			/*주가정보*/
			
			NodeList stockInfo = doc.getElementsByTagName("stockInfo");
			
			NamedNodeMap stockinfo = stockInfo.item(0).getAttributes();
			gettime = stockinfo.getNamedItem("myNowTime").getNodeValue();
			janggubun = stockinfo.getNamedItem("myJangGubun").getNodeValue();
			
			NodeList TBL_StockInfo = doc.getElementsByTagName("TBL_StockInfo");
			NamedNodeMap StockInfo = TBL_StockInfo.item(0).getAttributes();
			
			Stockinfo[0] = StockInfo.getNamedItem("JongName").getNodeValue();		//종목명 
			Stockinfo[1] = StockInfo.getNamedItem("CurJuka").getNodeValue();		//현재가 
			Stockinfo[2] = StockInfo.getNamedItem("DungRak").getNodeValue();		//전일대비코드
			Stockinfo[3] = StockInfo.getNamedItem("Debi").getNodeValue();			//전일대비
			Stockinfo[4] = StockInfo.getNamedItem("PrevJuka").getNodeValue();		//전일종가 
			Stockinfo[5] = StockInfo.getNamedItem("Volume").getNodeValue();			//거래량
			Stockinfo[6] = StockInfo.getNamedItem("Money").getNodeValue();			//거래대금  
			Stockinfo[7] = StockInfo.getNamedItem("StartJuka").getNodeValue();		//시가 
			Stockinfo[8] = StockInfo.getNamedItem("HighJuka").getNodeValue();		//고가
			Stockinfo[9] = StockInfo.getNamedItem("LowJuka").getNodeValue();		//저가 		
			Stockinfo[10] = StockInfo.getNamedItem("High52").getNodeValue();		//52주 최고 
			Stockinfo[11] = StockInfo.getNamedItem("Low52").getNodeValue();			//52주 최저  
			Stockinfo[12] = StockInfo.getNamedItem("UpJuka").getNodeValue();		//상한가 
			Stockinfo[13] = StockInfo.getNamedItem("DownJuka").getNodeValue();		//하한가 
			Stockinfo[14] = StockInfo.getNamedItem("Per").getNodeValue();			//PER            
			Stockinfo[15] = StockInfo.getNamedItem("Amount").getNodeValue();		//상장주식수    
			Stockinfo[16] = StockInfo.getNamedItem("FaceJuka").getNodeValue();		//액면가
			
			// 등락율 계산
			CurJuka = Integer.parseInt(Stockinfo[1].replaceAll(",", ""));
			Debi = Integer.parseInt(Stockinfo[3].replaceAll(",", ""));
			
			/*등락구분코드*/
			// 1 - 상한, 2 - 상승, 3 - 보합, 4 - 하한, 5 - 하락
			
			if(Stockinfo[2].equals("1")||Stockinfo[2].equals("2")||Stockinfo[2].equals("3")){
				StandardPrice = CurJuka - Debi;
			} else if(Stockinfo[2].equals("4")||Stockinfo[2].equals("5")){
				StandardPrice = CurJuka + Debi;
			}
			
			// 등락률 = (당일종가 - 기준가) / 기준가 * 100
			// 기준가 = 당일종가(현재가) - 전일대비
			DungRakrate = ((CurJuka - StandardPrice) / StandardPrice) * 100;
			DungRakrate_str = String.format("%.2f", DungRakrate);
			
			/*일자별시세*/
			
			NodeList TBL_Dailystock = doc.getElementsByTagName("DailyStock");
			
	 		dailystock_length = TBL_Dailystock.getLength();
			
			for(int j=0;j<dailystock_length;j++){
				
				NamedNodeMap DailyStock = TBL_Dailystock.item(j).getAttributes();
				
				Dailystock[j][0] = DailyStock.getNamedItem("day_Date").getNodeValue();		//일자
				Dailystock[j][1] = DailyStock.getNamedItem("day_EndPrice").getNodeValue();	//종가
				Dailystock[j][2] = DailyStock.getNamedItem("day_getDebi").getNodeValue();	//전일대비
				Dailystock[j][3] = DailyStock.getNamedItem("day_Start").getNodeValue();		//시가
				Dailystock[j][4] = DailyStock.getNamedItem("day_High").getNodeValue();		//고가
				Dailystock[j][5] = DailyStock.getNamedItem("day_Low").getNodeValue();		//저가
				Dailystock[j][6] = DailyStock.getNamedItem("day_Volume").getNodeValue();	//거래량
				Dailystock[j][7] = DailyStock.getNamedItem("day_getAmount").getNodeValue();	//거래대금
				Dailystock[j][8] = DailyStock.getNamedItem("day_Dungrak").getNodeValue();	//전일대비코드
				
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		
		vo.setJongCd(JongCd);
		vo.setGettime(gettime);
		vo.setJanggubun(janggubun);
		vo.setDungRakrate_str(DungRakrate_str);
		vo.setDailystock_length(dailystock_length);
		vo.setStockinfo(Stockinfo);
		vo.setDailystock(Dailystock);
		
		return vo;
	}
}
