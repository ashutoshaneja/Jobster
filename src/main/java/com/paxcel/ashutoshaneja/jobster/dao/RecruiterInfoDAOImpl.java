package com.paxcel.ashutoshaneja.jobster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.RecruiterInfo;
import com.paxcel.ashutoshaneja.jobster.util.ConnectionPool;

@Repository
public class RecruiterInfoDAOImpl implements RecruiterInfoDAO {

	@Autowired
	Logger appLogger;

	@Autowired
	ConnectionPool connectionpool;

	@Override
	public String addRecruiterInfo(RecruiterInfo recruiter) {
		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());
		try {
			final String getCompanySQL = "SELECT COMPANY_ID FROM COMPANY_DATA WHERE COMPANY_NAME = ?";
			PreparedStatement getCompanyPreparedStmt = fetchedConnection.prepareStatement(getCompanySQL);
			getCompanyPreparedStmt.setString(1, recruiter.getCompanyName());
			ResultSet resultset = getCompanyPreparedStmt.executeQuery();

			int companyID;
			if(resultset.next()==false) {
				//Company doesn't exists in Former DB. Adding record

				final String addCompanySQL = "INSERT INTO COMPANY_DATA(COMPANY_NAME) VALUES(?)";
				PreparedStatement addCompanyPreparedStmt = fetchedConnection.prepareStatement(addCompanySQL);

				addCompanyPreparedStmt.setString(1, recruiter.getCompanyName());

				int j = addCompanyPreparedStmt.executeUpdate();

				appLogger.info(this.getClass().getSimpleName()+": "+ j +" COMPANY added to DB");

				final String getIDSQL = "SELECT LAST_INSERT_ID()";
				PreparedStatement getIDPreparedStmt = fetchedConnection.prepareStatement(getIDSQL);
				ResultSet IDresultset = getIDPreparedStmt.executeQuery();
				IDresultset.next();
				companyID = IDresultset.getInt("LAST_INSERT_ID()");
			}
			else {
				companyID = resultset.getInt("COMPANY_ID");
			}

			final String addRecruiterInfoSQL = "INSERT INTO RECRUITER_DETAIL VALUES(?,?,?)";
			java.sql.PreparedStatement recruiterInfoPreparedStmt = fetchedConnection.prepareStatement(addRecruiterInfoSQL);

			recruiterInfoPreparedStmt.setInt(1, companyID);
			recruiterInfoPreparedStmt.setInt(2, recruiter.getUserID());
			recruiterInfoPreparedStmt.setString(3, recruiter.getDesignation());

			recruiterInfoPreparedStmt.executeUpdate();  

			appLogger.info(this.getClass().getSimpleName() +": "+ recruiter.getUsername()+" completed Profile.");  

			return "recruiterInfoAdded";
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

}
