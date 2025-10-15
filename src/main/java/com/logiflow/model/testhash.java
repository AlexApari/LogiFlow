package com.logiflow.model;

import org.mindrot.jbcrypt.BCrypt;

public class testhash {
    public static void main(String[] args) {
    	String passwordAdmin = "admin123";
    			String hashedAdmin = BCrypt.hashpw(passwordAdmin, BCrypt.gensalt());
    					System.out.println("Hash generado: " + hashedAdmin);
        String passwordOperador = "operador123";
        String hashedOperador = BCrypt.hashpw(passwordOperador, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashedOperador);
        String passwordUser = "usuario123";
        String hashedUser = BCrypt.hashpw(passwordUser, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashedUser);
        String passwordSupervisor = "supervisor123";
        String hashedSupervisor = BCrypt.hashpw(passwordSupervisor, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashedSupervisor);
        String passwordVendedor = "vendedor123";
        String hashedVendedor = BCrypt.hashpw(passwordVendedor, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashedVendedor);
    }
}
