package com.paxcel.ashutoshaneja.jobster.dao;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;

@Repository
public interface SignupDAO {
	
	public String createNewUser(UserVO uservo);

}
