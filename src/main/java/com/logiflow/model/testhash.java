package com.logiflow.model;

import org.mindrot.jbcrypt.BCrypt;

public class testhash {
    public static void main(String[] args) {
        String password = "operador123";
        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashed);
        String password1 = "usuario123";
        String hashed1 = BCrypt.hashpw(password1, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashed1);
        String password2 = "supervisor123";
        String hashed2 = BCrypt.hashpw(password2, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashed2);
        String password3 = "vendedor123";
        String hashed3 = BCrypt.hashpw(password3, BCrypt.gensalt());
        System.out.println("Hash generado: " + hashed3);
    }
}
