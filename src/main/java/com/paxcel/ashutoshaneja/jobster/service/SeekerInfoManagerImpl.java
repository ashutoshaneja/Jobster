package com.paxcel.ashutoshaneja.jobster.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.dao.SeekerInfoDAO;
import com.paxcel.ashutoshaneja.jobster.model.SearchVacancy;
import com.paxcel.ashutoshaneja.jobster.model.SeekerInfo;
import com.paxcel.ashutoshaneja.jobster.model.Vacancy;

@Service
public class SeekerInfoManagerImpl implements SeekerInfoManager {
	@Autowired
	SeekerInfoDAO dao;

	@Override
	public String addSeekerInfo(SeekerInfo seeker) {
		return dao.addSeekerInfo(seeker);
	}

	@Override
	public List<Vacancy> showVacancy() {
		return dao.showVacancy();
	}

	@Override
	public List<Vacancy> showFilteredVacancy(SearchVacancy vacancy) {
		return dao.showFilteredVacancy(vacancy);
	}

	@Override
	public String applyVacancy(Vacancy applyVacancyObj) {
		return dao.applyVacancy(applyVacancyObj);
	}

	@Override
	public List<Vacancy> getPageRecord(SearchVacancy vacancyObj) {
		return dao.getPageRecord(vacancyObj);
	}
}
