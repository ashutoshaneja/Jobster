package com.paxcel.ashutoshaneja.jobster.service;

import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.model.RecruiterInfo;

@Service
public interface RecruiterInfoManager {
	
	public String addRecruiterInfo(RecruiterInfo recruiter);
}
