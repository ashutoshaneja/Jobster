package com.paxcel.ashutoshaneja.jobster.model;

import java.io.Serializable;

public class Vacancy implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int vacancyID;
	private String username;
	private String companyName;
	private int vacancyCount;
	private String location;
	private String skill;
	private int experience;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getVacancyCount() {
		return vacancyCount;
	}
	public void setVacancyCount(int vacancyCount) {
		this.vacancyCount = vacancyCount;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	public int getExperience() {
		return experience;
	}
	public void setExperience(int experience) {
		this.experience = experience;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public int getVacancyID() {
		return vacancyID;
	}
	public void setVacancyID(int vacancyID) {
		this.vacancyID = vacancyID;
	}

}
