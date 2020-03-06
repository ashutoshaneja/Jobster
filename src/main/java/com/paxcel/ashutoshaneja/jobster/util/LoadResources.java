package com.paxcel.ashutoshaneja.jobster.util;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;


/**This class loads Resources required for execution and ensures that they are authentic, else close the program from getting executed.
 * @author Ashutosh
 *
 */
@Configuration
public class LoadResources {
	
	@Bean
	public Logger getLogger() {
		
		Logger appLogger=null;	

		try {
			appLogger=Logger.getLogger("GLOBAL");

			Properties log4jProperties = new Properties();

			Resource log4jPropertyResource = new ClassPathResource("log4j.properties");
		    
		    if (null != log4jPropertyResource) {
		    	log4jProperties = PropertiesLoaderUtils.loadProperties(log4jPropertyResource);
				PropertyConfigurator.configure(log4jProperties);   
				appLogger.setLevel(Level.INFO);
				System.out.println("Logger active..");
		    }
		}
		catch (Exception exception){
			System.out.println("Resources couldn't be loaded.. Aborting Application! :(");
			System.exit(0);
		}

		return appLogger;
	}
	
	@Autowired
	ConnectionPool connectionpool;
	@Bean
	public boolean ensureInitialPoolIsCreated() throws IOException {
		
		Properties dbProperties = new Properties();

		Resource dbPropertyResource = new ClassPathResource("db.properties");

		dbProperties = PropertiesLoaderUtils.loadProperties(dbPropertyResource);
		PropertyConfigurator.configure(dbProperties);   
		
		boolean outcome=false;
		
		final String DB_DRIVER_CLASS = dbProperties.getProperty("driver.class.name");
		final String DB_URL = dbProperties.getProperty("db.url");
		final String DB_USER = dbProperties.getProperty("db.user");
		final String DB_PASSWORD = dbProperties.getProperty("db.password");
		
		try {
			outcome = connectionpool.createInitialPool(DB_DRIVER_CLASS, DB_URL, DB_USER, DB_PASSWORD);
			System.out.println("Initial Connection Pool Established..");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return outcome;
	}
}
