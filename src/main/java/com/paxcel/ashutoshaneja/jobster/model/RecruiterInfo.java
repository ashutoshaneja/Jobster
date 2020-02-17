package com.paxcel.ashutoshaneja.jobster.model;

import java.io.Serializable;
public class RecruiterInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String companyName;
	private String username;
	private String designation;
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
