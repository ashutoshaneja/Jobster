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

/** This DAO saves seeker's additional info, retrieves vacancy/filtered-vacancy and deals with pagination
 * @author Ashutosh
 *
 */
@Repository
public class SeekerInfoDAOImpl implements SeekerInfoDAO {

	@Autowired
	Logger appLogger;

	@Autowired
	ConnectionPool connectionpool;

	/*-------------------------------- Save Seeker's Additional info in DB --------------------------------*/
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

	/*-------------------------------- Retrieve all vacancies after page load --------------------------------*/
	@Override
	public List<Vacancy> showVacancy() {
		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());

		List<Vacancy> vacancyList = new ArrayList<Vacancy>();
		ResultSet resultset = null;
		try {
			int counter=0;
			final String getCount = "SELECT COUNT(*) FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID";
			PreparedStatement getCountPreparedStmt = fetchedConnection.prepareStatement(getCount);
			ResultSet countResultSet = getCountPreparedStmt.executeQuery();
			if(countResultSet.next()){
				counter = countResultSet.getInt(1);
			}

			int noOfPages = 0;
			if(counter%5==0) {
				noOfPages = counter/5;
			}
			else {
				noOfPages = (counter/5)+1;
			}

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
				vacancyObj.setPages(noOfPages);
				vacancyList.add(vacancyObj);
				counter++;
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

	/*-------------------------------- Retrieve vacancies as per the specifies filters --------------------------------*/
	@Override
	public List<Vacancy> showFilteredVacancy(SearchVacancy vacancy) {

		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());

		List<Vacancy> vacancyList = new ArrayList<Vacancy>();
		ResultSet resultset;
		try {
			appLogger.info("Page no: "+vacancy.getPageNo());
			appLogger.info("Location: "+vacancy.getLocation());
			appLogger.info("Skill: "+vacancy.getSkill());
			appLogger.info("Count: "+vacancy.getRecordCount());


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


			StringBuilder locationQuery = new StringBuilder();
			locationQuery.append(" ( ");
			for(int i=0;i<locationArrayList.size()-1;i++) {
				locationQuery.append("LOCATION = '"+locationArrayList.get(i)+"' OR ");
			}
			locationQuery.append(" LOCATION = '"+locationArrayList.get(locationArrayList.size()-1)+"') ");

			appLogger.info("locationQuery: "+locationQuery);

						if(vacancy.getPageNo()==1) {

			if(skillArrayList.contains("Any") && locationArrayList.contains("Any")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL IS NOT NULL AND VACANCY.LOCATION IS NOT NULL LIMIT ?"; 
			}

			else if(skillArrayList.contains("Any")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL IS NOT NULL AND "+locationQuery+" LIMIT ?"; 
			}
			else if(locationArrayList.contains("Any")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION IS NOT NULL AND "+skillQuery+" LIMIT ?"; 
			}
			else {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE "+skillQuery+" AND "+locationQuery+" LIMIT ?"; 
			}

			appLogger.info("-> SQL TO RUN: "+getVacancySQL);
			PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);

			getVacancyPreparedStmt.setInt(1, vacancy.getRecordCount());

			appLogger.info("Count: "+vacancy.getRecordCount());

			resultset = getVacancyPreparedStmt.executeQuery();


			int counter=0;
			final String getCount = getVacancySQL.substring(0, getVacancySQL.length() - 7).replace(" * ", " COUNT(*) ");
			appLogger.info("inside filter dao -> countSQL : "+getCount);
			PreparedStatement getCountPreparedStmt = fetchedConnection.prepareStatement(getCount);
			ResultSet countResultSet = getCountPreparedStmt.executeQuery();
			if(countResultSet.next()){
				counter = countResultSet.getInt(1);
			}

			int noOfPages = 0;
			if(counter%(vacancy.getRecordCount())==0) {
				noOfPages = counter/vacancy.getRecordCount();
			}
			else {
				noOfPages = (counter/(vacancy.getRecordCount()))+1;
			}

			while(resultset.next()) {
				Vacancy vacancyObj = new Vacancy();
				vacancyObj.setVacancyID(resultset.getInt("VACANCY_ID"));
				vacancyObj.setUserID(resultset.getInt("RECRUITER_ID"));
				vacancyObj.setCompanyName(resultset.getString("COMPANY_NAME"));
				vacancyObj.setVacancyCount(resultset.getInt("VACANCY_COUNT"));
				vacancyObj.setLocation(resultset.getString("LOCATION"));
				vacancyObj.setSkill(resultset.getString("SKILL"));
				vacancyObj.setExperience(resultset.getInt("EXPERIENCE"));
				vacancyObj.setPages(noOfPages);
				vacancyList.add(vacancyObj);
			}
			return vacancyList;
			}
				else {
					
					if(skillArrayList.contains("Any") && locationArrayList.contains("Any")) {
						getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL IS NOT NULL AND VACANCY.LOCATION IS NOT NULL LIMIT ?, ?"; 
					}

					else if(skillArrayList.contains("Any")) {
						getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL IS NOT NULL AND "+locationQuery+" LIMIT ?, ?"; 
					}
					else if(locationArrayList.contains("Any")) {
						getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION IS NOT NULL AND "+skillQuery+" LIMIT ?, ?"; 
					}
					else {
						getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE "+skillQuery+" AND "+locationQuery+" LIMIT ?, ?"; 
					}

					appLogger.info("-> page SQL TO RUN: "+getVacancySQL);
					PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
					
					getVacancyPreparedStmt.setInt(1, (vacancy.getRecordCount()*(vacancy.getPageNo()-1)));
					getVacancyPreparedStmt.setInt(2, (vacancy.getRecordCount()*(vacancy.getPageNo())));

					resultset = getVacancyPreparedStmt.executeQuery();
					
					appLogger.info("-->"+(vacancy.getRecordCount()*(vacancy.getPageNo()-1)));
					appLogger.info("-->"+(vacancy.getRecordCount()*(vacancy.getPageNo())));
					
					while(resultset.next()) {
						Vacancy vacancyObject = new Vacancy();
						vacancyObject.setVacancyID(resultset.getInt("VACANCY_ID"));
						vacancyObject.setUserID(resultset.getInt("RECRUITER_ID"));
						vacancyObject.setCompanyName(resultset.getString("COMPANY_NAME"));
						vacancyObject.setVacancyCount(resultset.getInt("VACANCY_COUNT"));
						vacancyObject.setLocation(resultset.getString("LOCATION"));
						vacancyObject.setSkill(resultset.getString("SKILL"));
						vacancyObject.setExperience(resultset.getInt("EXPERIENCE"));

						vacancyList.add(vacancyObject);
					}
					System.out.println(vacancyList);
					return vacancyList;


				}

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

	/*-------------------------------- Save Seeker's details for specified Vacancy --------------------------------*/
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

	@Override
	public List<Vacancy> getPageRecord(SearchVacancy vacancyObj) {

		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());

		List<Vacancy> vacancyList = new ArrayList<Vacancy>();
		ResultSet resultset;
		try {
			appLogger.info("Inside Page Record, Page no: "+vacancyObj.getPageNo());
			appLogger.info("Inside Page Record, Page no: "+vacancyObj.getLocation());
			appLogger.info("Inside Page Record, Page no: "+vacancyObj.getSkill());


			/*---------- Revamp Multiple Skills to ArrayList for Dynamic Query Creation ----------*/
			String[] skillArray = vacancyObj.getSkill().split(",");
			List<String> skillList = Arrays.asList(skillArray);
			ArrayList<String> skillArrayList = new ArrayList<String>(skillList);

			/*---------- Revamp Multiple Locations to ArrayList for Dynamic Query Creation ----------*/
			String[] locationArray = vacancyObj.getLocation().split(",");
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


			StringBuilder locationQuery = new StringBuilder();
			locationQuery.append(" ( ");
			for(int i=0;i<locationArrayList.size()-1;i++) {
				locationQuery.append("LOCATION = '"+locationArrayList.get(i)+"' OR ");
			}
			locationQuery.append(" LOCATION = '"+locationArrayList.get(locationArrayList.size()-1)+"') ");

			appLogger.info("locationQuery: "+locationQuery);



			if(skillArrayList.contains("Any") && locationArrayList.contains("Any")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL IS NOT NULL AND VACANCY.LOCATION IS NOT NULL LIMIT ?, ?"; 
			}

			else if(skillArrayList.contains("Any")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.SKILL IS NOT NULL AND "+locationQuery+" LIMIT ?, ?"; 
			}
			else if(locationArrayList.contains("Any")) {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE VACANCY.LOCATION IS NOT NULL AND "+skillQuery+" LIMIT ?, ?"; 
			}
			else {
				getVacancySQL = "SELECT * FROM VACANCY INNER JOIN COMPANY_DATA ON VACANCY.COMPANY_ID=COMPANY_DATA.COMPANY_ID WHERE "+skillQuery+" AND "+locationQuery+" LIMIT ?, ?"; 
			}

			appLogger.info("-> page SQL TO RUN: "+getVacancySQL);
			PreparedStatement getVacancyPreparedStmt = fetchedConnection.prepareStatement(getVacancySQL);
			
			getVacancyPreparedStmt.setInt(1, (vacancyObj.getRecordCount()*(vacancyObj.getPageNo()-1)));
			getVacancyPreparedStmt.setInt(2, (vacancyObj.getRecordCount()*(vacancyObj.getPageNo())));

			resultset = getVacancyPreparedStmt.executeQuery();
			
			appLogger.info("-->"+(vacancyObj.getRecordCount()*(vacancyObj.getPageNo()-1)));
			appLogger.info("-->"+(vacancyObj.getRecordCount()*(vacancyObj.getPageNo())));
			
			while(resultset.next()) {
				Vacancy vacancyObject = new Vacancy();
				vacancyObject.setVacancyID(resultset.getInt("VACANCY_ID"));
				vacancyObject.setUserID(resultset.getInt("RECRUITER_ID"));
				vacancyObject.setCompanyName(resultset.getString("COMPANY_NAME"));
				vacancyObject.setVacancyCount(resultset.getInt("VACANCY_COUNT"));
				vacancyObject.setLocation(resultset.getString("LOCATION"));
				vacancyObject.setSkill(resultset.getString("SKILL"));
				vacancyObject.setExperience(resultset.getInt("EXPERIENCE"));

				vacancyList.add(vacancyObject);
			}
			System.out.println(vacancyList);
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
}
