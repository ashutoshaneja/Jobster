package com.paxcel.ashutoshaneja.jobster.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.dao.LoginDAO;
import com.paxcel.ashutoshaneja.jobster.model.UserVO;

@Service
public class LoginManagerImpl implements LoginManager {

	@Autowired
	LoginDAO dao;

	@Override
	public boolean handleLoginRequest(UserVO userVO) {
		return dao.handleLoginRequest(userVO);
	}

	@Override
	public String sendResponse(UserVO userVO) {
		return dao.sendResponse(userVO);
	}

	@Override
	public int getUserID(String username) {
		return dao.getUserID(username);
	}

}
