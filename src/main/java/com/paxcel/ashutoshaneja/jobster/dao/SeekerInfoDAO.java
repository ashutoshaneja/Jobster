package com.paxcel.ashutoshaneja.jobster.dao;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.SearchVacancy;
import com.paxcel.ashutoshaneja.jobster.model.SeekerInfo;
import com.paxcel.ashutoshaneja.jobster.model.Vacancy;

@Repository
public interface SeekerInfoDAO {

	public String addSeekerInfo(SeekerInfo seeker);
	
	public List<Vacancy> showVacancy();
	
	public List<Vacancy> showFilteredVacancy(SearchVacancy vacancy);
	
	public String applyVacancy(Vacancy applyVacancyObj);
	
	public List<Vacancy> getPageRecord(SearchVacancy vacancyObj);
}
