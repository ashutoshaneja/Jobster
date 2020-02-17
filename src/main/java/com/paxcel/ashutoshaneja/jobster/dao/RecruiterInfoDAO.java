package com.paxcel.ashutoshaneja.jobster.dao;

import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.RecruiterInfo;

@Repository
public interface RecruiterInfoDAO {

	public String addRecruiterInfo(RecruiterInfo recruiter);

}
