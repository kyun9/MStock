package com.project.mstock;

import java.io.*;

import org.rosuda.REngine.*;
import org.rosuda.REngine.Rserve.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import service.*;

@Controller
public class TestController {
	
	@Autowired
	RSourceService service;
	@Autowired
	RankScheduler rankService;
	
	@RequestMapping(value="/rsource", method = RequestMethod.GET)
	public String getRsource() throws RserveException, REXPMismatchException, IOException {
		service.rdata();
		//service.temp();

		return "temp";
	}
	
	@RequestMapping(value="/temp", method = RequestMethod.GET)
	public String getTemp(){
		rankService.updateRank();
		return "temp";
	}
	
}
