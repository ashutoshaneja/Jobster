package com.paxcel.ashutoshaneja.jobster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;
import com.paxcel.ashutoshaneja.jobster.util.ConnectionPool;
import com.paxcel.ashutoshaneja.jobster.util.PasswordEncoderGenerator;

@Repository
public class SignupDAOImpl implements SignupDAO {

	@Autowired
	Logger appLogger;
	
	@Autowired
	PasswordEncoderGenerator passwordEncoder;

	@Autowired
	ConnectionPool connectionpool;

	@Override
	public String createNewUser(UserVO userVO) {

		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());
		try {
			final String checkUsernameSQL = "SELECT * FROM USER WHERE USERNAME = ?";
			java.sql.PreparedStatement checkUsernamePreparedStmt = fetchedConnection.prepareStatement(checkUsernameSQL);
			checkUsernamePreparedStmt.setString(1, userVO.getUsername());

			ResultSet resultset = checkUsernamePreparedStmt.executeQuery();
			if(resultset.next()==true) {
				return "duplicateUsername";
			}
			else {
				boolean enabled = true;
				final String signupSQL = "INSERT INTO USER(USERNAME, PASSWORD, ENABLED) VALUES(?,?,?)";
				java.sql.PreparedStatement signupPreparedStmt = fetchedConnection.prepareStatement(signupSQL);

				signupPreparedStmt.setString(1, userVO.getUsername());
				signupPreparedStmt.setString(2, passwordEncoder.encryptThis(userVO.getPassword()));
				//signupPreparedStmt.setString(2, userVO.getPassword());
				signupPreparedStmt.setBoolean(3, enabled);
				
				signupPreparedStmt.executeUpdate();
				
				System.out.println(userVO.getUsername()+" - added to DB..");
				
				final String signupRoleSQL = "INSERT INTO USER_ROLE(USER_ID, ROLE) VALUES (?,?)";
				PreparedStatement signupRolePreparedStmt = fetchedConnection.prepareStatement(signupRoleSQL);
				
				final String getUserIDSQL = "SELECT USER_ID FROM USER WHERE USERNAME = ?";
				PreparedStatement getIDPreparedStmt = fetchedConnection.prepareStatement(getUserIDSQL);
				getIDPreparedStmt.setString(1, userVO.getUsername());
				ResultSet getIDresultset = getIDPreparedStmt.executeQuery();
				
				int userID=0;
				if(getIDresultset.next()) {
					userID = getIDresultset.getInt("USER_ID");
					userVO.setUserID(userID);
				}
				
				signupRolePreparedStmt.setInt(1, userID);
				signupRolePreparedStmt.setString(2, userVO.getRole());
				
				int i = signupRolePreparedStmt.executeUpdate();
				
				System.out.println("Role added for '" + userVO.getUsername()+"'");
				appLogger.info(this.getClass().getSimpleName() +": "+ i+" records inserted");  

				return "success";
			}
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
