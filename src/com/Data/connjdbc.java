package com.Data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class connjdbc {

	public static Statement getDatacn() throws ClassNotFoundException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection cn = DriverManager.getConnection(
					"jdbc:mysql://localhost/inventory", "root", "root");
			Statement st = cn.createStatement();			
			return st;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
