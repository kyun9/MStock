package com.project.mstock;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegisterController {
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String register() {
		return "register";
	}
}
