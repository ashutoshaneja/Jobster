package com.paxcel.ashutoshaneja.jobster.dao;

import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.Vacancy;

@Repository
public interface VacancyDAO {

	public String addVacancy(Vacancy vacancy);

}
