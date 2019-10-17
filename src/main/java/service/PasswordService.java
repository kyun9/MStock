package service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.bcrypt.*;
import org.springframework.stereotype.*;

@Service
public class PasswordService {
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	public String getEncodedPassword(String password) {
		return passwordEncoder.encode(password);
	}
}
