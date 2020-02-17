package com.paxcel.ashutoshaneja.jobster.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.dao.RecruiterInfoDAO;
import com.paxcel.ashutoshaneja.jobster.model.RecruiterInfo;

@Service
public class RecruiterInfoManagerImpl implements RecruiterInfoManager {
	@Autowired
	RecruiterInfoDAO dao;

	@Override
	public String addRecruiterInfo(RecruiterInfo recruiter) {
		return dao.addRecruiterInfo(recruiter);
	}
}
