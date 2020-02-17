package com.paxcel.ashutoshaneja.jobster.service;
import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;

@Service
public interface SignupManager {

	public String createNewUser(UserVO userVO);
}
