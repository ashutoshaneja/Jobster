package com.paxcel.ashutoshaneja.jobster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.SeekerInfo;
import com.paxcel.ashutoshaneja.jobster.model.Vacancy;
import com.paxcel.ashutoshaneja.jobster.model.SearchVacancy;
import com.paxcel.ashutoshaneja.jobster.util.ConnectionPool;

@Repository
public class SeekerInfoDAOImpl implements SeekerInfoDAO {

	@Autowired
	Logger appLogger;

	@Autowired
	ConnectionPool connectionpool;

	@Override
	public String addSeekerInfo(SeekerInfo seeker) {
		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());
		try {
			final String addSeekerInfoSQL = "INSERT INTO EMPLOYEE_DETAIL(USERNAME, LOCATION, SKILL, RESUME_URL, EXPERIENCE) VALUES(?,?,?,?,?)";
			PreparedStatement seekerInfoPreparedStmt = fetchedConnection.prepareStatement(addSeekerInfoSQL);

			seekerInfoPreparedStmt.setString(1, seeker.getUsername());
			seekerInfoPreparedStmt.setString(2, seeker.getLocation());
			seekerInfoPreparedStmt.setString(3, seeker.getSkill());
			seekerInfoPreparedStmt.setString(4, seeker.getResumeURL());
			seekerInfoPreparedStmt.setInt(5, seeker.getExperience());

			int i = seekerInfoPreparedStmt.executeUpdate();  
			appLogger.info(this.getClass().getSimpleName() +": "+ i+" records inserted");  

			return "seekerInfoAdded";
		}
		catch(Exception exception) {
			System.out.println("\nException while inserting data: " + exception.getMessage());
			appLogger.error(this.getClass().getSimpleName() +": Exception found in DB Connection." + exception.getMessage(), exception);
			return "failed";
		}
		finally {
			boolean releaseOutcome = connectionpool.releaseConnection(fetchedConnection);
			appLogger.info(this.getClass().getSimpleName() +": Status of Connection Release: "+releaseOutcome+", Pool size:"+connectionpool.getSize());
		}
	}

	@Override
	public List<Vacancy> showVacancy() {
		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());

		List<Vacancy> vacancyList = new ArrayList<Vacancy>();
		ResultSet resultset = null;
		try {

			final String getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID;";
			PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
			resultset = getVacancyPreparedStmt.executeQuery();


			while(resultset.next()) {
				Vacancy vacancyObj = new Vacancy();
				vacancyObj.setCompanyName(resultset.getString("COMPANY_NAME"));
				vacancyObj.setVacancyCount(resultset.getInt(2));
				vacancyObj.setLocation(resultset.getString(3));
				vacancyObj.setSkill(resultset.getString(4));
				vacancyObj.setExperience(resultset.getInt(5));

				vacancyList.add(vacancyObj);
			}
			return vacancyList;

		}
		catch(Exception exception) {
			System.out.println("\nException while inserting data: " + exception.getMessage());
			appLogger.error(this.getClass().getSimpleName() +": Exception found in DB Connection." + exception.getMessage(), exception);
			return null;
		}
		finally {
			boolean releaseOutcome = connectionpool.releaseConnection(fetchedConnection);
			appLogger.info(this.getClass().getSimpleName() +": Status of Connection Release: "+releaseOutcome+", Pool size:"+connectionpool.getSize());
		}

	}

	@Override
	public List<Vacancy> showFilteredVacancy(SearchVacancy vacancy) {

		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());

		List<Vacancy> vacancyList = new ArrayList<Vacancy>();
		ResultSet resultset;
		try {

			final String getVacancySQL;
			if(vacancy.getLocation().equals("") && vacancy.getSkill().equals("")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION IS NOT NULL AND VACANCY.SKILL IS NOT NULL";

				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);

				resultset = getVacancyPreparedStmt.executeQuery();
			}
			else if(vacancy.getLocation().equals("")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL = ?";

				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);

				getVacancyPreparedStmt.setString(1, vacancy.getSkill());
				resultset = getVacancyPreparedStmt.executeQuery();
			}
			else if(vacancy.getSkill().equals("")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION = ?";

				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);

				getVacancyPreparedStmt.setString(1, vacancy.getLocation());
				resultset = getVacancyPreparedStmt.executeQuery();
			}
			else {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION = ? AND VACANCY.SKILL = ?";

				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);

				getVacancyPreparedStmt.setString(1, vacancy.getLocation());
				getVacancyPreparedStmt.setString(2, vacancy.getSkill());
				
				resultset = getVacancyPreparedStmt.executeQuery();
			}


			while(resultset.next()) {
				Vacancy vacancyObj = new Vacancy();
				vacancyObj.setCompanyName(resultset.getString("COMPANY_NAME"));
				vacancyObj.setVacancyCount(resultset.getInt(2));
				vacancyObj.setLocation(resultset.getString(3));
				vacancyObj.setSkill(resultset.getString(4));
				vacancyObj.setExperience(resultset.getInt(5));

				vacancyList.add(vacancyObj);
			}
			return vacancyList;

		}
		catch(Exception exception) {
			System.out.println("\nException while inserting data: " + exception.getMessage());
			appLogger.error(this.getClass().getSimpleName() +": Exception found in DB Connection." + exception.getMessage(), exception);

		}
		finally {
			boolean releaseOutcome = connectionpool.releaseConnection(fetchedConnection);
			appLogger.info(this.getClass().getSimpleName() +": Status of Connection Release: "+releaseOutcome+", Pool size:"+connectionpool.getSize());
		}
		return vacancyList;

	}

}
