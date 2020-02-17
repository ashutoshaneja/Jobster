package com.paxcel.ashutoshaneja.jobster.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.paxcel.ashutoshaneja.jobster.dao.SignupDAO;
import com.paxcel.ashutoshaneja.jobster.model.UserVO;

@Service
public class SignupManagerImpl implements SignupManager {

	@Autowired
	SignupDAO dao;

	@Override
	public String createNewUser(UserVO userVO) {
		return dao.createNewUser(userVO);
	}

}
