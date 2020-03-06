package com.paxcel.ashutoshaneja.jobster.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.stereotype.Component; 

@Component
public class PasswordEncoderGenerator {

	public String encryptThis(String input) 
	{ 
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			String hashedPassword = passwordEncoder.encode(input);
			
			return hashedPassword;
	} 
}
