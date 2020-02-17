package com.paxcel.ashutoshaneja.jobster.service;

import org.springframework.stereotype.Service;

import com.paxcel.ashutoshaneja.jobster.model.Vacancy;

@Service
public interface VacancyManager {
	
	public String addVacancy(Vacancy vacancy);
}
