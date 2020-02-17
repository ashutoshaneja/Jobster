package com.paxcel.ashutoshaneja.jobster.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class ConnectionPool {

	private List<Connection> usedConnections = new ArrayList<>();
	private int INITIAL_POOL_SIZE = 5;
	private List<Connection> pool;

	public boolean createInitialPool(String driverClass, String url, String user, String password) throws SQLException, ClassNotFoundException {
		boolean flag=false;

		Class.forName(driverClass);
		pool = new ArrayList<>(INITIAL_POOL_SIZE);
		for (int i = 0; i < INITIAL_POOL_SIZE; i++) {
			pool.add(createConnection(url, user, password));
			flag=true;
		}
		return flag;
	}

	public synchronized Connection getConnection() {
		Connection connection = pool.remove(pool.size() - 1);
		usedConnections.add(connection);
		return connection;
	}

	public boolean releaseConnection(Connection connection) {
		usedConnections.remove(connection);
		return pool.add(connection);
	}

	Connection createConnection(String url, String user, String password)
			throws SQLException, ClassNotFoundException {
		Connection connection = DriverManager.getConnection(url, user, password);
		return connection;
	}

	public int getSize() {
		return pool.size();
	}
}
