package com.paxcel.ashutoshaneja.jobster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.Vacancy;
import com.paxcel.ashutoshaneja.jobster.util.ConnectionPool;

@Repository
public class VacancyDAOImpl implements VacancyDAO {

	@Autowired
	Logger appLogger;

	@Autowired
	ConnectionPool connectionpool;

	@Override
	public String addVacancy(Vacancy vacancy) {

		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());

		try {
			final String getCompanyIDSQL = "SELECT COMPANY_ID FROM RECRUITER_DETAIL WHERE USER_ID = ?";
			PreparedStatement getCompanyIDPreparedStmt = fetchedConnection.prepareStatement(getCompanyIDSQL);
			
			getCompanyIDPreparedStmt.setInt(1, vacancy.getUserID());
			ResultSet resultset = getCompanyIDPreparedStmt.executeQuery();
			
			resultset.next();
			
			int companyID = resultset.getInt("COMPANY_ID");

			System.out.println("Company ID "+companyID);

			final String addVacancySQL = "INSERT INTO VACANCY(RECRUITER_ID, COMPANY_ID, VACANCY_COUNT, LOCATION, SKILL, EXPERIENCE) VALUES(?,?,?,?,?,?)";
			PreparedStatement vacancyPreparedStmt = fetchedConnection.prepareStatement(addVacancySQL);

			vacancyPreparedStmt.setInt(1, vacancy.getUserID());
			vacancyPreparedStmt.setInt(2, companyID);
			vacancyPreparedStmt.setInt(3, vacancy.getVacancyCount());
			vacancyPreparedStmt.setString(4, vacancy.getLocation());
			vacancyPreparedStmt.setString(5, vacancy.getSkill());
			vacancyPreparedStmt.setInt(6, vacancy.getExperience());

			int i = vacancyPreparedStmt.executeUpdate();  
			appLogger.info(this.getClass().getSimpleName() +": "+ vacancy.getUsername()+" posted a vacancy.");  

			return "vacancyAdded";
		}
		catch(Exception exception) {
			System.out.println("\nException while inserting vacancy: " + exception.getMessage());
			appLogger.error(this.getClass().getSimpleName() +": Exception found in DB Connection." + exception.getMessage(), exception);
			return "failed";
		}
		finally {
			boolean releaseOutcome = connectionpool.releaseConnection(fetchedConnection);
			appLogger.info(this.getClass().getSimpleName() +": Status of Connection Release: "+releaseOutcome+", Pool size:"+connectionpool.getSize());
		}
	}

}
