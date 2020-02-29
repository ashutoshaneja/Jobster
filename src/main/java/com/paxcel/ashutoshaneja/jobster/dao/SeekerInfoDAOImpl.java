package com.paxcel.ashutoshaneja.jobster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.SearchVacancy;
import com.paxcel.ashutoshaneja.jobster.model.SeekerInfo;
import com.paxcel.ashutoshaneja.jobster.model.Vacancy;
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
			final String addSeekerInfoSQL = "INSERT INTO SEEKER_DETAIL(USER_ID, LOCATION, SKILL, RESUME_URL, EXPERIENCE) VALUES(?,?,?,?,?)";
			PreparedStatement seekerInfoPreparedStmt = fetchedConnection.prepareStatement(addSeekerInfoSQL);
			
			appLogger.info("user id is "+seeker.getUserID());
			seekerInfoPreparedStmt.setInt(1, seeker.getUserID());
			seekerInfoPreparedStmt.setString(2, seeker.getLocation());
			seekerInfoPreparedStmt.setString(3, seeker.getSkill());
			seekerInfoPreparedStmt.setString(4, seeker.getResumeURL());
			seekerInfoPreparedStmt.setInt(5, seeker.getExperience());

			seekerInfoPreparedStmt.executeUpdate();  
			appLogger.info(this.getClass().getSimpleName() +": "+ seeker.getUsername()+" completed Profile.");  

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

			final String getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID LIMIT 5;";
			PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
			resultset = getVacancyPreparedStmt.executeQuery();

			while(resultset.next()) {
				Vacancy vacancyObj = new Vacancy();
				vacancyObj.setVacancyID(resultset.getInt("VACANCY_ID"));
				vacancyObj.setUserID(resultset.getInt("RECRUITER_ID"));
				vacancyObj.setCompanyName(resultset.getString("COMPANY_NAME"));
				vacancyObj.setVacancyCount(resultset.getInt("VACANCY_COUNT"));
				vacancyObj.setLocation(resultset.getString("LOCATION"));
				vacancyObj.setSkill(resultset.getString("SKILL"));
				vacancyObj.setExperience(resultset.getInt("EXPERIENCE"));

				vacancyList.add(vacancyObj);
			}
			return vacancyList;

		}
		catch(Exception exception) {
			System.out.println("\nException while retrieving data: " + exception.getMessage());
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
			appLogger.info(vacancy.getLocation());
			appLogger.info(vacancy.getSkill());
			
			
			/*---------- Revamp Multiple Skills to ArrayList for Dynamic Query Creation ----------*/
			String[] skillArray = vacancy.getSkill().split(",");
			List<String> skillList = Arrays.asList(skillArray);
			ArrayList<String> skillArrayList = new ArrayList<String>(skillList);

			/*---------- Revamp Multiple Locations to ArrayList for Dynamic Query Creation ----------*/
			String[] locationArray = vacancy.getLocation().split(",");
			List<String> locationList = Arrays.asList(locationArray);
			ArrayList<String> locationArrayList = new ArrayList<String>(locationList);
			final String getVacancySQL;
			
			StringBuilder skillQuery = new StringBuilder();
			skillQuery.append(" ( ");
			for(int i=0;i<skillArrayList.size()-1;i++) {
				skillQuery.append(" SKILL = '"+skillArrayList.get(i)+"' OR ");
			}
			
			skillQuery.append("SKILL = '"+skillArrayList.get(skillArrayList.size()-1)+"') ");
			
			appLogger.info("skillQuery: "+skillQuery);
			
			
			
			////////////////////////////////////////////////////////
			StringBuilder locationQuery = new StringBuilder();
			locationQuery.append(" ( ");
			for(int i=0;i<locationArrayList.size()-1;i++) {
				locationQuery.append("LOCATION = '"+locationArrayList.get(i)+"' OR ");
			}
			locationQuery.append(" LOCATION = '"+locationArrayList.get(locationArrayList.size()-1)+"') ");
			
			appLogger.info("locationQuery: "+locationQuery);
			
			getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE "+skillQuery+" AND "+locationQuery+" LIMIT ?"; 
			
			appLogger.info("///////////SQL TO RUN: "+getVacancySQL);
			PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
			
			getVacancyPreparedStmt.setInt(1, vacancy.getRecordCount());
			
			appLogger.info("Count: "+vacancy.getRecordCount());
			
			resultset = getVacancyPreparedStmt.executeQuery();
			
//			if(vacancy.getLocation().equals("Any") && vacancy.getSkill().equals("Any")) {
//				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION IS NOT NULL AND VACANCY.SKILL IS NOT NULL LIMIT ?";
//				
//				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
//				getVacancyPreparedStmt.setInt(1, vacancy.getRecordCount());
//				
//				resultset = getVacancyPreparedStmt.executeQuery();
//			}
//			else if(vacancy.getLocation().equals("Any")) {
//				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL = ? LIMIT ?";
//
//				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
//
//				getVacancyPreparedStmt.setString(1, vacancy.getSkill());
//				getVacancyPreparedStmt.setInt(2, vacancy.getRecordCount());
//				resultset = getVacancyPreparedStmt.executeQuery();
//			}
//			else if(vacancy.getSkill().equals("Any")) {
//				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION = ? LIMIT ?";
//
//				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
//
//				getVacancyPreparedStmt.setString(1, vacancy.getLocation());
//				getVacancyPreparedStmt.setInt(2, vacancy.getRecordCount());
//				resultset = getVacancyPreparedStmt.executeQuery();
//			}
//			else {
//				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION = ? AND VACANCY.SKILL = ? LIMIT ?";
//
//				PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
//
//				getVacancyPreparedStmt.setString(1, vacancy.getLocation());
//				getVacancyPreparedStmt.setString(2, vacancy.getSkill());
//				getVacancyPreparedStmt.setInt(3, vacancy.getRecordCount());
//
//				resultset = getVacancyPreparedStmt.executeQuery();
//			}
//

			while(resultset.next()) {
				Vacancy vacancyObj = new Vacancy();
				vacancyObj.setVacancyID(resultset.getInt("VACANCY_ID"));
				vacancyObj.setUserID(resultset.getInt("RECRUITER_ID"));
				vacancyObj.setCompanyName(resultset.getString("COMPANY_NAME"));
				vacancyObj.setVacancyCount(resultset.getInt("VACANCY_COUNT"));
				vacancyObj.setLocation(resultset.getString("LOCATION"));
				vacancyObj.setSkill(resultset.getString("SKILL"));
				vacancyObj.setExperience(resultset.getInt("EXPERIENCE"));

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

	@Override
	public String applyVacancy(Vacancy applyVacancyObj) {
		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());
		try {
			final String addVacancySQL = "INSERT INTO APPLIED_JOBS VALUES(?,?)";
			PreparedStatement vacancyPreparedStmt = fetchedConnection.prepareStatement(addVacancySQL);

			appLogger.info("Vacancy ID: "+applyVacancyObj.getVacancyID());
			vacancyPreparedStmt.setInt(1, applyVacancyObj.getVacancyID());

			appLogger.info("EmployeeID: "+applyVacancyObj.getUserID());
			vacancyPreparedStmt.setInt(2, applyVacancyObj.getUserID());

			vacancyPreparedStmt.executeUpdate();
			appLogger.info(this.getClass().getSimpleName() +": "+ applyVacancyObj.getUsername()+" applied for vacancy - "+applyVacancyObj.getVacancyID());  

			return "Vacancy Applied";
		}
		catch(Exception exception) {
			System.out.println("\nException while inserting data: " + exception.getMessage());
			appLogger.error(this.getClass().getSimpleName() +": Exception found in DB Connection." + exception.getMessage(), exception);
			return "error";
		}
		finally {
			boolean releaseOutcome = connectionpool.releaseConnection(fetchedConnection);
			appLogger.info(this.getClass().getSimpleName() +": Status of Connection Release: "+releaseOutcome+", Pool size:"+connectionpool.getSize());
		}
	}

}
