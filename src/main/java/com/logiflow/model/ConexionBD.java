package com.logiflow.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.InputStream;

public class ConexionBD {
    private static String url;
    private static String user;
    private static String password;
    private static String driver;

    static {
        try (InputStream input = ConexionBD.class.getClassLoader().getResourceAsStream("db.properties")) {
        	if (input == null) {
                System.out.println("❌ No se encontró el archivo db.properties");
            } else {
                System.out.println("✅ Archivo db.properties encontrado");
        	Properties prop = new Properties();
            prop.load(input);
            url = prop.getProperty("db.url");
            user = prop.getProperty("db.user");
            password = prop.getProperty("db.password");
            driver = prop.getProperty("db.driver");
            Class.forName(driver);
            System.out.println("✅ Driver JDBC cargado: " + driver);
        }} catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(url, user, password);
    }
}
