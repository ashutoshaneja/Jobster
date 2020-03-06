package com.paxcel.ashutoshaneja.jobster.util;

import java.util.Properties;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Component;

//@Component
public class JobsterLogger {

	static Logger appLogger = null;

	static {
		try {
			appLogger = Logger.getLogger("GLOBAL");

			Properties log4jProperties = new Properties();

			Resource log4jPropertyResource = new ClassPathResource("log4j.properties");

			log4jProperties = PropertiesLoaderUtils.loadProperties(log4jPropertyResource);
			PropertyConfigurator.configure(log4jProperties);
			appLogger.setLevel(Level.INFO);
			System.out.println("Logger active..");

		} catch (Exception exception) {
			System.out.println("Resources couldn't be loaded.. Aborting Application! :(");
			System.exit(0);
		}
	}
	
	
}
