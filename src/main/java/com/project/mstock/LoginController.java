package com.project.mstock;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
}
