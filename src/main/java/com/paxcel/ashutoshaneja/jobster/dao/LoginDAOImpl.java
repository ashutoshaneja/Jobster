package com.paxcel.ashutoshaneja.jobster.dao;

import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;
import com.paxcel.ashutoshaneja.jobster.util.ConnectionPool;
import com.paxcel.ashutoshaneja.jobster.util.GenerateSHAPassword;

@Repository
public class LoginDAOImpl implements LoginDAO {

	@Autowired
	Logger appLogger;
	
	@Autowired
	ConnectionPool connectionpool;
	
	@Override
	public boolean handleLoginRequest(UserVO userVO) {
		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());
		try {
			final String loginSQL = "SELECT * FROM USER_CREDENTIAL WHERE USERNAME = ?";
			java.sql.PreparedStatement loginPreparedStmt = fetchedConnection.prepareStatement(loginSQL);
			
			loginPreparedStmt.setString(1, userVO.getUsername());
			

			ResultSet resultset = loginPreparedStmt.executeQuery();
			if(resultset.next()==false) {
				return false;
			}
			else {
				if(resultset.getString("PASSWORD").equals(GenerateSHAPassword.encryptThis(userVO.getPassword()))) {
					return true;
				}
				else
					return false;	
			}			 
		}
		catch(Exception exception) {
			System.out.println("\nException while inserting data: " + exception.getMessage());
			appLogger.error(this.getClass().getSimpleName() +": Exception found in DB Connection." + exception.getMessage(), exception);
			return false;
		}
		finally {
			boolean releaseOutcome = connectionpool.releaseConnection(fetchedConnection);
			appLogger.info(this.getClass().getSimpleName() +": Status of Connection Release: "+releaseOutcome+", Pool size:"+connectionpool.getSize());
		}
	}

	@Override
	public String sendResponse(UserVO userVO) {
		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());
		try {
			final String responseSQL = "SELECT ROLE FROM USER_CREDENTIAL WHERE USERNAME = ? AND PASSWORD = ?";
			java.sql.PreparedStatement responsePreparedStmt = fetchedConnection.prepareStatement(responseSQL);
			
			responsePreparedStmt.setString(1, userVO.getUsername());
			responsePreparedStmt.setString(2, GenerateSHAPassword.encryptThis(userVO.getPassword()));
			
			ResultSet resultset = responsePreparedStmt.executeQuery();
			resultset.next();
			String role = resultset.getString("ROLE");
			return role;
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
