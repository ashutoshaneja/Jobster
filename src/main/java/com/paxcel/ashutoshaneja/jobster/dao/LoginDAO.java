package com.paxcel.ashutoshaneja.jobster.dao;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;

@Repository
public interface LoginDAO {

	public boolean handleLoginRequest(UserVO userVO);
	
	public String sendResponse(UserVO userVO);

}
