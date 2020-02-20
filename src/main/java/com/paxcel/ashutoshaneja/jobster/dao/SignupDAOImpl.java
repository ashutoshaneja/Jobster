package com.paxcel.ashutoshaneja.jobster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;
import com.paxcel.ashutoshaneja.jobster.util.ConnectionPool;

@Repository
public class SignupDAOImpl implements SignupDAO {

	@Autowired
	Logger appLogger;

	@Autowired
	ConnectionPool connectionpool;

	@Override
	public String createNewUser(UserVO userVO) {

		Connection fetchedConnection = connectionpool.getConnection();
		appLogger.info(this.getClass().getSimpleName() +":Connection fetched from Pool, Pool Size: "+connectionpool.getSize());
		try {
			final String checkUsernameSQL = "SELECT * FROM users WHERE USERNAME = ?";
			java.sql.PreparedStatement checkUsernamePreparedStmt = fetchedConnection.prepareStatement(checkUsernameSQL);
			checkUsernamePreparedStmt.setString(1, userVO.getUsername());

			ResultSet resultset = checkUsernamePreparedStmt.executeQuery();
			if(resultset.next()==true) {
				return "duplicateUsername";
			}
			else {
				boolean enabled = true;
				final String signupSQL = "INSERT INTO users VALUES(?,?,?)";
				java.sql.PreparedStatement signupPreparedStmt = fetchedConnection.prepareStatement(signupSQL);

				signupPreparedStmt.setString(1, userVO.getUsername());
				//signupPreparedStmt.setString(2, GenerateSHAPassword.encryptThis(userVO.getPassword()));
				signupPreparedStmt.setString(2, userVO.getPassword());
				signupPreparedStmt.setBoolean(3, enabled);
				
				signupPreparedStmt.executeUpdate();
				
				System.out.println("Inserted into users" + userVO.getUsername());
				
				final String signupRoleSQL = "INSERT INTO user_roles(USERNAME, ROLE) VALUES (?,?)";
				PreparedStatement signupRolePreparedStmt = fetchedConnection.prepareStatement(signupRoleSQL);
				
				signupRolePreparedStmt.setString(1, userVO.getUsername());
				signupRolePreparedStmt.setString(2, userVO.getRole());
				
				int i = signupRolePreparedStmt.executeUpdate();
				
				System.out.println("Inserted into users" + userVO.getUsername());
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
