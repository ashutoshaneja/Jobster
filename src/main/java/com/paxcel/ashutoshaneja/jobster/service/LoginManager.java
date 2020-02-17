package com.paxcel.ashutoshaneja.jobster.service;
import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;

@Service
public interface LoginManager {

	public boolean handleLoginRequest(UserVO userVO);
	
	public String sendResponse(UserVO userVO);
}
