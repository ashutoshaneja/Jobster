package com.paxcel.ashutoshaneja.jobster.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.dao.VacancyDAO;
import com.paxcel.ashutoshaneja.jobster.model.Vacancy;

@Service
public class VacancyManagerImpl implements VacancyManager {
	@Autowired
	VacancyDAO dao;

	@Override
	public String addVacancy(Vacancy vacancy) {
		return dao.addVacancy(vacancy);
	}
}
